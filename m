Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06776679D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjAXPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjAXPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:14:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE948595
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:14:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y11so18544589edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFeBhnH+0B/42mAHnRRgB7lrALBFMURKcwmaM7RawrY=;
        b=k+mgpune5Pmc2lqEWZ+99lql1jb492y3C/Kyzi9ionAfVmCVTFvbOtMD0QaLYL9ypL
         IAsvZGY+J3UA7pz8mcMHWMzlZcNBSpr+RED1DOLVtaFVwwgqtNrweAJLw4O89YLUUDNS
         rdNk3uJASxvwQ3Fd7gvZD9tI7lMwWJ7pBnl+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFeBhnH+0B/42mAHnRRgB7lrALBFMURKcwmaM7RawrY=;
        b=dZSb4odVWKW7sNR7mZ4nZwLDVYJWqBS/8YSwUZypydPq2QpGPUAyn16/JtTvuj8wEB
         UiYPcCORU9ZZTuCtxkqRFuYmHlul7YfgKeu1Iyy2wiXFQxE4EVqWw5x8k80FglQG5zQI
         v4zoWeLbQ7zwnX8GcYqUsKIEKz7MJxEBuTg5pBkGpHQvPCo33hV7E8CcYRCL7Ewvt/yF
         UnhO0DWBSqXfxVMF62HDj+nyl97hWA9loDzfxAG3wIgsgWyTJcx5hjOCyvvdSjNjBvCH
         8kRuJDk1DWN3h0MVEvMsLQKmc5cnlUvRXcgrf30/JuEmcE4qNmOUSWpCZaqiufAtxj39
         e7Zw==
X-Gm-Message-State: AFqh2krE3XNfLxKKWflJisxv75D3/rDowcCJ+5kbSqQJ9QWtSzumN6AZ
        RSrMddqkgOc6EPj5k6GG9Otlb3P+rlU/Xo0x0zCSQQ==
X-Google-Smtp-Source: AMrXdXsY39EBZImVG3yBHV1zEjbdADI7AUEz6yUS4RDiaCK4MX0EZZGfjAHxM38N8ipvhu0XJdE4viQYk9mA0ilnfSU=
X-Received: by 2002:a05:6402:417:b0:49e:27c9:8fe5 with SMTP id
 q23-20020a056402041700b0049e27c98fe5mr4018804edv.56.1674573286172; Tue, 24
 Jan 2023 07:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
In-Reply-To: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
From:   Benson Leung <bleung@chromium.org>
Date:   Tue, 24 Jan 2023 07:14:33 -0800
Message-ID: <CANLzEku+O2=Ow+OO0-VoCxKbmoXDz-Jdj-VNE69f-iDEX=XENA@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_typec: allow deferred probe
 of switch handles
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        heikki.krogerus@linux.intel.com, lee.jones@linaro.org,
        groeck@chromium.org, enric.balletbo@collabora.com,
        tzungbi@kernel.org, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        dustin@howett.net, dnojiri@chromium.org, tinghan.shen@mediatek.com,
        pmalani@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:56 PM Victor Ding <victording@chromium.org> wrote:
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

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>
> Changes in v3:
> - Reverted unnecessary change.
>
> Changes in v2:
> - Coverted switch-block to nested if-blocks.
>
>  drivers/platform/chrome/cros_ec_typec.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 59de4ce01fab..de480ab10488 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -145,27 +145,33 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
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
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
