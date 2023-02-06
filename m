Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35F768C71D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBFT4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBFT4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:56:12 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCF2917F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:56:09 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id t1so6549794ybd.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLMstZQHkXJe//HFhYU7Zy8Xlrx7byL1tOxOLctVl4s=;
        b=aBJsRQhntuN/2TdlJueDGBEfnmLSC2B0sfJLRlD1zkotym8Tqh3/7B86FTTtbGJBgm
         xOOGNeoQBgsJ+WNeEJ3lJdgLTtWpLVvpSltjo5DgNUPVmelOwqyngK+RitYLsZZn1FV2
         ACd9gaOVxfMEYW+Z3N7JmjCYRb+ddUn4RN250=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLMstZQHkXJe//HFhYU7Zy8Xlrx7byL1tOxOLctVl4s=;
        b=K/sjKFoSa9di1aJ5BXsxGhDE/Vo9yxmAnS78QWFD37+r1Hs7g5ogYYJu4PtYTfs7jX
         oflfT6XHTRp494fFv0KfTQNft+qM8CrTCYctZCPGGZfRAK98bAunNB4wtlDaCFk3lS7m
         5HsaBcvPHk0XpSxMO2pHCbscipL4pWh28nS3ut5qthu08YgXJqgteiJgEFEJTnIswpOm
         6Wtd5KWGpROX1nKla2jTqor1m7ZcQPO+eyVzWrTD4drYgTgxK/zYBruitYfUxzdZ6uQ8
         U4kXgTA1AHHrS6MuI/N4S3cowlWxxqMAXVtXDYm0kazVuPwQuUS4/NC3m8w2Oux6On82
         5PiA==
X-Gm-Message-State: AO0yUKW/WO2QjSk4BGRw9jxgnOHlfzcKVUS5CutCOnMMcc8bP2XDE1vU
        55Wmaa1oQ+H9Y6bvdztzsAJtvbZ2yfp5AU4NT/pj6A==
X-Google-Smtp-Source: AK7set8HKJ7J6EprwhWlIjoypiaQ1a06IDT3nY9Mq/P6X9r1HbjELYnAC6RRiS3AaoatwabMI4S9y73OEs7Gwb+ynPs=
X-Received: by 2002:a25:43:0:b0:864:9aee:7b7e with SMTP id 64-20020a250043000000b008649aee7b7emr91952yba.244.1675713368611;
 Mon, 06 Feb 2023 11:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20230207073610.3290391-1-rajat.khandelwal@linux.intel.com>
In-Reply-To: <20230207073610.3290391-1-rajat.khandelwal@linux.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 6 Feb 2023 11:55:57 -0800
Message-ID: <CACeCKad1suBNrpPOtKnHaLZmLEpgV4ExA53ermqv50viSSnLdA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Avoid fetching the type-C parameters again
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

Please use the right header in the commit message. There are plenty of
examples in the git log.

On Sun, Feb 5, 2023 at 11:34 PM Rajat Khandelwal
<rajat.khandelwal@linux.intel.com> wrote:
>
> The struct 'cros_typec_port' incorporates three type-C parameters,
> 'ori_sw', 'retimer', and 'mux'.
> These parameters in the struct 'typec_port' are being already
> configured when 'typec_register_port' is being called.
>
> The bigger picture - 'typec_register_port' can return an error and
> the type-C parameters could go unconfigured. However, the callback
> will return EPROBE_DEFER and the driver will again be getting probed
> trying to configure them again.
> However, currently, they are again tried to get fetched for the
> 'cros_typec_port' struct, which sometimes could result in an error
> and these parameters could go unconfigured (no provision of deferring
> the probe in this case, so we are left with unconfigured parameters).

This is by design. If the switch handles cannot be obtained for any reason
other that -EPROBE_DEFER, we will not re-attempt to acquire them, and
should continue driver probe and carry on with limited functionality.

If there is a sporadic error other than -EPROBE_DEFER, that points to a
deeper issue in firmware which should be investigated.

>
> Hence, assign the parameters to the corresponding ones in the struct
> 'typec_port' after they are fetched in 'typec_register_port'.
>
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 58 ++++++++++---------------
>  1 file changed, 22 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 001b0de95a46..0265c0d38bd6 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -24,6 +24,8 @@
>  #include <linux/usb/typec_tbt.h>
>  #include <linux/usb/role.h>
>
> +#include "../../usb/typec/class.h"

That is a local header. We cannot use it outside of drivers/usb/typec/

> +
>  #define DRV_NAME "cros-ec-typec"
>
>  #define DP_PORT_VDO    (DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
> @@ -141,47 +143,17 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
>         return 0;
>  }
>
> -static int cros_typec_get_switch_handles(struct cros_typec_port *port,
> -                                        struct fwnode_handle *fwnode,
> -                                        struct device *dev)
> +static int cros_typec_get_role_switch_handle(struct cros_typec_port *port,
> +                                            struct fwnode_handle *fwnode,
> +                                            struct device *dev)
>  {
> -       port->mux = fwnode_typec_mux_get(fwnode, NULL);
> -       if (IS_ERR(port->mux)) {
> -               dev_dbg(dev, "Mux handle not found.\n");
> -               goto mux_err;
> -       }
> -
> -       port->retimer = fwnode_typec_retimer_get(fwnode);
> -       if (IS_ERR(port->retimer)) {
> -               dev_dbg(dev, "Retimer handle not found.\n");
> -               goto retimer_sw_err;
> -       }
> -
> -       port->ori_sw = fwnode_typec_switch_get(fwnode);
> -       if (IS_ERR(port->ori_sw)) {
> -               dev_dbg(dev, "Orientation switch handle not found.\n");
> -               goto ori_sw_err;
> -       }
> -
>         port->role_sw = fwnode_usb_role_switch_get(fwnode);
>         if (IS_ERR(port->role_sw)) {
>                 dev_dbg(dev, "USB role switch handle not found.\n");
> -               goto role_sw_err;
> +               return -ENODEV;
>         }
>
>         return 0;
> -
> -role_sw_err:
> -       typec_switch_put(port->ori_sw);
> -       port->ori_sw = NULL;
> -ori_sw_err:
> -       typec_retimer_put(port->retimer);
> -       port->retimer = NULL;
> -retimer_sw_err:
> -       typec_mux_put(port->mux);
> -       port->mux = NULL;
> -mux_err:
> -       return -ENODEV;
>  }
>
>  static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> @@ -363,6 +335,18 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>         return 0;
>  }
>
> +static void cros_typec_copy_port_params(struct cros_typec_port *cros_port)
> +{
> +       struct typec_port *port = cros_port->port;
> +
> +       if (IS_ERR_OR_NULL(port))
> +               return;
> +
> +       cros_port->mux = port->mux;
> +       cros_port->retimer = port->retimer;
> +       cros_port->ori_sw = port->sw;
> +}

Sorry, but this is not the right approach. These handles are
ref-counted. We intentionally
take extra references to these using the provided API. Please don't
use raw references like this.

Also, if the fwnode_*_get() functions are failing, why are we to
assume that they worked for the
Type-C class code (that code uses the same functions) [1] ?

This approach is not right.

BR,

-Prashant


[1] https://elixir.bootlin.com/linux/v6.2-rc7/source/drivers/usb/typec/class.c#L2317
