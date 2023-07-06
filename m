Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414BA749D72
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjGFNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGFNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D61BC8;
        Thu,  6 Jul 2023 06:23:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98de21518fbso88662066b.0;
        Thu, 06 Jul 2023 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649832; x=1691241832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtVZ9IN18GMIVNNPxgzg9kuctr8q4nqyiqN2EuiG34w=;
        b=ZTokUOHN4zP+Eekl+OVEKJa3T4lLrDOw++zXwjM1vzOFublHo6uQVNIBp/dGGOS/Ab
         8Mm5Mx+/P97Qu41PqXghN6dU2xcgidnu+UAfxPHOiAqIF/avHOJAu9xwfUJN/CcDRNGS
         1MLt9/a325Jwn/fUT0+8wderCd/CsuKvke/GYevncdsj72HqSrZiOJkLJtgXD+9t9Qka
         hGuO4qHxUDdGdBCdJxskeEpSEFdfZQN4bXCM5OT75S+h6TbMTEzu4/lXZC2tBDyU0+QK
         cpij0PRyrvn80TcH4XSqprwbB4jkyQcZnVetQf6MR5xVKWgMayDzq1pPk38PodNDipOJ
         ZwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649832; x=1691241832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtVZ9IN18GMIVNNPxgzg9kuctr8q4nqyiqN2EuiG34w=;
        b=Zn1NdVPSx4i7aeBhTUc8bvYbX4B7set4CzjWRXoIatU0YVVZcX0ITgd5flwUdkkCsf
         PNjfGvkqNoQ3B4pHPu6jWj4emYe7tUONTrqLiFqcsA/9omxNOGM5EJCdu/QYZzcg/xhm
         cREHvfvTtLXEO0MwPpNHJZVjvBISc4J1/mJAuWv1AIahAYHtYcF4ulOY44BiRNkBWBp2
         IwxEl9hjiM70ghW0FGMF9sKeeIn9SG0fmNMhWNX1HodMtQuTDeKY1tS9SAL1AadVxIvP
         ZZCrNfU3eIW/wZ48hpXHCoRENtfxKspFxX+a9eM3LY5TVg97fOe6x2Z6aZ1LF6+lUY+p
         Pdag==
X-Gm-Message-State: ABy/qLZoZ6gh7YzlVqkr4awwq7sETUtVyCfkvrlGK6+Bg22PJC0Tf8G2
        jJU1Ud+yZI3/yKGxKwBdMuFnYF3r7+DkvPXH
X-Google-Smtp-Source: APBJJlHm0xxHGoItRlBOBhViYJMBJacijEFaDtslHiS9Rc0lhDN3/xyJnmCdet5MEVmC/VGp6q04zg==
X-Received: by 2002:a17:906:4792:b0:991:d5ad:f1a7 with SMTP id cw18-20020a170906479200b00991d5adf1a7mr1864982ejc.51.1688649832046;
        Thu, 06 Jul 2023 06:23:52 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/20] selinux: services: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:23 +0200
Message-Id: <20230706132337.15924-8-cgzones@googlemail.com>
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

Use u32 as the output parameter type in security_get_classes() and
security_get_permissions(), based on the type of the symtab nprim
member.

Declare the read-only class string parameter of
security_get_permissions() const.

Avoid several implicit conversions by using the identical type for the
destination.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/security.h |  4 ++--
 security/selinux/selinuxfs.c        |  7 ++++---
 security/selinux/ss/services.c      | 22 +++++++++-------------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 665c4e5bae99..0f93fd019bb4 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -312,9 +312,9 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 				 u32 *peer_sid);
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses);
+			 char ***classes, u32 *nclasses);
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms);
+			     const char *class, char ***perms, u32 *nperms);
 int security_get_reject_unknown(void);
 int security_get_allow_unknown(void);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index bad1f6b685fd..16036633ddd3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1797,7 +1797,8 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 			char *objclass, int classvalue,
 			struct dentry *dir)
 {
-	int i, rc, nperms;
+	u32 i, nperms;
+	int rc;
 	char **perms;
 
 	rc = security_get_permissions(newpolicy, objclass, &perms, &nperms);
@@ -1867,8 +1868,8 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
 			    unsigned long *last_class_ino)
 {
-
-	int rc, nclasses, i;
+	u32 i, nclasses;
+	int rc;
 	char **classes;
 
 	rc = security_get_classes(newpolicy, &classes, &nclasses);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3275cfe2c8f7..2e2b17b00298 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2822,7 +2822,6 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 {
 	struct policydb *policydb = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	int len;
 	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
@@ -2844,7 +2843,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 		return -ENOENT;
 
 	for (c = genfs->head; c; c = c->next) {
-		len = strlen(c->u.name);
+		size_t len = strlen(c->u.name);
 		if ((!c->v.sclass || sclass == c->v.sclass) &&
 		    (strncmp(c->u.name, path, len) == 0))
 			break;
@@ -3332,7 +3331,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
@@ -3342,7 +3341,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 }
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses)
+			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
 	int rc;
@@ -3358,8 +3357,7 @@ int security_get_classes(struct selinux_policy *policy,
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
 	if (rc) {
-		int i;
-		for (i = 0; i < *nclasses; i++)
+		for (u32 i = 0; i < *nclasses; i++)
 			kfree((*classes)[i]);
 		kfree(*classes);
 	}
@@ -3372,7 +3370,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 {
 	struct perm_datum *datum = d;
 	char *name = k, **perms = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	perms[value] = kstrdup(name, GFP_ATOMIC);
 	if (!perms[value])
@@ -3382,10 +3380,10 @@ static int get_permissions_callback(void *k, void *d, void *args)
 }
 
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms)
+			     const char *class, char ***perms, u32 *nperms)
 {
 	struct policydb *policydb;
-	int rc, i;
+	int rc;
 	struct class_datum *match;
 
 	policydb = &policy->policydb;
@@ -3420,7 +3418,7 @@ int security_get_permissions(struct selinux_policy *policy,
 	return rc;
 
 err:
-	for (i = 0; i < *nperms; i++)
+	for (u32 i = 0; i < *nperms; i++)
 		kfree((*perms)[i]);
 	kfree(*perms);
 	return rc;
@@ -3600,9 +3598,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 /* Check to see if the rule contains any selinux fields */
 int selinux_audit_rule_known(struct audit_krule *rule)
 {
-	int i;
-
-	for (i = 0; i < rule->field_count; i++) {
+	for (u32 i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
 		switch (f->type) {
 		case AUDIT_SUBJ_USER:
-- 
2.40.1

