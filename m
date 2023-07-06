Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63182749D87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGFNY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjGFNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F3E1FF5;
        Thu,  6 Jul 2023 06:24:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso10477831fa.0;
        Thu, 06 Jul 2023 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649844; x=1691241844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn4pFvZABfTjKU9YrTeBoguU9feOF4gfW94L1p7i5hU=;
        b=gUiIINmlSl//9me/XihypS9ph/uurS7b+gobd0svEUr+LMeWisf6Xoxe805QzCKoMm
         H5inKyTFnh6rEOLylIuyLTm5bgW0tmAMjrVHfvxrX3S/oKyvewXnZfnhWXgbCMFohjbM
         rILBvZIgaNNGvv9ZqY8GM3gpSnhPLCG5LegeNH86S+or2cOJmNpl0dHUFwSOWr2LLxaq
         aMTIW4XzZpfD6U0pwnOVqU5HFw8BWfE4zyoq/60ARR1OPLmz9XpdxBljTdxGDPngMEsB
         KRJVP33Y9Arh0i4QM7LkD9O8BPMtTsst1RfWxUMLWkLIyVvpbuKSmoFxmGKLR+lzX0e2
         2dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649844; x=1691241844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nn4pFvZABfTjKU9YrTeBoguU9feOF4gfW94L1p7i5hU=;
        b=VWMox+U45fTpK62uqUGEsgfNo8ciU3oVYT7ogVFQkuT/Vglngqak38x9FdeUSxI9MK
         a52hCccaL7xSJ+X24l+XGld0g+BcJyiRWCxkaMinZtpU8gvj1PvExGok/+Cuyt/eeOUi
         4mvBagJlQawkcLWwV1VX3+S4Cgw+knHB+4BHeWJxvtoR/K4HFx/7m0sZh13lxlkn+YWv
         GSlXhDiiTj+/KA7+i2wpuED6j7ZW7h0f+o34ezzYxqeT1Nj1t+xxc5GQkIVzx8K0OiSA
         JcJEYlF6ybDgaYc5JTTpP+P0UtYxarS8uUoB+5gTRaHizEtiCpYX7ufWLlF47sHcGfkW
         4mfw==
X-Gm-Message-State: ABy/qLaxcAjLLKfOMEt39tv3O1j0+cnCX5CM2qMi9x9HS0WWIG6JQsKm
        2eqweVEh8+LSgFh40/voDlJvqD429aPkWcV+
X-Google-Smtp-Source: APBJJlFEqQMUrys4nGsDxvqdKjjZ1NGFrY/klrFAXnZ+WkS3ux2ihxid1z/5bXCE2FEGk/h2O/34jg==
X-Received: by 2002:a2e:8210:0:b0:2b6:ece0:a3c1 with SMTP id w16-20020a2e8210000000b002b6ece0a3c1mr1365397ljg.35.1688649843757;
        Thu, 06 Jul 2023 06:24:03 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:24:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 19/20] selinux: status: avoid implicit conversions regarding enforcing status
Date:   Thu,  6 Jul 2023 15:23:34 +0200
Message-Id: <20230706132337.15924-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the type bool as parameter type in
selinux_status_update_setenforce().  The related function
enforcing_enabled() returns the type bool, while the struct
selinux_kernel_status member enforcing uses an u32.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/security.h | 2 +-
 security/selinux/selinuxfs.c        | 7 ++++---
 security/selinux/status.c           | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a16c52d553e1..d0837efde62b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -375,7 +375,7 @@ struct selinux_kernel_status {
 	 */
 } __packed;
 
-extern void selinux_status_update_setenforce(int enforcing);
+extern void selinux_status_update_setenforce(bool enforcing);
 extern void selinux_status_update_policyload(u32 seqno);
 extern void selinux_complete_init(void);
 extern struct path selinux_null;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c3ac0468f698..88d856f5c6bc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -137,7 +137,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 {
 	char *page = NULL;
 	ssize_t length;
-	int old_value, new_value;
+	int scan_value;
+	bool old_value, new_value;
 
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
@@ -151,10 +152,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		return PTR_ERR(page);
 
 	length = -EINVAL;
-	if (sscanf(page, "%d", &new_value) != 1)
+	if (sscanf(page, "%d", &scan_value) != 1)
 		goto out;
 
-	new_value = !!new_value;
+	new_value = !!scan_value;
 
 	old_value = enforcing_enabled();
 	if (new_value != old_value) {
diff --git a/security/selinux/status.c b/security/selinux/status.c
index e436e4975adc..dffca22ce6f7 100644
--- a/security/selinux/status.c
+++ b/security/selinux/status.c
@@ -76,7 +76,7 @@ struct page *selinux_kernel_status_page(void)
  *
  * It updates status of the current enforcing/permissive mode.
  */
-void selinux_status_update_setenforce(int enforcing)
+void selinux_status_update_setenforce(bool enforcing)
 {
 	struct selinux_kernel_status   *status;
 
@@ -87,7 +87,7 @@ void selinux_status_update_setenforce(int enforcing)
 		status->sequence++;
 		smp_wmb();
 
-		status->enforcing = enforcing;
+		status->enforcing = enforcing ? 1 : 0;
 
 		smp_wmb();
 		status->sequence++;
-- 
2.40.1

