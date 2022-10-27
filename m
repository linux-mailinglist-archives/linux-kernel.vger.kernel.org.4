Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613D4610191
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiJ0T0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiJ0T0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:26:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06717820D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2DRp4MUOZX5RGg4JRQn7kAqNv3EFG3+0HRKGszsAM6A=; b=MjIU7IqdjNxtf0plLgLwdGp0Gl
        vHItaAHoZT8KIS1wqV8EKMv03v4I1fCvbLu6lcV6dXhWN4KjLcVBwpMtgQuaCXIJHaaKf0PhsTr5Y
        g11VJRiXRxP/CN450j6mzn2mgn9zdiDUcN8OU2FCA/SezJEgYf0xH/bA/BJjH+x49Vld9CCIDR1rp
        jgra6aOUVnaMioaHpsJwxw6OP49qBPXGGXDpKMlLr61sVTsXPRK14yLKofZRhGB1JFQh8H01OmbqK
        523EuP4b+0zzk57JyLfiXcuh6G2qa9eGVDAPFOlwYJ6iGD0rV/2NOIj+ehD27O+H9CsUrbBWQG/H4
        dG4qroeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oo8WR-006wHJ-Tn; Thu, 27 Oct 2022 19:26:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3106230017F;
        Thu, 27 Oct 2022 21:26:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B20721204F6F; Thu, 27 Oct 2022 21:26:35 +0200 (CEST)
Date:   Thu, 27 Oct 2022 21:26:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH] x86/uaccess: instrument copy_from_user_nmi()
Message-ID: <Y1rbanstUTfq3tb4@hirez.programming.kicks-ass.net>
References: <20221025221755.3810809-1-glider@google.com>
 <Y1j+Tt9mnMDU0zO+@hirez.programming.kicks-ass.net>
 <CAG_fn=XDeghFBGXT37Mc-ky-8NaPaMmCLdo3Par=xh92Fk_CAQ@mail.gmail.com>
 <Y1o72704bVK0FgCr@hirez.programming.kicks-ass.net>
 <CAG_fn=XESk1PPqbAVDqMdGbRwyvLvLQrm2hybr2cXaaYjfZEKA@mail.gmail.com>
 <202210271155.33956B1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210271155.33956B1@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:58:35AM -0700, Kees Cook wrote:

> I wandered around attempting to deal with in_nmi(), etc. And in
> the end just drop the attempt to cover it. It's worth noting that
> copy_from_user_nmi() exists on 1 architecture and has exactly 1
> call-site...

Yeah, back when I wrote it, it was a lot more complicated because we
could not reliably take #PF from NMI context; it did manual page-walks,
kmap_atomic()s and mempcy(). That's all fixed now and it's really mostly
a rudiment -- except for these instrumentation issues it seems.
