Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5886EBBF1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 00:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDVWDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDVWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 18:03:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300C92690;
        Sat, 22 Apr 2023 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1682200968; i=j.neuschaefer@gmx.net;
        bh=8ZnarGEq3P8eyg4UgR7YBhnw6fR/F5rJyisvrqWWWpY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ePOGq0/ZoOgfEVNHUZStqx37FgIsbsAs4avyayP3kNNNVTEjp+sXEDxqc2hoSStYh
         RmUSd+Tnbqxv2b8ZimRTuKEFifrm7nbGZVwdkcGjdoK6Po1+bSmngwazQkid85O02k
         NffEcwMbzHLE9211vPIpcdvbnBnCYpn4lIkvWyIbZnXAZAbiLia1kw4J+xtGihBTgr
         Zo8JMwX1m45O0Mw3vqqVjrEyF6EQRJ/bWoYb3ghkhsHUADpC4PwHb97RskcSR+yZy9
         6WItCvTfp/+826da0qSuPD6ZD4XFTy8QeJpujvYiPjOYWfPQb89k189yz7ShI6w8Dc
         t9W9w85J8O5fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1qTEqL0621-00f82X; Sun, 23
 Apr 2023 00:02:48 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v7 0/2] Nuvoton WPCM450 clock and reset driver
Date:   Sun, 23 Apr 2023 00:02:38 +0200
Message-Id: <20230422220240.322572-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tfOrHkcYGoAt0qTlD2wTvPaCVC4mMTo3M5fOBtZu5uwz+xCe2aZ
 PcRb0E2ksVKVTLv3muFbwcVje8yF0ggbCL5zOrbADEs4Cd6UYQDcDqnbfJv8xHavmRzdUUN
 9noDWJh66eAW2FVficUFHr7yc/8wrUteze2Sz9wjuD0lAZESH7bLXMJIKkR0aowEX7hgUMa
 YXOQ6b4Diu8yF37OAjStg==
UI-OutboundReport: notjunk:1;M01:P0:WJ22SuVJ1EU=;oeSFdu7hgHkDMaLppMVjtL2dmHn
 uWvd6iJqVOAk8LkgkYQBncYcTbfl2ruxIg0iQ+VNgcCEKfzYGR5za4LZkBRUJNoK4lJpxoyzQ
 lXguWyDHmEwklaaqw2SK/yCN2OI3cNIWJZ+8DbPykYB6vRhPXVvaDQqMXhCOjawh0SV00Zt3K
 WRVa1pomw0EhnC3iWHw/KHyorj/Fa615OPkff1z1that0dmhxOjWYYS/SFeP+w0M1+KkTEsSj
 yd0WMOxTEtAd0U4JE06sGeLDvLqJq5qDl4wVZrrZoEK5UAGodgrS/0ho4GMQBMrEz+Ezey2tO
 JpcPKDfrboDsgrRlZieAJ9ge7KgaQiatAYqPSBr/YbuJwmHxTPq5U0YPEw9TgXKeqvoklAihW
 j2+3HeHgngWGdQsUVEcOUsywCqVDqa84X4mqMZAkP++W3nLXds3rmk8Yv8AH+J+0iETUJxyWq
 aePNnh8rhO+OA3xZbvZw8OuWNVGYSwAASrpkqfbkBskfMRKahYKvdzIB6+oQUDhT7q2y3uzsP
 AK5Ck8dvNeAb8hOkNeHc9e36yKYdWDPJz9WoynhcjixLK2U2M64+lp5fg3vhyWVvZVBvFx7Rt
 mqutxu40uau64sAOjDhXRSTQLLcf3aWvJts5eczotDA+DRAppaKtlD+I7dYMWw9NoRQat9w4J
 9G6BXEdXeBSy8g+m/K6sDJ1XggfywqKk5NbIauGFgPSWzyLuTZ1xmlusN5s3VGq2CfbPxrsWQ
 JkAjQwsv7aGTTjrYcyNlXie8H59041BdB/WucIbVpReE71yhG+yNqRBGCULi0w2DdamRHTlkh
 ghein/ysBrsNGRbUblos7IBrmGNELrY9cLdkqztqYiwMR+rRH7a1CzXWBHerJkMtPCOXWwu+r
 LnR8Q+qXtcgn4ZArpyKL39bVbZ67almPSUFSufo4dfb8jNIZeqD+iOX2jY7Ws1mjFPgAxMVv7
 B+qX85Exdt5Q1Zzfaa+KSysO1WQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the clock and reset controller in the Nuvoton
WPCM450 SoC. This means that the clock rates for peripherals will be calcu=
lated
automatically based on the clock tree as it was preconfigured by the bootl=
oader.
The 24 MHz dummy clock, that is currently in the devicetree, is no longer =
needed.
Somewhat unfortunately, this also means that there is a breaking change on=
ce
the devicetree starts relying on the clock driver, but I find it acceptabl=
e in
this case, because WPCM450 is still at a somewhat early stage.

v7:
- Simplified the error handling, by largely removing resource
  deallocation, which:
  - was already incomplete
  - would only happen in a case when the system is in pretty bad state
    because the clock driver didn't initialize correctly (in other
    words, the clock driver isn't optional enough that complex error
    handling really pays off)

v6:
- Dropped all patches except the clock binding and the clock driver, becau=
se
  they have mostly been merged
- Minor correction to how RESET_SIMPLE is selected

v5:
- Dropped patch 2 (watchdog: npcm: Enable clock if provided), which
  was since merged upstream
- Added patch 2 (clocksource: timer-npcm7xx: Enable timer 1 clock before u=
se) again,
  because I wasn't able to find it in linux-next
- Switched the driver to using struct clk_parent_data
- Rebased on 6.1-rc3

v4:
- Leave WDT clock running during after restart handler
- Fix reset controller initialization
- Dropped patch 2/7 (clocksource: timer-npcm7xx: Enable timer 1 clock befo=
re use),
  as it was applied by Daniel Lezcano

v3:
- https://lore.kernel.org/lkml/20220508194333.2170161-1-j.neuschaefer@gmx.=
net/
- Changed "refclk" string to "ref"
- Fixed some dead code in the driver
- Added clk_prepare_enable call to the watchdog restart handler
- Added a few review tags

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-1-j.neuschaefer@gmx.n=
et/
- various small improvements

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-1-j.neuschaefer@gmx.n=
et/


Jonathan Neusch=C3=A4fer (2):
  dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
  clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver

 .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  66 ++++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-wpcm450.c                     | 374 ++++++++++++++++++
 drivers/reset/Kconfig                         |   2 +-
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
 5 files changed, 509 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 drivers/clk/clk-wpcm450.c
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

=2D-
2.39.2

