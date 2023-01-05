Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7728865F3F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjAESrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjAESrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:47:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1433E0E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:47:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v30so2666562edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgw8ytZ8qgDy6GzZF1ryroLO4GjbQhKhTHuYH5QueqQ=;
        b=d4xQW7aOqawwrqQ+Q+tdvQn2OItCU6t0Hz/kCQHrlQwBzfrFOZf00OWnnUp8NDcXse
         Gg4YLx0q41tNcLQFxYmTlq8LiiPDPw5awK6PTxoyYmyt2R9nGczDfnim45oqqSlwH1ku
         +A2oP7dYjAfTqmAUCDoI375sLGHDgzCW1Qz/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kgw8ytZ8qgDy6GzZF1ryroLO4GjbQhKhTHuYH5QueqQ=;
        b=3+Cw/gTX53knm5f+g+zUAQtdOG49Nhu99Z1wvn+Ja9s8MTVx65JKanQXsO4aCm6W6V
         Zc6wRw06sNxKwH+ubHAIum1VMzOS14ADphW2Igae3yT1cobbJMErjZkCpi+NogXbJYaP
         GIhEFC94Zbx3uqa8hVPRslMaDuOnszZLshbTgzHDwGXdTQzI8yAAeQGcD9prWF25Wv9L
         T6jtQ8KueI9f8uaRSkHaAA/i8BzvtiCNTG245777Vykg04GKE+X9GJjJMd72vsBxk6t7
         qtO1wKcqX3bRVV+OFfVl88WFCqW/3XSue4+hL5xgDOC7JZjCYCUFOHUIX9nj00brw/Df
         +bpg==
X-Gm-Message-State: AFqh2kpIENFEsByGaoJavQ/YoDoQMNj4lfmCOYyGnmnhFiSDpicJTMJI
        h+8u3Qx2MaQOUDSiu+qlDu+4ItI27lSHLuSMQWvtyA==
X-Google-Smtp-Source: AMrXdXt0rB7h75RQCatj+bf0XdBiLgg9pvTKdsd4RrtVWZ6bj/PPRJBXCJfr4/DyqsPu8Mf+F4TBvcqf3H1BjTJKV4k=
X-Received: by 2002:a05:6402:516b:b0:47e:1b4a:5489 with SMTP id
 d11-20020a056402516b00b0047e1b4a5489mr6363589ede.262.1672944433616; Thu, 05
 Jan 2023 10:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20230104060846.112216-1-pmalani@chromium.org> <20230104060846.112216-2-pmalani@chromium.org>
In-Reply-To: <20230104060846.112216-2-pmalani@chromium.org>
From:   Benson Leung <bleung@chromium.org>
Date:   Thu, 5 Jan 2023 10:46:57 -0800
Message-ID: <CANLzEkvqOvbSqtxG+YZoTmU=xH3ZZzbLEND7RQQH7pVPEY1hQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_typec_switch: Check for retimer flag
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
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

Hi Prashant,

On Tue, Jan 3, 2023 at 10:09 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Not all ports have retimers. Only register a retimer switch if the
> "retimer-switch" property is present for that port's mux
> device.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks,
Benson

> ---
>  drivers/platform/chrome/cros_typec_switch.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
> index 2536bda03bf3..9ed1605f4071 100644
> --- a/drivers/platform/chrome/cros_typec_switch.c
> +++ b/drivers/platform/chrome/cros_typec_switch.c
> @@ -246,14 +246,16 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
>                 port->port_num = index;
>                 sdata->ports[index] = port;
>
> -               ret = cros_typec_register_retimer(port, fwnode);
> -               if (ret) {
> -                       dev_err(dev, "Retimer switch register failed\n");
> -                       goto err_switch;
> +               if (fwnode_property_present(fwnode, "retimer-switch")) {
> +                       ret = cros_typec_register_retimer(port, fwnode);
> +                       if (ret) {
> +                               dev_err(dev, "Retimer switch register failed\n");
> +                               goto err_switch;
> +                       }
> +
> +                       dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
>                 }
>
> -               dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
> -
>                 if (!fwnode_property_present(fwnode, "mode-switch"))
>                         continue;
>
> --
> 2.39.0.314.g84b9a713c41-goog
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
