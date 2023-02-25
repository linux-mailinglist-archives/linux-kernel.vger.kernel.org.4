Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE47F6A2A74
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBYPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYPVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:21:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B6E39F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:21:38 -0800 (PST)
Received: from [192.168.2.94] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6475E6602FB0;
        Sat, 25 Feb 2023 15:21:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677338496;
        bh=7jBenHKBdFCc4MyDCi41WuTdy4hTEhAYm+jhGxudmJM=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=GIawh0H3XWWIFT1T4YktDsV4RCnMIZ2c2ntQa5vrgxqCIKinucESZIhWVJn9EeYfS
         OjP2krt53cvyTah2DhNpwRpf2hyZrTxhMC3rd57wtO1qufwbj3I3n9B4Efjbm8on09
         WKRgVj1KECaJvYfoLXwTh9YfZF7k3Cr3WMRL0DnHk6yOJCtYRi+Eb4w2jtX4jDJmDM
         gQ+vrECHzKPL6QNpR72bUv9CB/wsTyDdw1D3/+nLEW/rcZZjpj1BDf+oDeKlavQE6G
         rnuOJ4JmGbavUYQOM+g7ssUAYmOD0j/bUqECxJXFSFvXqALqrj5jY/kqH6kVMZzG5o
         ZhT8T0N5GVKEQ==
Message-ID: <c45a0c45-ed87-636f-aa68-3d7ff81b83b6@collabora.com>
Date:   Sat, 25 Feb 2023 18:21:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] drm/virtio: Support sync objects
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230119004143.968942-1-dmitry.osipenko@collabora.com>
 <20230119004143.968942-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20230119004143.968942-2-dmitry.osipenko@collabora.com>
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

On 1/19/23 03:41, Dmitry Osipenko wrote:
> +		ret = drm_syncobj_find_fence(file, syncobj_desc.handle,
> +					     syncobj_desc.point, 0, &in_fence);
> +		if (ret)
> +			break;
> +
> +		if (!dma_fence_match_context(in_fence, fence_ctx + ring_idx))
> +			ret = dma_fence_wait(in_fence, true);

I missed to add dma_fence_chain_contained(in_fence) here, otherwise the
match always fails for a chained fence.

-- 
Best regards,
Dmitry

