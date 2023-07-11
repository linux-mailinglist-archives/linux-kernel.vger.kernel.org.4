Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE374EF50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGKMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:49:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAAD127;
        Tue, 11 Jul 2023 05:49:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36BCn2tr005755;
        Tue, 11 Jul 2023 07:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689079742;
        bh=av9sGF2ONuxDxSWWPnCmNyIdnsN1IROS42kMnF1IAY8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JEk/EjNRLW0M4e3YbItgX/tL0aMp+bTbAnACEuCpgvNcYYqE10Klr8n/q/LT6eVwP
         zwH3jNXkrv4diQ1oGbQwt97dGosg7oXBcDlr86gUJo8luL4WwmaahosHLo2dGH+dlu
         xkgDbNzrVuz8KFIKlPc+5SFRg4s7RkEtaBrN60a8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36BCn24C017855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 07:49:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 07:49:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 07:49:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36BCn1Gc117977;
        Tue, 11 Jul 2023 07:49:01 -0500
Date:   Tue, 11 Jul 2023 07:49:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH 15/18] soc: ti: Mover power-domain drivers to the genpd
 dir
Message-ID: <20230711124901.7b3tw374n7eldjpj@puppy>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-16-ulf.hansson@linaro.org>
 <20230707175048.6yees6d3evcomyux@vacation>
 <CAPDyKFoc0hr=9LEtwwwe3R6rMn0b7TB1MCZN0ArUq+h9Pud08Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoc0hr=9LEtwwwe3R6rMn0b7TB1MCZN0ArUq+h9Pud08Q@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:16-20230711, Ulf Hansson wrote:
> On Fri, 7 Jul 2023 at 19:50, Nishanth Menon <nm@ti.com> wrote:
> >
> > On 16:04-20230707, Ulf Hansson wrote:
> > > Cc: Nishanth Menon <nm@ti.com>
> > > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > > Cc: Tero Kristo <kristo@kernel.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  MAINTAINERS                                   | 3 ++-
> > >  drivers/genpd/Makefile                        | 1 +
> > >  drivers/genpd/ti/Makefile                     | 3 +++
> > >  drivers/{soc => genpd}/ti/omap_prm.c          | 0
> > >  drivers/{soc => genpd}/ti/ti_sci_pm_domains.c | 0
> > >  drivers/soc/ti/Makefile                       | 2 --
> > >  6 files changed, 6 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/genpd/ti/Makefile
> > >  rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
> > >  rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (100%)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9e580df3e5db..3cf16ffac892 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -21101,7 +21101,7 @@ F:    drivers/irqchip/irq-ti-sci-inta.c
> > >  F:   drivers/irqchip/irq-ti-sci-intr.c
> > >  F:   drivers/reset/reset-ti-sci.c
> > >  F:   drivers/soc/ti/ti_sci_inta_msi.c
> > > -F:   drivers/soc/ti/ti_sci_pm_domains.c
> > > +F:   drivers/genpd/ti/ti_sci_pm_domains.c
> > >  F:   include/dt-bindings/soc/ti,sci_pm_domain.h
> > >  F:   include/linux/soc/ti/ti_sci_inta_msi.h
> > >  F:   include/linux/soc/ti/ti_sci_protocol.h
> > > @@ -21335,6 +21335,7 @@ L:    linux-kernel@vger.kernel.org
> > >  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > >  S:   Maintained
> > >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
> > > +F:   drivers/genpd/ti/omap_prm.c
> >
> > Probably the wrong place for this as omap_prm is'nt a keystone navigator
> > driver set. Maybe Tony has a suggestion?
> 
> I guess we could add it to the OMAP2+ section then?

That would be my suggestion.

> 
> In any case, I suggest we consider that as a separate patch on top, as
> I am just obeying to the existing pattern that the get_maintainers
> script provides.
> 

OK. otherwise, this looks good to me.

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
