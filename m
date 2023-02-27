Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22EF6A3A15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB0ETw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0ETv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:19:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E718113D9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:19:49 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 178D36602E18;
        Mon, 27 Feb 2023 04:19:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677471587;
        bh=neJHlzU7HoVQIEsPasqkW1HUTHpgAXMlKs8lTrotf54=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=mSbCBFeT2V5iyIj9z5lklaoIexXd+XiqkJmUAy3zGrKiBSl55nfJVaNQ9lp2chHZH
         0CJ5aKr+o7WUEW+Gn1O1C0qkEtqJOVyq0mXGCRR7IjlRxzDt8RLLMBmJwDGvU5i6RH
         Q3xf8gV8cgUnXi19RWWIDuT+jLJHc87d6E6L2YIxwh+q6mC1FDGHFOKEFy0xC3Ga4V
         6iZR4N1VSmFVLVKAZHOIWpolaOo/49yArPJVejrq5IeCPDQHchCj0eo1sSeuOQI5iO
         cVdXHcwE/27njzWEPq794fKTysNcn+RvkvDpMWJra0IIg8J0xblp9ClAD1OII6BRtI
         VsNykWm8mmVqQ==
Message-ID: <6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com>
Date:   Mon, 27 Feb 2023 07:19:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
 <ab018466-1659-d54d-4144-5e0879815de6@suse.de>
 <e9364e10-1ad8-aaaf-3d78-a29b0c1516ef@collabora.com>
In-Reply-To: <e9364e10-1ad8-aaaf-3d78-a29b0c1516ef@collabora.com>
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

On 2/17/23 16:41, Dmitry Osipenko wrote:
> On 2/17/23 16:28, Thomas Zimmermann wrote:
>> Hi,
>>
>> I looked through the series. Most of the patches should have an r-b or
>> a-b at this point. I can't say much about patch 2 and had questions
>> about others.
>>
>> Maybe you can already land patches 2, and 4 to 6? They look independent
>> from the shrinker changes. You could also attempt to land the locking
>> changes in patch 7. They need to get testing. I'll send you an a-b for
>> the patch.
> 
> Thank you, I'll apply the acked patches and then make v11 with the
> remaining patches updated.
> 
> Not sure if it will be possible to split patch 8, but I'll think on it
> for v11.
> 

Applied patches 1-2 to misc-fixes and patches 3-7 to misc-next, with the
review comments addressed.

-- 
Best regards,
Dmitry

