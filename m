Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56323728922
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjFHUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFHUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:05:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FACB9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:05:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f98276f89cso230731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686254712; x=1688846712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIV4LjcD36Raxv3M+Ag2LHAyDiN4jPlJxEgpmm5HAXE=;
        b=ryhL8UJia9g5S9RPy+hrb7vPPXgT9o8MGy4TCS9EOIibHpqUl2uXkfajgT51A5hk7b
         EujLBWke8ypBQlowkALAU04JjJuWEzsePXVfFMFlPxdzbTA3XKIammlwin6Hbl1yZoys
         zwrBxzzDu+QknfG0UbOV1BCdGegs8r2/66x1/vGXN2RglVQIomqGCqKVMOHKt2E7u6z1
         cFme/LVWAbnG/29F92z/pDPEOC+K7uUX6pjMBVpBC8BBL3QBNV1d9ViU7GhDcUAOMWom
         SmPnZ6L94/O7UuUJq3xNB1pizW4/wYbGHBDINxdO/eOmM6bu+sactlsQmtGPTtI58p5g
         Q+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686254712; x=1688846712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIV4LjcD36Raxv3M+Ag2LHAyDiN4jPlJxEgpmm5HAXE=;
        b=ISJmARPsYBYJ8f/Z6Wy30eYLEOXK4hRNl3XPh5x11nB5655Q2GNpCmlOtGQN3praSs
         gO2FA4kLhcc6gn6lgUokRmJXWRBM270y+FQr89cAoVxyYjqu4GqMgxhzLDTJkzFjxDPg
         9n60YXP9hQY118/fViDneadvac56bfQj5s1uHDW3M1mXerUhJjBOQIu5KLnJcTYfSX6I
         r3vlXC4S56TfZIq/ATGXKQRIbx6MXucxnNbU0uMjuQ6UR4GitKz6EWdRJZ87kRVz4mXM
         xesehETMdbMt1clbdYzDhHaLs2W64z9C2Uj/IQoNN6OOxR/3jLxtZjn+jP8RIPrhJDf9
         ldPQ==
X-Gm-Message-State: AC+VfDyxwwUXPS4QO9RPHk1SXmDZcZaOnRMIqawx1HoxNz6b9FGpQRdh
        QgDC7d/QfOYm4hnltQRgaVDaxc5R7LO6I3hYIXb6SA==
X-Google-Smtp-Source: ACHHUZ4CIbONl7q3IxgWipvcRK0WIl5R4yl0ilwzDhwV1nhu8O2kmYKeF+sJyJtKS8kZQQ8bnUw8T5mHJeT9LNiKz7A=
X-Received: by 2002:ac8:4e85:0:b0:3f3:75c2:7466 with SMTP id
 5-20020ac84e85000000b003f375c27466mr170826qtp.8.1686254711773; Thu, 08 Jun
 2023 13:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-3-apatel@ventanamicro.com> <20230608182828.GA3183987-robh@kernel.org>
In-Reply-To: <20230608182828.GA3183987-robh@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 8 Jun 2023 13:04:35 -0700
Message-ID: <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the
 interrupt controller DT nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
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
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 11:28=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> +Saravana
>
> On Mon, May 08, 2023 at 07:58:33PM +0530, Anup Patel wrote:
> > The RISC-V APLIC interrupt controller driver is a regular platform
> > driver so we need to ensure that it is probed as soon as possible.
> > To achieve this, we mark the interrupt controller device nodes with
> > FWNODE_FLAG_BEST_EFFORT (just like console DT node).
> >
> > Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to mark d=
evices as best effort")
>
> It is good practice to Cc the commit author of what you are fixing.
>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/of/irq.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 174900072c18..94e1d9245cff 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device_id =
*matches)
> >       INIT_LIST_HEAD(&intc_desc_list);
> >       INIT_LIST_HEAD(&intc_parent_list);
> >
> > +     /*
> > +      * We need interrupt controller platform drivers to work as soon
>
> If it's platform drivers/devices you care about, then perhaps this
> should be done when platform devices are created.
>
> > +      * as possible so mark the interrupt controller device nodes with
> > +      * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> > +      * the probe of the interrupt controller device for suppliers
> > +      * without drivers.
> > +      */
> > +     for_each_node_with_property(np, "interrupt-controller")
>
> This function only operates on nodes matching 'matches', but this
> operates on everything.
>
> It does make sense that if we init an interrupt controller here, then we
> will surely want to probe its driver later on. So maybe just move
> setting FWNODE_FLAG_BEST_EFFORT within
> for_each_matching_node_and_match() below.
>
> > +             np->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > +

Definite Nack. You are pretty much disabling fw_devlink for all
interrupt controllers. There are plenty of examples of the IRQ drivers
being needed very early on and still probing properly without the need
for this flag. Please fix your driver/DT.

-Saravana


> >       for_each_matching_node_and_match(np, matches, &match) {
> >               if (!of_property_read_bool(np, "interrupt-controller") ||
> >                               !of_device_is_available(np))
> > --
> > 2.34.1
> >
