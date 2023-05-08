Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2056FB4E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjEHQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjEHQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:16:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C017949ED
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:16:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f423c17bafso45835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683562592; x=1686154592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPrcBb2Ah0kfOoaFszvDkHKeVnCaFX5eQKXoC29Tzm8=;
        b=7a026Pqh7GkM9PJFh1N/RqFv9MCaJ76Vn0sLpxnUhuQXnFScIwh8xXjLjL3pRuOp31
         QhIvYBUWT9TVEptFtFteta78AdLwfnBPjIONsiwAxHpT3nDpC9e4mhTIO/6+2aHT1Uh1
         Lb7scZfXXpDjHch6ARYEdiqozKOtW4pl57z6hPjf63j5tPxUCYV7nkZ9pvCsj4kHRiey
         K00Z+14yjuvVya5MXoDG8a0e27Khpy1PDe6/RGphW8b/JEZZB0JPj43bCmYE3zJ9VVR9
         fwy4QJaMVuct1ztQv8THE59zXE5MMHSGYmvoZVe5C7mDcQPqiG6WXQUtRx1qttIBo1yr
         avAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683562592; x=1686154592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPrcBb2Ah0kfOoaFszvDkHKeVnCaFX5eQKXoC29Tzm8=;
        b=Re26AqzwADayso1NnNFsPUzw6nRlpJMhgWflpJAK6lKB8z2N5yuXF16aeRSx7i/qfw
         Gu2gAYnM/uCT4/AeIMxekgGJCqFXhmQF+THMxUk7QGISt2cSSiAV0BcRC3laX+QY9X9C
         OpFj65jR4U41HW/xDKc1gDa3CVAflszymYQbGviKuGbPJlLIdmTvkdZRFXmBmHCMNKMP
         /zz4OBHVUrBEC2hmoTG96Lh7XQhYU3dDJAZXLjMqHV+6joyECk3ieVrxHsB1VAX6/w3X
         cwVTC7oLx8/IUgQ34nxj2eoYe84thMSE+v1m3onm9EqE+COa9PwMn0nMyRRu/X+cWrmM
         qq7w==
X-Gm-Message-State: AC+VfDy97vbPLVT4dJUf5lpD1Cr6eSlmxFETQSJP161lknUUUVqEjyyN
        X/j/FxPbS98dIolUR/2eXoMLbHbbmzSGYbFxGX20ZQ==
X-Google-Smtp-Source: ACHHUZ5hFRkJ5iedrb7N0JePgc5+ke55o/q2Hh5UpZffH2mYawRXdkataqjtbiL0ZQIMWnAgWk+A0oe3hbHyu9q23Jk=
X-Received: by 2002:a05:600c:1d02:b0:3f4:2594:118a with SMTP id
 l2-20020a05600c1d0200b003f42594118amr235605wms.2.1683562592077; Mon, 08 May
 2023 09:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230508140206.283708-1-kan.liang@linux.intel.com>
In-Reply-To: <20230508140206.283708-1-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 8 May 2023 09:16:20 -0700
Message-ID: <CABPqkBSczJqEbA8M0HCdeqjddgDqpxapJYVYNuAS+EifJ+v+Dg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/uncore: Correct the number of CHAs on SPR
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 7:05=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The number of CHAs from the discovery table on some SPR variants is
> incorrect, because of a firmware issue. An accurate number can be read
> from the MSR UNC_CBO_CONFIG.
>
> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server C=
HA support")
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Tested-by: Stephane Eranian <eranian@google.com>

>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/uncore_snbep.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index 7d1199554fe3..54abd93828bf 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6138,6 +6138,7 @@ static struct intel_uncore_type spr_uncore_mdf =3D =
{
>  };
>
>  #define UNCORE_SPR_NUM_UNCORE_TYPES            12
> +#define UNCORE_SPR_CHA                         0
>  #define UNCORE_SPR_IIO                         1
>  #define UNCORE_SPR_IMC                         6
>  #define UNCORE_SPR_UPI                         8
> @@ -6448,12 +6449,22 @@ static int uncore_type_max_boxes(struct intel_unc=
ore_type **types,
>         return max + 1;
>  }
>
> +#define SPR_MSR_UNC_CBO_CONFIG         0x2FFE
> +
>  void spr_uncore_cpu_init(void)
>  {
> +       struct intel_uncore_type *type;
> +       u64 num_cbo;
> +
>         uncore_msr_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MSR,
>                                                 UNCORE_SPR_MSR_EXTRA_UNCO=
RES,
>                                                 spr_msr_uncores);
>
> +       type =3D uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CH=
A);
> +       if (type) {
> +               rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
> +               type->num_boxes =3D num_cbo;
> +       }
>         spr_uncore_iio_free_running.num_boxes =3D uncore_type_max_boxes(u=
ncore_msr_uncores, UNCORE_SPR_IIO);
>  }
>
> --
> 2.35.1
>
