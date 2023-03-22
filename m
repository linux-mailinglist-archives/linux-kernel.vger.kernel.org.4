Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9506C5ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCVXxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVXx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:53:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B5171E;
        Wed, 22 Mar 2023 16:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3BF6B81EA8;
        Wed, 22 Mar 2023 23:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31160C433D2;
        Wed, 22 Mar 2023 23:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679529205;
        bh=YhNph/4ta8FbF44lEZUNxH84xxM4Dhb4EA5vqQ7GTfQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sSnptT/fc40Ox/q2g5fz1FwiCmNlTFZnNMtInH8BwlwJkIyZ3sib8iVFGavpg1daB
         +K5l0T0xbv/G+W5V10zAurN1MCmqqu0fZlWtAt2avoQvUU0y2gGad5y86QPaWanQ/g
         ZkQuPkqESuVgsFZQx/xusZkyu1y0GhuyvlhRpbrUXd+wlZnTTDmiygF0hk+2rN0CbB
         yV3r1P6Gvyoa/aESrcaCHhjSdp/f7Emmj5vxFYyZur26oRWrMG71suOK2H/1NlK4rq
         bhZz6Tw2O87E+YWv3z85UofnPXMOFLCXVEM0/Y3NdBo9CR87BSVnYW5yIKbn96EIk/
         d/i6t3gpxdKFQ==
Message-ID: <1abd70426bb69995e6bdf1194ede56eb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a6358a5f-bbfd-4a14-a828-a3c28f82709a@spud>
References: <20230320103750.60295-1-hal.feng@starfivetech.com> <95f11f7c-611f-49a9-97e8-0de89846e430@spud> <62b766cef78d95793af95f428693c359.sboyd@kernel.org> <a6358a5f-bbfd-4a14-a828-a3c28f82709a@spud>
Subject: Re: [PATCH v6 00/21] Basic clock, reset & device tree support for StarFive JH7110 RISC-V SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hal Feng <hal.feng@starfivetech.com>, kernel@esmil.dk,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>
Date:   Wed, 22 Mar 2023 16:53:23 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-03-22 14:06:00)
> On Tue, Mar 21, 2023 at 04:57:52PM -0700, Stephen Boyd wrote:
> > Quoting Conor Dooley (2023-03-21 16:03:54)
> > >=20
> > > If you're happy on the driver side of things, do you want to pick tho=
se
> > > patches up on top of the bindings and send a PR to Stephen?
> >=20
> > This sounds fine to me. Let me know if you plan to send a PR with the
> > starfive clk bits.
>=20
> Since it was off-list:
> Emil and I spoke about this briefly today at the weekly linux-riscv
> meeting, the upshot of which is that it is likely to be me, rather than
> him, sending you a PR as he's pretty busy at the moment.
> That said, Emil mentioned that he has some doubts as to whether the
> bindings are correct, and from taking a look - he's right, so there'll
> likely not be a PR just yet! I'll go leave a comment about that...
>=20
> I've got no real desire to maintain these drivers going forward though,
> so perhaps Hal, or one of the other StarFive folks, can get themselves
> set up to send them to you going forwards?
>=20

Sure, or I can apply them myself based on some branch you provide that
has the required header files. It doesn't really matter as long as I
know what's going on.
