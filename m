Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC846BA01C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCNTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCNTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:54:32 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264925949
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:54:11 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s7so1621638ilv.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678823650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ILXYxmnfOLR0ewM60G3euG3ql1j35ZPmWRlhkZCiP0=;
        b=b7+Z0objvds1+g+MvHWg73uKyRsDn7xQDsrO8N7y5nen+snWZz62/2DCKr+C0ayHlh
         P3qPei6OCXlzaWbzFO+MrlrP/pQ9gFRP0CCvwwwQyKWxfIavYHkST9viDLG/6R/bne43
         fBeyImX0Oa/I3zIUX1G3VttadI8Kjje6aXMZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ILXYxmnfOLR0ewM60G3euG3ql1j35ZPmWRlhkZCiP0=;
        b=vFyLSHpe3Qs6gUcj6Vl5paW6ZX2hmihf/mNn5FcduZaC08yhTgxL214er0rVDSalDp
         s8yhhDyShrkPAIejKy1kyKDNBujCz94CCmuAH7rouDZhURBS8bMNDDJLcPPSaNPYqhPY
         lpjG1LtLeTnL4PLcXrAU2PUU6CkfV+U5dU/RgjOiC3p52aDZb2D1FVfl6L8euTgyqDwU
         ftUdTqAA7IzkRTrPyiXrLSR1VYEAF2btkdktwsoISd+U0ymvYa1G0CyeQilZOXvgCybp
         NrXYimeq6TCL1MAe2T1HpXY002XVboYGv2k8+jtxfE1TyOj54r9cbpnS9iC0eMGM7ARo
         mjPw==
X-Gm-Message-State: AO0yUKVcNsU61drmP42h4jduF3aJ46zrsT5C3HB9JxXnaPHStb9pjGEH
        +U90vnT+RePVlXXCFCr7kNOwKQ==
X-Google-Smtp-Source: AK7set9u8J4nHcX/9iBm0CPgxbmxzUuW1WdTeigP4mZCYcQyLJQAQ77l+aELPl1OxKuxN3uk6qfJYQ==
X-Received: by 2002:a05:6e02:1c01:b0:323:ad6:5357 with SMTP id l1-20020a056e021c0100b003230ad65357mr3511492ilh.28.1678823650533;
        Tue, 14 Mar 2023 12:54:10 -0700 (PDT)
Received: from markhas1.corp.google.com ([2620:15c:183:204:da4a:3c9d:f298:5d61])
        by smtp.gmail.com with ESMTPSA id w2-20020a029682000000b00403b917f3a8sm1012718jai.56.2023.03.14.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:54:10 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: cr50: i2c: use jiffies to wait for tpm ready irq
Date:   Tue, 14 Mar 2023 13:54:04 -0600
Message-Id: <20230314135400.1.I5561dfbc4438418281626e43e345e8acc879cd7c@changeid>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When waiting for a tpm ready completion, the cr50 i2c driver incorrectly
assumes that the value of timeout_a is represented in milliseconds
instead of jiffies.

Remove the msecs_to_jiffies conversion.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 77cea5b31c6e4..376ae18a04ebb 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -100,8 +100,7 @@ static int tpm_cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
 	}
 
 	/* Wait for interrupt to indicate TPM is ready to respond */
-	if (!wait_for_completion_timeout(&priv->tpm_ready,
-					 msecs_to_jiffies(chip->timeout_a))) {
+	if (!wait_for_completion_timeout(&priv->tpm_ready, chip->timeout_a)) {
 		dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
 		return -ETIMEDOUT;
 	}
-- 
2.40.0.rc2.332.ga46443480c-goog

