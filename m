Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B536AF259
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjCGSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCGSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:52:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5DABB26
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:40:39 -0800 (PST)
Received: from [192.168.2.57] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FF316602081;
        Tue,  7 Mar 2023 18:40:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678214435;
        bh=kzZgEsXwj2D2bZ03kYGGGhV7+F4z+DUuitiRMuVlXeU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=JlISTHDejcbW8NV11WI1CuuJHLAVvg86nvzAHQUnlx9smrgfeepdwDLIw0neniFTj
         emP0FJY2JL2TzcVvPfCzr8ZFaO8OKtdRunCfJqGnzvjcVtlpJOFpp8cuheQ3OXbzs6
         V9N9BGpBN92sIZ5uNWI4YJ4/DiI7W4V2oIfJiVv4IMxBJ0nz/99Y24G/9+vtGd//4h
         oHtYSSKuxJeE9dlu7sBJepgBb2EYDmj094VB+dW7MFHpyPsVV8TsXvI120JVWipihx
         SyeAWoZl+XKIvkfD1SZPrtLr9ERswBo4rWgvIPsyPPghPQ5vX8vjAvTRTxDOmrIXNu
         7MxWNPThh9UeQ==
Message-ID: <a49fb815-1f02-e8c1-fd8e-128f3b43e490@collabora.com>
Date:   Tue, 7 Mar 2023 21:40:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v12 10/11] drm/virtio: Support memory shrinking
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
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     intel-gfx@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20230305221011.1404672-1-dmitry.osipenko@collabora.com>
 <20230305221011.1404672-11-dmitry.osipenko@collabora.com>
 <3afbc965-4117-7d45-9a8f-b726c04d1b0c@suse.de>
 <66ddf54c-8396-2eb4-49ae-da479a997219@collabora.com>
In-Reply-To: <66ddf54c-8396-2eb4-49ae-da479a997219@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 21:25, Dmitry Osipenko wrote:
>> Not really a problem with this patchset, but having such branches looks
>> like a bug in the driver's GEM design. Whatever your GEM object needs or
>> does, it should be hidden in the implementation. Why is virtio doing this?
> There is another "VRAM" VirtIO-GPU BO type that doesn't implement the
> pin/unpin callbacks. Perhaps another option was to add the callbacks.

Although, the pin/unpin are optional. So yes, there was no need for the
extra branch, good catch.

-- 
Best regards,
Dmitry

