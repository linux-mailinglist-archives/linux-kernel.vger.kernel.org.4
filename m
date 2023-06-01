Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6171A387
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjFAP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjFAP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:59:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AB9186
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:59:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25691a1b2b8so408318a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685635173; x=1688227173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MuPvAtXgrayU/+paihVmHV/NLsrj/uUfRtuTGAgZxg=;
        b=MNrNgNNLXR0DRNunOBuMjsANe7pVfDPnhXcwtn8rqaqHXcLsKVrSUgwYvSup0e1O4g
         jYMwYxykLARoWtTn4HOMhktO3jX6QReekFssDHQvyyClGC+fwDnifB9SWT1mfSFD47Mo
         ogcNG6YN5AeDcoIceUb1MsHaPK9+CkjVG1XEdvN5xbiJqpOZ7Nq1Oa42VCyYLwvjNKTt
         E1ZrOguOGoWmmIycZENOUD6wep1DU7H0CSnOq6ELJA4XO+O9mslJxZ4Tz2N+0tR1yXTH
         uXtfkaSAujmNNRWbjXRlvvqTtKYHCFGf0Zomdjp1o1lCUINEUlAmD/0XV+AwK1IsEGUd
         2r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635173; x=1688227173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MuPvAtXgrayU/+paihVmHV/NLsrj/uUfRtuTGAgZxg=;
        b=B0i/iTefHekheOQLoo+vBn9BNS7jO8iYV5FDCqev4fDUP5ACKINnAQTlpgyyDfDCPH
         rziuph5g2LeVwR5T35rZs1frbbmHPvYrRqaJa7yFck9C6MhBYlbDejl83BN252m7xWDM
         v+ZyH9Dh4HUh5mooYoBZrlulr3UCobz5x+KvC2wrdN85cb+7T4CSxIanwjhktqNJ9FI/
         Nsiw/gIHysPAeSiCep5wfh7T4UfDMBXEC9GlQIvaHo3UaSLQPUeSSnv0PV5/MEiQ4GoG
         CBO1dnJlTAi/ckM5tbBzfOQOvtlkPJbgDVyQUNPb73sxBzvl02i+U7Iup0AaAVuBUSyL
         cdmw==
X-Gm-Message-State: AC+VfDz9LtO2qY60vo1+btbopZzdnrZMQLU0Dd6x8Er9xvp3lYumb6S6
        yGtuZcjDZCCzXzBHN2mSJPerp5A1ASMuLn74XWZdkQ==
X-Google-Smtp-Source: ACHHUZ6f2M5VSRmCC8uXrz23WnJD1bGhwjOB0DeyvQzUqAYuSD1Lpmr46IQaoMOYA04zRfY76oAQddG79oXmPBtsU5o=
X-Received: by 2002:a17:90b:180b:b0:256:d945:23c with SMTP id
 lw11-20020a17090b180b00b00256d945023cmr4853188pjb.14.1685635173296; Thu, 01
 Jun 2023 08:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230525095807.1379811-1-suzuki.poulose@arm.com>
In-Reply-To: <20230525095807.1379811-1-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 1 Jun 2023 16:59:22 +0100
Message-ID: <CAJ9a7Vi2qwjrL13dUC7AvYpvMwyn9w0nL=OaiDmXt3-+aiL9NA@mail.gmail.com>
Subject: Re: [RFC PATCH] coresight: etm4x: Match all ETM4 instances based on
 DEVARCH and DEVTYPE
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        james.clark@arm.com, anshuman.khandual@arm.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        frowand.list@gmail.com, linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Suzuki,

On Thu, 25 May 2023 at 10:58, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> All,
>
> This is an RFC patch to allow all ETM4 instances to be detected via AMBA driver
> without having to add the PIDs to the list. The AMBA driver already supports
> checking the DEVTYPE and DEVARCH registers for CoreSight components. This patch
> adds a pid,mask value that is bound to match all PIDs (with PIDR2.JEDEC field
> mandated to be RA0).
>
> With this patch, we wouldn't need to add the PIDs for newer CPUs to be able to
> use them. An entry in the device tree is all we need. The only side effect of
> this patch is :
>     If a DT description exists for an ETM and the CPU ETM has an erratum, the
>     driver may still probe it and use it. But then the DT shouldn't have
>     described it in the first place.
>

Don't think this is an issue.

In the previous mechanism, with an ETM with an erratum - or indeed
need of some arch specific extension as we allow now - someone would
have added the PID - tested it, hit the erratum, and would have to
investigate and fix according to what is required. This changes
nothing in terms of handling errata on ETM hardware - it just removes
the add PID step.

For new ETM that work out of the box, this saves time re-spinning the
driver every time - which is kind of what we want from device tree!

I'd go for it.

Moreover, the same principle could be added to the CTI drivers -
though these are generally pretty standard anyway (i.e. based on
Coresight Soc 600/400), so may be no pressing need for this right now.

Mike



> Thoughts?
>
> Suzuki
>
> ---8>---
>
> coresight: etm4x: Match all ETM4 instances based on DEVARCH
>
> Instead of adding the PIDs forever to the list for the new CPUs, let us detect
> a component to be ETMv4 based on the CoreSight CID, DEVTYPE=PE_TRACE and
> DEVARCH=ETMv4. This is already done for some of the ETMs. We can extend the PID
> matching to match the PIDR2:JEDEC, BIT[3], which must be 1 (RA0) always.
>
> Link: https://lkml.kernel.org/r/20230317030501.1811905-1-anshuman.khandual@arm.com
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: frowand.list@gmail.com
> Cc: linux@armlinux.org.uk
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          |  5 +++++
>  drivers/hwtracing/coresight/coresight-priv.h  | 19 +++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 4c15fae534f3..8a2e24d5686a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2260,6 +2260,11 @@ static const struct amba_id etm4_ids[] = {
>         CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
>         CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
>         CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
> +       /*
> +        * Match all PIDs with ETM4 DEVARCH. No need for adding any of the new
> +        * CPUs to the list here.
> +        */
> +       CS_AMBA_MATCH_ALL_UCI(uci_id_etm4),
>         {},
>  };
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 595ce5862056..72ec36c9232c 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -193,12 +193,27 @@ extern void coresight_remove_cti_ops(void);
>         }
>
>  /* coresight AMBA ID, full UCI structure: id table entry. */
> -#define CS_AMBA_UCI_ID(pid, uci_ptr)           \
> +#define __CS_AMBA_UCI_ID(pid, m, uci_ptr)      \
>         {                                       \
>                 .id     = pid,                  \
> -               .mask   = 0x000fffff,           \
> +               .mask   = m,                    \
>                 .data   = (void *)uci_ptr       \
>         }
> +#define CS_AMBA_UCI_ID(pid, uci)       __CS_AMBA_UCI_ID(pid, 0x000fffff, uci)
> +/*
> + * PIDR2[JEDEC], BIT(3) must be 1 (Read As One) to indicate that rest of the
> + * PIDR1, PIDR2 DES_* fields follow JEDEC encoding for the designer. Use that
> + * as a match value for blanket matching all devices in the given CoreSight
> + * device type and architecture.
> + */
> +#define PIDR2_JEDEC                    BIT(3)
> +#define PID_PIDR2_JEDEC                        (PIDR2_JEDEC << 16)
> +/*
> + * Match all PIDs in a given CoreSight device type and architecture, defined
> + * by the uci.
> + */
> +#define CS_AMBA_MATCH_ALL_UCI(uci)                                     \
> +       __CS_AMBA_UCI_ID(PID_PIDR2_JEDEC, PID_PIDR2_JEDEC, uci)
>
>  /* extract the data value from a UCI structure given amba_id pointer. */
>  static inline void *coresight_get_uci_data(const struct amba_id *id)
> --
> 2.34.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
