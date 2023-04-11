Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313096DD038
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDKDdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKDdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:33:46 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EFDBEB;
        Mon, 10 Apr 2023 20:33:44 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:8615.1212641597
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 47F091002B2;
        Tue, 11 Apr 2023 11:33:40 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-ljp89 with ESMTP id eb8c5b28e13a40fbb0aae97340f6b575 for emil.l.velikov@gmail.com;
        Tue, 11 Apr 2023 11:33:43 CST
X-Transaction-ID: eb8c5b28e13a40fbb0aae97340f6b575
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <2833ed06-7f8a-b8c1-404e-b481b2fedb3f@189.cn>
Date:   Tue, 11 Apr 2023 11:33:39 +0800
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
        nathan@kernel.org, linux-media@vger.kernel.org
References: <20230403171304.2157326-1-suijingfeng@loongson.cn>
 <20230403171304.2157326-3-suijingfeng@loongson.cn>
 <CACvgo53h+X26wngVmxpn3oVb9kbJezTHx61p3rZDR7sw1AQrWQ@mail.gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <CACvgo53h+X26wngVmxpn3oVb9kbJezTHx61p3rZDR7sw1AQrWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
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
>> --- /dev/null
>> +++ b/drivers/gpu/drm/loongson/lsdc_debugfs.c
>> +void lsdc_debugfs_init(struct drm_minor *minor)
>> +{
>> +#ifdef CONFIG_DEBUG_FS
>> +       drm_debugfs_create_files(lsdc_debugfs_list,
>> +                                ARRAY_SIZE(lsdc_debugfs_list),
>> +                                minor->debugfs_root,
>> +                                minor);
>> +#endif
>> +}
> Should probably build the file when debugfs is enabled and provide
> no-op stub in the header. See nouveau for an example.
>
But doing that way introduce duplication,  you actually write two 
implements for the same function prototype.

One for the real, another one for the dummy.

Typically skilled core framework programmer/writer like it, for multiple 
backend and multiple arch support

Because the functions set need to be implemented is large for those cases.

While we are just a driver implement based the drm core and only one 
single function here,

DEBUG_FS is enabled by default on our Mips and Loongarch. It is not 
suffer from high frequency changes.

In this case , CONFIG_DEBUG_FS just boils down to "true", a nearly 
always enabled decoration.


We do implement debugfs support that way in the before[1], but we pursue 
compact in the afterwards.

We could revise our driver if that is strongly recommended.


[1] https://patchwork.freedesktop.org/patch/480521/

