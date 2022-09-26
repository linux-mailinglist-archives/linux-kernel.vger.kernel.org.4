Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953F55EA814
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiIZOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiIZOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:11:48 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D95B5EDC6;
        Mon, 26 Sep 2022 05:23:00 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C4E331E80D6C;
        Mon, 26 Sep 2022 19:15:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HM1C-YBnYyoV; Mon, 26 Sep 2022 19:15:16 +0800 (CST)
Received: from [172.30.38.124] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D82A01E80D3D;
        Mon, 26 Sep 2022 19:15:15 +0800 (CST)
Subject: Re: [PATCH] drm/msm/gem: Use size_add() against integer overflow
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yu Zhe <yuzhe@nfschina.com>
References: <20220926092315.17193-1-liqiong@nfschina.com>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <80db9ee7-481e-9793-87a6-83a9be6836ec@nfschina.com>
Date:   Mon, 26 Sep 2022 19:19:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20220926092315.17193-1-liqiong@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022年09月26日 17:23, Li Qiong 写道:
> "struct_size() + n" may cause a integer overflow,
> use size_add() to handle it.
>
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index c9e4aeb14f4a..3dec87e46e50 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -30,8 +30,8 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
>  	uint64_t sz;
>  	int ret;
>  
> -	sz = struct_size(submit, bos, nr_bos) +
> -			((u64)nr_cmds * sizeof(submit->cmd[0]));
> +	sz = size_add(struct_size(submit, bos, nr_bos),
> +			((u64)nr_cmds * sizeof(submit->cmd[0])));
>  
>  	if (sz > SIZE_MAX)
>  		return ERR_PTR(-ENOMEM);

Sorry,  This patch a mistake, drop it ,  please.



