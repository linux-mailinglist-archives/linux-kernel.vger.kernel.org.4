Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8702167CAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjAZMYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbjAZMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:24:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A76D343
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:24:36 -0800 (PST)
Received: from [192.168.2.197] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC0626602E6E;
        Thu, 26 Jan 2023 12:24:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674735874;
        bh=vcL/t3khQ9UtoF+bJWODdAsRg8AvYVc6c48gFUnC2yo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DuYwMnk3kOEkj1W+FCWlYGj6DBN5pCQtsO4gypbXtuU067eSVXBRnVXjiqPlCS2aC
         G3crMGFDmBcdLdXt3cDOvyh0S8XNpN23Z/nBtPCrEC8f3DguxaxuulyQQIFqV1n11e
         Up3kuIfNwSWvSygWLH/JBkwP+JFbODv5T8fjf9oFBc2cOHwqsUW8fDCl6zOP4hXY3m
         1oByoZw4CqfygTdjlkRbv8Y6HAYHMcttRQTn2vcZdfYjLlqYBElSK5C0wD6/vZ/JKy
         baQL1XZNYUKRsCdTVR2hOC87AptcwNInoVpNTHPyEzwk8LSG72AXVItyrBSqZH/I7n
         6CSuTAPe9FrnQ==
Message-ID: <75698ab8-2e0b-8673-2f7d-83ffa37f447b@collabora.com>
Date:   Thu, 26 Jan 2023 15:24:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 06/11] drm/shmem-helper: Don't use vmap_use_count for
 dma-bufs
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@gmail.com>,
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
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <20230108210445.3948344-7-dmitry.osipenko@collabora.com>
 <20230126121705.wsm62yxco7cubwyf@sirius.home.kraxel.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230126121705.wsm62yxco7cubwyf@sirius.home.kraxel.org>
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

On 1/26/23 15:17, Gerd Hoffmann wrote:
> On Mon, Jan 09, 2023 at 12:04:40AM +0300, Dmitry Osipenko wrote:
>>  its own refcounting of vmaps, use it instead of drm-shmem
>> counting. This change prepares drm-shmem for addition of memory shrinker
>> support where drm-shmem will use a single dma-buf reservation lock for
>> all operations performed over dma-bufs.
> 
> Likewise truncated?

Should be the email problem on yours side, please see [1][2] where the
messages are okay.

[1]
https://lore.kernel.org/dri-devel/20230108210445.3948344-7-dmitry.osipenko@collabora.com/
[2] https://patchwork.freedesktop.org/patch/517401/

-- 
Best regards,
Dmitry

