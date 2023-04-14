Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AF6E264C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjDNO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjDNO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:57:34 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A493CE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:57:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id m19-20020a9d7e93000000b006a43569e458so166827otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681484251; x=1684076251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=do9MVGOBzyJXolla779PGaLbhzvpCmZ5RXZOI8+2W70=;
        b=xq4cG0CnhJuF455zMII2VIxNN4DY9Njc6L3CM8LJDZfrTXyRWG7NSA19VRklxMXIOK
         zIbjxPVoJYWyXlzWUZ4fhXACaLBhuOMDgxxR/TB0IYEsGljZ6Kb4IE3AxoTs/hXcho6y
         PD0z/UCEWJKZApz6Asi2Y9z4YKcICGErkC8x8d1UI4RCcKsqcs/2oECVPZYWUKzTUseX
         CS2FmVEtjtEOTsxWbLPJvMxWBi4aovVsa+MaWvvJRdTJzIz7Ey7CPkOPhCjzlgfi6ahX
         SGhxwA9cSxJJJFVgYV+x7f4J2SVeFZr/e/S2DHu7ZTN4GjwBljVyb5B9gYhEZ5nYBNw0
         yqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681484251; x=1684076251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=do9MVGOBzyJXolla779PGaLbhzvpCmZ5RXZOI8+2W70=;
        b=XBwyZApPy7nfTif+Ai74Og2JhJlAsK9BhZ+B9ze/kLGU3Qy6bHVN4R3/JvD2aZiahf
         rMK4e2pXhDmssnUnd2qBKK29N8o+qWR4VyCOSgMC7/7fvxm1d8L7uP+FHsBjSu3E1GoL
         1CNL3rq5XAhYgsfPL1aieGk7A8AP3EUu7yUKpjOvibqvfkmVN/eBexNv+yqo62d8C5x3
         yfCk/doZfFeR8o0TF7lUqeoiVCj/IqT0CxXcXK8cBpHg+pdvw7zsesKOadU5b9r3eErP
         dJ6ZmKjBCGyhDLyIz6s0Bv4PQCZFVGmDODOIhk5PRCp7YaCtD7PUF+2ZHkOstquZrZgX
         FBVQ==
X-Gm-Message-State: AAQBX9cRDdtW2VjcBORdDWKahIuJe6i83zVF47nCSjWqEduTCAgphSa9
        3wegK8EUsdjYSxSKX/OQGMnr7F/PHvKeggd21Jc5WQ==
X-Google-Smtp-Source: AKy350bryYmMpn9zKsFEcgct5+EQUHVWyheULTKkKFtsPGqzLdeZAzPHxQmw8AKj8PB2gte0L4N5dBt9L7QCo6hHaHI=
X-Received: by 2002:a05:6830:128e:b0:6a1:3fd6:5a0b with SMTP id
 z14-20020a056830128e00b006a13fd65a0bmr1559217otp.2.1681484251278; Fri, 14 Apr
 2023 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230414-rpmsg-wwan-secondary-at-port-v1-1-6d7307527911@nayarsystems.com>
In-Reply-To: <20230414-rpmsg-wwan-secondary-at-port-v1-1-6d7307527911@nayarsystems.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 14 Apr 2023 16:56:55 +0200
Message-ID: <CAMZdPi_+ZiubPtQV36w-1xF9rEvXkpkYAQAyaDhfC1-oWQCS5g@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: Expose secondary AT port on DATA1
To:     jbreva@nayarsystems.com
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 14 Apr 2023 at 13:09, Jaime Breva via B4 Relay
<devnull+jbreva.nayarsystems.com@kernel.org> wrote:
>
> From: Jaime Breva <jbreva@nayarsystems.com>
>
> Our use-case needs two AT ports available:
> One for running a ppp daemon, and another one for management
>
> This patch enables a second AT port on DATA1
>
> Signed-off-by: Jaime Breva <jbreva@nayarsystems.com>
> ---

Could you fix your subject prefix to be compliant with netdev list
[1], and also probably target net-next.

[1] https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Regards,
Loic


>  drivers/net/wwan/rpmsg_wwan_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wwan/rpmsg_wwan_ctrl.c b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> index 31c24420ab2e..e964bdeea2b3 100644
> --- a/drivers/net/wwan/rpmsg_wwan_ctrl.c
> +++ b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> @@ -149,6 +149,7 @@ static const struct rpmsg_device_id rpmsg_wwan_ctrl_id_table[] = {
>         /* RPMSG channels for Qualcomm SoCs with integrated modem */
>         { .name = "DATA5_CNTL", .driver_data = WWAN_PORT_QMI },
>         { .name = "DATA4", .driver_data = WWAN_PORT_AT },
> +       { .name = "DATA1", .driver_data = WWAN_PORT_AT },
>         {},
>  };
>  MODULE_DEVICE_TABLE(rpmsg, rpmsg_wwan_ctrl_id_table);
>
> ---
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> change-id: 20230414-rpmsg-wwan-secondary-at-port-db72a66ce74a
>
> Best regards,
> --
> Jaime Breva <jbreva@nayarsystems.com>
>
