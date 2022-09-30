Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065B5F0788
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiI3JZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiI3JZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B925FF78
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664529940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHizq7BlPFEQ4Or7gBQDWV2H9Bve5A4TC0jGsXwCKqY=;
        b=VF6lJjBu5GWMer9X/Ma9d5MQysAUmHN8P9BFvXq6gNIgIZJcRscgf16dLqdLcV1tiP+km7
        GUeE0xG6qlOvy6gxtuB2fBC1sX1YCn25bBvvOX0bQH5GnKTRX1CJu5m0VWaJf40CeanBpk
        Cc2XEdsPlmsRLzx+hSEyjtJfsGDBWb0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-4q-wQOcTN823u4bA1vwWaA-1; Fri, 30 Sep 2022 05:25:38 -0400
X-MC-Unique: 4q-wQOcTN823u4bA1vwWaA-1
Received: by mail-wr1-f69.google.com with SMTP id q28-20020adfab1c000000b0022e0399964dso181042wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wHizq7BlPFEQ4Or7gBQDWV2H9Bve5A4TC0jGsXwCKqY=;
        b=7N9hFL/ZlihTQeAdfeGGL2+51RKBQYUClZ3P9FP/U/Oh0TjXEQDZlqcDqsCIcC3Zqf
         dq20CDRxMRspMxI9v1GpX0fYXOTnhykcqvugRORaDB5pcbYg6j1mg6IwT3b/NiyPORPU
         1Hy0pDa9lm8klhPAnIZIvuVwib3Q4VpPaaAx7szEfr3AqKr9Ap7EGHo0AodTvZecgONW
         G54MG1frPRxcDvCMHRXxXHA52OirBoYm5wcnKD9usLlOUNQ1yPycg4gsj2oyuDXudqSm
         t/t0xN+BnQVfoQ5qhckjZZz+t+8ZnzkBigyi9egadK8K8hGr9J/5NvReZdCMN29D0Gq4
         qhIg==
X-Gm-Message-State: ACrzQf1N6OfFieABskpcq1KbK0V8M2gye0fwBv8qK5VyaWULsDLX0Baa
        f7qZ44vQr07VcUY/IVSMLm9XZq4rzQAfrz/VZwyzZ9v06aj5Ai8qZIVJJIFpZDreI3iq3wowfe4
        8U9BQ+/dJoqY3ZlR1AKIQzfVg
X-Received: by 2002:a5d:5a1a:0:b0:22a:ad99:d6eb with SMTP id bq26-20020a5d5a1a000000b0022aad99d6ebmr5618689wrb.76.1664529937450;
        Fri, 30 Sep 2022 02:25:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69Z1NMeezNfWti8y4P1oywT0JJcVH22qy0OB4L5lj8XASLTSigVkXmdmqLEoZUymOkuE/tXQ==
X-Received: by 2002:a5d:5a1a:0:b0:22a:ad99:d6eb with SMTP id bq26-20020a5d5a1a000000b0022aad99d6ebmr5618677wrb.76.1664529937242;
        Fri, 30 Sep 2022 02:25:37 -0700 (PDT)
Received: from [10.0.6.199] ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003a8434530bbsm6305484wme.13.2022.09.30.02.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:25:36 -0700 (PDT)
Message-ID: <da9fddaa-2329-c91b-a89d-c998c5720917@redhat.com>
Date:   Fri, 30 Sep 2022 11:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/ssd130x: Iterate over damage clips instead of using a
 merged rect
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220930080123.2441629-1-javierm@redhat.com>
 <a72d4736-74e1-1485-e952-f39909d94fbc@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a72d4736-74e1-1485-e952-f39909d94fbc@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks a lot for your feedback.

On 9/30/22 10:26, Thomas Zimmermann wrote:
> Hi
> 
> Am 30.09.22 um 10:01 schrieb Javier Martinez Canillas:
>> The drm_atomic_helper_damage_merged() helper merges all the damage clips
>> into one rectangle. If there are multiple damage clips that aren't close
>> to each other, the resulting rectangle could be quite big.
>>
>> Instead of using that function helper, iterate over all the damage clips
>> and update them one by one.
>>
>> Suggested-by: Jocelyn Falempe <jfalempe@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/gpu/drm/solomon/ssd130x.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
>> index bc41a5ae810a..2428f1813a8d 100644
>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -578,21 +578,23 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
>>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>> +	struct drm_atomic_helper_damage_iter iter;
>>   	struct drm_device *drm = plane->dev;
>> -	struct drm_rect src_clip, dst_clip;
>> +	struct drm_rect dst_clip;
>> +	struct drm_rect damage;
>>   	int idx;
>>   
>> -	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &src_clip))
>> -		return;
>> -
>>   	dst_clip = plane_state->dst;
>> -	if (!drm_rect_intersect(&dst_clip, &src_clip))
>> -		return;
>> -
>>   	if (!drm_dev_enter(drm, &idx))
>>   		return;
>>   
>> -	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
>> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
>> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
>> +		if (!drm_rect_intersect(&dst_clip, &damage))
>> +			continue;
> 
> dst_clip will be overwritten here. So need to init it within the loop first.
> 

Oh, indeed. I'll move it inside the loop. Thanks for catching this.

>> +
>> +		ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &damage);
> 
> In simpledrm, we adjust the destination address with dst_clip like this:
> 
>    iosys_map_incr(&dst, drm_fb_clip_offset(sdev->pitch, sdev->format, 
> &dst_clip));
> 
> How does this work in ssd130x? You never use dst_clip to adjust to the 
> changed location. Won't you have out-of-bounds writes on the device?
> 

Right, in ssd130x what I do is:

static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_map *vmap,
				struct drm_rect *rect)
{
	struct iosys_map dst;
...
	u8 *buf = NULL;
...
	buf = kcalloc(dst_pitch, drm_rect_height(rect), GFP_KERNEL);
...
	iosys_map_set_vaddr(&dst, buf);
	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect);
...
	ssd130x_update_rect(ssd130x, buf, rect);
}

I understand that's correct too?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

