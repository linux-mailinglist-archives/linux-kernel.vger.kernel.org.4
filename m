Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD59F73A529
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjFVPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFVPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:35:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3713619A9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:35:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9881b9d8cbdso140474866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687448145; x=1690040145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCJtFVbQmWr5EgIJhT94gUY8yhPOGjXjqTeD+3ohv7c=;
        b=lfczscwwacsM8/ss907z0EjEraCevvEZ0ZaQIl6S9zP0AorIURu0PqSbOf0sJfxNKn
         MllKAwSlrA12xQcXHyk5tw5lT0kqlliYrlzylrr5uhJYUvL29R5/AchfE6orYJMnIK5u
         Ep49JWaPN8CzNmXrp+QTz0dFP5ASVQq/ZdaPbTTzrPKBG89R5FCyCGfmkLVfxoorbXDg
         WdfpH2T7ZeJODTt94ySr/pNHH6+OIXIt134m8X4+sGA02HIB3NFoT2GDglv1+uQcevzn
         EkLg/CP9htyRUB8erTDsRYsZbVuJ8OLy8WMt6Wh57LjvFjVreKii7gUt8NrWXO+BrcxJ
         BuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687448145; x=1690040145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCJtFVbQmWr5EgIJhT94gUY8yhPOGjXjqTeD+3ohv7c=;
        b=C99qQjQc30m5dC7p8gwbKaPFkLbOL47Q/J4ll0y5VJoTqSGeOGpz3Z9suIF8m+Mr7d
         0Ag7sS5/x4dt6shl6SJsrXaKAPxfcn3QEK2wqT+Nup6kWDb+mO9M06gre5MdWpjlUGkG
         Yu5WF7xnVW5dk7Zq5NuLaN9jJUIl17UqKaIALLYkz/bq37ah9N3fQlVJSJWveC3mAk3h
         xW2BjAPtgbNfxDoM19S0s3yGyA5XDdnJHCo1yGtTYcvWjqPU5MW2R0LsEIiAK6w2amHM
         Yh/6OsGx5XTXPR4B1MG71cpE+HgS72Zh8VOS1bK6Il8oKT8tnuAhk+vVMJWw83fpdsn/
         BUKw==
X-Gm-Message-State: AC+VfDy0cIbRxuQDsdx5Rtkgp7lZ4Cuwq/DWyMx3abef4sLs+7Ytqy/w
        IR3efGkDdIuLxEb2RbwHolo=
X-Google-Smtp-Source: ACHHUZ6XOu/6r3lkluIOL9PMRfrvadT3toBDwUa8rJYbDs8kbVpzA8SShvfNy+WA1KzjWdyjUazJdA==
X-Received: by 2002:a17:907:360a:b0:982:a022:a540 with SMTP id bk10-20020a170907360a00b00982a022a540mr19674589ejc.11.1687448145354;
        Thu, 22 Jun 2023 08:35:45 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id ju15-20020a17090798af00b009788554ad10sm4833322ejc.138.2023.06.22.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:35:44 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     martin.fuzzey@flowbird.group
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, benjamin.bara@skidata.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH v2] regulator: da9063: fix null pointer deref with partial DT config
Date:   Thu, 22 Jun 2023 17:35:24 +0200
Message-Id: <20230622153524.2586521-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622151146.1459250-1-martin.fuzzey@flowbird.group>
References: <20230622151146.1459250-1-martin.fuzzey@flowbird.group>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Jun 2023 at 17:11, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
> When some of the da9063 regulators do not have corresponding DT nodes a null
> pointer dereference occurs on boot:
> 
> [    1.559034] 8<--- cut here ---
> [    1.564014] Unable to handle kernel NULL pointer dereference at virtual address
> 00000098 when read
> [    1.578055] [00000098] *pgd=00000000
> [    1.593575] Internal error: Oops: 5 [#1] SMP ARM
> [    1.634870] PC is at da9063_regulator_probe+0x35c/0x788
> [    1.647934] LR is at da9063_regulator_probe+0x2e8/0x788
> [    2.073626]  da9063_regulator_probe from platform_probe+0x58/0xb8
> [    2.079759]  platform_probe from really_probe+0xd8/0x3c0
> [    2.085092]  really_probe from __driver_probe_device+0x94/0x1e8
> [    2.091026]  __driver_probe_device from driver_probe_device+0x2c/0xd0
> [    2.097479]  driver_probe_device from __device_attach_driver+0xa4/0x11c
> [    2.104107]  __device_attach_driver from bus_for_each_drv+0x84/0xdc
> [    2.110402]  bus_for_each_drv from __device_attach_async_helper+0xb0/0x110
> [    2.117295]  __device_attach_async_helper from async_run_entry_fn+0x3c/0x158
> [    2.124369]  async_run_entry_fn from process_one_work+0x1d4/0x3e4
> [    2.130485]  process_one_work from worker_thread+0x30/0x520
> [    2.136070]  worker_thread from kthread+0xdc/0xfc
> 
> This is because such regulators have no init_data causing the pointers calculated in
> da9063_check_xvp_constraints() to be invalid.
> 
> Do not dereference them in this case.
> 
> Fixes: b8717a80e6ee ("regulator: da9063: implement setter for voltage monitoring")
> Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
> ---
> 
> Changes since V1:
>  -  Following review by Mark Brown avoid previous dereferences too.
>     With the GCC versions I tried this didn't cause problems
>     because it only takes the address ie
>         &config->init_data->constraints
>     doesn't fault if config->init_data is NULL (it would without the &)
>     But this behaviour isn't guaranteed and other compilers or compiler
>     versions could behave differently so completely avoid calling the
>     function if config->init_data is NULL.
> 
>  drivers/regulator/da9063-regulator.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index c5dd77be558b..a0621665a6d2 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -1028,9 +1028,12 @@ static int da9063_regulator_probe(struct platform_device
> *pdev)
>                         config.of_node = da9063_reg_matches[id].of_node;
>                 config.regmap = da9063->regmap;
> 
> -               ret = da9063_check_xvp_constraints(&config);
> -               if (ret)
> -                       return ret;
> +               /* Checking constraints requires init_data from DT. */
> +               if (config.init_data) {
> +                       ret = da9063_check_xvp_constraints(&config);
> +                       if (ret)
> +                               return ret;
> +               }
> 
>                 regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
>                                                      &config);
> --
> 2.25.1

Thank you!

As this is the same as I did in my patch[1], which I tested by removing some
LDO DT nodes, feel free to add:
Tested-by: Benjamin Bara <benjamin.bara@skidata.com>

br,
Benjamin

[1] https://lore.kernel.org/lkml/20230419-dynamic-vmon-v4-1-4d3734e62ada@skidata.com/
