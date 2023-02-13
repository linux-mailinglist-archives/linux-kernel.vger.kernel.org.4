Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D5694FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBMSxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBMSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:53:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A7166F5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:53:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38CB4B818D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 18:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81FBC433D2;
        Mon, 13 Feb 2023 18:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676314398;
        bh=xcGaRIwbb5nq215+b4sWh8e7QlbCOHLwlg1rA/vLzh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kKv7xvfhCcg6uANkHNPtgENlkk9RrI75JUYFMfTDK3KJxMpWCW1zwCojsst9DIxrY
         tudn4xDfG/kFVOjli1g/5SyMkiU6AEyluHzrZ/hFAGDHkBszfcIOkYrbmQ9Bd1crsT
         2m3Uq0w+As0ANxhZCUiubgnVbHJZLXRo5ldB38Yw=
Date:   Mon, 13 Feb 2023 10:53:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: call panic() when memoryless node
 allocation fails
Message-Id: <20230213105318.e2a83d60c12e734d45dccf1a@linux-foundation.org>
In-Reply-To: <20230212111027.95520-1-zhengqi.arch@bytedance.com>
References: <20230212111027.95520-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2023 19:10:27 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> In free_area_init(), we will continue to run after pgdat of memoryless
> node allocation fails. However, in the subsequent process (such as when
> initializing zonelist), the case that NODE_DATA(nid) is NULL is not
> handled, which will cause panic. Instead of this, it's better to call
> panic() directly when the memory allocation fails during system boot.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8360,11 +8360,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  
>  			/* Allocator not initialized yet */
>  			pgdat = arch_alloc_nodedata(nid);
> -			if (!pgdat) {
> -				pr_err("Cannot allocate %zuB for node %d.\n",
> -						sizeof(*pgdat), nid);
> -				continue;
> -			}
> +			if (!pgdat)
> +				panic("Cannot allocate %zuB for node %d.\n",
> +				       sizeof(*pgdat), nid);
>  			arch_refresh_nodedata(nid, pgdat);
>  			free_area_init_memoryless_node(nid);

Have you actually hit this at runtime?  If so, is there something we
can do to handle this failure more gracefully?

