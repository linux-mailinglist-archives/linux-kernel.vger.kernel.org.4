Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC76F7773
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEDUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjEDUuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:50:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE7F11544
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:50:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24de9c66559so753345a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1683233352; x=1685825352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki/0a/hvwKrbevC73y7DQvdxNqgn9S260zdZAiinumA=;
        b=VYMfcdFgnD+gQIQTSbP3tk2oMyC39W1Uta2eXXbGeId9d1wA8reaz7Z36R+yVm5549
         VYet11nKae70FwanQAg1yRWDXT229yQXYVTmSoJKiEQrfkRZYgS5JUUDZa+OReHlR02Q
         N6l1Z4MmNSPqzSuuhBiybx/x+X9yCwQl2TWOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233352; x=1685825352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki/0a/hvwKrbevC73y7DQvdxNqgn9S260zdZAiinumA=;
        b=dwBBLLMz8sHY2jjqGb9+Ym4Rf6m0L13RVl8phZm2pup2aaUbJfYC/maiwt/dBChNNr
         o80ptFF5vaarxIkX/l4ieQSq0kh6l7QQY1t+YdGrV3Wq79hsMlnJh2Irxsi0cysgt3N5
         qrzrS04NNYHFvuUwBwDt94NyM28po8RRsdl1HpJEmhN/M27hr6dGE9jFcEe6dloi/DZ6
         zXS+4l4+QwCtZVHwHm+/I6LHLEiOajo170U4I9c0YHCiZDUvORPgjz1i3mc+XLGPRT+R
         I6GX5hvAAiltE19HooAdwqJV3eqNkMA0Swi1pqIoFFuF5aeQ8+3CWVba4FF6ZFnyA432
         TvmA==
X-Gm-Message-State: AC+VfDyrpqGujVlIBdUkdOZgBsaEIWnKD68nvG1BnVD+wbLhfVnmcaCo
        hJBsNMCa4C4NLH7O0cztMkhvn7Zwo7G7gbvyJlMF
X-Google-Smtp-Source: ACHHUZ5ln6K5ET6JAdjO6RsquM8rbPiu+Sp1q5hxLySx7uHWllujbHXdcaG0WikkygHi8ATA1fCOH+bVxLH6i1eJbxY=
X-Received: by 2002:a17:90a:fb50:b0:24b:3295:3e23 with SMTP id
 iq16-20020a17090afb5000b0024b32953e23mr3214366pjb.19.1683233352246; Thu, 04
 May 2023 13:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145453.981767-1-v.v.mitrofanov@yadro.com>
In-Reply-To: <20230504145453.981767-1-v.v.mitrofanov@yadro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 5 May 2023 02:19:00 +0530
Message-ID: <CAOnJCULThWh8RsDX9JHhYYGq_SyrG+jJcrp=UciqDPd73BoFtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] perf: RISC-V: Limit the number of counters
 returned from SBI
To:     Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Cc:     linux@yadro.com, Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, May 4, 2023 at 8:25=E2=80=AFPM Viacheslav Mitrofanov
<v.v.mitrofanov@yadro.com> wrote:
>
> Perf gets the number of supported counters from SBI. If it happens that
> the number of returned counters more than RISCV_MAX_COUNTERS the code
> trusts it. It does not lead to an immediate problem but can potentially
> lead to it. Prevent getting more than RISCV_MAX_COUNTERS from SBI.
>
> Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> Changes in v2:
> - Add new line
> - Substitute pr_warn for pr_info
>
>  drivers/perf/riscv_pmu_sbi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 70cb50fd41c2..9d07af2b6be0 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -868,6 +868,12 @@ static int pmu_sbi_device_probe(struct platform_devi=
ce *pdev)
>                 goto out_free;
>         }
>
> +       /* It is possible to get from SBI more than max number of counter=
s */
> +       if (num_counters > RISCV_MAX_COUNTERS) {
> +               pr_info("SBI returned more than maximum number of counter=
s\n");

Being a little verbose to provide a clear message ?
"Limiting the number of counters to %d


> +               num_counters =3D RISCV_MAX_COUNTERS;
> +       }
> +
>         /* cache all the information about counters now */
>         if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
>                 goto out_free;
> --
> 2.37.2
>
>

Otherwise, LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>


--
Regards,
Atish
