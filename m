Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE2602D02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJRNbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiJRNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:31:35 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5BCBFCC;
        Tue, 18 Oct 2022 06:31:29 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id o22so8580519qkl.8;
        Tue, 18 Oct 2022 06:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ht/PxSroHeqM8f9r1nGvOcWIKYTDs4nogQZYcXxwMtY=;
        b=mjizs3yRlIr7Cyy4drNixxx04vsji8u2hUyRBOXMKwnfPjgJ1OJNIH14bQek6pd4yJ
         ibNJCM9lgA+E+dpjOUL//XklTJ+kkX53zrWTjEyBqajo787zdCxxj0AqzrMi2e1UWCf6
         LfhAaBXbAkXnJShwivS1MKJtMelXC49OHjS9ivr+8SJL1pKUiRAfibUcXTYf5O2J2rGf
         8d+TVK1c3Xd4oIaFlTIDj/x1NOapRjBex9/k81wudr7GuW2yqWsG5NyEdGMegOF0dFHV
         nIe3XqPzXaXvDTl7WcvrAzMdwNKFSLw6NHlzYjLwXGdrk5dedeG37Mf2OQXhYn/w5UWZ
         T9aA==
X-Gm-Message-State: ACrzQf2mSpRZbHeuGBoSZok/6B90ujK9Dche8mm+wqqM0hycz3YbHmKx
        dfbFbqys7kg9BY9jM3uI77ZDdWY8R/eGX1b/c5w=
X-Google-Smtp-Source: AMsMyM6VE0mm6MF4xsWZsya+OW3d5FmS7ysd4jFv/2G85Gd/2jyhh4Iwdwvbi7iM6pXxPLfWcwPE2ORvJ3RlctnrNx4=
X-Received: by 2002:a05:620a:158f:b0:6ee:93d5:e249 with SMTP id
 d15-20020a05620a158f00b006ee93d5e249mr1796067qkk.505.1666099888091; Tue, 18
 Oct 2022 06:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221018132341.76259-1-rrichter@amd.com> <20221018132341.76259-7-rrichter@amd.com>
In-Reply-To: <20221018132341.76259-7-rrichter@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Oct 2022 15:31:16 +0200
Message-ID: <CAJZ5v0iweDu6imi_P3eRTTk0Xpzv-swB05fYxmTMAHAjCN2tiA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Terry Bowman <terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 3:24 PM Robert Richter <rrichter@amd.com> wrote:
>
> A downstream port must be connected to a component register block.
> For restricted hosts the base address is determined from the RCRB. The
> RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> get the RCRB and add code to extract the component register block from
> it.
>
> RCRB's BAR[0..1] point to the component block containing CXL subsystem
> component registers. MEMBAR extraction follows the PCI base spec here,
> esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
>
> Note: Right now the component register block is used for HDM decoder
> capability only which is optional for RCDs. If unsupported by the RCD,
> the HDM init will fail. It is future work to bypass it in this case.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

What does this S-o-B mean?  If this person is your co-developer, you
need to add a Co-developed-by tag to clarify that.

> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 79 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 69 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb9f72813067..a92d5d7b7a92 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -9,6 +9,8 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>
> +#define CXL_RCRB_SIZE  SZ_8K
> +
>  static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>         unsigned long flags = CXL_DECODER_F_ENABLE;
> @@ -229,27 +231,82 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  struct cxl_chbs_context {
>         struct device *dev;
>         unsigned long long uid;
> -       resource_size_t chbcr;
> +       struct acpi_cedt_chbs chbs;
>  };
>
> -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> -                        const unsigned long end)
> +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> +                       const unsigned long end)
>  {
>         struct cxl_chbs_context *ctx = arg;
>         struct acpi_cedt_chbs *chbs;
>
> -       if (ctx->chbcr)
> +       if (ctx->chbs.base)
>                 return 0;
>
>         chbs = (struct acpi_cedt_chbs *) header;
>
>         if (ctx->uid != chbs->uid)
>                 return 0;
> -       ctx->chbcr = chbs->base;
> +       ctx->chbs = *chbs;
>
>         return 0;
>  }
>
> +static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
> +{
> +       struct acpi_cedt_chbs *chbs = &ctx->chbs;
> +       resource_size_t component_reg_phys, rcrb;
> +       u32 bar0, bar1;
> +       void *addr;
> +
> +       if (!chbs->base)
> +               return CXL_RESOURCE_NONE;
> +
> +       if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
> +               return chbs->base;
> +
> +       /* Extract RCRB */
> +
> +       if (chbs->length != CXL_RCRB_SIZE)
> +               return CXL_RESOURCE_NONE;
> +
> +       rcrb = chbs->base;
> +
> +       dev_dbg(ctx->dev, "RCRB found for UID %lld: 0x%08llx\n",
> +               ctx->uid, (u64)rcrb);
> +
> +       /*
> +        * RCRB's BAR[0..1] point to component block containing CXL
> +        * subsystem component registers. MEMBAR extraction follows
> +        * the PCI Base spec here, esp. 64 bit extraction and memory
> +        * ranges alignment (6.0, 7.5.1.2.1).
> +        */
> +       addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> +       bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> +       bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +       iounmap(addr);
> +
> +       /* sanity check */
> +       if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> +               return CXL_RESOURCE_NONE;
> +
> +       component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
> +       if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +               component_reg_phys |= ((u64)bar1) << 32;
> +
> +       if (!component_reg_phys)
> +               return CXL_RESOURCE_NONE;
> +
> +       /*
> +        * Must be 8k aligned (size of combined CXL 1.1 Downstream and
> +        * Upstream Port RCRBs).
> +        */
> +       if (component_reg_phys & (CXL_RCRB_SIZE - 1))
> +               return CXL_RESOURCE_NONE;
> +
> +       return component_reg_phys;
> +}
> +
>  static int add_host_bridge_dport(struct device *match, void *arg)
>  {
>         acpi_status status;
> @@ -259,6 +316,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>         struct cxl_port *root_port = arg;
>         struct device *host = root_port->dev.parent;
>         struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> +       resource_size_t component_reg_phys;
>
>         if (!bridge)
>                 return 0;
> @@ -273,19 +331,20 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>         dev_dbg(match, "UID found: %lld\n", uid);
>
>         ctx = (struct cxl_chbs_context) {
> -               .dev = host,
> +               .dev = match,
>                 .uid = uid,
>         };
> -       acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
> +       acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
>
> -       if (ctx.chbcr == 0) {
> +       component_reg_phys = cxl_get_chbcr(&ctx);
> +       if (component_reg_phys == CXL_RESOURCE_NONE) {
>                 dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n", uid);
>                 return 0;
>         }
>
> -       dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)ctx.chbcr);
> +       dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)component_reg_phys);
>
> -       dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
> +       dport = devm_cxl_add_dport(root_port, match, uid, component_reg_phys);
>         if (IS_ERR(dport))
>                 return PTR_ERR(dport);
>
> --
> 2.30.2
>
