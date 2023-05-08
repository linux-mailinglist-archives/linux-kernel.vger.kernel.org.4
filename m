Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922CC6FB402
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjEHPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjEHPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:42:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE198A50
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:42:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f139de8cefso28536558e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683560556; x=1686152556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvH2mgmfNa1pox3nAUFcfk/E0s6xFf24zLPU7zpEAl4=;
        b=yVO1gn84v4If9WbSGTbrE0WAh8Y3QA2Pn1vmt8p7a+m9QCSVC/rYjwy2olmSS5tFWY
         RZSALy3XG+nEIUNnyoHY9H5O8Wh2xMV9oq5nXGLAA+GMRNs7gNzn5BrNDL42NtqfHv5O
         w8oxhNf5TOyPjUVar1x+h8g2hWaJgrG2mLgUo7/da2kNvbZSmxduiKXU/qa+EnW1oBNY
         hw6Ld6xI5UYE4E+l5SiuaD1ShjqDiJNRKAKL7FRTwKSVf5HAelko6qzxIwxgh0kNHGXl
         HQzgG5Ope7n9Z0Bal3es8WB90kjrwH0PgP4L8t3W6qjKJABj6Eq1rxnFFWmQxSAGDYrT
         0FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560556; x=1686152556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvH2mgmfNa1pox3nAUFcfk/E0s6xFf24zLPU7zpEAl4=;
        b=DdvDYdxApJfNfUdROfWFJY9xPXFdT4g4lA3bhIBhEgLEyaBgyzn54XBvJb7RmciRoo
         KeykFpym8svAadUafzz7F98hJ+Anm1/u678jTPcdIPqOoY+eCzbcF5CnsS6zHEqxeKfy
         puruUpYiNAMFcEWvAYZmwKCOETJHPXTcvvKDAlOKXS9AetsTh3EoP/fxLa3KewZBv3Xi
         +EwqJ2orXBVUrDvIjWeUMePPkSLe9TYp4N8EBJ4Uz4092xT5BlvMbLQRSxQg+/s8Tboe
         sUy3kDrGKOEdQvSCtZpXV5wGlvAy5BJrinZtZwQZr98aFsewNflit7mM5wo0hWh6MAyn
         Yo9w==
X-Gm-Message-State: AC+VfDxN2pIvLxziIgQDO+oiJAgZsUFJH6XnO8deF0pdNuQqGMK3YlXV
        Nih8jHKmkAwZt+sTv8wQHZOxxw==
X-Google-Smtp-Source: ACHHUZ6OtgtKNp6dHBAWQTcAg5cvYFVzzFhQ/VRY0x4wCgSmv8Cl0dj9UL5It5ZnUPYZu+kgn9Uq+Q==
X-Received: by 2002:a2e:b63a:0:b0:2ac:75fa:eef0 with SMTP id s26-20020a2eb63a000000b002ac75faeef0mr2926926ljn.7.1683560556718;
        Mon, 08 May 2023 08:42:36 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e9815000000b002ad9b741959sm17720ljj.76.2023.05.08.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:42:36 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v2 1/5] ext4: ioctl: Add missing linux/string.h header
Date:   Mon,  8 May 2023 15:42:26 +0000
Message-ID: <20230508154230.159654-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508154230.159654-1-tudor.ambarus@linaro.org>
References: <20230508154230.159654-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ext4/ioctl.c uses strnlen(), strncpy(), memchr_inv() that are defined
in linux/string.h, but those were being included by sheer luck, indirectly,
via <linux/uuid.h> which includes <linux/string.h>. Add missing header.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f9a430152063..6d5210b94ac2 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/iversion.h>
 #include <linux/fileattr.h>
+#include <linux/string.h>
 #include <linux/uuid.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
-- 
2.40.1.521.gf1e218fcd8-goog

