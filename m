Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF05B5F5D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJEXGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJEXGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:06:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD58559B;
        Wed,  5 Oct 2022 16:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C49B0B81F7E;
        Wed,  5 Oct 2022 23:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA04C433D6;
        Wed,  5 Oct 2022 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665011169;
        bh=sId7vCZ/BscO4odCRyqbx9YmALMG5hZdxlSUO6EQ//k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g0SA5pkg14SPD2N4jgjqhXZIKasfHYgz2p6Jivm4cuDWdSsvZbwtySQtbDTvgmkFk
         V5b3vcoaT+9b53lICzCBJhsASgNwGkFt1hTB7kyqDVOsaGtlI8mfBpj+bBIyptBFO0
         lKSiUnQQDJzLiLpKAvmUBvXEbB2CeKx3Eo+jEib1rn6eoxZYItSWBYSPp7y9HPvWgP
         uY19coLL0VAnTB6zu+Ft9/81o+baIY4Wkt4+yHOlBC+wiDH71df43M4qRt0F5WK5pX
         sMsjDMwQ898nucgBzM2GZaR5KQV9GhZtJOFm010ZYJ8g2zphx6ZkgMOEK7vM/InsD1
         Hgvi4olUjv7zQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221005082348.v43xbjrhbdlbaohv@pengutronix.de>
References: <20220913102141.971148-1-m.felsch@pengutronix.de> <20221005082348.v43xbjrhbdlbaohv@pengutronix.de>
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Marek Vasut <marex@denx.de>
To:     Marco Felsch <m.felsch@pengutronix.de>, abel.vesa@linaro.org,
        abelvesa@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 05 Oct 2022 16:06:07 -0700
User-Agent: alot/0.10
Message-Id: <20221005230609.5BA04C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Felsch (2022-10-05 01:23:48)
> Hi Stephen, Michael,
>=20
> I know it is a busy time right now, but maybe you have a few minutes for
> this RFC. I know it is incomplete, but the interessting part is there
> and it would fix a real issue we encountered on the imx8mm-evk's.
>=20

There's another approach by Marek[1]. Can you work together on a
solution? I think we should step away from trying to make the critical
flag work during clk registration, and turn on the clk during provider
registration instead. That hopefully makes it simpler. We can keep the
clk flag of course, so that the clk can't be turned off, but otherwise
we shouldn't need to make registration path check for the property.

[1] https://lore.kernel.org/all/20220924174517.458657-1-marex@denx.de/
