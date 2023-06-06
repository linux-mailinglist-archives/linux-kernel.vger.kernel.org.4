Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEEA72376A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjFFGSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFFGSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92F187;
        Mon,  5 Jun 2023 23:18:04 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3566H60N032011;
        Tue, 6 Jun 2023 06:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vZKW3V+0ehn9Nx7MGBRdIeAM1+u3OGaDAoTtyJ/yuDI=;
 b=o0l3PEtn0TRbo3Px0JDtLBBOwKHe+ibG4peS64A/M/dEMRy5zZ8L6QFBBuSXeu2PvryH
 JXBOMaSkEpp/jRBC9o/IZA6lU+S5bEJ01G+gS3J4sr5HUpmrgpG1QAPKoopOWirA4JP7
 VECUjABgspl6ZOWIT/SbON7RkiSyUeqqNRCxQfo+Mx2VSP3JQb1bH9vgU3Ygf35BrdyL
 neYXaxqvoNbchZSo4Liyf3rOXTcWXmzWiX4d1je6WlvwhyUzJrYtuKpr5kO9w1IeMKJP
 6o2icMZapJvd1aL9zYKsPWCyRwdoqjp1Ow5staf/gxuDI1flEXp0GAcidwnfH4k/v1tc 6g== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1ycyg0ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 06:18:01 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3560fmP3032090;
        Tue, 6 Jun 2023 06:17:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qyxdfhde5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 06:17:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3566HuDV45613512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jun 2023 06:17:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92EBE2004B;
        Tue,  6 Jun 2023 06:17:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D5AB20040;
        Tue,  6 Jun 2023 06:17:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jun 2023 06:17:56 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7F39D600E2;
        Tue,  6 Jun 2023 16:17:54 +1000 (AEST)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Benjamin Gray <bgray@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH v2] initramfs: Encode dependency on KBUILD_BUILD_TIMESTAMP
Date:   Tue,  6 Jun 2023 16:17:41 +1000
Message-Id: <20230606061741.69755-1-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fh-NLYIatZnQMwJJ_2tsz0NikhP-9Q76
X-Proofpoint-ORIG-GUID: fh-NLYIatZnQMwJJ_2tsz0NikhP-9Q76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_03,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Tested-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

---

v2: Remove redundant comment, quote argument to shell script
---
 usr/Makefile         |  1 +
 usr/gen_initramfs.sh | 16 +++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/usr/Makefile b/usr/Makefile
index 59d9e8b07a01..f8e1ad19e05c 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -64,6 +64,7 @@ quiet_cmd_initfs = GEN     $@
 	$(CONFIG_SHELL) $< -o $@ -l $(obj)/.initramfs_data.cpio.d \
 	$(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
 	$(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
+	$(if $(KBUILD_BUILD_TIMESTAMP), -d "$(KBUILD_BUILD_TIMESTAMP)") \
 	$(ramfs-input)
 
 # We rebuild initramfs_data.cpio if:
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
2.40.1

