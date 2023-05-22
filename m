Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68DF70B751
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEVIJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEVIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:09:44 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F2FAA;
        Mon, 22 May 2023 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684742981; bh=aA1E0+xC/rAqJLb6Jh39PUGRSeGXjVPeIfHkIASardM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GxNeYl2P1gnfXOcmwOovlg6H5jfccMv55Mlm6Y1G/Rj7o8toa/nDZIs4swTV43Y/g
         cYAQYTAiQC8X1nkbWT/3/uxkWcBz6G3UGpjOeCmxYqh4KFeY8+HF2/fWbWnREobchl
         iWk2z7ftTFn2LgWhH9gRfUSEFmawzGMG7bpz2kuc=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7DFEA600DA;
        Mon, 22 May 2023 16:09:40 +0800 (CST)
Message-ID: <97fe7af2-0a93-3f28-db6e-40a9b0798d49@xen0n.name>
Date:   Mon, 22 May 2023 16:09:39 +0800
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
 <73447e35-f4df-9871-6210-b7bf1a3f04fc@189.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <73447e35-f4df-9871-6210-b7bf1a3f04fc@189.cn>
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

On 2023/5/22 16:02, Sui Jingfeng wrote:
> Hi,
> 
> On 2023/5/21 20:21, WANG Xuerui wrote:
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/loongson/Kconfig
>>> @@ -0,0 +1,17 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +config DRM_LOONGSON
>>> +    tristate "DRM support for Loongson Graphics"
>>> +    depends on DRM && PCI && MMU
>>> +    select DRM_KMS_HELPER
>>> +    select DRM_TTM
>>> +    select I2C
>>> +    select I2C_ALGOBIT
>>> +    help
>>> +      This is a DRM driver for Loongson Graphics, it may including
>>
>> Drop "it may"; "including" should be enough.
>>
> 'it may' is more *precise* here, because currently we don't ship with 
> the support for loongson 2K series SoC.
> 
> I'm try to be precise as far as I can, we avoid made this driver too 
> large by ignore loongson 2K series SoC temporary.

That's a good idea! For now the patch is so large that my review reply 
is said to be dropped by the lists. Focusing on one bunch of similar 
models first then adding support for the rest not-so-similar models is 
very friendly towards the reviewing process and will help code quality too.

> 
>>> +      LS7A2000, LS7A1000, LS2K2000 and LS2K1000 etc. Loongson LS7A
>>> +      series are bridge chipset, while Loongson LS2K series are SoC.
>>> +
>>> +      If "M" is selected, the module will be called loongson.
>>
>> Just "loongson"? 
> 
> Yes,  when compile this driver as module,  loongson.ko will be generated.
> 
>   drm radeon is also doing so, See drm/radeon/Kconfig.
> 
>> I know it's like this for ages (at least dating back to the MIPS days) 
>> but you really don't want to imply Loongson is mainly a GPU company. 
>> Something like "loongson_drm" or "lsdc" or "gsgpu" could be better. 
> 
> No, these name may have backward compatibility problems.
> 
> Downstream driver already taken those name.
> 
> userspace driver need to differentiate them who is who.

IMO this shouldn't be a problem. Let me try explaining this: currently, 
upstream / the "new world" doesn't have any support for this driver at 
all, so any name will work; just use whatever is appropriate from an 
upstream's perspective, then make the userspace bits recognize both 
variants, and you'll be fine. And the "existing" userspace drivers can 
also carry the change, it'll just be a branch never taken in that setup.

So, I'm still in favor of keeping the upstream "clean" without dubious 
names like this (bare "loongson"). What do you think about my suggestion 
above?

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

