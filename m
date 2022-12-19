Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D55650A63
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiLSKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiLSKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:52:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE8EE23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4k1EzSe5WHf6OaPOnP3b3SI0nUjUbDa1iSkjxlHiSvQ=; b=qAB6aIJfLYKrrJOaHS5lzFGLUn
        VEyfj0EEc0pKnI8zKB0mEAOKJP14NlAUMrDzJUQkmOyBTq1WTl9aiq/niSoa8cVK4hPY9MsVt65vn
        gMQu2Z4d5l9e4nXYOz3THtu7efIpxJMIU6leJMZoQDdoaWNNWv3Nnsn/T0jMHpoSi6Kd3BVjGGxVM
        8Jzc/QW6Kdg+tmdmtwPmHspTFL5kLmSIjZnCaTMkC6DRKGndS3KLku4QSVY5NVlctlIqPUnb5qWHz
        566slOpD6n9IaGtQeLKpqobDmT8wxzyGxMi937Zc3zmhr4CjDvDI7hePeBPjimpnjGM4lhfnZBCr5
        BvfNU70w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7DkZ-00CYCz-37;
        Mon, 19 Dec 2022 10:52:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE543300348;
        Mon, 19 Dec 2022 11:52:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2BCA202FE504; Mon, 19 Dec 2022 11:52:03 +0100 (CET)
Date:   Mon, 19 Dec 2022 11:52:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] objtool: reduce memory usage of struct reloc
Message-ID: <Y6BCU+vGYV7GVl4c@hirez.programming.kicks-ass.net>
References: <20221216-objtool-memory-v1-0-6f2dd3ed7312@weissschuh.net>
 <20221216-objtool-memory-v1-4-6f2dd3ed7312@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216-objtool-memory-v1-4-6f2dd3ed7312@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 09:30:07PM +0000, Thomas Weißschuh wrote:
> Use a smaller type for the relocation type and move it to a location in
> the structure where it avoids wasted padding bytes.
> 
> Technically ELF could use up to four bytes for the type.
> But until now only types up to number 43 have been defined.
> 
> Reduce the size of struct reloc on x86_64 from 120 to 112 bytes.
> This structure is allocated a lot and never freed.

Please put in a assertion for this -- I can see this going sideways fast
if we ever get this wrong.

static inline void reloc_set_type(struct reloc *reloc, int type)
{
	if (type > (1U << (8*sizeof(reloc->type))))
		WARN_ELF("reloc->type out of range");

	reloc->type = type;
}

