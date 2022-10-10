Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4A5F9A29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiJJHln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiJJHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12C95AF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665387384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1f8I5UyDX8gxRXr5ohnX/paZTyQ9wTejsUQHDC78T/c=;
        b=VmwYLl6SG2FTSnmRuLqUg18nABmJj4+mhIF+jT8zqbRP6R+hTvjrzwe7bBavB+aPajU/I/
        tXd9Kf0iVHt/g3My4k1UbpBAIY2i3ZFKK6tNWuSCAVElo8xcyZDJJdamUN8PLi0kmULWLs
        nf02oI8BGMSOAkgj56sIqo1nT3JVqhg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-4ns8ftrcM2WkIFXP-v2shg-1; Mon, 10 Oct 2022 03:36:22 -0400
X-MC-Unique: 4ns8ftrcM2WkIFXP-v2shg-1
Received: by mail-ej1-f69.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso4010629ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1f8I5UyDX8gxRXr5ohnX/paZTyQ9wTejsUQHDC78T/c=;
        b=imbnyTv6bTEbhyJWwjS4ZemQO7aUJOiwLwDjjmE+dydNOAwXcwQSZIxJYRM+9yVd2l
         fXJecmdW47sRhGZ+LfviQazXqRWmzlwwA5Joqwsc0LSrIFMiLcTucHmlOMh4zrLWRM4U
         6PDIEYSqq+6WuUnSIlsjBaXYy5hoDxie2rhz2VAiL28NynDrKOFiPfCKb+KHJtXO1epw
         KcjsybGk/RXtHoYlwe5o3dlOutxMxmLKh0+pesuQn7944Pvpul8FwwDYKo4gRTAm8y7q
         ov3PBoB5quelGEv0JqdJO4l5YCLvoOsuTZERS2YoURuBLinrXa/U3CyWAgKV6cOY461W
         l3lQ==
X-Gm-Message-State: ACrzQf02CdfGWbwnECyYMXZOK+Hi6My1X/q4/sLD4oZiex4ASQHCBJL5
        z3el5Vi5Ir7REu4DEDVRXEAdg0nVlT0kwg/v3CzMqr6J2W7xxzURZ0Re7lWlBVNE+Tw9MnyEaln
        FolNbKStdOFr3sALyxNlKUkLH
X-Received: by 2002:a17:907:980e:b0:78d:b6d5:661e with SMTP id ji14-20020a170907980e00b0078db6d5661emr3104525ejc.46.1665387381789;
        Mon, 10 Oct 2022 00:36:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7wFOxm2ELMxXxzdKhb/nK4R1sn0lrnt6dA55oUM6OIh5ax3IR+kS6bEAggeKvbzKl852MGiQ==
X-Received: by 2002:a17:907:980e:b0:78d:b6d5:661e with SMTP id ji14-20020a170907980e00b0078db6d5661emr3104506ejc.46.1665387381543;
        Mon, 10 Oct 2022 00:36:21 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bo1-20020a170906d04100b0077b2b0563f4sm4970456ejb.173.2022.10.10.00.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 00:36:20 -0700 (PDT)
Message-ID: <864752b9-f501-3f39-5a87-900af33a878d@redhat.com>
Date:   Mon, 10 Oct 2022 09:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH AUTOSEL 5.10 11/22] ACPI: video: Change
 disable_backlight_sysfs_if quirks to acpi_backlight=native
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arvid Norlander <lkml@vorpal.se>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
References: <20221009235540.1231640-1-sashal@kernel.org>
 <20221009235540.1231640-11-sashal@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221009235540.1231640-11-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/10/22 01:55, Sasha Levin wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> [ Upstream commit c5b94f5b7819348c59f9949b2b75c341a114cdd4 ]
> 
> Some Toshibas have a broken acpi-video interface for brightness control
> and need a special firmware call on resume to turn the panel back on.
> So far these have been using the disable_backlight_sysfs_if workaround
> to deal with this.
> 
> The recent x86/acpi backlight refactoring has broken this workaround:
> 1. This workaround relies on acpi_video_get_backlight_type() returning
>    acpi_video so that the acpi_video code actually runs; and
> 2. this relies on the actual native GPU driver to offer the sysfs
>    backlight interface to userspace.
> 
> After the refactor this breaks since the native driver will no
> longer register its backlight-device if acpi_video_get_backlight_type()
> does not return native and making it return native breaks 1.
> 
> Keeping the acpi_video backlight handling on resume active, while not
> using it to set the brightness, is necessary because it does a _BCM
> call on resume which is necessary to turn the panel back on on resume.
> 
> Looking at the DSDT shows that this _BCM call results in a Toshiba
> HCI_SET HCI_LCD_BRIGHTNESS call, which turns the panel back on.
> 
> This kind of special vendor specific handling really belongs in
> the vendor specific acpi driver. An earlier patch in this series
> modifies toshiba_acpi to make the necessary HCI_SET call on resume
> on affected models.
> 
> With toshiba_acpi taking care of the HCI_SET call on resume,
> the acpi_video code no longer needs to call _BCM on resume.
> 
> So instead of using the (now broken) disable_backlight_sysfs_if
> workaround, simply setting acpi_backlight=native to disable
> the broken apci-video interface is sufficient fix things now.
> 
> After this there are no more users of the disable_backlight_sysfs_if
> flag and as discussed above the flag also no longer works as intended,
> so remove the disable_backlight_sysfs_if flag entirely.
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Arvid Norlander <lkml@vorpal.se>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch goes hand in hand with:

commit 3cb1f40dfdc3 ("drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on some models")

and without that commit also being present it will cause a regression on
the quirked Toshiba models.

This really is part of the big x86/ACPI backlight handling refactor which 
has landed in 6.1 and as such is not intended for older kernels, please
drop this from the stable series.

Regards,

Hans



> ---
>  drivers/acpi/acpi_video.c   | 48 -------------------------------------
>  drivers/acpi/video_detect.c | 35 +++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index eb04b2f828ee..befe7b66c3aa 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -50,9 +50,6 @@ module_param(brightness_switch_enabled, bool, 0644);
>  static bool allow_duplicates;
>  module_param(allow_duplicates, bool, 0644);
>  
> -static int disable_backlight_sysfs_if = -1;
> -module_param(disable_backlight_sysfs_if, int, 0444);
> -
>  #define REPORT_OUTPUT_KEY_EVENTS		0x01
>  #define REPORT_BRIGHTNESS_KEY_EVENTS		0x02
>  static int report_key_events = -1;
> @@ -384,14 +381,6 @@ static int video_set_bqc_offset(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> -static int video_disable_backlight_sysfs_if(
> -	const struct dmi_system_id *d)
> -{
> -	if (disable_backlight_sysfs_if == -1)
> -		disable_backlight_sysfs_if = 1;
> -	return 0;
> -}
> -
>  static int video_set_device_id_scheme(const struct dmi_system_id *d)
>  {
>  	device_id_scheme = true;
> @@ -464,40 +453,6 @@ static const struct dmi_system_id video_dmi_table[] = {
>  		},
>  	},
>  
> -	/*
> -	 * Some machines have a broken acpi-video interface for brightness
> -	 * control, but still need an acpi_video_device_lcd_set_level() call
> -	 * on resume to turn the backlight power on.  We Enable backlight
> -	 * control on these systems, but do not register a backlight sysfs
> -	 * as brightness control does not work.
> -	 */
> -	{
> -	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> -	 .callback = video_disable_backlight_sysfs_if,
> -	 .ident = "Toshiba Portege R700",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
> -		},
> -	},
> -	{
> -	 /* https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
> -	 .callback = video_disable_backlight_sysfs_if,
> -	 .ident = "Toshiba Portege R830",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R830"),
> -		},
> -	},
> -	{
> -	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> -	 .callback = video_disable_backlight_sysfs_if,
> -	 .ident = "Toshiba Satellite R830",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE R830"),
> -		},
> -	},
>  	/*
>  	 * Some machine's _DOD IDs don't have bit 31(Device ID Scheme) set
>  	 * but the IDs actually follow the Device ID Scheme.
> @@ -1764,9 +1719,6 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>  	if (result)
>  		return;
>  
> -	if (disable_backlight_sysfs_if > 0)
> -		return;
> -
>  	name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
>  	if (!name)
>  		return;
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index e39d59ad6496..3a27f2364159 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -500,6 +500,41 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_BOARD_NAME, "PF5LUXG"),
>  		},
>  	},
> +	/*
> +	 * These Toshibas have a broken acpi-video interface for brightness
> +	 * control. They also have an issue where the panel is off after
> +	 * suspend until a special firmware call is made to turn it back
> +	 * on. This is handled by the toshiba_acpi kernel module, so that
> +	 * module must be enabled for these models to work correctly.
> +	 */
> +	{
> +	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> +	 .callback = video_detect_force_native,
> +	 /* Toshiba Portégé R700 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
> +		},
> +	},
> +	{
> +	 /* Portégé: https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
> +	 /* Satellite: https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> +	 .callback = video_detect_force_native,
> +	 /* Toshiba Satellite/Portégé R830 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
> +		},
> +	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Toshiba Satellite/Portégé Z830 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
> +		},
> +	},
> +
>  	/*
>  	 * Desktops which falsely report a backlight and which our heuristics
>  	 * for this do not catch.

