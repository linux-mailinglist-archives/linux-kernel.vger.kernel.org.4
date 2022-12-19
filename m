Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734B46508D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 09:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiLSIus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 03:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiLSIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:50:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A5DEDE;
        Mon, 19 Dec 2022 00:49:57 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ8jGg3002009;
        Mon, 19 Dec 2022 08:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zuYByMNWVB12KJ6JEVEmhnxANtFVEIDRrd2WDawWei8=;
 b=e7fd0Siq1YtyutVWzsyFIIzT+/MnhqltJosTI6q0BVy/D5XPxGhtEf+HaDIcbB45JGnm
 zynwxXRAS0ZHMJf6VW0o0erDHIYFj8poc+lZuDh9834aphI3YTYtscdF0CgTJS32SZX/
 Eqsb0rcx7RTWRVkaSCLAAZcr18iFVakqJoFK3d1X9RCKe9+G52x/5B4TGW9JSGKo+b0V
 KJvzmki5ZQ6Lh+WTvU9kPoMobxEzczEmKDO8j+S83j1yol9zGgSsVp7kf+zcvHM3dtih
 vrnvzyFIH5Y5hMhWDU0F5gb2VcMjUr/7jVzTkCCjTlAXq5Ies76OWwz7YoJtd7cv2oJ5 ug== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjmqp02gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 08:49:52 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ2uada011246;
        Mon, 19 Dec 2022 08:49:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mh6yw1jgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 08:49:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJ8nkBB48038258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 08:49:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A233D20043;
        Mon, 19 Dec 2022 08:49:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55A2820040;
        Mon, 19 Dec 2022 08:49:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 08:49:46 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, gor@linux.ibm.com, sandipan.das@amd.com,
        sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3 2/2] perf/test: Fix test case 89 for x86
Date:   Mon, 19 Dec 2022 09:49:33 +0100
Message-Id: <20221219084933.3560216-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219084933.3560216-1-tmricht@linux.ibm.com>
References: <20221219084933.3560216-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W_7zJzVItE0vJ696mAAkehqSs_wlWM7-
X-Proofpoint-GUID: W_7zJzVItE0vJ696mAAkehqSs_wlWM7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-18_13,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
call stack, redesign the test completely.
Read the output lines from the perf probe of the ping command.
Create an array of expected patterns. Each array entry specifies a
pattern that may appear in the perf probe output.
Check that each probe output line is matched in the expected
patterns array. If there is no match it is an error.
However not every pattern in the expected pattern array must be hit
as there may be redundant entries.

This scheme does not test the sequence of the call stack but the
patterns itself are long and complicated enough. This should be
ok.

Output before on x86
 # ./perf test 89
 89: probe libc's inet_pton & backtrace it with ping   : FAILED!
 #

Output after on x86
 # ./perf test 89
 89: probe libc's inet_pton & backtrace it with ping   : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 .../shell/record+probe_libc_inet_pton.sh      | 70 +++++++++++++------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 0f01c62cbee9..5b424be76716 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -30,28 +30,36 @@ add_libc_inet_pton_event() {
 
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
+		# New line introduced with glibc 2.36.x with fedora 37, replaces previous line
+		expected[4]='[[:xdigit:]]+[[:space:]](\[unknown\]|main)\+0x[[:xdigit:]]+.*\(.*/bin/ping.*\)$'
 		;;
 	esac
 
@@ -60,16 +68,34 @@ trace_libc_inet_pton_backtrace() {
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
-		echo "$line" | egrep -q "$pattern"
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
+			# echo PATTERN "$pattern"
+			echo "$line" | egrep -q "$pattern"
+			[ $? -eq 0 ] && { hit=1; break; }
+		done
+		if [ "$hit" -eq 1 ]
+		then
+			printf "HIT: \"%s\"\n" "$line"
+		else
+			printf "FAIL: missing backtrace entry for line \"%s\"\n" "$line"
 			return 1
 		fi
+		((++idx))
 	done
 
 	# If any statements are executed from this point onwards,
-- 
2.38.1

