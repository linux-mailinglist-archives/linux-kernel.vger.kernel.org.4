Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F857469DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGDGo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGDGor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:44:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF810D4;
        Mon,  3 Jul 2023 23:44:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6682909acadso2534102b3a.3;
        Mon, 03 Jul 2023 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688453081; x=1691045081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJTkCoWmCbMtHWUFBdWByh/qbNj1+660uOBQdn+P8iE=;
        b=Uk58Xeg4W4VsC9fg1JBjTHNdn8GFx2Q982tAp12nRkQrIjSTOG/Fb8VUMV7CziTpIQ
         MHsozBo8E2pOnVOeZSxxDqRW6BdL4621WOPuUG+aEZcbxnuTVoUd002zeiunu7ugauJj
         bLRTj0lrOAaPbI67c+ItPhrQjxKLodSufIo9K1ntFjyZcXJIyNFKRQjk1E4T/ZhuVBFM
         /oDJLcjZOrG7QlvgHpDt9U/Eq3UjyMQcAv5gvmZGcHayF81ZkJYmjCyXO1mVS0KeBPJk
         s7Sq348OiEqp86HB7u11+h4Qf+aT57tznPWysKyDda32MxeZBQXznwkMM3iKwFm7MKEw
         5ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453081; x=1691045081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJTkCoWmCbMtHWUFBdWByh/qbNj1+660uOBQdn+P8iE=;
        b=CzGoEy1QikCvwD/iTxxYfaFKicczSAYoXg6I1DWBmU/8wRKZv1OVqvyXEUg4qpw543
         1PrCKjaObnT3A/6DnB7urptXtGOV8DYaPmLX2QyezbTkC+Kj//aytBanaL5uw7CEH6wz
         rr7DEszRs9Za6rjI4wXOgxkctgtryilsJcBb5A0sld+2hPK2Iax4yWFPNxJXNCe/Qqbr
         eh8XNKJgHx8nSb6NwVtLXlrESzVpE7ydu1/TXc9DLyrVf9T0el1ppZefrNdbcMZzMEa0
         LtE3K3lvl9GqDcjsKED6/QUtXQFXBqNKvmpIQBboMrE+KR8pG6TsCX5zu3/IQcy1PecM
         XL1g==
X-Gm-Message-State: ABy/qLaZBqUYOnU1F9dSO/QA7jsoULVfiFxmjkY1UltjPc/fOF9F4hZ7
        HWqXSvRpW5uEGuTMzl9m8Mo=
X-Google-Smtp-Source: APBJJlFQQuqe8XxyD0X1T0vHtHrvuQj7uK+jeVXFB/3LONnxxeEmErBv7/6mJZUi+mNZoJV1HAhoNg==
X-Received: by 2002:a05:6a00:2e22:b0:66e:fd84:c96d with SMTP id fc34-20020a056a002e2200b0066efd84c96dmr12862841pfb.13.1688453081022;
        Mon, 03 Jul 2023 23:44:41 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78382000000b00668652b020bsm14863429pfm.105.2023.07.03.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:44:40 -0700 (PDT)
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
Subject: [PATCH v13 5/7] media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
Date:   Tue,  4 Jul 2023 14:44:10 +0800
Message-Id: <20230704064412.2145181-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704064412.2145181-1-milkfafa@gmail.com>
References: <20230704064412.2145181-1-milkfafa@gmail.com>
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

