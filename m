Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA360C3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJYGsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiJYGsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:48:30 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C014BB72
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:48:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-36847dfc5ccso105878477b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JPRRYLjIyOi+l0vP5hB11FlLPptXndDWR57UKLvqVFs=;
        b=k2ppGJjX3Z9j6TEBU4XW5Pue1wIrSncGBXuSj+0p+HIhlsvg2E2i7Aavf8GtZPDOJO
         XWL5Y/6yO+zRbbeMgDCfw1RRc5kTmn4jIdf48odLbcF9WfFYHcx4GHyrdOwMkmvtn3eM
         GurjSDbHq8pWgVpdb1Po3ibPBL8l758BgMfWObmyH84FCyidPk7b1HpM1fvXGq/xEPuU
         m9I0seJTlQM5nPgdAJwAEi0OtRkiCTxyUUp9IRJUnOAv4GCvbVCTw75V3A0WcKhCAgi6
         /OaR0+ChRHCeSu9wdIX7vSj8Q+kf/t5n+MWPZuTIwVMMBR8mJiCxycYlXFokJ0t7CgHO
         Sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPRRYLjIyOi+l0vP5hB11FlLPptXndDWR57UKLvqVFs=;
        b=u7Io8trZ6NqcJSvRTdiK4eAPeUAyJFTuHSk3mok9b5Ficy1YUjjf4JWVoVPRLqEMcx
         cdh9l6Bn/RgeZOMV0vw7GFBEWxqm6/OJ4BntZCZrE7YQgkkGnsYk5h7FLizEUMq/kuki
         gIa+xpOGLNaHCSXk7gqi0oCu45pE8xUuaknKMl8312OLJrPuPMTmX2w4PllzX90y8gUt
         c7qeIwR6c8ZzxvHbtNIJyDZMU4R+86cVsjfuahQYo6SmuNnLJlxyClqPFZRDp2v4XC38
         dGQs6KO7sikMqsCzIEas1PB7/Hk+Gwt4SXB4Basp4Y28Hi9Ub1yorH5dkX1o8Ex+CsaJ
         3q0Q==
X-Gm-Message-State: ACrzQf2urpclUYeGSJbpfRzuOHqbAC4iNUtNK/QM5xhAAsjMyWiCSCaJ
        99RdUZc1z6EdGBakbY/uXaGhbnE5Yv9ZuikNtdtGbg==
X-Google-Smtp-Source: AMsMyM4UxUNUoo9ZHmaxATl7Pl8lKSNiL5vivNDiUqywTNqfL9iXItW/z/XSLcjnJOjq1SXEOg65vMWakQK4L4iTzCc=
X-Received: by 2002:a81:7804:0:b0:369:1074:e2b with SMTP id
 t4-20020a817804000000b0036910740e2bmr22567329ywc.127.1666680508337; Mon, 24
 Oct 2022 23:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221025050608.2635173-1-quic_fenglinw@quicinc.com> <20221025050608.2635173-2-quic_fenglinw@quicinc.com>
In-Reply-To: <20221025050608.2635173-2-quic_fenglinw@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 25 Oct 2022 09:48:17 +0300
Message-ID: <CAA8EJpqQaGwsBKMqqHSqd-jcKsacuamqsd0adxCWTvQcDz9b3Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] spmi: pmic-arb: add support to map SPMI
 addresses to physical addr
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        David Collins <collinsd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 08:08, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
> From: David Collins <collinsd@codeaurora.org>
>
> Add an exported function which can map an SPMI address to the
> physical address range of the registers used to write to that
> SPMI address.
>
> The feature can be used by consumer drivers that need to lock
> down access to certain PMIC peripherals temporarily for certain
> secure use cases.

No-no-no-no. First, typically the API is only accepted together with
the actual API user. It is bad to have an API call that has no users.

Next, the API you are trying to add doesn't match what you have
described so far. Instead of locking the device from the ARB driver,
you are providing the child devices with the wormhole, meaning that
the child device will have know how to program the ARB. This is not
correct. The ARB programming should happen from the ARB driver, not
from the PMIC/etc drivers.

Last, but not least. The API you have tried to add is added as the one
specific to the spmi_pmic_arb. This is usually a very bad practice.
Please rework this as an API that doesn't depend on the backing SPMI
arbiter.

>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  drivers/spmi/spmi-pmic-arb.c           | 104 +++++++++++++++++++++++++
>  include/linux/soc/qcom/spmi-pmic-arb.h |  23 ++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 include/linux/soc/qcom/spmi-pmic-arb.h
>
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 2cf3203b2397..1e7f5a9ff4bc 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spmi.h>
> +#include <linux/soc/qcom/spmi-pmic-arb.h>
>
>  /* PMIC Arbiter configuration registers */
>  #define PMIC_ARB_VERSION               0x0000
> @@ -124,6 +125,8 @@ struct apid_data {
>   *
>   * @rd_base:           on v1 "core", on v2 "observer" register base off DT.
>   * @wr_base:           on v1 "core", on v2 "chnls"    register base off DT.
> + * @wr_base_phys:      base physical address of the register range used for
> + *                     SPMI write commands.
>   * @intr:              address of the SPMI interrupt control registers.
>   * @cnfg:              address of the PMIC Arbiter configuration registers.
>   * @lock:              lock to synchronize accesses.
> @@ -141,6 +144,7 @@ struct apid_data {
>  struct spmi_pmic_arb {
>         void __iomem            *rd_base;
>         void __iomem            *wr_base;
> +       phys_addr_t             wr_base_phys;
>         void __iomem            *intr;
>         void __iomem            *cnfg;
>         void __iomem            *core;
> @@ -180,6 +184,9 @@ struct spmi_pmic_arb {
>   * @irq_clear:         on v1 address of PMIC_ARB_SPMI_PIC_IRQ_CLEARn
>   *                     on v2 address of SPMI_PIC_IRQ_CLEARn.
>   * @apid_map_offset:   offset of PMIC_ARB_REG_CHNLn
> + * @wr_addr_map:       maps from an SPMI address to the physical address
> + *                     range of the registers used to perform an SPMI write
> + *                     command to the SPMI address.
>   */
>  struct pmic_arb_ver_ops {
>         const char *ver_str;
> @@ -196,6 +203,8 @@ struct pmic_arb_ver_ops {
>         void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
>         void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
>         u32 (*apid_map_offset)(u16 n);
> +       int (*wr_addr_map)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> +                          struct resource *res_out);
>  };
>
>  static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
> @@ -972,6 +981,21 @@ static int pmic_arb_offset_v1(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>         return 0x800 + 0x80 * pmic_arb->channel;
>  }
>
> +static int pmic_arb_wr_addr_map_v1(struct spmi_pmic_arb *pmic_arb, u8 sid,
> +                                  u16 addr, struct resource *res_out)
> +{
> +       int rc;
> +
> +       rc = pmic_arb_offset_v1(pmic_arb, sid, addr, PMIC_ARB_CHANNEL_RW);
> +       if (rc < 0)
> +               return rc;
> +
> +       res_out->start = pmic_arb->wr_base_phys + rc;
> +       res_out->end = res_out->start + 0x80 - 1;
> +
> +       return 0;
> +}
> +
>  static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>  {
>         struct apid_data *apidd = &pmic_arb->apid_data[pmic_arb->last_apid];
> @@ -1111,6 +1135,21 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>         return 0x1000 * pmic_arb->ee + 0x8000 * apid;
>  }
>
> +static int pmic_arb_wr_addr_map_v2(struct spmi_pmic_arb *pmic_arb, u8 sid,
> +                                  u16 addr, struct resource *res_out)
> +{
> +       int rc;
> +
> +       rc = pmic_arb_offset_v2(pmic_arb, sid, addr, PMIC_ARB_CHANNEL_RW);
> +       if (rc < 0)
> +               return rc;
> +
> +       res_out->start = pmic_arb->wr_base_phys + rc;
> +       res_out->end = res_out->start + 0x1000 - 1;
> +
> +       return 0;
> +}
> +
>  /*
>   * v5 offset per ee and per apid for observer channels and per apid for
>   * read/write channels.
> @@ -1145,6 +1184,21 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>         return offset;
>  }
>
> +static int pmic_arb_wr_addr_map_v5(struct spmi_pmic_arb *pmic_arb, u8 sid,
> +                                  u16 addr, struct resource *res_out)
> +{
> +       int rc;
> +
> +       rc = pmic_arb_offset_v5(pmic_arb, sid, addr, PMIC_ARB_CHANNEL_RW);
> +       if (rc < 0)
> +               return rc;
> +
> +       res_out->start = pmic_arb->wr_base_phys + rc;
> +       res_out->end = res_out->start + 0x10000 - 1;
> +
> +       return 0;
> +}
> +
>  static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u16 addr, u8 bc)
>  {
>         return (opc << 27) | ((sid & 0xf) << 20) | (addr << 4) | (bc & 0x7);
> @@ -1254,6 +1308,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
>         .irq_status             = pmic_arb_irq_status_v1,
>         .irq_clear              = pmic_arb_irq_clear_v1,
>         .apid_map_offset        = pmic_arb_apid_map_offset_v2,
> +       .wr_addr_map            = pmic_arb_wr_addr_map_v1,
>  };
>
>  static const struct pmic_arb_ver_ops pmic_arb_v2 = {
> @@ -1267,6 +1322,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
>         .irq_status             = pmic_arb_irq_status_v2,
>         .irq_clear              = pmic_arb_irq_clear_v2,
>         .apid_map_offset        = pmic_arb_apid_map_offset_v2,
> +       .wr_addr_map            = pmic_arb_wr_addr_map_v2,
>  };
>
>  static const struct pmic_arb_ver_ops pmic_arb_v3 = {
> @@ -1280,6 +1336,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
>         .irq_status             = pmic_arb_irq_status_v2,
>         .irq_clear              = pmic_arb_irq_clear_v2,
>         .apid_map_offset        = pmic_arb_apid_map_offset_v2,
> +       .wr_addr_map            = pmic_arb_wr_addr_map_v2,
>  };
>
>  static const struct pmic_arb_ver_ops pmic_arb_v5 = {
> @@ -1293,6 +1350,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
>         .irq_status             = pmic_arb_irq_status_v5,
>         .irq_clear              = pmic_arb_irq_clear_v5,
>         .apid_map_offset        = pmic_arb_apid_map_offset_v5,
> +       .wr_addr_map            = pmic_arb_wr_addr_map_v5,
>  };
>
>  static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
> @@ -1302,6 +1360,50 @@ static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
>         .translate = qpnpint_irq_domain_translate,
>  };
>
> +static int _spmi_pmic_arb_map_address(struct spmi_pmic_arb *pmic_arb,
> +                               u32 spmi_address, struct resource *res_out)
> +{
> +       u32 sid, addr;
> +
> +       sid = (spmi_address >> 16) & 0xF;
> +       addr = spmi_address & 0xFFFF;
> +
> +       return pmic_arb->ver_ops->wr_addr_map(pmic_arb, sid, addr, res_out);
> +}
> +
> +/**
> + * spmi_pmic_arb_map_address() - returns physical addresses of registers used to
> + *             write to the PMIC peripheral at spmi_address
> + * @ctrl:              SPMI controller device pointer
> + * @spmi_address:      20-bit SPMI address of the form: 0xSPPPP
> + *                     where S = global PMIC SID and
> + *                     PPPP = SPMI address within the slave
> + * @res_out:           Resource struct (allocated by the caller) in which
> + *                     physical addresses for the range are passed via start
> + *                     and end elements
> + *
> + * Returns: 0 on success or an errno on failure.
> + */
> +int spmi_pmic_arb_map_address(struct spmi_controller *ctrl, u32 spmi_address,
> +                             struct resource *res_out)
> +{
> +       struct spmi_pmic_arb *pmic_arb;
> +
> +       if (!ctrl || !res_out) {
> +               pr_err("%s: Invalid pointer\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       pmic_arb = spmi_controller_get_drvdata(ctrl);
> +       if (!pmic_arb) {
> +               pr_err("Missing PMIC arbiter device\n");
> +               return -ENODEV;
> +       }
> +
> +       return _spmi_pmic_arb_map_address(pmic_arb, spmi_address, res_out);
> +}
> +EXPORT_SYMBOL(spmi_pmic_arb_map_address);
> +
>  static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  {
>         struct spmi_pmic_arb *pmic_arb;
> @@ -1341,6 +1443,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>         if (hw_ver < PMIC_ARB_VERSION_V2_MIN) {
>                 pmic_arb->ver_ops = &pmic_arb_v1;
>                 pmic_arb->wr_base = core;
> +               pmic_arb->wr_base_phys = res->start;
>                 pmic_arb->rd_base = core;
>         } else {
>                 pmic_arb->core = core;
> @@ -1367,6 +1470,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>                         err = PTR_ERR(pmic_arb->wr_base);
>                         goto err_put_ctrl;
>                 }
> +               pmic_arb->wr_base_phys = res->start;
>         }
>
>         dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
> diff --git a/include/linux/soc/qcom/spmi-pmic-arb.h b/include/linux/soc/qcom/spmi-pmic-arb.h
> new file mode 100644
> index 000000000000..adb999d6e246
> --- /dev/null
> +++ b/include/linux/soc/qcom/spmi-pmic-arb.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2020, The Linux Foundation. All rights reserved. */
> +
> +#ifndef _SPMI_PMIC_ARB_H
> +#define _SPMI_PMIC_ARB_H
> +
> +#include <linux/spmi.h>
> +#include <linux/ioport.h>
> +#include <linux/types.h>
> +
> +
> +#if IS_ENABLED(CONFIG_SPMI_MSM_PMIC_ARB)
> +int spmi_pmic_arb_map_address(struct spmi_controller *ctrl, u32 spmi_address,
> +                             struct resource *res_out);
> +#else
> +static inline int spmi_pmic_arb_map_address(struct spmi_controller *ctrl,
> +                               u32 spmi_address, struct resource *res_out)
> +{
> +       return -ENODEV;
> +}
> +#endif
> +
> +#endif
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
