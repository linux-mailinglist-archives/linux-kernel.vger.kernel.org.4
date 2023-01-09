Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1266353E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbjAIX2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbjAIX2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:28:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E620101D9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:28:49 -0800 (PST)
Received: from [192.168.2.154] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BEE746602D68;
        Mon,  9 Jan 2023 23:28:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673306928;
        bh=bw1hYe8Xc6/o43q1d4oFrzR72ui9P2UWVKyDLL+iuMM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NzWsjApffRkLRnZprpeIs5QfddIl4P1biqIapM5DhZgQJkuE2qGgflKHWsp0yBcn1
         1kywVhNkjT9t4PXlW9fw9pTLNGzYT1QUhlBB+Tl7PXCdgL4uXjmLCus8IhZgcRQnrA
         te34I4JVLVinz9NQyc0gGpduCXQn9C7m5jpdVBqBjT3PbyniWl7UvPfce+F9SSeEIA
         ueyjjIguXgOmtWiq/FQdiU1RTKS8bzPiYEiLWldCpjF6ClbI8L2XqwiTl9QasmzZeH
         1vll2NrOznZg/KRupuB7y7r+ElLaPLnlVUJkQzF80vlGNcFwCVknbedF/qj7SnhI70
         s5NP5ZOPSpHlQ==
Message-ID: <3ae74f28-580b-3b53-3d7b-e8bde97dabe3@collabora.com>
Date:   Tue, 10 Jan 2023 02:28:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/virtio: Fix GEM handle creation UAF
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20221216233355.542197-1-robdclark@gmail.com>
 <20221216233355.542197-2-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221216233355.542197-2-robdclark@gmail.com>
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

On 12/17/22 02:33, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Userspace can guess the handle value and try to race GEM object creation
> with handle close, resulting in a use-after-free if we dereference the
> object after dropping the handle's reference.  For that reason, dropping
> the handle's reference must be done *after* we are done dereferencing
> the object.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Added fixes/stable tags and applied this virtio-gpu patch to misc-fixes.
The Panfrost patch is untouched.

-- 
Best regards,
Dmitry

