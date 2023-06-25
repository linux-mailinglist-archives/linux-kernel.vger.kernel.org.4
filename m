Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01FA73D10D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjFYMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFYMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:42:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873D131
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:41:47 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7F6F66031BB;
        Sun, 25 Jun 2023 13:41:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687696905;
        bh=0I1rLltUXkTnuQd/Jvq/oa9s7KLLg1FujdfDbdaVAKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P5ZIZ4UQKOsnlyXzqxUVqKQrAzvPU4bSOV3uz5j0Nmdim+LPgprXn5ucXF9fiCKSp
         76huK/CIkDaX9pT7AHfWvykF+cyojiAgGZ9TdRQuQiD0Yia7xueQWSiFFMzny7FNhS
         8O73csA8e/KRNaqvaseQhERP++r+ocEBniHGrcpLP76mfyrXsjIBffwoHtCbzjrfIu
         TXGDf4XZ4hEtDNVgVuT3jZgtfwdcIgAdlInclE2TezCUEdswbBevWdD2mXKA8F8ssW
         21GKN5ubwDAnXRtNOiPA7oVseYQzj6ri51mDCzxEeLzcSYHhPZxVk62XD93C5G9BMg
         ognpTBMa0dhxw==
Message-ID: <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
Date:   Sun, 25 Jun 2023 15:41:41 +0300
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
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
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

On 6/25/23 11:47, Geert Uytterhoeven wrote:
> Hi Dmitry,
> 
> On Sun, Apr 16, 2023 at 1:55 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
>> support is needed by native context VirtIO-GPU Mesa drivers, it also will
>> be used by Venus and Virgl contexts.
>>
>> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> 
>> +static int
>> +virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
>> +{
>> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
>> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
>> +       size_t syncobj_stride = exbuf->syncobj_stride;
>> +       u32 num_in_syncobjs = exbuf->num_in_syncobjs;
>> +       struct drm_syncobj **syncobjs;
>> +       int ret = 0, i;
>> +
>> +       if (!num_in_syncobjs)
>> +               return 0;
>> +
>> +       /*
>> +        * kvalloc at first tries to allocate memory using kmalloc and
>> +        * falls back to vmalloc only on failure. It also uses GFP_NOWARN
> 
> GFP_NOWARN does not exist.

https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/gfp_types.h#L38

-- 
Best regards,
Dmitry

