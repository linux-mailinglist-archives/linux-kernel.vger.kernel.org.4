Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2419A7203CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjFBNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjFBNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:54:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960DD3;
        Fri,  2 Jun 2023 06:54:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso3099927a12.0;
        Fri, 02 Jun 2023 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685714071; x=1688306071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDpXsnaJTFHH62sQsPmicJfhzz97hie0lQUAduHr3qw=;
        b=fqmmt9m9Og7MSjhS20D/NfmSLs+XU6HykZBgQMDZlrFvPEz78Efl2ttDAlt0I9sabq
         9jDwf8GfwR+i+jCNGNitY+iaWF4dSk5H0EwnyZNO6coDy0e8klga4Qfzp0QemhQ0wyfh
         uoBvidX7mmP+IFMLamLZxaRMsreB7GJvyV5xC5BLAHA/3v0Kp3VNGu98qFaCq3te16qq
         zxxMBffX6e515Va1HXLqIg3hcLzwh0U20NduxcijX3/gDYIAEbi7ogzpStVrL0Ul8I7H
         RBE57Ml+AS3L4kUWbUO2wQJT8MIYFH9l0FjP7ArEcTJQvFL904ZYxFjdHInn84zYtEQx
         7YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685714071; x=1688306071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDpXsnaJTFHH62sQsPmicJfhzz97hie0lQUAduHr3qw=;
        b=L7xsAhMBr5We0L9A6M/np1sT5QiynCG5bII8bMEAcP06mc3I26oRUZpSvNlDlQECSI
         TWxZXSsu5pBCnUuFMjfgYzyBpXCYFemlOwheJGC8wSCMvZfQyRWkzY6icpMRizLcxFmC
         iM/HEmcRx6T6moiHWBhc6gclvHRefBUmxrBtBc22Nia71LlsqL9YWWOv/aVLEI/0JT9N
         U1bs1p9cvy2Ch8QknEh7t2zkKgNtsBOKfbkMDsyayGPXCyYnnhZvTel++/L68H89bWcO
         YRt9EljkeTz8WHv7nm4eghLRorKF3944gohPEMR5NgdWKcbAeC5GudxzSHdyVV2+SxKy
         kU1g==
X-Gm-Message-State: AC+VfDyfSU+T5ilPtiKjwp3JVetGZ20O9dhjot0jshVrZ2ekv9Jx2L7E
        oL4zFusUJMOYi1t1wBeqc5A+MVjPd0+6Jw==
X-Google-Smtp-Source: ACHHUZ4tIYSr8WC8t5CEEBXmgh1Z43KeMwYCwv+nydG9MyJluLR3eu/WvO+dopqLn8p5bQDxDOGubg==
X-Received: by 2002:a05:6402:b34:b0:515:4043:4770 with SMTP id bo20-20020a0564020b3400b0051540434770mr1931992edb.41.1685714071485;
        Fri, 02 Jun 2023 06:54:31 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402150300b00514b99afa57sm731453edw.44.2023.06.02.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:54:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Juraj Marcin <juraj@jurajmarcin.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: support name based type transitions in conditional policies
Date:   Fri,  2 Jun 2023 15:54:26 +0200
Message-Id: <20230602135427.33897-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the move of name based type transitions to the avtab structure such
statements are candidate to be used in conditional policies.  They are
already read into the policy database (which might be seen as a mistake
as referencing them after a boolean change causes a use-after-free).

Copy the avtab_trans structures on boolean changes to keep them
available.

CC: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Based on patcheset by Juraj Marcin [1]

[1]: https://patchwork.kernel.org/project/selinux/list/?series=752711
---
 security/selinux/ss/avtab.c       |  2 +-
 security/selinux/ss/avtab.h       |  2 +
 security/selinux/ss/conditional.c | 96 ++++++++++++++++++++++++++++---
 3 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index d3c027e5c0da..8068c9b4d1e6 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -297,7 +297,7 @@ static int avtab_trans_destroy_helper(void *k, void *d, void *args)
 	return 0;
 }
 
-static void avtab_trans_destroy(struct avtab_trans *trans)
+void avtab_trans_destroy(struct avtab_trans *trans)
 {
 	hashtab_map(&trans->name_trans.table, avtab_trans_destroy_helper, NULL);
 	hashtab_destroy(&trans->name_trans.table);
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 929e322715d1..eb19d7719b72 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -125,6 +125,8 @@ struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified
 #define MAX_AVTAB_HASH_BITS 16
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
 
+void avtab_trans_destroy(struct avtab_trans *trans);
+
 /* policydb filename transitions compatibility */
 
 int avtab_filename_trans_read(struct avtab *a, void *fp, struct policydb *p);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 91392d65563e..48b162dca3f5 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -605,11 +605,36 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 	}
 }
 
+static int cond_avtab_trans_destroy_helper(void *k, void *d, __always_unused void *args)
+{
+	kfree(k);
+	kfree(d);
+	return 0;
+}
+
+static int cond_avtab_trans_copy(struct hashtab_node *new, const struct hashtab_node *orig,
+				 __always_unused void *args)
+{
+	new->key = kstrdup(orig->key, GFP_KERNEL);
+	if (!new->key)
+		return -ENOMEM;
+
+	new->datum = kmemdup(orig->datum, sizeof(u32), GFP_KERNEL);
+	if (!new->datum) {
+		kfree(new->key);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int cond_dup_av_list(struct cond_av_list *new,
-			struct cond_av_list *orig,
-			struct avtab *avtab)
+			const struct cond_av_list *orig,
+			struct avtab *avtab,
+			const struct policydb *origp)
 {
 	u32 i;
+	int rc;
 
 	memset(new, 0, sizeof(*new));
 
@@ -618,9 +643,66 @@ static int cond_dup_av_list(struct cond_av_list *new,
 		return -ENOMEM;
 
 	for (i = 0; i < orig->len; i++) {
-		new->nodes[i] = avtab_insert_nonunique(avtab,
-						       &orig->nodes[i]->key,
-						       &orig->nodes[i]->datum);
+		const struct avtab_key *orig_key = &orig->nodes[i]->key;
+		struct avtab_datum datum = orig->nodes[i]->datum;
+
+		if (origp->policyvers >= POLICYDB_VERSION_AVTAB_FTRANS &&
+		    (orig_key->specified & AVTAB_TRANSITION)) {
+			struct avtab_trans trans = {
+				.otype = datum.u.trans->otype,
+			};
+
+			rc = symtab_init(&trans.name_trans,
+					 datum.u.trans->name_trans.table.nel);
+			if (rc) {
+				avtab_trans_destroy(&trans);
+				return rc;
+			}
+			rc = symtab_init(&trans.prefix_trans,
+					 datum.u.trans->prefix_trans.table.nel);
+			if (rc) {
+				avtab_trans_destroy(&trans);
+				return rc;
+			}
+			rc = symtab_init(&trans.suffix_trans,
+					 datum.u.trans->suffix_trans.table.nel);
+			if (rc) {
+				avtab_trans_destroy(&trans);
+				return rc;
+			}
+
+			rc = hashtab_duplicate(&trans.name_trans.table,
+					       &datum.u.trans->name_trans.table,
+					       cond_avtab_trans_copy,
+					       cond_avtab_trans_destroy_helper,
+					       NULL);
+			if (rc) {
+				avtab_trans_destroy(&trans);
+				return rc;
+			}
+			rc = hashtab_duplicate(&trans.prefix_trans.table,
+					       &datum.u.trans->prefix_trans.table,
+					       cond_avtab_trans_copy,
+					       cond_avtab_trans_destroy_helper,
+					       NULL);
+			if (rc) {
+				avtab_trans_destroy(&trans);
+				return rc;
+			}
+			rc = hashtab_duplicate(&trans.suffix_trans.table,
+					       &datum.u.trans->suffix_trans.table,
+					       cond_avtab_trans_copy,
+					       cond_avtab_trans_destroy_helper,
+					       NULL);
+			if (rc) {
+				avtab_trans_destroy(&trans);
+				return rc;
+			}
+
+			datum.u.trans = &trans;
+		}
+
+		new->nodes[i] = avtab_insert_nonunique(avtab, orig_key, &datum);
 		if (!new->nodes[i])
 			return -ENOMEM;
 		new->len++;
@@ -662,12 +744,12 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 		newn->expr.len = orign->expr.len;
 
 		rc = cond_dup_av_list(&newn->true_list, &orign->true_list,
-				&newp->te_cond_avtab);
+				&newp->te_cond_avtab, origp);
 		if (rc)
 			goto error;
 
 		rc = cond_dup_av_list(&newn->false_list, &orign->false_list,
-				&newp->te_cond_avtab);
+				&newp->te_cond_avtab, origp);
 		if (rc)
 			goto error;
 	}
-- 
2.40.1

