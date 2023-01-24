Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF72679156
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjAXG5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAXG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:57:07 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C9E3802E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:57:06 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4d59d518505so205480097b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fcebh+bUESLcOMNZ4sR2MuaW6vYB2qGoKmgCrKux9VU=;
        b=h2nLVR/RG3NysjTEIaFO1gviCk7tj/Pp+XDSLhXNzqCLdXGLa2H7NKPKeULZDdpUD+
         iZU98TWcvbRaAe4UXGc3tseS28OKioddBNnJFtOyCANyrBt3UvznzGKWgrs09EJLFtnu
         xJhIc5q+fkRVopubv+p4De1mIhIPj68y7bt60gQqs8ajxFXFsY15flgdyoF88SQvH9OZ
         dbXlQGNix7wgySF1YXKZShBMq9/aVgeSREuMQg0kScVbdWx3/VoZPmOSZEoIgd5BXM2W
         BNucppGLBY3QT+i3HB448dQvqni9UNC1lUDiuBV4mFlzRbECQokhbSEzYjngaTzLbwje
         lL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcebh+bUESLcOMNZ4sR2MuaW6vYB2qGoKmgCrKux9VU=;
        b=f9wAHcgAmG3Dxu5YlzG/qczOVWEBWdMh6wodcJzg/3BCqyZe5FL/Z4g8ccRNPnJVO2
         4/mSp8fLy39Fceeq4HNAUt0EbR+s3mUUPCbdCT5r18CVj7ChJI+P6tttLd3HHgI2C4TL
         XeIGT6nqsj309KsooIpmP1u38eIfNDUhRXhxZJlZJmXMnMPl42xL23N03Qbeid0CbNxv
         446ty9IwUeedWofPj0CMENcBg4fj64DGBCEyjLXhUvM8KYudl1M9pjOxxWKbGg6JlVxU
         qesICeREmm5+04eQg9YgKPUlB2YW3TTZVe+qr/lIRCnYVl2sDcJqGFzjC3QifA+YCx4D
         V09Q==
X-Gm-Message-State: AO0yUKXV7RHR8VPwkSAaU5mrsCb+ydMR9taS9zVscJ9uCqhfbO1h+80o
        aZX+m+lfpGQ0oxJFU+LROH5dYHQL/8VXrnEbvRnagg==
X-Google-Smtp-Source: AK7set+t8kQvXIeEjL5m+Tui6k3ysRdw96B0wR6qF+zF2OY9Qxu9OA2HEdsUGWTTnrqnr+PBfjQDpO9Soua+TgUl8EQ=
X-Received: by 2002:a81:7902:0:b0:506:3b34:5127 with SMTP id
 u2-20020a817902000000b005063b345127mr198916ywc.402.1674543425311; Mon, 23 Jan
 2023 22:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20230124061521.v2.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
In-Reply-To: <20230124061521.v2.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 23 Jan 2023 22:56:54 -0800
Message-ID: <CABXOdTeFw_puhp5t=UUWLwrtqaoLo9ys6Z8r9Gd4HXZ3te8jdQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: allow deferred probe
 of switch handles
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        dustin@howett.net, lee.jones@linaro.org, bleung@chromium.org,
        dnojiri@chromium.org, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        gustavoars@kernel.org, groeck@chromium.org,
        enric.balletbo@collabora.com, tinghan.shen@mediatek.com,
        heikki.krogerus@linux.intel.com, tzungbi@kernel.org
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

On Mon, Jan 23, 2023 at 10:16 PM Victor Ding <victording@chromium.org> wrote:
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
> Changes in v2:
> - Coverted switch-block to nested if-blocks.
>
>  drivers/platform/chrome/cros_ec_typec.c | 26 ++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 59de4ce01fab..580f3bdf091c 100644
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

This change is pointless.

Guenter

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
> @@ -423,9 +429,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>                 }
>
>                 ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
> -               if (ret)
> -                       dev_dbg(dev, "No switch control for port %d\n",
> -                               port_num);
> +               if (ret) {
> +                       dev_dbg(dev, "No switch control for port %d, err: %d\n", port_num, ret);
> +                       if (ret == -EPROBE_DEFER)
> +                               goto unregister_ports;
> +               }
>
>                 ret = cros_typec_register_port_altmodes(typec, port_num);
>                 if (ret) {
> --
> 2.39.1.405.gd4c25cc71f-goog
>
