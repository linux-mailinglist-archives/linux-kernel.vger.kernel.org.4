Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8667E6A3FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjB0LCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0LBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:01:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C04F196B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:01:14 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8239066021EB;
        Mon, 27 Feb 2023 11:00:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677495671;
        bh=Uh8//OK+3hdNaqjSqu/2C6uxnKClaRwrTVDY9fef0ho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hctghTghqru1ufBwHyKfPoGQ6MxZQUBi+4x2k85yWbUCCSVHsiU43UFihpoYvVJe9
         VHAEXnBGIeYnKasmvdJS846U3ZcAR9awuPJoLraH386O1zezaFU3kEbMOo7SswOT/M
         NYefK92/y8Geb4qWB/UTr2DF3IiO2djjCz4LXnHO2Yc6ysQqbhNS15RCgwtnxH5M3z
         4k3/yfW8h0Y0ElY1aYfF2BRSACbuoP61ZS6Cod/EnpFHbTGA3NxV2ygPIls4SjthyU
         /1IgmSNSnyfGWJaRRz/HF1G5m/0fEm+wZcTKDhv+BkY/7zve4y0prElm08Ygtl5Rua
         2zNsHMup0OwqA==
Message-ID: <95cf8f0e-0ec1-5071-834e-9eb97a0da233@collabora.com>
Date:   Mon, 27 Feb 2023 14:00:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
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
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <ab018466-1659-d54d-4144-5e0879815de6@suse.de>
 <e9364e10-1ad8-aaaf-3d78-a29b0c1516ef@collabora.com>
 <6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com>
 <87a60z2y2t.fsf@intel.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87a60z2y2t.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 13:37, Jani Nikula wrote:
> On Mon, 27 Feb 2023, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>> On 2/17/23 16:41, Dmitry Osipenko wrote:
>>> On 2/17/23 16:28, Thomas Zimmermann wrote:
>>>> Hi,
>>>>
>>>> I looked through the series. Most of the patches should have an r-b or
>>>> a-b at this point. I can't say much about patch 2 and had questions
>>>> about others.
>>>>
>>>> Maybe you can already land patches 2, and 4 to 6? They look independent
>>>> from the shrinker changes. You could also attempt to land the locking
>>>> changes in patch 7. They need to get testing. I'll send you an a-b for
>>>> the patch.
>>>
>>> Thank you, I'll apply the acked patches and then make v11 with the
>>> remaining patches updated.
>>>
>>> Not sure if it will be possible to split patch 8, but I'll think on it
>>> for v11.
>>>
>>
>> Applied patches 1-2 to misc-fixes and patches 3-7 to misc-next, with the
>> review comments addressed.
> 
> Please resolve the drm-tip rebuild conflict [1].
> 
> BR,
> Jani.
> 
> 
> [1] https://paste.debian.net/1272275/

Don't see that conflict locally, perhaps somebody already fixed it?

-- 
Best regards,
Dmitry

