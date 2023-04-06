Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234E6D9510
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjDFL1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjDFL1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:27:07 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB5872A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j9zgix9Ki2wowJU7zS2d04njTU8sE2RfJgO5J+edVo8=; b=WzfJ0ptJMnAmUN+UGQvsNO51HC
        lnSwYG/XnDXAvnfQEgOKcFoQTrivuJDC/kLPqhs6AdhGoNGDSE4XOgvt1ZW0/aAqGPeK+HmxrmwGU
        dOQ7ZeENg2TapBT9f7lVZR7BIq7cJ48pknDqm1/5+lS+z2NGluLmjvir8DHEeauwZ59TDS+SrVLQD
        vU9WXn8dpXRjN9Ey68yx7jPju6bOIr6uCLMobjPlZ/oKh9HhgsB07eSFwF+41CuciBg4w71aLX1lA
        zNcTrIylt2egc1wLV6YtwjwDSpvekd72mKCSYXl9jRmCbJfMULISS6fPNFc9PLRYkts47yJ6DerSq
        zw9sjv6Q==;
Received: from [187.36.234.139] (helo=[192.168.1.195])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pkNlf-007zxn-2F; Thu, 06 Apr 2023 13:27:03 +0200
Message-ID: <accdc804-19e7-df59-7dd3-69c83f52405d@igalia.com>
Date:   Thu, 6 Apr 2023 08:26:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] drm/vkms: Drop vkms_connector_destroy() wrapper
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Marius Vlad <marius.vlad@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230406110235.3092055-1-javierm@redhat.com>
 <20230406110235.3092055-2-javierm@redhat.com>
 <ZC6o4l7tzSIwFTKw@phenom.ffwll.local>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <ZC6o4l7tzSIwFTKw@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 08:11, Daniel Vetter wrote:
> On Thu, Apr 06, 2023 at 01:02:34PM +0200, Javier Martinez Canillas wrote:
>> This helper is just a wrapper that calls drm_connector_cleanup(), there's
>> no need to have another level of indirection.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> On both patches:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Aside, would be a nice cleanup to move vkms output stuff (crtc and
> connector) over to the drmm_ stuff. The plane already does that.

I sent a patch [1] a while ago moving the CRTC to the drmm_ functions.
If you could take a look at it, it would be great.

[1] https://lore.kernel.org/dri-devel/20230116205800.1266227-1-mcanal@igalia.com/T/

Best Regards,
- Maíra Canal

> 
> That should also simplify the multi-output work.
> -Daniel
> 
>> ---
>>
>>   drivers/gpu/drm/vkms/vkms_output.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
>> index 991857125bb4..4de6f8ae38be 100644
>> --- a/drivers/gpu/drm/vkms/vkms_output.c
>> +++ b/drivers/gpu/drm/vkms/vkms_output.c
>> @@ -6,14 +6,9 @@
>>   #include <drm/drm_probe_helper.h>
>>   #include <drm/drm_simple_kms_helper.h>
>>   
>> -static void vkms_connector_destroy(struct drm_connector *connector)
>> -{
>> -	drm_connector_cleanup(connector);
>> -}
>> -
>>   static const struct drm_connector_funcs vkms_connector_funcs = {
>>   	.fill_modes = drm_helper_probe_single_connector_modes,
>> -	.destroy = vkms_connector_destroy,
>> +	.destroy = drm_connector_cleanup,
>>   	.reset = drm_atomic_helper_connector_reset,
>>   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>> -- 
>> 2.40.0
>>
> 
