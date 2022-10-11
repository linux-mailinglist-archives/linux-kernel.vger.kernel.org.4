Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0C5FBBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJKUBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJKUBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:01:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E99A9DE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:01:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so14245021pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ImRFY/kQc3nbzwRtMOnxxuLMo6+tsKsP7uuwYA4BR0=;
        b=GdbesdzwaCWqgkLNAsV5KfVktbL3UaDzzdoWc3A/Uid9TPzLobcqUwMusm+WjS1FsK
         IGTPQ99DcXwxs6onD0+bKHwk60UlUNZ4AW77I99kA0ebc3oTNyHNLytG/ozVvrER7cuI
         Vf1GyUYTANCxeX7vc06y0gxJqvo5X+ZuHFgmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ImRFY/kQc3nbzwRtMOnxxuLMo6+tsKsP7uuwYA4BR0=;
        b=2RYm5DQl5p6nQfzbpDFSH1ImeE+temztQa/4lXqvtCm98otYMZhV1FAnVOFmoORZ4c
         D78c6W4zAE2OBhGt8dEF3gnAp6Vwvp/XYLhoJ1T9haXWjrTzHc/Xs2NqU3XPTLIB94m5
         ZV9B81P4vdF8px2WtgD0YaW6/OH7mdJ/PlyZMGStA73cjlUNLQLRF/QDDuPqC6T7RM+b
         tdoSwDRyFUnfZCFmmjaS4fDCtZAgyzwB4U2Mh88x8yoLCPs7j677Pu0hpTaWsEhY6EkS
         pN3VrNuUxyihfelT0sfQVzGWskzbyj4QHfThL/ES26VjX3Z1EhbySzaTi1vBXqxIEvMd
         gGag==
X-Gm-Message-State: ACrzQf2v0nTnI3vauPzqFCeVPKsmFp+66iDWZJR6OVhLv5n24QaAIWi+
        m8rJU76nzdUCzXKwTR8htcLPQQ==
X-Google-Smtp-Source: AMsMyM7a3zBz6ADcgsNbPrpNPfDdQ9wFNVD9/cbamGp+fK1w86YjAePIu1woS0FTC0RVmaT+LaOqOg==
X-Received: by 2002:a17:903:41c3:b0:17f:8def:dc92 with SMTP id u3-20020a17090341c300b0017f8defdc92mr25919272ple.7.1665518476781;
        Tue, 11 Oct 2022 13:01:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b00172897952a0sm9075354plc.283.2022.10.11.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:01:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] pstore/ram: Consolidate kfree() paths
Date:   Tue, 11 Oct 2022 13:01:08 -0700
Message-Id: <20221011200112.731334-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011200112.731334-1-keescook@chromium.org>
References: <20221011200112.731334-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; h=from:subject; bh=mEys1/rsMBHmicDuT/PsrbPdqAOP6FbA5qrs0C/Aook=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRcuGkYaMuiV1/iqYJVxiQLWWJdgT/EO2hGLXvCmv f1roR0+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0XLhgAKCRCJcvTf3G3AJmIJD/ 9YFybwXm4L9u+XUPazEJkw+K98z+r3+XGqgpk3nmGI6xxI4nJQgRqRn4GmlGBcUHr/osiLps9UShHn jr7WoywJyiwhPJfCeE0nj8drYxyiGoNXVk3iGKxwOBa+mA3HuRBxm3Dqv3C1pWImZ+8+4JogFP+Knn utLQSoKMw8Is7uGgJ8cbITYcrBU6k5vKYkVZ8Bt/gFR4j1xvcJEH34AAdtWk8lhdI33+WHjyZq0uwb lbFAta32vWqN0VZ3KD0Eu8KaL26IsSC3azgr3NAyoxZBOILh9Hun55SzC62SMupjIo6GGiZElr+7HF +V54LJfiNMAkD14iDvRxE2SOm61lT1VYM51gr6AR8qqcgivrE3wboJ2pjN937d4kVjQ1pMckd5Amjq 8QMVN+oLXyJO84jq8fZ7MXp048Uzh5Ur2KFB8S8ySuTv+MAy9J8i4WZw33ogCBDFrgZztOtGJ3hoI/ /JpaDtaAmSnmxQW9SrNlrh/s8/YHXhkvll3yTJeuVB2pX913iv78NZADfPHba/TBjaQIQt2RBpcnNE +RN0+TE5ROe/voSF6gKmnqfqXv0eYEolf5YGRw4o9U3A+/5qjDTX/KecPwKGyHIahZwsoRpSFLyzLf zRp7ckYYdmVt2po2Yp0XnYkpjlBcqqILqkSGfDCVhbC444cauyk10bWrS8VA==
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

There's no reason to keep separate kfree() paths: either all allocations
succeeded, or not. Everything is torn down in the case of failure, so
adjust the callers to reflect this.

Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index fefe3d391d3a..348820a3ce88 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -451,6 +451,12 @@ static void ramoops_free_przs(struct ramoops_context *cxt)
 {
 	int i;
 
+	/* Free pmsg PRZ */
+	persistent_ram_free(cxt->mprz);
+
+	/* Free console PRZ */
+	persistent_ram_free(cxt->cprz);
+
 	/* Free dump PRZs */
 	if (cxt->dprzs) {
 		for (i = 0; i < cxt->max_dump_cnt; i++)
@@ -772,12 +778,12 @@ static int ramoops_probe(struct platform_device *pdev)
 				dump_mem_sz, cxt->record_size,
 				&cxt->max_dump_cnt, 0, 0);
 	if (err)
-		goto fail_out;
+		goto fail_init;
 
 	err = ramoops_init_prz("console", dev, cxt, &cxt->cprz, &paddr,
 			       cxt->console_size, 0);
 	if (err)
-		goto fail_init_cprz;
+		goto fail_init;
 
 	cxt->max_ftrace_cnt = (cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
 				? nr_cpu_ids
@@ -788,12 +794,12 @@ static int ramoops_probe(struct platform_device *pdev)
 				(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
 					? PRZ_FLAG_NO_LOCK : 0);
 	if (err)
-		goto fail_init_fprz;
+		goto fail_init;
 
 	err = ramoops_init_prz("pmsg", dev, cxt, &cxt->mprz, &paddr,
 				cxt->pmsg_size, 0);
 	if (err)
-		goto fail_init_mprz;
+		goto fail_init;
 
 	cxt->pstore.data = cxt;
 	/*
@@ -857,11 +863,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 fail_clear:
 	cxt->pstore.bufsize = 0;
-	persistent_ram_free(cxt->mprz);
-fail_init_mprz:
-fail_init_fprz:
-	persistent_ram_free(cxt->cprz);
-fail_init_cprz:
+fail_init:
 	ramoops_free_przs(cxt);
 fail_out:
 	return err;
@@ -876,8 +878,6 @@ static int ramoops_remove(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 	cxt->pstore.bufsize = 0;
 
-	persistent_ram_free(cxt->mprz);
-	persistent_ram_free(cxt->cprz);
 	ramoops_free_przs(cxt);
 
 	return 0;
-- 
2.34.1

