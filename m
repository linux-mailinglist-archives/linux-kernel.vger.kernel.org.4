Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148FC6DD83A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjDKKpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDKKpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:45:09 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70D5D423F;
        Tue, 11 Apr 2023 03:44:47 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:53314.233135370
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 8596310013E;
        Tue, 11 Apr 2023 18:44:33 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id 34c062daeef4482cada5c101c1f03811 for emil.l.velikov@gmail.com;
        Tue, 11 Apr 2023 18:44:35 CST
X-Transaction-ID: 34c062daeef4482cada5c101c1f03811
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <d46621fc-94d1-8c33-76e9-00825763719b@189.cn>
Date:   Tue, 11 Apr 2023 18:44:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v10 2/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nathan@kernel.org, linux-media@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230403171304.2157326-1-suijingfeng@loongson.cn>
 <20230403171304.2157326-3-suijingfeng@loongson.cn>
 <CACvgo53h+X26wngVmxpn3oVb9kbJezTHx61p3rZDR7sw1AQrWQ@mail.gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <CACvgo53h+X26wngVmxpn3oVb9kbJezTHx61p3rZDR7sw1AQrWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/4 22:10, Emil Velikov wrote:
>> +static const struct dev_pm_ops lsdc_pm_ops = {
>> +       .suspend = lsdc_pm_suspend,
>> +       .resume = lsdc_pm_resume,
>> +       .freeze = lsdc_pm_freeze,
>> +       .thaw = lsdc_pm_thaw,
>> +       .poweroff = lsdc_pm_freeze,
>> +       .restore = lsdc_pm_resume,
>> +};
>> +
> The above section (and functions) should probably be wrapped in a
> CONFIG_PM_SLEEP block.
>
I agree with you.

I see imx-drm has this guard, but it's for embedded platform.

But I also see drm/ast and drm/radeon also didn't add this.

Maybe S3/S4 support is mandatory for PC platform?

Coding this way to force the kernel to enable PM_SLEEP option, otherwise 
there a pile of driver won't get compiled.

At lease drm/ast and drm/radeon is usable on LoongArch/Mips/X86-64 platform.


