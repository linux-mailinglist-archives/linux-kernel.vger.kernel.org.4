Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B7C64C5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbiLNJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbiLNJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:27:39 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD75B68;
        Wed, 14 Dec 2022 01:27:37 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c13so4024316pfp.5;
        Wed, 14 Dec 2022 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLpWFlG8mxCCWcewzRCKKTz15AMme8ZuJhE5IEg3io0=;
        b=NdoF3cNFvXv/M3+aBr6oTDL01XCH53BB6efW2D9TwDjttKAN2fqd9wCLBFKRra84A8
         076QSS5+5Xkj5xaxUarsRhRtVHABJncmznu2U7yewp0pYZlUZljVPRUnxYZnI6obuK3g
         ZCmexl3Z6dHEpdO9/o2XmBrO1JyHtwYi1Kh+ME7XqmY3qLukNNze0iwxNHOe9zMA2aqD
         gJlKq61sDR2PXffsV7tFOZT+2RsbzxzPJ3D+3SCpmmCwiWDIvdX29VXXCga/Z+ChheUE
         utTXUnbbIBPjlGonsBnxjcK5k+7DMC6OiMEmJedwF2A4GDcJt2t6dIVf1WuxDE/17eAC
         ygDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLpWFlG8mxCCWcewzRCKKTz15AMme8ZuJhE5IEg3io0=;
        b=F5j09nHWltcdykcOFLwq8fA3Ts5DQdVwK7DZAgv6//fka4UluAqJbTzkw6T9NQwyd8
         Oks5ZCIYEs62h1CtvE+/sHBI+SPv5bGr59oNFUM+mDD2myhh9MT5FAlMkbyxO6eE7wg/
         tTaGLyEYFULbKHUS/TVpRNKecJn6bpZQ/ZCg4laCrcvO3F/5zuslqQN2FMUsBtiO31IG
         5YUwZRNs7DR1RVlbiO2getorNBVgfuOkfmpYAizM5cSLQWSENCTbNg9Z5Q/zZBf9LdCq
         n/gQ/ADyhpC9UICP4SS8jWw4/UZmeFBgl83PIxHXCtYVupQnbDqtW4cz7AqL9/vnVXAS
         WKyA==
X-Gm-Message-State: ANoB5plEUVYlqCiPKhiJs59Y7cZIaDEKqdFnr/MBgt5WshiIKqyWcwT3
        pbEw6aJ1xQvDvLq8JM8S27Q=
X-Google-Smtp-Source: AA0mqf4Ng4hlbOW8z0BGWKEyNXler717YQ1Fdr8pfObDXmNg3crKRtCmJj3s5c5PMKDUy7jCnC7gqA==
X-Received: by 2002:aa7:9297:0:b0:573:f869:2115 with SMTP id j23-20020aa79297000000b00573f8692115mr21004739pfa.9.1671010057016;
        Wed, 14 Dec 2022 01:27:37 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t123-20020a628181000000b00576145a9bd0sm9003312pfd.127.2022.12.14.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:27:36 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v8 5/7] media: v4l2-ctrls: Reserve user control base for NPCM video controls
Date:   Wed, 14 Dec 2022 17:26:34 +0800
Message-Id: <20221214092636.810883-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214092636.810883-1-milkfafa@gmail.com>
References: <20221214092636.810883-1-milkfafa@gmail.com>
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

Add a control base and reserve 16 controls for Nuvoton NPCM video
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b73a8ba7df6c..aa5c9f64f1d6 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -199,6 +199,12 @@ enum v4l2_colorfx {
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

