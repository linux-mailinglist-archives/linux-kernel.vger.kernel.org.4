Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE326C0244
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCSOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD01E2AA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679235066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mxfg9kgQ8xTY4kfBNMCHJxuv4+U4pmpKqJi9ZEPAVGs=;
        b=REuErNWEPxX0Ij2ZPdfNXCC5DVy+KkF7lN7OpU7OFUhDMSGp2UOri1gHpfTETebFJzZSOl
        wFZN/cjGKcMqZb8v3NSHVxTuHhU2648UU/zQ3HwIvaDTlMnlN6cMpVJsAB5a4QkRM+dJlI
        TnpYy68sucZ3CVK4Opw5K+WEWFpU4ro=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-MwW4OtXzOhyVAIo_VcUG-Q-1; Sun, 19 Mar 2023 10:11:02 -0400
X-MC-Unique: MwW4OtXzOhyVAIo_VcUG-Q-1
Received: by mail-qt1-f200.google.com with SMTP id fz25-20020a05622a5a9900b003d6c5910689so5306329qtb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679235061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mxfg9kgQ8xTY4kfBNMCHJxuv4+U4pmpKqJi9ZEPAVGs=;
        b=2FljCLxmAzs2gdApyFTXhiLEJEOkG/2WfjFrDLHdrsCYDFN0UziZ5wNE1BLhYHP8pY
         I0erlZQS5UvNeqi98jNsViSeVtr+uzK2WgNE4IHOWNPglt+XCLCxa9kcOpIpSmYvUoKF
         gaoRnzQobfgMlWEM0umJVK9yCmfijlW5PRmVZvDlcH4ZZllN2tv3AUn6RaNczP4KirfF
         IaGmM+zKlw/guLtwMyBPL9TXAF7lA1COTOTBc0j3fGBxTX8NkTLkXKqvh8z9+lP16K9D
         cvScuXz6tPoj5aBuo3UIH/XmgnOK/l/bpKQYgnsatB7FlNYAhFnLTZPIRJnEDlI1pqAI
         db1g==
X-Gm-Message-State: AO0yUKW3ziEiI98SLECp1egUdVEEvwqiY6i8c1F4NfdCQTw4M45Ps/hT
        yIKroL9NsTo3TMTiAgKArzDUyE05NoC9OgP96IAkjXzzefAYJlpHw7v0fk8euTK4jvkUc9VqxMi
        BhQQMoCshj9j7ybDWf2l2sMmU
X-Received: by 2002:a05:622a:1356:b0:3db:6f27:60b9 with SMTP id w22-20020a05622a135600b003db6f2760b9mr11743870qtk.15.1679235061580;
        Sun, 19 Mar 2023 07:11:01 -0700 (PDT)
X-Google-Smtp-Source: AK7set82QnetAWI+F3gcmRcjmUamYUEWEUr1FY8V21h15oRUvVodbHhYtRBiyrHKXmDFomTxkbB5rQ==
X-Received: by 2002:a05:622a:1356:b0:3db:6f27:60b9 with SMTP id w22-20020a05622a135600b003db6f2760b9mr11743843qtk.15.1679235061327;
        Sun, 19 Mar 2023 07:11:01 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b0074583bda590sm5492950qkh.10.2023.03.19.07.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:11:01 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: typec: tcpci_mt6360: remove unused mt6360_tcpc_read16 function
Date:   Sun, 19 Mar 2023 10:10:53 -0400
Message-Id: <20230319141053.1703937-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/usb/typec/tcpm/tcpci_mt6360.c:46:19: error: unused function
  'mt6360_tcpc_read16' [-Werror,-Wunused-function]
static inline int mt6360_tcpc_read16(struct regmap *regmap,
                  ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/typec/tcpm/tcpci_mt6360.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 1b7c31278ebb..6fa8fd5c8041 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -43,12 +43,6 @@ struct mt6360_tcpc_info {
 	int irq;
 };
 
-static inline int mt6360_tcpc_read16(struct regmap *regmap,
-				     unsigned int reg, u16 *val)
-{
-	return regmap_raw_read(regmap, reg, val, sizeof(u16));
-}
-
 static inline int mt6360_tcpc_write16(struct regmap *regmap,
 				      unsigned int reg, u16 val)
 {
-- 
2.27.0

