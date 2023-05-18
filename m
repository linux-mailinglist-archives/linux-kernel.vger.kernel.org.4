Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4170799E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjERF1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjERF1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:27:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160FC359D;
        Wed, 17 May 2023 22:26:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso1158850a91.1;
        Wed, 17 May 2023 22:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684387598; x=1686979598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3SX7vnK+KQM4ZMwTnaOC6JG3KgM54lUutokuN0ixeA=;
        b=qqnvOc8ieLdnJaNzjhBH2+WRmpxqYZgSAE4cBA3AX3cnr6NdzEn/NwpMg/Bf76BYfj
         bTId6cCiw5xbbUO8pxaIJGy375JglemdgmohL8mFC40D7sLFPuxvy7N2UW0OF1+FWRZc
         d6WC2LVnowjYd+H3i3cNpC7z8HTlVjxxMCV/NC6+EFfZob1IcKmDcbj6vDGHe7wAAOca
         4PFWECs4GVG4Z7+Yr+xN1+37Uqcmy/X3kpdJob0kh5Rp16TbTSLwSesfSW9vzOE9AF8T
         RDvJfXLQmi7BGmA4/KmUKydeRrj+2kvskIom8AQB7ShwFQb2JGur/MjAeb5OoTmb3rYu
         vGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684387598; x=1686979598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3SX7vnK+KQM4ZMwTnaOC6JG3KgM54lUutokuN0ixeA=;
        b=O+mK9eFXz8n21OOxh3nA2Q8AqFdYv8U5le1XDThfmJOnvX0u3VDWSsv7hcQOZ2Fpfb
         Mrsw7HUOojQs5y5UAmoc3AavWuMBPAEt5PzVKTgNjnqzn/xwGNB1b2RSOUIPHm4/RfP5
         MnaKEmW91wTBH1xFuqGSColOcY3D3LtrbprSkrxN4wkUCU8Oy3SahVGMpFN4/E5ZzPy8
         p2k4TkAz8k97lyHO9k0fjxTreovEOv4dqWY3iecA3u6xE6y2umwJGqOK5qSFMPvXxUbS
         2R7Q82ucqR8OuX68NTZ2iY5zhzen4hHuQW3CfDsogbErKca3lPswG344EZgI0pP8nche
         pu5g==
X-Gm-Message-State: AC+VfDyo7Pviv1EOz0Lk8258XL+OoFjPEeGRJpscvXwvbKImze0p7eSt
        rut29jTn2Gz3iiy5507zZ34=
X-Google-Smtp-Source: ACHHUZ7/kb6jzt1viu38lPkOl40YN4kNUl879RxNS4D9m4KK+I2IDKc6EtzP3WiBOcTqcx1MkIhi7A==
X-Received: by 2002:a17:90a:2e12:b0:23b:2c51:6e7 with SMTP id q18-20020a17090a2e1200b0023b2c5106e7mr1386307pjd.21.1684387598008;
        Wed, 17 May 2023 22:26:38 -0700 (PDT)
Received: from localhost.localdomain ([111.201.128.95])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a150900b0024e4f169931sm2704098pja.2.2023.05.17.22.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 22:26:37 -0700 (PDT)
From:   Yeqi Fu <asuk4.q@gmail.com>
To:     f.fangjian@huawei.com, broonie@kernel.org
Cc:     Yeqi Fu <asuk4.q@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: [PATCH] spi: hisi-kunpeng: Fix error checking
Date:   Thu, 18 May 2023 13:25:15 +0800
Message-Id: <20230518052515.368978-1-asuk4.q@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The function debugfs_create_dir returns ERR_PTR if an error occurs,
and the appropriate way to verify for errors is to use the inline
function IS_ERR. The patch will substitute the null-comparison with
IS_ERR.

Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 524eadbef87b..2b4b3d2a22b8 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -169,7 +169,7 @@ static int hisi_spi_debugfs_init(struct hisi_spi *hs)
 	master = container_of(hs->dev, struct spi_controller, dev);
 	snprintf(name, 32, "hisi_spi%d", master->bus_num);
 	hs->debugfs = debugfs_create_dir(name, NULL);
-	if (!hs->debugfs)
+	if (IS_ERR(hs->debugfs))
 		return -ENOMEM;
 
 	hs->regset.regs = hisi_spi_regs;
-- 
2.37.2

