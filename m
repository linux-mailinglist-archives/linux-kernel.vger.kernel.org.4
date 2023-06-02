Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F2720B10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbjFBVig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjFBVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:38:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27731B9;
        Fri,  2 Jun 2023 14:38:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d24136685so2007766b3a.1;
        Fri, 02 Jun 2023 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685741912; x=1688333912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOxmmoChgGmmbkHXT5M4NYNn9GSH3yiIHwZaw748eEU=;
        b=LuRX98zJpZv5/62lSU0Rz8wc7Nn9jAM1gsQ+T1ZPV5ta0Wg59SMYJDlq7gQgUbkNdk
         coiiff54b4vj11EnEgZ9JBt6keF7hFjpSKEYEO7MoguDkWsfh8GYkn3B/xDI8yED5Q3b
         jGCgsTwYCsyXAndT1UqCUbcGR8u6LDPQwsCS7DAA65uAKxOIUL7kuNexIB9HyB9C+PuP
         trbIEanSeNDaJzwaHVWtjSv2dPY4PG2foJ8WA/l2x92MFkRDKWuYIXNMYX7ApEJdXzhu
         uMjdC7BaJPqjldsHaLqcSNwn04/FI0LY/MW8Z8Gkz99fuMV0ZJeHEi55UFJRUVR48Pbp
         Y18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741912; x=1688333912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOxmmoChgGmmbkHXT5M4NYNn9GSH3yiIHwZaw748eEU=;
        b=KS6ubgNMogEaCv07Oz43EXuWeJb1AkuYBXwlaZXe2w/44koHu8q7GZcX0xbz7JAcuE
         NWGeN80E0qQCHDKuev3AVilBkVYTDMN/XTlstYls3H1+DjDt2ZeGwqI9OaLgfEFHMMIZ
         gkmashUReeBLlxSRL8d6ZS+PI5DdkyWmnDR9qC3UhgAxOpJGqgyKpnwHyVnG6NMuDmi7
         5yglCwB5wAqTQLzpFbu73WXAweZ7W8ErezgU2kBUID2SELX1+ypGaZcBi7KoANYPr7bh
         oFv1TAUEmhR2/Io+bxrevryzwwOEspigBgo87G83f+WRaMGoembPV1+E/aIulN0xqr4C
         r7rQ==
X-Gm-Message-State: AC+VfDy0EIJmM//eGuKsfdakknVhuWY1kwQcbajIZULzUx8DhCYM8vBo
        nfuK8slsIct1BfxBOj5b+WI=
X-Google-Smtp-Source: ACHHUZ55XmHcQvakmsg1pHCvPItWTYcdK/wkx9Rwsh3rx8Y14ZpNkcR5EdRaoYUI0gcJInUlge1gbw==
X-Received: by 2002:a05:6a00:130c:b0:64c:a099:8924 with SMTP id j12-20020a056a00130c00b0064ca0998924mr6324982pfu.10.1685741912361;
        Fri, 02 Jun 2023 14:38:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a14-20020a62bd0e000000b0064ceb16a1a8sm1404186pff.33.2023.06.02.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:38:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jun 2023 14:38:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: hp-wmi-sensors: fix debugfs check
Message-ID: <b444388f-585e-4798-a3a0-7d8b1996e5b1@roeck-us.net>
References: <20230601213216.3220550-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601213216.3220550-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
> Fixes: 602bef0fa281 ("hwmon: add HP WMI Sensors driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: James Seo <james@equiv.tech>

Applied.

Thanks,
Guenter

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
