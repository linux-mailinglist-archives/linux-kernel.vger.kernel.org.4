Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BBB724524
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbjFFOBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbjFFOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:01:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C8198A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:00:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso7153620276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686060043; x=1688652043;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S6bABvrmsSInWb8fnuh4ITkDJEvWLg0D4R3//Td0SQE=;
        b=kEgWoJ49N2whPXRJaq/b8YUNnuy53VuV4VogxQBdtVGh7K6G2usK2oAdAsNXkCEyVj
         MNZF1nOPM0Zw0jMJziXYNV8bNHqxGz2Dxo990m13oURN+iYndqqrVQ/i4ZnLgPXtzhiL
         54HwrLuHd8Wgi9mcroDbDvi7VsZop9AkynLKTIsoAChiyBp/Z/eA6/SdGJSXNyZnySV+
         NE8oJitgXuLzbzPYX+BlJhZy4VWABtlvzYPRWiisKqLOjtRlwko27m8LgY6C09gIcMsG
         okHpEkKiYa8ETBqpurh2HSOXb5fI7TwXwAuIbRIOx/YvixnOnYukV0YmpuFP2cAxCItP
         LHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060043; x=1688652043;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6bABvrmsSInWb8fnuh4ITkDJEvWLg0D4R3//Td0SQE=;
        b=S7lZRDSsyI//UpYMgk9xWYrk5PkQhtpqJeUubEHwVTVk/MplI3dkRpN2uMHNYjfSNz
         y97N7SRMe90Oxf7mPOxX4xk6yDguV5nWZNOtYrUwtZf16HQ+lzOuuLdivsrhv/pRt8Fs
         qio97HBPHW8ik18Cruz9H8fVf3wLtv5DWOErHf+ac0vPs/3A2h6hLh575B5ab2AVePKe
         cYpdLjIGyg2aS1JJnGiDJmBt5tMr5Fgl3DA/HuquxAybOAnjXWzcCCJi8osz34UCIqZO
         hw9065fVV528l8+5CCWlTyvGO+k5HmkfS4J9bsdDtccHuN8koGWG90T6ur1D5lB+mSIs
         Cjeg==
X-Gm-Message-State: AC+VfDw0LlC3wS1tqKHl9kZoSS7H9tG2Etyn59OquQmezWNBhT2c7/tO
        cnw8jBfvgHrKYwrWrsDm0zGcDic1/vFZN51KMBnKEKgNdT5ErK7iTT6MQ0J/gkY9SwAjhVeuV7I
        kshZHNTlRuEo7xJTq5kf+TDzgWBtNbVLiJ7yzQMfXj/765I0B+5ALLsVD6pzZ1w==
X-Google-Smtp-Source: ACHHUZ52QT/eB8BKHEzn6E94GeOQS/r0FOgsbZh9T/CpgqQyCi2PdRDg7H6Yi8ImeRi6e7th9vZJykg=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:f52a:f978:3766:4700])
 (user=ptf job=sendgmr) by 2002:a25:e6d6:0:b0:ba7:5d7a:b50d with SMTP id
 d205-20020a25e6d6000000b00ba75d7ab50dmr1144964ybh.10.1686060043589; Tue, 06
 Jun 2023 07:00:43 -0700 (PDT)
Date:   Tue,  6 Jun 2023 10:00:36 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606140041.3244713-1-ptf@google.com>
Subject: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
From:   Patrick Thompson <ptf@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Patrick Thompson <ptf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAC_VER_46 ethernet adapters fail to detect IPv6 multicast packets
unless allmulti is enabled. Add exception for VER_46 in the same way
VER_35 has an exception.

Signed-off-by: Patrick Thompson <ptf@google.com>
---

 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4b19803a7dd01..96245e96ee507 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2583,7 +2583,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		rx_mode |= AcceptAllPhys;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
-- 
2.41.0.rc0.172.g3f132b7071-goog

