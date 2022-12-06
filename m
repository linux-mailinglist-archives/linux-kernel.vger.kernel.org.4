Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09516643A59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLFAjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiLFAjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:39:22 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0169D1EEE2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vrd7FfueKholXe98mvN6q0jU34zWpJgC+kcpoxaw4+4=; b=rH59W3VEdRciD0aYsAMpA9ER86
        H3a2VLMFj6PeVvB9+jdkN6XxQDH10pGzSLhtVRnAmPlnA0aPTGyVpJXHrsFEoo6PpcDOU3BaCOlmS
        edQoUSbLXCGnFc3reFsmm0KyfDJpp6kIzd/Gs+Tg38U+dtgpF6ODApfCRauDJSSRqM+8vsMDcMlRd
        bGZhLoXLk3/87zPwf1ACoURW8V+3K+Dwj4jlIP/0pWsaddwPdR1W5X0r6D/ehvmldAM5IzZ+uxI+t
        78maBxch5FCmBD+5hEhNmkLhFErUb3FY9w4gCUxG7ytigtQ2w2j8U39lXMRqBqnVks+MKwm1MIHLT
        zP/N23iA==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p2Lxl-00FpTH-Bm; Tue, 06 Dec 2022 01:37:33 +0100
Message-ID: <44140361-33c3-ff97-b28f-64c26bf87d5c@igalia.com>
Date:   Mon, 5 Dec 2022 21:37:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] drm/v3d: cleanup BOs properly when lookup_bos
 fails
To:     Melissa Wen <mwen@igalia.com>, emma@anholt.net, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-dev@igalia.com
References: <20221205135538.3545051-1-mwen@igalia.com>
 <20221205135538.3545051-2-mwen@igalia.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221205135538.3545051-2-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 10:55, Melissa Wen wrote:
> When v3d_lookup_bos fails to `allocate validated BO pointers`,
> job->bo_count was already set to args->bo_count, but job->bo points to
> NULL. In this scenario, we must verify that job->bo is not NULL before
> iterating on it to proper clean up a job. Also, drm_gem_object_put
> already checks that the object passed is not NULL, doing the job->bo[i]
> checker redundant.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 96af1cb5202a..31a37572c11d 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -363,11 +363,11 @@ v3d_job_free(struct kref *ref)
>  	struct v3d_job *job = container_of(ref, struct v3d_job, refcount);
>  	int i;
>  
> -	for (i = 0; i < job->bo_count; i++) {
> -		if (job->bo[i])
> +	if (job->bo) {
> +		for (i = 0; i < job->bo_count; i++)
>  			drm_gem_object_put(job->bo[i]);
> +		kvfree(job->bo);
>  	}
> -	kvfree(job->bo);
>  
>  	dma_fence_put(job->irq_fence);
>  	dma_fence_put(job->done_fence);
