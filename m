Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7345570B89B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjEVJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjEVJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:09:57 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D433A0;
        Mon, 22 May 2023 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684746594; bh=SPYiAMAfwsbGLpbFquS7a6DX49n2vxiuay0rOac3rZk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uiVi4AlxpZ232570ViYBvCQl9V7OUZlNX/DFSnXUFQLQFt+yFf0VH/cV/Y0uOXys+
         kyLDCPJoyJLly2UEJOmrTEPO83GuvAqKTRS/iPk4BLJy23yGz3snLdfwAwHSEwWRqs
         OorxcMiBwDRusc28o2+fpZ1fd2NT/RpWTKrIFg0g=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 07042600DA;
        Mon, 22 May 2023 17:09:52 +0800 (CST)
Message-ID: <8cb8e7e9-7287-f8eb-e1d3-52effde0cceb@xen0n.name>
Date:   Mon, 22 May 2023 17:09:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Liu Peibao <liupeibao@loongson.cn>, linux-media@vger.kernel.org
References: <20230520105718.325819-1-15330273260@189.cn>
 <20230520105718.325819-2-15330273260@189.cn>
 <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
 <47bfa5a1-8a60-6faa-1983-d8a29589cdb6@189.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <47bfa5a1-8a60-6faa-1983-d8a29589cdb6@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2023/5/22 17:05, Sui Jingfeng wrote:
> Hi,
> 
> On 2023/5/21 20:21, WANG Xuerui wrote:
>>> +++ b/drivers/gpu/drm/loongson/lsdc_debugfs.c
>>> @@ -0,0 +1,91 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>>> + */
>>> +
>>> +#include <drm/drm_debugfs.h>
>>> +
>>> +#include "lsdc_benchmark.h"
>>> +#include "lsdc_drv.h"
>>> +#include "lsdc_gem.h"
>>> +#include "lsdc_probe.h"
>>> +#include "lsdc_ttm.h"
>>> +
>>> +/* device level debugfs */
>>> +
>>> +static int lsdc_identify(struct seq_file *m, void *arg)
>>> +{
>>> +    struct drm_info_node *node = (struct drm_info_node *)m->private;
>>> +    struct lsdc_device *ldev = (struct lsdc_device 
>>> *)node->info_ent->data;
>>> +    const struct loongson_gfx_desc *gfx = to_loongson_gfx(ldev->descp);
>>> +    u8 impl, rev;
>>> +
>>> +    loongson_cpu_get_prid(&impl, &rev);
>>> +
>>> +    seq_printf(m, "Running on cpu 0x%x, cpu revision: 0x%x\n",
>>> +           impl, rev);
>>
>> Is this really needed/relevant for LSDC identification? AFAICS the 
>> loongson_cpu_get_prid helper has only one use (that's here), 
> 
> Yes, this is really needed, when doing the remote debugging, sometime 
> you only have a ssh login the target machine.
> 
> User of the driver could know what the host is in the DRM way.

Okay, so it's unavoidable coupling of CPU and DC models, because the DC 
hardware revision cannot be determined by looking at its revision field 
alone (i.e. multiple actual HW makes behaving differently, but sharing 
one DC revision).

I've always hoped things were different in the LoongArch era, turns out 
someone has failed me :-/ Then probably you should mention the necessity 
of the coupling somewhere with comments.

> 
>> so if it's not absolutely necessary you can just get rid of that 
>> function and lsdc_probe.h altogether.
> This function it written for the future, It will not be removed.

Usually we only introduce code when necessary. For now if others are 
fine with this then I'd be fine too.

>>
>>> +
>>> +    seq_printf(m, "Contained in: %s\n", gfx->model);
>>
>> "model: " would be more appropriate for a piece of info looking like a 
>> "gfx->model"?
> No, these are nearly equivalent.

While I don't completely get why, it's mostly a stylistic recommendation 
so maybe it's okay anyway. It's just debug information after all.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

