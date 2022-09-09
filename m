Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C535B40FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIIUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiIIUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01595D9E98
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B738620F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 20:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59667C433D7;
        Fri,  9 Sep 2022 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662756322;
        bh=COEliIIy25ePOvJQJHAFqqBR9qrfLM0+NcxidTG+SrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nu53F953N7ueZWqIwLeEsHqmDp0kaB5Onw9ICZf3GIPyOwCgui1AC71/3r1qzSFuZ
         raejeQFmyAbMSr1601btrE1KL3JcdzVK7BYWTZpRptMLgQhG6nUMPMHFjvR99oXlml
         pwmVHxDxhajXbmUAa6nCpCGRxRVJNSpvbjVyj0DBiSAtx++spGfzDLMehPcwYWRwXL
         onLokCvpWSHRCYCChlsdZmBXUrZM06dsIkQO3hz+DLycsgMHInnigVg7NlAGd3a+ck
         +mrdDbaJa4t6D7Ox7l6z9cXu31fozWVlxL0x+ELPj83T5v5k/CHI3P+08qESCAjd8e
         eyN+Jw9iYbLzw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] mm/damon: Remove duplicate get_monitoring_region() definitions
Date:   Fri,  9 Sep 2022 20:45:20 +0000
Message-Id: <20220909204520.60047-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909024105.84831-1-xhao@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 10:41:05 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In lru_sort.c and reclaim.c, they are all defining get_monitoring_region()
> function, there is no need to define it separately.
> 
> As 'get_monitoring_region()' is not a 'static' function anymore, we try
> to use a prefix to distinguish with other functions, so there rename it
> to 'damon_find_biggest_system_ram'.
> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 11 +++++++++++
>  mm/damon/core.c       | 29 +++++++++++++++++++++++++++++
>  mm/damon/lru_sort.c   | 37 ++-----------------------------------
>  mm/damon/reclaim.c    | 37 ++-----------------------------------
>  4 files changed, 44 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 7b1f4a488230..6c863b281fb2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -448,6 +448,16 @@ struct damon_ctx {
>  	struct list_head schemes;
>  };
>  
> +/**
> + * struct damon_system_ram_region - System RAM resource address region of [@start, @end).

I prefer 80 columns, let's break down this line.
https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings

Also this struct is gonna be used by only damon_find_biggest_system_ram(), so I
think it might make more sense to move this into core.c.

And, as this is not aimed to directly be used by external API users, I think it
would make more sense to hide from kernel doc (/* instead of /**).

> + * @start:	Start address of the  (inclusive).

of the 'region'?

> + * @end:	End address of the region (exclusive).

I like the nice explanation: whether its inclusive or exclusive.

> + */
> +struct damon_system_ram_region {
> +	unsigned long start;
> +	unsigned long end;
> +};
> +

As this struct is only used by damon_find_biggest_system_ram(), I think it
might make more sense to move this into core.c?

Below parts all look good.

Also, this patch seems cannot cleanly applied on top of the latest
mm/mm-unstable branch.  Would need rebase.


Thanks,
SJ

[...]
