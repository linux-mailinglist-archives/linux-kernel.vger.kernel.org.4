Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A9749D71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGFNYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGFNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6F1BD0;
        Thu,  6 Jul 2023 06:23:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992b66e5affso87869066b.3;
        Thu, 06 Jul 2023 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649830; x=1691241830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkBksRN7bdprO5MQOGhCkpjrSYNKbvjJ8BXlsGQfvbA=;
        b=XHZjH3uHqOB8pfbX97fSIP4Cmqu8I8oGtx+y4X5VGJED3j1RGgyne9bDc3pDI2EC69
         SOZU5SqQjIrmOEqrII3G5hSuySj0v8TOzQ2OiXRRBtIKNBh3o9J5ZjX3dNE4p1zgeeM+
         mVrEpA8HlL5RfePue4ttSeNTW56CNys+++3aW8F7aUyT6Vnh/rSekfFFkfwIWqLbgGuM
         uZaE4blGBC6f8iqhVJJjVVJlOy9dwdZwka1DRoY2Ef/dOoho+QFNi3PCLF8TwpH6jmhJ
         uCZMaZgDhNSQ+cPPcdNEaFEZDbvr49yX7onnWWp2Rquk5n2wIbOq7jBz7x9D+XSKnPoc
         pRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649830; x=1691241830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkBksRN7bdprO5MQOGhCkpjrSYNKbvjJ8BXlsGQfvbA=;
        b=kYJnX4HLM59mqCbURZhNwu8NysSQQiFb12lmYLl48E2EOLg0mwZ5BW7JxUNiDNvTin
         JGNUKL9Oj7dARUc8ynrb2wfqmkvmprmR/QUMXck0wMm7sOOA+rkgHPk0c6Dm1qy6MSO+
         sANz8t01gDxn5aqtYdvFMyCKVqvZ4DZXhUtWymNqLVOLDX7bgttqD+13HW24jWeHvbn5
         GpqfTQy6jIeaUzvQUT0SLXNqMjaTJEJDR3XxWNRKYtXZ0bFHgzzDKBn6PFE4HRpU9nd6
         62BXisx2RBnjLpuBnEUtdPOlOPkntdo9CsW49LLjiTDV+AOvuqJ+gSFJrDcg+MVnmetD
         357w==
X-Gm-Message-State: ABy/qLZ5DpB8sV6qnZTAeK24TETXrmt3Q78PKKC2gBKrFCDpYpa3jV/K
        MSYEF6p1VuJCyJJPOVn0gm8nYFqT8ay3LW3C
X-Google-Smtp-Source: APBJJlE0ZxoHa/axZ9BSuMs4JTTWHi8l90/a5i/e5FANIZ0p+QRLaY5st3EStnGzq3xLBU/BhN98SQ==
X-Received: by 2002:a17:906:f55:b0:988:4dc:e3a3 with SMTP id h21-20020a1709060f5500b0098804dce3a3mr1289943ejj.31.1688649830532;
        Thu, 06 Jul 2023 06:23:50 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/20] selinux: services: update type for umber of class permissions
Date:   Thu,  6 Jul 2023 15:23:22 +0200
Message-Id: <20230706132337.15924-7-cgzones@googlemail.com>
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

Security classes have only up to 32 permissions, hence using an u16 is
sufficient (while improving padding).

Also use a fixed sized cast in a bit shift to work correctly on
architectures where sizeof(unsigned int) != sizeof(u32).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 6 +++---
 security/selinux/ss/services.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 78946b71c1c1..3275cfe2c8f7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -97,7 +97,6 @@ static int selinux_set_mapping(struct policydb *pol,
 			       struct selinux_map *out_map)
 {
 	u16 i, j;
-	unsigned k;
 	bool print_unknown_handle = false;
 
 	/* Find number of classes in the input mapping */
@@ -117,6 +116,7 @@ static int selinux_set_mapping(struct policydb *pol,
 	while (map[j].name) {
 		const struct security_class_mapping *p_in = map + (j++);
 		struct selinux_mapping *p_out = out_map->mapping + j;
+		u16 k;
 
 		/* An empty class string skips ahead */
 		if (!strcmp(p_in->name, "")) {
@@ -202,7 +202,7 @@ static void map_decision(struct selinux_map *map,
 {
 	if (tclass < map->size) {
 		struct selinux_mapping *mapping = &map->mapping[tclass];
-		unsigned int i, n = mapping->num_perms;
+		u16 i, n = mapping->num_perms;
 		u32 result;
 
 		for (i = 0, result = 0; i < n; i++) {
@@ -230,7 +230,7 @@ static void map_decision(struct selinux_map *map,
 		 * should audit that denial
 		 */
 		for (; i < (sizeof(u32)*8); i++)
-			result |= 1<<i;
+			result |= 1<<((u32)i);
 		avd->auditdeny = result;
 	}
 }
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 8a9b85f44b66..b6f99353301e 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -12,7 +12,7 @@
 /* Mapping for a single class */
 struct selinux_mapping {
 	u16 value; /* policy value for class */
-	unsigned int num_perms; /* number of permissions in class */
+	u16 num_perms; /* number of permissions in class */
 	u32 perms[sizeof(u32) * 8]; /* policy values for permissions */
 };
 
-- 
2.40.1

