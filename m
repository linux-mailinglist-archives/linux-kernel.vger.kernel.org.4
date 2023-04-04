Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2306D6A71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjDDRXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbjDDRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB255B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so133619718edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUpb2JM7n+7eZBq4BlWotaA0EKU+rUj5Kly600q312g=;
        b=hBCgbbkHOu5B9RSMiGPoizTD+mVjukE/VKo8b5D2Dy++O6pvtprK/ssMtbcfE4ymiQ
         efEtsLIsQt/gMIVEyhMxlNKo9xchltk/+zRHSPY+Z/HLSq9o1cF3V8g+zJlZ3QpC1opQ
         yme7DSvfEiktVVKkp+nyFC3vPvFP3IvywUretH7x//zlK7+8P9Jujaw3J//yAEGjrQCO
         +lMOF1t52ZTbbLl811v2VF/uMvM6QRAQZ8onbICA9+azSTgZ8Ta00SNUN0Yc8VBKH84x
         Ix24DhAqigm6x7YLaNDCe2vCyzFwDFhDAwvgzA8DHEIt2i+wSVVADInvsbNdEFmJ+YNX
         QQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUpb2JM7n+7eZBq4BlWotaA0EKU+rUj5Kly600q312g=;
        b=7J2n5wEgNfg6w22+xSplpdjy+fprZcuX6sVFrgWiXIePeZHzAZKWquMiIpM22KVE3B
         hnEWkoxkbfEL9xGQPrTfjHFAit8z/OG1fjPyp2YlqzzKLUtSww8V8+RWzbtFSth837qz
         tyX8E4Lj+NYFmNq24AHa15TmhR0CwloiZNpokWBATzq46Q9rtoNquyvhGD6IPXKwownh
         G4eP0/u737TplkcQMLf8J6np7k3ivZpWSEATmUHt25CP2mzmqu04lUPxOgTs2wJDZQpo
         y9gX78pjA+z/BuzZh1E+erU/dmkvP+D2bkiQLt0wBQRf3oxFgwlabsqF36jPM6iNIWhr
         0/ZQ==
X-Gm-Message-State: AAQBX9ciJFsGtNFaGrKEP7Xg01uOld8MiVvCI74GHj2/ScDBPTFWXjd3
        4Ryf9M/H2NzA5PgA9mzFQLQYNg==
X-Google-Smtp-Source: AKy350ZQwaNXjaTOKKh8KmO6I3neo+7WUDKbK0eMBeQ7BE7yqm8YUH+dYtIsDAQLX2y5jQFyr4xHMQ==
X-Received: by 2002:a17:906:702:b0:92f:d1ec:a7d7 with SMTP id y2-20020a170906070200b0092fd1eca7d7mr51234ejb.15.1680628966047;
        Tue, 04 Apr 2023 10:22:46 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 17/40] nvmem: core: allow to modify a cell before adding it
Date:   Tue,  4 Apr 2023 18:21:25 +0100
Message-Id: <20230404172148.82422-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Provide a way to modify a cell before it will get added. This is useful
to attach a custom post processing hook via a layout.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-provider.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0708f9f27898..f43025ad315b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -695,6 +695,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
+	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
 	struct device_node *child;
 	const __be32 *addr;
@@ -724,6 +725,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
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

