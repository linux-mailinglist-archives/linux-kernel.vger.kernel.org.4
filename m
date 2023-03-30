Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8A6CFF68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjC3JBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjC3JBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:01:21 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A5B46EAD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:01:19 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:38472.1681716573
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id B4C161002CF;
        Thu, 30 Mar 2023 17:01:17 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id f5b9e183632f48f099a5785df2746d73 for tzimmermann@suse.de;
        Thu, 30 Mar 2023 17:01:18 CST
X-Transaction-ID: f5b9e183632f48f099a5785df2746d73
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <740bb1d9-fca2-9171-b548-0422c9e94112@189.cn>
Date:   Thu, 30 Mar 2023 17:01:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/fbdev-generic: optimize out a redundant assignment
 clause
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     suijingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@linux.ie>, liyi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230325074636.136833-1-15330273260@189.cn>
 <a3370ae7-8c78-8170-f9c3-7f616a1fa382@suse.de>
 <20230330041726.w7boceq7ljymvfq2@ldmartin-desk2>
 <f42d8ab8-c765-2517-7d25-6ce1dea320e8@suse.de>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <f42d8ab8-c765-2517-7d25-6ce1dea320e8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/30 14:57, Thomas Zimmermann wrote:
> Hi
>
> Am 30.03.23 um 06:17 schrieb Lucas De Marchi:
>> On Wed, Mar 29, 2023 at 11:04:17AM +0200, Thomas Zimmermann wrote:
>>> (cc'ing Lucas)
>>>
>>> Hi
>>>
>>> Am 25.03.23 um 08:46 schrieb Sui Jingfeng:
>>>>  The assignment already done in drm_client_buffer_vmap(),
>>>>  just trival clean, no functional change.
>>>>
>>>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>>>> ---
>>>>  drivers/gpu/drm/drm_fbdev_generic.c | 5 ++---
>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c 
>>>> b/drivers/gpu/drm/drm_fbdev_generic.c
>>>> index 4d6325e91565..1da48e71c7f1 100644
>>>> --- a/drivers/gpu/drm/drm_fbdev_generic.c
>>>> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>>>> @@ -282,7 +282,7 @@ static int drm_fbdev_damage_blit(struct 
>>>> drm_fb_helper *fb_helper,
>>>>                   struct drm_clip_rect *clip)
>>>>  {
>>>>      struct drm_client_buffer *buffer = fb_helper->buffer;
>>>> -    struct iosys_map map, dst;
>>>> +    struct iosys_map map;
>>>>      int ret;
>>>>      /*
>>>> @@ -302,8 +302,7 @@ static int drm_fbdev_damage_blit(struct 
>>>> drm_fb_helper *fb_helper,
>>>>      if (ret)
>>>>          goto out;
>>>> -    dst = map;
>>>> -    drm_fbdev_damage_blit_real(fb_helper, clip, &dst);
>>>> +    drm_fbdev_damage_blit_real(fb_helper, clip, &map);
>>>
>>> I see what you're doing and it's probably correct in this case.
>>>
>>> But there's a larger issue with this iosys interfaces. Sometimes the 
>>> address has to be modified (see calls of iosys_map_incr()). That can 
>>> prevent incorrect uses of the mapping in other places, especially in 
>>> unmap code.
>>
>> using a initializer for the cases it's needed IMO would make these kind
>> of problems go away, because then the intent is explicit
>>
>>>
>>> I think it would make sense to consider a separate structure for the 
>>> I/O location. The buffer as a whole would still be represented by 
>>> struct iosys_map.  And that new structure, let's call it struct 
>>> iosys_ptr, would point to an actual location within the buffer's
>>
>> sounds fine to me, but I'd have to take a deeper look later (or when
>> someone writes the patch).  It seems we'd replicate almost the entire
>> API to just accomodate the 2 structs.  And the different types will lead
>> to confusion when one or the other should be used
>
> I think we can split the current interface onto two categories: 
> mapping and I/O. The former would use iosys_map and the latter would 
> use iosys_ptr. And we'd need a helper that turns gets a ptr for a 
> given map.
>
> If I find the tine, I'll probably type up a patch.
>
Then merge this trivial patch first?

It will not prohibit anyone achieve a big goal or releasing a better 
patch in the future.


> Best regards
> Thomas
>
>>
>> thanks
>> Lucas De Marchi
>>
>>> memory range. A few locations and helpers would need changes, but 
>>> there are not so many callers that it's an issue.  This would also 
>>> allow for a few debugging tests that ensure that iosys_ptr always 
>>> operates within the bounds of an iosys_map.
>>>
>>> I've long considered this idea, but there was no pressure to work on 
>>> it. Maybe now.
>>>
>>> Best regards
>>> Thomas
>>>
>>>>      drm_client_buffer_vunmap(buffer);
>>>
>>> -- 
>>> Thomas Zimmermann
>>> Graphics Driver Developer
>>> SUSE Software Solutions Germany GmbH
>>> Maxfeldstr. 5, 90409 Nürnberg, Germany
>>> (HRB 36809, AG Nürnberg)
>>> Geschäftsführer: Ivo Totev
>>
>>
>>
>
