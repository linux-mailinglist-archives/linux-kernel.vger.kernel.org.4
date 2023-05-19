Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651A5708CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjESA0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjESA0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:26:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5CA10C6;
        Thu, 18 May 2023 17:25:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso194367a12.1;
        Thu, 18 May 2023 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455950; x=1687047950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMfahW6oLGHRObTA6rrybI0oq2bzFJD+CcgVRcI95q0=;
        b=qUB74s/YaZimii0sfE3q+3Tb8Vk9ayRq3pHJ724br+e/iXX5TPZODU4JGnt7tWGqWP
         8rjUus4BPiyAupRUVqet8OEgdI/5hGQZ6ELwQbXXEg0ZV69H2SXBlcWidnyQBacxK8GU
         tUq/qslNDDRpRMShQ7ZYxhw4II2xEgyQN5rJt8zao+DJSFJJaYdXRsFHIdRgZj9nR4iR
         PCpsSbm769v74/5n0OWZI/WH8jrk9bqd3njyU+vMRmkdVds2/Joj/FfRE3mutPRwtYhI
         Clsafxri4jpthwZk3lsggsMcVJNUwmQAsUpxOnKgbECbHzo22PjRYF2XF58hr8WL/kaR
         uW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455950; x=1687047950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMfahW6oLGHRObTA6rrybI0oq2bzFJD+CcgVRcI95q0=;
        b=UwkZ+WujTu/nohbq5TqdECQQ4TC+i46zzDNC97IV9CU4buX/0Y9st+bU4ltVhPiMnD
         +gRB9ISOJJvpo1t0npkiyFg42T8EC6R7TvFP+ijAU2ZC2LDIDFAZrFaBwQKOhu2kgYEH
         kwMl9z5itV9ErQjfReMa31OFksDVD+6asd6j8u8utMovBvQJi3yD228KNJYHoU6aVb7h
         nOr+96vUCMI4FU/H5pdzBoszID5qal1zlmDYClXATfE6mHSLj77ayzAmvKvntq0NbS8E
         5M8Cw3HJee5l8ALPZuUAKuuueTmb8Rf6iTsllpddZXN1pla87EI+uE4Y9Tv4Z6JmzEPf
         bGfQ==
X-Gm-Message-State: AC+VfDzlZTggeWv2TqDJzU8fc2imkDo5jA+nTdHsicNLcRxN+pSeZVsa
        /OApva05RCFAUCkg0PscXPs=
X-Google-Smtp-Source: ACHHUZ4VLJqv0ylytSewSk8F25tuq10rcvffO6/7iT90V2PdgIf9rDdZC0vhqSPtZDpuM02BTM0c8g==
X-Received: by 2002:a17:903:41c9:b0:1ab:28b4:6d5 with SMTP id u9-20020a17090341c900b001ab28b406d5mr4398400ple.5.1684455949645;
        Thu, 18 May 2023 17:25:49 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902a5c600b001ae57277a87sm2022696plq.255.2023.05.18.17.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:25:49 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btqca: use le32_to_cpu for ver.soc_id
Date:   Fri, 19 May 2023 08:25:43 +0800
Message-Id: <20230519002544.3695-1-minhuadotchen@gmail.com>
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

Use le32_to_cpu for ver.soc_id to fix the following
sparse warning.

drivers/bluetooth/btqca.c:640:24: sparse: warning: restricted __le32 degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
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

