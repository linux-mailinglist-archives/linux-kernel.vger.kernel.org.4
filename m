Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152A36F7598
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjEDT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjEDT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA3AD09;
        Thu,  4 May 2023 12:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69EC86381F;
        Thu,  4 May 2023 19:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6199C433D2;
        Thu,  4 May 2023 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229772;
        bh=+96Mq4ggXsx7WcB6BZtFOmiAWeqBv5VKnktfiAdc368=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAptdyaWXnk1/rYalL72z1pBE1rjt5LD4PxhjxjHXDJwvPlrj3yZceJzzhflwjMfa
         ozhD1S7bh7/NZDNXDYSjr0AIS51p+MWT+EZcVw+yyOKCZBvYdv7zZgRySlHTVRTSsW
         pY/kJ6a/+u63pgA3eE9H1xooYgplOS8aPnDw5a5KtfDIoOzvKfgnNRmuK8NScuRAb+
         aiT/yl6t5J4M7ux8QI5mP5ofmwOiB2hi4RSzKtcK5vNgn5pDlfz7c7QP/eD4bFo7Sr
         bpHWjku4Fr9NDIs4UpwvOZdpFB70BMB2yO+9sw73piMN2Yw7yDDC1FRtmKaN38NdTs
         JwiPik57I3Lwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 28/30] Bluetooth: btintel: Add LE States quirk support
Date:   Thu,  4 May 2023 15:48:21 -0400
Message-Id: <20230504194824.3808028-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194824.3808028-1-sashal@kernel.org>
References: <20230504194824.3808028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

[ Upstream commit 77f542b10c535c9a93bf8afdd2665524935807c2 ]

Basically all Intel controllers support both Central/Peripheral
LE states.

This patch enables the LE States quirk by default on all
Solar and Magnertor Intel controllers.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d707aa63e9441..2a4cc5d8c2d40 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2381,9 +2381,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Valid LE States quirk for GfP */
-		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		/* Apply LE States quirk from solar onwards */
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
-- 
2.39.2

