Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2331772D8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbjFMEnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjFMEnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:43:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DD3131
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:42:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so7532827a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1686631372; x=1689223372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzwXO5LLinsbc81q9m0mJrThXDrRsGSZgZKBrqcWDhU=;
        b=Re/JoZDdl7WWFhPNRzXIFIPRLlnyd5pZGoZse5aP6tFTQ1ruH4SblQBU/qotEyJ8+O
         iMqIDMjO/+jluK8C/6EtzKspe3cTT3unitXHicVeJQf2SUUyk0agBJRXEkoityiA8USl
         v82m85Hryu0TtYHH2IvWElQGzoJEg1Hu9nIdWCU1jFX2Bahe/MV3MRRvw/Ijm+3gPMB5
         oTjOChfwoW7JOm9AYO1Uq0jt6SzTUsTP/bekTVKCXC9wOrzlXcAHZw8HEfWsXmQurh+D
         6NBihHB3EucGRXJ+Rsd7kWSihtlrYwnUX7Kmnsaw2UqKgcpvTyaaNakSa1BFWTDPXa4R
         HabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686631372; x=1689223372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzwXO5LLinsbc81q9m0mJrThXDrRsGSZgZKBrqcWDhU=;
        b=N14p8EBXi1wLIxwSL4W7zdqX2nm4upjKUUGwFUvoFrTb6j6QjRhoFa0voGKNqjJQls
         nxtAcDtNfuDgjFfz5ItJ4pp99IQiCdMEeFawyKAk9u+Wwg4FNbGnOefNxaffOzOrRCWh
         Kk0heFoKEW5RtdkL/Up+40OR/3Keua4Jb23P7IUJ62fAbyfWFZwrfE0OszpwEDGWsxth
         wJPHehgQ7blMlN8HQhLzX3kQYt2RE1L15UUlZavJIzOcr5esutiwRDkxv7G2x1tx3EP3
         WlHN/Aud1Y/7+n9c7+sBdA9v6aFa4YisgsGmq6vw1AhMFZsABXJQ3LvuQhp0g/Cy7YaW
         TbCA==
X-Gm-Message-State: AC+VfDwqb+N1GHMdlY46+GR3WId1dKEQigJT0IQud/lrTLPF5tTNj7D1
        Is4Wo4zKXMO9npXAVi76TrjT/W8xD4EJkHUMhKtv4w==
X-Google-Smtp-Source: ACHHUZ4ETr5UZ3VbtqL8LS3ZVa0OXp7qvMh694ytmLxSCEv5jRu14utuMLjd7mOBnSDm2aadOjxLwJ3P3GoNW1vtYdA=
X-Received: by 2002:aa7:c553:0:b0:508:3b1f:e6b5 with SMTP id
 s19-20020aa7c553000000b005083b1fe6b5mr5571374edr.15.1686631371900; Mon, 12
 Jun 2023 21:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-3-apatel@ventanamicro.com> <20230608182828.GA3183987-robh@kernel.org>
 <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com>
 <CAK9=C2V1LH0739Nq5Ji7gGbgbyFtNAtBYR43fU7vr9omD5tKSA@mail.gmail.com> <CAGETcx--aEEB6ag1qGcEeygPyZM9Q-T1NOY+wK911LGJGisN8Q@mail.gmail.com>
In-Reply-To: <CAGETcx--aEEB6ag1qGcEeygPyZM9Q-T1NOY+wK911LGJGisN8Q@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 13 Jun 2023 10:12:40 +0530
Message-ID: <CAAhSdy2p6K70fc2yZLPdVGqEq61Y8F7WVT2J8st5mQrzBi4WHg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the
 interrupt controller DT nodes
To:     Saravana Kannan <saravanak@google.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 2:47=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Fri, Jun 9, 2023 at 4:40=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> >
> > On Fri, Jun 9, 2023 at 1:35=E2=80=AFAM Saravana Kannan <saravanak@googl=
e.com> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 11:28=E2=80=AFAM Rob Herring <robh@kernel.org>=
 wrote:
> > > >
> > > > +Saravana
> > > >
> > > > On Mon, May 08, 2023 at 07:58:33PM +0530, Anup Patel wrote:
> > > > > The RISC-V APLIC interrupt controller driver is a regular platfor=
m
> > > > > driver so we need to ensure that it is probed as soon as possible=
.
> > > > > To achieve this, we mark the interrupt controller device nodes wi=
th
> > > > > FWNODE_FLAG_BEST_EFFORT (just like console DT node).
> > > > >
> > > > > Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to =
mark devices as best effort")
> > > >
> > > > It is good practice to Cc the commit author of what you are fixing.
> > > >
> > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > > ---
> > > > >  drivers/of/irq.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > > > > index 174900072c18..94e1d9245cff 100644
> > > > > --- a/drivers/of/irq.c
> > > > > +++ b/drivers/of/irq.c
> > > > > @@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_devi=
ce_id *matches)
> > > > >       INIT_LIST_HEAD(&intc_desc_list);
> > > > >       INIT_LIST_HEAD(&intc_parent_list);
> > > > >
> > > > > +     /*
> > > > > +      * We need interrupt controller platform drivers to work as=
 soon
> > > >
> > > > If it's platform drivers/devices you care about, then perhaps this
> > > > should be done when platform devices are created.
> > > >
> > > > > +      * as possible so mark the interrupt controller device node=
s with
> > > > > +      * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to d=
elay
> > > > > +      * the probe of the interrupt controller device for supplie=
rs
> > > > > +      * without drivers.
> > > > > +      */
> > > > > +     for_each_node_with_property(np, "interrupt-controller")
> > > >
> > > > This function only operates on nodes matching 'matches', but this
> > > > operates on everything.
> > > >
> > > > It does make sense that if we init an interrupt controller here, th=
en we
> > > > will surely want to probe its driver later on. So maybe just move
> > > > setting FWNODE_FLAG_BEST_EFFORT within
> > > > for_each_matching_node_and_match() below.
> > > >
> > > > > +             np->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > > > > +
> > >
> > > Definite Nack. You are pretty much disabling fw_devlink for all
> > > interrupt controllers. There are plenty of examples of the IRQ driver=
s
> > > being needed very early on and still probing properly without the nee=
d
> > > for this flag. Please fix your driver/DT.
> >
> > Okay, I will try to set FWNODE_FLAG_BEST_EFFORT only for
> > APLIC device_node via IRQCHIP_DECLARE().
>
> No, my point is that you very likely don't need to use that flag.
>
> What exactly is the problem you are facing? Point to an example RISC-V
> dts (not dtsi) in upstream and give specifics please.

The APLIC irqchip driver added by this series is a platform driver. It
used to work fine without setting FWNODE_FLAG_BEST_EFFORT
flag in fwnode but after commit 8f486cab263c the APLIC irqchip
driver did not probe hence this fix.

Regards,
Anup
