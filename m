Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD597749D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGFNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGFNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B31BC9;
        Thu,  6 Jul 2023 06:23:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso88722066b.3;
        Thu, 06 Jul 2023 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649829; x=1691241829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjeU+oFwnLoTGw/GiFQxSoA+QryPefibnYvK0tDSOi0=;
        b=MqKQaLP19EQnZquTr15z2LYEMWk0lbI5ahUOyiCTMkO8YK8LPDbmlgOI1nxf7s91Je
         iGlcY/sOWLM8xRhikuBOXXIghPJCylRJDoZMIu32VvAgTY86pJgwqEQk3p8fxOObj/7f
         LvypWTZxm7AJtBNKRR2383uF0sqquAmpMfEfz1wZYdiJuoOTKU+3EzQMgFHD8pX6x4fX
         /kT1jVDeH85FVHRdN43fwgGmiPS5csGgjmrY6Ji6MlU4CZvjJyDbq3YhD3LWeNVM5MQ5
         A6RnA9ztb1WrIgir9cG5fIFtq/o3yHGYCMyRQviIhzKNmMHQ3Q1efnXp1SczW5VkF0Zd
         0L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649829; x=1691241829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjeU+oFwnLoTGw/GiFQxSoA+QryPefibnYvK0tDSOi0=;
        b=C7tSbsO7jcL70oTkoLLTnxktjQstGKsHbpFOzvpZHDKf+zysijiHXIo4iVXJgGVX0v
         0+xUkc1jHajIQVdoKXdhpn1jQUqrB2n40hNl6MdkI+SwtQHCEOZi/XsMPEO7KJGcazZ2
         HC1ZoKosY9dMNOS6suaQjx7kLResGJ4n7x41mJvUIC/N5IN9ng9a+bOTFUxfedJwbEDE
         hS4XeGjLAAeWIvnGTO4XBO9T8e+LecB3u+x4+Z2KlMdbpmm54eOUAwv3eJLM4bx12NB9
         nFKywrslIdb2UqZMAZ+Dpw3POPgBVYNbT1VnhuhSY9tGl/xR+23K1aaox/wlsi+3LmOH
         LUzw==
X-Gm-Message-State: ABy/qLaQe8JgYTXc4kLSdtvjbstSFhVmYEZQmMSAGIlkRkOVJRFDWwyb
        pbOUmepoDz+11mduULLm4FNukVt87iIZDECs
X-Google-Smtp-Source: APBJJlGu2Uc3SG18KkFyWv+L8uehha8QzRmMB+1/NtU2kDc89k5qj+QydVBy+B1kR4EUTVWBoeWnWw==
X-Received: by 2002:a17:906:6492:b0:992:d013:1130 with SMTP id e18-20020a170906649200b00992d0131130mr1581300ejm.6.1688649829104;
        Thu, 06 Jul 2023 06:23:49 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/20] selinux: mls: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:21 +0200
Message-Id: <20230706132337.15924-6-cgzones@googlemail.com>
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

Use u32 for ebitmap bits.

Use char for the default range of a class.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/mls.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 99571b19d4a9..1976f6b857e9 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -45,7 +45,7 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
 
 	len = 1; /* for the beginning ":" */
 	for (l = 0; l < 2; l++) {
-		int index_sens = context->range.level[l].sens;
+		u32 index_sens = context->range.level[l].sens;
 		len += strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
 
 		/* categories */
@@ -240,7 +240,7 @@ int mls_context_to_sid(struct policydb *pol,
 	char *sensitivity, *cur_cat, *next_cat, *rngptr;
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum, *rngdatum;
-	int l, rc, i;
+	int l, rc;
 	char *rangep[2];
 
 	if (!pol->mls_enabled) {
@@ -331,7 +331,7 @@ int mls_context_to_sid(struct policydb *pol,
 			if (catdatum->value >= rngdatum->value)
 				return -EINVAL;
 
-			for (i = catdatum->value; i < rngdatum->value; i++) {
+			for (u32 i = catdatum->value; i < rngdatum->value; i++) {
 				rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
 				if (rc)
 					return rc;
@@ -451,7 +451,8 @@ int mls_convert_context(struct policydb *oldp,
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum;
 	struct ebitmap_node *node;
-	int l, i;
+	u32 i;
+	int l;
 
 	if (!oldp->mls_enabled || !newp->mls_enabled)
 		return 0;
@@ -495,7 +496,7 @@ int mls_compute_sid(struct policydb *p,
 	struct range_trans rtr;
 	struct mls_range *r;
 	struct class_datum *cladatum;
-	int default_range = 0;
+	char default_range = 0;
 
 	if (!p->mls_enabled)
 		return 0;
-- 
2.40.1

