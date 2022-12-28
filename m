Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C03657919
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiL1O5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiL1O52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:57:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1680120B4;
        Wed, 28 Dec 2022 06:57:25 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSCMHAJ008660;
        Wed, 28 Dec 2022 14:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/Rw5FdGe2i4qT4kYjSNPWFvOI7r+yUD4ZZsKmKmPAsE=;
 b=IiHE7lfBn/ZBtr5a2JCjV+7o+a81ZStJ0KR/jwFxp80md6mnCbUqJgDcPnKWXEyzHEUw
 DLqRgg308FG7HF4FiLLnd/k0jknBUVBD2shbo7VhxdSYVQA4Vq2BU8L16b8QPaXcBZIY
 ZhCJq0BpGcciK+ndJgno5ydHfrz90LMqMnZn7mZEcJQpHeNJtWDyK+d3YfzKXo2livQL
 ekwm9N362mzI8JCGvIOqcfA4kFnQcG4TlAK52e6Xbj2S7PAVgqHZLIVNQhjV4Xmxe+lm
 96uxDQJutvTivlITmJDqPz8oSP7LZMHcSvGP8xaqFtYO0pAigwW1pf/vFAMyGc1KsTPJ Sw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mramv6ae5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 14:57:17 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRNHJ6g023280;
        Wed, 28 Dec 2022 14:57:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mns26uxp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 14:57:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BSEvAZq45678904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Dec 2022 14:57:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C898620040;
        Wed, 28 Dec 2022 14:57:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DF3E20043;
        Wed, 28 Dec 2022 14:57:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Dec 2022 14:57:10 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <richter@de.ibm.com>
Subject: [PATCH v2 2/2] perf/test: Fix test case 89 for x86
Date:   Wed, 28 Dec 2022 15:57:04 +0100
Message-Id: <20221228145704.2702487-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228145704.2702487-1-tmricht@linux.ibm.com>
References: <20221228145704.2702487-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fKvMkCmmi03kKFR4a858b-az1ZhbU1i2
X-Proofpoint-GUID: fKvMkCmmi03kKFR4a858b-az1ZhbU1i2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_12,2022-12-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212280124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <richter@de.ibm.com>

perf test '89: probe libc's inet_pton & backtrace it with ping'
fails on x86. Debugging revealed a changed stack trace for the
ping command using probes:

ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
                  12be50 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
                  4fca main+0x139b (/usr/bin/ping)

The line getaddrinfo.... in the call stack is gone.
It was introduced with glibc version 2.36.8 released
with Fedora 37.

To make the test case more robust to glibc changes resulting in changed
call stacks, redesign the test completely.
Read the output lines from the perf probe of the ping command.
Create an array of expected patterns. Each array entry specifies a
pattern that may appear in the perf probe output.
Check that each probe output line is matched in the expected
patterns array. If there is no match it is an error.
However not every pattern in the expected pattern array must be hit
as there may be redundant entries.

This scheme does not test the sequence of the call stack entries
but the patterns itself are long and complicated enough.
Also each perf probe output line has to be in the expected pattern
array for the test to pass

Output before on x86
 # ./perf test 89
 89: probe libc's inet_pton & backtrace it with ping   : FAILED!
 #

Output after on x86
 # ./perf test 89
 89: probe libc's inet_pton & backtrace it with ping   : Ok
 #

Signed-off-by: Thomas Richter <richter@de.ibm.com>
---
 .../shell/record+probe_libc_inet_pton.sh      | 70 +++++++++++++------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 4e9de55d871a..3baef1aa92f5 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -30,28 +30,37 @@ add_libc_inet_pton_event() {
 
 trace_libc_inet_pton_backtrace() {
 
-	expected=`mktemp -u /tmp/expected.XXX`
+	declare -a expected
+	local -i idx=0 hit maxstack=4
 
-	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
-	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+	expected[0]='ping[][0-9 \.:]+'"$event_name"': \([[:xdigit:]]+\)'
+	expected[1]='.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'|inlined\)$'
 	case "$(uname -m)" in
 	s390x)
-		eventattr='call-graph=dwarf,max-stack=4'
-		echo "text_to_binary_address.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
-		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
-		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
-		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		eventattr='call-graph=dwarf,max-stack='"$maxstack"
+		expected[2]='text_to_binary_address.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'
+		expected[3]='gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'|inlined\)$'
+		expected[4]='(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'|inlined\)$'
+		expected[5]='main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$'
 		;;
 	ppc64|ppc64le)
-		eventattr='max-stack=4'
-		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		eventattr='max-stack='"$maxstack"
+		expected[2]='gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'\)$'
+		expected[3]='getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'\)$'
+		# Line valid with glibc 2.35.x with fedora 36
+		expected[4]='.*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$'
+		# New line introduced with glibc 2.36.x with fedora 37, replaces previous line
+		expected[5]='[[:xdigit:]]+[[:space:]](\[unknown\]|main)\+0x[[:xdigit:]]+.*\(.*/bin/ping.*\)$'
 		;;
 	*)
-		eventattr='max-stack=3'
-		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		maxstack=3
+		eventattr='max-stack='"$maxstack"
+		expected[2]='getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'\)$'
+		# Line valid with glibc 2.35.x with fedora 36
+		expected[3]='.*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$'
+		# New lines introduced with glibc 2.36.x with fedora 37, replaces previous line
+		expected[4]='[[:xdigit:]]+[[:space:]](\[unknown\]|main)\+0x[[:xdigit:]]+.*\(.*/bin/ping.*\)$'
+		expected[5]='.*main\+0x[[:xdigit:]]+.*\('"$libc"'\)$'
 		;;
 	esac
 
@@ -60,16 +69,31 @@ trace_libc_inet_pton_backtrace() {
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
 	perf script -i $perf_data > $perf_script
 
+	# To make the call stack checking more robust to changes in the glibc
+	# just check that each probe output line appears in the expected
+	# patterns array.
+	# This scheme does not check the sequence as before but tests
+	# that every line in the call stack is expected. Considering the
+	# long patterns this should be save too.
 	exec 3<$perf_script
-	exec 4<$expected
-	while read line <&3 && read -r pattern <&4; do
-		[ -z "$pattern" ] && break
-		echo $line
-		echo "$line" | grep -E -q "$pattern"
-		if [ $? -ne 0 ] ; then
-			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
+
+	# Number of input lines to check, take value from max-stack attribute
+	while read line <&3; do
+		[ "$idx" -ge "$maxstack" ] && break
+		[ -z "$line" ] && break
+
+		hit=0
+		for pattern in "${expected[@]}"
+		do
+			echo "$line" | egrep -q "$pattern"
+			[ $? -eq 0 ] && { hit=1; break; }
+		done
+		if [ "$hit" -eq 0 ]
+		then
+			printf "FAIL: missing backtrace entry for line \"%s\"\n" "$line"
 			return 1
 		fi
+		((++idx))
 	done
 
 	# If any statements are executed from this point onwards,
@@ -92,6 +116,6 @@ skip_if_no_perf_probe && \
 add_libc_inet_pton_event && \
 trace_libc_inet_pton_backtrace
 err=$?
-rm -f ${perf_data} ${perf_script} ${expected}
+rm -f ${perf_data} ${perf_script}
 delete_libc_inet_pton_event
 exit $err
-- 
2.38.1

