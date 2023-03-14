Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24EF6B9618
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCNN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCNN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A11BADE;
        Tue, 14 Mar 2023 06:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0CB6176B;
        Tue, 14 Mar 2023 13:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59253C4339E;
        Tue, 14 Mar 2023 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678800239;
        bh=OfM3hT6uoMNd3/FINM80boLpc05PsZ3wMWGSXM5LelQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XEE6N9MQS61ng3tZpY0N2LEMBo0mzDXV8KZ3fHBGp7dimC1i2tmtXmzkmOz8eGEoF
         YQK1H7+ofQGKp1mUTI4oIplF0FvKVLZGUtAFXUNFEn4EMB7etJ1Oi4yYiCnu6i3zF0
         9s47+DyYeuegIeNwgGt75P7Vv6xDQOSDO2GL52+8AumesBkby+mjwKeu8QSsWWILDA
         MMgZpA5KAlNgxa3jJXFynNroRT9RBCa7lVYRdsdqSMqvMiH+hyv86GABnevts0F4Hu
         cXmH0fuP27IcHsDvEDl8hvXDLvdRy/OcdsvBKeDPIkSgx2vJQlXHjHww0FvgckrsCR
         EwlNCsyYHujJw==
Received: by mail-vs1-f50.google.com with SMTP id x14so14060426vso.9;
        Tue, 14 Mar 2023 06:23:59 -0700 (PDT)
X-Gm-Message-State: AO0yUKWAvL0BS1gY2GfXeK8hm3ihO+eTXQAKwnBoenwUW1Qf1V6iRLs+
        fUQq1UGr6LXITvVghdVWnHWSeug1liPyaXnOIg==
X-Google-Smtp-Source: AK7set/YgSFtm49HHMG7GpsmLoSaLCHGZ39/OFUu1tdOauCfSijB7VdKgS5MrLVbbrlfT5LUFI38a7WBgGeJqtfY70E=
X-Received: by 2002:a67:b142:0:b0:412:bca:d304 with SMTP id
 z2-20020a67b142000000b004120bcad304mr24925406vsl.7.1678800238244; Tue, 14 Mar
 2023 06:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144725.1545315-1-robh@kernel.org> <c6a5dc7f-46bf-8f1e-0a9c-2614d5f1824d@amd.com>
In-Reply-To: <c6a5dc7f-46bf-8f1e-0a9c-2614d5f1824d@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Mar 2023 08:23:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKy7qWDkU3z1p0oTn1umLzWchKw86Zu8mKzugDWQXJF-w@mail.gmail.com>
Message-ID: <CAL_JsqKy7qWDkU3z1p0oTn1umLzWchKw86Zu8mKzugDWQXJF-w@mail.gmail.com>
Subject: Re: [PATCH] soc: xilinx: Use of_property_present() for testing DT
 property presence
To:     Michal Simek <michal.simek@amd.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 5:19=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 3/10/23 15:47, Rob Herring wrote:
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties. As
> > part of this, convert of_get_property/of_find_property calls to the
> > recently added of_property_present() helper when we just want to test
> > for presence of a property and nothing more.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   drivers/soc/xilinx/zynqmp_power.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zyn=
qmp_power.c
> > index 78a8a7545d1e..641dcc958911 100644
> > --- a/drivers/soc/xilinx/zynqmp_power.c
> > +++ b/drivers/soc/xilinx/zynqmp_power.c
> > @@ -218,7 +218,7 @@ static int zynqmp_pm_probe(struct platform_device *=
pdev)
> >          } else if (ret !=3D -EACCES && ret !=3D -ENODEV) {
> >                  dev_err(&pdev->dev, "Failed to Register with Xilinx Ev=
ent manager %d\n", ret);
> >                  return ret;
> > -       } else if (of_find_property(pdev->dev.of_node, "mboxes", NULL))=
 {
> > +       } else if (of_property_present(pdev->dev.of_node, "mboxes")) {
> >                  zynqmp_pm_init_suspend_work =3D
> >                          devm_kzalloc(&pdev->dev,
> >                                       sizeof(struct zynqmp_pm_work_stru=
ct),
> > @@ -240,7 +240,7 @@ static int zynqmp_pm_probe(struct platform_device *=
pdev)
> >                          dev_err(&pdev->dev, "Failed to request rx chan=
nel\n");
> >                          return PTR_ERR(rx_chan);
> >                  }
> > -       } else if (of_find_property(pdev->dev.of_node, "interrupts", NU=
LL)) {
> > +       } else if (of_property_present(pdev->dev.of_node, "interrupts")=
) {
> >                  irq =3D platform_get_irq(pdev, 0);
> >                  if (irq <=3D 0)
> >                          return -ENXIO;
> > --
> > 2.39.2
> >
>
> Waiting for v2 because of missing of.h header reported by lkp.
> https://lore.kernel.org/all/202303120017.BIw01Y21-lkp@intel.com/

It's a false positive. The header change is in v6.3-rc1, but 0-day is
applying these to branches not yet updated to rc1.

Rob
