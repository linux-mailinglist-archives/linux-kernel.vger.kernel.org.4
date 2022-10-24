Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100560B1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiJXQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiJXQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:37:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50636879;
        Mon, 24 Oct 2022 08:24:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bs21so922108wrb.4;
        Mon, 24 Oct 2022 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLgc4/4C8v2jDtY+kMWIa5ZzBrBS7jfMBU2/F5ZQ5SM=;
        b=B71lktSNCiRFQJrKXCWCN4QxfX/TYZNdY8OxVIsKF7q3E08na25TFcl1p34nsMRMan
         Us3Vg9+DeUik8y0zahnES1/+u2RtqhicAQ9uLYs6A7VS1Rflhq2tGs+V39ktJag6tmix
         Hjl/dRwIcr6w1puXUndLfmDKFOsAXmQktEt9f/NRegSFnkwFg69NMaHO82yG2EBRllXn
         Q9biOxW3QzoHrH7EvxtZGl1wfEukyYRxVvDSsYcmXf1NE13LajLCgYTIyZSC9R5mDCws
         CrtL6pJ5wdUDD14R6XJMfcKF4dmKAZQHbX6BPyJgtbT3T45fk5A7li5ALLXhkaadIX5+
         vpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLgc4/4C8v2jDtY+kMWIa5ZzBrBS7jfMBU2/F5ZQ5SM=;
        b=AiXSEmtumLyTjFmGYKNAS3d98/fR7cxbzk4L1Cw9hooP5ivwNzUiB5Qdv+Uku7xgBQ
         e8Ho6OOW2vBC2QrIXGcquJ3OlyO/QQqWUjX7AEvGwApJ2jCSPo3oqp8GAZU9gLwiRQw3
         SBFkhtaptRX8UFWTQ0xnxyesdS517qG+JGQZRjYg42vpolGp1lAqAOSyw/MOZnjDc7hx
         Yc1X1adjZ8HAAz+h1txmBdWi++sG5RlPpz6fgcUXSD5q0HfNscbzsVOgl5ibWcZPK/JA
         DBFtwN7KI9fJSHZhvNFjYX2sWmJwzI1iXvCErqDSsgWLDKBIq7Gss8hKNbr6ei5rn2od
         n4iQ==
X-Gm-Message-State: ACrzQf2b6fJQHsCWVkGCVI0Odf6/RErU14WProTOmiEVMhrQs1COfB5D
        OYIUR/09V0+HYNFUwy0V60eR3bVUuQnlr1ZU
X-Google-Smtp-Source: AMsMyM74x8Xq7pcPJv3wMuHY0rzfdbCS1si0suzLihSkp26iytP0gSH5VGVeWMKinACC1WYjKtXVKA==
X-Received: by 2002:adf:dc8a:0:b0:236:6372:551e with SMTP id r10-20020adfdc8a000000b002366372551emr7300862wrj.41.1666624436138;
        Mon, 24 Oct 2022 08:13:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b003c6c2ff7f25sm181093wmb.15.2022.10.24.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:13:55 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Slark Xiao <slark_xiao@163.com>, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7164: remove variable cnt
Date:   Mon, 24 Oct 2022 16:13:54 +0100
Message-Id: <20221024151354.2166343-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable cnt is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/pci/saa7164/saa7164-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index d5f32e3ff544..01d75ef2342d 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -352,7 +352,7 @@ static void saa7164_work_enchandler(struct work_struct *w)
 		container_of(w, struct saa7164_port, workenc);
 	struct saa7164_dev *dev = port->dev;
 
-	u32 wp, mcb, rp, cnt = 0;
+	u32 wp, mcb, rp;
 
 	port->last_svc_msecs_diff = port->last_svc_msecs;
 	port->last_svc_msecs = jiffies_to_msecs(jiffies);
@@ -405,7 +405,6 @@ static void saa7164_work_enchandler(struct work_struct *w)
 
 		saa7164_work_enchandler_helper(port, rp);
 		port->last_svc_rp = rp;
-		cnt++;
 
 		if (rp == mcb)
 			break;
@@ -429,7 +428,7 @@ static void saa7164_work_vbihandler(struct work_struct *w)
 		container_of(w, struct saa7164_port, workenc);
 	struct saa7164_dev *dev = port->dev;
 
-	u32 wp, mcb, rp, cnt = 0;
+	u32 wp, mcb, rp;
 
 	port->last_svc_msecs_diff = port->last_svc_msecs;
 	port->last_svc_msecs = jiffies_to_msecs(jiffies);
@@ -481,7 +480,6 @@ static void saa7164_work_vbihandler(struct work_struct *w)
 
 		saa7164_work_enchandler_helper(port, rp);
 		port->last_svc_rp = rp;
-		cnt++;
 
 		if (rp == mcb)
 			break;
-- 
2.37.3

