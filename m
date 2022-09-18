Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322FB5BBD9E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIRLhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIRLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E44EE1D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33D6AB80B90
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05576C433D7;
        Sun, 18 Sep 2022 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663501043;
        bh=TOQt7kyMZ1yY5be65vxMfb0wY0P7Yh01S8YLq+qVhbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ak6DCGdRs7OX8B/f8hORROTnu+5kMuL0sJL0dVk7f/zUS8DGpAS4MQCw7Ts8hfv72
         PNASfUtxCRbS+aoeaYNiBEMrggErWBVqm0diUW2tfee6u3KjkWsFHVy28SVse1ftoh
         BOkCjEOMa0k4iPF/oNOdWwzLnXYbEVT7OFJhhuD84qQCVeDy3qEZgzQAcHkkiG1MAR
         nZk2BJybloSnT2zue65FXgiSAkVZ/3YWcyfXwbIhc5nbrz5kqyjjGTBBscAxPcAgQ+
         vuljfOeXV+rLZgYlpAIb7g/5Hs8GZZd0yqp5nQGxK86/JIHHNIUIDt3HTVb60lh634
         hmDqCj9oC+7Qg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/7] habanalabs/gaudi2: increase hard-reset sleep time to 2 sec
Date:   Sun, 18 Sep 2022 14:37:12 +0300
Message-Id: <20220918113717.2637094-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220918113717.2637094-1-ogabbay@kernel.org>
References: <20220918113717.2637094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The access to the device registers is blocked during hard reset, until
preboot runs and allows the access to specific registers, including the
PSOC BTM_FSM register which is used to know when the reset is done.
Between the reset request and until this register is polled there is a
small delay of 500 msec which is not enough for F/W to process the reset
and for preboot to run, so the register might be accessed while it is
blocked.
To avoid it, increase the delay to 2 sec.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index c040e01adafe..6ed9b3ce16dd 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -21,7 +21,7 @@
 
 #define GAUDI2_DMA_POOL_BLK_SIZE		SZ_256		/* 256 bytes */
 
-#define GAUDI2_RESET_TIMEOUT_MSEC		500		/* 500ms */
+#define GAUDI2_RESET_TIMEOUT_MSEC		2000		/* 2000ms */
 #define GAUDI2_RESET_POLL_TIMEOUT_USEC		50000		/* 50ms */
 #define GAUDI2_PLDM_HRESET_TIMEOUT_MSEC		25000		/* 25s */
 #define GAUDI2_PLDM_SRESET_TIMEOUT_MSEC		25000		/* 25s */
-- 
2.25.1

