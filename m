Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995B86A3A29
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjB0Ee6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Ee4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:34:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7FB15554
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:34:54 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9008660217D;
        Mon, 27 Feb 2023 04:34:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677472493;
        bh=Q+RRLIC4HI40FUSzS41A43b5og4HGlLpqG8USccRVGk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YoRu+YEKHI5r3oclywm0nao1CdRIfIXGx1QyJairfK58hFa9P0GJ+MM83ZefIawwx
         PwXUM063ItFAVuaTq0Y9VdF+beKRimcNhEWBOm4Qqrd+11GcGyO9jrSO5xIdv9sIIK
         jB5Hg3k4Ti0+yTCsv4Ha64yr3K4Gak7vOxFnOecQ5KB8z0an5syiCL0MEc9xnF3Kkg
         Mbw49X5mShtKFNA1y8ZngHczwQGUmkETv4PXJctQh2/O2oTh2e8i4TYtLLysP7NeUy
         R66M1BU2+W7BuXMiCLT6mh8SrEMsM9rvUzSpZ3reiSMARzKBvdcqfUOgdV3Yd1JYIH
         gj6Cd5L09uOrg==
Message-ID: <fa4b3f87-66d2-bf01-e825-a6e9ced15aca@collabora.com>
Date:   Mon, 27 Feb 2023 07:34:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 08/11] drm/shmem-helper: Add memory shrinker
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
 <20230108210445.3948344-9-dmitry.osipenko@collabora.com>
 <e486d8db-0be0-31d1-afd2-d6aa13917302@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <e486d8db-0be0-31d1-afd2-d6aa13917302@suse.de>
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

On 2/17/23 16:19, Thomas Zimmermann wrote:
>> +/**
>> + * drm_gem_shmem_swap_in() - Moves shmem GEM back to memory and enables
>> + *                           hardware access to the memory.
> 
> Do we have a better name than _swap_in()? I suggest
> drm_gem_shmem_unevict(), which suggest that it's the inverse to _evict().

The canonical naming scheme used by TTM and other DRM drivers is
_swapin(), without the underscore. I'll use that variant in v11 for the
naming consistency with the rest of DRM code.

-- 
Best regards,
Dmitry

