Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A996232DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKISsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKISsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:48:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B20C74
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:48:18 -0800 (PST)
Received: from [192.168.2.122] (unknown [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1AF8466029C3;
        Wed,  9 Nov 2022 18:48:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668019696;
        bh=HqPD8JhaCO33vjM9HvhqQQe5npl+/oagnjrYCxOv+Gk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V4kTlhmprYtAsRaQqn2mut/x7XOwso0ST7pEO3IVukE80DAxz97xRbcIqaw32lfYm
         pKsxTgNMEqWa1/MmE73at60ZgBfPXBQxDF5ewdIYjByS7M/kjyEol+8DhvTPDnv9J+
         c19NbtnDMpLmJTeRHsiUD1mf2t4QbHaIg8DbDyQzzaWGWRAlHMkrwIxDbAY8UvzUmF
         QQXmfS73Qa7PqtfJxaKgMw3U1d39EseOGrMDjfgf+Ne2QPket1mX5qNlVgW7gBZDGq
         TqzmJxRHibw/HQLZFtdhemvBfZQHZNRF9mNe17lydZ5sK6QdDC5PKzKBxUxbclVWMq
         I0tk0zLRSkqog==
Message-ID: <f2d96471-5c72-1529-2e82-382260335aad@collabora.com>
Date:   Wed, 9 Nov 2022 21:48:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v8 4/7] drm/shmem-helper: Add memory shrinker
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
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
References: <20221105232719.302619-1-dmitry.osipenko@collabora.com>
 <20221105232719.302619-5-dmitry.osipenko@collabora.com>
 <077ad468-335e-c3cd-2f18-557d3ecc3bf4@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <077ad468-335e-c3cd-2f18-557d3ecc3bf4@suse.de>
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

Hello Thomas,

On 11/9/22 13:28, Thomas Zimmermann wrote:
>> +int drm_gem_shmem_set_evictable(struct drm_gem_shmem_object *shmem)
>> +{
>> +    dma_resv_lock(shmem->base.resv, NULL);
>> +
>> +    if (shmem->madv < 0) {
>> +        dma_resv_unlock(shmem->base.resv);
>> +        return -ENOMEM;
> 
> ENOMEM is not right here. It's for failed memory allocation. ENODEV
> seems more appropriate.

Had the same thought about ENOMEM and at one point was considering
ENOENT, but in the end decided it's not much better than ENOMEM.

> But why do we need an error here anyway? Why not just fail transparently?

I added the error handling everywhere for consistency. Perhaps indeed
will be better to fail transparently for now since nobody cares about
such errors and likely won't in the future.

The rest of the comments are also good to me, will start preparing the
v9. Thank you for the review!

-- 
Best regards,
Dmitry

