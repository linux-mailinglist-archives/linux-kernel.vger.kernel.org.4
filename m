Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339A6678CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjAXAni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXAnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:43:37 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9432DE54
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:43:36 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id t16so12385204ybk.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VirHtwZIR+krpt640kXLmdBO4/megsErXbDLotYWnLE=;
        b=Mq+q9W/IFdy0auODrchmgOt8fh63zbjA0dkS6/VHQt14A8kAew8LJk2n1Iim/ScdTK
         pZ/g+VkrJz07bgGtpy6r5wHmAmw0/WJ8+hanA3kY92uyHKz5NxVVABz1/s4gFNLFszJK
         Pu3qQmyxA/pUANR/Y6lmA0gUM/Nkw/ogJiyHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VirHtwZIR+krpt640kXLmdBO4/megsErXbDLotYWnLE=;
        b=QTRo6fUkC+1Nr148AIFCCSN5sKyGdY6wCA++vBzCQ5YiPwgXJ72A50GEcMSyWDg1NG
         nZ7CrKx1oW403wL6dcnLE3TkUBePz6uoQkqPd5z4KVp/s6ogrP/eB1dI7dGq8X7ZGUDK
         bPESyksVWznr4z7o/2y3kIgmN15Fgl8+mqZ8LRDP2op7xklvZxkLJSkC7GUodK+ZyRwH
         jrKwP0/OLF9pNrwQ5ucs1OdYHChufqVAO4PKbROtXHCExCO16QuSrMSyJKarYPvVXIiU
         nHiODqswhPfGTzthB1VL1LEFri/bkMsDEdKjiu5xXbHlhlxgI/+V8x4Gcs1Y28KbwQeb
         ih7A==
X-Gm-Message-State: AFqh2kp8UKultORh8OBjnYskP3LYswO5lLsLWisUrExAKsx91Z+ENw/P
        61+lZ8uKUAH9EwlpIsAltMgOWFM/vplFt7leg2YGvg==
X-Google-Smtp-Source: AMrXdXtXzlxEcjko7SKoGgpsddK1ALit1MUPi8Wv7qxawIFiDTWvsAmxw+tfW96X+19/d/juBi2twOXfE2JllLnVdvk=
X-Received: by 2002:a05:6902:90e:b0:7c8:3a6f:9b7b with SMTP id
 bu14-20020a056902090e00b007c83a6f9b7bmr2956596ybb.88.1674521015221; Mon, 23
 Jan 2023 16:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20230123093609.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
In-Reply-To: <20230123093609.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 23 Jan 2023 16:43:23 -0800
Message-ID: <CACeCKafcL=KJ+a5C2BKXWX3rkWf9BHp1oB3dikAjGtFWqW5_PA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: allow deferred probe of
 switch handles
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        gustavoars@kernel.org, heikki.krogerus@linux.intel.com,
        dnojiri@chromium.org, dustin@howett.net, lee.jones@linaro.org,
        tzungbi@kernel.org, groeck@chromium.org,
        gregkh@linuxfoundation.org, tinghan.shen@mediatek.com,
        sebastian.reichel@collabora.com, enric.balletbo@collabora.com,
        bleung@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 1:36 AM Victor Ding <victording@chromium.org> wrote:
>
> `fwnode_typec_{retimer,mux,switch}_get()` could return `-EPROBE_DEFER`,
> which is called from `cros_typec_get_switch_handles`. When this happens,
> it does not indicate absence of switches; instead, it only hints that
> probing of switches should occur at a later time.
>
> Progagate `-EPROBE_DEFER` to upper layer logic so that they can re-try
> probing switches as a better time.
>
> Signed-off-by: Victor Ding <victording@chromium.org>
> ---
>
>  drivers/platform/chrome/cros_ec_typec.c | 30 +++++++++++++++++--------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 59de4ce01fab..f4b3fc788491 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -145,31 +145,37 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
>                                          struct fwnode_handle *fwnode,
>                                          struct device *dev)
>  {
> +       int ret = 0;
> +
>         port->mux = fwnode_typec_mux_get(fwnode, NULL);
>         if (IS_ERR(port->mux)) {
> -               dev_dbg(dev, "Mux handle not found.\n");
> +               ret = PTR_ERR(port->mux);
> +               dev_dbg(dev, "Mux handle not found: %d.\n", ret);
>                 goto mux_err;
>         }
>
>         port->retimer = fwnode_typec_retimer_get(fwnode);
>         if (IS_ERR(port->retimer)) {
> -               dev_dbg(dev, "Retimer handle not found.\n");
> +               ret = PTR_ERR(port->retimer);
> +               dev_dbg(dev, "Retimer handle not found: %d.\n", ret);
>                 goto retimer_sw_err;
>         }
>
>         port->ori_sw = fwnode_typec_switch_get(fwnode);
>         if (IS_ERR(port->ori_sw)) {
> -               dev_dbg(dev, "Orientation switch handle not found.\n");
> +               ret = PTR_ERR(port->ori_sw);
> +               dev_dbg(dev, "Orientation switch handle not found: %d\n", ret);
>                 goto ori_sw_err;
>         }
>
>         port->role_sw = fwnode_usb_role_switch_get(fwnode);
>         if (IS_ERR(port->role_sw)) {
> -               dev_dbg(dev, "USB role switch handle not found.\n");
> +               ret = PTR_ERR(port->role_sw);
> +               dev_dbg(dev, "USB role switch handle not found: %d\n", ret);
>                 goto role_sw_err;
>         }
>
> -       return 0;
> +       return ret;
>
>  role_sw_err:
>         typec_switch_put(port->ori_sw);
> @@ -181,7 +187,7 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
>         typec_mux_put(port->mux);
>         port->mux = NULL;
>  mux_err:
> -       return -ENODEV;
> +       return ret;
>  }
>
>  static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> @@ -423,9 +429,15 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>                 }
>
>                 ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
> -               if (ret)
> -                       dev_dbg(dev, "No switch control for port %d\n",
> -                               port_num);
> +               switch (ret) {
> +               case 0:
> +                       break;
> +               case -EPROBE_DEFER:
> +                       dev_err(dev, "Deferring getting switch handles at port %d\n", port_num);
> +                       goto unregister_ports;
> +               default:
> +                       dev_dbg(dev, "No switch control for port %d, err: %d\n", port_num, ret);
> +               }

The switch statement seems a little clunky here. Instead, nest a couple
of ifs; it is shorter and easier to read IMO.

ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
if (ret) {
    dev_err_probe(dev, ret, "No switch control for port: %d\n", port_num);
    if (ret == -EPROBE_DEFER)
        goto unregister_ports;
}

}
}
>
>                 ret = cros_typec_register_port_altmodes(typec, port_num);
>                 if (ret) {
> --
> 2.39.0.246.g2a6d74b583-goog
>
