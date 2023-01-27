Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168767E2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjA0LTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjA0LSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802F63E0B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so4200811wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1rofkASwOxqgmxowzyZ3fLwYQAi8p7kZIwCpQKFbL8=;
        b=CG9kYsacMx/Tbrvb4bhDrUJ/xowc+DpWPTgmEGnhSnDpR+N5ZUg3GCz556j1mFQLhV
         PM/5VYn04MOOb28K1NWgrVDfNDlIoXekRLaLMvqE9SC0g1Nw8M/BPkgGKLjaObUP43DQ
         +h28LCuc262XuxcB8sPjsACtMkEd8IwG32p8x0sg5cAO1gq19uvi62dYM26ctD6orZm+
         Fck1xkbRFYtz8vceSLiiixhZNTnJJ5PaGeZ4TmXMKGIr/jJcRrboP1apF0vQkT8xiDTZ
         ZDSX/dRXgJirtOkZHzfhPyfwNU+NWr9irmXpsTwCwVxGTyZwtj2iA7pkuHIloCwXhXhd
         qvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1rofkASwOxqgmxowzyZ3fLwYQAi8p7kZIwCpQKFbL8=;
        b=DFvZs82+D663QFMfAbYldFPpik6T1vOWLT3jXMBpQ3ckjSSG6YqCa2bIPN1C7PUzPR
         9yCBqpvdSUAp6RfFckQbTQYlQnZ1PIO8FH2QpEPnz8VGO8+64isOR8VtrdfeS3w6pWp/
         TQYugPiO+jaf8RG10FduWs5jG4IP2i8AWu9MRI/fLJHrNatt8mZbsAUBm2xMoz1HmKOv
         XEGWtIYyHPdRn3KxtZZp4wMTTC2O+3NZEq6L7wb0UGW8J6J640vgHoiHgB1xDKW8DPG5
         5Jpkg0ekPJaUvS+Ec+/twA6zKKMS9aAyH2Vz8iTypjwvePL4Jhb7M2J6QD6gbVUt6j+I
         KZYA==
X-Gm-Message-State: AO0yUKUkF2312MDlaUQ3IUTBjlXaTaCy3YdJUBN127zvKgmicALqHCNM
        s+EAC3YCri1pWHXEkQX5/3rY7vYK6PJSwMBs
X-Google-Smtp-Source: AK7set++bOwltOgTSHZbZ5yQoTqvXj3ykM5tzw0xMxRLzB41UYuY3lejlPpOxvSsNSVroroXg/Mh0A==
X-Received: by 2002:a5d:668d:0:b0:2bf:d17c:609b with SMTP id l13-20020a5d668d000000b002bfd17c609bmr1902116wru.64.1674818285770;
        Fri, 27 Jan 2023 03:18:05 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 19/37] nvmem: core: allow to modify a cell before adding it
Date:   Fri, 27 Jan 2023 11:15:47 +0000
Message-Id: <20230127111605.25958-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Provide a way to modify a cell before it will get added. This is useful
to attach a custom post processing hook via a layout.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-provider.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 80051726b064..216a8eb01d00 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -694,6 +694,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
+	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
 	struct device_node *child;
 	const __be32 *addr;
@@ -723,6 +724,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 		info.np = of_node_get(child);
 
+		if (layout && layout->fixup_cell_info)
+			layout->fixup_cell_info(nvmem, layout, &info);
+
 		ret = nvmem_add_one_cell(nvmem, &info);
 		kfree(info.name);
 		if (ret) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3bfc23553a9e..be81cc88eabc 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -155,6 +155,8 @@ struct nvmem_cell_table {
  * @add_cells:		Will be called if a nvmem device is found which
  *			has this layout. The function will add layout
  *			specific cells with nvmem_add_one_cell().
+ * @fixup_cell_info:	Will be called before a cell is added. Can be
+ *			used to modify the nvmem_cell_info.
  * @owner:		Pointer to struct module.
  * @node:		List node.
  *
@@ -168,6 +170,9 @@ struct nvmem_layout {
 	const struct of_device_id *of_match_table;
 	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
 			 struct nvmem_layout *layout);
+	void (*fixup_cell_info)(struct nvmem_device *nvmem,
+				struct nvmem_layout *layout,
+				struct nvmem_cell_info *cell);
 
 	/* private */
 	struct module *owner;
-- 
2.25.1

