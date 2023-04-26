Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54A6EFB28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbjDZTeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjDZTeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3172684;
        Wed, 26 Apr 2023 12:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E6E6199C;
        Wed, 26 Apr 2023 19:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AEF2C433EF;
        Wed, 26 Apr 2023 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682537660;
        bh=maf6/BWfgU2ncGnj6zGDd1S57xHd7EW9VanLw4HM0lQ=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=pfzsV7xK93wyHSvWTzOB0YRU4/NZX9qX1+l3l7/2bIkLSIBKJTQXmAzM6ia9cWCEf
         P864cAoStyXbLvEeFkytVU3LPp0vztcVgWFO3rY9hrz2wMV/ZLoQZA9satUjzyepGx
         4GOQ8JovFOVA/m4GhWXcdpoQwASoP4nTccq/YWcENxBYnYsLK8gyYGay0APdnXsdqg
         NlCBK9VnFnhXirv8PHlN9ROLr6I0mnUXX976U+P++p6KK7DNDLJYNJ0/77rEwv1AL2
         ibzy3vk5LbtSCUUDMNQIIOZ6/m8u2ovIYV9CJ0ydM2oREqm+jMWRmzI6mUCfuiNFW/
         I+9ja4NjKk/pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D0C77B7C;
        Wed, 26 Apr 2023 19:34:20 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/2] clk: fix corner case of
 clk_mux_determine_rate_flags()
Date:   Thu, 27 Apr 2023 03:34:15 +0800
Message-Id: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALd8SWQC/22OSw7CMAwFr4KyxihxSpFYcQ/EonEdGvUTlJQIV
 PXuJN1VYjn2e2MvInJwHMX1sIjAyUXnpwz6eBDUNdOTwbWZBUrUskIFNPRQV1SbmlFRa0ROmiY
 ymNBM1JXs2MSZQ1m8Alv32fT3R+bOxdmH73YtqTLdi5MCBcacpbZokay++fc8eN+fyI+iGBL+a
 SFIuOSfiBBV1ap9a13XH1Tv8/znAAAA
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682537658; l=901;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=maf6/BWfgU2ncGnj6zGDd1S57xHd7EW9VanLw4HM0lQ=;
 b=SIb8BOsguv8fnRlfotQhfHQXWXc+E+Db4OKYO/BHbSNJaXC/Dr9OX7sk8NwFAZYgTBvkng8C1
 CXt5kM/XsQxDfudX6xYcK+gn2tcJp9Vm/aWQRoX+4aAaAY3z+Prp10V
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- Add many unittest functions for mux determine_rate
- Add more checks for ULONG_MAX
- Link to v2: https://lore.kernel.org/r/20230421-clk-v2-0-74c6cc2214d1@outlook.com

Changes in v2:
- Add a unit test to clk_test.c
- Link to v1: https://lore.kernel.org/r/20230421-clk-v1-1-bb503f2f2cf3@outlook.com

---
Yang Xiwen (2):
      clk: use ULONG_MAX as the initial value for the iteration in clk_mux_determine_rate_flags()
      clk: tests: Add missing test cases for mux determine_rate

 drivers/clk/clk.c      |  13 ++++-
 drivers/clk/clk_test.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 3 deletions(-)
---
base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
change-id: 20230421-clk-64c6b6e21cdb

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

