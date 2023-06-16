Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668CE7330F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjFPMQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFPMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:16:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C5294C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:16:42 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C23443F10B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917800;
        bh=9khctnS3KGbhQfn/AhXw2BywtkyBNp99eLHZVmIExRI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=j9WX8ngBKzxgqvog7gCOfDs0/xjxvE3/xqvK/Gx8pE2yz5Ou4qqZtHQm3H+O+4S1Z
         H2A/9237Mx9VOVjLcKujtFc5o47mQoUKs4han0Vsryk8Acqsqyn6TRUsefyqceP0kV
         ZPvo5aKP5aLCVANt4kTe3RcmKe03TbXzTwzvUfG3jAiqRz2Lmpn78J7sFu7SRrFN7I
         WUOzX82zXoZtTOYSVDMAa7N2s6ddpg24WQZqDwkmRoioCOaZjhK98TYsgtF5F17Z3G
         u02jHXhhrgfhwOtRz/9DxSX7EE68gXREHqpBq2QXvQj533Zfyndv0Wk26l8cAXXVKF
         bL7NNhnRajJ9w==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f658076c93so501232e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917799; x=1689509799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9khctnS3KGbhQfn/AhXw2BywtkyBNp99eLHZVmIExRI=;
        b=J8dgnLSS0zBiFcI32TNXJIm5H8B/7jDlMUTa69bF3d9CCvX33j7NESZKbGxELczUJO
         spUXmZ/Se7BPGZc7mLYRFXPcSrUsOEspH5UNbOavnPz2/iSlHiMyuJRGH2amxP5uPUSN
         ShsCiRauQKzJkDt/9w2D4vbETx8sBGzT+J5pdTnyRU/e3ei+WaLMaHzYqtZUlwk8vA7d
         nPhxnrgCt7lVg0F+A48OTORQCTdEfArwMppS0KMQEjFRekQswO5Ou0xelZopXEB4SQZz
         Rr/Mu3K0mTkhh4L+TJTrCYOinOJOVfx+h4bY7pR5/H95DZc6CUEy6CXeLWdxDO/eiIal
         2gCw==
X-Gm-Message-State: AC+VfDwQFH3jAsrr0xvruzVjzHJ3KnJgDp/nWfZT1GAb+MNcJebvrcdR
        w/G9ssJhO7/zTW95V+H3ej8gd45UpsOuOIQNHaUavv2UsAhXAz2UBJy6T5bJGS0olACDzh8001e
        RF0uv8sHANPDbw/FWPh7waEzgSFPmWscfde2qejqXsQ==
X-Received: by 2002:a2e:90c5:0:b0:2af:23c0:ffe2 with SMTP id o5-20020a2e90c5000000b002af23c0ffe2mr1600560ljg.48.1686917799486;
        Fri, 16 Jun 2023 05:16:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A8o+IbZxCv/2DBlnwbGp11X9xuYSeDQtkg8plvKTfF7GfPMv6+pbOIWOLSRri7mw46WYb4w==
X-Received: by 2002:a2e:90c5:0:b0:2af:23c0:ffe2 with SMTP id o5-20020a2e90c5000000b002af23c0ffe2mr1600543ljg.48.1686917799207;
        Fri, 16 Jun 2023 05:16:39 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcc14000000b003f8044b3436sm2033492wmh.23.2023.06.16.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:16:38 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ogabbay@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, talcohen@habana.ai,
        osharabi@habana.ai, dliberman@habana.ai, dhirschfeld@habana.ai,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] habanalabs/gaudi: Add MODULE_FIRMWARE macros
Date:   Fri, 16 Jun 2023 14:16:37 +0200
Message-Id: <20230616121637.1033074-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add MODULE_FIRMWARE macros to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/accel/habanalabs/gaudi/gaudi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index a29aa8f7b6f3..cd034e98128a 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -63,6 +63,10 @@
 #define GAUDI_LINUX_FW_FILE	"habanalabs/gaudi/gaudi-fit.itb"
 #define GAUDI_TPC_FW_FILE	"habanalabs/gaudi/gaudi_tpc.bin"
 
+MODULE_FIRMWARE(GAUDI_BOOT_FIT_FILE);
+MODULE_FIRMWARE(GAUDI_LINUX_FW_FILE);
+MODULE_FIRMWARE(GAUDI_TPC_FW_FILE);
+
 #define GAUDI_DMA_POOL_BLK_SIZE		0x100 /* 256 bytes */
 
 #define GAUDI_RESET_TIMEOUT_MSEC	2000		/* 2000ms */
-- 
2.37.2

