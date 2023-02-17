Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C399C69ACA7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBQNlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBQNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:41:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CE68E50
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:41:35 -0800 (PST)
Received: from [192.168.2.109] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54CAB6601F13;
        Fri, 17 Feb 2023 13:41:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676641294;
        bh=QEsanptIUs+DNGjJkoo74QmfA4sYNiYpQ+Z8nBl9cOE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H0IL9tyyLG2AmVtJRlEEDgHQPlSoK4swz3W4uwDWTIi6WegxJb80lxqjgi4uy0TiF
         vQXUXXx4xbgindGq++pO0QA0H8HUUinweAQie7GhpJgM1pqR9wozeYUVpcwNh7LIZg
         rIFs8S72UWL/ATqbi6v1UZ3gxVBWYQIfOU5ByF/zf+pCrCDTKY5YnquvnF7UGzhTOR
         s9Xi3ceH+CQJj2bBgI/aNLwvC752sR4lP6MMct3nIORdZco30bzqeUb56NaU6fCofn
         CmCJQKiYj8T5qK4NJAFuIsJLMaoX02ZGPJePu+59RiJXlPBOBMLGkF+u6k6bRSROqu
         D0gM/8SgCKXbA==
Message-ID: <e9364e10-1ad8-aaaf-3d78-a29b0c1516ef@collabora.com>
Date:   Fri, 17 Feb 2023 16:41:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
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
 <ab018466-1659-d54d-4144-5e0879815de6@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ab018466-1659-d54d-4144-5e0879815de6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 16:28, Thomas Zimmermann wrote:
> Hi,
> 
> I looked through the series. Most of the patches should have an r-b or
> a-b at this point. I can't say much about patch 2 and had questions
> about others.
> 
> Maybe you can already land patches 2, and 4 to 6? They look independent
> from the shrinker changes. You could also attempt to land the locking
> changes in patch 7. They need to get testing. I'll send you an a-b for
> the patch.

Thank you, I'll apply the acked patches and then make v11 with the
remaining patches updated.

Not sure if it will be possible to split patch 8, but I'll think on it
for v11.

-- 
Best regards,
Dmitry

