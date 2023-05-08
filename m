Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335376FB4EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjEHQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjEHQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A5E172D;
        Mon,  8 May 2023 09:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAACC60C5A;
        Mon,  8 May 2023 16:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86282C433EF;
        Mon,  8 May 2023 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683562845;
        bh=hNKbhjXj4sq7siJDAnA0CwKqmHnlz6fdow6mqG667FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vC/3ScToQKhedFLfxUFSJ3aCnIFQ0ilNTcZmOvWfnMTfly0Y9+O7vzM0QHX8Y06eC
         c7fRRlONd+f2NO7xa8jTaXN8agDMHkEG8a4KmDON8G0osb5Jw5TwquFB8n360h6lfd
         BpC7Hi39UPl1zzmAVZ77ZoVtKVB+17cKZLXXIjjkC+zQvGKcv4oOFR1pxeku74nVFS
         7XkdKiTUMB59g96XuAhNv9sDvb9ckYlFLNH8M/FOw3VLSMZh8Mm/IVuasrRHULRqS9
         /48L1lKQrFX8SbG3gt16Mv5iEMzBQsWJ+3vdWEi3JbSXSSco99OeSo8rpK0PXtNp/P
         LVmby35lajZAw==
Date:   Tue, 9 May 2023 00:09:38 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/5] irqchip/sifive-plic: Support T-HEAD's C910 PLIC
Message-ID: <ZFkewiBpnxCigI0G@xhacker>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-2-jszhang@kernel.org>
 <CAJF2gTTni=G5FP80rSArErXGWQatR1P8rCy9nNOggeA4vtXftQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTni=G5FP80rSArErXGWQatR1P8rCy9nNOggeA4vtXftQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 02:52:29PM +0800, Guo Ren wrote:
> On Mon, May 8, 2023 at 2:34 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > The T-HEAD's C910 PLIC still needs the delegation bit settingto allow
> > access from S-mode, but it doesn't need the edge quirk.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 4 ++++
> >  drivers/irqchip/irq-sifive-plic.c                             | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index f75736a061af..64b43a3c3748 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > @@ -62,6 +62,10 @@ properties:
> >                - starfive,jh7110-plic
> >                - canaan,k210-plic
> >            - const: sifive,plic-1.0.0
> > +      - items:
> > +          - enum:
> > +              - thead,light-plic
> > +          - const: thead,c910-plic
> >        - items:
> >            - enum:
> >                - allwinner,sun20i-d1-plic
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index e1484905b7bd..71afa2a584d9 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -569,6 +569,7 @@ static int __init plic_init(struct device_node *node,
> >  }
> >
> >  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> > +IRQCHIP_DECLARE(thead_c910_plic, "thead,c910-plic", plic_init);
> >  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> >
> >  static int __init plic_edge_init(struct device_node *node,
> > --
> > 2.40.0
> >
> opensbi needs thead,c900-plic, and we could put multi compatible name
> in the dts. So, it's no need here.

Thanks, I misunderstood the PLIC edge quirk. This patch isn't needed any
more.
