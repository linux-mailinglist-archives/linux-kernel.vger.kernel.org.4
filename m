Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41FE6CD33B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjC2H3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjC2H3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:29:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D703AAB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tyigenNRL14flZba6FvHZXgEG9vHkKSt7KxbjM+DuTs=; b=oqQY51vI4/3eZ0wAtGSwp5PRTb
        FaZJL1ktgh3QUOFihyHXC1lLxciVFBG8UThHJV66xh7fdom+B3vt3wNxJtZsHSVda5tDlIEr/YTdd
        yDOaAbb3AZDwADL2i3j6Yd8SWAmIKEgcYj87i7RmjcMHHPUT6tXSG3jDKGqtinom/BKwMNP19Dkry
        aLEYGpTSCrVlBtjSzwAxPZhHyY3IjSYDyCkHlSSnB0IpVh7ONLpHbw88jniIMM1rEQc4VYS3l34uo
        JbuR0xKgOZZaUXG23mVMXnXERrS8oF9VnxRP/FFxPUv8Nj/bcgeZLux7+nY87PKmGdHWsWOIqMLh5
        pAEcJ2+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phQCs-006muq-0s;
        Wed, 29 Mar 2023 07:26:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1CBC3000E6;
        Wed, 29 Mar 2023 09:26:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCCC52CC6DE9A; Wed, 29 Mar 2023 09:26:53 +0200 (CEST)
Date:   Wed, 29 Mar 2023 09:26:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] objtool: Add per-function rate limiting for
 unreachable warnings
Message-ID: <20230329072653.GI4253@hirez.programming.kicks-ass.net>
References: <cover.1679932620.git.jpoimboe@kernel.org>
 <b21f7791b30c54cf8c4d0f489decdc4a47a18963.1679932620.git.jpoimboe@kernel.org>
 <20230328081105.GD4253@hirez.programming.kicks-ass.net>
 <20230328202205.cfd7hvpj74rv7ry4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328202205.cfd7hvpj74rv7ry4@treble>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:22:05PM -0700, Josh Poimboeuf wrote:
> On Tue, Mar 28, 2023 at 10:11:05AM +0200, Peter Zijlstra wrote:
> > On Mon, Mar 27, 2023 at 09:00:47AM -0700, Josh Poimboeuf wrote:
> > > Unreachable instruction warnings are rate limited to once per object
> > > file.  That no longer makes sense for vmlinux validation, which might
> > > have other unreachable instructions lurking in other places.  Change it
> > > to once per function.
> > 
> > Do we want a negative option to disable this? --no-ratelimit or such?
> 
> Per-function rate-limiting is almost always the right thing, personally
> I don't envision needing to disable it.

Ok, fair enough. I'll let you know if I ever come across the need to
disable it :-)
