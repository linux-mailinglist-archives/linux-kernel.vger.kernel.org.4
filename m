Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F46365F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiKWQkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiKWQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:40:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57702BA5A3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:40:18 -0800 (PST)
Received: from [192.168.2.109] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 009BB6600367;
        Wed, 23 Nov 2022 16:40:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669221616;
        bh=9jAcNG5mmc8WdRcm1FU/6k9HjRgP8OF/p9T3eXcNN5g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y4/HSy/fWd8Zgc3i5mYx/xGvm7+frMwkYiTm2sHW37EP882UGsVPbqeHZ8blbQQY9
         sPiKyi5LJsSKrVbRvyu2iq4EfFsI//PPQNI6WQ2XEGiru4Uh1mHFdOStdEvNns0qai
         V0rXdL0fBs3gGPdPbKqZSOFiLxl+H2iJxnZAbuyEuEF+FzUg685TWWUqR99/v0SKKW
         +MRB89IfKmwxp0XcVLLiWD70lF10fZdq0GLMXchbnEgvtqFXWGYbSuTRZ0cbU+qu2u
         OgSjhAYlVVgO9/+EPZno8IcvUkRSALHakD89Cb0buTjFS9kP7TCDrBUC109IUvMgqB
         Fmw5sowFqxNKA==
Message-ID: <2d63940e-1cc2-a03e-a253-dac4d697e7d1@collabora.com>
Date:   Wed, 23 Nov 2022 19:40:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v9 03/11] drm/gem: Add evict() callback to
 drm_gem_object_funcs
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20221123025723.695075-1-dmitry.osipenko@collabora.com>
 <20221123025723.695075-4-dmitry.osipenko@collabora.com>
 <f390d9ec-e8b2-a10d-bd2e-011ec879c615@arm.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <f390d9ec-e8b2-a10d-bd2e-011ec879c615@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 18:58, Steven Price wrote:
> On 23/11/2022 02:57, Dmitry Osipenko wrote:
>> Add new common evict() callback to drm_gem_object_funcs and corresponding
>> drm_gem_object_evict() helper. This is a first step on a way to providing
>> common GEM-shrinker API for DRM drivers.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_gem.c | 15 +++++++++++++++
>>  include/drm/drm_gem.h     | 12 ++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index 299bca1390aa..c0510b8080d2 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -1458,3 +1458,18 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>>  	return freed;
>>  }
>>  EXPORT_SYMBOL(drm_gem_lru_scan);
>> +
>> +/**
>> + * drm_gem_object_evict - helper to evict backing pages for a GEM object
>> + * @obj: obj in question
>> + */
>> +bool
>> +drm_gem_object_evict(struct drm_gem_object *obj)
>> +{
>> +	dma_resv_assert_held(obj->resv);
>> +
>> +	if (obj->funcs->evict)
>> +		return obj->funcs->evict(obj);
>> +
>> +	return false;
>> +}
> 
> This function needs exporting for the module build to work correctly.

Indeed, I missed that drm-shmem can be built as a separate module.

-- 
Best regards,
Dmitry

