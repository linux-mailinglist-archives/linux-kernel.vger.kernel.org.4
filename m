Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269A16E8394
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDSVYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDSVYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6F170E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:23:36 -0700 (PDT)
Received: from [192.168.2.24] (109-252-147-202.dynamic.spd-mgts.ru [109.252.147.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 717DE6603225;
        Wed, 19 Apr 2023 22:22:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681939347;
        bh=sv9nD2x5q3zJup15lguqfkxx5gcjmsq7ljOlnWhsOTQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k8kC1SbYzV8Hbf89jJh30k9eGyNgCLgHs+Vxp3DnxelszjtIiXHaEnS76pCMvZCai
         3GdQq9yUmOYSNipMHpsUQLvBmjSSS3X8+g9Qosi73a4zYOArvOqFimrS41AclcZwyD
         uOR8q+Zj/6i3Hz1VxnDB0v8pHNXqseMfi2YYpSF7dvI43F+Qw6Ok0Hff6x39yBfm71
         xj/otdDWOMEfZ3x8XLKfEctOsKceOVkB5BK69hvmwohAcVFwRQaRzJjZfso9QDGq4u
         lA71FX6h0qFKW/U5yHWEDS0xtfU1bDtkipdBXEvt28TcKqoW3H/D7H5o9yzCNQY87U
         qLRxftFyptMiw==
Message-ID: <6fef7bd4-6d02-6de8-e5f0-0ec8f57321f2@collabora.com>
Date:   Thu, 20 Apr 2023 00:22:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To:     Gurchetan Singh <gurchetansingh@google.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        Dominik Behr <dbehr@google.com>
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <CAAfnVB=5TVKxUmLhNMLMdgAPx7KoSKTsZQtq7Hv36FcP7bmgLA@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAAfnVB=5TVKxUmLhNMLMdgAPx7KoSKTsZQtq7Hv36FcP7bmgLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gurchetan,

On 4/18/23 02:17, Gurchetan Singh wrote:
> On Sun, Apr 16, 2023 at 4:53 AM Dmitry Osipenko <
> dmitry.osipenko@collabora.com> wrote:
> 
>> We have multiple Vulkan context types that are awaiting for the addition
>> of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
>>
>>  1. Venus context
>>  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
>>
>> Mesa core supports DRM sync object UAPI, providing Vulkan drivers with a
>> generic fencing implementation that we want to utilize.
>>
>> This patch adds initial sync objects support. It creates fundament for a
>> further fencing improvements. Later on we will want to extend the
>> VirtIO-GPU
>> fencing API with passing fence IDs to host for waiting, it will be a new
>> additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU
>> context
>> drivers in works that require VirtIO-GPU to support sync objects UAPI.
>>
>> The patch is heavily inspired by the sync object UAPI implementation of the
>> MSM driver.
>>
> 
> The changes seem good, but I would recommend getting a full end-to-end
> solution (i.e, you've proxied the host fence with these changes and shared
> with the host compositor) working first.  You'll never know what you'll
> find after completing this exercise.  Or is that the plan already?
> 
> Typically, you want to land the uAPI and virtio spec changes last.
> Mesa/gfxstream/virglrenderer/crosvm all have the ability to test out
> unstable uAPIs ...

The proxied host fence isn't directly related to sync objects, though I
prepared code such that it could be extended with a proxied fence later
on, based on a prototype that was made some time ago.

The proxied host fence shouldn't require UAPI changes, but only
virtio-gpu proto extension. Normally, all in-fences belong to a job's
context, and thus, waits are skipped by the guest kernel. Hence, fence
proxying is a separate feature from sync objects, it can be added
without sync objects.

Sync objects primarily wanted by native context drivers because Mesa
relies on the sync object UAPI presence. It's one of direct blockers for
Intel and AMDGPU drivers, both of which has been using this sync object
UAPI for a few months and now wanting it to land upstream.

-- 
Best regards,
Dmitry

