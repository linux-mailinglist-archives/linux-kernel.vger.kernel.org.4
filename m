Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CAE680208
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjA2Vy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjA2VyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:54:23 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279AB1729;
        Sun, 29 Jan 2023 13:53:58 -0800 (PST)
Date:   Sun, 29 Jan 2023 21:53:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675029235;
        bh=ZuHmmVa75rD8H0vl4ysn2tdQr+R0FO834UM43ckVg7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwDyfjXUge1kIoGDKORmb6v4DE9Rk4To6GBsoNO8yyGwfL9D5sSoEYL/Ec5YoS4Bd
         DKLIBGJE3uw/fN3pv+DZL+zH3Psaus/uDzqfiPx8a5TDogGxED7kmGQZtApKntadRd
         JX5nyKASVyeCzlH2iq+DnSX4XDIdpxTfiBR3ELNk=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: use standard debug APIs
Message-ID: <20230129215352.oglktngi2rvp6sfd@t-8ch.de>
References: <20221223-hid-dbg-v1-1-5dcf8794f7f9@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221223-hid-dbg-v1-1-5dcf8794f7f9@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri, hi Benjamin,

On Fri, Dec 23, 2022 at 09:30:19PM +0000, Thomas Weiﬂschuh wrote:
> The custom "debug" module parameter is fairly inflexible.
> It can only manage debugging for all calls dbg_hid() at the same time.
> 
> Furthermore it creates a mismatch between calls to hid_dbg() which can
> be managed by CONFIG_DYNAMIC_DEBUG and dbg_hid() which is managed by the
> module parameter.
> 
> Furthermore the change to pr_debug() allows the debugging statements to
> be completely compiled-out if desired.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> 
> Note: This removes the possibility to enable debugging for the HID core
> and all drivers at the same time.
> If this is still desirable it could probably be implemented with the new
> DYNAMIC_DEBUG class feature.
> ---
>  drivers/hid/hid-core.c | 9 ---------
>  include/linux/hid.h    | 8 +-------
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index bd47628da6be..4facfb446986 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -41,11 +41,6 @@
>  
>  #define DRIVER_DESC "HID core driver"
>  
> -int hid_debug = 0;
> -module_param_named(debug, hid_debug, int, 0600);
> -MODULE_PARM_DESC(debug, "toggle HID debugging messages");
> -EXPORT_SYMBOL_GPL(hid_debug);
> -
>  static int hid_ignore_special_drivers = 0;
>  module_param_named(ignore_special_drivers, hid_ignore_special_drivers, int, 0600);
>  MODULE_PARM_DESC(ignore_special_drivers, "Ignore any special drivers and handle all devices by generic driver");
> @@ -2909,10 +2904,6 @@ static int __init hid_init(void)
>  {
>  	int ret;
>  
> -	if (hid_debug)
> -		pr_warn("hid_debug is now used solely for parser and driver debugging.\n"
> -			"debugfs is now used for inspecting the device (report descriptor, reports)\n");
> -
>  	ret = bus_register(&hid_bus_type);
>  	if (ret) {
>  		pr_err("can't register hid bus\n");
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 8677ae38599e..676f501507aa 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -882,8 +882,6 @@ static inline bool hid_is_usb(struct hid_device *hdev)
>  
>  /* HID core API */
>  
> -extern int hid_debug;
> -
>  extern bool hid_ignore(struct hid_device *);
>  extern int hid_add_device(struct hid_device *);
>  extern void hid_destroy_device(struct hid_device *);
> @@ -1191,11 +1189,7 @@ int hid_pidff_init(struct hid_device *hid);
>  #define hid_pidff_init NULL
>  #endif
>  
> -#define dbg_hid(fmt, ...)						\
> -do {									\
> -	if (hid_debug)							\
> -		printk(KERN_DEBUG "%s: " fmt, __FILE__, ##__VA_ARGS__);	\
> -} while (0)
> +#define dbg_hid(fmt, ...) pr_debug("%s: " fmt, __FILE__, ##__VA_ARGS__)
>  
>  #define hid_err(hid, fmt, ...)				\
>  	dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)

any feedback on this patch?

Please note that this is *not* the same as the already merged
34ba3657a503 ("HID: i2c-hid: switch to standard debugging APIs")

> ---
> base-commit: 51094a24b85e29138b7fa82ef1e1b4fe19c90046
> change-id: 20221223-hid-dbg-2f3eeddddd53
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>

Thanks,
Thomas
