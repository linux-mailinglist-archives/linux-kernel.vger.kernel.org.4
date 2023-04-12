Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7716DF6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjDLNPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDLNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:15:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6983FA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:14:51 -0700 (PDT)
Received: from [192.168.2.164] (109-252-119-170.nat.spd-mgts.ru [109.252.119.170])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 660346603102;
        Wed, 12 Apr 2023 14:13:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305211;
        bh=NcDjKYoHcWPHgnRj4XVd7yZ8i1I7wYvmpusFDpMNx78=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DJkE6eOEGhm59OB/OBnisWQpWpW2tSDweg9Xk/6FBR8D2xqjGLvX01N5Azcz/ozgk
         BrWqi/RQcLbPJS/MfZmHZDqngiEK7dIssKAPXY8qJH+jC2liA0TE9ht0X4H73CmonB
         h1JJuDZdhUAUj890KESltF2u3pSHuqWOCTm+DkcFJlSUHLl7yj6mzig9btx/sRQCDx
         D0l33EYMW32M9bG9YGyOMeAMB42q7obuVUgYy2crc9Q24RJTKzF7Kn2adX7k6b0yzk
         6exuU9fWp1pLfYQsmd/1jXng6XAQEpl4leOgNPwmyEhNIN2aT22IGThW4VG8xV17pX
         VEhSndWJ8QelA==
Message-ID: <8963a3ee-532f-eb2a-f417-ce62c8d18bd2@collabora.com>
Date:   Wed, 12 Apr 2023 16:13:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 3/3] drm/virtio: Support sync objects
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20230409123957.29553-1-dmitry.osipenko@collabora.com>
 <20230409123957.29553-4-dmitry.osipenko@collabora.com>
 <CACvgo51719VsgNqiTO-RnZxXruRvtuMgJ1v5oaq4x5Lrniuaaw@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CACvgo51719VsgNqiTO-RnZxXruRvtuMgJ1v5oaq4x5Lrniuaaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 4/11/23 14:07, Emil Velikov wrote:
> Hi Dmitry,
> 
> On Sun, 9 Apr 2023 at 13:40, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> 
>> +static void virtio_gpu_free_syncobjs(struct drm_syncobj **syncobjs,
>> +                                    uint32_t nr_syncobjs)
>> +{
>> +       uint32_t i = nr_syncobjs;
>> +
>> +       while (i--) {
>> +               if (syncobjs[i])
>> +                       drm_syncobj_put(syncobjs[i]);
>> +       }
>> +
>> +       kvfree(syncobjs);
>> +}
>> +
> 
>> +static void virtio_gpu_reset_syncobjs(struct drm_syncobj **syncobjs,
>> +                                     uint32_t nr_syncobjs)
>> +{
>> +       uint32_t i;
>> +
>> +       for (i = 0; i < nr_syncobjs; i++) {
>> +               if (syncobjs[i])
>> +                       drm_syncobj_replace_fence(syncobjs[i], NULL);
>> +       }
>> +}
>> +
> 
> Can I bribe you (with cookies) about dropping the NULL checks above?
> They're dead code and rather misleading IMHO.

When userspace doesn't set the VIRTGPU_EXECBUF_SYNCOBJ_RESET flag in
virtio_gpu_parse_deps(), the syncobjs[i] is NULL. Hence not a dead code
at all :)

>> +static void
>> +virtio_gpu_free_post_deps(struct virtio_gpu_submit_post_dep *post_deps,
>> +                         uint32_t nr_syncobjs)
>> +{
>> +       uint32_t i = nr_syncobjs;
>> +
>> +       while (i--) {
>> +               kfree(post_deps[i].chain);
>> +               drm_syncobj_put(post_deps[i].syncobj);
>> +       }
>> +
>> +       kvfree(post_deps);
>> +}
>> +
>> +static int virtio_gpu_parse_post_deps(struct virtio_gpu_submit *submit)
>> +{
>> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
>> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
>> +       struct virtio_gpu_submit_post_dep *post_deps;
>> +       u32 num_out_syncobjs = exbuf->num_out_syncobjs;
>> +       size_t syncobj_stride = exbuf->syncobj_stride;
>> +       int ret = 0, i;
>> +
>> +       if (!num_out_syncobjs)
>> +               return 0;
>> +
>> +       post_deps = kvcalloc(num_out_syncobjs, sizeof(*post_deps), GFP_KERNEL);
>> +       if (!post_deps)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < num_out_syncobjs; i++) {
>> +               uint64_t address = exbuf->out_syncobjs + i * syncobj_stride;
>> +
> 
> For my own education: what's the specifics/requirements behind the
> stride? is there a use-case for the stride to vary across in/out
> syncobj?

Stride is the same for in/out syncobjs as the same struct
drm_virtgpu_execbuffer_syncobj is used by both.

The out-syncobj don't use the "flags" field of
drm_virtgpu_execbuffer_syncobj. We could use separate strides and desc
for in/out syncobjs, but in practice it's unlikely that we will be
extending the desc anytime soon and usually there are not many
out-syncobj to care about the wasted field.

On the other hand, if we will ever need to extend desc for in-syncobjs,
there will be more wasted fields. Maybe it indeed won't hurt to split
in/out syncobjs, for consistency. I'll think about it for v6, thanks.

> Off the top of my head: userspace could have an array of larger
> structs, each embedding an syncobj. Thus passing the stride, the
> kernel will fetch/update them in-place w/o caring about the other
> data.
> Or perhaps there is another trick that userspace utilises the stride for?

Stride is only about potential future expansion of the struct
drm_virtgpu_execbuffer_syncobj with new fields. There shouldn't be any
special tricks for userspace to use.

>> +               if (copy_from_user(&syncobj_desc,
>> +                                  u64_to_user_ptr(address),
>> +                                  min(syncobj_stride, sizeof(syncobj_desc)))) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
> 
> We seem to be parsing garbage(?) stack data in the syncobj_stride <
> sizeof(syncobj_desc) case.
> 
> Zeroing/reseting the syncobj_desc on each iteration is one approach -
> be that fully or in part. Alternatively we could error out on
> syncobj_stride < sizeof(syncobj_desc).

Good catch! It indeed needs to be zeroed. Nothing terrible will happen
today for kernel if it will use garbage data, but a malfunctioning
userspace may happen to appear working properly.

>> +               post_deps[i].point = syncobj_desc.point;
>> +
>> +               if (syncobj_desc.flags) {
>> +                       ret = -EINVAL;
>> +                       break;
>> +               }
>> +
>> +               if (syncobj_desc.point) {
>> +                       post_deps[i].chain = dma_fence_chain_alloc();
>> +                       if (!post_deps[i].chain) {
>> +                               ret = -ENOMEM;
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               post_deps[i].syncobj = drm_syncobj_find(submit->file,
>> +                                                       syncobj_desc.handle);
>> +               if (!post_deps[i].syncobj) {
>> +                       ret = -EINVAL;
> 
> I think we want a kfree(chain) here. Otherwise we'll leak it, right?

I'm sure there was a kfree here in one of previous version of the patch.
Another good catch, thanks :)

>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (ret) {
>> +               virtio_gpu_free_post_deps(post_deps, i);
>> +               return ret;
>> +       }
>> +
>> +       submit->num_out_syncobjs = num_out_syncobjs;
>> +       submit->post_deps = post_deps;
>> +
>> +       return 0;
>> +}
>> +
> 
> 
> With the two issues in virtio_gpu_parse_post_deps() addressed, the series is:
> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>

Thanks you for the review!

-- 
Best regards,
Dmitry

