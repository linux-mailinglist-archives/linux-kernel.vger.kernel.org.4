Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6634613107
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJaHFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJaHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:05:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B4BF65;
        Mon, 31 Oct 2022 00:05:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k2so27148048ejr.2;
        Mon, 31 Oct 2022 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK+jHrm2hYBv9wkKb/abfad11zivk5bW9tGF3VlFq3U=;
        b=BF79z0RZ0XhmibTMUspbagzzogRc4h6z8LD4vJ4Ix2hxDMQCGaMocNIY91+V8P1A0B
         qPp2sDSgJU23nVb3fzmGOi4eJg+Zt3Q/ktUU80yNkhWG7n841CoJtro3Ko47SmLkfWA9
         rhIdd6MfM7YIdUx2XwwUQqEr01cXmlLLlXqLi3NrLHWA9cTPzBAwwOmuasgceETeFVeL
         OHA1yNxeoIYM6vIEU2DaOZQQ6UVAJesF9sLaECKlwbs/N3yy8XvbMk3mI8+ehkDPPGjC
         LEkO9E1rAoOGafBldh9CVTNZalEwxr/kwTnoRF7Ngu3XCefcaNiJ4dVXIXnJuaNm0UuP
         AmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MK+jHrm2hYBv9wkKb/abfad11zivk5bW9tGF3VlFq3U=;
        b=1NkpOPhV0+l6E/xgQXUi+u0hlhcdiEorOd1BcPrMQUqYCjSVClJpwENDPCYcbtSpFq
         I3sxvCwKl+RV/dGwwLRD1JmC9u25xh8d1FKmAUUgZEeY8WLPUHi4047jELlBxoWnzZBR
         XPDwLCQ7cv038JkNOd89QkMABHpysGSmCfpohgvYB00s5Xrwzx0ur0hmSZs4ntbfv/4e
         KuP4mXqHSpUYZ4YAS/acQNRA+DA6o/7dVqZd6YAO6wsO2W6w4aPI/ZxCgloMjFyQi2vk
         6UdKykVNXx89UfmRHAbPVUTExLAS3wW/dQob2gfsDZgOthYfKoLz8b/I3kwD01ZDZTGM
         L9Lg==
X-Gm-Message-State: ACrzQf2CvsulZwygudvxI21a53pEEPsTwAkBH0nlYNx7EBGDprAKkNwS
        TwNj4DTW3sjqhc9bTnlIsuE=
X-Google-Smtp-Source: AMsMyM55cWpX9uDMf1Dtg2wvjWJa+matOOOcle0zhukTPrtjubcellBbE3vWh1bUoXR0HqNmFaOC5w==
X-Received: by 2002:a17:907:25c5:b0:782:978d:c3da with SMTP id ae5-20020a17090725c500b00782978dc3damr11009394ejc.623.1667199912488;
        Mon, 31 Oct 2022 00:05:12 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id gg6-20020a170906e28600b007ad2da5668csm2651759ejb.112.2022.10.31.00.05.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 00:05:11 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
To:     "H. Nikolaus Schaller" <hns@goldelico.com>, tony@atomide.com
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <4B3F8E50-3472-4AED-9A77-3E265DF8C928@goldelico.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <0000784a-ae89-1081-0ec7-fc77d3381545@gmail.com>
Date:   Mon, 31 Oct 2022 09:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4B3F8E50-3472-4AED-9A77-3E265DF8C928@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Nikolaus,

On 31.10.22 г. 0:08 ч., H. Nikolaus Schaller wrote:
> Hi Ivaylo,
> 
> it took a while until I found time to test newer kernels (mainline + Letux additions)
> on the OMAP5 Pyra but unfortunately I did not get screen display for v6.1. Even worse,
> the console was flooded by

Could you elaborate on that - do you have anything on the display 
(during boot or dunno). Do you have simplefb enabled, so boot log to be 
visible on the display? Is that wayland you are trying to run? Do you 
have PVR driver enabled? Did you try to boot vanilla kernel?

> 
> [   39.419846] WARNING: CPU: 0 PID: 3673 at drivers/bus/omap_l3_noc.c:139 l3_interrupt_handler+0x23c/0x330
> [   39.429914] 44000000.l3-noc:L3 Custom Error: MASTER MPU TARGET GPMC (Idle): Data Access in Supervisor mode during Functional access
> ...
> 

I have no idea what that error is supposed to mean. @Tony?

> making the system unuseable.
> 
> After doing some manual bisect by installing different kernel versions on the boot SD card,
> I was able to identify that it crept in between v5.18 and v5.19-rc1. A git bisect on this
> range (adding Letux patches on top of each bisect base) did reveal this patch as the first bad one.
> 
> After reverting it seems as if I can use any v5.19 .. v6.1-rc2 kernel without issues.
> 
> Now I wonder why this patch breaks my system?
> 

A wild guess - omap5 has some cache issues (as is visible from 
7cb0d6c17b96b8bf3c25de2dfde4fdeb9191f4c3), which lead to the above. 
Before the patch *all* access to the BO backing memory was done through 
TILER/DMM, mitigating the issue. After the patch, whoever tries to 
render to non-scanout buffer is doing it directly to the memory, causing 
the issue.

Another possibility - someone assumes that memory is always linear, 
which is true when it is accessed through DMM, but it is not after the 
patch. Do you have my "drm: pvrsgx: dmabuf import - Do not assume 
scatterlist memory is contiguous" patch in your PVR driver? Maybe there 
is another driver that lacks similar patch.

Regards,
Ivo

> BR and thanks,
> Nikolaus
> 
> 
>> Am 19.01.2022 um 11:23 schrieb Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>:
>>
>> On devices with DMM, all allocations are done through either DMM or TILER.
>> DMM/TILER being a limited resource means that such allocations will start
>> to fail before actual free memory is exhausted. What is even worse is that
>> with time DMM/TILER space gets fragmented to the point that even if we have
>> enough free DMM/TILER space and free memory, allocation fails because there
>> is no big enough free block in DMM/TILER space.
>>
>> Such failures can be easily observed with OMAP xorg DDX, for example -
>> starting few GUI applications (so buffers for their windows are allocated)
>> and then rotating landscape<->portrait while closing and opening new
>> windows soon results in allocation failures.
>>
>> Fix that by mapping buffers through DMM/TILER only when really needed,
>> like, for scanout buffers.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
>> drivers/gpu/drm/omapdrm/omap_gem.c | 12 ++++++++----
>> 1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
>> index 41c1a6d..cf57179 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
>> @@ -821,10 +821,12 @@ int omap_gem_pin(struct drm_gem_object *obj, dma_addr_t *dma_addr)
>> 			if (ret)
>> 				goto fail;
>>
>> -			if (priv->has_dmm) {
>> -				ret = omap_gem_pin_tiler(obj);
>> -				if (ret)
>> -					goto fail;
>> +			if (omap_obj->flags & OMAP_BO_SCANOUT) {
>> +				if (priv->has_dmm) {
>> +					ret = omap_gem_pin_tiler(obj);
>> +					if (ret)
>> +						goto fail;
>> +				}
>> 			}
>> 		} else {
>> 			refcount_inc(&omap_obj->pin_cnt);
>> @@ -861,6 +863,8 @@ static void omap_gem_unpin_locked(struct drm_gem_object *obj)
>> 			kfree(omap_obj->sgt);
>> 			omap_obj->sgt = NULL;
>> 		}
>> +		if (!(omap_obj->flags & OMAP_BO_SCANOUT))
>> +			return;
>> 		if (priv->has_dmm) {
>> 			ret = tiler_unpin(omap_obj->block);
>> 			if (ret) {
>> -- 
>> 1.9.1
>>
> 
