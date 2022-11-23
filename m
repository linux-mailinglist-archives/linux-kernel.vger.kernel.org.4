Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189BA634BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiKWBCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKWBCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:02:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C660BF47;
        Tue, 22 Nov 2022 17:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A6C1B81DDD;
        Wed, 23 Nov 2022 01:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07CEC433D6;
        Wed, 23 Nov 2022 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669165352;
        bh=ijrMTcyWsqW6LZM3KVpES0ixK86mmIZqatbEA6I3C6E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=s/s5LCHvcVkPGC8p3nryjKjLv7qUSKYfx9BfVc9V8vdfeSpZ+QEBHNHVlO5GVBkXy
         o0KGgPDaIiLSDqTpKvCRol3Ov2HHMntplS+6vlGyeM7eNrim7JcyTL4o+L9VJrHrA8
         4Y9gtwp8FbGzwoYdxvZvMiC218BjH4OUzvE5+69oNQ0KEswdOrfFOAMiVbEfgtarcp
         I82F5C2fA4gbhEJmCmOBXF5IxZdNvXQNJm69eNQTzkZcc9f3XfKAPp53TNoWIEU84C
         xnLLgbuhgf5IUHoLLu5IyHdMLdC7RZA3DVD3vk6aNhEH0J2VDpkfU9EQApoAnXKPdn
         fX7b+VdlTQlKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com>
References: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v4 1/2] clk: ti: change ti_clk_register[_omap_hw]() API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Len Baker <len.baker@gmx.com>, Liang He <windhl@126.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 17:02:29 -0800
User-Agent: alot/0.10
Message-Id: <20221123010231.F07CEC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2022-11-13 10:11:46)
> The ti_clk_register() and ti_clk_register_omap_hw() functions are always
> called with the parameter of type "struct device" set to NULL, since the
> functions from which they are called always have a parameter of type
> "struct device_node". Replacing "struct device" type parameter with
> "struct device_node" will allow you to register a TI clock to the common
> clock framework by taking advantage of the facilities provided by the
> "struct device_node" type. Further, adding the "of_" prefix to the name
> of these functions explicitly binds them to the "struct device_node"
> type.
>=20
> The patch has been tested on a Beaglebone board.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20
> ---

Applied to clk-next
