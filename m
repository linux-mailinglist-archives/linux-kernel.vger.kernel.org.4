Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95236BC012
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjCOWtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjCOWs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C132618BC;
        Wed, 15 Mar 2023 15:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D654B61EA4;
        Wed, 15 Mar 2023 22:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A85CC433EF;
        Wed, 15 Mar 2023 22:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678920535;
        bh=iC8NtjPlD0VRfMIcs8JsUdxzmc0BBWrCOka5EaH6dOY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z+K+RYH9IrYKl4dW5flp0qNvyWKTLyYNXUWFXkgB0CuS1DinHBwMGMeYZs/Fic+hj
         9qSmTB0Of7tkQWE048Z+GcwNOAZGNBjwwgVHSc5LhRumjmUgMAP3l10S9Ck2WMfdvp
         c/u5M8M2gKZKRNJ9yqSCG8wZYsB3yLDZwjAEUKpRnToOzJgVGfqPvBFT8t2TUu3WAz
         pdL61mmZu76Nf5Opg2vTygZ2Z+txDjj5cjzumL7DMpu1yD3kIyyMxhEpp00Jo2TPhp
         AVA45Hs9886s3aPzTkGdGS7+cJMEEgAeaQffUl0ANBuIqQdS6NdO46yFc3+D577axk
         NZb6XzV5GKtyg==
Message-ID: <85856e5711813212bb4c04acbbe284b4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <729b1b69-aba6-4623-cf78-b08562d30d76@starfivetech.com>
References: <20230314124404.117592-1-xingyu.wu@starfivetech.com> <de14f63beb2b3e424ec2375187c8087f.sboyd@kernel.org> <729b1b69-aba6-4623-cf78-b08562d30d76@starfivetech.com>
Subject: Re: [PATCH v3 00/11] Add new partial clock and reset drivers for StarFive JH7110
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 15 Mar 2023 15:48:53 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-03-14 20:44:00)
> On 2023/3/15 8:30, Stephen Boyd wrote:
> > Quoting Xingyu Wu (2023-03-14 05:43:53)
> >> This patch serises are to add new partial clock drivers and reset
> >> supports about System-Top-Group(STG), Image-Signal-Process(ISP)
> >> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC.
> >=20
> > What is your merge plan for this series? Did you intend for clk tree to
> > take the majority of patches? We won't take the dts changes through the
> > clk tree.
> >=20
> > I think Philipp Zabel reviewed some earlier version of the patches and
> > provided reviewed-by tags. Can you check if they can be added here? If
> > so, please resend again, or get those merged through the reset tree.
>=20
> These patches add new clock & reset providers based on the basic clock & =
reset
> of the minimal system which Hal.feng had submitted[1], which are used in =
USB, DMA,
> VIN and Display modules that are merging.
> [1]: https://lore.kernel.org/all/20230311090733.56918-1-hal.feng@starfive=
tech.com/
>=20
> Oh I checked and had not received any comments from Philipp Zabel in earl=
ier version
> of these patches. Maybe it was confused with the patches of the minimal s=
ystem.
>=20

Ok. I am waiting for a resend on that series from Hal.feng
