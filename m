Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D336F3307
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjEAPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjEAPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:38:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723A101
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:38:50 -0700 (PDT)
Received: from [192.168.2.246] (109-252-144-198.dynamic.spd-mgts.ru [109.252.144.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D16B866029DE;
        Mon,  1 May 2023 16:38:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682955528;
        bh=60ntYlxBLAqZcU4b/vq2szObt+W0BUAHvfMdgUwVFEU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=jU7MFV/sNLCmvNNHS86pcVVv7Cxcs8xDyVU4wP29g9SJTpaSK42CT43hC/+mDZIJ/
         0pCaHUqQ42/bbprEbIDlSY3aiOuT9hjBKaMRnpPZxWUBXPiEUmRtn7pBopUG5EO/oL
         thsh8/UAvF5BLz3DsDtsCHUyoPFzRtB4Ol8WVs3FT4bAHfwPkhxZHHh586eghtFvUC
         IY0YexpTXT8eM8mCtyvpJ3qjt2+wmmXrWCGR0rsorq8Q12bP+ehab/46A3M8AIc6dh
         sKetCYbm4I0cbpxzOpyt7qy43oroTlO3KhcMkIVBrVsYtNprQSCholHZa7e2O0W6nW
         87swqG6GZ4KWg==
Message-ID: <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
Date:   Mon, 1 May 2023 18:38:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23 14:52, Dmitry Osipenko wrote:
> We have multiple Vulkan context types that are awaiting for the addition
> of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
> 
>  1. Venus context
>  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
> 
> Mesa core supports DRM sync object UAPI, providing Vulkan drivers with a
> generic fencing implementation that we want to utilize.
> 
> This patch adds initial sync objects support. It creates fundament for a
> further fencing improvements. Later on we will want to extend the VirtIO-GPU
> fencing API with passing fence IDs to host for waiting, it will be a new
> additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU context
> drivers in works that require VirtIO-GPU to support sync objects UAPI.
> 
> The patch is heavily inspired by the sync object UAPI implementation of the
> MSM driver.

Gerd, do you have any objections to merging this series?

We have AMDGPU [1] and Intel [2] native context WIP drivers depending on
the sync object support. It is the only part missing from kernel today
that is wanted by the native context drivers. Otherwise, there are few
other things in Qemu and virglrenderer left to sort out.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
[2] https://gitlab.freedesktop.org/digetx/mesa/-/commits/native-context-iris

-- 
Best regards,
Dmitry

