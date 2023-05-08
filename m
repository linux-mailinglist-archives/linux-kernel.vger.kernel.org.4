Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE176F9E20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjEHDPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjEHDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:15:09 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652083DE
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 20:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683515679; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=l9Yk2ZpIGQ75skWpiIgtduLusGE0oPB3mXGTsifKZOd4htya3Lqri6vqKzS+RAv0h8tGa6qEoIzSUPoHrga+izsHhKMJAhvntlkmkHzigs8jpJwMJ8NioaVFqypgoLjUA6GSxNGvaR6aa7OE90VOs0bfyVuOYACp6DntwGfvxsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683515679; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qnDzkRSag6SxflxnrB+gJTuVsWsOkNdIPE1k2QWE8XE=; 
        b=RUnwG9k5DIpDNtpbg3Bo0K5nvSIveaan3d38/FCtTLP4mdnPLHeUOrJ7MLyOAiPSgdnJKxKfQkiHuadbVtXbg059Vy2H5ImNegQZwQkMxUx8QJCmuu1rKZFBgJzS5SkWqDAZ6md27ajQirnwbmN66nnfamsAcsLCj4yYoCCWliU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683515679;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=qnDzkRSag6SxflxnrB+gJTuVsWsOkNdIPE1k2QWE8XE=;
        b=TzPxT1lMzDl+M0OheL8u2UY+r17jtv5k9D2Ui8pLXoO6w0j+soRqNs2YdOAYiXsE
        6qCNPWUjcfS/lE7tROLVaGJYcWNlWKc6yn5m5128QFJatuU/Ei+0jx7MDktcY8Rd9Ld
        lQTTX2V3CI6y7FFBdMs7qDn9qLnUQgOTXw/hzWuk=
Received: from edelgard.fodlan.icenowy.me (120.85.98.36 [120.85.98.36]) by mx.zohomail.com
        with SMTPS id 1683515678721325.31977442907953; Sun, 7 May 2023 20:14:38 -0700 (PDT)
Message-ID: <56489d3f1b23a90baf3ef024da09b4c8c02a2204.camel@icenowy.me>
Subject: Re: [PATCH 1/5] irqchip/sifive-plic: Support T-HEAD's C910 PLIC
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Date:   Mon, 08 May 2023 11:14:32 +0800
In-Reply-To: <20230507182304.2934-2-jszhang@kernel.org>
References: <20230507182304.2934-1-jszhang@kernel.org>
         <20230507182304.2934-2-jszhang@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-05-08=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 02:23 +0800=EF=BC=
=8CJisheng Zhang=E5=86=99=E9=81=93=EF=BC=9A
> The T-HEAD's C910 PLIC still needs the delegation bit settingto allow
> access from S-mode, but it doesn't need the edge quirk.

No, the PLIC controller seems to be the same between C906 and C910,
which has level/edge selectable via external signal.

See openc906 and openc910 repositories, especially the documents with
it: =E7=8E=84=E9=93=81C9{06,10}=E9=9B=86=E6=88=90=E6=89=8B=E5=86=8C.pdf .

In addition, such problem won't arise when the system uses only level-
triggered interrupts.

>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> =C2=A0.../bindings/interrupt-controller/sifive,plic-1.0.0.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4
> ++++
> =C2=A0drivers/irqchip/irq-sifive-plic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A02 files changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/sifive,plic-1.0.0.yaml
> b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-
> 1.0.0.yaml
> index f75736a061af..64b43a3c3748 100644
> --- a/Documentation/devicetree/bindings/interrupt-
> controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-
> controller/sifive,plic-1.0.0.yaml
> @@ -62,6 +62,10 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - starfive,jh7110-plic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - canaan,k210-plic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sif=
ive,plic-1.0.0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - thead,light-plic
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: thead,c9=
10-plic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - allwinner,sun20i-d1-plic
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-
> sifive-plic.c
> index e1484905b7bd..71afa2a584d9 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -569,6 +569,7 @@ static int __init plic_init(struct device_node
> *node,
> =C2=A0}
> =C2=A0
> =C2=A0IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> +IRQCHIP_DECLARE(thead_c910_plic, "thead,c910-plic", plic_init);
> =C2=A0IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for
> legacy systems */
> =C2=A0
> =C2=A0static int __init plic_edge_init(struct device_node *node,

