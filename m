Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814F733796
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjFPRoG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:44:05 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD52D50;
        Fri, 16 Jun 2023 10:44:03 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9827714a479so29257266b.1;
        Fri, 16 Jun 2023 10:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686937442; x=1689529442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VniSeHaXdryn43igc7uCKUF+QlXEAOyfI2ccgX3YhpA=;
        b=klWm64JVa/0j3uK1c8pM+EY6eBlVrThCPRE9plGJ7p15u7nJ/ux5Pr3TYJ9I1POaOL
         BDgVqCW84hWdwl5uV79gwfunwKq/RmxHWLSA1gHB9CAWMG22KYNa2OmiTRCyOS7gsmqx
         ebbNr3WswLW+4v8+Uo0DCBd8E3pgWusaOUZ/xdG/h5SiE7DmP1HZVTBZJQzfqB5wRisX
         bTah3+065Mji+3aUzTwVhefGcP/s2g1g68dF1vtybHLDzfyuX35sz1i6x5fK9QQLWvC1
         w9oZIi6E+H/SOxsD2RJjj9o7kfujOGD1zag1PoB48naT8FSjBC6rsjvO999Foybkl/UY
         Chug==
X-Gm-Message-State: AC+VfDyrKLBg/kGu9WePxzS1vEj60EDBggQGmEoOukbPr6kkR1lfBZF1
        E7bhpdCfL3BMct8yefnUIJ9geRh9TcjTFqiHm/ks836C
X-Google-Smtp-Source: ACHHUZ7AaNeLllF+JWr9V7XlGQUBFwMkV9Vo8cviEUp94rd77uR2FXfAMtHB/GQE3nC8aBEp1DVsDKv1H00nRQ1GtoM=
X-Received: by 2002:a17:906:4c:b0:987:2c00:edd0 with SMTP id
 12-20020a170906004c00b009872c00edd0mr67924ejg.6.1686937441939; Fri, 16 Jun
 2023 10:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230530114216.1420790-1-yimingtseng@google.com>
In-Reply-To: <20230530114216.1420790-1-yimingtseng@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 19:43:50 +0200
Message-ID: <CAJZ5v0gmmyLMWwzn8q_DCrKVg6mNJ+mHFcLt2AY8LJJ_4dt7dg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix overflow in genpd_parse_state
To:     YiMing Tseng <yimingtseng@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marscheng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 1:42 PM YiMing Tseng <yimingtseng@google.com> wrote:
>
> Add type casters to prevent 32-bit overflow before assigning to s64
> variables. It allows full 32-bit range support for latency and
> residency.

OK, but is it really a practical problem?

Ulf, what do you think?

> Signed-off-by: YiMing Tseng <yimingtseng@google.com>
> ---
>  drivers/base/power/domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 32084e38b73d..26a04cd8d8dc 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2939,10 +2939,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>
>         err = of_property_read_u32(state_node, "min-residency-us", &residency);
>         if (!err)
> -               genpd_state->residency_ns = 1000 * residency;
> +               genpd_state->residency_ns = (s64)1000 * residency;
>
> -       genpd_state->power_on_latency_ns = 1000 * exit_latency;
> -       genpd_state->power_off_latency_ns = 1000 * entry_latency;
> +       genpd_state->power_on_latency_ns = (s64)1000 * exit_latency;
> +       genpd_state->power_off_latency_ns = (s64)1000 * entry_latency;
>         genpd_state->fwnode = &state_node->fwnode;
>
>         return 0;
> --
