Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D9716895
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjE3QD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjE3QDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:03:54 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB00138;
        Tue, 30 May 2023 09:03:27 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77496b0b345so114471939f.3;
        Tue, 30 May 2023 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462606; x=1688054606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEKIsEXdKLpGKZBlAIha7KqcLcJLHAXSdcsQ3sVyRjo=;
        b=ruvnPIeJ1Sq+jrkh0VDmLz424q5HNzgEmxgk33feRyuEEdkyqZ+B15gc5GhVbIBS3J
         7xxYzE3Yc0PBmckjUDV3k2eewrMrWIt1Vt1VmjScVhCpn4ihzQFp3LxW8iti0nuZjt9z
         tIssPGma5sSAlpR7byVRFuCnPADheGGDj0ZcdLPJYfz736MYjn1Wh7+ePd0bWtR08phK
         BF4//BN9FriLzaGr02CRWahmKO0H2HLcxdlV0Ux/WGgdmJtFNvndRB4rpVpKRog5nI2b
         Kmtk0vq5mP1kWlkFLtThfus6c2omy0vbfVebolDVuYnN8gSEn5NfUIy6eirXivms5UJw
         YMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462606; x=1688054606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEKIsEXdKLpGKZBlAIha7KqcLcJLHAXSdcsQ3sVyRjo=;
        b=TL7xTc2qWb/Z/sWJe/LfAunrNMlcZTL/bHUqp1PkdTKIXOIdzuRWILIdA4sIgSYB8z
         LLYUHr171GnfS4jgaUYbn0oqEt2+wFybn3Sv5oqj42HTJVTdldAvt/nRfoeF6SWegAjk
         9rF/Y1VWZgLD1PBQLIr2ZvqzUDCIwHvz6s23220hlXbNwHcheABMNYR4w8M9+dOAZaiC
         17Gz/ofiDxqxyVdU3PC8fA5RIQodbOFj4FHNwdzj6p+/+5v0U4LyykDhC1DyjREPq7HL
         yi8yENTvlBxKi3LbHe5tTpfKypEOYCD/PN5y5YBPiWcV0bEWqS1DjBs8zzcJ5UHmuwxR
         91/g==
X-Gm-Message-State: AC+VfDzQfgVwGAj6qKhGSKjkunlgYowK8+IrHQC3VaEXOtVgD1D+Lcqc
        Dl+RogBGe2hNTPq5SVqZg3vC151u8Hq67g==
X-Google-Smtp-Source: ACHHUZ56E7vZFVGPKgd7I4fikcApbkWq3RIs9RFtkKtKKI4VmN5p6MbyDE4tMarLqBpL/2gdUJnHJA==
X-Received: by 2002:a92:d4c4:0:b0:335:5b3b:82 with SMTP id o4-20020a92d4c4000000b003355b3b0082mr1722420ilm.26.1685462606607;
        Tue, 30 May 2023 09:03:26 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id ay20-20020a056638411400b004141ce991aesm783054jab.179.2023.05.30.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:03:26 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: sym53c8xx: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:03:23 +0000
Message-ID: <20230530160323.412484-1-azeemshaikh38@gmail.com>
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
 drivers/scsi/sym53c8xx_2/sym_glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index ee36a9c15d9c..17491ba10439 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -1286,7 +1286,7 @@ static struct Scsi_Host *sym_attach(const struct scsi_host_template *tpnt, int u
 	/*
 	 *  Edit its name.
 	 */
-	strlcpy(np->s.chip_name, dev->chip.name, sizeof(np->s.chip_name));
+	strscpy(np->s.chip_name, dev->chip.name, sizeof(np->s.chip_name));
 	sprintf(np->s.inst_name, "sym%d", np->s.unit);
 
 	if ((SYM_CONF_DMA_ADDRESSING_MODE > 0) && (np->features & FE_DAC) &&

