Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24446780B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjAWQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjAWQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:00:46 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E2E7297
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:00:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 188so15361746ybi.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NeIcA5S+dnmrIVTwVfRWJo+4PAeUHSf9erW6VTBU+Fk=;
        b=SEZJD4dx9tkHB8M9ZJpL3Fvn6P01HXOawpP3Md/gmXNji/GzGqSKt2hw3xNEs+BvOQ
         wDfKBoRGOqWWZYsnURMXLVmN6t1BMDww7Bo7voRF+8rGxAvo//iHoisFyPCRLoOqaQlS
         /Yk/qAndjQfkW5ysqkVZrGBT/+IjrfbEugsq3YMuU1aebIq55SHOGX1YkWffL6qjEGXZ
         9Rk/buaJyZxsfXHMXjtA86yKshvJhDxAxCWFnbdpKYJLqLzW9VV3nZP4qs65paryP6Lt
         zzt/B2xUmNyU7Awki1TPmr8iU3FrYT8vOfjwfwJx01xVz1ED1v+PS8lSQJ//fiVkyTc/
         Ku5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeIcA5S+dnmrIVTwVfRWJo+4PAeUHSf9erW6VTBU+Fk=;
        b=j5ig+HzZ0wvAuKef6z0RR0OTgL2VhXODqfdHwld+vZTxEL7E/WcAOUotpd0ne2tLYP
         ACt1Dem+0RfgaHaOVviGXJL/VDSLwrzJKmttc/fPuxBL83/jKAlzXD8ygh+mgIvXGwgx
         prueAY3zoEHEFJgXspE2QoN0tmwa1YIq5+guQ/9l9zHZOF5owPGGWh4U4QXnhS6yPsTI
         dfk61y5LXqE6Mn4BrbZEkT9Qe3xq44vS5SIoG8dh763CkNeGLMAL4KR3KtJFJJ5pisEb
         mCaBtPor+j2pz5NmOh0MZaKRaLaeg48Fs5AsW9Sxl5K0DgxVGC88qlK/OHrHG3t01gp7
         0vFg==
X-Gm-Message-State: AFqh2kodJyYxV3vOO6lFPJlJ1SIGQrXksOcdPcAN80n5LgyV+uhV3TOS
        iMZuk2CKfRvHCFFR+PTkBxZbodghYIDvF5APZXv9NQ==
X-Google-Smtp-Source: AMrXdXujNE1G5UWuwXCs+5+Pw9XLNjdaXbWFeSasbkoUAsicrIlpOl0APXO1UPrAC9V1oPfF2Gp4dFd3hrJ3d7B6s/8=
X-Received: by 2002:a25:4643:0:b0:7f0:6577:3333 with SMTP id
 t64-20020a254643000000b007f065773333mr1764056yba.525.1674489642788; Mon, 23
 Jan 2023 08:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20230123093609.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
In-Reply-To: <20230123093609.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 23 Jan 2023 08:00:31 -0800
Message-ID: <CABXOdTcEi7zb6YNcWsV6vXjO6T0VTOsuzJUO+APR1tgTfrXgww@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: allow deferred probe of
 switch handles
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        gustavoars@kernel.org, heikki.krogerus@linux.intel.com,
        dnojiri@chromium.org, dustin@howett.net, lee.jones@linaro.org,
        tzungbi@kernel.org, groeck@chromium.org,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        tinghan.shen@mediatek.com, sebastian.reichel@collabora.com,
        enric.balletbo@collabora.com, bleung@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

All of those should call dev_err_probe().

>                 goto mux_err;

and this can return directly.

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
>
>                 ret = cros_typec_register_port_altmodes(typec, port_num);
>                 if (ret) {
> --
> 2.39.0.246.g2a6d74b583-goog
>
