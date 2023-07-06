Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256CE749D77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGFNYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjGFNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFA21BF0;
        Thu,  6 Jul 2023 06:23:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703c900e3so9897141fa.1;
        Thu, 06 Jul 2023 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649835; x=1691241835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A9liYAylTYZaKkz26rlg+lN90yLkMQe/eVravo5I1c=;
        b=aYu4VEkg1GaCVjNfGwnh+Eh6dEw3yAg01DNOsnqXa5BVHIB/wirjEwhMuR/FtHoleV
         pP7DfzwoP22q6QAXXXjxHkS3/i5azG+O91vMIZ4rVH1RhMHO4UKj6k3crmi/BrG1To+5
         oa6qVT7Z8Y3NBmniXRf2cqfxH6xL0EH6nNKhvqvXISYpOtiBPMttQUKbzmj2mDFAv5D6
         wcGMBzErZaiwncQNqJW2LTwLWPTU6wLWtaKb4y0uCtnlvuWpRRuODZ/5WufyxQLsCaLl
         GsjT9JoErZmIRznP7CGus962pLOw91T7IGBZVEvu5AK3hmGPovdDVvz+e30gWktqJl1i
         Qnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649835; x=1691241835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A9liYAylTYZaKkz26rlg+lN90yLkMQe/eVravo5I1c=;
        b=MbyV31bGmohlR3iulrmORQ68hDXz6aYDbwds7VAJ8lKFaem2RUIJnl3stgMQt4LvPZ
         L8bZKnkPCoak7d9vs8pFAd2LUBXJMC09ZbyKTQUCmhez4/jWENS/5RHmaKmtB29Nq1Wi
         pnMhvkKoOjWJZXS/sVMSPd8OcA/KJm9qtmP+qBP+kZ/Bu6v0B+KGTMrvuWxtZGitWvyf
         WfBCKtMDXpxUl3jKtwRNUsr7LpyLY6/QQKY7Y+qZvxb8XoFeqE781Uf2n/xmuYYJj616
         CmOWcF6EDdsCh9o91m6/abFX2FYyHfs37Qq9LfJpPjmqYYeDY6z4PzErxNdTlC9oOCyz
         2AXw==
X-Gm-Message-State: ABy/qLbYlAk3RoWGTQK6KASXQw4Gh7eDx8cKjx4d3ACBR3eEnVQbPTmq
        NIH21WCIKKgaUVYGpESZGm56o4mmfeEVDmYv
X-Google-Smtp-Source: APBJJlGDYQnr04I5ouAE/S+drMjthPtgH0/2CEii0REOh6/8rC7/8ZrVnYRAkq4XntxyCkDO4WzDUg==
X-Received: by 2002:a2e:8eca:0:b0:2b6:fa92:479e with SMTP id e10-20020a2e8eca000000b002b6fa92479emr1418805ljl.42.1688649834567;
        Thu, 06 Jul 2023 06:23:54 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/20] selinux: avc: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:26 +0200
Message-Id: <20230706132337.15924-11-cgzones@googlemail.com>
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

Use a consistent type of u32 for sequence numbers.

Use a non-negative and input parameter matching type for the hash
result.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 1074db66e5ff..cd55479cce25 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -122,7 +122,7 @@ static struct kmem_cache *avc_xperms_data_cachep __ro_after_init;
 static struct kmem_cache *avc_xperms_decision_cachep __ro_after_init;
 static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
-static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
+static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
 	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
 }
@@ -523,7 +523,7 @@ static void avc_node_populate(struct avc_node *node, u32 ssid, u32 tsid, u16 tcl
 static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 {
 	struct avc_node *node, *ret = NULL;
-	int hvalue;
+	u32 hvalue;
 	struct hlist_head *head;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
@@ -566,7 +566,7 @@ static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass)
 	return NULL;
 }
 
-static int avc_latest_notif_update(int seqno, int is_insert)
+static int avc_latest_notif_update(u32 seqno, int is_insert)
 {
 	int ret = 0;
 	static DEFINE_SPINLOCK(notif_lock);
@@ -609,7 +609,7 @@ static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
 		       struct av_decision *avd, struct avc_xperms_node *xp_node)
 {
 	struct avc_node *pos, *node = NULL;
-	int hvalue;
+	u32 hvalue;
 	unsigned long flag;
 	spinlock_t *lock;
 	struct hlist_head *head;
@@ -654,9 +654,9 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
 	struct selinux_audit_data *sad = ad->selinux_audit_data;
-	u32 av = sad->audited;
+	u32 av = sad->audited, perm;
 	const char *const *perms;
-	int i, perm;
+	u32 i;
 
 	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
 
@@ -833,7 +833,8 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 			   struct extended_perms_decision *xpd,
 			   u32 flags)
 {
-	int hvalue, rc = 0;
+	u32 hvalue;
+	int rc = 0;
 	unsigned long flag;
 	struct avc_node *pos, *node, *orig = NULL;
 	struct hlist_head *head;
-- 
2.40.1

