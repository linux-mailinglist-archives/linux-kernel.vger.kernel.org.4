Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D50B6F7367
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEDTnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEDTnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD093D5;
        Thu,  4 May 2023 12:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE14F6346C;
        Thu,  4 May 2023 19:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF387C433A7;
        Thu,  4 May 2023 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229352;
        bh=bkD6hVU+8F90R1FdgY0SO//u+++2L4MdapcaIwB2BL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnJ83nOSmWzoU9SGz7V4PJlMT0ELfP1zqYEyy57eCOxHHYEHg2zV/6Mv+X7p6QaK2
         BtVIC6pXA7PY+6El3VrTJ3Gt9MmtEN5TZcS+56qAicXmbCWuUevaD/djCbQTLNmi6Y
         wn0SaVpILLTrfmTPRlH0vRCDOyVk+CKqa3jlHquYqLuwModOU4RTNhWwuMZ3mJTE7e
         LU3Od7YiL34ZFYDvEOQ2JAL7MZaQ01gBShR3J+djPnuWwCe7OevSwQx4ULfbau8x4r
         B8AKFFAhlXMudA/W3YlllOC8GVwGF3KejDpWXsXm7O6DRVf8GYCgXJ7KcZaw+nueD9
         MSKilzqag2Zwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajat Soni <quic_rajson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 16/59] wifi: ath12k: fix memory leak in ath12k_qmi_driver_event_work()
Date:   Thu,  4 May 2023 15:40:59 -0400
Message-Id: <20230504194142.3805425-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
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

From: Rajat Soni <quic_rajson@quicinc.com>

[ Upstream commit 960412bee0ea75f6b3c2dca4a3535795ee84c47a ]

Currently the buffer pointed by event is not freed in case
ATH12K_FLAG_UNREGISTERING bit is set, this causes memory leak.

Add a goto skip instead of return, to ensure event and all the
list entries are freed properly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230315090632.15065-1-quic_rajson@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 979a63f2e2ab8..03ba245fbee92 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2991,7 +2991,7 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 		spin_unlock(&qmi->event_lock);
 
 		if (test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags))
-			return;
+			goto skip;
 
 		switch (event->type) {
 		case ATH12K_QMI_EVENT_SERVER_ARRIVE:
@@ -3032,6 +3032,8 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 			ath12k_warn(ab, "invalid event type: %d", event->type);
 			break;
 		}
+
+skip:
 		kfree(event);
 		spin_lock(&qmi->event_lock);
 	}
-- 
2.39.2

