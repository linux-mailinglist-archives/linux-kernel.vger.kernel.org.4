Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A321270B86E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjEVJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjEVJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:05:28 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6C50FE;
        Mon, 22 May 2023 02:05:14 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:51158.600247562
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 387F01002CF;
        Mon, 22 May 2023 17:05:11 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 4e1da2ddffb14c7ea87b889e41f0d88c for kernel@xen0n.name;
        Mon, 22 May 2023 17:05:14 CST
X-Transaction-ID: 4e1da2ddffb14c7ea87b889e41f0d88c
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <47bfa5a1-8a60-6faa-1983-d8a29589cdb6@189.cn>
Date:   Mon, 22 May 2023 17:05:10 +0800
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
>> +++ b/drivers/gpu/drm/loongson/lsdc_debugfs.c
>> @@ -0,0 +1,91 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <drm/drm_debugfs.h>
>> +
>> +#include "lsdc_benchmark.h"
>> +#include "lsdc_drv.h"
>> +#include "lsdc_gem.h"
>> +#include "lsdc_probe.h"
>> +#include "lsdc_ttm.h"
>> +
>> +/* device level debugfs */
>> +
>> +static int lsdc_identify(struct seq_file *m, void *arg)
>> +{
>> +    struct drm_info_node *node = (struct drm_info_node *)m->private;
>> +    struct lsdc_device *ldev = (struct lsdc_device 
>> *)node->info_ent->data;
>> +    const struct loongson_gfx_desc *gfx = to_loongson_gfx(ldev->descp);
>> +    u8 impl, rev;
>> +
>> +    loongson_cpu_get_prid(&impl, &rev);
>> +
>> +    seq_printf(m, "Running on cpu 0x%x, cpu revision: 0x%x\n",
>> +           impl, rev);
>
> Is this really needed/relevant for LSDC identification? AFAICS the 
> loongson_cpu_get_prid helper has only one use (that's here), 

Yes, this is really needed, when doing the remote debugging, sometime 
you only have a ssh login the target machine.

User of the driver could know what the host is in the DRM way.

> so if it's not absolutely necessary you can just get rid of that 
> function and lsdc_probe.h altogether.
This function it written for the future, It will not be removed.
>
>> +
>> +    seq_printf(m, "Contained in: %s\n", gfx->model);
>
> "model: " would be more appropriate for a piece of info looking like a 
> "gfx->model"?
No, these are nearly equivalent.
