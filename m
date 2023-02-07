Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CADA68D0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBGHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjBGHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:51:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FACC2E;
        Mon,  6 Feb 2023 23:51:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v13so14217449eda.11;
        Mon, 06 Feb 2023 23:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MAcGBhfYJH12s1m6Mlrfjjm34y3tTLoDEvIT2WAfMg=;
        b=d7K7xElfgp/OSqI7i4n2yCI8yumpN7UeyLpjtJx0sV/FpiLD/636yAvtiMkTtkYb0l
         ucDlBQjpSjRU/+aOWJzRHVKBDZmOhA9zcBhNG5jaISqPzCREvE8uZC2fePI4uuhZFVb3
         ZVouoHp1n3OcwIk5MiJh0HjBTnFDhTrgYxHmdndZjz9aHrNYR1jEt9EX39P/tut7eww2
         ZcW5YPGlY2CrQTQvywR1fryKusmAXif+bU4ox7LT3G7pbNcV0JmP5H0Igll2IULkiee4
         v+Wj5EP7kCIfF1E2g0QBph3fJfdfQTZAzVt/QiF+meDGsqk7AxQoWo+UjQZk24PGorhf
         JxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MAcGBhfYJH12s1m6Mlrfjjm34y3tTLoDEvIT2WAfMg=;
        b=hrFA4I0jm//HYLjjbajuD+Bk7sHl+TisG3n98PztbBeh64qsPTj+Q6HbBJVTQgQxdO
         YkxuvkqZ5yTecrSC+ijKernYyCWqoyMHUSNSHPy55ier4Yw+Lop+uTkh864dfpt3RqD3
         hhSYWuel2uv7oZ7p0f2N+dWFzFteDexJaqtVL3K6Q7qcCI1MuoijxltB3nuWcyl7+UDy
         EkwyFdArK6n8AF/CamaMM7at6AYYx/CY+eCyqCaaucauHnReMCO6miivMZU6zl9VaoJb
         XD4ytQqrPT/jRGwl99ZudynxlWRvAf1cJWzxXFt2CNUdnUDBOUJWWH+pU/dxNDEdmVGg
         GsJg==
X-Gm-Message-State: AO0yUKUjlmyBwSovbanBxQ3OBIXYwH5ECcZQolhSp3Jxvc04s/9KwUmU
        0zNRTIfkM+jOOYb4JLhu9qrCC53MWVEPNoDNCmw=
X-Google-Smtp-Source: AK7set9lt5j+w095nFTUJw9kawQv3h15WZBR3heYuhLpaFmwnyQ54oO5vLiD88vSYWR/e266zEZphxYcff6g5Hda/As=
X-Received: by 2002:a50:8a83:0:b0:4aa:9903:ec5f with SMTP id
 j3-20020a508a83000000b004aa9903ec5fmr656184edj.54.1675756314187; Mon, 06 Feb
 2023 23:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com> <20230207014207.1678715-13-saravanak@google.com>
In-Reply-To: <20230207014207.1678715-13-saravanak@google.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Tue, 7 Feb 2023 10:51:41 +0300
Message-ID: <CALHCpMgC55uTnZKPGdKmSX1f0++bSLp2odBp5gQ1kmg90JuQwQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] mtd: mtdpart: Don't create platform device
 that'll never probe
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
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

=D0=B2=D1=82, 7 =D1=84=D0=B5=D0=B2=D1=80. 2023 =D0=B3. =D0=B2 04:42, Sarava=
na Kannan <saravanak@google.com>:
>
> These "nvmem-cells" platform devices never get probed because there's no
> platform driver for it and it's never used anywhere else. So it's a
> waste of memory. These devices also cause fw_devlink to block nvmem
> consumers of "nvmem-cells" partition from probing because the supplier
> device never probes.
>
> So stop creating platform devices for nvmem-cells partitions to avoid
> wasting memory and to avoid blocking probing of consumers.
>
> Reported-by: Maxim Kiselev <bigunclemax@gmail.com>
> Fixes: bcdf0315a61a ("mtd: call of_platform_populate() for MTD partitions=
")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/mtd/mtdpart.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index d442fa94c872..85f5ee6f06fc 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -577,6 +577,7 @@ static int mtd_part_of_parse(struct mtd_info *master,
>  {
>         struct mtd_part_parser *parser;
>         struct device_node *np;
> +       struct device_node *child;
>         struct property *prop;
>         struct device *dev;
>         const char *compat;
> @@ -594,6 +595,15 @@ static int mtd_part_of_parse(struct mtd_info *master=
,
>         else
>                 np =3D of_get_child_by_name(np, "partitions");
>
> +       /*
> +        * Don't create devices that are added to a bus but will never ge=
t
> +        * probed. That'll cause fw_devlink to block probing of consumers=
 of
> +        * this partition until the partition device is probed.
> +        */
> +       for_each_child_of_node(np, child)
> +               if (of_device_is_compatible(child, "nvmem-cells"))
> +                       of_node_set_flag(child, OF_POPULATED);
> +
>         of_property_for_each_string(np, "compatible", prop, compat) {
>                 parser =3D mtd_part_get_compatible_parser(compat);
>                 if (!parser)
> --
> 2.39.1.519.gcb327c4b5f-goog
>

Hi, Saravana!

Now it works pretty well. Thank you so much for your efforts.

> Reported-by: Maxim Kiselev <bigunclemax@gmail.com>
> Fixes: bcdf0315a61a ("mtd: call of_platform_populate() for MTD partitions=
")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Tested-by: Maksim Kiselev <bigunclemax@gmail.com>
