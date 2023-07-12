Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097F974FF95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGLGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGLGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:44:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 331921996
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:44:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4493E2F4;
        Tue, 11 Jul 2023 23:45:23 -0700 (PDT)
Received: from [10.163.48.19] (unknown [10.163.48.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 748583F67D;
        Tue, 11 Jul 2023 23:44:39 -0700 (PDT)
Message-ID: <a6f6731b-9478-b91d-f4ce-aa018fb44d7b@arm.com>
Date:   Wed, 12 Jul 2023 12:14:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] drm/arm/komeda: Remove component framework and add a
 simple encoder
Content-Language: en-US
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, daniel@ffwll.ch
References: <20230704163454.5138-1-faiz.abbas@arm.com>
 <ZKWk3YkM7jI304uv@e110455-lin.cambridge.arm.com>
From:   Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>
In-Reply-To: <ZKWk3YkM7jI304uv@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On 7/5/2023 10:44 PM, Liviu Dudau wrote:
> Hi Faiz,
> 
> On Tue, Jul 04, 2023 at 10:04:54PM +0530, Faiz Abbas wrote:
>> The Komeda driver always expects the remote connector node to initialize
>> an encoder. It uses the component aggregator framework which consists
>> of component->bind() calls used to initialize the remote encoder and attach
>> it to the crtc. This makes it incompatible with connector drivers which
>> implement drm_bridge APIs.
>>
>> Remove all component framework calls from the komeda driver and declare and
>> attach an encoder inside komeda_crtc_add().
>>
>> The remote connector driver has to implement the DRM bridge APIs which
>> can be used to glue the encoder to the remote connector. Since we
>> usually pair this with a component encoder that also implements a
>> drm_bridge, dropping support is not expected to affect users of this
>> driver.
> 
> Thanks for updating the commit description, I think it shows the intent better.
> 
> When I'm trying to apply your patch to drm-misc next (or any branch that matters)
> it fails because ...
> 
>>
>> Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
>> ---
>>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 23 +++++++-
>>  .../gpu/drm/arm/display/komeda/komeda_drv.c   | 57 ++-----------------
>>  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 10 +---
>>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
>>  4 files changed, 32 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> index 4cc07d6bb9d82..e5a8a80b173f4 100644
>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> @@ -13,6 +13,8 @@
>>  #include <drm/drm_crtc_helper.h>
> 
> ... this line is different in my tree. It looks like your tree is missing
> commit e3b63718827880 ("drm/arm/komeda: Remove unnecessary include
> statements for drm_crtc_helper.h"), which has been applied in early January.
> 


Right. Let me rebase to drm-misc-next and send another version.

Thanks,
Faiz
