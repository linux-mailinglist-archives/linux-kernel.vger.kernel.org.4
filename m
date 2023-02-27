Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1936A3A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjB0E2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0E16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:27:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA5744BE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:27:57 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C73CD660210B;
        Mon, 27 Feb 2023 04:27:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677472075;
        bh=kGcDbR4j3314+FTKe5Y7VXHs4Heb3IW139yRkBeOUHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b6pZBgVLX08t2YqV5olnHu19OeCoqB/Pm9rJVvl1XsvpURdJl5pAkl/KFEncqUPLm
         WH/OI8V39hmkRzCMr7+8+53/GdvfmBHLFqudl1IKzB/Mvpc9nIYG58SE6/8BvZZEO4
         w2DKaRa/Tjpz8AGIB58dHehk2+HDKr/9Knt3u5F5sWStdDWKRtvthKm9wZqQ9kGfdL
         k65gnWGlhEaZkkd2mIjigeJZCvJuFITIWf8qmqmmtOXHXwBKMVh9azo6OIgz5ogjOA
         bv6DOQVh5MFRUu37Wiet7YY9sahysVOG2QtMnrpWSiNEQ5QoUWOd7+bOlXFx1xcq0J
         ZIWVn1cPp6VgA==
Message-ID: <4d6e096b-4f04-5e17-ff23-4842b69fdc95@collabora.com>
Date:   Mon, 27 Feb 2023 07:27:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 01/11] drm/msm/gem: Prevent blocking within shrinker
 loop
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <20230108210445.3948344-2-dmitry.osipenko@collabora.com>
 <d1c560f1-0201-7b41-bb27-d6bcb332b8d4@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <d1c560f1-0201-7b41-bb27-d6bcb332b8d4@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 15:02, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.01.23 um 22:04 schrieb Dmitry Osipenko:
>> Consider this scenario:
>>
>> 1. APP1 continuously creates lots of small GEMs
>> 2. APP2 triggers `drop_caches`
>> 3. Shrinker starts to evict APP1 GEMs, while APP1 produces new purgeable
>>     GEMs
>> 4. msm_gem_shrinker_scan() returns non-zero number of freed pages
>>     and causes shrinker to try shrink more
>> 5. msm_gem_shrinker_scan() returns non-zero number of freed pages again,
>>     goto 4
>> 6. The APP2 is blocked in `drop_caches` until APP1 stops producing
>>     purgeable GEMs
>>
>> To prevent this blocking scenario, check number of remaining pages
>> that GPU shrinker couldn't release due to a GEM locking contention
>> or shrinking rejection. If there are no remaining pages left to shrink,
>> then there is no need to free up more pages and shrinker may break out
>> from the loop.
>>
>> This problem was found during shrinker/madvise IOCTL testing of
>> virtio-gpu driver. The MSM driver is affected in the same way.
>>
>> Reviewed-by: Rob Clark <robdclark@gmail.com>
>> Fixes: b352ba54a820 ("drm/msm/gem: Convert to using drm_gem_lru")
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   drivers/gpu/drm/drm_gem.c              | 9 +++++++--
>>   drivers/gpu/drm/msm/msm_gem_shrinker.c | 8 ++++++--
>>   include/drm/drm_gem.h                  | 4 +++-
>>   3 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index 59a0bb5ebd85..c6bca5ac6e0f 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -1388,10 +1388,13 @@ EXPORT_SYMBOL(drm_gem_lru_move_tail);
>>    *
>>    * @lru: The LRU to scan
>>    * @nr_to_scan: The number of pages to try to reclaim
>> + * @remaining: The number of pages left to reclaim
>>    * @shrink: Callback to try to shrink/reclaim the object.
>>    */
>>   unsigned long
>> -drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
>> +drm_gem_lru_scan(struct drm_gem_lru *lru,
>> +         unsigned int nr_to_scan,
>> +         unsigned long *remaining,
>>            bool (*shrink)(struct drm_gem_object *obj))
>>   {
>>       struct drm_gem_lru still_in_lru;
>> @@ -1430,8 +1433,10 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>> unsigned nr_to_scan,
>>            * hit shrinker in response to trying to get backing pages
>>            * for this obj (ie. while it's lock is already held)
>>            */
>> -        if (!dma_resv_trylock(obj->resv))
>> +        if (!dma_resv_trylock(obj->resv)) {
>> +            *remaining += obj->size >> PAGE_SHIFT;
>>               goto tail;
>> +        }
>>             if (shrink(obj)) {
>>               freed += obj->size >> PAGE_SHIFT;
>> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c
>> b/drivers/gpu/drm/msm/msm_gem_shrinker.c
>> index 051bdbc093cf..b7c1242014ec 100644
>> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
>> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
>> @@ -116,12 +116,14 @@ msm_gem_shrinker_scan(struct shrinker *shrinker,
>> struct shrink_control *sc)
>>       };
>>       long nr = sc->nr_to_scan;
>>       unsigned long freed = 0;
>> +    unsigned long remaining = 0;
>>         for (unsigned i = 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++) {
>>           if (!stages[i].cond)
>>               continue;
>>           stages[i].freed =
>> -            drm_gem_lru_scan(stages[i].lru, nr, stages[i].shrink);
>> +            drm_gem_lru_scan(stages[i].lru, nr, &remaining,
> 
> This function relies in remaining being pre-initialized. That's not
> obvious and error prone. At least, pass-in something like
> &stages[i].remaining that is then initialized internally by
> drm_gem_lru_scan() to zero. And similar to freed, sum up the individual
> stages' remaining here.
> 
> TBH I somehow don't like the overall design of how all these functions
> interact with each other. But I also can't really point to the actual
> problem. So it's best to take what you have here; maybe with the change
> I proposed.
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I had to keep to the remaining being pre-initialized because moving the
initialization was hurting the rest of the code. Though, updated the MSM
patch to use &stages[i].remaining

-- 
Best regards,
Dmitry

