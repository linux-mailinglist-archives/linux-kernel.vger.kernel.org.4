Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C264673E360
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFZPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjFZPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:32:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C910CF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:32:21 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B584F66003AF;
        Mon, 26 Jun 2023 16:32:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687793540;
        bh=N7YClaLaHV0hg4+VyEKoSchWeCtkJ4wlscqEXFV5dek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sd/w15JWxmBf5nzcKCMwRZlqveqO9LaSYai72wu6i79sazACDUbd6sgfjbsx/snRF
         WgiukljFuQDQpj1QVW2Z6SUaXpFA8Eu3di/XEx9balYnGUlCW1UtT5qxvQsIDe4Srt
         pLFyv72lbqRfWbw8jung2GvD76+5fjrbuEuT+f5p9S9dMIuJ/Y1uKUT37yIE+IHGoZ
         mtuAGEmO075KObuQH0f4NxafFQkaNbPifOksy2nm2zKsiKqGUwpzJEQKh/PXp3kAxj
         DQYgT3nSvytaKY03X6yKPo9uSDTMeKVH0pKxv8wqKLTKZnpRnY0F+gZ2G+W0FsGaNU
         F/kItH2zvHAHg==
Message-ID: <76624af3-1d82-8f96-6681-76538026395e@collabora.com>
Date:   Mon, 26 Jun 2023 18:32:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v13 03/10] drm/shmem-helper: Add pages_pin_count field
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20230314022659.1816246-1-dmitry.osipenko@collabora.com>
 <20230314022659.1816246-4-dmitry.osipenko@collabora.com>
 <20230626170420.45826ac7@collabora.com>
 <20230626172148.706a2534@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230626172148.706a2534@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 18:21, Boris Brezillon wrote:
> On Mon, 26 Jun 2023 17:04:57 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
>> Hi Dmitry,
>>
>> Sorry for chiming in only now :-/.
>>
>> On Tue, 14 Mar 2023 05:26:52 +0300
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>
>>> And new pages_pin_count field to struct drm_gem_shmem_object that will
>>> determine whether pages are evictable by memory shrinker. The pages will
>>> be evictable only when pages_pin_count=0. This patch prepares code for
>>> addition of the memory shrinker that will utilize the new field.
>>>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 7 +++++++
>>>  include/drm/drm_gem_shmem_helper.h     | 9 +++++++++
>>>  2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> index 4da9c9c39b9a..81d61791f874 100644
>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> @@ -277,6 +277,8 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>>>  	drm_WARN_ON(obj->dev, obj->import_attach);
>>>  
>>>  	ret = drm_gem_shmem_get_pages(shmem);
>>> +	if (!ret)
>>> +		shmem->pages_pin_count++;
>>>  
>>>  	return ret;
>>>  }
>>> @@ -289,7 +291,12 @@ static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
>>>  
>>>  	drm_WARN_ON(obj->dev, obj->import_attach);
>>>  
>>> +	if (drm_WARN_ON_ONCE(obj->dev, !shmem->pages_pin_count))
>>> +		return;
>>> +
>>>  	drm_gem_shmem_put_pages(shmem);
>>> +
>>> +	shmem->pages_pin_count--;
>>>  }
>>>  
>>>  /**
>>> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
>>> index 20ddcd799df9..7d823c9fc480 100644
>>> --- a/include/drm/drm_gem_shmem_helper.h
>>> +++ b/include/drm/drm_gem_shmem_helper.h
>>> @@ -39,6 +39,15 @@ struct drm_gem_shmem_object {
>>>  	 */
>>>  	unsigned int pages_use_count;
>>>  
>>> +	/**
>>> +	 * @pages_pin_count:
>>> +	 *
>>> +	 * Reference count on the pinned pages table.
>>> +	 * The pages allowed to be evicted by memory shrinker
>>> +	 * only when the count is zero.
>>> +	 */
>>> +	unsigned int pages_pin_count;  
>>
>> s/pages_pin_count/pin_count/ ?
>>
>> And do we really need both pages_pin_count and pages_use_count. Looks
>> like they both serve the same purpose, with one exception:
>> pages_use_count is also incremented in the get_pages_sgt_locked() path,
>> but you probably don't want it to prevent GEM eviction. Assuming
>> your goal with this pin_count field is to check if a GEM object is
>> evictable, it can be done with something like
>>
>> bool
>> drm_gem_shmem_is_evictable_locked(struct drm_gem_shmem_object *shmem)
>> {
>> 	dma_resv_assert_held(shmem->base.resv);
>>
>> 	return shmem->pages_use_count == (shmem->sgt ? 1 : 0);
>> }
>>
>> I mean, I'm not against renaming pages_use_count into pin_count, but,
>> unless I'm missing something, I don't see a good reason to keep both.
> 
> My bad, I think I found one place calling drm_gem_shmem_get_pages()
> where we want pin_count and pages_use_count to differ:
> drm_gem_shmem_mmap(). We certainly don't want userspace mappings to
> prevent eviction.

That's correct, thanks for the review :)

-- 
Best regards,
Dmitry

