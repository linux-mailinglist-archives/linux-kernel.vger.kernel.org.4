Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF45F79E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJGOpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJGOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:45:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE840003
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBD4CB82393
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1A4C433C1;
        Fri,  7 Oct 2022 14:44:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CatVYEYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665153894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocwaJwuQX+7YyoGctk5bUWUgzcE5LKjsZ2hNKouDWvs=;
        b=CatVYEYsKrSeZXECJHYwy0+jY2EV9Um8F9W89ZTca3D7r8JV9GfVV+d/3tdElWFPVqSCnG
        pqLgVNtgMxODjlrx2vCl1Bd/fcK1e1d4CX79x/GWcDuKBnxK+RiTBd+GqnYKCS3ExKbexJ
        uiX6mKszFdr6PNLGVZJnI66+Ftl3G54=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8a357f4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Oct 2022 14:44:54 +0000 (UTC)
Date:   Fri, 7 Oct 2022 08:44:52 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Jann Horn <jannh@google.com>,
        Natalie Silvanovich <natashenka@google.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: x86/mm: Randomize per-cpu entry area
Message-ID: <Y0A7ZAjtDcq2PJaX@zx2c4.com>
References: <Yz/mfJ1gjgshF19t@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz/mfJ1gjgshF19t@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:42:36AM +0200, Peter Zijlstra wrote:
> +	max_cea = (CPU_ENTRY_AREA_MAP_SIZE - PAGE_SIZE) / CPU_ENTRY_AREA_SIZE;
> +
> +	/* O(sodding terrible) */
> +	for_each_possible_cpu(i) {
> +		unsigned int cea;
> +
> +again:
> +		cea = prandom_u32_max(max_cea);

Just FYI, max_cea is 2274876 (at least in my test rig), which means the
values returned from prandom_u32_max() won't be uniformly distributed.
Right now the kernel doesn't have a function that does rejection
sampling to get uniform distribution, but I could add one if you need.
Alternatively, maybe you don't actually *need* this to be perfectly
distributed -- which seems to be a common perspective -- and so this is
good enough. Your call, but just wanted to make you aware.

Jason
