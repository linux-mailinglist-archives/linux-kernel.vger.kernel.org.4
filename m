Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01B6C266C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCUAlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUAlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:41:20 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EBB279B0;
        Mon, 20 Mar 2023 17:41:19 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id c10so4943016vsh.12;
        Mon, 20 Mar 2023 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679359278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM3QZO6xoSFJGtEBFqPUFw6XBUQqTrnKng1a87SyblQ=;
        b=g+PjSFQv4G3OrS8SycsR671jcutjTajQjPRI61kYf/PQVVB8kspynAhp2uk9tuP12r
         gbkDWFSWjrnRxC2Gzr8KDi9yDKhGtkvCOuYayv0Yv3wShpNvXeqPmQDuqqeLASQxvZAh
         lcYcq/agnZthDxQrlPxX1CTszp6wvSusqtrjvfsfgqnbsodkR+T+DtKG4WQ86VHib26j
         vvrsyyV08q30VNCLK0cMQBRX75zS2D7FnJhATPmWzB3PUxBRZdpuwWTRlYn5IkpJ2WdF
         QtlkNUhGUswB0KIEmKM9U1cIjG7BDDQuFK2gXyzihyyB11pofkPjohioJslai5SdNCl1
         IiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679359278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM3QZO6xoSFJGtEBFqPUFw6XBUQqTrnKng1a87SyblQ=;
        b=fCyH+5Gy1/5eZhooD49hH2sW9dcyVk8qEbf8VqKXIEzf7GY7YsiXowJUQDxB692vOF
         CvOpTr2gH2rajBtw/Elc8zL0NFBFfhDTT0+LGn3WZIC+CUc+ADQI2Qt8LMCD50h/ho55
         ibtmMjEuPNo45Hd+qLjp9ihyvNJv88tplCMuWenkciuG4wf/Q1oMBXspT8s1WaIS8/2v
         JVI4nuF+VLk4lh2fBguhtzSXeMqulygqQjR7WlxGjvKW7xMYXpn6GCN6M5JoEp52ouX+
         orSMiDoY5LNgBA5H/B2X04+fkjbYUst9UhLASLoMOkOkKs4lo9L/Y0YLdlRTYewbIEQm
         vDCw==
X-Gm-Message-State: AO0yUKV59COiZuI6M9aidHawwmT0nzXcTBSMIFPk6u8RiGHewSKOSXIP
        Pzo+IgMYxs6PwAmHLqSJTvu31vlv4EAA5D/gGwkp7J5U
X-Google-Smtp-Source: AK7set/qNnDNyLGyZ6P4oQQ6aDb3PSDcxfXjZSG/Cn3Tc8grkYuo/UkP6zjlCsBpiXRudkBVJulRtNsHIcosG+8NZl0=
X-Received: by 2002:a67:ca9a:0:b0:402:999f:51dd with SMTP id
 a26-20020a67ca9a000000b00402999f51ddmr557968vsl.3.1679359278115; Mon, 20 Mar
 2023 17:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212029.3154407-1-david.e.box@linux.intel.com>
In-Reply-To: <20230320212029.3154407-1-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Mon, 20 Mar 2023 20:40:47 -0400
Message-ID: <CAE2upjTu98gf9EWKV1X1tP9q7M+vWtniGri+ccgj3BTnh+2QDQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: Alder Lake PCH slp_s0_residency fix
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     rajvi.jingar@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andy.shevchenko@gmail.com,
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

Looks good to me.  Just a nit, maybe change the subject to "Fix Alder
Lake S0ix reporting" or something like that.

Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

On Mon, Mar 20, 2023 at 5:20=E2=80=AFPM David E. Box
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
>
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
> +        * programs have the legacy SLP_S0 residency counter that is usin=
g the 122
> +        * usec tick.
> +        */
> +       const int lpm_adj_x2 =3D pmcdev->map->lpm_res_counter_step_x2;
> +
> +       if (pmcdev->map =3D=3D &adl_reg_map)
> +               return (u64)value * GET_X2_COUNTER((u64)lpm_adj_x2);
> +       else
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
Thanks,
Rajneesh
