Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3214F71FAC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjFBHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjFBHMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:12:31 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52D1B5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:12:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1685689948; x=1685697148; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=rcYboFVd7AE2p0CUNEz6a2jsGbJCMFxFjqC+A9m1lBw=;
 b=oua6mHVg/PrauupNsyfY86SDR1DZTONWPDageeVj0gTD0S97alcTPsttTqmT+M89N9mN/p0+/I9pEq8nKqhYSqVzeN/U2lGP601VKJBcYd0gtDZHe5Jsj4YamGqBpaEDoTh0ZGsQE7Rvn3RIhv9vK+54VcyYEU2yfSEJJXB5qXmkq6INIeOV+F/FZu2lqQ0E6nvo41JqGWwKSWiqJCB2qr4E1kWcLdxQuyrFBLF/qasiHEQL89wumVCDgVVRGg5PsjX8Sf7Q2eHLB897eUFuqAvxnjc5oXU+ysb/ISIflbZMhy0ECp+CrF4Q1SsGFIS8UTLlUO1WwLM1x36LZpF3Qg==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 29052c795feb with SMTP id
 6479965c2853aaaeeb0645ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Jun 2023 07:12:28 GMT
Sender: james@equiv.tech
Date:   Fri, 2 Jun 2023 00:12:27 -0700
From:   James Seo <james@equiv.tech>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: hp-wmi-sensors: fix debugfs check
Message-ID: <ZHmWWzb3PiCiExJf@equiv.tech>
References: <20230601213216.3220550-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601213216.3220550-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:31:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Checking for Kconfig symbols with #if is wrong:
> 
> drivers/hwmon/hp-wmi-sensors.c:1141:5: error: "CONFIG_DEBUG_FS" is not defined, evaluates to 0 [-Werror=undef]
> 
> This could be an #ifdef, but an IS_ENABLED() check is even better to
> give the best compile coverage.
> 
> Fixes: 602bef0fa281f ("hwmon: add HP WMI Sensors driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hwmon/hp-wmi-sensors.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index 7218945bd03fc..ebe2fb5134805 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1138,8 +1138,6 @@ static int hp_wmi_update_info(struct hp_wmi_sensors *state,
>  	return ret;
>  }
>  
> -#if CONFIG_DEBUG_FS
> -
>  static int basic_string_show(struct seq_file *seqf, void *ignored)
>  {
>  	const char *str = seqf->private;
> @@ -1341,16 +1339,6 @@ static void hp_wmi_debugfs_init(struct device *dev, struct hp_wmi_info *info,
>  	}
>  }
>  
> -#else
> -
> -static void hp_wmi_debugfs_init(struct device *dev, struct hp_wmi_info *info,
> -				struct hp_wmi_platform_events *pevents,
> -				u8 icount, u8 pcount, bool is_new)
> -{
> -}
> -
> -#endif
> -
>  static umode_t hp_wmi_hwmon_is_visible(const void *drvdata,
>  				       enum hwmon_sensor_types type,
>  				       u32 attr, int channel)
> @@ -1959,7 +1947,8 @@ static int hp_wmi_sensors_init(struct hp_wmi_sensors *state)
>  	if (err)
>  		return err;
>  
> -	hp_wmi_debugfs_init(dev, info, pevents, icount, pcount, is_new);
> +	if (IS_ENABLED(CONFIG_DEBUG_FS))
> +		hp_wmi_debugfs_init(dev, info, pevents, icount, pcount, is_new);
>  
>  	if (!count)
>  		return 0;	/* No connected sensors; debugfs only. */
> -- 
> 2.39.2
>

Acked-by: James Seo <james@equiv.tech>

