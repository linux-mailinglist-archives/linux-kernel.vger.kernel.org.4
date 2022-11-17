Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2162D9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiKQLtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiKQLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:49:23 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB14A317C3;
        Thu, 17 Nov 2022 03:49:15 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,171,1665414000"; 
   d="scan'208";a="142991195"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Nov 2022 20:49:15 +0900
Received: from mulinux.example.org (unknown [10.226.93.80])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4C63040031D7;
        Thu, 17 Nov 2022 20:49:11 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 0/2] Reset related fixes for rzg2l_wdt
Date:   Thu, 17 Nov 2022 11:49:05 +0000
Message-Id: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

this series addresses a couple of issues found with the rzg2l_wdt
driver:
1) on the RZ/Five SoC it was observed that changing the timeout
   wouldn't reset the system as expected
2) on the RZ/V2M SoC it was observed that calling into the restart
   callback from the reboot command wouldn't reboot the system
   straight away

As it turns out, the RZ/Five watchdog IP requires the module clock
to be supplied during a reset.
On RZ/V2M, a specific procedure has to be followed to reset the
watchdog IP.

This series comes with two patches, one to fix the problem affecting
RZ/Five, and one to fix the problem affecting RZ/V2M.

Thanks,
Fab

Fabrizio Castro (1):
  watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M

Lad Prabhakar (1):
  watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks

 drivers/watchdog/rzg2l_wdt.c | 45 +++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

-- 
2.34.1

