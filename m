Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7F46BC69E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCPHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCPHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:12:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB81CF76
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:11:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e11-20020a5b004b000000b00b37118ce5a7so989727ybp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678950682;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ONiyvATRP+sYO0cUaYvRRKjkxrSOSKrIRA+wHss4tjQ=;
        b=H+FPljJIIomYtc/NnrAnTTyoSPEooxmuWOrMvbKEhQcBQTU6TLkGYtIcd72fxkZvyj
         ie4ciSX2lkqv/NX/kCkLwzLilcEM6aXv10YrWNeWoQaLO15Xermeog90+uTvTpnHWn9a
         LCOzRiuMI2QAQcQ3ma6g8fWFPt11FPw6Kek0XN71XeoLf/ax/V0r1XeKEtXoKoPH8i1z
         jtATqW2Mjg6A4sHs1ca+plj8mOV4o48m7NU7R0ctNpQTVCx/mhO54JK46OaytnhUD81v
         zPTNtMnHE9ZDYVprOfQfORuUbZXvSbZE/QRBIsu0UrRtZEv9Vy2XUXNP/S1TumsnPT8D
         2lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678950682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONiyvATRP+sYO0cUaYvRRKjkxrSOSKrIRA+wHss4tjQ=;
        b=G0u4h8og4gGKyeKHhwzaPwLR2oYJ/MbGmlkKFY5SSJc/xFbhknJIfuS0ynVNikyhVN
         BYtx2ipbhk2LtR2UoKMQPKei7ijCpUoHpb2/hVmYsYVC2oXPfIZfWZMXuY/BH/80lVk2
         v75gsb3lmRcdOlZUukF29Uls0UZ4IW94bpw+VwgQfSjJ+XEIZQ7Pmeg5kXN7HBzruHyI
         dbV2A1/08zRiGTqNLcglNtdOmQz/oEQud+YYhzpJC7tnuc7cbZ35z310Fkx4dNNlnfei
         qkTlsGMXmTojqmT65k+p/z145DNdlrZ7SbpqhkJmdwVDk4NIDymUtjfVDmsPsvFbj0uP
         zPaA==
X-Gm-Message-State: AO0yUKUPp+iesIDH6Z1gO0E6Ym7q6/oZXGQr9caLmlqAQvArsPuvkMzA
        mVYm1rlLLDH8hTyf1+I/y7kigIUPmleKgbsHgQ==
X-Google-Smtp-Source: AK7set91b5nUXx5SrhOK3n4qjarCprO5irMkIBZbqna7UYe5L25YhwrToCIxOTjZ6NIUBw4kz/evVHiPgmdEpjmCwQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:5470:81fd:9c7f:513a])
 (user=howardchung job=sendgmr) by 2002:a81:4317:0:b0:52e:f77c:315d with SMTP
 id q23-20020a814317000000b0052ef77c315dmr1629424ywa.3.1678950682470; Thu, 16
 Mar 2023 00:11:22 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:10:58 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316151018.v1.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
Subject: [PATCH v1] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        howardchung <howardchung@google.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Brian Gix <brian.gix@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: howardchung <howardchung@google.com>

The MGMT command: MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI uses variable
length argumenent. This patch adds right the field.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: howardchung <howardchung@google.com>
---

 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39589f864ea7..249dc6777fb4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9357,7 +9357,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ add_adv_patterns_monitor_rssi,
-				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE },
+				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE,
+						HCI_MGMT_VAR_LEN },
 	{ set_mesh,                MGMT_SET_MESH_RECEIVER_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ mesh_features,           MGMT_MESH_READ_FEATURES_SIZE },
-- 
2.40.0.rc2.332.ga46443480c-goog

