Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB555B61E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiILTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2B24BE3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663012230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0YHTFiHmCMOhY8jwxABxa5BgJfL6gkhs2YD6OMTr1g=;
        b=UvxJtnvAoyeymMb8UqjiICkPlXAWzZb5rkj1nEwlxCld5HMvK6g8haxH9WN4YngGdUMZjx
        WlO/RGM48c9BmdjsyB8C8AwOgK9YCvSDZgbEjodkx9V8/1V+hH/iYsZRyRBHjzCkeTOYBg
        3rXRgz8J424zAIpDv2HMZRv40ezTNkk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-xVVHT6r_PIaNf-qChoNBzg-1; Mon, 12 Sep 2022 15:50:29 -0400
X-MC-Unique: xVVHT6r_PIaNf-qChoNBzg-1
Received: by mail-ej1-f70.google.com with SMTP id sh44-20020a1709076eac00b00741a01e2aafso3725408ejc.22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=w0YHTFiHmCMOhY8jwxABxa5BgJfL6gkhs2YD6OMTr1g=;
        b=65TEXnUCqHR2C94kLyKVRFO/8Cf9gESo5igfXEqQDoIEv+sHiFfk8r+g+sYjJP28jq
         iFVG+n5E5JkuysdaOQY/E67HCQ3dzoaeufsmLnTWqnWzCRAiNooCluxlfMcrbz4q6rPG
         1INDs8x8d8E7cLbPGu0JAV8NkPVfOzs6F2WQD9N57875l5A0G/U3F81xRsy8yeCeFRuY
         KnH77YLqMsPFlPRbAaqgH9FQ14SeSdotl2bC9h71q2N2P93BdiN3rPqVRZe4atTTiQLK
         pbDvIddQLXwRdC+A7kFNW4zX/PH3BmGuLvI0cOmkmXnfqzQpxKN6Mh8T39ryhLya/Snc
         dagA==
X-Gm-Message-State: ACgBeo3HqGmRki3Pwz5TGpieSbhSE71gkENWRee1WrMh1bCYe4Ob2G/m
        +o9/JhXUT6P0UdgGn4LvPrAx//5LkZItiePSjEIdbLkKj/Inynb7szmBF01OBe5pR/HG7BYJqlg
        Vj43MKi5Z8DhNFjQ9K0aWW09d
X-Received: by 2002:a05:6402:3485:b0:451:f615:321f with SMTP id v5-20020a056402348500b00451f615321fmr3394892edc.65.1663012228294;
        Mon, 12 Sep 2022 12:50:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4XL9fTgyaRKc9Ofbmv7caRrEgXhMgt6F/fC9gah/5BqD0T4QwTibDWloQvf5gK3w7wJXiFQA==
X-Received: by 2002:a05:6402:3485:b0:451:f615:321f with SMTP id v5-20020a056402348500b00451f615321fmr3394881edc.65.1663012228134;
        Mon, 12 Sep 2022 12:50:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906210900b007767c82acc6sm4841512ejt.151.2022.09.12.12.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 12:50:27 -0700 (PDT)
Message-ID: <dc472070-34a8-93e1-2ca3-4847c49f12eb@redhat.com>
Date:   Mon, 12 Sep 2022 21:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND drm-misc-next 4/7] drm/arm/hdlcd: plane: use drm
 managed resources
Content-Language: en-US
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220905152719.128539-1-dakr@redhat.com>
 <20220905152719.128539-5-dakr@redhat.com>
 <Yx9uAe//u/Z9zfmM@e110455-lin.cambridge.arm.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Yx9uAe//u/Z9zfmM@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

Thanks for having a look!

This is not about this patch, it's about patch 3/7 "drm/arm/hdlcd: crtc: 
use drmm_crtc_init_with_planes()".

And there it's the other way around. When using 
drmm_crtc_init_with_planes() we shouldn't have a destroy hook in place, 
that's the whole purpose of drmm_crtc_init_with_planes().

We should just drop patch 3/7 "drm/arm/hdlcd: crtc: use 
drmm_crtc_init_with_planes()", it's wrong.

Do you want me to send a v2 for that?

- Danilo



On 9/12/22 19:36, Liviu Dudau wrote:
> Hi Danilo,
> 
> I have applied your patch series for HDLCD on top of drm-next (commit 213cb76ddc8b)
> and on start up I get a warning:
> 
> [   12.882554] hdlcd 7ff50000.hdlcd: drm_WARN_ON(funcs && funcs->destroy)
> [   12.882596] WARNING: CPU: 1 PID: 211 at drivers/gpu/drm/drm_crtc.c:393 __drmm_crtc_init_with_planes+0x70/0xf0 [drm]
> 
> It looks like the .destroy hook is still required or I'm missing some other required
> series where the WARN has been removed?
> 
> Best regards,
> Liviu
> 
> On Mon, Sep 05, 2022 at 05:27:16PM +0200, Danilo Krummrich wrote:
>> Use drm managed resource allocation (drmm_universal_plane_alloc()) in
>> order to get rid of the explicit destroy hook in struct drm_plane_funcs.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/arm/hdlcd_crtc.c | 20 +++++++-------------
>>   1 file changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
>> index c0a5ca7f578a..17d3ccf12245 100644
>> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
>> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
>> @@ -289,7 +289,6 @@ static const struct drm_plane_helper_funcs hdlcd_plane_helper_funcs = {
>>   static const struct drm_plane_funcs hdlcd_plane_funcs = {
>>   	.update_plane		= drm_atomic_helper_update_plane,
>>   	.disable_plane		= drm_atomic_helper_disable_plane,
>> -	.destroy		= drm_plane_cleanup,
>>   	.reset			= drm_atomic_helper_plane_reset,
>>   	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>>   	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
>> @@ -297,24 +296,19 @@ static const struct drm_plane_funcs hdlcd_plane_funcs = {
>>   
>>   static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
>>   {
>> -	struct hdlcd_drm_private *hdlcd = drm->dev_private;
>> +	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
>>   	struct drm_plane *plane = NULL;
>>   	u32 formats[ARRAY_SIZE(supported_formats)], i;
>> -	int ret;
>> -
>> -	plane = devm_kzalloc(drm->dev, sizeof(*plane), GFP_KERNEL);
>> -	if (!plane)
>> -		return ERR_PTR(-ENOMEM);
>>   
>>   	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
>>   		formats[i] = supported_formats[i].fourcc;
>>   
>> -	ret = drm_universal_plane_init(drm, plane, 0xff, &hdlcd_plane_funcs,
>> -				       formats, ARRAY_SIZE(formats),
>> -				       NULL,
>> -				       DRM_PLANE_TYPE_PRIMARY, NULL);
>> -	if (ret)
>> -		return ERR_PTR(ret);
>> +	plane = drmm_universal_plane_alloc(drm, struct drm_plane, dev, 0xff,
>> +					   &hdlcd_plane_funcs,
>> +					   formats, ARRAY_SIZE(formats),
>> +					   NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
>> +	if (IS_ERR(plane))
>> +		return plane;
>>   
>>   	drm_plane_helper_add(plane, &hdlcd_plane_helper_funcs);
>>   	hdlcd->plane = plane;
>> -- 
>> 2.37.2
>>
> 

