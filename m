Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6670B771
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjEVITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjEVITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:19:44 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87091B0;
        Mon, 22 May 2023 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684743580; bh=RZXp5Ck7yfTaCZh0IwtE2GL3yOChPwPMVkjIgiEYfqs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gi7Uq2ike/7EE9dkmUHbd0oKSZQH8v8rapxy2X8W4bbdBJ5GxWUvUfwHEV7yogYnz
         m7b38NCttK19pbrc3o/BaBVBn6QU6kVPIiHCsQYhs/Qyvy99rzq8/4lg90OlErPQp2
         cf6eE8TeW0uimep7ey+Omw9Quc6taN1r1qEDQsKI=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id DE4E1600DA;
        Mon, 22 May 2023 16:19:39 +0800 (CST)
Message-ID: <74b273dd-4310-0106-a24c-c1b15db8ead9@xen0n.name>
Date:   Mon, 22 May 2023 16:19:39 +0800
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
 <6957f8b7-5e37-889f-0b48-d2424b891392@189.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <6957f8b7-5e37-889f-0b48-d2424b891392@189.cn>
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

On 2023/5/22 16:14, Sui Jingfeng wrote:
> Hi,
> 
> On 2023/5/21 20:21, WANG Xuerui wrote:
>>> +
>>> +      If in doubt, say "N".
>>> diff --git a/drivers/gpu/drm/loongson/Makefile 
>>> b/drivers/gpu/drm/loongson/Makefile
>>> new file mode 100644
>>> index 000000000000..9158816ece8e
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/loongson/Makefile
>>> @@ -0,0 +1,20 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +loongson-y := \
>>> +    lsdc_benchmark.o \
>>> +    lsdc_crtc.o \
>>> +    lsdc_debugfs.o \
>>> +    lsdc_device.o \
>>> +    lsdc_drv.o \
>>> +    lsdc_gem.o \
>>> +    lsdc_gfxpll.o \
>>> +    lsdc_i2c.o \
>>> +    lsdc_irq.o \
>>> +    lsdc_output_7a1000.o \
>>> +    lsdc_output_7a2000.o \
>>> +    lsdc_plane.o \
>>> +    lsdc_pixpll.o \
>>> +    lsdc_probe.o \
>>> +    lsdc_ttm.o
>>> +
>>> +obj-$(CONFIG_DRM_LOONGSON) += loongson.o
>>> diff --git a/drivers/gpu/drm/loongson/lsdc_benchmark.c 
>>> b/drivers/gpu/drm/loongson/lsdc_benchmark.c
>>> new file mode 100644
>>> index 000000000000..82961531d84c
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/loongson/lsdc_benchmark.c
>>> @@ -0,0 +1,133 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>
>> Is it GPL-2.0, GPL-2.0-only, or GPL-2.0+? Please make sure all license 
>> IDs are consistent. 
> 
> 
> I see drm/vkms is also writing the copyrights similar.
> 
> with "# SPDX-License-Identifier: GPL-2.0-only" in the Makefile,
> 
> while "// SPDX-License-Identifier: GPL-2.0+" in the C source file.
> 
> Sorry, I'm stupid, I can't figure out the difference between them.
> 
> Personally, I really don't care about this as along as checkpatch.pl 
> don't complain.
> 
> I respect the maintainers of DRM, they didn't told me to change it.
> 
> I assume there is no problem.

It's your work after all, so you get to license the work however you 
want (inside the kernel project's licensing requirements, of course), so 
maintainers won't interfere with that.

I'm suggesting the license double-check because the whole driver is one 
piece of work, so it's better to be extra clear (you DO want to make 
sure things are clear when it comes to copyright, compliance & etc.) and 
make it as consistent as possible, but ultimately it's of course down to 
you. I think you may keep things as-is if others don't voice their 
concerns in the coming days.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

