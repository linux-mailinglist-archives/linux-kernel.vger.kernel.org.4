Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17E723D6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjFFJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjFFJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026ECE62
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686043779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLqddK56/VOqKWL6TPavU9Pj8Wm/0NiaRm8Lo3WR5yQ=;
        b=aNiybn+sOvNSr8zk92E2kWYOgzmx7XtA306qilLXjeHpEzI8jPn2V+ySJRiUQCl51BMWgd
        189aeF0MSYjMr3760NU7wMH6s7mB4d7fXn1SoowkBFYemRAf2PTmifcK6Iwqjdv88jYxzk
        kMBq9zA6lhHF6OwsmRjMqY3pmrjJOWw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-U_HTfStxPRSdi_sFKK067g-1; Tue, 06 Jun 2023 05:29:37 -0400
X-MC-Unique: U_HTfStxPRSdi_sFKK067g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-970e0152da7so488703466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686043777; x=1688635777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLqddK56/VOqKWL6TPavU9Pj8Wm/0NiaRm8Lo3WR5yQ=;
        b=ZUNETQ23Lr+0P1y3i1XhjeLj3kr3rYkbuzXZMdhqrPS7BR4+GlNP9dMVZl2gh1zH6y
         tqpUrKGAOBiM3QNluVAQYqCAtRaAQUP8OQMZTDhbTeYJ1hATtylPkLLjyIo9b9gxK83K
         xAfQRwIuq3v5IZ4E9bumT2H/s8SUAU0vY1JTPf6CV7LpoSyrSOchwS8YR5bCLbOAXHRb
         /qbdEz/r1/0XBKjzF4MHLblDsD/6bsZSS4xOIWCwdwryA4hdc32yO6DY+bsaYHAKNP16
         eQqV8I2rzjf8lQRayBn7AHLvlkd62feCe5DwIIvuZ15YpTS09uJN7CT8ZcKamdPlAI8W
         ub4g==
X-Gm-Message-State: AC+VfDzQnu/Q/lYtkpxqv2+c4Xt61Ve7AY15s2KMqlj1koLHpHqxQMzW
        FgD/6C8m1zk4zxvLpdfarmzXMc6N6VhtG8XWhl7ptTQBajubrRmQ3jFh+euV3oewUjIrMTjEb0y
        XIx9X5y7+57Gs8gYXPVt1yJU9
X-Received: by 2002:a17:907:2ce5:b0:973:903c:35a4 with SMTP id hz5-20020a1709072ce500b00973903c35a4mr2076547ejc.65.1686043776825;
        Tue, 06 Jun 2023 02:29:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EXRiSuEJC0Xld3SJGaWeiae6Bz2o8dNnaUNiiKbxcL4+i7TKvtpOMJda2aVlnj2nXVDZ+4A==
X-Received: by 2002:a17:907:2ce5:b0:973:903c:35a4 with SMTP id hz5-20020a1709072ce500b00973903c35a4mr2076531ejc.65.1686043776534;
        Tue, 06 Jun 2023 02:29:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b0096a742beb68sm5266459ejd.201.2023.06.06.02.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:29:35 -0700 (PDT)
Message-ID: <776f19d5-96d7-cb20-84a3-ba97bf78efb0@redhat.com>
Date:   Tue, 6 Jun 2023 11:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86:intel/pmc: Remove Meteor Lake S platform
 support
Content-Language: en-US, nl
To:     Xi Pardee <xi.pardee@intel.com>
Cc:     irenic.rajneesh@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@intel.com,
        david.e.box@linux.intel.com
References: <20230601004706.871528-1-xi.pardee@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230601004706.871528-1-xi.pardee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/1/23 02:47, Xi Pardee wrote:
> commit c5ad454a12c6 ("platform/x86: intel/pmc/core: Add Meteor Lake
> support to pmc core driver") was supposed to add support for Meter
> Lake P/M and mistakenly added support for Meteor Lake S instead. Meteor
> Lake P/M support was added later and MTL-S support needs to be removed
> since its currently assigned to the wrong register maps.
> 
> Fixes: c5ad454a12c6 ("platform/x86: intel/pmc/core: Add Meteor Lake support to pmc core driver")
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/pmc/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index da6e7206d38b..b8711330e411 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1039,7 +1039,6 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_core_init),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
> -	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          mtl_core_init),
>  	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
>  	{}
>  };

