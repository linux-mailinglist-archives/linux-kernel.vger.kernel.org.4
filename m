Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15803749D79
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGFNY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGFNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E31BF3;
        Thu,  6 Jul 2023 06:23:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1063203a12.1;
        Thu, 06 Jul 2023 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649835; x=1691241835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POQtj9EwL7vW/RtHnM490ckQa0bYDSbV6IRJYsU0nzA=;
        b=iyv3Q7TAJWpYkGBROZoecoTa2QBSNEXYY2XzcHjPuTq0Oilh6NK2w4NJyjZRRgtcuv
         YImNb7DZT89USAblfNtfugLx4+iw0Jx/pyaXtCep5LHfsqi99B3t+vuES0l+gx8WxoFF
         ocn+lVc2ziecSrEwac8/zshIA/aL3IPutZjvKW0Fak6UOIRW407pAlsurKMRX+DKlspe
         99lr8o/JynVMOD/8epVAFcCYfknwvtrcA6ZjiPXf8lFomPrEG5Gmf0rsKu0JcnALZoPj
         QVGFUZBFgqafYOO2xT8jZnoClhaaz3FTeP8drWgwNDg89dGHsawwif8dXavPJ6CSm3lj
         G4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649835; x=1691241835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POQtj9EwL7vW/RtHnM490ckQa0bYDSbV6IRJYsU0nzA=;
        b=J2CHvdFBsSPhrGYo2svcj0QcDsbHwJ3XLN+UqqzcuMa3exVOtNyvsuFDzZWTNAmt8i
         UWxlTt8rcpTygPBL+gcRCKf2bCnDDuxy0EUEgM4GsFSHRO+byI851IFxFMfS5yNjn6VG
         50yL7GZRYa3ltVDH+6EQtsoAyseUpniBkx3OZy5EE7rTjurnlKFAgXGS8TZnHDAtXZAf
         D2VsFtGWDYkVdkE2JDkVPZU7iUqJkXcDm0tvFicBcjii+e6EWiKAwl4+c+oIwLoc9B51
         K00h3vL9BLYkv8PctOgLfh0GO9Z6HKkrgCU7RZWr8oamMKHHKtPA7yeU9RofEVQ87PJx
         LtIA==
X-Gm-Message-State: ABy/qLYv5a0EaO8vFph3DFZ4NSlTJ6iLq3MlNKnJ5rLZ+EntnNuCpZE/
        S3de6NQyg2MTMmCkhcpc3ImqsgT/B9HmEdlF
X-Google-Smtp-Source: APBJJlGEQlOFfh1QyGyEvv8pBADn/VnYy3d2OqjwCtcSCGKwupeaDkcfHRazpcTrLC9VzRKH1Tn7XA==
X-Received: by 2002:a17:906:3c46:b0:98d:fc51:b3dd with SMTP id i6-20020a1709063c4600b0098dfc51b3ddmr1402524ejg.41.1688649835234;
        Thu, 06 Jul 2023 06:23:55 -0700 (PDT)
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
Subject: [RFC PATCH 12/20] selinux: hooks: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:27 +0200
Message-Id: <20230706132337.15924-12-cgzones@googlemail.com>
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

Use the identical types in assignments of local variables for the
destination.

Merge tail calls into return statements.

Avoid using leading underscores for function local variable.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8a8a4f0f2ad..fff50604abce 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1125,7 +1125,7 @@ static inline int default_protocol_dgram(int protocol)
 
 static inline u16 socket_type_to_security_class(int family, int type, int protocol)
 {
-	int extsockclass = selinux_policycap_extsockclass();
+	bool extsockclass = selinux_policycap_extsockclass();
 
 	switch (family) {
 	case PF_UNIX:
@@ -5027,15 +5027,13 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	int err;
+	int err, peerlbl_active, secmark_active;
 	struct sk_security_struct *sksec = sk->sk_security;
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	char *addrp;
-	u8 secmark_active;
-	u8 peerlbl_active;
 
 	if (family != PF_INET && family != PF_INET6)
 		return 0;
@@ -5498,11 +5496,11 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	const struct task_security_struct *__tsec;
+	const struct task_security_struct *tsec;
 	u32 tsid;
 
-	__tsec = selinux_cred(current_cred());
-	tsid = __tsec->sid;
+	tsec = selinux_cred(current_cred());
+	tsid = tsec->sid;
 
 	return avc_has_perm(tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO,
 			    NULL);
@@ -6000,8 +5998,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 
 static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 {
-	int err;
-	int perms;
+	u32 perms;
 
 	switch (cmd) {
 	case IPC_INFO:
@@ -6024,8 +6021,7 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 		return 0;
 	}
 
-	err = ipc_has_perm(msq, perms);
-	return err;
+	return ipc_has_perm(msq, perms);
 }
 
 static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *msg, int msqflg)
@@ -6130,8 +6126,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 /* Note, at this point, shp is locked down */
 static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
-	int perms;
-	int err;
+	u32 perms;
 
 	switch (cmd) {
 	case IPC_INFO:
@@ -6158,8 +6153,7 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 		return 0;
 	}
 
-	err = ipc_has_perm(shp, perms);
-	return err;
+	return ipc_has_perm(shp, perms);
 }
 
 static int selinux_shm_shmat(struct kern_ipc_perm *shp,
@@ -6928,7 +6922,7 @@ static int selinux_uring_override_creds(const struct cred *new)
  */
 static int selinux_uring_sqpoll(void)
 {
-	int sid = current_sid();
+	u32 sid = current_sid();
 
 	return avc_has_perm(sid, sid,
 			    SECCLASS_IO_URING, IO_URING__SQPOLL, NULL);
-- 
2.40.1

