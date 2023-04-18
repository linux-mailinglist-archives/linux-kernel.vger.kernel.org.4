Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9533E6E6D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDRUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjDRUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E61213F;
        Tue, 18 Apr 2023 13:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBDD62C64;
        Tue, 18 Apr 2023 20:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85F0C433D2;
        Tue, 18 Apr 2023 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681849433;
        bh=P15Yl/B1MBCuSDNyRH5yThZsU7xR/xjFglvjJ5Mbq2M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B6Y/SypffQQ8pukFX5bAyerb/e7v21DRsz529COu6kuYnnj3+CQvW2WoCFRGK91p2
         Yv2eWxDSXTk5PMudRfN5XwgOx+XjMSD4pjLuaXey2yd3Q7sK+kwIQhjOkMWG0Ku6xG
         hWoM7/5/uwGlvN5jfdv9OpDyQVS9m7reG57/6c929q/UWFiKXtJKNGbSBWY/SB/vfs
         hGi6SWCGkcLVYz2q740S+dYGpbBRrzrIqQLcQZop0Aje0OqvRFGC7P7A/eGj134rUh
         tgbcq1H7xCFKokMUE2CURzcCy5+aQBZedYUMueWlSFY5Aj7oI+d9Z1oDUbL4kW8dBI
         2moLfpGOAxW/A==
Message-ID: <f817937cfd494c3f619adda97ebd6346.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <71f646cb-7114-0c78-493c-99bdb5217801@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com> <20230412053824.106-10-ychuang570808@gmail.com> <4f57a7ccc946d18be5eb9a47fa69e5f8.sboyd@kernel.org> <71f646cb-7114-0c78-493c-99bdb5217801@gmail.com>
Subject: Re: [PATCH v7 09/12] clk: nuvoton: Add clock driver for ma35d1 clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Tue, 18 Apr 2023 13:23:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-04-14 20:58:57)
> >> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/cl=
k-ma35d1.h
> >> new file mode 100644
> >> index 000000000000..28c60f081788
> >> --- /dev/null
> >> +++ b/drivers/clk/nuvoton/clk-ma35d1.h
> >> @@ -0,0 +1,123 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (C) 2023 Nuvoton Technology Corp.
> >> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> >> + */
> >> +
> >> +#ifndef __DRV_CLK_NUVOTON_MA35D1_H
> >> +#define __DRV_CLK_NUVOTON_MA35D1_H
> > Is this header included in one C file? If so, remove the header file and
> > put the contents in the C file.
>=20
> Both clk-ma35d1.c and clk-ma35d1-pll.c include this header file.
>=20

Do they both use all the defines from it? Move as much as possible out
of this header file and put them in the only C file that uses it.
