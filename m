Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C126B6836F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjAaT7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAaT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:59:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C3B56894
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i1Eurtt8Qar/4Q95uYaxqcQbrnPikWcsxDTtR/y7JGE=; b=mSF7cdlSw8I9Ba6diYNF07lyKQ
        g211CYVKSZkf315NHCE4T8eao0pYCN9jiwGmMl1P0ygYa2h1ZiNAYnCYf82V2w2Iy9yOibjS5eQnn
        KbpDAmVpC9QajdEHt9A61NCmjtOx0Nfx6aHJY3a06NLr2Im4CXyLmtODHv9yZGOQPgtlZjIJ30Nfs
        jnosIzTw/2rAnMVzR1Wk3+EZYXUtRi3v4scB26ncE1j9aXFseA603ezUM5xSEUTEPtUqz1r1kWCmg
        hG4Y+TXPe+ZPgP9V3rthH2+Si7lPrE8nMbWXYfj38uRZOqTZjQqq+5kF+dxHRDDDP18U7CKKCkDYr
        sTqS1tsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMwm0-004S40-2x;
        Tue, 31 Jan 2023 19:58:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEB55300577;
        Tue, 31 Jan 2023 20:59:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0AA420D6DE1C; Tue, 31 Jan 2023 20:59:05 +0100 (CET)
Date:   Tue, 31 Jan 2023 20:59:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Message-ID: <Y9lzCaC2k/Un64O3@hirez.programming.kicks-ass.net>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <87357q228f.ffs@tglx>
 <Y9lfe54aoCWlmyqy@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9lfe54aoCWlmyqy@p183>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:35:39PM +0300, Alexey Dobriyan wrote:

> > Seriously this procfs accuracy is the least of the problems and if this
> > would be the only issue then we could trivially fix it by declaring that
> > the procfs output might go backwards.
> 
> Declarations on l-k are meaningless.

Not really, we often do the -EWONTFIX thing.

> > If there would be a real reason to ensure monotonicity there then we could
> > easily do that in the readout code.
> 
> People expect it to be monotonic. I wrote this test fully expecting
> that /proc/uptime is monotonic. It didn't ever occured to me that
> idletime can go backwards (nor uptime, but uptime is not buggy).

People want ponies too -- people will just have to cope with not having
ponies.
