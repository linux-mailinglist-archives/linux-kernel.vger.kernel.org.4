Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0337D70C2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjEVPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjEVPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:53:55 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52523BB;
        Mon, 22 May 2023 08:53:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3318961b385so9999425ab.1;
        Mon, 22 May 2023 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770832; x=1687362832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qp7s6eO/AiGsCaE5OfeXuT9L6GmJOAFNtZ50/pn9Ms0=;
        b=JrLSlq4qpxv8uj+F8ZuAqFxqWGTX61pCjBbHzCPqT0cXJJ/+aFK9npAbkH6A0zI67F
         kvUfVgkLs6KZsAzZSfxA/9kxXQMoomeTQq5RogFzJLUjmYBORGzhCIWXJh38Ped0Qkbo
         B3lZwR7stSz4ujI9sN1eNv3A1o35X+hbXuCdYYxMnbZRPUFXXS4NA8uikjvSSr1e7q44
         efdDrGxw6yk+kJTD/Ef1555kvCLtygx1xDv2wG54k/qkYSgAaGQD/QdEPqazML7x6jAT
         AEn6XD97sMmTOqcOnf3NXwP06/FU2MJ+0k8JzRyJj4MZ+q7hce3Ri8DrPLuIMgRE2wzY
         NNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770832; x=1687362832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp7s6eO/AiGsCaE5OfeXuT9L6GmJOAFNtZ50/pn9Ms0=;
        b=GHfzvjNfL4feE//+99/lMV7i21pHd1vRe+Lhoasr/Jk7kXawKD0OnKBCVljLbjg+AU
         dCQiwetYh12tedO79rsAkdcH9Et+swKx66rpv83iOU7a+6SUQNciEONbbBknLvwD16h/
         6LfZ7khD/N+mQKxUOjzHetGaT52drZdK09kdApZj90WNL/s42w/ZcLuY7zH5nyNx+uHB
         1OSprEd/oztUfQ5rOyFfP3/UCluq80XKYzZgHng+6es+6y2tq/9bvd13xsdoS0lcmHe0
         y2B1120Vlagc1imPtvlREOAlVuHDFir+qrvlSaq3aJPnKYiKytHqTmg14uCf5hvo4XTB
         WgQA==
X-Gm-Message-State: AC+VfDz5IFkeTxz8lMifDkUITAel7sJP8ktkfcIdDlI6nU0cV4MMiX6P
        ch0Sov2yJDBsF75vNk2zzDE=
X-Google-Smtp-Source: ACHHUZ7aBJVz1KLJlwChQfgNPLVGLNp5UND/JIzA4bLkEOU4EweDrbrS5F+10LrjJ6X1nAYVpiIgUw==
X-Received: by 2002:a92:cec4:0:b0:332:b948:9097 with SMTP id z4-20020a92cec4000000b00332b9489097mr8154249ilq.4.1684770832620;
        Mon, 22 May 2023 08:53:52 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id d6-20020a92d786000000b003376eedd0c7sm1817889iln.45.2023.05.22.08.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:53:52 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:53:50 +0000
Message-ID: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index db5c9343a3d2..0918d80672bb 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1951,7 +1951,7 @@ static int tda998x_create(struct device *dev)
 	 * offset.
 	 */
 	memset(&cec_info, 0, sizeof(cec_info));
-	strlcpy(cec_info.type, "tda9950", sizeof(cec_info.type));
+	strscpy(cec_info.type, "tda9950", sizeof(cec_info.type));
 	cec_info.addr = priv->cec_addr;
 	cec_info.platform_data = &priv->cec_glue;
 	cec_info.irq = client->irq;

