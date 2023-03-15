Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04C06BBFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCOWkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1203624BD7;
        Wed, 15 Mar 2023 15:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8229861E99;
        Wed, 15 Mar 2023 22:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE12C433EF;
        Wed, 15 Mar 2023 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678920002;
        bh=Dqgr9v54cHrkJKhuRh+AiuRaYdqJV1Qe+/QF6NsU5r0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NIfBEAyYIYoM2nZPpROk+29khoFR2Alq5hnLpj0EIF6SuIG6BcXUC36rQZSTTf5Bz
         PsNMAvGX+11izw7qQvEDcqB64o3Y6d9063NqJcwBAkZMBZkRFCdIi3lca25LgRO+55
         ezVeKQqO7KttwW2fNMKnq+xpS2MP/QmrDYKcyoRhl1aZ11P2z3i6gXWRkvRS3n61np
         +wIJOb6EGKakn5OVpOLZwhedfFhjoGrLT9oxnHPqYvM2uDIoRktooFU6mdshyhz3dg
         +JwIfYJk/rB09CEqb0q/72Hb+eIyBB+LFVmutlvMLQaZcvIWDLuPkqeLOgdYJ9jiIq
         P2mdHcRqfznWw==
Message-ID: <e24f9d404c5f9830c9606e4635dc6431.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e895fea6-e13b-450f-97e8-34ecfe075691@spud>
References: <20230314124404.117592-1-xingyu.wu@starfivetech.com> <de14f63beb2b3e424ec2375187c8087f.sboyd@kernel.org> <729b1b69-aba6-4623-cf78-b08562d30d76@starfivetech.com> <e895fea6-e13b-450f-97e8-34ecfe075691@spud>
Subject: Re: [PATCH v3 00/11] Add new partial clock and reset drivers for StarFive JH7110
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Date:   Wed, 15 Mar 2023 15:40:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-03-15 01:14:06)
> Hey Stephen,
>=20
> On Wed, Mar 15, 2023 at 11:44:00AM +0800, Xingyu Wu wrote:
> > On 2023/3/15 8:30, Stephen Boyd wrote:
> > > Quoting Xingyu Wu (2023-03-14 05:43:53)
> > >> This patch serises are to add new partial clock drivers and reset
> > >> supports about System-Top-Group(STG), Image-Signal-Process(ISP)
> > >> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC.
> > >=20
> > > What is your merge plan for this series? Did you intend for clk tree =
to
> > > take the majority of patches? We won't take the dts changes through t=
he
> > > clk tree.
>=20
> FWIW, I've been waiting for the "main" clock/reset series [1] to be ready
> to go, before suggesting that I take it (the main series) via the soc
> tree. This one is kinda in the same boat, with defines in the dt-binding
> headers that are used by both drivers and dts, so splitting the two
> doesn't make all that much sense.
>=20
> As Xingyu points out below, this series depends on the main one, so if I
> was to take that via soc, this one would need to go on top, or be
> delayed.
> At what point does that become too much to go via soc and some sort of
> shared tag become needed?
>=20

Platform/SoC maintainers either base their DTS file branch on some
branch made in clk repo that has the bindings and drivers they need
(clk-starfive probably), or they send a pull request to clk maintainers
with the bindings and clk drivers. Or they don't use the #defines in the
header files and use raw numbers in the DTS, or they simply apply the
patch that just has the #defines in it to their SoC tree and we
duplicate the commit in the history by also applying it to the clk tree.

Let's try to keep things simple and not use raw numbers.

BTW, clk driver code doesn't typically go via soc. Not sure if that's
happening but please don't do that.
