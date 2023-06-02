Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E910B720379
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjFBNf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjFBNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:35:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5E51A7;
        Fri,  2 Jun 2023 06:35:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f50e26b8bso314712166b.2;
        Fri, 02 Jun 2023 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685712921; x=1688304921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMh2+arP4Zqusoomno3ivGkTbBUqnESHWGQdrYtjkF8=;
        b=Z2DLk4fQN4adHOfPFVDfqWHl1ZrpiptyF659TT3a+Y3glNuNRoWDMgdJcNLak2scOY
         z0j4toa2l16/tRncVOBqbmOvr6OUCyxXtopOO3ozM3Ghm0N4MABer5Kw6pO0vjvcbC7M
         jaXqIgFz0Lqv158oYCmHG0eC+CXzsnb6m8CfKb7wqKVf1kLT+MJI1qu12TqoX5Ay8o7D
         sb8BuqYt4VmiCOQZDEswFf4oEPeHSvlImTL6x5jlgfrQcKmyWthmnZ/A8ExbJNc9j04i
         0BkJNYx4b0GqTJcK2St8IYrA7RfbcJ1qkURNBleMZgFahuvuKF1EtTKuPMMRgAf/OAcH
         +PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685712921; x=1688304921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMh2+arP4Zqusoomno3ivGkTbBUqnESHWGQdrYtjkF8=;
        b=RqNntVelfeKGc78O5ASVXYQNe8pw99C7gWXazztWDaXxqG/5Mkh5YCgmh50ajw9/Oa
         qiim3iXLF/uXzBgyaQuUfmYzWZoUSwFwJJYFWuZB7R8+Gr/N0Jbq0lC4IPCSbqDN2gJM
         fj8/SbdOpYuxdRXGc2PwFr079sqtQVUWae7dT7YhTXeKEfNnfDIMcpRLyEwRwBvKGO/s
         yXEGLDKo6fQFbIMs9y14zf0pwProeuay3pgl53qVN3561IQCCIbnn1M4fSggxpH3h7il
         i0xBTBaVDx1moJA+apDLr+l3zr2S2zqMSc9VpJn//x5wRGKc1dM7V1/YKoGMFLEYn3q+
         kjfw==
X-Gm-Message-State: AC+VfDx/IRUNpCPxo+l9+pSv/yTXgICDYZxK6BSFrXhPGzDQgUwLk93Z
        JGT4iZJrTJGvb2BF3usAKtC10JyVJUU4hQ==
X-Google-Smtp-Source: ACHHUZ7fHqXLlRy0wB+pOx36oQfdLkjO0mg6q1BSyho1Z/EN6yeKs56yVKD7tADaJURRA2f+j57jBg==
X-Received: by 2002:a17:907:3687:b0:958:cc8:bd55 with SMTP id bi7-20020a170907368700b009580cc8bd55mr2336949ejc.0.1685712920947;
        Fri, 02 Jun 2023 06:35:20 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090616c700b0096595cc0810sm767838ejd.72.2023.06.02.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:35:20 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: avoid bool as identifier name
Date:   Fri,  2 Jun 2023 15:35:10 +0200
Message-Id: <20230602133511.30239-1-cgzones@googlemail.com>
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

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 8 ++++----
 security/selinux/ss/conditional.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index e11219fdf9f7..b156c181c3c1 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -38,7 +38,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
 			if (sp == (COND_EXPR_MAXDEPTH - 1))
 				return -1;
 			sp++;
-			s[sp] = p->bool_val_to_struct[node->bool - 1]->state;
+			s[sp] = p->bool_val_to_struct[node->boolean - 1]->state;
 			break;
 		case COND_NOT:
 			if (sp < 0)
@@ -366,7 +366,7 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 		return 0;
 	}
 
-	if (expr->bool > p->p_bools.nprim) {
+	if (expr->boolean > p->p_bools.nprim) {
 		pr_err("SELinux: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
@@ -401,7 +401,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 			return rc;
 
 		expr->expr_type = le32_to_cpu(buf[0]);
-		expr->bool = le32_to_cpu(buf[1]);
+		expr->boolean = le32_to_cpu(buf[1]);
 
 		if (!expr_node_isvalid(p, expr))
 			return -EINVAL;
@@ -518,7 +518,7 @@ static int cond_write_node(struct policydb *p, struct cond_node *node,
 
 	for (i = 0; i < node->expr.len; i++) {
 		buf[0] = cpu_to_le32(node->expr.nodes[i].expr_type);
-		buf[1] = cpu_to_le32(node->expr.nodes[i].bool);
+		buf[1] = cpu_to_le32(node->expr.nodes[i].boolean);
 		rc = put_entry(buf, sizeof(u32), 2, fp);
 		if (rc)
 			return rc;
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index e47ec6ddeaf6..5a7b51278dc6 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -29,7 +29,7 @@ struct cond_expr_node {
 #define COND_NEQ	7 /* bool != bool */
 #define COND_LAST	COND_NEQ
 	u32 expr_type;
-	u32 bool;
+	u32 boolean;
 };
 
 struct cond_expr {
-- 
2.40.1

