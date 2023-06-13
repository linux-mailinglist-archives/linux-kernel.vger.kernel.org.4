Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B947F72E777
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjFMPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjFMPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:40:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BDE19BC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:39:47 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AFA763F26E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686670784;
        bh=h2VB2F1nqgPgNlWNC2nzeOkEx2tuyJu/3uifBQZUmKY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Px1GsJBpr91+X+7dRDPpYZOSu31kCRXMwUv1yRwhk0LSTw+MnXf3q/0x6j5EMI2Hl
         PKhNnljqQhYp64fIh0dsOaaY2ENyUvAjU7T/pbozQOHlqO7vUwc7DIwd5njsqZDh5q
         gxeDlAQPCeEDnq4BfAiNQ4T+ncUVs81YYlWVfvw+Twtlds7tDgHDjh61gqXKpYf+c5
         SXXGXV8/A+9494aMHL99ZVyGs6CNtDEOn6tNz1alFrVdeZ8ECan4kcqwbDO/vIisgG
         Mhk4uB9L3HF8h6ByoEMnRXR7/XW4ZiHkTN9JE7KOifUmN1E6ZI2v2cyyC1OHc+rYTg
         N8U9/Oov+xVwQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e3d670c4aso3309719f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670783; x=1689262783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2VB2F1nqgPgNlWNC2nzeOkEx2tuyJu/3uifBQZUmKY=;
        b=Ui6CDyJ4v+qrrs4iajNugDSl7rEc0+A1cdZSiJaIDSCZEWbYRasTdb99qP8t9BCPTw
         rCHTzCG3f3tgEWi0eD34NEMM5qByqtCuy+2S8Zg8IB+LhLYrrjdwTxjG8dm9FdnP76fw
         YeoZUyXX3p8bLhZeoZ5Ry8i8areLhg6MsRbfS9ZwI3buvLmI39vo+o6ySWwjHUwO/kuZ
         DO7WTRLssW3dGTKsXGnWWX5tpYZGziUa0u+MUAo1ScWyYFpLYMrYFX/TLwjzyr9VwO+s
         RuY+fyBCoS5W7M722ILU+b2aXR2ZBm8pAoTFZhsvSZ6M/FkAKTGnDQD2AK832bmEyPST
         vrNA==
X-Gm-Message-State: AC+VfDwxli/uGyW9ycV4+b3DKy/CGo8iystKUpkjdt3XDDGoCTzE0joj
        d0w1E6j/pfK/LNSCDho4ftAtcj4tpO5vuu214zCgXpDmL181kzxs/lw1hZl6dt0w9S8ALM1AaTn
        9pc2PV7gNmIGHkrebFCvNdsiT+ZgGZUXyWwSYZwu6QA==
X-Received: by 2002:a05:6000:1248:b0:2f8:3225:2bc2 with SMTP id j8-20020a056000124800b002f832252bc2mr6846723wrx.41.1686670783782;
        Tue, 13 Jun 2023 08:39:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7u6y5BjGv0z8bT/LB9RrsvWeO5qrDCAe7zl2OSeRDtbWoTqJ0KQBMBeO8sS2CFGRWa+dBvvw==
X-Received: by 2002:a05:6000:1248:b0:2f8:3225:2bc2 with SMTP id j8-20020a056000124800b002f832252bc2mr6846717wrx.41.1686670783535;
        Tue, 13 Jun 2023 08:39:43 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0030aedb8156esm15556257wrr.102.2023.06.13.08.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:39:43 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     gregkh@linuxfoundation.org, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, martin.blumenstingl@googlemail.com,
        mchehab@kernel.org, narmstrong@baylibre.com,
        linux-media@vger.kernel.org
Subject: [PATCH v2 resend 2] media: meson: vdec: Add MODULE_FIRMWARE macro
Date:   Tue, 13 Jun 2023 17:39:39 +0200
Message-Id: <20230613153939.152457-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230126153258.1558471-1-juerg.haefliger@canonical.com>
References: <20230126153258.1558471-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson-vdec module loads firmware so add MODULE_FIRMWARE macros to
provide that information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

---
v2 resend 2:
  - cc linux-media@vger.kernel.org
v2:
  - Drop duplicates
  - Add Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/staging/media/meson/vdec/vdec_platform.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/staging/media/meson/vdec/vdec_platform.c
index 88c9d72e1c83..70c9fd7c8bc5 100644
--- a/drivers/staging/media/meson/vdec/vdec_platform.c
+++ b/drivers/staging/media/meson/vdec/vdec_platform.c
@@ -280,3 +280,12 @@ const struct vdec_platform vdec_platform_sm1 = {
 	.num_formats = ARRAY_SIZE(vdec_formats_sm1),
 	.revision = VDEC_REVISION_SM1,
 };
+
+MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
+MODULE_FIRMWARE("meson/vdec/g12a_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxbb_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxm_h264.bin");
+MODULE_FIRMWARE("meson/vdec/sm1_vp9_mmu.bin");
-- 
2.37.2

