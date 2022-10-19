Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54F6040CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiJSKSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiJSKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:18:04 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106331F9ED
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:58:31 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id a67so24385943edf.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=My/34CAlRo4tk8wH2NooNR7VSYQMNRON6cm2Ue148Ok=;
        b=j4nJNfiwUGiecTrDfvzLp55RXx+12QBER9Ni7XU1ukIj0fkwrjksiRouDNHlWLmh8e
         ikmNf/AKGJ69x2EkaDXghzmkLfAD/ZftDj6EUbAw2s/1HPbvpi6JubP87z9voBji70L3
         /AdvkwpT/6+NUMCDOLeM//uvRNLPs4UGWGOyWY5Qw0/m37B7oRLgZZC1NJFBwtdhrhRV
         gUZPlZvg68Hyx5EMdHlofnD1qjFeS9VRN5nVY7Am91VMPzhqUoQhMd4YiW3UrO0P1diU
         25f2uLyf+8soP8diJ4n+8AeHddW8t1jD5JpGA2SakdXy3Ouy1nGbFPdV7KDUsZghARjR
         FJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My/34CAlRo4tk8wH2NooNR7VSYQMNRON6cm2Ue148Ok=;
        b=LYzHOn8gfdY5l91/t/h2j2zaMitLk8oyu7YRvgqdGrXjRkBzd1rlS/t0eIMW0Nfger
         BgTfCTnteyYdPJqN00MEJwx8DzhSznMzh4X3q0yB4taq/Hq9PXAt6+fcfx55fVWVTVx0
         fTS5ggzedbmQtInmo0OoFCkQQ1BQXH8P4X/eM/6Aj5OsrSLnc8t6b7FudQ8kbrkOnGkw
         BoaD5jLJO9S2jE4pePIVontNrs8EEjlfPhQkkqVO/vV5GDxqtCl43gbEf5LzzXIRlE5A
         1O0Lln8Cfq5WPUkcyH4pXu85glP35gieGx3ErjoBWHNeEg+DpSQlK9Xn6aXeWeliOxz2
         tLOA==
X-Gm-Message-State: ACrzQf2RYRVdcpZnNWGDhbJ81MXBuRj0OhSPLZm/GtgMRrGCG+jgOlwX
        rkJ4cZrjvc8u/72QTHNQZMx5m6Z9FFVganAr1+I=
X-Google-Smtp-Source: AMsMyM5yg1PfTrRlbLHHVfywZPIxUR/jK1gpMuOorHuf2JDiAdW5W6Efz5M+XUuyGGNzO1Q2XFBYZsnPP9NG88S4jdk=
X-Received: by 2002:aa7:d4d9:0:b0:45c:7eae:d8d8 with SMTP id
 t25-20020aa7d4d9000000b0045c7eaed8d8mr6632657edr.254.1666173332999; Wed, 19
 Oct 2022 02:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221017033904.2421723-1-chenhuacai@loongson.cn>
 <20221017033904.2421723-3-chenhuacai@loongson.cn> <87lepcgtvm.wl-maz@kernel.org>
In-Reply-To: <87lepcgtvm.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 19 Oct 2022 17:55:20 +0800
Message-ID: <CAAhV-H6RasMFTpLN6dFG6fryBH4+na84CTe4rAHDB+CN3Oud_Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] irqchip/loongson-eiointc: Add suspend/resume support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Wed, Oct 19, 2022 at 3:23 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 17 Oct 2022 04:39:02 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Add suspend/resume support for EIOINTC irqchip, which is needed for
> > upcoming suspend/hibernation.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-eiointc.c | 31 ++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> > index 16e9af8d8b1e..c68f8de3ae09 100644
> > --- a/drivers/irqchip/irq-loongson-eiointc.c
> > +++ b/drivers/irqchip/irq-loongson-eiointc.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/syscore_ops.h>
> >
> >  #define EIOINTC_REG_NODEMAP  0x14a0
> >  #define EIOINTC_REG_IPMAP    0x14c0
> > @@ -301,6 +302,35 @@ static struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group
> >       return NULL;
> >  }
> >
> > +static int eiointc_suspend(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void eiointc_resume(void)
> > +{
> > +     int i, j;
> > +     struct irq_desc *desc;
> > +     struct irq_data *irq_data;
> > +
> > +     eiointc_router_init(0);
> > +
> > +     for (i = 0; i < nr_pics; i++) {
> > +             for (j = 0; j < VEC_COUNT; j++) {
> > +                     desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
> > +                     if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
> > +                             irq_data = &desc->irq_data;
> > +                             eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
>
> Changing the affinity without holding the irq_desc lock? What makes
> this safe?
Yes, holding the lock is needed, thanks.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
