Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EE26FC39B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjEIKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjEIKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A43DC5D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683627034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9rbMiOw27xxoY1ruazr+6p4Yi/4A32mw5gbRIKxDHE=;
        b=Yrg5RJK2IxVwHo+LMT4hcffzQWN5gMdJQlDK8GS8tEWtAfLzjFhooPJqtqSB2wraPnVoHO
        ICuE5Zg7/XBLkJeBS8IgZ99SR9STJoiXsrIAOZPoKrh+40SoXn94ttRhqfXULAoYN6V7eG
        6g7d9VAkKYdGnKkAkXQvetRXPBve6Jo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-bMhmQ4K-Np2Yw_9G9QEQrw-1; Tue, 09 May 2023 06:10:31 -0400
X-MC-Unique: bMhmQ4K-Np2Yw_9G9QEQrw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50bcd245040so6739494a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627030; x=1686219030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9rbMiOw27xxoY1ruazr+6p4Yi/4A32mw5gbRIKxDHE=;
        b=X06kx8edcDdZ4e0M/Skis2CvVdYKFluyVbUMeHHC1y3GmKuzinKfEWz80xI+/ncFCe
         nGdyhWN/KrxAWqtqwHQLcuF4dE7sw9cEScXRFFfNlpxIhfMeL/+O1izTflgwgrjtrOnB
         vHDwhks5Regd1JfCTGAsCzl+WMJdhws76GFLjUg15dycGZ/+vy44nVCiZjOCQm2rmwPD
         cnqvRS1pG3FaFT/cTY2iP8UOA3xVrbt4NB9rfiAeefYzyMBojiCBlxHswkmQVHy76iFL
         ayflbVLtETzKdNpu0qpkcsDw4xn2dR7j4ZpEifVTEgXRcpXjS+WKcb04DiaUEF8wWqno
         sPUQ==
X-Gm-Message-State: AC+VfDxtpKQJ/l4hsREs9UVON5afnd9lcjl8N043eVeLu4DZ5mHasAyC
        YAdGT/69iv2Fu4Rgq3vMfOWbaYs7B+5pJQktvN0IDtnRfYInQU+Wt7LGQj9QuvJPkgz/xdr8zbx
        YDdDGIICo0LSyFtHHaTnelEDY
X-Received: by 2002:a17:907:1687:b0:958:cc8:bd55 with SMTP id hc7-20020a170907168700b009580cc8bd55mr13432899ejc.0.1683627030414;
        Tue, 09 May 2023 03:10:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6L5H0XaMCop48Y9qCUt32YMQTdXO+CiALaQzO0nKyF70CRxQga8SxiF1NWf9ZOzT2uoVWyzw==
X-Received: by 2002:a17:907:1687:b0:958:cc8:bd55 with SMTP id hc7-20020a170907168700b009580cc8bd55mr13432869ejc.0.1683627030030;
        Tue, 09 May 2023 03:10:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v3-20020aa7d803000000b0050d83a39e6fsm600303edq.4.2023.05.09.03.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 03:10:29 -0700 (PDT)
Message-ID: <5ae4e14f-bac3-3107-160e-c0856b0abdeb@redhat.com>
Date:   Tue, 9 May 2023 12:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] platform/x86: gigabyte-wmi: remove allowlist
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230325-gigabyte-wmi-unrestrict-v2-1-0a54bc8e70d2@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230325-gigabyte-wmi-unrestrict-v2-1-0a54bc8e70d2@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/7/23 22:45, Thomas Weißschuh wrote:
> Having to maintain a per-system allowlist is burdensome and confusing
> for users, drop it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

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
> Changes in v2:
> - Rebase on 6.4-rc1
> - Remove RFC status
> - Drop #include <linux/dmi.h>
> - Link to v1: https://lore.kernel.org/r/20230325-gigabyte-wmi-unrestrict-v1-1-23771309a4d3@weissschuh.net
> ---
> 
> As discussed in v1 this is based on 6.4-rc1.
> ---
>  drivers/platform/x86/gigabyte-wmi.c | 44 -------------------------------------
>  1 file changed, 44 deletions(-)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 2a426040f749..8aa665e866b8 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -5,7 +5,6 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/acpi.h>
> -#include <linux/dmi.h>
>  #include <linux/hwmon.h>
>  #include <linux/module.h>
>  #include <linux/wmi.h>
> @@ -13,10 +12,6 @@
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
> @@ -133,49 +128,10 @@ static u8 gigabyte_wmi_detect_sensor_usability(struct wmi_device *wdev)
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
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("A320M-S2H V2-CF"),
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
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B650 AORUS ELITE AX"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z490 AORUS ELITE AC"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE WIFI"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO WIFI"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
> -	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570S AORUS ELITE"),
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
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> change-id: 20230325-gigabyte-wmi-unrestrict-7244320c1996
> 
> Best regards,

