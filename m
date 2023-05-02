Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA16F3F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjEBIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjEBIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:45:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13278526B;
        Tue,  2 May 2023 01:45:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b62d2f729so2651273b3a.1;
        Tue, 02 May 2023 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683017104; x=1685609104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJTkCoWmCbMtHWUFBdWByh/qbNj1+660uOBQdn+P8iE=;
        b=WMsQrSWfdIDHG5GT83wqCYp1SIlvdJ1jugJs99R2rCBZ3KSE9tIjCyXdXeXgwwEVBT
         PDfP9R/fp7KTS1feDOAv5EogFWy4oBrwsFsai0IMlv+/OHPJYkjsmN+KhOWGnQVcZSl8
         rO//3TbuB69ovYGxJQ2k93UkgXzWLl5BlyNB5eR1NJBr9BIOLdRKZI3GihgN6AfwSPX2
         mRu8zi0RCZYz0kt+7A1c6DGKB1omolPmE9tfYzDfLZ73MMN+2aWYnmds3cvePr+9KRzI
         tZfyzS1vpFmPVtRk6ytJybSzYMla1b6fUjfZqNBmNO1r7R1teQQtmIHf3+/OEFJJBUIF
         +AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683017104; x=1685609104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJTkCoWmCbMtHWUFBdWByh/qbNj1+660uOBQdn+P8iE=;
        b=d9rqbCwXPwyAlmaxmQKEG70G9oRdveOilg3avnylKRibW5GbY9D7YSV5m59GFlLJie
         HKjXJKyqVCptSKEwdstKpnGr37xIEImb/MltptO1kp7pJ29Ucmw6Fp/ROYJ0RcT3hP6v
         fPd24A+gaVGb18Cp2J5VDK+i5nTzkcNtF/yzd7BSB48MiaX8U3htPABFomPu48oUPaCp
         Y0X7ES9pdUtQ6oVjzKHcambkyqnyBmJF9gDIQC3R7zPtV5DMzs9e2A8NbVFSkuiT6k4g
         lzYxwQG66d6/LgyJ7M+kY4JGk18PNAU0euLXCjVedqvou0yJHPxqMTPfySejbwWF7U0l
         n+wA==
X-Gm-Message-State: AC+VfDyBMIky+jqzot8ZD+6kl6k9QLEix0GLWxng6GCnhYQBjPF+Xp17
        xmjMj9kUnvr0Nqxmp8AYnqE=
X-Google-Smtp-Source: ACHHUZ6yS1veqvlhL0A4B/EOJ7hwQuu71Hi+5QNofB5Zx/eN+ESCf+6IsczFIzdCUxQFduyPspqniQ==
X-Received: by 2002:a05:6a21:6d84:b0:d6:80a4:f0b6 with SMTP id wl4-20020a056a216d8400b000d680a4f0b6mr21779423pzb.6.1683017104177;
        Tue, 02 May 2023 01:45:04 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a520a00b0023fcece8067sm7059039pjh.2.2023.05.02.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 01:45:03 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v12 5/7] media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
Date:   Tue,  2 May 2023 16:44:28 +0800
Message-Id: <20230502084430.234182-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502084430.234182-1-milkfafa@gmail.com>
References: <20230502084430.234182-1-milkfafa@gmail.com>
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

Add a control base for Nuvoton NPCM driver controls, and reserve 16
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5e80daa4ffe0..19d2651249fa 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -203,6 +203,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

