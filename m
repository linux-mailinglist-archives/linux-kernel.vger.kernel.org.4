Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E815F0A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiI3LcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiI3Lbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B97A52F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664536942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIY8LT1ugRWlfKqWsvrTNSHb2e7mEKJMdmnnIobz0+0=;
        b=OrMFcUBFyCtUhFQqyIuujI2PQvyh0Zpzq5k0r5JwO+PbotsPnaQVJrW6kyD8nXtCYQizJV
        KkkVMjF9ltlyKgJC3W98bs6AbAioyvrzJntJD9iQPuroZPYRFYsDiQc+CXO46flD/+22DC
        qgxAqTH7T8+nZcB5w7vsaDey1l01KTE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-7-BF2EndMcKQXibQOLtGzQ-1; Fri, 30 Sep 2022 07:22:19 -0400
X-MC-Unique: 7-BF2EndMcKQXibQOLtGzQ-1
Received: by mail-wm1-f71.google.com with SMTP id v130-20020a1cac88000000b003b56eabdf04so3244516wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NIY8LT1ugRWlfKqWsvrTNSHb2e7mEKJMdmnnIobz0+0=;
        b=V9A7wLfH6r3wfvWC9guWuPGig+ThIG6o35CrzA8qpAU0Gd9Hp8c2q+DrTEaxOnU9db
         Y0IYPIkvVxi6Cgp7ApQUP/LnVjjPm7nQaWfgDQOFLE3Gz3WQ3rGt4dsi8NuvSYHH793A
         CkUceV/JEhQYwF7naH0y9ZjoIg2i1/iIegzlUf9Eu2LGRkF/WorLIjuBLfSJ2oeIWD4H
         D5ArSOiAj4SQqKi6A+aFXVKJaFSVh/5vNafFgJyM0tHUJvMrSixvrCYh2dYRktOS9TOn
         ai65fRJ8eW/cLY6p0R7j3eac5smJ2p1JOIwkDV39d/1rNaIrOWkb1MkQwELMgjAoBNdY
         A6rA==
X-Gm-Message-State: ACrzQf2HQD4xPX1M3EANkKbGJ9DbFdUHdlTT580N1Ejr+GrZ721WDTKb
        qVP6caF1+gSc/3MEE9kQSpNzVhFWC5gEddQXUnT6ePqB1NkCfhstFAPbGEJ/979VpADN72R3uqG
        3Cr5Q+knJe+W6bhHdzrtKznCZ
X-Received: by 2002:a05:600c:221a:b0:3b4:75b8:3f7f with SMTP id z26-20020a05600c221a00b003b475b83f7fmr5389153wml.175.1664536938344;
        Fri, 30 Sep 2022 04:22:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6eh4/mcd2KYdSDOHHgpKNlEvirzPAZUgKCO+3PZhxJKjfyP3Jmv5uSx5Dz7KM57sx+HtZzsg==
X-Received: by 2002:a05:600c:221a:b0:3b4:75b8:3f7f with SMTP id z26-20020a05600c221a00b003b475b83f7fmr5389141wml.175.1664536938143;
        Fri, 30 Sep 2022 04:22:18 -0700 (PDT)
Received: from [172.20.10.4] ([84.78.249.224])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b003b4f86b31dfsm6438527wmo.33.2022.09.30.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 04:22:17 -0700 (PDT)
Message-ID: <79e665bb-c51a-0ac1-3f2f-f0e5eba22388@redhat.com>
Date:   Fri, 30 Sep 2022 13:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/ssd130x: Iterate over damage clips instead of using a
 merged rect
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        dri-devel@lists.freedesktop.org
References: <20220930080123.2441629-1-javierm@redhat.com>
 <a72d4736-74e1-1485-e952-f39909d94fbc@suse.de>
 <da9fddaa-2329-c91b-a89d-c998c5720917@redhat.com>
 <65fd4526-f223-d425-3e69-04fe5485c87c@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <65fd4526-f223-d425-3e69-04fe5485c87c@suse.de>
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

On 9/30/22 12:11, Thomas Zimmermann wrote:

[...]

>>
>>>> +
>>>> +		ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &damage);
>>>
>>> In simpledrm, we adjust the destination address with dst_clip like this:
>>>
>>>     iosys_map_incr(&dst, drm_fb_clip_offset(sdev->pitch, sdev->format,
>>> &dst_clip));
>>>
>>> How does this work in ssd130x? You never use dst_clip to adjust to the
>>> changed location. Won't you have out-of-bounds writes on the device?
>>>
>>
>> Right, in ssd130x what I do is:
>>
>> static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_map *vmap,
>> 				struct drm_rect *rect)
>> {
>> 	struct iosys_map dst;
>> ...
>> 	u8 *buf = NULL;
>> ...
>> 	buf = kcalloc(dst_pitch, drm_rect_height(rect), GFP_KERNEL);
>> ...
>> 	iosys_map_set_vaddr(&dst, buf);
>> 	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect);
>> ...
>> 	ssd130x_update_rect(ssd130x, buf, rect);
>> }
>>
>> I understand that's correct too?
> 
>  From what I understand about ssd130x, blit_rect looks correct up to the 
> call to update_rect.  The values in the rect parameter are for the 
> damage area of the plane. In update_rect, the destination coords x and y 
> are also taken from rect. But they should come from dst_clip, which is 
> the on-screen location. Does that make sense?
> 

I believe you are correct. Then what I should do is to not pass the damage
area to ssd130x_fb_blit_rect() as the struct drm_rect argument but instead
the dst_clip as filled by drm_rect_intersect(). Does that sound correct ?

In other words, the following:

	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
	drm_atomic_for_each_plane_damage(&iter, &damage) {
		dst_clip = plane_state->dst;
		if (!drm_rect_intersect(&dst_clip, &damage))
			continue;

		ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
	}

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

