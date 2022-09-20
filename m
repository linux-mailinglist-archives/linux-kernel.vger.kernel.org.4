Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA25BE343
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiITKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiITKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:22 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03E971737
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id D6990280AE2;
        Tue, 20 Sep 2022 18:31:18 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 12/20] gpio/rockchip: add return check for clock rate set
Date:   Tue, 20 Sep 2022 18:31:00 +0800
Message-Id: <20220920103108.23074-13-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSElNVh5DGENIHh8fTUNJSlUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6PDo4OT0dURwfFwkTLy8B
        PwMwFBlVSlVKTU1ITU1CQ0xCTk5IVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUlLTU03Bg++
X-HM-Tid: 0a835a73c1602eb1kusnd6990280ae2
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the clock rate set for the apb clock is successful or not.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpio/gpio-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index e36cdbd4bbef..511e93a6a429 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -199,6 +199,9 @@ static int rockchip_gpio_set_debounce(struct gpio_chip *gc,
 	if (bank->gpio_type == GPIO_TYPE_V2 && !IS_ERR(bank->db_clk)) {
 		div_debounce_support = true;
 		freq = clk_get_rate(bank->db_clk);
+		if (!freq)
+			return -EINVAL;
+
 		max_debounce = (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
 		if (debounce > max_debounce)
 			return -EINVAL;
-- 
2.25.1

