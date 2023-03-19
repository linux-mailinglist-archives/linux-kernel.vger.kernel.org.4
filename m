Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9206D6C032C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjCSQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjCSQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:33:14 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1A211D9;
        Sun, 19 Mar 2023 09:32:48 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id s7so5395371ilv.12;
        Sun, 19 Mar 2023 09:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE9pu/DRfAdXm95rr3VepAwA/+9JYYjjkqTbdSZh0/k=;
        b=Yw6gBHVQxFSAzAwO3Ftwxn1teQ52tS7RTbnRv7AqvZtX/C0/wsa0p+5rrCD0HswzJT
         IudppGTWSkZRpaFxlqsJuxGvfCc3Mc08j9QTv6V4KmnXflqWDjl2QKapulH1K+cju2Uy
         lFWyv5lDAqx8yKpC1vlERTgrGKkYKtTGWQYBaW6qFggMd20v75Di6JjyyOaREAdKdA3j
         rdp+hY18aVzu1F/loX1ls3x5Fm2DatwZPCYb4FvRCXlQQ6HWTaL1NQoB+fzidfVSmkkk
         6FYzIX4uG6+XyO1lsAT3wywMFg9EM5Yza+j2kXtOMzBQ5fDapMuyA5NWTiOKQ3hLULqa
         SyRw==
X-Gm-Message-State: AO0yUKUDL4jjD3JGS0xbPLd/BtpI0zt0FmTTAM2wkWIrtzbH/7cPNgvP
        0EC7AioYvpaAgZRQwDa97g==
X-Google-Smtp-Source: AK7set8TmV5UVPTkReQlgL09w24MdyyWUQneS0fdD4520jOIVQTiqM8e0NB/f35ify8j+9IAH9zL9A==
X-Received: by 2002:a92:ce50:0:b0:31a:1554:b0a with SMTP id a16-20020a92ce50000000b0031a15540b0amr3905365ilr.10.1679243567618;
        Sun, 19 Mar 2023 09:32:47 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id n18-20020a922612000000b00316dc3afe57sm2150373ile.86.2023.03.19.09.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:47 -0700 (PDT)
Received: (nullmailer pid 227058 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>, Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: ARM CLCD: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:32:41 -0500
Message-Id: <20230319163241.226984-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_get_address() and of_translate_address() with single call
to of_address_to_resource(). With this, use ioremap() instead of
of_iomap() which would parse "reg" a second time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/fbdev/amba-clcd.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index f65c96d1394d..1289bfe6e872 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -759,7 +759,7 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
 {
 	int err;
 	struct device_node *memory;
-	u64 size;
+	struct resource res;
 
 	err = clcdfb_of_init_display(fb);
 	if (err)
@@ -769,18 +769,20 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
 	if (!memory)
 		return -ENODEV;
 
-	fb->fb.screen_base = of_iomap(memory, 0);
-	if (!fb->fb.screen_base) {
-		of_node_put(memory);
-		return -ENOMEM;
-	}
 
-	fb->fb.fix.smem_start = of_translate_address(memory,
-			of_get_address(memory, 0, &size, NULL));
-	fb->fb.fix.smem_len = size;
-	of_node_put(memory);
+	err = of_address_to_resource(memory, 0, &res);
+	if (err)
+		goto out;
 
-	return 0;
+	fb->fb.screen_base = ioremap(res.start, resource_size(&res));
+	if (!fb->fb.screen_base)
+		goto out;
+
+	fb->fb.fix.smem_start = res.start;
+	fb->fb.fix.smem_len = resource_size(&res);
+out:
+	of_node_put(memory);
+	return err;
 }
 
 static int clcdfb_of_vram_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-- 
2.39.2

