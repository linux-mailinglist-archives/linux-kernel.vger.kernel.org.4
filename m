Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223445B62F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiILVqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiILVpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:45:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B94D15E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:45:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-34577a9799dso84620997b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=6+LQgns1/8zpG0OHFak8nK3Ilwf0pwSl1GyfLOUBAHY=;
        b=gGOw60e1rpYD6TuAGwTn1INOvUIO0roMQJqMvPDtHZ3UQnwRVcEe1E2Lonygj2xPXW
         T7VejqP7YEWDwcM2Fw0dM+LChi/7jSBzA8TxU4xpos+N5cIog+peVDWDKeJJTVWPFwbx
         KAhGqy4z6vXHqHuPEjqQWoPc0RbECfptY8slGI/T1vLbxRPMgkcxAzNu5UEZQV4IrNZy
         wxpNB52VWIn4D0coKpwbjPGUtTqJK/KzpKl8wsoUZH/yBsIJRHbZsQAY824PpzXO/GZj
         /wBhdzOvhDBBGqNi8VTCSjsE8Bq36E8sjeH3OlfjWBmBFmFLCdf4rr6irACkZCe9I/GC
         sgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6+LQgns1/8zpG0OHFak8nK3Ilwf0pwSl1GyfLOUBAHY=;
        b=ii5pl/O+mvyrimAdh1rpCtZsqvzygsndixT2RWiIj6RMDS4yHr7/RvzytiF90T3Hjh
         ARUSrztpnX8EJxyfin83zZOsWvNADHDYhAe7a4pU65m7KSp/tvYJ3TWtJMz8htI7pnDf
         rfY/I+4V3S1/br5gnazZ6RLv7IJwoni5Yj+djnYwvoqRCzTIQI14E0HXFmnoohb0TvRa
         SStFLxxGJHMG/n9LWIbmVne2EMhpyZ9syC55RyAvjz34w3O+UqJDASBvi6+Zu+q6Y1D/
         QzYr70CPgZYgTLeHodC27O9ema2TnivczM2fILwH4Q4feq81BKvALQ4Qc5rgN5+noxdH
         knTA==
X-Gm-Message-State: ACgBeo3VZJtlZN2e7O1zh2jmlru3hTdLUwzqAjhkkAgGBJR8zIE+BTlg
        fkruUw3RA6elTbUooiyDcRVOk+kurQ==
X-Google-Smtp-Source: AA6agR5Wo0VhogpTx5DxeN1niodvB4431b9kJDUIXpDf7IRaH1XfCA4O7LgT46IBvWJGD/4wLke+g5aO3w==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:b790:0:b0:66f:7978:f166 with SMTP id
 n16-20020a25b790000000b0066f7978f166mr23452698ybh.17.1663019152781; Mon, 12
 Sep 2022 14:45:52 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:45:44 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912214548.929144-1-nhuck@google.com>
Subject: [PATCH] Staging: rtl8192e: Fix return type of rtllib_xmit
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Felix Schlepper <f3sch.git@outlook.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ndo_start_xmit field in net_device_ops is expected to be of type
netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of rtllib_xmit should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 42f81b23a144..1b665afd309e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -543,7 +543,7 @@ static u8 rtllib_current_rate(struct rtllib_device *ieee)
 		return ieee->rate & 0x7F;
 }
 
-static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 {
 	struct rtllib_device *ieee = (struct rtllib_device *)
 				     netdev_priv_rsl(dev);
@@ -946,13 +946,13 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			if ((*ieee->hard_start_xmit)(txb, dev) == 0) {
 				stats->tx_packets++;
 				stats->tx_bytes += le16_to_cpu(txb->payload_size);
-				return 0;
+				return NETDEV_TX_OK;
 			}
 			rtllib_txb_free(txb);
 		}
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 
  failed:
 	spin_unlock_irqrestore(&ieee->lock, flags);
@@ -962,7 +962,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 
 }
 
-int rtllib_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t rtllib_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	memset(skb->cb, 0, sizeof(skb->cb));
 	return rtllib_xmit_inter(skb, dev);
-- 
2.37.2.789.g6183377224-goog

