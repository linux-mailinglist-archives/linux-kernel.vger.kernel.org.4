Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF7E5B7F09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiINCgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiINCgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:36:22 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2988F6AA26;
        Tue, 13 Sep 2022 19:36:22 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id h1-20020a4aa741000000b004756c611188so1323418oom.4;
        Tue, 13 Sep 2022 19:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vPvbO7ZwmBLpmPZWL6EL/Tpq0V2KuVYVEM5NRN+l2Sc=;
        b=A3EylJT7O9g+jefl03sB6zihaTB7wgZA2FO+LMlf+/2zJFycFMNMvV42oOAjam0hUu
         q9veoPUNg9U0mYHgosvkYQhENnxvwRKFTmQYeLowna4JznV2cwZrkndSHSBuwMnGBWGr
         HpvSzkBYj8l3526FZ4h4VEBkSME9jZOFLETJmJTjio4ncV5W+sdzFDJYAP5+JUcSpHpz
         pss9GyXA/oF1QT+Sl5NQ02TdIyG5aJ8VmjRsqiMmSsxblvIEnO2bWmRBCzwu+EndwKZE
         5er3E05dgmkofJWq3lQXA5183wlpKLcPKN/1NaWrLLjiw5yWiM4YUPZRmnq+ZHjrEsPG
         8AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vPvbO7ZwmBLpmPZWL6EL/Tpq0V2KuVYVEM5NRN+l2Sc=;
        b=bDceDK2Or/NuiXvjXoFoVhMATGcgdSvXam8w8Uyutbyk3UiaY4rFPweoCucVUBeTIf
         o9ID9BYAaLRlq8hVw+73CZHtxe9Wn5sEKzsbm8vLwgzr9jZpsHx/O5HHPCaOHhzdOB04
         8dyseXCaf0Z3EzgHyQ+IEjk6qTmBxhWxeq80NJtwWV3j4+laLELYj98jcn9GnZrIzyeG
         5qhatXXqJBMq/LYMoPx50p9dF+uomK8bYbpcHaLCDvlwLCZtOQ5E1SWhX6XQoa3GwYwh
         niXdro8HU8YaSa/UsgEVNbt72SHYc9xjcK9czbAKittCP/kC48rHs5CvZ2UBsicyoDHu
         IQ+Q==
X-Gm-Message-State: ACgBeo1D1Oi3jl0cXtBeHAqgXW7RXvip9JnRXVaqeQXMoMO3xhDnaibH
        fbQgC3LfKuzKjmKnLn1yHZ0FtAQNrDDGrA==
X-Google-Smtp-Source: AA6agR6I3eE3rbNa8yHKMInUM6pDXUw7shES1Kt7J1PE6mJTZefEJyxWkWebCz5iMj6/jd/i5Xq7Kg==
X-Received: by 2002:a4a:b6c8:0:b0:44b:4bfe:426d with SMTP id w8-20020a4ab6c8000000b0044b4bfe426dmr11937299ooo.12.1663122981315;
        Tue, 13 Sep 2022 19:36:21 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:94e2:ccf7:1a63:3c59])
        by smtp.gmail.com with ESMTPSA id v4-20020a9d4e84000000b00636956b3080sm6979036otk.43.2022.09.13.19.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 19:36:20 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: dbc: Fix memory leak in xhci_alloc_dbc()
Date:   Tue, 13 Sep 2022 23:36:09 -0300
Message-Id: <20220914023609.695296-1-rafaelmendsr@gmail.com>
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

If DbC is already in use, then the allocated memory for the xhci_dbc struct
doesn't get freed before returning NULL, which leads to a memleak.

Fixes: 534675942e90 ("xhci: dbc: refactor xhci_dbc_init()")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index e61155fa6379..f1367b53b260 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -988,7 +988,7 @@ xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *
 	dbc->driver = driver;
 
 	if (readl(&dbc->regs->control) & DBC_CTRL_DBC_ENABLE)
-		return NULL;
+		goto err;
 
 	INIT_DELAYED_WORK(&dbc->event_work, xhci_dbc_handle_events);
 	spin_lock_init(&dbc->lock);
-- 
2.34.1

