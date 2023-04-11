Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2710F6DD7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDKKVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDKKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:21:43 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA4ECDD;
        Tue, 11 Apr 2023 03:21:40 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:55572.1747296415
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id F1B78100208;
        Tue, 11 Apr 2023 18:21:37 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id 8ce6a0aaf01b4ef78285af8e79f77ddf for emil.l.velikov@gmail.com;
        Tue, 11 Apr 2023 18:21:39 CST
X-Transaction-ID: 8ce6a0aaf01b4ef78285af8e79f77ddf
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <860cb3b3-5247-c6ad-c13a-619cde221208@189.cn>
Date:   Tue, 11 Apr 2023 18:21:37 +0800
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
Content-Transfer-Encoding: 8bit
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
>> +static enum drm_mode_status
>> +lsdc_mode_config_mode_valid(struct drm_device *ddev,
>> +                           const struct drm_display_mode *mode)
>> +{
>> +       struct lsdc_device *ldev = to_lsdc(ddev);
>> +       const struct drm_format_info *info = drm_format_info(DRM_FORMAT_XRGB8888);
> Short-term hard coding a format is fine, but there should be a comment
> describing why.
Because our driver only support DRM_FORMAT_XRGB8888 frame buffer currently.

After carry out the IGT test, I found this function may not sufficient  
anymore.

>> +       u64 min_pitch = drm_format_info_min_pitch(info, 0, mode->hdisplay);
>> +       u64 fb_size = min_pitch * mode->vdisplay;
>> +
>> +       if (fb_size * 3 > ldev->vram_size) {
> Why are we using 3 here? Please add an inline comment.
>
Originally lsdc_mode_config_mode_valid() is copy from drm_gem_vram_helper.c

with the observation that there no need for the compute of the number of 
pages in

the terms of PAGE_SIZE.


The '3' here is  a experience number, it intend to restrict single 
allocation overlarge.

In my opinion, it stand for one frame buffer plus another two dumb 
buffer allocation

when running  the running pageflip test(from the libdrm modetest).


Therefore, the kernel space drm driver should guarantee at least 3 times 
frame buffer

allocation to the user-space. Otherwise, the pageflip test can not even 
being able to run.


While when testing this driver with IGT, I found the  dumb_buffer test 
of IGT will try to

create a very large dumb buffer,  as large as 256MB in my case.

Currently our driver could not satisfy such a large allocation,

I test it with drm/radeon driver on LoongArch and X86-64, redeon can not 
even passing it.


The restriction put in here is not effective anymore, because it is too 
late.

I'm think we should put the restriction in the lsdc_dumb_create() function.

We will revise our driver at next version.


Great thanks for your valuable reviews.

