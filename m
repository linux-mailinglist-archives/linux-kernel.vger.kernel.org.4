Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58B6EBFA4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDWM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDWM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:58:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6001E10E2;
        Sun, 23 Apr 2023 05:58:25 -0700 (PDT)
Date:   Sun, 23 Apr 2023 14:58:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682254703; bh=HJZukvWGA79XO5tkgTXFO4AGdPlZ1YR+UNXDjQ8EzL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRRcjBXBJd4zdlXEeyRIsyVffcxauEnlbc8jYu9ZVpvqdLY0dMMG/XZ8SWbxdFcnP
         N7r0WScvcRYEkD1lwaWKv9zpwDGtCcrVBGaRebHduWBTLckXVb/9MSF9uDl0NYCcta
         51tyacmvRVPaQDX/XRDwyyKASn8tCmL31rxi9waw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 10/14] HP BIOSCFG driver  - passwdattr-interface
Message-ID: <740fec33-7dd5-401f-b5fb-aaf2201f1d1f@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-11-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420165454.9517-11-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 11:54:50-0500, Jorge Lopez wrote:
> ---
>  .../x86/hp/hp-bioscfg/passwdattr-interface.c  | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
> new file mode 100644
> index 000000000000..02fc766eb3cf
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to SET password methods under
> + * HP_WMI_SET_BIOS_SETTING_GUID for use with hp-bioscfg driver.
> + *
> + * Copyright (c) 2022 Hewlett-Packard Inc.
> + */
> +
> +#include <linux/wmi.h>
> +#include "bioscfg.h"
> +
> +static int bios_attr_pass_interface_probe(struct wmi_device *wdev,
> +					  const void *context)
> +{
> +	mutex_lock(&bioscfg_drv.mutex);
> +	bioscfg_drv.password_attr_wdev = wdev;

This wdev is never used. It seems this full subdriver can be dropped.
Or the one UUID-based callsite using the same UUID can use the driver.

> +	mutex_unlock(&bioscfg_drv.mutex);
> +	return 0;
> +}
> +
> +static void bios_attr_pass_interface_remove(struct wmi_device *wdev)
> +{
> +	mutex_lock(&bioscfg_drv.mutex);
> +	bioscfg_drv.password_attr_wdev = NULL;
> +	mutex_unlock(&bioscfg_drv.mutex);
> +}
> +
> +static const struct wmi_device_id bios_attr_pass_interface_id_table[] = {
> +	{ .guid_string = HP_WMI_SET_BIOS_SETTING_GUID },
> +	{ },

No comma after end-of-array marker.

> +};
> +static struct wmi_driver bios_attr_pass_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME"-password"
> +	},
> +	.probe = bios_attr_pass_interface_probe,
> +	.remove = bios_attr_pass_interface_remove,
> +	.id_table = bios_attr_pass_interface_id_table,
> +};
> +
> +int init_bios_attr_pass_interface(void)
> +{
> +	return wmi_driver_register(&bios_attr_pass_interface_driver);
> +}
> +
> +void exit_bios_attr_pass_interface(void)
> +{
> +	wmi_driver_unregister(&bios_attr_pass_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, bios_attr_pass_interface_id_table);
> -- 
> 2.34.1
> 
