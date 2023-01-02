Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9640D65B6CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjABTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjABTAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3FD84
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672685986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WOPN/LK/WXz6Ghsv8Bn+UnAhtmBnvTXnzOz5HK8Rlk=;
        b=N2sB0SVMZGIVcxRiu3azSpn5hmGVTX4MP+xqKBxb8a6UeMjgVtnRREYLHC+nfAtPHVFeGO
        FAEhvI0IkrYVfQB3C8T2IsU8vfJ6mYhqNy0Q47tUb8kr6kXN/4uRKDq/AQC8xrw9aHAJ+D
        LhtLBQW+lkYbtO7Ywci2XdU+jUHJXmg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-cAVGKvqdPwyP2ntDPSbuOw-1; Mon, 02 Jan 2023 13:59:40 -0500
X-MC-Unique: cAVGKvqdPwyP2ntDPSbuOw-1
Received: by mail-wm1-f71.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so18868728wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 10:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WOPN/LK/WXz6Ghsv8Bn+UnAhtmBnvTXnzOz5HK8Rlk=;
        b=P1Su6O7ZqqK2EEJtRVw9aLRisFk28QAwFQmloUGajglDmJMeY1xO9K/EN+g0NlNSVy
         Ody/A/zcG3gD4uNZWpcFL0tbKb0Zg/L9co9ukMtOFalLyPOhyN8aLMAxBqZg6R22ukTp
         +Sv1LOdzBfoM5lZOQ7gctZT3WJtzTgHt8uJY8zHc/pH45tISaeTzNkBEMfR+Opv0BNdV
         C8fUyRskMA5ZGSw5k7kJb8fc4gnfdbIRKf1ImfaQgTS5oFfSc3AiMq9aRSnYHZzMKgJL
         Jhq1T1E+opwG2ie6V0ukJfG+/oH7d5iUVFQLQCnZdd+NCiOD7b5lXeS1FwDayrXZH1wN
         WgnQ==
X-Gm-Message-State: AFqh2kqsVvSQ2SIr8G9Clqu93FmaPNB9P3YQA8qOP1TrB1wUv+YCwk1D
        grAwx3k0vG4+kt4tC/A/h6HYRfZLz/8GzQmSBIo6Dyc7qFXzBFA4FiI32Xrh3ZVsKQNV/OFGGaZ
        hTe5acadSV8OhRwQ2Zw0BItmc
X-Received: by 2002:a05:600c:1c9d:b0:3d1:f3eb:c718 with SMTP id k29-20020a05600c1c9d00b003d1f3ebc718mr36368381wms.19.1672685978893;
        Mon, 02 Jan 2023 10:59:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtY7ieM99CQJWNJHqwEx3e+hU/MU5mpbx0U8M5qHx6VgaHdqWH0s9s0pCZ5kSIUjOcd5tCbcw==
X-Received: by 2002:a05:600c:1c9d:b0:3d1:f3eb:c718 with SMTP id k29-20020a05600c1c9d00b003d1f3ebc718mr36368375wms.19.1672685978701;
        Mon, 02 Jan 2023 10:59:38 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003d96c811d6dsm41003934wmq.30.2023.01.02.10.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 10:59:38 -0800 (PST)
Message-ID: <8de738ef-588b-1c59-6e97-c0277eb313b1@redhat.com>
Date:   Mon, 2 Jan 2023 19:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/14] drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-2-javierm@redhat.com> <Y7MkzucDEdsYenqX@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y7MkzucDEdsYenqX@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

Thanks a lot for your feedback.

On 1/2/23 19:39, Sam Ravnborg wrote:
> Hi Javier.
> 
> On Wed, Dec 28, 2022 at 02:47:44AM +0100, Javier Martinez Canillas wrote:
>> Many panel drivers define dsi_dcs_write_seq() and dsi_generic_write_seq()
>> macros to send DCS commands and generic write packets respectively, with
>> the payload specified as a list of parameters instead of using arrays.
>>
>> There's already a macro for the former, introduced by commit 2a9e9daf75231
>> ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro") so drivers can be
>> changed to use that. But there isn't one yet for the latter, let's add it.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>  include/drm/drm_mipi_dsi.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
>> index 20b21b577dea..c7c458131ba1 100644
>> --- a/include/drm/drm_mipi_dsi.h
>> +++ b/include/drm/drm_mipi_dsi.h
>> @@ -297,6 +297,22 @@ int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
>>  int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>>  					u16 *brightness);
>>  
>> +/**
>> + * mipi_dsi_generic_write - transmit data using a generic write packet
> s/mipi_dsi_generic_write/mipi_dsi_generic_write_seq
> (As the bot also reported)
> 

Ups, sorry for missing that.

> with this fixed:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>

Thanks!
 
>> + * @dsi: DSI peripheral device
>> + * @seq: buffer containing the payload
>> + */
>> +#define mipi_dsi_generic_write_seq(dsi, seq...) do {				\
>> +		static const u8 d[] = { seq };					\
>> +		struct device *dev = &dsi->dev;	\
>> +		int ret;						\
>> +		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
>> +		if (ret < 0) {						\
>> +			dev_err_ratelimited(dev, "transmit data failed: %d\n", ret); \
>> +			return ret;						\
>> +		}						\
>> +	} while (0)
>> +
> (If you align '\' under each other it would be nicer, but I could see
> that mipi_dsi_dcs_write_seq() do not do so).

Yeah, I was actually thinking about doing like you suggested for this macro
but preferred to keep it consistent with the existing mipi_dsi_dcs_write_seq()
macro definition...

Maybe I can add a preparatory patch that just fixes the backslash characters
indent for mipi_dsi_dcs_write_seq() to be all aligned?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

