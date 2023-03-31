Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF896D25AD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCaQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCaQe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:34:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DA23FC1;
        Fri, 31 Mar 2023 09:31:10 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-136.ewe-ip-backbone.de [91.248.213.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F1A3660319C;
        Fri, 31 Mar 2023 17:31:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680280268;
        bh=rHbX/qlp+rL7Mg3bJEUnLaEAxzLsCgYjKEhKA8ZUJz4=;
        h=From:To:Cc:Subject:Date:From;
        b=IPNZJ7WpofmAGTMqLY4lbwCWpt6LL5tJuC6mjLQw0LWMbcMUFuOBPM0TZe+LwR7K9
         L4GRTAzTt3R09aRVmpXy3ENqsFz/qPtYRJtSoO105tq8dF9IJbAZA340GEzTuCgsEM
         41NDVfFYFsj4KSB4+fGEEnNbD9Tkc+ImspVtLwUFkCras2MMTQSCBcqJZnISgTd8ZT
         t2o1d9T3Az+vkGNgvO5qqI3/HBARDjf87Hy2OHewpND7brHXbsmv1ysrc2E6VhivcG
         3Li0XNUMU62VHWJz7IuvLJmviaTuqbhRzjRnw+1lAJxjtuT5vXa/hkfljDDPytXiPO
         mMyPw+sWPrvgQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 56A574807E1; Fri, 31 Mar 2023 18:31:06 +0200 (CEST)
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
Subject: [PATCHv1 0/2] Improve RK3588 clocks and power domains support
Date:   Fri, 31 Mar 2023 18:30:56 +0200
Message-Id: <20230331163058.5688-1-sebastian.reichel@collabora.com>
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

