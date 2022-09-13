Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7A5B7774
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiIMRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiIMRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:11:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B60A75CF9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6183FB80FBC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D93C433C1;
        Tue, 13 Sep 2022 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663082278;
        bh=UFuyDwznO8ZwtLcStnaZ9JsjmgrVUXjXM/FFOXRJBaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C188hfqeWizeKtA5CVnQ2eNvWzPCg9IkKG9N294NZzM5ScgNCZ+MJDnhGLLthPZSP
         TJnsh6FIEiAbpfkIZtoMaE94TfEszHZ3vn9twzQjImtTa+SanqkU5QWpUcEeLl+JRZ
         rCkb5Cu147gCnQCH9T3Rm0FeZJoXJRer60fODjXyyU/KdcMXeizWXOVxhz+3CNp0gn
         ROu8r8RFNGTgEaclFhF9N+MLE0pgHiAD5V0gz1ExjB8AlX4YlxCEcYQbYvD8zikrVn
         ddpsHOd4P+VfrkFyVokDCGNvJgzKKk+1RYZJBASqSYvrVv4hHm6qgiOU/yra92Y1zU
         FSjLBX1CRp1uQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: add MADV_COLLAPSE support in damos_action
Date:   Tue, 13 Sep 2022 15:17:55 +0000
Message-Id: <20220913151755.103334-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913114735.22841-1-xhao@linux.alibaba.com>
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

Hi Xin,

On Tue, 13 Sep 2022 19:47:35 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> MADV_COLLAPSE has large different with MDVA_HUGE in dealing with huge
> pages, it doesn't need to rely on 'khugepage' thread to create THP.
> So combining with it will give damon users more options.

I think this is a simple and worthy change, but... could you put some more
detailed explanation of the scenario that the action could be used?  Also, it
would be good to have some evaluation results you got with this change.

Also, to my understanding, MADV_COLLAPSE is not merged in the mainline yet,
right?  I believe it will make it in v6.1-rc1.  That said, to make Andrew's
burden less, how about delaying this change until MADV_COLLAPSE is mainlined?
If you have some numbers showing clear and great benefit of this change, I
think it would be worthy to add immediately, though.


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 1 +
>  mm/damon/vaddr.c      | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 016b6c9c03d6..c44f9410d997 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -97,6 +97,7 @@ enum damos_action {
>  	DAMOS_PAGEOUT,
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
> +	DAMOS_COLLAPSE,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index c2c08c1b316b..58c0d068563d 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -655,6 +655,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_COLLAPSE:
> +		madv_action = MADV_COLLAPSE;
> +		break;
>  	case DAMOS_STAT:
>  		return 0;
>  	default:
> -- 
> 2.31.0
