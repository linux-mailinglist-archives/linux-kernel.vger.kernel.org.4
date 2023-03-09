Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21D26B188B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCIBLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:11:36 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A21CB06B;
        Wed,  8 Mar 2023 17:11:35 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y10so526073pfi.8;
        Wed, 08 Mar 2023 17:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678324295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h0BP7xRpMiCpSEztDZ3QdlwVhz3jyLstzHsPlgVJDw=;
        b=NOqnwJENL1Q9PVZRY335mvButCucwaOiAbrXXU/4G4FTRPyagudVZybZ3Fzkl5+jTb
         KhmCff4VZhjDz/xK30mPZqkd9RFRr56gb/owUNTvYgTlX+mrHkKSbEoSnCzeN8c7nkyv
         nfMfltsuON5u0Rs9AFqzXBYHfOqbmUKCjxTQDM5nPNKbDVHSE4HPEo3BHojQl+9iY9Cx
         KGRAszLC4w9aVQzLR8py0w7rJ0akYNmjGng+0I+3JtP1IyIXSMRfkx/2R7ryswa8Tpz1
         TaHI74cO7uobsyvlz14f9VIkOUg7Y6C2jSEoNywD8yUUZ/OBz4DcBxMuYTeWJVpgbfoI
         FXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678324295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h0BP7xRpMiCpSEztDZ3QdlwVhz3jyLstzHsPlgVJDw=;
        b=g4AYSzZL8+7uODLTfehOGEGiu1cTfNVSTeQEtInTxwhkfatqhweaDzNoHmpN/VDv1T
         PBEKKblfCemAmIbtJw50uCi1uvkv8bmLcZ7NlqUkNmV62xsznFnBvBBjPAyVHSeKXl7q
         wug02ReFEwVQ5C8r0pp5emNZjr4pM0TPgBCI9cCrYattnCZXtm8ZCkejdL1+xEY6skDu
         IiWcB6dETjYYt+laohhbouMP9pnUYPzssMwQoR7vP/0ZnGv0jSZio9MB0ltnZ9QwyeB5
         d2OoEoTxxEWIGVqm0/snf3ZJprU1c8rWVZHtpJqdNQmKTaOMmHaR4du8hzQLZVtijr56
         9w/Q==
X-Gm-Message-State: AO0yUKXLKz38JDjvQwy8p1mwxDcnzY9uE4QlG8KIKDXU9IUJMPK8uiia
        j6hv0xHdCj7mTeriwMJmGOM5e6CAiubTJfr/wgs=
X-Google-Smtp-Source: AK7set8G04eAaKT8IT1CwFNzw4sP6YNYzd5eCbQqOutz3SXq0kB0WR8GgDsy9HZpPV+RT2tSY0ISSjlZ8iXC7ruzzow=
X-Received: by 2002:a63:5904:0:b0:503:a26a:2e7a with SMTP id
 n4-20020a635904000000b00503a26a2e7amr6959585pgb.6.1678324294761; Wed, 08 Mar
 2023 17:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20230308214822.1317086-1-daniel.lezcano@linaro.org> <20230308214822.1317086-2-daniel.lezcano@linaro.org>
In-Reply-To: <20230308214822.1317086-2-daniel.lezcano@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Mar 2023 22:11:23 -0300
Message-ID: <CAOMZO5CoYi2MpVLBqoKh7g9Dhjq77KfNy3QQNi2AawjGTrFZpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal/drivers/imx: Use the thermal framework for
 the trip point
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Mar 8, 2023 at 6:48=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:

>         /* do not allow changing critical threshold */
> -       if (trip =3D=3D IMX_TRIP_CRITICAL)
> +       if (trip.type =3D=3D THERMAL_TRIP_CRITICAL)
>                 return -EPERM;
> -
> +

Unrelated change?
