Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380246D5168
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjDCTdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjDCTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:33:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4BC10DE;
        Mon,  3 Apr 2023 12:33:45 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-192.ewe-ip-backbone.de [91.248.212.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E45D66603145;
        Mon,  3 Apr 2023 20:33:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680550424;
        bh=HLxZp58uZbh2yKGMAwWX3x4hnxJ2g4oYtgD1TCqt/kg=;
        h=From:To:Cc:Subject:Date:From;
        b=VVtMjOm2de/pqu93Ktnc8dm6IlqYc4FUDpl3YWVMDRgs5NXajAihZBIgY1f6UeRXI
         eeS+Tzsh69AyhBM0K50OaH+44B7GVzNdKRVag/qCW8L/dL/puPQXiDwxXmhPjI+2AV
         I8+G3l7v0aQORqAg79+cvdLvB1lCTD4eDa+2SDTqcpwLSp7kdsYUS0jQVdJuhCWEhm
         1uIt8U1uJH5ykw+k61TuwdueN6w3xfBAm1GAh4r0ACClME2tMnfFmkO6X7moOMGepQ
         ppc1egirmYlM4v7kQA1O1/5zpl89AQOmY+EWL3ewZHUpD9Lk0AijFts2vEjyb4Zn+t
         4r6DAGyM4JQRg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4B2FC4807E1; Mon,  3 Apr 2023 21:33:41 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 0/2] Improve RK3588 clocks and power domains support
Date:   Mon,  3 Apr 2023 21:32:48 +0200
Message-Id: <20230403193250.108693-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After this patchset the power-domain support for RK3588 is basically on par
with the downstream implementation. More importantly the clock controller
change unblocks support for any IP blocks using linked clocks. The clock
controller change must be applied before the power-domain change to avoid
accessing unclocked registers.

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230331163058.5688-1-sebastian.reichel@collabora.com/
 * Replace dsb(sy) with wmb() to fix COMPILE_TEST build on !arm64; direct replacement
   would be mb(), but write memory barrier should be enough here as far as I can tell
 * Added Tested-by from Vincent Legoll

-- Sebastian

Boris Brezillon (1):
  soc: rockchip: power-domain: add rk3588 mem module support

Sebastian Reichel (1):
  clk: rockchip: rk3588: make gate linked clocks ignore unused

 drivers/clk/rockchip/clk-rk3588.c |  42 +++++---
 drivers/soc/rockchip/pm_domains.c | 160 +++++++++++++++++++++++-------
 2 files changed, 151 insertions(+), 51 deletions(-)

-- 
2.39.2

