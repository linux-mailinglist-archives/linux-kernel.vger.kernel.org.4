Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A87272CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjFGXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFGXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:20:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019610EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:20:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1b2ca09b9so69544811fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686179999; x=1688771999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AiCeR7ptlfI6j+KiqyWrQWFndEERMb3CPvsTwhpnG8=;
        b=JplymHULuO0ZSDgko0y3lbWxLIw9kmIHQ3kx2jxN3PQbrq7L94f8QlkLKcvgWKhirW
         iZaNu14CbrGgKMmqUt/0WYPjJaxnf/kxFYGMyWiZmowrw0IeY2cDZ/4YpGpNgoQ16HD8
         Q1V2E5GdNfE8eH4NmjEMt+ddunjaRs23B95fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686179999; x=1688771999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AiCeR7ptlfI6j+KiqyWrQWFndEERMb3CPvsTwhpnG8=;
        b=K4ovqAT+wFD5Oc6lTnMwwI+CkR20J6F1g1wbPYSJjOpBlF+Rbuzj7wKIHKG8HrEl+I
         aK7Sut9KwK7ncc3F3R8RBam8n3DGvH3t4v7jNKF97JpalPtzjkPdysz+BFFtBzQMVHXF
         9ol8u5DpxEvJ72KwxRy/VPvojVZQyH+E5HgM8OCJg9u9e0GdZ+EnT4t6QbMxFjRluSLu
         4kZDZZZnyKwtF2WVTOHJRByl+izj8Le0rndEAmy/X/uAZt8DQ9dnj0Ugln4/HsO5OUY0
         9vgwRzQzKib472GLh71Lde5I/Z569atdkIptj+MuuRXzBp1Kz37xcxTuZ1kQeLhyvcyW
         1wDw==
X-Gm-Message-State: AC+VfDwpMZBE3h6Bpkx6mFaExxtalBxhqzefi0vhKjWtRCoawXvuhJJW
        oktO9QDVOiuTzPb0qEitnOU7f/5/dUfOxncKVF1N
X-Google-Smtp-Source: ACHHUZ4D7xRTYmYYSFjgjkg4pgyGVYsusRQtFORfKo7XPXxHQQAEgfHiH9CWABCGTO7onMXXi/sA+gYmBrWTXaNru0c=
X-Received: by 2002:a2e:9f44:0:b0:2b1:d6bf:d8b2 with SMTP id
 v4-20020a2e9f44000000b002b1d6bfd8b2mr3368419ljk.22.1686179998917; Wed, 07 Jun
 2023 16:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230607112417.782085-1-sunilvl@ventanamicro.com> <20230607112417.782085-3-sunilvl@ventanamicro.com>
In-Reply-To: <20230607112417.782085-3-sunilvl@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Jun 2023 16:19:47 -0700
Message-ID: <CAOnJCU+F8LL_s=nRgWvONAJRK33PyHG=6DV+J9L+uNkT3-A2Jg@mail.gmail.com>
Subject: Re: [PATCH v2 -next 2/2] RISC-V/perf: Use standard interface to get
 INTC domain
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 4:24=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> Currently the PMU driver is using DT based lookup to
> find the INTC node for sscofpmf extension. This will not work
> for ACPI based systems causing the driver to fail to register
> the PMU overflow interrupt handler.
>
> Hence, change the code to use the standard interface to find
> the INTC node which works irrespective of DT or ACPI.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 4f3ac296b3e2..0bc491252a44 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -739,7 +739,6 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, =
struct platform_device *pde
>  {
>         int ret;
>         struct cpu_hw_events __percpu *hw_events =3D pmu->hw_events;
> -       struct device_node *cpu, *child;
>         struct irq_domain *domain =3D NULL;
>
>         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> @@ -756,20 +755,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>         if (!riscv_pmu_use_irq)
>                 return -EOPNOTSUPP;
>
> -       for_each_of_cpu_node(cpu) {
> -               child =3D of_get_compatible_child(cpu, "riscv,cpu-intc");
> -               if (!child) {
> -                       pr_err("Failed to find INTC node\n");
> -                       of_node_put(cpu);
> -                       return -ENODEV;
> -               }
> -               domain =3D irq_find_host(child);
> -               of_node_put(child);
> -               if (domain) {
> -                       of_node_put(cpu);
> -                       break;
> -               }
> -       }
> +       domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> +                                         DOMAIN_BUS_ANY);
>         if (!domain) {
>                 pr_err("Failed to find INTC IRQ root domain\n");
>                 return -ENODEV;
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
