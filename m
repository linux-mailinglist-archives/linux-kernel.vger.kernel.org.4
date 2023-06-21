Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AD737970
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjFUDBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFUDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:01:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B25199A;
        Tue, 20 Jun 2023 20:01:12 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3420b22365fso26443895ab.1;
        Tue, 20 Jun 2023 20:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687316472; x=1689908472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ymvo1yb6hBMOYst3q5f6+Qj67WzRYCMDxb+OaKy61M=;
        b=fviI+sflWeNoKMpAzsUSp+vaO2FvMfkSnBJ4p7z6kSa7Yl18CQQxgO4BSJOsX6oX0i
         VKR3QZGMQ7MRnUJ6z+aDI3MXofS8Q7I3BXSimp69sEZ3HoCAta6cUnx+4yD4DNAD3a9M
         3/P136W2TDKEI4hyhlDsAdVXmT47KmvlbZVJlhn84dHx5EA4T+kX5Enk0Y8ZjwIQgSni
         s3hKbT3MG2V7NAy+2wxq29kZwVKrDaAQHs15SG8mxA8VwY7mGeSgxAAlCAGv5ivDqQL8
         9j3dWjOve7XGIcMWh7EbXCDd/OYew/yTbX7IUJgQmG7tboorii3WvtOJ9GRFPYup0MTk
         TPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687316472; x=1689908472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ymvo1yb6hBMOYst3q5f6+Qj67WzRYCMDxb+OaKy61M=;
        b=NUgDG/Y9P30ZeqgKPR1zEIQmPdCF+6S/Lk6uY88c1q2G+Erk+/aaBsVGgkrp25XSqz
         rGUUkXpJeC2GlSvGnfgJBRAhYxzAOTGOlxAwdosqaSxM0yBAbuGu+ZED78ZI2xihFoQr
         XW1Z18/kpJrBwqqz3OeoymkKfO/276vLn/F9ORqBlssXaWxh/zdtU77GfIWQMpO8Y92m
         JFfyF61WQtzhe5ddSIF+t577B2NqscBreU2/9UyVcNi06ElB5KGpLzdh8qxlXCHs+0De
         Nnk22HV6xYA9pCx8h+IlWBd2FVQKwvHT71bpQmTxbavfgnsIt0Sp713wY84RG51pvOtc
         PPFA==
X-Gm-Message-State: AC+VfDyJvWuQ+ATwag+UIRGLNXVzFSlnIspTGhX/xr3sYVbNJxZva5o8
        6eDEqXlx3v9aQxjG9pmyZ/A=
X-Google-Smtp-Source: ACHHUZ5ketWPs0ojDilB4XOdWLwA7W6OoZTreZL4pnCosRTIm3zavncQabT1d7KNdfFI2FRCZnmrAw==
X-Received: by 2002:a92:d905:0:b0:331:4f70:a2b with SMTP id s5-20020a92d905000000b003314f700a2bmr11631651iln.5.1687316471819;
        Tue, 20 Jun 2023 20:01:11 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id x6-20020a029706000000b0042682dd951dsm1035008jai.87.2023.06.20.20.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 20:01:11 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: target: tcmu: Replace strlcpy with strscpy
Date:   Wed, 21 Jun 2023 03:00:33 +0000
Message-ID: <20230621030033.3800351-3-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
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
 drivers/target/target_core_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 15ffc8d2ac7b..22cc6cac0ba2 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -2820,14 +2820,14 @@ static ssize_t tcmu_dev_config_store(struct config_item *item, const char *page,
 			pr_err("Unable to reconfigure device\n");
 			return ret;
 		}
-		strlcpy(udev->dev_config, page, TCMU_CONFIG_LEN);
+		strscpy(udev->dev_config, page, TCMU_CONFIG_LEN);
 
 		ret = tcmu_update_uio_info(udev);
 		if (ret)
 			return ret;
 		return count;
 	}
-	strlcpy(udev->dev_config, page, TCMU_CONFIG_LEN);
+	strscpy(udev->dev_config, page, TCMU_CONFIG_LEN);
 
 	return count;
 }
-- 
2.41.0.162.gfafddb0af9-goog

