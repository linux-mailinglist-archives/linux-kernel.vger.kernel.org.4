Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573E2610C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJ1Itc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1Ita (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:49:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E51BB56F;
        Fri, 28 Oct 2022 01:49:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so3916999pjl.3;
        Fri, 28 Oct 2022 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+W6HdSggedVNAmKo44TRVUJtR5I0fDVO41SU1t933A=;
        b=ZlFVufaSjqP/ASYTdwQb9tl7oyw9vZS35rJU/RjqitL7RCi8kuSG7Jsrqd7MSTvNcX
         h3ODQ0RIBU5a3GQmXSBE83vhrGXPf0qDoO8w8r5a4vICkq+wuJJfzluwzlwMCDaPR8aQ
         BORQ5MPT+9zEns0XulJEZByS0a/2phk6veX5vW5zl7062SMAcvbR4bngRMKvVpl5YK4y
         JU7ZjK2/u9SxXAov5rUdsZdKo56RQQbO6hKFbwJ3kTr6PriLeFlvBgvcZzq+N2+kU1zM
         I/Fs6vN9ApNugZylu8UBaKsPFYe0uRMZ9SdnpcbLB3fiFUxWcZzsh/Nqak85Sil3Qpj8
         flOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+W6HdSggedVNAmKo44TRVUJtR5I0fDVO41SU1t933A=;
        b=phj7gkc/ZQ8Zx4z7vcrGamTU1DaqYLMObyZjmL+v9j0iArEU/a0Ga1D0OYXL39XyCu
         z/9NBd7WSyByWAueD2xJHdb4DEBv6CdkRCT3BkIebR43RZHsQm26JJZh2NdEtlYskJ6N
         Al/+UZNcIxO/nHEZQU/FoFTquOjNM7fo/0+llkJkGBg3QggaqoSCfA+CBNLFPckIfmwR
         Ts/TuoJMnzl7av3aLpMyCUbQEaw1PgbUnd65E2gpY1M0UtFEjBQPuk8yRAvieVmBmTZj
         6psDY71WzKbnz6R31N8OrNVWlz+UaWdQiaLMp/inVRPkH3kqOdHc1dT69uzUjeNHPLGT
         INXw==
X-Gm-Message-State: ACrzQf0F2H3mngJCxJckc3G+Juz7wqw4o01ADcAK1Dg40fmoC/T1lxIH
        XN70tjgKv9kgQosrYhgmB1I=
X-Google-Smtp-Source: AMsMyM5gQaPFuvITBpw4qWMCFy8pdSdOeML/FaZqEcgGgF8C4s8zlMAtzeAAUjUUOplktZu9A5XoRg==
X-Received: by 2002:a17:90b:3646:b0:213:812c:7c62 with SMTP id nh6-20020a17090b364600b00213812c7c62mr5646050pjb.194.1666946964032;
        Fri, 28 Oct 2022 01:49:24 -0700 (PDT)
Received: from localhost ([60.27.159.185])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b0056bc1a41209sm2401584pfb.33.2022.10.28.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 01:49:23 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        bruce.chen@unisoc.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Fix dentry leak in dwc3_gadget_free_endpoints
Date:   Fri, 28 Oct 2022 16:49:19 +0800
Message-Id: <20221028084919.21654-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Chen <bruce.chen@unisoc.com>

When using debugfs_remove_recursive leaks a dentry with
a hotplug stress test, the phone runs out of memory.

Thus fix the issue by using the newly created debugfs_lookup_and_remove().

Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/usb/dwc3/core.h    | 1 +
 drivers/usb/dwc3/debugfs.c | 3 ++-
 drivers/usb/dwc3/gadget.c  | 4 +---
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..ba3ecaa7f06c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1261,6 +1261,7 @@ struct dwc3 {
 	u8			num_eps;
 
 	struct dwc3_hwparams	hwparams;
+	struct dentry		*root;
 	struct debugfs_regset32	*regset;
 
 	u32			dbg_lsp_select;
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index f2b7675c7f62..b9af4a81f51d 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -911,6 +911,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
 
 	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
+	dwc->root = root;
 	debugfs_create_regset32("regdump", 0444, root, dwc->regset);
 	debugfs_create_file("lsp_dump", 0644, root, dwc, &dwc3_lsp_fops);
 
@@ -929,6 +930,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 
 void dwc3_debugfs_exit(struct dwc3 *dwc)
 {
-	debugfs_remove(debugfs_lookup(dev_name(dwc->dev), usb_debug_root));
+	debugfs_remove(dwc->root);
 	kfree(dwc->regset);
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 079cd333632e..6d6c188fcbea 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3172,9 +3172,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name,
-				debugfs_lookup(dev_name(dep->dwc->dev),
-					       usb_debug_root)));
+		debugfs_lookup_and_remove(dep->name, dwc->root);
 		kfree(dep);
 	}
 }
-- 
2.34.1

