Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA150706E08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjEQQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjEQQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:23:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E22D5D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:23:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561c11762b7so13727277b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684340606; x=1686932606;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vaL/27odEK7tkDU5POuT7lbmrJSszQaButEBuwvYdNs=;
        b=YM35Pq5w3m4rYqdaMXFs+/GWwuhGPQWA0RSX3P0xUHWar2Y1X5aegbFNXZl8TnbZBJ
         O3r7m4e6nmTsVmFnXtMlgtmBZmSnDe+SrFw0gH42IliVQGc1bzvNuSJjsewHu8pmqZk0
         2rCAY+wniFVG81jcwnkAdiPrEkyYTexQIagI8GmwqlMJjr1TrKNjXB3urpH+a5SQm79d
         X/yrrNBhifYtNzj7G+e8VkC7h6+Y8EBXg7YX6yizfQi8eTLJ77nph+a2x0PvLgfN1Omx
         ht+eb9QdBjRIEmQIcPRRhBlkS8Qc77k/TkwPMUn30EZrwaf9E56mpl7XIkDLUfuHLfuU
         57BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340606; x=1686932606;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaL/27odEK7tkDU5POuT7lbmrJSszQaButEBuwvYdNs=;
        b=gQ2pyX0AE3WEWFGXIUHd9od3GJUdAQ+3H1kBIvbJyk9mGObR4UNqMw5wYHBkd30e9Q
         Hh77IScjXk5Y/ZgtxBPGMtnnQIUler5BzF4huW1gn2wg4vtSNsNvmX//KVL7suuzyBCm
         CSA+Ff00KdKiRWntxyGrFJOAA3H5JIxkD2etszaHmCitblsOcs646ExRqM0VDu52zewO
         QoDdR1NDWHrFqy3m7XkeqexwuZWevdBCJnoEW2p0V+no/1keyf6nrfWFL3b3aNYGi9Yn
         Zc7N+rfZfI+nrRoRgpyC+Oppz+NTAwUVo2nWO7LhzSZ5ewp1Z7Fi5otnd2JSa2CL3Nc0
         xKAw==
X-Gm-Message-State: AC+VfDxuSOvhBmzR9UAQPlwqFKot+guX0rsPVoKpKgzQE2ReAh9s8FLA
        LDfvHLAcrsmBYrHRwe9x7JJJF543BIGIoj04ygY=
X-Google-Smtp-Source: ACHHUZ6NdaI40kXvf1BU50rHPPWhX+ejuYobBk9x0TQGd0uQUROoFot1PPQi07jDl5Fp80ZnPz9vZb46mziw//SlL5k=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:a482:1a11:bbfc:3af4])
 (user=ndesaulniers job=sendgmr) by 2002:a81:b209:0:b0:55d:955b:360 with SMTP
 id q9-20020a81b209000000b0055d955b0360mr23798404ywh.5.1684340605834; Wed, 17
 May 2023 09:23:25 -0700 (PDT)
Date:   Wed, 17 May 2023 09:23:16 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHP/ZGQC/x2NQQqDQBAEvyJzdkFXFyVfCR5G7egQ3IQZkQTx7
 65eGoouqJ0MKjB6ZDspNjH5xARlntEwc5zgZExMvvBVEcrGTYhv/J2vua1CaHxaSnLPBtcrx2G +9IVthV7HV/GS3114dsdxAk+dXSFxAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684340604; l=1972;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=GW4jP2PSBzeFIDkH2ffkq3N72XBOV9s7pvdD5DDFav0=; b=4ERTA9BOjWmg7kfBlrlzuCmDZ2oGmuve0kGlIsiPU0frgrM3CjT9M6wcIAbzRnlnOsb1pwWeGgyl
 jkdRWtRpCWcPNFZf/RiChBLgEmMNk4LO2yHj7LaVPOO08TFdAch/
X-Mailer: b4 0.12.2
Message-ID: <20230517-genkey-v1-1-b887424da4a8@google.com>
Subject: [PATCH] certs: buffer stderr from openssl unless error
From:   ndesaulniers@google.com
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running `openssl req` prints a progress meter consisting of `.`, `*`,
and `+` characters to stderr which we redirect to stdout. During a build
with `make -j`, the output from this command becomes interspersed
throughout the rest of the quiet_cmd_* output, messing up the
indentation.

Suppress the output from this command unless the return code is
non-zero. If `openssl req` prints additional information to stderr
without setting a non-zero return code, it will be missed.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 certs/Makefile   | 4 +---
 certs/gen_key.sh | 7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index 799ad7b9e68a..9b4fee56780d 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -45,9 +45,7 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),certs/signing_key.pem)
 keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) := -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
 
 quiet_cmd_gen_key = GENKEY  $@
-      cmd_gen_key = openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
-		-batch -x509 -config $< \
-		-outform PEM -out $@ -keyout $@ $(keytype-y) 2>&1
+      cmd_gen_key = $(srctree)/$(src)/gen_key.sh $(CONFIG_MODULE_SIG_HASH) $< $@ $(keytype-y)
 
 $(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
 	$(call if_changed,gen_key)
diff --git a/certs/gen_key.sh b/certs/gen_key.sh
new file mode 100755
index 000000000000..1de1f22be484
--- /dev/null
+++ b/certs/gen_key.sh
@@ -0,0 +1,7 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+OUT=$(openssl req -new -nodes -utf8 -"$1" -days 36500 -batch -x509 \
+	-config "$2" -outform PEM -out "$3" -keyout "$3" $4 2>&1)
+if [[ $? -ne 0 ]]; then
+	echo "$OUT"
+fi

---
base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
change-id: 20230517-genkey-24a835572835

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

