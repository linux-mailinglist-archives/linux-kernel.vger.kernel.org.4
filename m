Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370270954B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjESKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjESKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:43:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D010C3;
        Fri, 19 May 2023 03:43:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae40dcdc18so23001655ad.2;
        Fri, 19 May 2023 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684493008; x=1687085008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWt2qP+e1SDrtcGYZghlo0NbjI0r5adHq8yWB5oHK48=;
        b=XhcSU8tdtKzF3mnZo9ROpw/TdyCIIxXjIG2LGXwNisIkIbxfIvJknJ8ahFnnDR+mwD
         KRDaLMImjHfskU1v18PlVGr+dS7EajfFntnO2HceAcw6L655uIj6YQ2xyNHd5xE4YJd1
         5GtkEXmAF05p5dze+1Yn9NoT44UntXfDBjW6Ha7iFY82vQQ9K5nDzhD3T2eqbPSIxUTB
         XPg5S52rFAPES0lsdGTrXgaCkBLKVnNe+cbsv701InUBVbmgAc1C5oTfMm5qwKjy9rxs
         21vrlJ94MYLlHhkBZaC5bakzkFAXJHMxWNlrsafuFI6PRh9FGszOY1JuaXIJHFC9d2lu
         ewog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684493008; x=1687085008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWt2qP+e1SDrtcGYZghlo0NbjI0r5adHq8yWB5oHK48=;
        b=JBu8WumXDNaJut0NuvEmyVuodsZYy5CLDoq+5+pwfEU1w/nQBRmakotFNEUaVfEtc3
         bldhsVLzVreCoRfdK7/TMm6D2t1AqYYm4xm8AXCIAJeSxpEsM49eSXqDyOL+nZwfNsxW
         os4j65rpmVF1SSjMIkA89Ktx52StvTmXJoW7YcLb4HiCayhRnHTIJsozD8OAqY+x2j9/
         2M6E6OBFONrak82rU0Q0ia4PinU7SSUjYNTkex5o+LakHmBfIobe4QY9/VaIgtvOQMZZ
         ofHD8aKK2sw1l8UBBetMa4ToKLY570cHnMGefKCi1EbJOsPPGk/juOp3RUhb9UorcvRf
         2u2Q==
X-Gm-Message-State: AC+VfDzdbkV+4t7hRLq2XMChM9KGhNZz2A0rp4o3YcuNoUaE7fZbqzoP
        1hir0r5OJVpoX9v0+n2lAKM=
X-Google-Smtp-Source: ACHHUZ6rYy6bVmQaIPLIKx0lK7QkULIDyWAuQZNO8Awc8eLbFGi/Ruounn1Kyh5I+T3tAa/OkgeM6w==
X-Received: by 2002:a17:902:e9d5:b0:1ac:8cd6:9323 with SMTP id 21-20020a170902e9d500b001ac8cd69323mr2012218plk.22.1684493008298;
        Fri, 19 May 2023 03:43:28 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001a285269b70sm3080693plj.280.2023.05.19.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:43:27 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btqca: use le32_to_cpu for ver.soc_id
Date:   Fri, 19 May 2023 18:43:23 +0800
Message-Id: <20230519104324.4623-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use le32_to_cpu for ver.soc_id to fix the following
sparse warning.

drivers/bluetooth/btqca.c:640:24: sparse: warning: restricted
__le32 degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---

Change since v1:
fix the line length > 80 error reported by bluez.test.bot

---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index fd0941fe8608..e7e58a956d15 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -637,7 +637,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/%s", firmware_name);
 	else if (qca_is_wcn399x(soc_type)) {
-		if (ver.soc_id == QCA_WCN3991_SOC_ID) {
+		if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/crnv%02xu.bin", rom_ver);
 		} else {
-- 
2.34.1

