Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23C7716863
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjE3QAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjE3QAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:00:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614FBB2;
        Tue, 30 May 2023 09:00:37 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c5db6a5cfso337535239f.2;
        Tue, 30 May 2023 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462436; x=1688054436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zX10SJBU8S1HDBYkbi8trIiB7376uD4rHt1agT0RgVE=;
        b=T6kwuwNOMP7SpNBuj9ulB7wtBDWLgkSuq5HTmKEa5CuYtWLEVwQNJmgxnv+xiuEE0B
         2rku+K4GXdjh+DlwdYc8eirLyEiOPsBAMctGxjT5iHZ04TBMqoKZjNUbSVqLgXtgU/AY
         uIqH6Hz+yPtRarj8PvB6p42hNDUXz2yC3EjsLUjbFZlQKnzw5G7613CyK0oimxB+Llxh
         gVYjawUUecbgmkn74c7SvBAIw6y3w9a25jdxXF4uoJoPSCqI7Mj6TPZObK+XUgqIakYx
         iW8JW9dLDsdAdykEY7ARdusn6bbkgDwmmjvAaoiVj6JqvddlunlIU3PhGJ1THnj1/4bu
         f2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462436; x=1688054436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zX10SJBU8S1HDBYkbi8trIiB7376uD4rHt1agT0RgVE=;
        b=BRK+8AgZGV8F6GJAJDb1+Jw3xjlnnLslzv/ovnICluCUdiju9gZYA3Tl6xoF79rgUZ
         C5AFDApD30DRN45CYjgNyTkDlEUjE1CE+CYz5m7kp6se6Fvv331SHQsXm2fTE0dgTskn
         jydaBUJ4zFsyhFpTNChcxaALyGv9W3t0T5NNZt6a3R5RTrlgFyqgRfENCJUNOGnupnK6
         DTXHa6nC6oforkiaxg4/PK2LlmNUemqFogOCtxKWN7yG8SCr7dOOkRhRdgqf92h8hdus
         MGCfB5VmuEFvhoFIHo0NSYapTae4HuHcxZFhy6gqfg7YPYbG+6yWbAoXyvQf1Dm5i23t
         VJXw==
X-Gm-Message-State: AC+VfDyV+315VdJc98DhnG3XSaLFd0NGoQfEtdU8PfISHMTbSzAfe1ea
        oP+/fxDcKDVdcQsq6sgHibs=
X-Google-Smtp-Source: ACHHUZ4Y7vaByrfhYL39lnBvPFfAEKvFNbSJFnHyf/l553ue3parkMv7sOH7zAptCsOe6CzI2RFFWQ==
X-Received: by 2002:a5e:8914:0:b0:73a:6c7f:c476 with SMTP id k20-20020a5e8914000000b0073a6c7fc476mr2352086ioj.16.1685462436590;
        Tue, 30 May 2023 09:00:36 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id q22-20020a5ea616000000b007767a221ea0sm3238153ioi.11.2023.05.30.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:00:36 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:00:33 +0000
Message-ID: <20230530160033.411441-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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
 drivers/soc/fsl/qe/qe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index b3c226eb5292..58746e570d14 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -524,7 +524,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	 * saved microcode information and put in the new.
 	 */
 	memset(&qe_firmware_info, 0, sizeof(qe_firmware_info));
-	strlcpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_info.id));
+	strscpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_info.id));
 	qe_firmware_info.extended_modes = be64_to_cpu(firmware->extended_modes);
 	memcpy(qe_firmware_info.vtraps, firmware->vtraps,
 		sizeof(firmware->vtraps));
@@ -599,7 +599,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	/* Copy the data into qe_firmware_info*/
 	sprop = of_get_property(fw, "id", NULL);
 	if (sprop)
-		strlcpy(qe_firmware_info.id, sprop,
+		strscpy(qe_firmware_info.id, sprop,
 			sizeof(qe_firmware_info.id));
 
 	of_property_read_u64(fw, "extended-modes",

