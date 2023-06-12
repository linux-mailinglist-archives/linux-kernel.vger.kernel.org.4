Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930E572B608
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjFLDVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjFLDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:21:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B338E10D8;
        Sun, 11 Jun 2023 20:19:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6532671ccc7so4274581b3a.2;
        Sun, 11 Jun 2023 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686539958; x=1689131958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnwXoTfAjNKtmmu+h2X8viuU0CQTCnF38bCD8KDLgdA=;
        b=LMla4nCwPUfIHE5Ve5y77UoJzkj9XH/NNStiqa1ATWK8uUlXnJkXquyou0uuO98B/3
         58fKYILWgnDQRZhI6HePC90rISArwOinDvtCn1littK2LDJtLPernfebjvWJhpypMGqO
         mEMWeppsX2bcZ3WZxApjiMvetxehh7i31MwoNGDdsBUcmX6AO285YVqLe12jtDMj/BU0
         AD2qSYJBE40BIBXCocpSTrQbABTeJGTUcDjnqLMRw15qIFkqP9Y5W2UuYH3e8yWlXBbK
         3STqC0VlGuxDO4eF/okfdOiQBxjiggnDVOzw1kFHeNI19Q1RLTsWunAnsyK9RB7Ow67M
         g7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686539958; x=1689131958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnwXoTfAjNKtmmu+h2X8viuU0CQTCnF38bCD8KDLgdA=;
        b=aS1JVSr/EeXeYQ9hLqxHZP16RsdK/tEMgEWOcn3UK46XRFiih+7EsxhHcZzySyk7WV
         aDFeacdrL2neBvHd2QveExc/fA0UXNhiqT+Di1NWtGg7BXvYA1/qzseEaq46X84H5ThC
         6vIZ9pOBvEMRNI+IQ34oP30g+f+tSJnNqJX9Wr2pFjQu2ZKjDPvNowF7AMbfGHFdnVae
         ePp5OiBwK1YVMHzCF8FJS9cNOUN4uaWg6mk84hcTvjGJgjb5cK/achQ1VvsrTxgz1+Zf
         wMlk8smzmFJhnV6FuvgQty4o4FyT7kixRGZ4dTFDcVDndGibBmKx4HYDDa6OaRQLHKHu
         35Aw==
X-Gm-Message-State: AC+VfDzoSKTNy43iN72bVmnrBOhEfiwIKjllwmP4xT990BfLYzP+nGyv
        9EAKPTlt3YrVoYCzHZZji+YMeVasJitG/VSV8XM=
X-Google-Smtp-Source: ACHHUZ6N4Nh1SAip/KXj6nE7uF8b9QoD8cUzqaJDuRczmR3ZnWGH+wTchxOPIFoYZe97z99KeWBRdQ==
X-Received: by 2002:a05:6a00:1a10:b0:652:98e9:fb1 with SMTP id g16-20020a056a001a1000b0065298e90fb1mr10582701pfv.32.1686539958108;
        Sun, 11 Jun 2023 20:19:18 -0700 (PDT)
Received: from dmssc64-Default-string.lan (ec2-3-38-176-46.ap-northeast-2.compute.amazonaws.com. [3.38.176.46])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78503000000b006414289ab69sm5940853pfn.52.2023.06.11.20.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 20:19:17 -0700 (PDT)
From:   a345351830@gmail.com
To:     345351830@qq.com
Cc:     amy.shih@advantech.com.tw, oakley.ding@advantech.com.tw,
        zhijun.hu@advantech.com.cn,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v1,1/1] watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)
Date:   Mon, 12 Jun 2023 11:19:07 +0800
Message-Id: <20230612031907.796461-1-a345351830@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

Add PCI_VENDOR_ID_HYGON(Hygon vendor id [0x1d94]) in this driver

Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
---
 drivers/watchdog/sp5100_tco.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 14f8d8d90920..2bd3dc25cb03 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -96,7 +96,7 @@ static enum tco_reg_layout tco_reg_layout(struct pci_dev *dev)
 	    sp5100_tco_pci->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
 	    sp5100_tco_pci->revision >= AMD_ZEN_SMBUS_PCI_REV) {
 		return efch_mmio;
-	} else if (dev->vendor == PCI_VENDOR_ID_AMD &&
+	} else if ((dev->vendor == PCI_VENDOR_ID_AMD || dev->vendor == PCI_VENDOR_ID_HYGON) &&
 	    ((dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
 	     dev->revision >= 0x41) ||
 	    (dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
@@ -579,6 +579,8 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 	  PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
 	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
-- 
2.34.1

