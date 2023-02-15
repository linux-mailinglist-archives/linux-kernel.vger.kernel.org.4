Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E920697A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjBOLJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjBOLJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:09:37 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D0366AE;
        Wed, 15 Feb 2023 03:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676459375; x=1707995375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FeD2gX27EYJ/o3bIBlV58bfyVjsGyOEA5W4Xd7KygKE=;
  b=SqfPqukJK1cqlGtWvrS9xSN9k8xNOQBI1OtYMYF+Gw5mnhhqbnUyP/Jy
   DYTgBy0kjg+Qforf/IjbTek2DZzLgK9nsRjcPZr9F3ztKimyblB8hBjz3
   9i8v+tVi3JdVUyQpd8zmeNER1Z0NUBjZ3yWJJb1a64s76bpXg+0M8FPpy
   gqsnQChk6YdODec51QIFb8+jqL95Hig/Ma45ah96buqScqa85FTuWzBIu
   qCrRLLfWr+7Gz9SXFF53Dw0Vg7qpG3esSPYxqPV+VbJWOKeyR5A+n/eob
   hShpdtOVCY1J/JqS1X3WMNbvI6xVjYZluap0FPaDSbDnQhRoMQt02+PDq
   w==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29099139"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Feb 2023 12:09:33 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 15 Feb 2023 12:09:33 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 15 Feb 2023 12:09:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676459373; x=1707995373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FeD2gX27EYJ/o3bIBlV58bfyVjsGyOEA5W4Xd7KygKE=;
  b=PF29jVYvhJCndbbd8WaQbs9eVxd6Sg/+kYuvgOSUFHBP8XFRO7JPFF9R
   wSD0sF3J6ikLVs5cqUKVZ2ASuGPsMJDFp0X03KBaTO+JAOEDq98HKrGgh
   j/cw4qVcFJw1s6JgAEFItNcyU3w5SZ9smCZBMUuxmqkZj4rS0ILdceYsX
   s7AuGMEEYe+x0AkAjnBD4g2zqi2hi432LkMkiUGPaqNe/2tE+XqUAbcMI
   M5JXEtX6LUscJenCu8XVjj6iJQc3/Ool4KVZ10ngT8Mujfev94HHXlGdy
   +6gyESeh+YqmbWFW6wB/Qb92M+bwsP3Fn/sI+LWch3L0wsDK35fuzZT70
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29099138"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Feb 2023 12:09:33 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 27CD6280056;
        Wed, 15 Feb 2023 12:09:33 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     andy.shevchenko@gmail.com, Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] gpio: vf610: make irq_chip immutable
Date:   Wed, 15 Feb 2023 12:09:32 +0100
Message-ID: <4497001.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CACRpkdYHJOgO9K_H9QA1_VWgParbh+Xqh-oCmo3JAFtaMXYByg@mail.gmail.com>
References: <20230214073638.571417-1-alexander.stein@ew.tq-group.com> <Y+tn3Y+SraIetn5X@surfacebook> <CACRpkdYHJOgO9K_H9QA1_VWgParbh+Xqh-oCmo3JAFtaMXYByg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. Februar 2023, 11:18:06 CET schrieb Linus Walleij:
> On Tue, Feb 14, 2023 at 11:52 AM <andy.shevchenko@gmail.com> wrote:
> > Tue, Feb 14, 2023 at 08:36:38AM +0100, Alexander Stein kirjoitti:
> > > Since recently, the kernel is nagging about mutable irq_chips:
> > >     "not an immutable chip, please consider fixing it!"
> > >=20
> > > Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> > > helper functions and call the appropriate gpiolib functions.
> >=20
> > ...
> >=20
> > > The overall changes are based on commit f1138dacb7ff
> > > ("gpio: sch: make irq_chip immutable")
> >=20
> > Nice, but you forgot one crucial detail. You need to mark GPIO resuested
> > whenever it's locked as IRQ and otherwise when unlocked.
>=20
> +static const struct irq_chip vf610_irqchip =3D {
> (...)
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
>=20
> That's what this macro does ;)

Does this mean the calls to gpiochip_disable_irq/gpiochip_enable_irq in v2/=
v3=20
are not necessary?

Best regards,
Alexander

> Yours,
> Linus Walleij


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


