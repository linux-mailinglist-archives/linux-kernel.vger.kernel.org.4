Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0348270A1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjESVoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjESVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:44:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0BB4;
        Fri, 19 May 2023 14:44:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d341bdedcso839840b3a.3;
        Fri, 19 May 2023 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684532654; x=1687124654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+YI3oWErqNGQDBE42kFbzwZJwN9CxeeSi1fS965dfk=;
        b=rAUzIwBGnAq2HbC9AkeTZ/QzT7LAhUHStbdYTu29WP+9B4KMekZ/Reh1WAwJNyCoXm
         HKQZhImu4kOfk/lFFf8vfU5QD7A6EtXMQ9sy8me3HunVPYoadbpF6DFi6FjuJxPA7prR
         qAmxOWivMtR3iFZwT0vdk7vIIcc2Mn7TLLjNNd224i0W3o6db5iKf9vpqwKFB0VNGEj1
         C0H+KeD6HfaaZJeeQY2T6n11NGd1hxin9/2BvHOesEFb4w4zYsjIx8kNkxaCWjMw0iEt
         lowiAYC6PnZFMhmDJc0XaB52LyK3v9hMZmG5ZReVM882Zr57OFXWCGGWG0qgE9QKBhZ2
         BNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684532654; x=1687124654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+YI3oWErqNGQDBE42kFbzwZJwN9CxeeSi1fS965dfk=;
        b=BDQ6MtjSu0sAoSXs0+pyUkNhXSorBVV0BtxliNdhPxfhEDqG59a+pBiWFVGZbv4L3c
         P0O/n7Oyh5Nq3tzJHWYnBFfiSBowuoH63v1AgLpPjNNsAfhfYj5es0YTBe9dIZ4jxVYP
         DcRUQ+W92jfpZwQGE5C60M2c44u+EtryOqirF2W8dmkHqjsq1AdOikhidJhPQm7pAgAL
         bE+LFCtSkQfHKb5phWPiQCHIxezCCF+5SihgrcTLCiE103N9zCxaKizEsJLC883Q5yaH
         WpOtoh+GFe3w1UaVssO5o3hdN3ccB8gsKvTGTglPDs7BOi/IIYtitm0H14nj8UB9lIBU
         3nkA==
X-Gm-Message-State: AC+VfDzVNqFr+XvgOAsXwHLI2iKOGz4RIwjbrCh+3rtHB0eZaSt0i+Lb
        lZ8acJz4U4yWksPrTZ87QDBEtOFlTXP5UA==
X-Google-Smtp-Source: ACHHUZ4jFLzx+FO3jAHqDqkAzHJNMIWAWbYKZnmQH82BfPHFt21Fyfc9FPiLAF4ODJShKIySdEMOmA==
X-Received: by 2002:a17:902:d501:b0:1ae:2e0d:b38c with SMTP id b1-20020a170902d50100b001ae2e0db38cmr4599935plg.12.1684532653947;
        Fri, 19 May 2023 14:44:13 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001ab09f5ca61sm105639plg.55.2023.05.19.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:44:13 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_mrvl: use correct __le16 type
Date:   Sat, 20 May 2023 05:44:08 +0800
Message-Id: <20230519214408.20984-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast 0xffff to __le16 before comparing it with a __le16 type pkt
and fix the following sparse warnings:

drivers/bluetooth/hci_mrvl.c:170:23: sparse: warning:
restricted __le16 degrades to integer
drivers/bluetooth/hci_mrvl.c:203:23: sparse: warning:
restricted __le16 degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/bluetooth/hci_mrvl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index e08222395772..91f63d2b0c02 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -167,7 +167,7 @@ static int mrvl_recv_fw_req(struct hci_dev *hdev, struct sk_buff *skb)
 	struct mrvl_data *mrvl = hu->priv;
 	int ret = 0;
 
-	if ((pkt->lhs ^ pkt->rhs) != 0xffff) {
+	if ((pkt->lhs ^ pkt->rhs) != cpu_to_le16(0xffff)) {
 		bt_dev_err(hdev, "Corrupted mrvl header");
 		mrvl_send_ack(hu, MRVL_NAK);
 		ret = -EINVAL;
@@ -200,7 +200,7 @@ static int mrvl_recv_chip_ver(struct hci_dev *hdev, struct sk_buff *skb)
 	u16 version = le16_to_cpu(pkt->lhs);
 	int ret = 0;
 
-	if ((pkt->lhs ^ pkt->rhs) != 0xffff) {
+	if ((pkt->lhs ^ pkt->rhs) != cpu_to_le16(0xffff)) {
 		bt_dev_err(hdev, "Corrupted mrvl header");
 		mrvl_send_ack(hu, MRVL_NAK);
 		ret = -EINVAL;
-- 
2.34.1

