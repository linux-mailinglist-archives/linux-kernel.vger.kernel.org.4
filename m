Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E623E70BFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjEVN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjEVN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:28:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277CC6;
        Mon, 22 May 2023 06:28:04 -0700 (PDT)
Received: from [192.168.2.171] (109-252-147-95.dynamic.spd-mgts.ru [109.252.147.95])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B93C6606D84;
        Mon, 22 May 2023 14:27:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684762079;
        bh=keD/935Zu/vg8AvzQ/mBIJs8+l9o00PBHzFnRJHLzSg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DIyoGQY28KPe9vMso5QxUo+B+LjI47cH/U4JwbRsIiakuaiBSF/Y7imIYc/jDeXp8
         +wc9lthaCS+AlUh+d5looWfz4hmwb0n/H5azQr5MVPfR8jaUD0R1SXwnufnJTrVL69
         lIBXFbCYtxb4/OQ0m3YJveSKWwZ9TPETWj8txE4eYmPaSpI8XCkV+N8L/IHlhJPafV
         59NZeqgqi1BB3nFLZVrnu28Pi4a+LFs8cpygwYjTK3JjRmaL/WujfMnZlzN7hVte1B
         71W3VJWvV4T+e7VJJgD7pcZyh2Ry2S0QAlJtUkubAkrX9ypCaFK2g6cfDyKmqSBVwG
         YSaELA4697lcw==
Message-ID: <abc2a8ab-0969-fbb6-8dec-b15c81df38e4@collabora.com>
Date:   Mon, 22 May 2023 16:27:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 6/6] drm/shmem-helper: Switch to reservation lock
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com
References: <20230521205112.150206-1-dmitry.osipenko@collabora.com>
 <20230521205112.150206-7-dmitry.osipenko@collabora.com>
 <CACvgo52QvmZw5k_9dmBHPB25rTdLZJzVG_vNFr8or+3f5sVO=Q@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CACvgo52QvmZw5k_9dmBHPB25rTdLZJzVG_vNFr8or+3f5sVO=Q@mail.gmail.com>
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

On 5/22/23 16:02, Emil Velikov wrote:
> Hi Dmitry,
> 
> Saw v3 fly by, so I had a quick look. Original RB still stands,
> although I noticed a couple of non-blocking nitpicks.
> 
> On Sun, 21 May 2023 at 22:00, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> 
>> -static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>>  {
> 
> Should this getter have a dma_resv_assert_held(shmem->base.resv); like
> it's put brethren?
> 
> 
>> -void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
>> +static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>> +{
>> +       int ret;
>> +
>> +       dma_resv_assert_held(shmem->base.resv);
>> +
>> +       ret = drm_gem_shmem_get_pages(shmem);
>> +
>> +       return ret;
> 
> With the assert_held in the getter, it would be less confusing to
> inline this and the unpin_locked functions.
> 
>> +}
>> +
>> +static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
>>  {
>> -       mutex_lock(&shmem->pages_lock);
>> -       drm_gem_shmem_put_pages_locked(shmem);
>> -       mutex_unlock(&shmem->pages_lock);
>> +       dma_resv_assert_held(shmem->base.resv);
>> +
>> +       drm_gem_shmem_put_pages(shmem);
> 
> Side note: the putter has an assert_held so the extra one here seems quite odd.
> 
> As said at the top - with or w/o these nitpicks, the original RB still stands.

Good catch. I actually added assert_held to get_pages(), but in a later
patch that is not part of this series.

-- 
Best regards,
Dmitry

