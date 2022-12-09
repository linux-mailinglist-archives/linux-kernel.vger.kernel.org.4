Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0FE648950
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLIT6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiLIT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:57:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E512D21
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:57:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t17so5857947pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV94Hdsmj/rge1pxGHPoYvch3kgpddAT5RyHFFyJFTg=;
        b=MIEgM7AcEd8c1p4RBoJryGl+eDFfeBPqULbKL8T4v93d7IuqpBpKuUT4N4q3zie5Y5
         2wegkvSoDJbnR2DqvqUgRQHNzeEL5vYDbvfJYQrPLH+RWnbduNvYHR7dTB7s/xEZ0oEA
         zLjcPxIKyVogGcQqMiz6s/V/GnuLHAwfM1sZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV94Hdsmj/rge1pxGHPoYvch3kgpddAT5RyHFFyJFTg=;
        b=5H5lLwn7+4Zp75tA6SaeSrpldaY/kWKZrq7sZVhZQYeW9WJMnRcwDXi0g62M209055
         xl0Feawc1sw3/Pw9RmfrO9c3m/R0+5anUBAxVgyeIN5Qo8eqOVBklrCS26RwLqa/zZqE
         m6UOBvw+ztxFs8j4iUt4Pp1wmKN6oJlwzGUbrBpghab+KMw4QSq/Gi2oMpgdgiBXbgVM
         yn6qjNEzQpCSoBBwcYSap/GnubmFaFhoK+OYQqu6nYyitkg6/SuljPnP8DR2rM+5ZKLx
         580uoTpAQr5PMx7JbDWh6UUFYss+375a01lamDT8M/PIdSRKlCFPR396/+qPHji3DhlJ
         gjyw==
X-Gm-Message-State: ANoB5pmSF9I4lLnVJdKAQx3MmjwfC4Tuw2H0FIkBd1IDrMFFrXR1UQD0
        7fsB+1eKon7AHQpkAc/VZgGTeQ==
X-Google-Smtp-Source: AA0mqf5JfLp+yQhtaQbxy2JIfSbZafFNMeQKy6aySb+jcSnSlGQcUzWFGJmdl5DTeENoDsDcONXKhQ==
X-Received: by 2002:a17:90a:5786:b0:216:cdf6:54f4 with SMTP id g6-20020a17090a578600b00216cdf654f4mr7128252pji.48.1670615869671;
        Fri, 09 Dec 2022 11:57:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16-20020a630a10000000b00476b165ff8bsm1321797pgk.57.2022.12.09.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:57:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] LoadPin: Move pin reporting cleanly out of locking
Date:   Fri,  9 Dec 2022 11:57:44 -0800
Message-Id: <20221209195746.1366607-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209195520.never.357-kees@kernel.org>
References: <20221209195520.never.357-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; h=from:subject; bh=qpKMYDC56+fDQCAgb3kucQB61qmMW3F8BnrtighTbJ8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjk5M4AxgOeVuDbCFggXuhx/+nBj8BFwaPMy3eb2VJ NaeaG1iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY5OTOAAKCRCJcvTf3G3AJriyD/ 4r/FpIMnOqnp15Re6UBICImyzzlTPeTQyPYjM8kPBV1nrBZVoQVObVFTVsfYF0QupC5DBXHqOphZq1 MznJK9y64QlK0QxxmQiAbWEss99MW4M7gaenC2pROIftMK6LsahpdyQflTek4KFl0gJIZync7I1NR5 l0UGJLJY0y2F0KZ4W2M5XOarsAXRpDP2NJ2oJ2NLvcQ/h5dY1syx49NIeKTl3VoIAHloDwhaLsCFBX 5GD2RDGmYARrnDkhJj066OKCc6HLmgONm5mwpemsUPPWYG0a6tNjeky4aP0i1nUEcllFc0QYnH43K9 fX76lvoiRtDJRpmblu7yJyMfBAwPN2XSby9F45m24vBAXCCSdsqZmj6YAH4QZBC7lSPIOtP17lv3Lk zR428NPpNenay48toMomPOPXERR62GlqO7RVAJGNwvYCzqesj2vQ1e9vvieSywoJ+J60QiOE4uIIPB k1J6LY2ttmycsbAbQX8Po1Gs9yk+VjeZM3553qBcUV23OHqzY0hXTMMHjIlaICWnQIrxJrV2QSnwsZ wFXgCpjIZKqIrTR0u5dkryfomClsmBzVAnJ6sFsWT10Xbsq1BC0M9jZiS86aopKttRPciM16ZQ+4BC Dbfh/Sgd0DvhkkXP0s47geEvu+vc2AKu3Jl5h6D0TWARQOvUKNcQHOvAd81Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the pin reporting to be more cleanly outside the locking. It
was already, but moving it around helps clear the path for the root to
switch when not enforcing.

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/loadpin/loadpin.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5b15f8f7268d..ef12d77548ae 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -131,6 +131,7 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 {
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
+	bool first_root_pin = false;
 	bool load_root_writable;
 
 	/* If the file id is excluded, ignore the pinning. */
@@ -162,18 +163,14 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 	 */
 	if (!pinned_root) {
 		pinned_root = load_root;
-		/*
-		 * Unlock now since it's only pinned_root we care about.
-		 * In the worst case, we will (correctly) report pinning
-		 * failures before we have announced that pinning is
-		 * enforcing. This would be purely cosmetic.
-		 */
-		spin_unlock(&pinned_root_spinlock);
+		first_root_pin = true;
+	}
+	spin_unlock(&pinned_root_spinlock);
+
+	if (first_root_pin) {
 		report_writable(pinned_root, load_root_writable);
 		set_sysctl(load_root_writable);
 		report_load(origin, file, "pinned");
-	} else {
-		spin_unlock(&pinned_root_spinlock);
 	}
 
 	if (IS_ERR_OR_NULL(pinned_root) ||
-- 
2.34.1

