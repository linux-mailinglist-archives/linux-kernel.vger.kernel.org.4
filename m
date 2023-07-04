Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA874733D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGDNtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGDNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:49:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBED5173F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:49:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D65614BF;
        Tue,  4 Jul 2023 06:49:51 -0700 (PDT)
Received: from [10.163.47.13] (unknown [10.163.47.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193D03F73F;
        Tue,  4 Jul 2023 06:49:06 -0700 (PDT)
Message-ID: <90f386c3-b2bb-b876-80df-c67005e89a66@arm.com>
Date:   Tue, 4 Jul 2023 19:19:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/arm/komeda: Remove component framework and add a
 simple encoder
Content-Language: en-US
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, daniel@ffwll.ch
References: <20230621084116.26882-1-faiz.abbas@arm.com>
 <ZJ1UJaNJese6g2Ia@e110455-lin.cambridge.arm.com>
From:   Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>
In-Reply-To: <ZJ1UJaNJese6g2Ia@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On 6/29/2023 3:21 PM, Liviu Dudau wrote:
> Hi Faiz,
>
> Thanks for the patch and for addressing what was at some moment on my "nice to
> improve / cleanup" list. Sorry for the delay in responding, I had to revive
> the bits of an old setup to be able to test this properly, with 2 encoders
> attached.
>
> On Wed, Jun 21, 2023 at 02:11:16PM +0530, Faiz Abbas wrote:
>> The Komeda driver always expects the remote connector node to initialize
>> an encoder. It uses the component aggregator framework which consists
>> of component->bind() calls used to initialize the remote encoder and attach
>> it to the crtc. This is different from other drm implementations which expect
>> the display driver to supply a crtc and connect an encoder to it.
> I think both approaches are valid in DRM. We don't want to remove the component
> framework because it is doing the wrong thing, but because we cannot use it
> with drivers that implement the drm_bridge API. Given that we usually pair with
> a component encoder that also implements a drm_bridge, dropping support for
> component framework should not affect the users of the driver.

Sounds good. I will update the commit message to emphasize the bridge API.

>> Remove all component framework calls from the komeda driver and declare and
>> attach an encoder inside komeda_crtc_add().
> Unfortunately you haven't removed all component framework calls. The hint for
> that is that you have not removed the #include <linux/component.h> line from
> any of the files. Specifically, komeda_kms_attach()/detach() still calls
> component_unbind_all() which will crash with your patch applied.

Good catch. Will remove that stuff in v2.

>> The remote connector driver has to implement the DRM bridge APIs which
>> can be used to glue the encoder to the remote connector.
>>
>> Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
>> ---
>>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 22 +++++++-
>>  .../gpu/drm/arm/display/komeda/komeda_drv.c   | 56 ++-----------------
>>  .../gpu/drm/arm/display/komeda/komeda_kms.c   |  4 --
>>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
>>  4 files changed, 30 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> index cea3fd5772b57..144736a69b0ee 100644
>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> @@ -12,6 +12,8 @@
>>  #include <drm/drm_atomic_helper.h>
>>  #include <drm/drm_print.h>
>>  #include <drm/drm_vblank.h>
>> +#include <drm/drm_simple_kms_helper.h>
>> +#include <drm/drm_bridge.h>
>>  
>>  #include "komeda_dev.h"
>>  #include "komeda_kms.h"
>> @@ -612,9 +614,11 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
>>  			   struct komeda_crtc *kcrtc)
>>  {
>>  	struct drm_crtc *crtc = &kcrtc->base;
>> +	struct drm_device *base = &kms->base;
>> +	struct drm_bridge *bridge;
>>  	int err;
>>  
>> -	err = drm_crtc_init_with_planes(&kms->base, crtc,
>> +	err = drm_crtc_init_with_planes(base, crtc,
>>  					get_crtc_primary(kms, kcrtc), NULL,
>>  					&komeda_crtc_funcs, NULL);
>>  	if (err)
>> @@ -626,6 +630,22 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
>>  
>>  	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
> I would move this line after the bridges are being initialised, just in case in the future
> colour management will propagate some info down to the bridges.

Sure. I'll move it down.

.

.

.

>>  };
>>  
>>  /**
>> -- 
>> 2.25.1
>>
> Code looks good and turns out swapping drm_bridge for component framework is not that painful. If you send v2
> with the comments addressed I should be able to test it now and review the patch much sooner.
>
> One issue I have observed from my testing of your patch is that on `rmmod komeda` we fail to disable the
> interrupts after drm_kms_helper_poll_fini() call in komeda_kms_detach(), then we NULL the drm->dev_private
> before we get an interrupt which causes komeda_kms_irq_handler() to access the NULL pointer. This is not
> something caused by your patch, but if you want to test module removal I think you should be aware of this.

I'll keep this in mind while testing.

Thanks,
Faiz

