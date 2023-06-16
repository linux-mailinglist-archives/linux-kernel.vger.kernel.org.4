Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6A733111
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjFPMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjFPMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:22:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D516B30DE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:22:22 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F63F3F16F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686918141;
        bh=zw1VmnyGgP9Z0XT+cVN9mnOntivZi1r272LyKdlNy7g=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RIJNmJNTJGsGBEUUh6kft2PO2UUoeSN+hEuO41fYKU9WR2SLgTviKxk95QvwDFzCw
         ooIUmY6BhQLcAR9ySnoI1iBGgfwgj82oNBrqMq70UadcJz06nq+t4NCTvBsaQxWXRX
         4FuE7WUmu6pCz6sGZpR2+WufYIbTxlFXKq6dlrsCWWZ9u8TIPhS/LY9uRQMSg8o0dl
         7bVHs/Z+o2OYFs4e0SWDbOdIFsMyImdUfjLKv5hTpQ1+QkySK7Mkx+qxyyMUy3eA7i
         q58OAQX7tbR8NAiiRsR11ov//bTuwl3M+50KzoQCGn9GMlkQ2Jhy4wjqUJFVL/Sn2b
         StQKy1QFHAc5Q==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f8dde5535dso2541635e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918141; x=1689510141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw1VmnyGgP9Z0XT+cVN9mnOntivZi1r272LyKdlNy7g=;
        b=gnUqGa/3JMR8sZlrqUvs7IdZMpk7gvy2JK2LbP7lpBAkse3ABHIPMXqvIvDzDJjtdK
         5LbJM0GPzfZABsqKWgkKWp7M0WQE8c545/cjfc5JIgt/60KF6bJBEtGZ7+NpV7FygRuw
         zrBijwgLISdCNwrxrcwq6tXTsa+DlFdtR7gvQKODe3ud7OiQiZkMS1dQbqmQptdk0Wcs
         4hG5maR1oFdTd1iAy6Ks8DacaUYreY5gVSMmdxsdA4k8HKy9HNSpj/l+xiZXtoz5c+w4
         xmXp/Y5isQua53sjovTUF/XgrlW3OF0iQ1GNFKq8aRWvKrmEsMftg7/r+uQmsvkiVtCz
         GQtA==
X-Gm-Message-State: AC+VfDwbVrkjiD1HPfEap9zk8ka6x89dQisjnenazfHazJ5PC9ZH9aOD
        63/lIBKRcpRU2n6cLx6rGBeV/9cyF+pNVOR3XGJAWNQGsfPN+4izZ9F8tYW5+04QrKvYbzTuDug
        M9Tj7Kvcgm9cvsjlp5XcbGtnPRLnbGvr5YuhK45GUkA==
X-Received: by 2002:a05:600c:2189:b0:3f6:7e6:44ea with SMTP id e9-20020a05600c218900b003f607e644eamr1430104wme.18.1686918141173;
        Fri, 16 Jun 2023 05:22:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rBUPHGh+Xrw+/lwEv6Boc48lL+634iJofytBHc16kHMsIMMUVbLAnK1MqG7zZ49WoCqz1ww==
X-Received: by 2002:a05:600c:2189:b0:3f6:7e6:44ea with SMTP id e9-20020a05600c218900b003f607e644eamr1430100wme.18.1686918140883;
        Fri, 16 Jun 2023 05:22:20 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id i1-20020adff301000000b002f28de9f73bsm23571315wro.55.2023.06.16.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:22:20 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        shangxiaojing@huawei.com, juerg.haefliger@canonical.com
Subject: [PATCH] nfc: fdp: Add MODULE_FIRMWARE macros
Date:   Fri, 16 Jun 2023 14:22:18 +0200
Message-Id: <20230616122218.1036256-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add MODULE_FIRMWARE macros to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/nfc/fdp/fdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index f12f903a9dd1..da3e2dce8e70 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -762,3 +762,6 @@ EXPORT_SYMBOL(fdp_nci_remove);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("NFC NCI driver for Intel Fields Peak NFC controller");
 MODULE_AUTHOR("Robert Dolca <robert.dolca@intel.com>");
+
+MODULE_FIRMWARE(FDP_OTP_PATCH_NAME);
+MODULE_FIRMWARE(FDP_RAM_PATCH_NAME);
-- 
2.37.2

