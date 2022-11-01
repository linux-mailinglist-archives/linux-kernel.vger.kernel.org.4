Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84AD615233
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKATWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKATWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660CC1C93C;
        Tue,  1 Nov 2022 12:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C65F61705;
        Tue,  1 Nov 2022 19:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE5DC433D6;
        Tue,  1 Nov 2022 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667330536;
        bh=rzMpc3yyGF71lY7u/blmIwz+eJhbF9m5RL7Pl44fz0M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KaqT8v6ze0W8xaqIdyEs3+njmgpSmGE/13pvzPzBBpWFl9CAVJnchldF1ONTPCAE0
         izA9dXVNw/Nq7sd9jI4NJDNSjS5WfebeT6+u2VDleROJfpDNpkOxTA7L/M5+9aP0fI
         bpGO2L1bgsSdxHpRrW1Br12lRX0dl0sww86LOcxcuVTNtDOYwrkH2K5EJBvWeqLcso
         JLqu8mE4jy2T/3uIoRNQE7Tr6vv3bJXx7PhO2k3ou8sWeXJ2tIp7p1+2ab6/xUEG6r
         bP+lpsbpV8jmhQI7rs2LsCUhtiMJ3NsOqH6vZceDGLu74hOj4EYQM6mjIcd6H66mxB
         faghF4Z8C0fmA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZODGKR.IJ47UDRQGD431@crapouillou.net>
References: <20221027192024.484320-1-lis8215@gmail.com> <20221027192024.484320-4-lis8215@gmail.com> <20221027215716.77250C433D6@smtp.kernel.org> <ZODGKR.IJ47UDRQGD431@crapouillou.net>
Subject: Re: [PATCH v6 3/3] clk: Add Ingenic JZ4755 CGU driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
To:     Paul Cercueil <paul@crapouillou.net>
Date:   Tue, 01 Nov 2022 12:22:14 -0700
User-Agent: alot/0.10
Message-Id: <20221101192216.5EE5DC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2022-10-28 00:48:35)
> Hi Stephen,
>=20
> Le jeu. 27 oct. 2022 =EF=BF=BD 14:57:14 -0700, Stephen Boyd <sboyd@kernel=
.org>=20
> a =EF=BF=BDcrit :
> > Quoting Siarhei Volkau (2022-10-27 12:20:23)
> >>  diff --git a/drivers/clk/ingenic/jz4755-cgu.c=20
> >> b/drivers/clk/ingenic/jz4755-cgu.c
> >>  new file mode 100644
> >>  index 000000000..d2eb3ae0c
> >>  --- /dev/null
> >>  +++ b/drivers/clk/ingenic/jz4755-cgu.c
> >>  @@ -0,0 +1,346 @@
> > [...]
> >>  +static void __init jz4755_cgu_init(struct device_node *np)
> >>  +{
> >>  +       int retval;
> >>  +
> >>  +       cgu =3D ingenic_cgu_new(jz4755_cgu_clocks,
> >>  +                             ARRAY_SIZE(jz4755_cgu_clocks), np);
> >>  +       if (!cgu) {
> >>  +               pr_err("%s: failed to initialise CGU\n", __func__);
> >>  +               return;
> >>  +       }
> >>  +
> >>  +       retval =3D ingenic_cgu_register_clocks(cgu);
> >>  +       if (retval)
> >>  +               pr_err("%s: failed to register CGU Clocks\n",=20
> >> __func__);
> >>  +
> >>  +       ingenic_cgu_register_syscore_ops(cgu);
> >>  +}
> >>  +CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu",=20
> >> jz4755_cgu_init);
> >=20
> > Is there another driver that probes this device?=20
> > CLK_OF_DECLARE_DRIVER()
> > is for the situation where we want to probe this device again with
> > another platform driver. Please add a comment indicating what that=20
> > other
> > driver is.
>=20
> See: 03d570e1a4dc ("clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro")
>=20

Does that mean this is also a simple-mfd?
