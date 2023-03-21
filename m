Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0906C2A27
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCUGEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:04:36 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E727D6D;
        Mon, 20 Mar 2023 23:04:35 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m15so4330584qkn.9;
        Mon, 20 Mar 2023 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679378675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8okZ+MxCAMhs0+VJVHp9ZPpwKBGBvJ/Czo08rRq3vk=;
        b=cNh1GYqwjZGb02XyXqjdt36rEMx40jrvUPWa8EDbApuA0HdCsLKKxWLkP3qDX01Sbp
         4IJcwzStT5S6svSD23FRU4Ad0rioAwiz+2EaCeTyf9qYH8Y/ADwCvqbY82UeBuquvh5Z
         mmLgKSNyh5Kiy7nzXT7mvkBvbZQU168WoPUwVb8TO0bsgRaYSwn9EyAaW+HN8PvMcpEX
         /QprCgcrLw3Wa+6Ge3jQNanyaXGk+/sqnk8l8g20NQJT3FdZ8vJ330467217p3SCM6Su
         d5FBEcNAs+pmxdnNQBtgixdUmWXTCl1ZkJoxJAemLsLjxLLVoNHOzcmuG9X3DysYg23R
         H3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679378675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8okZ+MxCAMhs0+VJVHp9ZPpwKBGBvJ/Czo08rRq3vk=;
        b=xB1FW6fpSycZakAHMDsMAuAk0q1TTgirqXmOtQE+por94ohRf98wS2YdHv0hx4H22T
         51835K/9ndkm6EjMkNi4+iGMrbNNQEzwcKPuNcl5P6egQTOZMvmP5YqH+lKo4UzKzxEn
         FBMOpC2/IT1VMxpe/A9WIQAE4wE7VcUpvLeRK6RYNIzfTTbiFVafwIxDQrpeW6d6GEg/
         RonEEGVU16M1llaQ/uYOcwkXh4ZPRB06IU1xHoVJ3hht4vdild3e3M6VReWuHyPe7zU+
         L7Bdc42Q/gcQdB+Cfmn3i7dISMeyr6MZ7XAECqSXOZHgWFWgqkBXFqHlXNITwucqj2xB
         6Law==
X-Gm-Message-State: AO0yUKWK6RCX2ns73fi2d9QrY4HYem97pxdi1GxvZumRRZAumP9Y4vRK
        m6YfS5muzXEUnDLhML0MuXSPHZD/nV/abtRKYWQ=
X-Google-Smtp-Source: AK7set/oZRC1c37jEs+UBIZKlHM+uinEOTBoILRWM+qefzYpXQu8ihDwKO1oN6OkqNRx4Ow9gsk/Eui9sC1u9NbnM1g=
X-Received: by 2002:a05:620a:e07:b0:746:7857:d28b with SMTP id
 y7-20020a05620a0e0700b007467857d28bmr295379qkm.14.1679378674833; Mon, 20 Mar
 2023 23:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212029.3154407-1-david.e.box@linux.intel.com>
In-Reply-To: <20230320212029.3154407-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Mar 2023 08:03:58 +0200
Message-ID: <CAHp75VfQVGOj6FsvgddmxBMvkKi=Az29pzovdpzwZvVmj9pCqg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: Alder Lake PCH slp_s0_residency fix
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, rajvi.jingar@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
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

On Mon, Mar 20, 2023 at 11:20=E2=80=AFPM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
>
> For platforms with Alder Lake PCH (Alder Lake S and Raptor Lake S) the
> slp_s0_residency attribute has been reporting the wrong value. Unlike oth=
er
> platforms, ADL PCH does not have a counter for the time that the SLP_S0
> signal was asserted. Instead, firmware uses the aggregate of the Low Powe=
r
> Mode (LPM) substate counters as the S0ix value.  Since the LPM counters r=
un
> at a different frequency, this lead to misreporting of the S0ix time.
>
> Add a check for Alder Lake PCH and adjust the frequency accordingly when
> display slp_s0_residency.

OK!
But one nit-pick below.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: bbab31101f44 ("platform/x86/intel: pmc/core: Add Alderlake support=
 to pmc core driver")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index e489d2175e42..61ca7c37fb02 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -66,7 +66,18 @@ static inline void pmc_core_reg_write(struct pmc_dev *=
pmcdev, int reg_offset,
>
>  static inline u64 pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u3=
2 value)
>  {
> -       return (u64)value * pmcdev->map->slp_s0_res_counter_step;
> +       /*
> +        * ADL PCH does not have the SLP_S0 counter and LPM Residency cou=
nters are
> +        * used as a workaround which uses 30.5 usec tick. All other clie=
nt

microsecond or us or  =C2=B5s (I prefer the latter).

> +        * programs have the legacy SLP_S0 residency counter that is usin=
g the 122
> +        * usec tick.

microsecond or us or =C2=B5s (I prefer the latter).

> +        */
> +       const int lpm_adj_x2 =3D pmcdev->map->lpm_res_counter_step_x2;
> +
> +       if (pmcdev->map =3D=3D &adl_reg_map)
> +               return (u64)value * GET_X2_COUNTER((u64)lpm_adj_x2);

> +       else

Redundant 'else'.

> +               return (u64)value * pmcdev->map->slp_s0_res_counter_step;
>  }
>
>  static int set_etr3(struct pmc_dev *pmcdev)
>
> base-commit: 02c464b73645404654359ad21f368a13735e2850
> --
> 2.34.1
>


--=20
With Best Regards,
Andy Shevchenko
