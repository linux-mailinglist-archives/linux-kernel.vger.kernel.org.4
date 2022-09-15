Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699D5B9C46
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIONqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiIONp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED897515
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C50A62205
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE49C433C1;
        Thu, 15 Sep 2022 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663249553;
        bh=zvTn9BWL/FcNXRvKgOxjhue2aM2e2uoqaWld7P/b3RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRA6W5Q0sRPZn6UzpoUEdY4q9113j7YXLElel6nUDhpaUq/jxErH35CXDRAqju9Ki
         CuCAtJriOhsk5GYS+BFDk66R0Arv27ZzPVDLwrUft2bG68sCq3AqGmAyTKPIqDEQYk
         KJpz4x2T4BRnD9X2qKF6FVj9I+SuOOmeEJAqcdiuHjx9y1FQ7UrSiz/i0K1fcKlLsk
         57p/li2bFIvxT1j1bib6LwoG0M6pr6CyYZONohl14Iuya80R5ZaNvOxtTbXAXB8dg6
         bwQnAMgDibpnu0zhuKgu0fcV/FoZkTmOkS8e4JNBBgAwgFK3cmuNaBUbj0H8YWpEBK
         /T4hRTMn5+ibg==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon: use 'struct damon_target *' instead of 'void *' in target_valid()
Date:   Thu, 15 Sep 2022 13:45:51 +0000
Message-Id: <20220915134551.99224-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663241621-13293-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaixu,


On Thu, 15 Sep 2022 19:33:41 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We could use 'struct damon_target *' directly instead of 'void *' in
> target_valid() operation to make code simple.

Nice finding.

> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/damon.h | 2 +-
>  mm/damon/vaddr.c      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index c5dc0c77c772..1dda8d0068e5 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -346,7 +346,7 @@ struct damon_operations {
>  	unsigned long (*apply_scheme)(struct damon_ctx *context,
>  			struct damon_target *t, struct damon_region *r,
>  			struct damos *scheme);
> -	bool (*target_valid)(void *target);
> +	bool (*target_valid)(struct damon_target *t);
>  	void (*cleanup)(struct damon_ctx *context);
>  };
>  
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3f84584f9982..f53c2ff2bcc8 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -593,9 +593,8 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>   * Functions for the target validity check and cleanup
>   */
>  
> -static bool damon_va_target_valid(void *target)
> +static bool damon_va_target_valid(struct damon_target *t)
>  {
> -	struct damon_target *t = target;
>  	struct task_struct *task;
>  
>  	task = damon_get_task_struct(t);
> -- 
> 2.27.0
> 
