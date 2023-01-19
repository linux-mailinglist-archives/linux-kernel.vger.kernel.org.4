Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0A6734EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjASJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjASJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:59:04 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064B53E41;
        Thu, 19 Jan 2023 01:59:03 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id u7so884592qkk.10;
        Thu, 19 Jan 2023 01:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+Zs6gnnTdAd+D97a2ATi7zK4ycLCkd6CidyqSInY1Y=;
        b=UVB6W5a+FK5ArV85JrvGH+fE1PJJGKjDzgy1NM486w13TwHk09pj5TYZLiLQrOF1b4
         MS3WsRoatTuycWVrj1100PTaERrfi7aWgxiHRIleKWvWpWwjbpK1V6ystWsu6+C4crzv
         uzOwMMGk8+L776v0tHNMH8NOcC0DdlaNDijt6y3Nq2aB+xp9ljnxGEpszBfOdrspGRRl
         7nvxbGmx55WuywyrJyfoUykAmn6yFSwHMf1kb8iwc/mrrZymEpEJBizZlT+jupS8NUIt
         JtUpRQ5rJnOgHxXQj6/lTFlLpSjm+FrFhzEwbUTKK2IvDwrlBw77W7v/J5FNOV1WtmFs
         3X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+Zs6gnnTdAd+D97a2ATi7zK4ycLCkd6CidyqSInY1Y=;
        b=4yYeCSwRykGF4aXE02uVmJDyCAIIovgchOeGY78P4vKKmFCm3Up0zImd1KNYQXL2FG
         ZwpDMkqfwA/ibMJSFMta5cXeKSUkY8QrXl6DEocVbOxccTtXq1pg2wscwmx+/2voxaRw
         ECnTdyQKWsaWcdgw6VfaGNtxsfnwVJgwJPRP0TVdgoC3Tkl95ighzkIl5x8j5RYduu/v
         MDWCtPy6i8I5DBkazwSfV8s86Jlt5GT2k21JqX5+IV6+CVmmAJMhrPn+YFX5/iI9Bq8+
         +WUYi8aWu8u2YZcYaPiRmLIxGpx2A1qxmOQcHZuTTpgejwPXLvSsZXVmS7gG0ln0tHyN
         IRVw==
X-Gm-Message-State: AFqh2koj4hbNC21N8JEcqyGNpjA/8quk2rAakVorDhIexG9+FIh6d7Zu
        0T15XWplC+VwIEWlbVvZEVZ7q3F4lDPbAISn0rg=
X-Google-Smtp-Source: AMrXdXuo4ZrtXMR/Q2FSoFIwK22LeSmwFHyHKtY1qPpJwahsDcF2y2KerSe48P74eOdW7USYk6MQHUExeU9LjMrUSIQ=
X-Received: by 2002:a05:620a:56d:b0:706:5fba:6192 with SMTP id
 p13-20020a05620a056d00b007065fba6192mr581153qkp.383.1674122342460; Thu, 19
 Jan 2023 01:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20230119035136.21603-1-blarson@amd.com> <20230119035136.21603-12-blarson@amd.com>
In-Reply-To: <20230119035136.21603-12-blarson@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Jan 2023 11:58:26 +0200
Message-ID: <CAHp75VfurZMfRbqDt7WRY368uu4NM3r2a6SDCogOukBZN5J8yQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/15] spi: dw: Add support for AMD Pensando Elba SoC
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com, arnd@arndb.de,
        brad@pensando.io, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 5:52 AM Brad Larson <blarson@amd.com> wrote:
>
> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.  The Elba DW_SPI instance has two native
> CS signals that are always overridden.

...

> +struct dw_spi_elba {
> +       struct regmap *syscon;
> +};

Why can't struct regmap be used directly?

...

> +static void dw_spi_elba_override_cs(struct dw_spi_elba *dwselba, int cs, int enable)
> +{
> +       regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
> +                          ELBA_SPICS_SET(cs, enable));

> +

Redundant blank line.

> +}

...

> +               dev_err(&pdev->dev, "failed to find %s\n", syscon_name);
> +               return -ENODEV;

return dev_err_probe();

...

> +               dev_err(&pdev->dev, "syscon regmap lookup failed\n");
> +               return PTR_ERR(regmap);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
