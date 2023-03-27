Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8656CA55A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0NP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088CC1985
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679922911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjDKvnE/0RHI26sM+GFJ8N/AK61ziZWVPRz/BZ4LSd4=;
        b=aQtu7mzgPiegXxjv1txJ/ExqUTS+zI7uRietA7uCRGuaPUVD1KjZzMYfnTClgZkVBHVTyC
        29Z21Jj5O2+FZR0I49o6Rwfl55qsj/tqAzj2KPQytTth/lk5jz4ipqqNMEBGvuhnf7O4uh
        F/wKKgAtCwHciHEtXr+AgOShj2lr4Rg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-gCQmaKhpPF-SnwmpFjt7XQ-1; Mon, 27 Mar 2023 09:15:09 -0400
X-MC-Unique: gCQmaKhpPF-SnwmpFjt7XQ-1
Received: by mail-ed1-f69.google.com with SMTP id k30-20020a50ce5e000000b00500544ebfb1so12526400edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjDKvnE/0RHI26sM+GFJ8N/AK61ziZWVPRz/BZ4LSd4=;
        b=AOhFcerD+YLj1edZh06CiY83iLvkcWQLaF0sGOlCArdVBEcAWMZ9y2uNpCmorqUVUR
         qdhxk4K9zkgQhhh4uY1zaeaI4A6Wz3bLsEZXBlwq97Id9k0cMiF5FvCuW4mK8paeWJoz
         c9PsRnsAf43vnEvs/OTnZoyJyzeZtk+pAccWBRdFWU6uBYOt+MDqRW2fi87MGanI3FwW
         rxOQPUzcqqT2aBwhOr1RMQ10r8yodjUgCd0wRPTJG5xWHTySoWcrfpbmEV8l2DBc26JR
         y+wB4rJuieuOa7KIFMbZRbepWBVYsYjuPoNBpc8f8+pNl+Arn6N0c70jBRae62Ttj0xk
         n8fA==
X-Gm-Message-State: AAQBX9cbeX+cOqxqnWze+pxfpODgRnN7ft28DQKnz7N4xa8pLgWEhFol
        uJ4EKjY/aRyFvZDq/wfU/cU2vHADNpVMWOkhXhQcv11itcmc2GgdE/hu/m6AIRrd9GXqZN1Qly+
        RW5crU8xwWVY7edgq9F++B329
X-Received: by 2002:a17:907:2d29:b0:8fa:b2b:9de with SMTP id gs41-20020a1709072d2900b008fa0b2b09demr16265424ejc.25.1679922908540;
        Mon, 27 Mar 2023 06:15:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZUPwajKVZT22VocG9iPAcAPmPkfXZkFy2dSGhm2syf6WG8CTfO9Fo4Lh9dXbaK1t7H2CvYZg==
X-Received: by 2002:a17:907:2d29:b0:8fa:b2b:9de with SMTP id gs41-20020a1709072d2900b008fa0b2b09demr16265400ejc.25.1679922908282;
        Mon, 27 Mar 2023 06:15:08 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709062bcc00b0093034e71b94sm13963031ejg.65.2023.03.27.06.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:15:07 -0700 (PDT)
Message-ID: <dc1ba9f1-549f-ef27-6a49-e288d41893d2@redhat.com>
Date:   Mon, 27 Mar 2023 15:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RFC] platform/x86: gigabyte-wmi: remove allowlist
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230325-gigabyte-wmi-unrestrict-v1-1-23771309a4d3@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230325-gigabyte-wmi-unrestrict-v1-1-23771309a4d3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 3/25/23 17:48, Thomas Weißschuh wrote:
> Having to maintain a per-system allowlist is burdensome and confusing
> for users, drop it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> 
> I propose to keep this in -next for two cycles or so to make sure it
> does not break anything.

I think dropping this is a good idea (given the current experience with
the driver), but keeping the dropping of the list in -next for 2 cycles
is somewhat tricky. Normally once the final e.g. 6.3 is released I take
the pdx86/for-next branch *as-is* and use that to send a pull-req to
Linus, so that Linus gets send a hash which has been tested in linux-next
for a while before sending it to him.

Dropping this patch at that point would mean generating a new hash,
which is a bit meh. I can do that but I would prefer to just limit
testing to 1 full cycle.

Maybe you can send me a non RFC version of this patch once 6.4-rc1 is out?
Then I can add that to for-next right away and then we can get a full
cycle of -next testing that way.

Would that work for you?

Regards,

Hans



> ---
>  drivers/platform/x86/gigabyte-wmi.c | 40 -------------------------------------
>  1 file changed, 40 deletions(-)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 322cfaeda17b..b0338f043416 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -13,10 +13,6 @@
>  #define GIGABYTE_WMI_GUID	"DEADBEEF-2001-0000-00A0-C90629100000"
>  #define NUM_TEMPERATURE_SENSORS	6
>  
> -static bool force_load;
> -module_param(force_load, bool, 0444);
> -MODULE_PARM_DESC(force_load, "Force loading on unknown platform");
> -
>  static u8 usable_sensors_mask;
>  
>  enum gigabyte_wmi_commandtype {
> @@ -133,46 +129,10 @@ static u8 gigabyte_wmi_detect_sensor_usability(struct wmi_device *wdev)
>  	return r;
>  }
>  
> -#define DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME(name) \
> -	{ .matches = { \
> -		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."), \
> -		DMI_EXACT_MATCH(DMI_BOARD_NAME, name), \
> -	}}
> -
> -static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M DS3H-CF"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M DS3H WIFI-CF"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M S2H V2"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE AX V2"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE V2"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 GAMING X V2"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550I AORUS PRO AX"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z490 AORUS ELITE AC"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE WIFI"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO WIFI"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z690M AORUS ELITE AX DDR4"),
> -	{ }
> -};
> -
>  static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *context)
>  {
>  	struct device *hwmon_dev;
>  
> -	if (!dmi_check_system(gigabyte_wmi_known_working_platforms)) {
> -		if (!force_load)
> -			return -ENODEV;
> -		dev_warn(&wdev->dev, "Forcing load on unknown platform");
> -	}
> -
>  	usable_sensors_mask = gigabyte_wmi_detect_sensor_usability(wdev);
>  	if (!usable_sensors_mask) {
>  		dev_info(&wdev->dev, "No temperature sensors usable");
> 
> ---
> base-commit: 65aca32efdcb0965502d3db2f1fa33838c070952
> change-id: 20230325-gigabyte-wmi-unrestrict-7244320c1996
> 
> Best regards,

