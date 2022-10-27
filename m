Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0784060F347
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiJ0JLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiJ0JK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463214005
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E3A0B8255C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB84C433D6;
        Thu, 27 Oct 2022 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861823;
        bh=Sh+BmeRGZOX5XGeQBr+NcaVn9R2vZH1mrSUpX2DxTCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7kFKr8yqIN8HQUEeg89SJw+uqYK4JRiEOoF8dBqPVF4/ye6zdF7nPWtIGhtwoZdG
         jssP1Pz/cpz4+jE9l9FT+jQaYOZefLFDofZMU79Qru56sPuMWqcyhsSWo1nK9Jt8Kb
         2oLMJJ3PIlAS3FC3aJGBlUkj4PVnVc/0C1/WV1iTWo0eksYu9iexK2tKxGyJZL5EFc
         UzAUCgm2fiW+Dnf84PeNwHhjlysWDj6Jp6oJPz9qLCqIl4hpEezj/PuUXJ9I0tgzyE
         HsOX7rkj5LR+4iEGc4YmgbpK/StfKJniTcsNz+xZhn+flN2rfGQME/XFkNEAfKeI2t
         jRfIuvgmlkRXA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 08/15] habanalabs/gaudi: use graceful hard reset for F/W events
Date:   Thu, 27 Oct 2022 12:10:00 +0300
Message-Id: <20221027091007.664797-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Use graceful hard reset for F/W events on Gaudi device that require a
device reset.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 337123f73501..3dfb9ecf7db3 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7942,16 +7942,14 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		reset_required = false;
 	}
 
-	/* despite reset doesn't execute. a notification on
-	 * occurred event needs to be sent here
-	 */
-	if (event_mask)
-		hl_notifier_event_send_all(hdev, event_mask);
-
-	if (reset_required)
-		hl_device_reset(hdev, flags);
-	else
+	if (reset_required) {
+		hl_device_cond_reset(hdev, flags, event_mask);
+	} else {
 		hl_fw_unmask_irq(hdev, event_type);
+		/* Notification on occurred event needs to be sent although reset is not executed */
+		if (event_mask)
+			hl_notifier_event_send_all(hdev, event_mask);
+	}
 }
 
 static void *gaudi_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size)
-- 
2.25.1

