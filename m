Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28EF7443B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjF3VCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjF3VCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1E3AB6;
        Fri, 30 Jun 2023 14:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC520617F3;
        Fri, 30 Jun 2023 21:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E82DC433C9;
        Fri, 30 Jun 2023 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688158948;
        bh=VcUOHJR+47uuktJ5ytIptdWQ67g+qS6C8InKoEpNYPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bKdUOjRCwCirUT9q7WtJCF4J3SZ4MFRFD8zaccxrUCFa9mbQEs4fZgvNSunaFSwHS
         11ybRccrlNFDydC4LidgSdsGFXA7rSGVX9439m9ZFKuiJyw/WNoOyg+GKmnSr3ULyi
         wHhqaTJsHXAOUOCB0CP88rjXunxKGHZQNCJkujwp9IlyYNecbajAR7n5nXCcv+pBd0
         xscq2RUpHgoTZpW4VfBOQaINmjy/m8iOmKsAxgavZPUEy+5Qxp+J0WV2yqYc1p3A/T
         B4lnfUMei8c8YgAy1s72TdRRzKQF1QxEjVJiQBSjzJ8Bn08y+Qvs1GD3YMgvhh8+Wh
         4BILoquM3xp7A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b69923a715so36937441fa.0;
        Fri, 30 Jun 2023 14:02:28 -0700 (PDT)
X-Gm-Message-State: ABy/qLZQMOUza1dBcv1cxRIKdEm3+S8Tm5EKYOc156vnFL56E9RtSqP4
        2yr+rGyiUaHst8ih1U0dKIzu9OP34pVfO3XjTg==
X-Google-Smtp-Source: APBJJlFXPs+PM/Yq4ExfSZtrMaxYg8sRjO2RE/Hx0FHDxKM+5ocBDwFMqtPHbTzm605Nqffb+L2iwr7y6OT1M6EjMHQ=
X-Received: by 2002:a2e:3a10:0:b0:2b5:8102:1843 with SMTP id
 h16-20020a2e3a10000000b002b581021843mr3406860lja.18.1688158946181; Fri, 30
 Jun 2023 14:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230609183111.1765507-1-robh@kernel.org>
In-Reply-To: <20230609183111.1765507-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Jun 2023 15:02:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOAK4EzED1fbKiyyv8zzS4A0ZVzHu9Us9RhmFRnPYJpQ@mail.gmail.com>
Message-ID: <CAL_JsqJOAK4EzED1fbKiyyv8zzS4A0ZVzHu9Us9RhmFRnPYJpQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: pmac32: Use of_property_read_reg() to parse "reg"
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:31=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Ping!

>
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cp=
ufreq.c
> index ec75e79659ac..f53635ba16c1 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -378,10 +378,9 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>
>  static u32 read_gpio(struct device_node *np)
>  {
> -       const u32 *reg =3D of_get_property(np, "reg", NULL);
> -       u32 offset;
> +       u64 offset;
>
> -       if (reg =3D=3D NULL)
> +       if (of_property_read_reg(np, 0, &offset, NULL) < 0)
>                 return 0;
>         /* That works for all keylargos but shall be fixed properly
>          * some day... The problem is that it seems we can't rely
> --
> 2.39.2
>
