Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0F6186E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKCSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKCSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:04:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2E23392
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:01:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b11so2403798pjp.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfQ8/CAL4S026DtWAnZscysHYhGEE1wVieDh82Tdr08=;
        b=I18iC2yKrg6+LAoc5oeMqbZb2+EuFmwElNbhB+mUlPs0W89QCjCZPKV2w4PrgavOFa
         kFnCeYud6UfFP8OvHBqunAtTVF/rbF13qqrG9H3qMTi1Ygmz7MlR/y2vna8amHhP4LOY
         rbOH9iNj9wvWvP8Uegka7N+SJm0ekA0q8PY+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfQ8/CAL4S026DtWAnZscysHYhGEE1wVieDh82Tdr08=;
        b=jULVamKATN6Kdtp4dLpdZ9cczacAa/y6yCkS77DJ7Cmbjpnt2rOJEf2HwAYv22a11f
         aJqIcKNlEYLlk7JgCzTOVrS/nJLTlz6YKDcwTz9CItUfFCmq6F4KrkYJO1lDsoqlxid1
         qi8n5w2O6Q0fo8FNQjzJj6yHqitOq2pDCMF7P+EvCEPguI1vg0vjHBMth0hlzgQLIHsb
         Z/CBl5g1mNidXtKpUX+zinmZ9ezwkhQf4JjxP+R8T/oxhrjwHBRVPBQb26c6U6gjeG2v
         sTTX5dMIFvgDSECiXJWN2H7EdTgYo964h39ADqPoWSNDJWnMs8Stnkn8A67KgCed1BM7
         i8IQ==
X-Gm-Message-State: ACrzQf0PB2BVchOkOPflvAbiXI4BXB0+5Ynzw/qo3sJbZcOkLYCg+xNA
        9IaJRIKe/vp52GU6R1cVoXtZZhtt833h7TLG
X-Google-Smtp-Source: AMsMyM4xq4UAu0O7V+ZZtlC479QmsjfT8xWTYxEDk8MFu2zZxJDctc12i9fXITGj7vI9jGerYFNLzQ==
X-Received: by 2002:a17:90a:f484:b0:213:d200:e956 with SMTP id bx4-20020a17090af48400b00213d200e956mr25810351pjb.40.1667498500047;
        Thu, 03 Nov 2022 11:01:40 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:39 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        gwendal@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Evan Green <evgreen@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v4 02/11] tpm: Export and rename tpm2_find_and_validate_cc()
Date:   Thu,  3 Nov 2022 11:01:10 -0700
Message-Id: <20221103105558.v4.2.I7bbedcf5efd3f1c72c32d6002faed086c5ed31c7@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103180120.752659-1-evgreen@chromium.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export tpm_find_and_validate_cc() since it will be needed by an upcoming
change allowing access to certain PCRs to be restricted to the kernel.
In order to export it consistently, and because it's a tpm2-only
function, rename it to tpm2_find_and_validate_cc().

Signed-off-by: Evan Green <evgreen@chromium.org>

---

(no changes since v3)

Changes in v3:
 - Split find_and_validate_cc() export to its own patch (Jarkko)
 - Rename tpm_find_and_validate_cc() to tpm2_find_and_validate_cc().

 drivers/char/tpm/tpm.h        | 3 +++
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 24ee4e1cc452a0..f1e0f490176f01 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -231,6 +231,9 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
 void tpm2_flush_space(struct tpm_chip *chip);
+int tpm2_find_and_validate_cc(struct tpm_chip *chip,
+			      struct tpm_space *space,
+			      const void *cmd, size_t len);
 int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
 		       size_t cmdsiz);
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index ffb35f0154c16c..ca34cc006e7f8d 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -262,9 +262,9 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
 	return 0;
 }
 
-static int tpm_find_and_validate_cc(struct tpm_chip *chip,
-				    struct tpm_space *space,
-				    const void *cmd, size_t len)
+int tpm2_find_and_validate_cc(struct tpm_chip *chip,
+			      struct tpm_space *space,
+			      const void *cmd, size_t len)
 {
 	const struct tpm_header *header = (const void *)cmd;
 	int i;
@@ -306,7 +306,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
 	if (!space)
 		return 0;
 
-	cc = tpm_find_and_validate_cc(chip, space, cmd, cmdsiz);
+	cc = tpm2_find_and_validate_cc(chip, space, cmd, cmdsiz);
 	if (cc < 0)
 		return cc;
 
-- 
2.38.1.431.g37b22c650d-goog

