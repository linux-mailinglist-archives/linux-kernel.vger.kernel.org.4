Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC8609A16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJXFyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJXFyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BC5852B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D3861012
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82540C4347C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666590845;
        bh=IdeoKRp7CnTeQycf+9JLsdNh6b3jxG4J8xktr1nYokc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cLsmSRL7yxCsgsZYI4pkwM4eu2stTLbzCozg1hw8x6YBv7W3s0z2Kbaw5KCs7xjrt
         new2b7/zUlv/NgqN0ac3LfNw87n4B/V8TuhDvpJdNZZ8RnHM/BbxG4zVW0LQ7m1WA3
         0QFUi+gjlBZ2v2A9jnK6l3SU/81kJudtgAUdLkcHbiNvT1u0a9z7tMEJv+z5Y8Ewtn
         LvYTIWCAbi70BdVdzrLGYGct48kT8tg85q0YZ9yfmyTZQH9ODF2aZqK+xl894gBVBv
         CrNcmum/oCkE27rwik+Quqh3DT/PdHxZrVIxYzAI3yfTOt6HfwM1MfbiKArdjBnfgJ
         Oy6nZRHh1inQw==
Received: by mail-vs1-f46.google.com with SMTP id h3so6914490vsa.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:54:05 -0700 (PDT)
X-Gm-Message-State: ACrzQf1JaksRGeKQOBOA0gI45xJ6iUjcAEtEDpjh55fBIT45FIODxSBD
        GR5/BFgG3X0n+acvm07s3OVCoPFjx52X1mGx/Ck1uQ==
X-Google-Smtp-Source: AMsMyM6r3lhmzECYp5LCoWCOCyKSCy4MMw6xBEcHox8V0neSeitmujt/1h4kOBN101XI1Nv3slbvsWLOegmr2kJxRTI=
X-Received: by 2002:a67:d296:0:b0:3a6:ef66:b4cb with SMTP id
 z22-20020a67d296000000b003a6ef66b4cbmr16546365vsi.30.1666590844366; Sun, 23
 Oct 2022 22:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221020145237.942146-1-luca.weiss@fairphone.com>
In-Reply-To: <20221020145237.942146-1-luca.weiss@fairphone.com>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Mon, 24 Oct 2022 11:23:53 +0530
X-Gmail-Original-Message-ID: <CAHLCerN+-5qKsRmpuF55RdeUMZJZuiZJ-7O4LnM8+QuHJfs0mQ@mail.gmail.com>
Message-ID: <CAHLCerN+-5qKsRmpuF55RdeUMZJZuiZJ-7O4LnM8+QuHJfs0mQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom/temp-alarm: fix inaccurate warning
 for gen2
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 8:23 PM Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On gen2 chips the stage2 threshold is not 140 degC but 125 degC.
>
> Make the warning message clearer by using this variable and also by
> including the temperature that was checked for.
>
> Fixes: aa92b3310c55 ("thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 1 PMIC peripherals")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index be785ab37e53..ad84978109e6 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -252,7 +252,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>                         disable_s2_shutdown = true;
>                 else
>                         dev_warn(chip->dev,
> -                                "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140 C! Configuring stage 2 shutdown at 140 C.\n");
> +                                "No ADC is configured and critical temperature %d mC is above the maximum stage 2 threshold of %ld mC! Configuring stage 2 shutdown at %ld mC.\n",
> +                                temp, stage2_threshold_max, stage2_threshold_max);
>         }
>
>  skip:
> --
> 2.38.1
>
