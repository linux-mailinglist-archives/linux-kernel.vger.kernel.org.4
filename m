Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CD70B73E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjEVICt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEVICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:02:39 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4161AB;
        Mon, 22 May 2023 01:02:37 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:58120.1490266714
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 00AEA1002C4;
        Mon, 22 May 2023 16:02:34 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 1a4434578fbd45abb00625fc7c141694 for kernel@xen0n.name;
        Mon, 22 May 2023 16:02:36 CST
X-Transaction-ID: 1a4434578fbd45abb00625fc7c141694
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <73447e35-f4df-9871-6210-b7bf1a3f04fc@189.cn>
Date:   Mon, 22 May 2023 16:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
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
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/21 20:21, WANG Xuerui wrote:
>> --- /dev/null
>> +++ b/drivers/gpu/drm/loongson/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +config DRM_LOONGSON
>> +    tristate "DRM support for Loongson Graphics"
>> +    depends on DRM && PCI && MMU
>> +    select DRM_KMS_HELPER
>> +    select DRM_TTM
>> +    select I2C
>> +    select I2C_ALGOBIT
>> +    help
>> +      This is a DRM driver for Loongson Graphics, it may including
>
> Drop "it may"; "including" should be enough.
>
'it may' is more *precise* here, because currently we don't ship with 
the support for loongson 2K series SoC.

I'm try to be precise as far as I can, we avoid made this driver too 
large by ignore loongson 2K series SoC temporary.

>> +      LS7A2000, LS7A1000, LS2K2000 and LS2K1000 etc. Loongson LS7A
>> +      series are bridge chipset, while Loongson LS2K series are SoC.
>> +
>> +      If "M" is selected, the module will be called loongson.
>
> Just "loongson"? 

Yes,  when compile this driver as module,  loongson.ko will be generated.

  drm radeon is also doing so, See drm/radeon/Kconfig.

> I know it's like this for ages (at least dating back to the MIPS days) 
> but you really don't want to imply Loongson is mainly a GPU company. 
> Something like "loongson_drm" or "lsdc" or "gsgpu" could be better. 

No, these name may have backward compatibility problems.

Downstream driver already taken those name.

userspace driver need to differentiate them who is who.


