Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB56721013
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjFCM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjFCM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:29:11 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314A1A6;
        Sat,  3 Jun 2023 05:29:10 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-561b7729a12so65728487b3.1;
        Sat, 03 Jun 2023 05:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685795349; x=1688387349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lj3c5i4LVsfDq+IR9UtiM8SjPOJlmSS1MT39h6r6yz8=;
        b=LyT2wZ9o8RMwnLf0EZBQ5Ft2BKnD5wom4JrXEequD0EgIg+P+XC6m1hSiWAXzAK1x4
         7OyVA/c2SmovawmuiX3C/laPARWcc1RZ3Xp9RI2c+lwyU/9xoVjJil3aGc6bFnCT/sgn
         69yVo/10tfxmI3FwOjjQv6DG0Uyrqy8/gwUrzuakyQDXSH40OTJQd+fKjUM+3LuPg6mB
         sjnJxCGYcEqD8fkw6GUEDlhABT7suHS1a0EGA8gIK1HQLVj6W+xDL6QIOLrOYCYnmUBz
         /qLZMgKPxzopPpnc3PIjT5/EXg4RT553InR0XIfgssUzVmtGkMrUoJQj4rXnsLH7xYMI
         NCNQ==
X-Gm-Message-State: AC+VfDy7WmCHkAQ3MycBnrj78MbTRBQ5TiYYzOsKIKFYtmWW8qt9Fu4L
        OKpC+2RPxaEcvdjdA3wENqQ=
X-Google-Smtp-Source: ACHHUZ5BNuwyzunn2X0qgK3iGCf6DWX/cVutWu5eXPQl3bI+jokGNHknhIgNiMrHcgfCRCoZTniTmA==
X-Received: by 2002:a81:480c:0:b0:568:cd43:b4ef with SMTP id v12-20020a81480c000000b00568cd43b4efmr3440268ywa.1.1685795348897;
        Sat, 03 Jun 2023 05:29:08 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id q125-20020a817583000000b00545a08184cesm1447411ywc.94.2023.06.03.05.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 05:29:08 -0700 (PDT)
From:   Sungwoo Kim <iam@sung-woo.kim>
Cc:     daveti@purdue.edu, Sungwoo Kim <iam@sung-woo.kim>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Add missing checks for invalid DCID
Date:   Sat,  3 Jun 2023 08:28:09 -0400
Message-Id: <20230603122808.1633403-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving a connect response we should make sure that the DCID is
within the valid range and that we don't already have another channel
allocated for the same DCID.
Missing checks may violate the specification (BLUETOOTH CORE SPECIFICATION
Version 5.4 | Vol 3, Part A, Page 1046).

Fixes: 40624183c202 ("L2CAP: Add missing checks for invalid LE DCID")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/l2cap_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 376b523c7..104eb0320 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4306,6 +4306,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	result = __le16_to_cpu(rsp->result);
 	status = __le16_to_cpu(rsp->status);
 
+	if (result == L2CAP_CR_SUCCESS && (dcid < L2CAP_CID_DYN_START ||
+					   dcid > L2CAP_CID_DYN_END))
+		return -EPROTO;
+
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 	       dcid, scid, result, status);
 
@@ -4337,6 +4341,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
+		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
+			err = -EBADSLT;
+			break;
+		}
+
 		l2cap_state_change(chan, BT_CONFIG);
 		chan->ident = 0;
 		chan->dcid = dcid;
-- 
2.34.1

