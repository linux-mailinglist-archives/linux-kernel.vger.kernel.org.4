Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61871683D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjE3P6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjE3P6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:58:01 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3012D;
        Tue, 30 May 2023 08:57:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7748d634a70so331655639f.2;
        Tue, 30 May 2023 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462270; x=1688054270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3nhZu/SST6liTzw12jwyRWaA0HI9Rq5mjkfPZUDJJ0=;
        b=DBACDy960MdBUSi2MlfR3uIgS5rfyHfeBqYOQAko3egK2pkKXPOP4u71bmLzZjHsCr
         sTalg02v1PJQJzhXMQanHZ3diAPmwvEWa7HK0VMcA6apamDXdtuf8kFwoPP7BG7WrnVD
         jkz6c17mChq7dDeZVA0MR3w7u4aj/a3dMhjtag+qXUd1KSHjqbVqMiraq9w36iJhGBBP
         nHYMZuWF9MDUOF0tb76rGcvIlMCbz30W2fs76HuoqXnCi63ytdVfg51G4ybYCzo2vrQ9
         f+Gty/WgWz3LfyYTsYJZAyNdxywX/c6O2SMgIPHiG4F0yY+SL8Pp8YWBKhi9bT8qe2x0
         T7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462270; x=1688054270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3nhZu/SST6liTzw12jwyRWaA0HI9Rq5mjkfPZUDJJ0=;
        b=On6iRQEoH+V92lqMAj1vQYK8ypOUq1ZVFNYW4xazPrSZSZdvll7Zsl3DqovP9NWE8G
         oxJfvULmk0iwKC5D0SJ2X5Of3RZ+CXsQ65S2C4oyQEPxLWAj4TY9zo6J5gNVXq5i+D35
         UCvVWXchVkocbNnPtotrNsleCIqJ6fX5luLEHlTsppoc2oRL02c9JYKdvnyQo4li5Lu9
         XWkusQ+3a5Wlhz2x9zsiQt7jYuOFfY5JMpHwFOpa4qNmukuPxe2EsvvC8VopjhjMav5H
         ln2aPn1kFxuPNP5JScs7cD34W7cWYzgxpwvx3XTzEbL1Si+W1zPPHF4hw+Cj5HxoS3iz
         yyGg==
X-Gm-Message-State: AC+VfDxxqBC4QBHDdW7Yji2iI7tcobb1ipbBrmAymBpbdM6PhJm2ubpP
        jeE5xYprc9VQuJt0rvNBjK0=
X-Google-Smtp-Source: ACHHUZ7k6HhP0kdWImUTJu3N45pKv5Dy/HUTCEIcuL2SlRfI6/AzUh/f91cp4wiV4RLyhJVpd/MFKQ==
X-Received: by 2002:a05:6602:4204:b0:774:8210:3c6a with SMTP id cb4-20020a056602420400b0077482103c6amr1900354iob.11.1685462270164;
        Tue, 30 May 2023 08:57:50 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id y5-20020a6bd805000000b00774804141f1sm3431052iob.36.2023.05.30.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:57:49 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: lpfc: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 15:57:45 +0000
Message-ID: <20230530155745.343032-1-azeemshaikh38@gmail.com>
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
 drivers/scsi/lpfc/lpfc_hbadisc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 5ba3a9ad9501..239a6537b987 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4835,7 +4835,7 @@ lpfc_nlp_state_name(char *buffer, size_t size, int state)
 	};
 
 	if (state < NLP_STE_MAX_STATE && states[state])
-		strlcpy(buffer, states[state], size);
+		strscpy(buffer, states[state], size);
 	else
 		snprintf(buffer, size, "unknown (%d)", state);
 	return buffer;

