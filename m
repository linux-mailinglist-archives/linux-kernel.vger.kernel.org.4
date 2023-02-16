Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E05699FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBPWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBPWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:32:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651AA4C3FA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:32:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso5417202wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5vXNR+H0c80bTIPdRkMX1RbvYvrD4ce9/JGf1xe3NU=;
        b=k61SMX1KONa9iIwehIQCaziylg3pU9/0NrlOH9Hn+OQjDN6wbgXkM9RHYX+r7+lAuu
         jzbuPTNK3M1N0Mfo+tF9uRANQzUn0/Xrg/ZLfBvQSxV8+UYN8Gp00TGUCcohgzIF0vSC
         K0c790y0PII1LJ+rOuYrg5NSkGlyCJ0I9lhbnkKV1dYzsNi2T11orf7ZW9Wjkgh0+axh
         QMTI99YrfV/oYznnM1UnHvo6ERVyd088YMzgY6DMRxt5dKbz+m4feKuOjcsNMRM08GBN
         ys0kI7EP/NtksrCM1J/xa8vzp7W8qdToxAKrqfm41cFFbQO2tSpnksTHYIX7OFuaFSyB
         qzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5vXNR+H0c80bTIPdRkMX1RbvYvrD4ce9/JGf1xe3NU=;
        b=vNkG3Ei7PLCyyU+YEGMcLuzTaYTgqEl0lbA8y1khj72/x38lZdzvMAtoo/me+s85k2
         NDuP/WzbnTFMDrbt7hQYCVn60UthGybbKTZHaNqEA0/YPoMCH1zoCJ4xguY0Vk7D4E3M
         YVB/dHonMJT59bHVlpPlj4EXvVt6ZjBsnlZOvSgUu35giM9Mi47pnKkBfOj/s2HWCxrl
         YbtSU5b1XqrORezI1nyQb4sIIrJdVdi54L/HjbmBz86vCseFbPiKRWrM2xm/sQwwJOGo
         AEeIawNSZ849VYRp7fcbCNkALFSBLmpsspxlRfql61nrQqSfivmnsSPEGC2nLfrSi/F2
         nv5A==
X-Gm-Message-State: AO0yUKXa4xlXbRcpC4AHpRhDAJiZqBJQI+lJCHbCJMfJ6LSSN2ex6VDz
        0VRPs4QpQ2uQXZV8PvAYk/JHXh78mnE=
X-Google-Smtp-Source: AK7set+ZGMp24px+TnsXdQfuQM0UG+V8p3bLk8k/icBDJpYn/wMn48jL5+ckyQFjW2ImbFFmLdt5uQ==
X-Received: by 2002:a05:600c:816:b0:3dc:5390:6499 with SMTP id k22-20020a05600c081600b003dc53906499mr6517227wmp.1.1676586730839;
        Thu, 16 Feb 2023 14:32:10 -0800 (PST)
Received: from localhost (94.197.187.145.threembb.co.uk. [94.197.187.145])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003db012d49b7sm14516056wmb.2.2023.02.16.14.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:32:10 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] regmap-irq: Remove unused type_invert flag
Date:   Thu, 16 Feb 2023 22:31:59 +0000
Message-Id: <20230216223200.150679-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

type_invert is deprecated and no longer used; it can now be removed.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 11 ++---------
 include/linux/regmap.h           |  3 ---
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a8f185430a07..e3092f522107 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -189,12 +189,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 			if (!d->type_buf_def[i])
 				continue;
 			reg = d->get_irq_reg(d, d->chip->type_base, i);
-			if (d->chip->type_invert)
-				ret = regmap_update_bits(d->map, reg,
-					d->type_buf_def[i], ~d->type_buf[i]);
-			else
-				ret = regmap_update_bits(d->map, reg,
-					d->type_buf_def[i], d->type_buf[i]);
+			ret = regmap_update_bits(d->map, reg,
+						 d->type_buf_def[i], d->type_buf[i]);
 			if (ret != 0)
 				dev_err(d->map->dev, "Failed to sync type in %x\n",
 					reg);
@@ -1028,9 +1024,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 			ret = regmap_read(map, reg, &d->type_buf_def[i]);
 
-			if (d->chip->type_invert)
-				d->type_buf_def[i] = ~d->type_buf_def[i];
-
 			if (ret) {
 				dev_err(map->dev, "Failed to get type defaults at 0x%x: %d\n",
 					reg, ret);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a3bc695bcca0..2114679729ce 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1547,8 +1547,6 @@ struct regmap_irq_chip_data;
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
- * @type_invert: Invert the type flags. Deprecated, use config registers
- *		 instead.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
  *		  the hardware provides separate bits for rising/falling edge
  *		  or low/high level interrupts and they should be combined into
@@ -1625,7 +1623,6 @@ struct regmap_irq_chip {
 	unsigned int clear_ack:1;
 	unsigned int wake_invert:1;
 	unsigned int runtime_pm:1;
-	unsigned int type_invert:1;
 	unsigned int type_in_mask:1;
 	unsigned int clear_on_unmask:1;
 	unsigned int not_fixed_stride:1;
-- 
2.39.2

