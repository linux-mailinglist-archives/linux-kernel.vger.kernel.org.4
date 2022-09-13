Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778D65B77A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiIMRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiIMRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:18:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E1861EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE402B80F10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE19C433C1;
        Tue, 13 Sep 2022 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081876;
        bh=C2SleSiuBkOWC306gvMd63ndpm5F32RdHPWF/1NZ+Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6EvO1tbHXy5BnLWx+aINqFnlkt2g4z3xcHVU2o/GN+MBsp/HbSX3LY2E/6UIeodI
         9XBVm2KxKb49tlqgxUTC//o0tZQ2uovfGUcC02jNZoRESrLW9q7O1mWsVTy+2aT67x
         f8BwGM15zXQAkeoO26xkITIkD7CxSpcJw/K0Ukg/EN2H8yIfPjlcZ5mzs9/xj861Zp
         PcK8a60fm9yHTfIAbT4PfeV3xY1ERsqdoCsfoMxvUjOAaya5yX3mAyn0V+5vWy94n9
         89XxK0MedRYIjfq59D0ICSFrBlIQUUv/XQeOPhwh0zfqr6p38TXNgwiyDqwVUC46UY
         P9JAbfa66K85g==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH 4/4] mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is zero
Date:   Tue, 13 Sep 2022 15:11:14 +0000
Message-Id: <20220913151114.103184-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663060287-30201-5-git-send-email-kaixuxia@tencent.com>
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

On Tue, 13 Sep 2022 17:11:27 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> When 'init()' and 'update()' DAMON operations failed and the number
> of the damon_target regions is zero,

Well, I think that could be a temporal failure.  In the case, later call of
'update()' could success?


Thanks,
SJ

> the kdamond would do nothing
> to this monitoring target in this case. It makes no sense to run
> kdamond when all of monitoring targets have no regions. So add the
> judgement in 'target_valid()' operation to indicate the target is
> invalid when 'nr_regions' is zero.

> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  mm/damon/vaddr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 39ea48d9cc15..65ff98d49ec0 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -598,6 +598,9 @@ static bool damon_va_target_valid(void *target)
>  	struct damon_target *t = target;
>  	struct task_struct *task;
>  
> +	if (!damon_nr_regions(t))
> +		return false;
> +
>  	task = damon_get_task_struct(t);
>  	if (task) {
>  		put_task_struct(task);
> -- 
> 2.27.0
