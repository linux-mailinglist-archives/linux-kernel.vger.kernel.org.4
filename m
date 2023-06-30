Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23B74431E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjF3UST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjF3USH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:18:07 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358430C5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:18:05 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id 55F7C15360;
        Fri, 30 Jun 2023 21:18:03 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 47FED219FD1; Fri, 30 Jun 2023 21:18:03 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 0/3] clocksource: sun5i: clean up and convert to platform driver
Date:   Fri, 30 Jun 2023 21:01:25 +0100
Message-ID: <20230630201800.16501-1-mans@mansr.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two of these patches remove a bunch of duplicated code/data in
the sun5i hstimer driver.  To keep the diff clearer, the first patch
introduces an otherwise pointless struct which is then removed in the
second.

The third patch converts the driver to a platform_device driver.  This
is to make it work again on A20 and A31 (I think) where it broke when
the ccu driver was changed to a platform driver.

I have only tested this on an A20 where the hstimer is registered as
expected and can be selected through sysfs.  I hope it doesn't break
something else.

Some additional discussion here:
https://lore.kernel.org/linux-clk/20211119033338.25486-4-samuel@sholland.org/

Mans Rullgard (3):
  clocksource: sun5i: remove duplication of code and data
  clocksource: sun5i: remove pointless struct
  clocksource: sun5i: convert to platform device driver

 drivers/clocksource/timer-sun5i.c | 288 +++++++++++++-----------------
 1 file changed, 123 insertions(+), 165 deletions(-)

-- 
2.41.0

