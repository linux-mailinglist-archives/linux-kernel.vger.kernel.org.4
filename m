Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D5679922
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjAXNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjAXNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:20:52 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A423C29E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:20:25 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4c24993965eso216971727b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iatBsnyN9KLmYoJDVX4uZPB29jcAj/SJ847xSay6LsM=;
        b=iU3g46mSoil2nPxNowG+amIi9F9QNYSJWYfoa06vn7GVe7l7J1IXEEq9/2F/yiWafY
         39LdD4/IdoMnNxumeksm7jIpQOB0wgYlsCKRUltL/CNf1jyXoUWBnQc+MB0FkmjgoUm0
         wpx73bbAvRBgT5ljsFf7X2mRhAmg+sO1rml6kVzUJsa5WqdJ0W6pJt3OBXAv01WALmrW
         95g+IuuKA2dynymTTVYqdoBwuIAejY2FjxA6fbRxG1RtNmGHwjUcIvZBGYUGH7Ljw8dX
         /ZzrLdLZrdxZR4nkC2VhGWe3IaE51ySkeJJbL9bTdnbYPGWn+sle+TOYctrPxvjZZElq
         GwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iatBsnyN9KLmYoJDVX4uZPB29jcAj/SJ847xSay6LsM=;
        b=un00e3UJUtSISl3FPco9vNRTc9inaHXpDkgx62wvlPSHUnyxQXRbvWpuvytAkiSDID
         UGsU/1fdNuhFWIQJqiRRhzdf8V2ila3g+2aXxTkaVTS68Z68YvOt47jv87s/qn4zBFz0
         z3dRqsS6B9LDQVqYSEou+bWrhjO94M2HCUCFHM+lFDAiJIW/Wa6RPUJuD0dd04i5IB9D
         Ka3SAYoKKo51/MufkKVxoiVgr4JGZ8bELFD+pyDIyuj0pwOH9cl6GGLab/uPAuxkAmZq
         c8PsyVmofhDGd33nw8w5et7hRpThUMOtEWRRmyiwOYWmX+iRTQRwWqH2haWrps/FbDlT
         t44w==
X-Gm-Message-State: AFqh2krvPNKraKJyzC1OOcZsK3VgOfH3gZ1VxsuSLO16aJwVxkKMaST7
        U4+o8QYoJ9vNGRaLMrFunZiYik6r34O7z9h9SWLk4A==
X-Google-Smtp-Source: AMrXdXtpm5oP7Q44eFF7PiXc0dwzZyF5FEvbTCk1byLeqm7EwDv1dOfN+Bb7tXCmokekANx2Mf6Z2T+2AoXVz37lbA0=
X-Received: by 2002:a0d:eec6:0:b0:4d6:5735:dbfd with SMTP id
 x189-20020a0deec6000000b004d65735dbfdmr3330925ywe.157.1674566421203; Tue, 24
 Jan 2023 05:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
In-Reply-To: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 24 Jan 2023 05:20:10 -0800
Message-ID: <CABXOdTdvMVfvSNPiNgjpyROE+7X-KzCsqYkKmnOnycBa_Vxv6g@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_typec: allow deferred probe
 of switch handles
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        heikki.krogerus@linux.intel.com, lee.jones@linaro.org,
        groeck@chromium.org, enric.balletbo@collabora.com,
        tzungbi@kernel.org, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        bleung@chromium.org, dustin@howett.net, dnojiri@chromium.org,
        tinghan.shen@mediatek.com, pmalani@chromium.org
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

Reviewed-by: Guenter Roeck <groeck@chromium.org>

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
