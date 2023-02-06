Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5267C68BF83
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjBFOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjBFOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:04:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E394526D;
        Mon,  6 Feb 2023 06:04:05 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqKKM014632;
        Mon, 6 Feb 2023 14:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=B8AZACvhItDb8czZLNhsLMLRUnUga5mRTGoRMSK5flA=;
 b=PDRKXMzCtZnRtVb3dQ+TRgyO+2kP3TGT10LCDeJG7lUFtV11OidAUnnwEJE+OOu8crU3
 +Nl+wZks6KBGII732+XbbVMlWvNRUN/s/OCKfvYTQMYZkTRAHK2X+YjmHRsdwu1n7qQZ
 z9qQZZn3Sat/t5A5g3qs5kI4ZyXEaaf6cYd4oRZxAGMDSGYhYGnZerPcInz7XqwhdF0i
 lnufXfDVYUQLUJkyxM05HAAc5mpp3sT57mIBJTAQr4tghTIrmTZaR++3wC+2wmPAueM/
 uO9/jZ8rtVUjhKknI7S+t0ShN31YWu1GgSAyokVTs1mn2bXZzZtbVJDl0W6wH8zRpdb6 tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1gkk4eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:44 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DqbsI016485;
        Mon, 6 Feb 2023 14:03:43 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1gkk4d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CBKtk001165;
        Mon, 6 Feb 2023 14:03:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3nhf072ykt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3eCj25821796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CC7E5805D;
        Mon,  6 Feb 2023 14:03:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A59458059;
        Mon,  6 Feb 2023 14:03:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:38 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v15 19/26] ima: Namespace audit status flags
Date:   Mon,  6 Feb 2023 09:02:46 -0500
Message-Id: <20230206140253.3755945-20-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _R_FLHmJzf7e9vTdWm6U7XJztnkOjK5O
X-Proofpoint-GUID: oJ7EUbRiM3XEYOo4tOyCIXe-qBqijgwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

The iint cache stores whether the file is measured, appraised, audited
etc. This patch moves the IMA_AUDIT and IMA_AUDITED flags into the
per-namespace ns_status, enabling IMA audit mechanism to audit the same
file each time it is accessed in a new namespace.

Read and write operations on the iint flags is replaced with function
calls. For reading, iint_flags() returns the bitwise OR of iint->flags
and ns_status->flags. The ns_status flags are masked with
IMA_NS_STATUS_FLAGS (currently only IMA_AUDIT & IMA_AUDITED) while the
iint flags are masked with ~IMA_NS_STATUS_FLAGS. Similarly,
set_iint_flags() writes the one masked portion to the ns_status flags,
while the iint flags receive the remaining flags. The ns_status
parameter added to ima_audit_measurement() is used with the above
functions to query and set the ns_status flags.

Replace all occurrences where the IMA_AUDITED flag is set with the
iint_flags() and set_iint_flags() operations so that the splitting
and merging of the flags works properly. Whenever the IMA_AUDITED flag is
tested, use iint_flags() to receive the merged version of the flags.

Since IMA_AUDITED is also part of the IMA_DONE_MASK, use the new
functions wherever the IMA_DONE_MASK is involved.

Move the IMA_AUDIT flag also into the ns_status flags since this flag
is dependent on policy rules that may be different per namespace.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v9:
 - Use ns_status also in non-namespaced case and use same flag splitting
   for namespaced and non-namespaced case, thus use one implementation
   for iint_flags() and set_iint_flags()
 - Merge-in patch 'Enable re-auditing of modified files'
 - Use one implementation of mask_iint_ns_status_flags() for namespaced
   and non-namespaced case
 - Added IMA_AUDIT to IMA_NS_STATUS_FLAGS since it's a per namespace flag
---
 security/integrity/ima/ima.h      | 40 ++++++++++++++++++++--
 security/integrity/ima/ima_api.c  |  8 +++--
 security/integrity/ima/ima_main.c | 56 ++++++++++++++++++++++++++-----
 security/integrity/integrity.h    |  3 ++
 4 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3206d8cb8ca4..4ac937c2c039 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -314,7 +314,8 @@ int process_buffer_measurement(struct ima_namespace *ns,
 			       int pcr, const char *func_data,
 			       bool buf_hash, u8 *digest, size_t digest_len);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename);
+			   const unsigned char *filename,
+			   struct ns_status *ns_status);
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry,
 			    struct ima_template_desc *template_desc);
@@ -498,6 +499,34 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
 
+#define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
+#define IMA_NS_STATUS_FLAGS     (IMA_AUDIT | IMA_AUDITED)
+
+static inline unsigned long iint_flags(struct integrity_iint_cache *iint,
+				       struct ns_status *ns_status)
+{
+	if (!ns_status)
+		return iint->flags;
+
+	return (iint->flags & ~IMA_NS_STATUS_FLAGS) |
+	       (ns_status->flags & IMA_NS_STATUS_FLAGS);
+}
+
+static inline unsigned long set_iint_flags(struct integrity_iint_cache *iint,
+					   struct ns_status *ns_status,
+					   unsigned long flags)
+{
+	unsigned long ns_status_flags = flags & IMA_NS_STATUS_FLAGS;
+
+	WARN_ON(!ns_status && ns_status_flags);
+
+	iint->flags = flags & ~IMA_NS_STATUS_FLAGS;
+	if (ns_status)
+		ns_status->flags = ns_status_flags;
+
+	return flags;
+}
+
 static inline
 struct user_namespace *ima_user_ns_from_file(const struct file *filp)
 {
@@ -535,7 +564,14 @@ static inline struct ns_status *ima_get_ns_status
 					 struct inode *inode,
 					 struct integrity_iint_cache *iint)
 {
-	return NULL;
+	struct ns_status *ns_status = &iint->ns_status;
+
+	if (list_empty(&iint->ns_list)) {
+		ns_status_init(ns_status);
+		list_add(&ns_status->ns_next, &iint->ns_list);
+	}
+
+	return ns_status;
 }
 
 #endif /* CONFIG_IMA_NS */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 5ea55d172b44..6ca68f6cce01 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -387,14 +387,16 @@ void ima_store_measurement(struct ima_namespace *ns,
 }
 
 void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename)
+			   const unsigned char *filename,
+			   struct ns_status *ns_status)
 {
 	struct audit_buffer *ab;
 	char *hash;
 	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
 	int i;
+	unsigned long flags = iint_flags(iint, ns_status);
 
-	if (iint->flags & IMA_AUDITED)
+	if (flags & IMA_AUDITED)
 		return;
 
 	hash = kzalloc((iint->ima_hash->length * 2) + 1, GFP_KERNEL);
@@ -417,7 +419,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 	audit_log_task_info(ab);
 	audit_log_end(ab);
 
-	iint->flags |= IMA_AUDITED;
+	set_iint_flags(iint, ns_status, flags | IMA_AUDITED);
 out:
 	kfree(hash);
 	return;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 55ddf2c8506a..7908acd57e9f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -149,6 +149,31 @@ static void ima_rdwr_violation_check(struct ima_namespace *ns,
 				  "invalid_pcr", "open_writers");
 }
 
+static void mask_iint_ns_status_flags(struct integrity_iint_cache *iint,
+				      unsigned long mask)
+{
+	struct ns_status *ns_status;
+	unsigned long flags;
+
+	read_lock(&iint->ns_list_lock);
+	if (list_empty(&iint->ns_list)) {
+		/*
+		 * An empty list is possible due to __process_measurement only
+		 * creating ns_status for IMA_NS_STATUS_ACTIONS.
+		 * No ns_status being used implies that for example IMA_AUDIT
+		 * was never used and thus IMA_AUDITED cannot have been set.
+		 */
+		flags = iint_flags(iint, NULL) & mask;
+		set_iint_flags(iint, NULL, flags);
+	} else {
+		list_for_each_entry(ns_status, &iint->ns_list, ns_next) {
+			flags = iint_flags(iint, ns_status) & mask;
+			set_iint_flags(iint, ns_status, flags);
+		}
+	}
+	read_unlock(&iint->ns_list_lock);
+}
+
 static void ima_check_last_writer(struct integrity_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
@@ -165,8 +190,11 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 		if (!IS_I_VERSION(inode) ||
 		    !inode_eq_iversion(inode, iint->version) ||
 		    (iint->flags & IMA_NEW_FILE)) {
-			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
+			mask_iint_ns_status_flags
+					(iint,
+					 ~(IMA_DONE_MASK | IMA_NEW_FILE));
 			iint->measured_pcrs = 0;
+
 			if (update)
 				ima_update_xattr(iint, file);
 		}
@@ -203,6 +231,7 @@ static int __process_measurement(struct ima_namespace *ns,
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
+	struct ns_status *ns_status = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
@@ -215,6 +244,7 @@ static int __process_measurement(struct ima_namespace *ns,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	unsigned long flags;
 
 	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -243,6 +273,14 @@ static int __process_measurement(struct ima_namespace *ns,
 		iint = integrity_inode_get(inode);
 		if (!iint)
 			rc = -ENOMEM;
+
+		if (!rc && (action & IMA_NS_STATUS_ACTIONS)) {
+			ns_status = ima_get_ns_status(ns, inode, iint);
+			if (IS_ERR(ns_status)) {
+				rc = PTR_ERR(ns_status);
+				ns_status = NULL;
+			}
+		}
 	}
 
 	if (!rc && violation_check)
@@ -258,11 +296,13 @@ static int __process_measurement(struct ima_namespace *ns,
 
 	mutex_lock(&iint->mutex);
 
+	flags = iint_flags(iint, ns_status);
+
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
 		/* reset appraisal flags if ima_inode_post_setattr was called */
-		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
-				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
-				 IMA_NONACTION_FLAGS);
+		flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
+			   IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
+			   IMA_NONACTION_FLAGS);
 
 	/*
 	 * Re-evaulate the file if either the xattr has changed or the
@@ -273,7 +313,7 @@ static int __process_measurement(struct ima_namespace *ns,
 	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
 	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
 	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
-		iint->flags &= ~IMA_DONE_MASK;
+		flags &= ~IMA_DONE_MASK;
 		iint->measured_pcrs = 0;
 	}
 
@@ -281,9 +321,9 @@ static int __process_measurement(struct ima_namespace *ns,
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
 	 */
-	iint->flags |= action;
+	flags = set_iint_flags(iint, ns_status, flags | action);
 	action &= IMA_DO_MASK;
-	action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
+	action &= ~((flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
 
 	/* If target pcr is already measured, unset IMA_MEASURE action */
 	if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
@@ -360,7 +400,7 @@ static int __process_measurement(struct ima_namespace *ns,
 						  &pathname, filename);
 	}
 	if (action & IMA_AUDIT)
-		ima_audit_measurement(iint, pathname);
+		ima_audit_measurement(iint, pathname, ns_status);
 
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc = 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 112836d9b33a..50a5d94593e1 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -204,6 +204,9 @@ struct integrity_iint_cache {
 	 */
 	rwlock_t ns_list_lock;
 	struct list_head ns_list;
+#ifndef CONFIG_IMA_NS
+	struct ns_status ns_status;
+#endif
 };
 
 /* rbtree tree calls to lookup, insert, delete
-- 
2.37.3

