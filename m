Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E119C5ECA00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiI0QuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiI0Qty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:49:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6A91F2CD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:49:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so2924841pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q45maTEqvwaKw6wMa3TQ/V03Aq+AX8mf2ZA+XEh0/b4=;
        b=gNzxdX3rWeFq+HU2sp8HpDRVrvMzGbiZq6L34nC3aV9Tvr2rkNJMbDr5Ma6UsRHlnt
         zanNcTC7FHdGsOEql/msaHAkRJDxjx4uNWCXLBYSsIt9fxUz1KddOcvNdpj0H0uYOKnM
         X81/tO3wZml/yvA7jo1OcimI4FNWDHslTkJsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q45maTEqvwaKw6wMa3TQ/V03Aq+AX8mf2ZA+XEh0/b4=;
        b=QkSsqPMEh+eJ/icZ7av4sowy+iHO7ua3OU6D/EISwFuBz6wQxGsuWYC3inmIntiJYW
         pxqvviljjpSqeSWn6dSR0zAuvDMYbPRmbFxr/6M2glv6x1zWRiXSm3FDcCFV2LM7tb7n
         PRtIC9MpbUkADZ1u3Kx7a0sGfznQtogOi4pJqDAVjrGRO77cyZBYIhXSFJXC4Cm2GUvo
         G3DM6sZMbM5xDN2xCNcOxZ87e2loEIx8TSl1ozppGLSmPiTLniFlMXsAfJy87t/h0YAF
         hXe0le+wxWebINdKz8rB1MlWDC284dNxZGEHbQWO1J2Zl+phtwDcKWm9YNdfhfL074lX
         naOg==
X-Gm-Message-State: ACrzQf0bPOQF3Ci3fRO8jkhGPDQB9Sa7lCFGW80mw51/ZXyDXIStDJED
        ihGhg/3vjBUJxdmfp/CtnkkdD3cSkXzecgr1iQQ=
X-Google-Smtp-Source: AMsMyM6ns+nmHvFOlkuorIDjzxLX2le/RrwK12l7D44L/hI74GkHltKAHaLUjb/MLAH/YcXpmbk0mQ==
X-Received: by 2002:a17:902:f7d3:b0:179:fae9:c14d with SMTP id h19-20020a170902f7d300b00179fae9c14dmr1459283plw.91.1664297386827;
        Tue, 27 Sep 2022 09:49:46 -0700 (PDT)
Received: from evgreen-glaptop.lan ([73.231.74.141])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b00434272fe870sm1753509pgd.88.2022.09.27.09.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:49:46 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dlunev@google.com, jarkko@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Ben Boeckel <me@benboeckel.net>, rjw@rjwysocki.net,
        corbet@lwn.net, linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v3 02/11] tpm: Export and rename tpm2_find_and_validate_cc()
Date:   Tue, 27 Sep 2022 09:49:13 -0700
Message-Id: <20220927094559.v3.2.I7bbedcf5efd3f1c72c32d6002faed086c5ed31c7@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220927164922.3383711-1-evgreen@chromium.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v3:
 - Split find_and_validate_cc() export to its own patch (Jarkko)
 - Rename tpm_find_and_validate_cc() to tpm2_find_and_validate_cc().

 drivers/char/tpm/tpm.h        | 3 +++
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 34e20b3192f833..9c9e5d75b37c78 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -232,6 +232,9 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
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
2.31.0

