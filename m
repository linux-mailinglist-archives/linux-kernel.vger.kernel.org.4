Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C2719039
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjFABvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjFABvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:51:32 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5DD133;
        Wed, 31 May 2023 18:51:31 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5552cbcda35so260770eaf.1;
        Wed, 31 May 2023 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685584291; x=1688176291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgQbAD4zC7kyh7MqqeeXdMAW7P6yao31pgzuJElJL7w=;
        b=kkUyzVm4MihjTQwP3aZCH9VByi9/iotHw8zdfTHaZMCneJN/1tdYpbSFeJ76KlkIlw
         3CwEDh2ZMKFdbFHGmbB8lXhk/gFu13dULDc5jksvXtDOB+dUHcdg3maMeWC4VknpWMRI
         tx6+Y1Cv6aM1V+Fp1QEh/fwc2TMM2o23xXn69XOlLOsr5XJmP6YlBUslvJcDogCZEpDF
         3mgNh6awT0MHfnlbKREn3TWdvjHT9pihG3j1Hy8ZfNdEXHbMW6CMAUp/s/a9lrihnC42
         Txbhg/nd4qHtVEcZLx1HYIjThOQjg91Y42ZxC+F/LBySCm2VUnA5xCgtrxp7fFb1jAro
         4aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685584291; x=1688176291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgQbAD4zC7kyh7MqqeeXdMAW7P6yao31pgzuJElJL7w=;
        b=FJ3k+5Iu+zh+ZamfE8qvgNX/f+ETaclLGs1BkZ3x5UawWGLxfiZG6LvZ+S31WOlOFw
         89BLR4Mp1yWddM77eisTnOo8Y2kIuR2ACmJydq5aHUtYSDgfDlbLbd58KR3FXkKepJuF
         YWoXA54+4DEcIC7FihilfzUkk90pvBigkHG5Kdh0L75cCCxWQxjnk91Uwky+LPW01DrW
         IYUuqC28p7UJI6n4wQn4NXaDkdEfBUQhVWvjvhuMzc5Ju1Q/PlyP/NyvG0Zd/WHkJ7if
         JZ1PF7UYEAu4HOEhlFcPEOfeKSXVxPBzsxUGKvsFQ4QrtAriECNcWJNkATHruPqtV2nj
         6TWA==
X-Gm-Message-State: AC+VfDwMUP5sj4ZQ38JEzmzemOjNYRqgAqQ5/jGYGiJ10afK6MGUqYkk
        +qiIKLM5DDxphElNXF/1sjoqOGc8Ns0=
X-Google-Smtp-Source: ACHHUZ70ddQQc3frYxxLbQixmfd9jL9eksGVFPhfD0kYHkzVRBNtEEb3hpKxSROXxiA+9nWgt+/pVA==
X-Received: by 2002:a05:6358:4411:b0:123:1395:629f with SMTP id z17-20020a056358441100b001231395629fmr4575739rwc.8.1685584291061;
        Wed, 31 May 2023 18:51:31 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e454-8dbb-0377-d3ab-ebce-7b9b.emome-ip6.hinet.net. [2001:b400:e454:8dbb:377:d3ab:ebce:7b9b])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a7c4200b00253239144c5sm165795pjl.42.2023.05.31.18.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 18:51:30 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 3/4] mmc: sdhci: Add VDD2 definition for power control register
Date:   Thu,  1 Jun 2023 09:51:14 +0800
Message-Id: <20230601015115.406002-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601015115.406002-1-victorshihgli@gmail.com>
References: <20230601015115.406002-1-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add new definition for VDD2 - UHS2 or PCIe/NVMe.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f4f2085c274c..f219bdea8f28 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -99,6 +99,13 @@
 #define  SDHCI_POWER_180	0x0A
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
+/*
+ * VDD2 - UHS2 or PCIe/NVMe
+ * VDD2 power on/off and voltage select
+ */
+#define  SDHCI_VDD2_POWER_ON	0x10
+#define  SDHCI_VDD2_POWER_120	0x80
+#define  SDHCI_VDD2_POWER_180	0xA0
 
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
-- 
2.25.1

