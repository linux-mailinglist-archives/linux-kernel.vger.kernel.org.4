Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF15EEAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiI2Bdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiI2Bdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FB118DEC;
        Wed, 28 Sep 2022 18:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A50D61824;
        Thu, 29 Sep 2022 01:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73153C433C1;
        Thu, 29 Sep 2022 01:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664415218;
        bh=N5BA8bHC8pdKQGoSWcCTt0SDD9FfHiL9T5gTYfb/eDo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=U8+08XYxmaOEmKIqqDNRmQVY0cRu+dq1VdoN0PgrwI/BolqI/hAqu52aEo2MSWy4O
         32xcd4VONEhtwxvLHeZf3UsaH9FBGPDzT164W5eWYmB55IA0m2+02wwtIr5sp+BiXC
         iMDs7CFPFaluFlse+nY3N1kzSVaMoGtNfMym0F0MjBQZih2uKzqLR6YBotdVnvfa4q
         fAJ29W8z9GmSnVxASfl0E2BxwWjPSlbiTHBfATDR+CHCSrCIlKQbe/SYFK6XOsLZmj
         7rUfpApY0JsSB+D1o7eKmuMmUzXqAyNRYcvptRJCggjKC7el36gqxc6Gwi3G6RYST6
         nLkZrk7ScxSAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220905161504.1526-1-f.fainelli@gmail.com>
References: <20220905161504.1526-1-f.fainelli@gmail.com>
Subject: Re: [PATCH v2] clk: iproc: Do not rely on node name for correct PLL setup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-clk@vger.kernel.org
Date:   Wed, 28 Sep 2022 18:33:36 -0700
User-Agent: alot/0.10
Message-Id: <20220929013338.73153C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Florian Fainelli (2022-09-05 09:15:03)
> After commit 31fd9b79dc58 ("ARM: dts: BCM5301X: update CRU block
> description") a warning from clk-iproc-pll.c was generated due to a
> duplicate PLL name as well as the console stopped working. Upon closer
> inspection it became clear that iproc_pll_clk_setup() used the Device
> Tree node unit name as an unique identifier as well as a parent name to
> parent all clocks under the PLL.
>=20
> BCM5301X was the first platform on which that got noticed because of the
> DT node unit name renaming but the same assumptions hold true for any
> user of the iproc_pll_clk_setup() function.
>=20
> The first 'clock-output-names' property is always guaranteed to be
> unique as well as providing the actual desired PLL clock name, so we
> utilize that to register the PLL and as a parent name of all children
> clock.
>=20
> Fixes: 5fe225c105fd ("clk: iproc: add initial common clock support")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---

Applied to clk-fixes
