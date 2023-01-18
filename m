Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45B670EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjARAe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjARAeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:34:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4124A32501;
        Tue, 17 Jan 2023 16:02:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9677C6159C;
        Wed, 18 Jan 2023 00:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CB0C433D2;
        Wed, 18 Jan 2023 00:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674000124;
        bh=+lNxWhx5IPzrUSKqX5AsyvWP5h8GsglZS3sbBpAWc9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vizeQW6uZgAKr5zx7b7VDmdxeAhzgGq5J9R4n2qYttkb44D+fqK+gGYMuhJap9ycT
         74ZfFdjCiwMBUdJIIn4zcQkR7ki8E3y3LHjsS1Er6f/qiGOvci47/I6fzT4wGAmVCR
         WPQkAA32+zLA3zQufzGpJjUGPx0eWLLMbLz6mi7Q=
Date:   Tue, 17 Jan 2023 16:02:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     James Morse <james.morse@arm.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyich@gmail.com>,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        =?ISO-8859-1?Q?=C9meric?= Maschino <emeric.maschino@gmail.com>
Subject: Re: [PATCH] ia64: Fix build error due to switch case label
 appearing next to declaration
Message-Id: <20230117160203.a1a22c612cdffeeb79b8d397@linux-foundation.org>
In-Reply-To: <20230117151632.393836-1-james.morse@arm.com>
References: <20230117151632.393836-1-james.morse@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 15:16:32 +0000 James Morse <james.morse@arm.com> wrote:

> Since commit aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to
> report ITC frequency"), gcc 10.1.0 fails to build ia64 with the gnomic:
> | ../arch/ia64/kernel/sys_ia64.c: In function 'ia64_clock_getres':
> | ../arch/ia64/kernel/sys_ia64.c:189:3: error: a label can only be part of a statement and a declaration is not a statement
> |   189 |   s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> 
> ...
>
> @@ -185,8 +188,8 @@ ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *
>  	switch (which_clock) {
>  	case CLOCK_REALTIME:
>  	case CLOCK_MONOTONIC:
> -		s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> -		struct timespec64 rtn_tp = ns_to_timespec64(tick_ns);
> +		tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> +		rtn_tp = ns_to_timespec64(tick_ns);
>  		return put_timespec64(&rtn_tp, tp);
>  	}
>  

Huh, how did that sneak through.  We usually use an extra set of braces
for this.

Thanks, I'll add cc:stable to this.
