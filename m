Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDBE5F01ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiI3Aus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiI3Au1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB75AA01
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCD37621FF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E6C43143;
        Fri, 30 Sep 2022 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664499022;
        bh=7LJ64O6A/mqm94cjoD/YSd5blsm2WGPuYoFyyVXjGI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVd9bxe2KYaIQ8Su0PrvjvxcblGhVZdVtrW6uRhZSzMGHSm/ONj8iu/v7v1bLyhvO
         KD9t+QeGSr+ifVzrljYqbED8rKyGL4YjOaybbQXXCPrqrc6iCYfJGRqfSTT4+NhNu7
         9ovFsqFddrwE3HXCtQxRzBfPgM9pIScdyOgTeSTJCXivk+PJkFZ/ioKV/tpfaoAph4
         N8ljv0S4oMu1X+0xbFesuZUi/+W//W7MaRzr1kazQQoiAL2zu76a7LTiwYia0HCkyE
         J3o+oI5uO9D8TzFWXI0Feb2DVrsCILXxJC4QOz3KzWgDeF9YTQRy6IFzZAev24b4lb
         p2TrFMVl4AcHw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Subject: [PATCH 9/9] spmi: pmic-arb: increase SPMI transaction timeout delay
Date:   Thu, 29 Sep 2022 17:50:18 -0700
Message-Id: <20220930005019.2663064-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930005019.2663064-1-sboyd@kernel.org>
References: <20220930005019.2663064-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Increase the SPMI transaction timeout delay from 100 us to
1000 us in order to account for the slower execution time
found on some simulator targets.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Link: https://lore.kernel.org/r/1655004286-11493-11-git-send-email-quic_fenglinw@quicinc.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 39f25bc26233..2cf3203b2397 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -91,7 +91,7 @@ enum pmic_arb_channel {
 
 /* Maximum number of support PMIC peripherals */
 #define PMIC_ARB_MAX_PERIPHS		512
-#define PMIC_ARB_TIMEOUT_US		100
+#define PMIC_ARB_TIMEOUT_US		1000
 #define PMIC_ARB_MAX_TRANS_BYTES	(8)
 
 #define PMIC_ARB_APID_MASK		0xFF
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

