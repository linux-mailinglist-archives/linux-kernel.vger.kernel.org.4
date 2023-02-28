Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E202C6A59E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjB1NWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1NWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:22:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00E2E817;
        Tue, 28 Feb 2023 05:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677590495; i=w_armin@gmx.de;
        bh=QVP466RW3LEp6uaazzvy9ds/oekGh5o8C2F8P4Qp8ME=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=CxxFy5YZArUXTADOk53lp2PuIQ2Shb6L1p5lVzW9xY+jnOpLl+3M3rOVsyFdSnsVO
         /J0gOJQBwjIioilyFIqCKX9UzR/wYyKO3tNs4MOeSo4gRo0O31/qVlE8FP0pBRdCXR
         zmRmxJjK54K25jNM7nQ/0/D4UHDKkGQXX9hHOi8Kj0HVOVw2sgSDwq+WSXPbuthZ8o
         +CvdhWftAP4jfLSy5iqHWlBT/MmF+QToHYXG35uj+65RZ4lm4y5vUgrVpPE2/vZMji
         q6h1y6yV9DBX1a9KQyyJubVWQ/v92RFHc2MwBCl0OW5TBIDg8EGJkjhfxj7wqN6rew
         VXp7vTCyqjWpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1or2KF27dQ-00fy6f; Tue, 28
 Feb 2023 14:21:35 +0100
Subject: Re: [PATCH v2 1/2] platform/x86: dell-ddv: Fix cache invalidation on
 resume
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230218115318.20662-1-W_Armin@gmx.de>
Message-ID: <a50ee14a-0181-5237-ddbc-5df85bd2eb6a@gmx.de>
Date:   Tue, 28 Feb 2023 14:21:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230218115318.20662-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:clm5n+6ihDAo+6ma3hx/EJ2ABcn2sRQKbrmgBTGjMfdbPfJj4Yy
 coetI3rlDDwiOLeVxB2OZ3UWxxPnMACCJZP2HAxdDIJvRDpmxOw+TcUgWnGHB4HfVXPMjNO
 uee1AErrLp5//po7YzBdQ7HSbgUa3IMqmwAa/MvXwYBtGF8xE45eNaOCmcW96DGBXR9ocZx
 kuYmvte4lrVQCZXwmW/FA==
UI-OutboundReport: notjunk:1;M01:P0:wg9GWKTMJ5I=;x50cEz6bWGDmmyzNX1MqkPwGeE2
 soPANucPOvq3agMLUuJs3fQXFIp0MwQ7pQxp723ZR5d4BTQXs8FSlA7PV69tfrFTMEV9LzKs7
 UrUkW17iZj0z5OwZmRqX95d3paVAd2wbLymok29oFzTU1ygPGSVI4RbsIQzYehgroiHsD7zZq
 JlkdbWEPdGsCGJWAD0joGv4CcTN3Qv3N7jISfk0qyvIO+X7ohjJTdVdkTg/g1jEwFMYzUeA7k
 oRukCzevL6y8+362lDOVOLeuuev2JQ9DxMvQlX7aJN2M136EMifmzAffQf9oJ8ArWmlSkUSjU
 lJTl27Bp0CfP3U8Ng4sRTKAs4Zqg4gYz5IPxRMRwiPJADKK2/bKQo6VquOEUuKjPcM0VhHYA7
 Yse29P69fqUr/cXPEC3hlATjZcMJVbMn6k961amTGnTPz9qwPtlghlMgRrkJoUzXkfPbsmFUP
 5hTfI6vBGBJvGovA9IdkwfyiCG48rOAuhQh+tGUMdqBa2fV2v2RoejWFiC5tbtipC9hsvdFHc
 VeoKZXTtk8wPetx7xvasisJlfOYIL8f4+MOueVdBbg6F9cv57zgWVKbHG+D0a6z0bgW4zWIpA
 9sKe9EGPqOQBFCafuDsgqGN1AHoFnSuetbHARpVder/5fizAPbKA5ThdKCHL+N0y+DyC0dQmk
 XWVJp+aJzP0jXhKjHSomvNF8nxE/5puB4++/jOfU1YL5Koj77SEFy0H2aD1c9ooeHNGqsuTe4
 cCNvTwZUsPkBAfa1O/eYGZ3dSB2DesgCqiaCxWrtL/GN/d2DDMNrYzvTiIrQnK+jn69ggI4la
 DWMmHiVkVTBVRTP118KcPaW6RnbLPstlOFUgaheqiaxriCVw4Vbu8uPgY2j4RTvLKHdE4oDgj
 WTwWvnGWl66o1WD6o6WRRTIUCpZ1BJf9XfyPuAJgraWLUoVr537FdRqH7w8xtEOAEgi9tLqNr
 9TMKiRxRKDCZdlUhsceOY0KDkyo=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.02.23 um 12:53 schrieb Armin Wolf:

> If one or both sensor buffers could not be initialized, either
> due to missing hardware support or due to some error during probing,
> the resume handler will encounter undefined behaviour when
> attempting to lock buffers then protected by an uninitialized or
> destroyed mutex.
> Fix this by introducing a "active" flag which is set during probe,
> and only invalidate buffers which where flaged as "active".
>
> Tested on a Dell Inspiron 3505.

Hello,

what is the status of this series? Both patches are tested on real hardware
and work flawlessly.

Armin Wolf

> Fixes: 3b7eeff93d29 ("platform/x86: dell-ddv: Add hwmon support")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v2:
> - move checking of the "active" flag inside
>    dell_wmi_ddv_hwmon_cache_invalidate()
> ---
>   drivers/platform/x86/dell/dell-wmi-ddv.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index d547c9d09725..eff4e9649faf 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -96,6 +96,7 @@ struct combined_chip_info {
>   };
>
>   struct dell_wmi_ddv_sensors {
> +	bool active;
>   	struct mutex lock;	/* protect caching */
>   	unsigned long timestamp;
>   	union acpi_object *obj;
> @@ -520,6 +521,9 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct device *dev
>
>   static void dell_wmi_ddv_hwmon_cache_invalidate(struct dell_wmi_ddv_sensors *sensors)
>   {
> +	if (!sensors->active)
> +		return;
> +
>   	mutex_lock(&sensors->lock);
>   	kfree(sensors->obj);
>   	sensors->obj = NULL;
> @@ -530,6 +534,7 @@ static void dell_wmi_ddv_hwmon_cache_destroy(void *data)
>   {
>   	struct dell_wmi_ddv_sensors *sensors = data;
>
> +	sensors->active = false;
>   	mutex_destroy(&sensors->lock);
>   	kfree(sensors->obj);
>   }
> @@ -549,6 +554,7 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *w
>   		return ERR_PTR(ret);
>
>   	mutex_init(&sensors->lock);
> +	sensors->active = true;
>
>   	ret = devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_hwmon_cache_destroy, sensors);
>   	if (ret < 0)
> @@ -852,7 +858,7 @@ static int dell_wmi_ddv_resume(struct device *dev)
>   {
>   	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
>
> -	/* Force re-reading of all sensors */
> +	/* Force re-reading of all active sensors */
>   	dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
>   	dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);
>
> --
> 2.30.2
>
