Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E576CAB91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjC0RKg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 13:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjC0RKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:10:17 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2184696;
        Mon, 27 Mar 2023 10:09:43 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id er18so27854570edb.9;
        Mon, 27 Mar 2023 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=916y5uBFwWgOo9alDh+0q8lvXTnxrYU+/IU/mAeJkWc=;
        b=0A4bKicBw3OVXe1hkC02o9BBH13efEtdDb+1BSIsCJ0MGcATYu2BfSjK1gw+ELwQS2
         a4KCH9sj8KmtJHRxz1N+5AhNOgupgWw1LtDxi/bhiAQaySmxorX/L6dZAIMwyWRQrSnA
         GknkHAjc8bXFZUuzQvWPuIVrZC+2kYWByNhQw/IdvXlTSgDu1sx+jOaRCMpPyxQxb2dG
         JueBkjQeT3XlGDBK/NjELoVSNKS0/D1tszLiMZVHtAhUFl4TkvLoPS1cBDewYauc1F7N
         ubYdbS4HkW4eeaubLLmKHSxt34kjdo49MCFCDpTBu6r1xPpJTG3OVwDWt6jTkHl+iCle
         UrhQ==
X-Gm-Message-State: AAQBX9essL3M38COOhRUm3bvldGThoEsklp5L5PTeHmzYtOqOOy1XPk7
        bv8HNe5UsFbZBEafmbb0w19Kng2tikpg8qvVvPWlhZkx
X-Google-Smtp-Source: AKy350YIAgoU5/pPhgYFHzwE54SIN2M00utwdiDdeoXlDJPlxpp6WHnTBlVa0Tn3T0Sq5dCVTup4C6TRcUIQImKqm20=
X-Received: by 2002:a17:906:5fca:b0:930:310:abcf with SMTP id
 k10-20020a1709065fca00b009300310abcfmr6216312ejv.2.1679936982247; Mon, 27 Mar
 2023 10:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144703.1541888-1-robh@kernel.org> <CAPDyKFoVUQEmseNT+dZFJDfwh7ijTwUs5_NckpZLhRQ=VuFpFQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoVUQEmseNT+dZFJDfwh7ijTwUs5_NckpZLhRQ=VuFpFQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:09:30 +0200
Message-ID: <CAJZ5v0hx_zQj+JHdgkvHaq4C_UVqNAH_8ANF-v4fEmRWKyRCMA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Use of_property_present() for testing DT
 property presence
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 6:47 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 10 Mar 2023 at 15:47, Rob Herring <robh@kernel.org> wrote:
> >
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties. As
> > part of this, convert of_get_property/of_find_property calls to the
> > recently added of_property_present() helper when we just want to test
> > for presence of a property and nothing more.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rafael, can you please pick this via your tree.

Done (queued up for 6.4), thanks!

> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
> >  drivers/cpuidle/cpuidle-riscv-sbi.c   | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 6ad2954948a5..e875ddadc51b 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -165,7 +165,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
> >          * initialize a genpd/genpd-of-provider pair when it's found.
> >          */
> >         for_each_child_of_node(np, node) {
> > -               if (!of_find_property(node, "#power-domain-cells", NULL))
> > +               if (!of_property_present(node, "#power-domain-cells"))
> >                         continue;
> >
> >                 ret = psci_pd_init(node, use_osi);
> > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > index be383f4b6855..1fab1abc6eb6 100644
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -497,7 +497,7 @@ static int sbi_genpd_probe(struct device_node *np)
> >          * initialize a genpd/genpd-of-provider pair when it's found.
> >          */
> >         for_each_child_of_node(np, node) {
> > -               if (!of_find_property(node, "#power-domain-cells", NULL))
> > +               if (!of_property_present(node, "#power-domain-cells"))
> >                         continue;
> >
> >                 ret = sbi_pd_init(node);
> > @@ -548,8 +548,8 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
> >         for_each_possible_cpu(cpu) {
> >                 np = of_cpu_device_node_get(cpu);
> >                 if (np &&
> > -                   of_find_property(np, "power-domains", NULL) &&
> > -                   of_find_property(np, "power-domain-names", NULL)) {
> > +                   of_property_present(np, "power-domains") &&
> > +                   of_property_present(np, "power-domain-names")) {
> >                         continue;
> >                 } else {
> >                         sbi_cpuidle_use_osi = false;
> > --
> > 2.39.2
> >
