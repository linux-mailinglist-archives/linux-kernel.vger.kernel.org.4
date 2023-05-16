Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F07054C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjEPRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEPRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:13:36 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCA797DBB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:13:34 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:38604.1707314332
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 17FDE1001EC;
        Wed, 17 May 2023 01:13:31 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-prw2v with ESMTP id 953a00f70f7049468745cd8cdf3e03c8 for tzimmermann@suse.de;
        Wed, 17 May 2023 01:13:33 CST
X-Transaction-ID: 953a00f70f7049468745cd8cdf3e03c8
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <530369f4-1edd-d8cf-031e-a8effdf15510@189.cn>
Date:   Wed, 17 May 2023 01:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230516165931.2989639-1-suijingfeng@loongson.cn>
 <c4a08b01-6d81-a21f-ba9f-ade2b447ff6d@suse.de>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <c4a08b01-6d81-a21f-ba9f-ade2b447ff6d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/17 01:06, Thomas Zimmermann wrote:
>
>
> Am 16.05.23 um 18:59 schrieb Sui Jingfeng:
>> Both mode->crtc_htotal and mode->crtc_vtotal are u16 type,
>> mode->crtc_htotal * mode->crtc_vtotal will results a unsigned type.
>> Using a u32 is enough to store the result, but considering that the
>> result will be casted to u64 soon after. We use a u64 type directly.
>>
>> So there no need to cast it to signed type and cast back then.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
Thanks a lot,  thanks for the response time also.

>> ---
>>   drivers/gpu/drm/drm_vblank.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index 877e2067534f..d99c404b181b 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -622,7 +622,7 @@ void drm_calc_timestamping_constants(struct 
>> drm_crtc *crtc,
>>         /* Valid dotclock? */
>>       if (dotclock > 0) {
>> -        int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>> +        u64 frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>>             /*
>>            * Convert scanline length in pixels and video
>> @@ -630,7 +630,7 @@ void drm_calc_timestamping_constants(struct 
>> drm_crtc *crtc,
>>            * in nanoseconds:
>>            */
>>           linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, 
>> dotclock);
>> -        framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>> +        framedur_ns = div_u64(frame_size * 1000000, dotclock);
>>             /*
>>            * Fields of interlaced scanout modes are only half a frame 
>> duration.
>
