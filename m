Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263B0749D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjGFNYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGFNYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF01994;
        Thu,  6 Jul 2023 06:24:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992af8b3b1bso87803566b.1;
        Thu, 06 Jul 2023 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649839; x=1691241839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhqfK8uOyIqhSWoksWSfTXUpr2q1z9ORZXhHYVLrqUc=;
        b=O4KSmmCeD9sYZFHVmyww/xG4Bn2lpeGw2ZtWKThZ/pDxxSrDATDoWPKO14yfoPINdz
         Qb8Kir3o5FMfNA3QJ5MZi0mRXld3ldX8DNnuDhJ6eRSeV1kus9OTNdd+uBrKkYEJboQP
         Yp0UkuhmHOposft2+KQ0CZCKVTEqdaj5vMJY6ez6n1MSZNIgk7Q6Gofh86DSshCVvoK9
         PPMQO+6sU5f70/fIjRBvZsgAl9lZRhFR0icq9c9sVnEn+5za1StHnsGPw+A/6qunbe+p
         X4NzTASICdF+gUGoEpO5QODq8qmHavtPecdgHmKTkin0fUpQ5C8TjoQ0MbRD36pG3j0/
         rSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649839; x=1691241839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhqfK8uOyIqhSWoksWSfTXUpr2q1z9ORZXhHYVLrqUc=;
        b=gPI29vKZxp59SBoq2q+yMbTNa5O1Vd7B/9UZY9xkj2VRqlWlgZyF4mAg5PRnHYk7UO
         aqRKDOnTJwE4khnHASwFgBeT8iTnVzUVAXCWg0Yi/A0wI64Ij3YJLUy0TBz77J5DrAFY
         QGilRiUjz2eFVvmevIpTeXL099gWLF7pUsJ7fNJQd5UWrLIzgXEfN2xPPp0TW3OHCos3
         iB0xXsmniYzr0RrFtvhcLWDYcx158A62rCGbeIEs9INWRqbsG4SDPrK9lYRAO7g0bVCe
         d8X/jloCa2yRPGQz8RT6IQ6a9uT0zTs7idCMlE6yPeNq1FO/tz3Zqv3/EhOltIYnyRro
         Y8ug==
X-Gm-Message-State: ABy/qLb08FGUOZkVlDwo4mCqFXiefBuewumuacUSk2Xrec5jI6FwKIyC
        doJQA2t0MQd5x5I9p0b4KdqCfUG+si1gdyVo
X-Google-Smtp-Source: APBJJlG9MaOIZc/y/RkPd/ZmorYz4p4b/YrdZJGuFNw7KK/6hkO9a969QNx7FXMR9RYVMBbYmJ5i+A==
X-Received: by 2002:a17:907:3f0b:b0:98e:2423:708 with SMTP id hq11-20020a1709073f0b00b0098e24230708mr1678815ejc.62.1688649838816;
        Thu, 06 Jul 2023 06:23:58 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/20] selinux: policydb: implicit conversions
Date:   Thu,  6 Jul 2023 15:23:30 +0200
Message-Id: <20230706132337.15924-15-cgzones@googlemail.com>
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

Use the identical type for local variables, e.g. loop counters.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 112 +++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 47 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index cfe77ef24ee2..9d0a3dab80d5 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -161,9 +161,7 @@ static const struct policydb_compat_info policydb_compat[] = {
 
 static const struct policydb_compat_info *policydb_lookup_compat(int version)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
+	for (u32 i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
 		if (policydb_compat[i].version == version)
 			return &policydb_compat[i];
 	}
@@ -359,7 +357,7 @@ static int role_tr_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
-static void ocontext_destroy(struct ocontext *c, int i)
+static void ocontext_destroy(struct ocontext *c, u32 i)
 {
 	if (!c)
 		return;
@@ -781,7 +779,7 @@ void policydb_destroy(struct policydb *p)
 {
 	struct ocontext *c, *ctmp;
 	struct genfs *g, *gtmp;
-	int i;
+	u32 i;
 	struct role_allow *ra, *lra = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
@@ -1155,7 +1153,7 @@ static int common_read(struct policydb *p, struct symtab *s, void *fp)
 	struct common_datum *comdatum;
 	__le32 buf[4];
 	u32 len, nel;
-	int i, rc;
+	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
 	if (!comdatum)
@@ -1178,7 +1176,7 @@ static int common_read(struct policydb *p, struct symtab *s, void *fp)
 	if (rc)
 		goto bad;
 
-	for (i = 0; i < nel; i++) {
+	for (u32 i = 0; i < nel; i++) {
 		rc = perm_read(p, &comdatum->permissions, fp);
 		if (rc)
 			goto bad;
@@ -1220,16 +1218,16 @@ static int type_set_read(struct type_set *t, void *fp)
 
 static int read_cons_helper(struct policydb *p,
 				struct constraint_node **nodep,
-				int ncons, int allowxtarget, void *fp)
+				u32 ncons, int allowxtarget, void *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
 	__le32 buf[3];
 	u32 nexpr;
-	int rc, i, j, depth;
+	int rc, depth;
 
 	lc = NULL;
-	for (i = 0; i < ncons; i++) {
+	for (u32 i = 0; i < ncons; i++) {
 		c = kzalloc(sizeof(*c), GFP_KERNEL);
 		if (!c)
 			return -ENOMEM;
@@ -1246,7 +1244,7 @@ static int read_cons_helper(struct policydb *p,
 		nexpr = le32_to_cpu(buf[1]);
 		le = NULL;
 		depth = -1;
-		for (j = 0; j < nexpr; j++) {
+		for (u32 j = 0; j < nexpr; j++) {
 			e = kzalloc(sizeof(*e), GFP_KERNEL);
 			if (!e)
 				return -ENOMEM;
@@ -1319,7 +1317,7 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 	struct class_datum *cladatum;
 	__le32 buf[6];
 	u32 len, len2, ncons, nel;
-	int i, rc;
+	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
 	if (!cladatum)
@@ -1359,7 +1357,7 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 			goto bad;
 		}
 	}
-	for (i = 0; i < nel; i++) {
+	for (u32 i = 0; i < nel; i++) {
 		rc = perm_read(p, &cladatum->permissions, fp);
 		if (rc)
 			goto bad;
@@ -1412,7 +1410,8 @@ static int role_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
-	int rc, to_read = 2;
+	int rc;
+	unsigned int to_read = 2;
 	__le32 buf[3];
 	u32 len;
 
@@ -1468,7 +1467,8 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
-	int rc, to_read = 3;
+	int rc;
+	unsigned int to_read = 3;
 	__le32 buf[4];
 	u32 len;
 
@@ -1542,7 +1542,8 @@ static int user_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
-	int rc, to_read = 2;
+	int rc;
+	unsigned int to_read = 2;
 	__le32 buf[3];
 	u32 len;
 
@@ -1683,7 +1684,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 	upper = user = datum;
 	while (upper->bounds) {
 		struct ebitmap_node *node;
-		unsigned long bit;
+		u32 bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: user %s: "
@@ -1719,7 +1720,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 	upper = role = datum;
 	while (upper->bounds) {
 		struct ebitmap_node *node;
-		unsigned long bit;
+		u32 bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: role %s: "
@@ -1834,7 +1835,7 @@ static int range_read(struct policydb *p, void *fp)
 {
 	struct range_trans *rt = NULL;
 	struct mls_range *r = NULL;
-	int i, rc;
+	int rc;
 	__le32 buf[2];
 	u32 nel;
 
@@ -1851,7 +1852,7 @@ static int range_read(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
-	for (i = 0; i < nel; i++) {
+	for (u32 i = 0; i < nel; i++) {
 		rc = -ENOMEM;
 		rt = kzalloc(sizeof(*rt), GFP_KERNEL);
 		if (!rt)
@@ -1996,7 +1997,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, tclass, ndatum, i;
+	u32 len, ttype, ndatum, tclass;
 	__le32 buf[3];
 	int rc;
 
@@ -2026,7 +2027,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	}
 
 	dst = &first;
-	for (i = 0; i < ndatum; i++) {
+	for (u32 i = 0; i < ndatum; i++) {
 		rc = -ENOMEM;
 		datum = kmalloc(sizeof(*datum), GFP_KERNEL);
 		if (!datum)
@@ -2082,9 +2083,9 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 
 static int filename_trans_read(struct policydb *p, void *fp)
 {
-	u32 nel;
+	u32 nel, i;
 	__le32 buf[1];
-	int rc, i;
+	int rc;
 
 	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
 		return 0;
@@ -2123,7 +2124,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 
 static int genfs_read(struct policydb *p, void *fp)
 {
-	int i, j, rc;
+	int rc;
 	u32 nel, nel2, len, len2;
 	__le32 buf[1];
 	struct ocontext *l, *c;
@@ -2136,7 +2137,7 @@ static int genfs_read(struct policydb *p, void *fp)
 		return rc;
 	nel = le32_to_cpu(buf[0]);
 
-	for (i = 0; i < nel; i++) {
+	for (u32 i = 0; i < nel; i++) {
 		rc = next_entry(buf, fp, sizeof(u32));
 		if (rc)
 			goto out;
@@ -2175,7 +2176,7 @@ static int genfs_read(struct policydb *p, void *fp)
 			goto out;
 
 		nel2 = le32_to_cpu(buf[0]);
-		for (j = 0; j < nel2; j++) {
+		for (u32 j = 0; j < nel2; j++) {
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto out;
@@ -2237,8 +2238,8 @@ static int genfs_read(struct policydb *p, void *fp)
 static int ocontext_read(struct policydb *p, const struct policydb_compat_info *info,
 			 void *fp)
 {
-	int i, j, rc;
-	u32 nel, len;
+	int i, rc;
+	u32 nel, len, val;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
@@ -2251,7 +2252,7 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 		nel = le32_to_cpu(buf[0]);
 
 		l = NULL;
-		for (j = 0; j < nel; j++) {
+		for (u32 j = 0; j < nel; j++) {
 			rc = -ENOMEM;
 			c = kzalloc(sizeof(*c), GFP_KERNEL);
 			if (!c)
@@ -2299,9 +2300,27 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 				rc = next_entry(buf, fp, sizeof(u32)*3);
 				if (rc)
 					goto out;
-				c->u.port.protocol = le32_to_cpu(buf[0]);
-				c->u.port.low_port = le32_to_cpu(buf[1]);
-				c->u.port.high_port = le32_to_cpu(buf[2]);
+
+				rc = -EINVAL;
+
+				val = le32_to_cpu(buf[0]);
+				if (val > U8_MAX)
+					goto out;
+				c->u.port.protocol = val;
+
+				val = le32_to_cpu(buf[1]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.low_port = val;
+
+				val = le32_to_cpu(buf[2]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.high_port = val;
+
+				if (c->u.port.low_port > c->u.port.high_port)
+					goto out;
+
 				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
 					goto out;
@@ -2429,7 +2448,7 @@ int policydb_read(struct policydb *p, void *fp)
 	struct role_allow *ra, *lra;
 	struct role_trans_key *rtk = NULL;
 	struct role_trans_datum *rtd = NULL;
-	int i, j, rc;
+	int rc;
 	__le32 buf[4];
 	u32 len, nprim, nel, perm;
 
@@ -2546,7 +2565,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	}
 
-	for (i = 0; i < info->sym_num; i++) {
+	for (int i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(u32)*2);
 		if (rc)
 			goto bad;
@@ -2563,7 +2582,7 @@ int policydb_read(struct policydb *p, void *fp)
 				goto out;
 		}
 
-		for (j = 0; j < nel; j++) {
+		for (u32 j = 0; j < nel; j++) {
 			rc = read_f[i](p, &p->symtab[i], fp);
 			if (rc)
 				goto bad;
@@ -2597,7 +2616,7 @@ int policydb_read(struct policydb *p, void *fp)
 	rc = hashtab_init(&p->role_tr, nel);
 	if (rc)
 		goto bad;
-	for (i = 0; i < nel; i++) {
+	for (u32 i = 0; i < nel; i++) {
 		rc = -ENOMEM;
 		rtk = kmalloc(sizeof(*rtk), GFP_KERNEL);
 		if (!rtk)
@@ -2643,7 +2662,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 	lra = NULL;
-	for (i = 0; i < nel; i++) {
+	for (u32 i = 0; i < nel; i++) {
 		rc = -ENOMEM;
 		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
 		if (!ra)
@@ -2707,10 +2726,10 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 
 	/* just in case ebitmap_init() becomes more than just a memset(0): */
-	for (i = 0; i < p->p_types.nprim; i++)
+	for (u32 i = 0; i < p->p_types.nprim; i++)
 		ebitmap_init(&p->type_attr_map_array[i]);
 
-	for (i = 0; i < p->p_types.nprim; i++) {
+	for (u32 i = 0; i < p->p_types.nprim; i++) {
 		struct ebitmap *e = &p->type_attr_map_array[i];
 
 		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
@@ -3282,7 +3301,7 @@ static int (*const write_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 static int ocontext_write(struct policydb *p, const struct policydb_compat_info *info,
 			  void *fp)
 {
-	unsigned int i, j, rc;
+	int i, rc;
 	size_t nel, len;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
@@ -3360,9 +3379,9 @@ static int ocontext_write(struct policydb *p, const struct policydb_compat_info
 					return rc;
 				break;
 			case OCON_NODE6:
-				for (j = 0; j < 4; j++)
+				for (unsigned int j = 0; j < 4; j++)
 					nodebuf[j] = c->u.node6.addr[j]; /* network order */
-				for (j = 0; j < 4; j++)
+				for (unsigned int j = 0; j < 4; j++)
 					nodebuf[j + 4] = c->u.node6.mask[j]; /* network order */
 				rc = put_entry(nodebuf, sizeof(u32), 8, fp);
 				if (rc)
@@ -3631,8 +3650,7 @@ static int filename_trans_write(struct policydb *p, void *fp)
  */
 int policydb_write(struct policydb *p, void *fp)
 {
-	unsigned int i, num_syms;
-	int rc;
+	int rc, num_syms;
 	__le32 buf[4];
 	u32 config;
 	size_t len;
@@ -3701,7 +3719,7 @@ int policydb_write(struct policydb *p, void *fp)
 	}
 
 	num_syms = info->sym_num;
-	for (i = 0; i < num_syms; i++) {
+	for (int i = 0; i < num_syms; i++) {
 		struct policy_data pd;
 
 		pd.fp = fp;
@@ -3750,7 +3768,7 @@ int policydb_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
-	for (i = 0; i < p->p_types.nprim; i++) {
+	for (u32 i = 0; i < p->p_types.nprim; i++) {
 		struct ebitmap *e = &p->type_attr_map_array[i];
 
 		rc = ebitmap_write(e, fp);
-- 
2.40.1

