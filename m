Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B893673E457
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjFZQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjFZQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:12:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C1110F6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:11:50 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E6D566003AC;
        Mon, 26 Jun 2023 17:11:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687795908;
        bh=9EZs0izTC9fT3uhYtjpxEXL0MLcsJc+fn/xx7LDWC30=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eW9yYPq6r+yhdEvGBX0mFerL6rT+zA/f5p+Aq+i+1Gvz7TmqJ3PZZCbxm5O9mxC0q
         +wsB3qZtEg6L+HAx2svRPhQWQW+uAjqweSzb5ZVPE96+wB2K6lfsiabzOX2s7HHEth
         vT+clsYUfkiTRmR+8m1P4NMY6iBMVAYZemw2KTMwYfdrud9xHPfIVtghLSrypMxSO1
         8mOxPCsDdm7DtudciYaTh1sRBkpx6H0zjiINaLQPalZvz59ETD2dSxQ2K4Us+qd8Nh
         f7DDiZEqwu3PHqtmtAnUgJaeZtg1Q1W4U9OfbF43uyvrvIQEhg5lpm2KKMvk1lAeW6
         7hsT1XtYiMYOA==
Message-ID: <2f4d3e96-1e10-3662-bfc5-8c361a4c1366@collabora.com>
Date:   Mon, 26 Jun 2023 19:11:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v6 3/3] drm/virtio: Support sync objects
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com>
 <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
 <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
 <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 18:36, Geert Uytterhoeven wrote:
> Hi Dmitry,
> 
> On Sun, Jun 25, 2023 at 2:41 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>> On 6/25/23 11:47, Geert Uytterhoeven wrote:
>>> On Sun, Apr 16, 2023 at 1:55 PM Dmitry Osipenko
>>> <dmitry.osipenko@collabora.com> wrote:
>>>> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
>>>> support is needed by native context VirtIO-GPU Mesa drivers, it also will
>>>> be used by Venus and Virgl contexts.
>>>>
>>>> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
>>>
>>>> +static int
>>>> +virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
>>>> +{
>>>> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
>>>> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
>>>> +       size_t syncobj_stride = exbuf->syncobj_stride;
>>>> +       u32 num_in_syncobjs = exbuf->num_in_syncobjs;
>>>> +       struct drm_syncobj **syncobjs;
>>>> +       int ret = 0, i;
>>>> +
>>>> +       if (!num_in_syncobjs)
>>>> +               return 0;
>>>> +
>>>> +       /*
>>>> +        * kvalloc at first tries to allocate memory using kmalloc and
>>>> +        * falls back to vmalloc only on failure. It also uses GFP_NOWARN
>>>
>>> GFP_NOWARN does not exist.
>>
>> https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/gfp_types.h#L38
> 
> That line defines "__GFP_NOWARN", not "GFP_NOWARN".
> C is case- and underscore-sensitive. as is "git grep -w" ;-)

The removal of underscores was done intentionally for improving
readability of the comment

-- 
Best regards,
Dmitry

