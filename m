Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0346D56F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjDDCzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDDCzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:55:35 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 018E119BF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:55:32 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:48454.1860087732
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 97DE0102ADA;
        Tue,  4 Apr 2023 10:55:29 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-bkw2h with ESMTP id 9b5738e047274065a67ab0e7b4b82ca0 for tzimmermann@suse.de;
        Tue, 04 Apr 2023 10:55:31 CST
X-Transaction-ID: 9b5738e047274065a67ab0e7b4b82ca0
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <3c173bbe-c74a-5817-c9c5-f3364c628240@189.cn>
Date:   Tue, 4 Apr 2023 10:55:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/fbdev-generic: optimize out a redundant assignment
 clause
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>, liyi <liyi@loongson.cn>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230325074636.136833-1-15330273260@189.cn>
 <a3370ae7-8c78-8170-f9c3-7f616a1fa382@suse.de>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <a3370ae7-8c78-8170-f9c3-7f616a1fa382@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/29 17:04, Thomas Zimmermann wrote:
> (cc'ing Lucas)
>
> Hi
>
> Am 25.03.23 um 08:46 schrieb Sui Jingfeng:
>>   The assignment already done in drm_client_buffer_vmap(),
>>   just trival clean, no functional change.
>>
>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>> ---
>>   drivers/gpu/drm/drm_fbdev_generic.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c 
>> b/drivers/gpu/drm/drm_fbdev_generic.c
>> index 4d6325e91565..1da48e71c7f1 100644
>> --- a/drivers/gpu/drm/drm_fbdev_generic.c
>> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>> @@ -282,7 +282,7 @@ static int drm_fbdev_damage_blit(struct 
>> drm_fb_helper *fb_helper,
>>                    struct drm_clip_rect *clip)
>>   {
>>       struct drm_client_buffer *buffer = fb_helper->buffer;
>> -    struct iosys_map map, dst;
>> +    struct iosys_map map;
>>       int ret;
>>         /*
>> @@ -302,8 +302,7 @@ static int drm_fbdev_damage_blit(struct 
>> drm_fb_helper *fb_helper,
>>       if (ret)
>>           goto out;
>>   -    dst = map;
>> -    drm_fbdev_damage_blit_real(fb_helper, clip, &dst);
>> +    drm_fbdev_damage_blit_real(fb_helper, clip, &map);
>
> I see what you're doing and it's probably correct in this case.
>
> But there's a larger issue with this iosys interfaces. Sometimes the 
> address has to be modified (see calls of iosys_map_incr()). That can 
> prevent incorrect uses of the mapping in other places, especially in 
> unmap code.
>
Yes, I just realized that.

iosys_map_incr() change the internal state of a opaque structure, this 
is somewhat evil.

if it is non-opaque, then this is abstract failure.

You have to worry about that if it is changed by a accident call 
iosys_map_incr() from other place.

The map should be const, I guess most programmer expect  the map be a const.

making it const please, copy on demand, modify the copy only, leave the 
original mapping untouched.

Hope this could eliminate the embarrassing.

Sorry for missing the point.

> I think it would make sense to consider a separate structure for the 
> I/O location. The buffer as a whole would still be represented by 
> struct iosys_map.  And that new structure, let's call it struct 
> iosys_ptr, would point to an actual location within the buffer's 
> memory range. A few locations and helpers would need changes, but 
> there are not so many callers that it's an issue.  This would also 
> allow for a few debugging tests that ensure that iosys_ptr always 
> operates within the bounds of an iosys_map.
>
> I've long considered this idea, but there was no pressure to work on 
> it. Maybe now.
>
I have also get some idea from you idea.
> Best regards
> Thomas
>
>>         drm_client_buffer_vunmap(buffer);
>
