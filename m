Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EC640ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiLBUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLBT77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:59:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6BDBF77
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17D14B8227D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88235C433C1;
        Fri,  2 Dec 2022 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670011195;
        bh=TX0AQoDfjQ4ZbnVcTd0C+6HAmwMewsTbT3BnxuxMcCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XFBleSmod6qXnyGd6Aj1/6zXkp3J+l41YJOFvtwsh2/dGobsQwYdqAFno/AR0QQfZ
         z4QIsbuNwHWGFH0ehg+EY6xxvi0XRrt1arjLXPtnF3Wa+h1YY/DM3VhLITdEY8YVik
         1uzHOpGSb1IfZp84aWej9hC2a9KGayNm+2xBoh8M=
Date:   Fri, 2 Dec 2022 11:59:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     tzm <tcm1030@163.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm/mempolicy: failed to disable numa balancing
Message-Id: <20221202115954.a226f8ef3051266d04caff54@linux-foundation.org>
In-Reply-To: <20221202141630.41220-1-tcm1030@163.com>
References: <20221202141630.41220-1-tcm1030@163.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Dec 2022 22:16:30 +0800 tzm <tcm1030@163.com> wrote:

> It will be failed to  disable numa balancing policy permanently by passing
> <numa_balancing=disable> to boot cmdline parameters.
> The numabalancing_override variable is int and 1 for enable -1 for disable.
> So, !enumabalancing_override will always be true, which cause this bug.

That's really old code!

> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2865,7 +2865,7 @@ static void __init check_numabalancing_enable(void)
>  	if (numabalancing_override)
>  		set_numabalancing_state(numabalancing_override == 1);
>  
> -	if (num_online_nodes() > 1 && !numabalancing_override) {
> +	if (num_online_nodes() > 1 && (numabalancing_override == 1)) {
>  		pr_info("%s automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl\n",
>  			numabalancing_default ? "Enabling" : "Disabling");
>  		set_numabalancing_state(numabalancing_default);

Looks right to me.  Mel?

After eight years, I wonder if we actually need this.
