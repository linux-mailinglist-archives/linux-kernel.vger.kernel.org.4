Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A4660F348
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiJ0JLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiJ0JK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BA2255AC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF4662242
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87775C43470;
        Thu, 27 Oct 2022 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861827;
        bh=ohUBb+gBWQFcCb9kdCbyCAtdzYz41hKtbSdipGN5VxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBSkRuwf9KVO0ecWQQykSvjXZNmoS892MH+rAUHpuYOiNuKSUHoI3iNhuBaPNN5Ae
         vXOizD5UmoZ+74et+HGCSmTgwSalyegEECQVdG0mkujRtkLKY7urQ2Q++wy99INNtL
         Ko7SpscAwnNb+T9zC4CI6oZUMuiH0QulCh1dgoOH98mO2UbCjBpNoHcLHZsYE8Le6M
         17DmrFUivQulqqWdk9czo9/RQkzkLlyy3FT5W/CHkb3MOebx7jphdiJxgoXgsL5mG4
         2SCM8cY+7BKhP8Cdt6BjfqSxQIaMmYIjHXUlb5m0ZC85/Txl2ddIHdTCs50RwkqiCU
         oEonEJWqKOlNw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 11/15] habanalabs: no consecutive err when user context is enabled
Date:   Thu, 27 Oct 2022 12:10:03 +0300
Message-Id: <20221027091007.664797-11-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

Consecutive error protects a device reset loop from being triggered
due to h/w issues and enters the device into an unavailable state.
When user may cause the error, an unavailable state
will prevent the user from running its workloads.

The commit prevents entering consecutive state when a user context
is enabled.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index bcd959924971..61ddcb1ce508 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1320,6 +1320,10 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 {
 	u32 cur_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
 
+	/* No consecutive mechanism when user context exists */
+	if (hdev->is_compute_ctx_active)
+		return;
+
 	/*
 	 * 'reset cause' is being updated here, because getting here
 	 * means that it's the 1st time and the last time we're here
-- 
2.25.1

