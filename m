Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2A67C03D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbjAYWzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjAYWzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:55:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6B458AE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:55:15 -0800 (PST)
Received: from [192.168.2.197] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AC3C6602D1F;
        Wed, 25 Jan 2023 22:55:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674687314;
        bh=3KgCvkiMWuw1advwxtDNvcxv2KngByLwOXF9vKgP06k=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=YnJHI30zZohHLfInL1M102KVG7aDB4zyDl9JeidmzFJOnpyPGCEZJzzrXJWGV0q6X
         QLzt+lGGzDOJjkzm4OQd7du3QeyODeIlGPizmQHDmlTZ+ug6QSr3p9reYn4uRfJMar
         EwXw+P4krJQo+OZ2KArfEIZTDqdFqRbWeXjGYChH5nK4uXD+nT1/pagQsnb8JbIB/J
         PfX0UtNWY3sgFerI4nxqSXwlYOxcMyi6riIpo1k0ieeBQZMsfb999bzPKDVYrzsja9
         ic8x/sl66WetMSLWjZyH7vob1UEP2hjtNpaNHWsBuf0o5kcpei/eW3DK3XkQ3bnYPb
         FIzYr3XntbicA==
Message-ID: <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
Date:   Thu, 26 Jan 2023 01:55:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        David Airlie <airlied@gmail.com>,
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
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas and Gerd,

On 1/9/23 00:04, Dmitry Osipenko wrote:
> This series:
> 
>   1. Makes minor fixes for drm_gem_lru and Panfrost
>   2. Brings refactoring for older code
>   3. Adds common drm-shmem memory shrinker
>   4. Enables shrinker for VirtIO-GPU driver
>   5. Switches Panfrost driver to the common shrinker
> 
> Changelog:
> 
> v10:- Rebased on a recent linux-next.
> 
>     - Added Rob's ack to MSM "Prevent blocking within shrinker loop" patch.
> 
>     - Added Steven's ack/r-b/t-b for the Panfrost patches.
> 
>     - Fixed missing export of the new drm_gem_object_evict() function.
> 
>     - Added fixes tags to the first two patches that are making minor fixes,
>       for consistency.

Do you have comments on this version? Otherwise ack will be appreciated.
Thanks in advance!

-- 
Best regards,
Dmitry

