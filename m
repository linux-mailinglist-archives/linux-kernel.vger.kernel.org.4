Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A966C0994
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCTEJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCTEJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:09:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2F4F77C;
        Sun, 19 Mar 2023 21:09:02 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K26hNV016868;
        Mon, 20 Mar 2023 04:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s29gtJQTaAQNRvDYuRNvJzZ7BnhQ4Zgr013/VoKrO9c=;
 b=WYr4tF0xT13DLWABqJJXAXm4FvhIA9kZKik9b+eq6nXvYhvHFtwBCkVT8MUANBdOlTn4
 lVe8MyKdfauuUhF1Z8ie+aua3So6SxBnYleATtiwxFLayyJdgeV5nffNTrIuupAr7+Fp
 2oNN9s/SYgEOwGhWyIHpIlQCv0PD2YagQ1xXYWdHAdLJ1bThHHncCVIjwoH+D2tAyiWq
 aXpyLUZluxYRsoFNCvb6yldC55G74vWPw7tbLqWid0+BsqZecxhqz3tCiNpZD4SDEPy3
 aMw0IPuRlhNvjKjNIq52llskSJ4N14nKGWuFI1RaPebd0z6fd+MHEmzx6ALG5lDHLKFk VQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdq3td5b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 04:09:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32JAgiZp015057;
        Mon, 20 Mar 2023 04:08:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pd4jfanak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 04:08:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32K48tfx58655028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 04:08:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDC442004B;
        Mon, 20 Mar 2023 04:08:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD32E20043;
        Mon, 20 Mar 2023 04:08:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 04:08:54 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E43F260463;
        Mon, 20 Mar 2023 15:08:49 +1100 (AEDT)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 2/2] initramfs: Encode dependency on KBUILD_BUILD_TIMESTAMP
Date:   Mon, 20 Mar 2023 15:08:39 +1100
Message-Id: <20230320040839.660475-2-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320040839.660475-1-bgray@linux.ibm.com>
References: <20230320040839.660475-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vCU-69eZaEcK3fy6V2LK7fPGhV3gncPE
X-Proofpoint-GUID: vCU-69eZaEcK3fy6V2LK7fPGhV3gncPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303200034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gen_initramfs.sh has an internal dependency on KBUILD_BUILD_TIMESTAMP
for generating file mtimes that is not exposed to make, so changing
KBUILD_BUILD_TIMESTAMP will not trigger a rebuild of the archive.

Declare the mtime date as a new parameter to gen_initramfs.sh to encode
KBUILD_BUILD_TIMESTAMP in the shell command, thereby making make aware
of the dependency.

It will rebuild if KBUILD_BUILD_TIMESTAMP changes or is newly set/unset.
It will _not_ rebuild if KBUILD_BUILD_TIMESTAMP is unset before and
after. This should be fine for anyone who doesn't care about setting
specific build times in the first place.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

---

Ran into this while debugging the issue in the first patch. Made for a
very perplexing debug session before we worked out the state wasn't
being rebuilt.
---
 usr/Makefile         |  2 ++
 usr/gen_initramfs.sh | 16 +++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/usr/Makefile b/usr/Makefile
index 59d9e8b07a01..2aa386cf48d6 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -64,6 +64,7 @@ quiet_cmd_initfs = GEN     $@
 	$(CONFIG_SHELL) $< -o $@ -l $(obj)/.initramfs_data.cpio.d \
 	$(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
 	$(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
+	$(if $(KBUILD_BUILD_TIMESTAMP), -d $(KBUILD_BUILD_TIMESTAMP)) \
 	$(ramfs-input)
 
 # We rebuild initramfs_data.cpio if:
@@ -71,6 +72,7 @@ quiet_cmd_initfs = GEN     $@
 # 2) There are changes in which files are included (added or deleted)
 # 3) If gen_init_cpio are newer than initramfs_data.cpio
 # 4) Arguments to gen_initramfs.sh changes
+# 5) KBUILD_BUILD_TIMESTAMP is changed
 $(obj)/initramfs_data.cpio: $(src)/gen_initramfs.sh $(obj)/gen_init_cpio $(deps_initramfs) FORCE
 	$(call if_changed,initfs)
 
diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 63476bb70b41..14b5782f961a 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -23,6 +23,7 @@ $0 [-o <file>] [-l <dep_list>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
 	-g <gid>       Group ID to map to group ID 0 (root).
 		       <gid> is only meaningful if <cpio_source> is a
 		       directory.  "squash" forces all files to gid 0.
+	-d <date>      Use date for all file mtime values
 	<cpio_source>  File list or directory for cpio archive.
 		       If <cpio_source> is a .cpio file it will be used
 		       as direct input to initramfs.
@@ -190,6 +191,7 @@ prog=$0
 root_uid=0
 root_gid=0
 dep_list=
+timestamp=
 cpio_list=$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
 output="/dev/stdout"
 
@@ -218,6 +220,13 @@ while [ $# -gt 0 ]; do
 			[ "$root_gid" = "-1" ] && root_gid=$(id -g || echo 0)
 			shift
 			;;
+		"-d")	# date for file mtimes
+			timestamp="$(date -d"$1" +%s || :)"
+			if test -n "$timestamp"; then
+				timestamp="-t $timestamp"
+			fi
+			shift
+			;;
 		"-h")
 			usage
 			exit 0
@@ -237,11 +246,4 @@ done
 
 # If output_file is set we will generate cpio archive
 # we are careful to delete tmp files
-timestamp=
-if test -n "$KBUILD_BUILD_TIMESTAMP"; then
-	timestamp="$(date -d"$KBUILD_BUILD_TIMESTAMP" +%s || :)"
-	if test -n "$timestamp"; then
-		timestamp="-t $timestamp"
-	fi
-fi
 usr/gen_init_cpio $timestamp $cpio_list > $output
-- 
2.39.2

