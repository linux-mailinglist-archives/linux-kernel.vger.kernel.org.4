Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C864B34E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiLMKhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiLMKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:37:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6F1057F;
        Tue, 13 Dec 2022 02:37:29 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD8tTlx019096;
        Tue, 13 Dec 2022 10:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=h7RK8T8taq4CuuKj6hSyg+dTmQ/jogpwEizyJ2NFvGI=;
 b=cmqo4/+ZCbpYH0CXwKvrXfybauC4hmFK6p8P9pFpyrmi233dpPJsodPwUM705sWhHB6C
 Ii0709X20I/Ws84cBf0WNSwf57ycwjwVe764oK95RtNfhCy5NzvGbJaNpj1/w4kmT8jb
 4/Bxvzj38JN/pE5unVgEUHVPCYn53kcI+9H9gpIKqSxbfnj+QCUSH3QpM1CtL4QB26dj
 jzmcAIivGdn0BhBAyesKREHhaTaR0QfzUMsOktzhb3MndMLtqANyJmCOVvu91Y7KSc2W
 Ev9aaC6zAHQbWEiOelHow1tinoIbBoRtQ5NPZ3sMAF2Q/i7wvgoWtSJV0OlIGJE8YQmL lQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mepafja16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 10:37:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD59Gt0007817;
        Tue, 13 Dec 2022 10:37:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mchcf41dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 10:37:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDAbKkG44761514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 10:37:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA08D20040;
        Tue, 13 Dec 2022 10:37:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70F3E20043;
        Tue, 13 Dec 2022 10:37:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 10:37:20 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2] perf/test: Fix perf test 84 on s390
Date:   Tue, 13 Dec 2022 11:37:07 +0100
Message-Id: <20221213103708.1287991-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ck7vl8d7AibfyzdnW-f6iHV80dJdSS76
X-Proofpoint-ORIG-GUID: ck7vl8d7AibfyzdnW-f6iHV80dJdSS76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212130089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test '84: probe libc's inet_pton & backtrace it with ping'
fails on s390. Debugging revealed a changed stack trace for the
ping command using probes:

ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
                  13e7c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
          --->    104371 text_to_binary_address+0xef1 (inlined)
                  104371 gaih_inet+0xef1 (inlined)
                  104371 __GI_getaddrinfo+0xef1 (inlined)
                    5d4b main+0x139b (/usr/bin/ping)

The line ---> text_to_binary_address ...
is new. It was introduced with glibc version 2.36.7.2 released
with Fedora 37 for s390.

Output before
 # ./perf test 84
 84: probe libc's inet_pton & backtrace it with ping   : FAILED!
 #

Output after:
 # ./perf test 84
 84: probe libc's inet_pton & backtrace it with ping   : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index f12a4e217968..0f01c62cbee9 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -37,6 +37,7 @@ trace_libc_inet_pton_backtrace() {
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
+		echo "text_to_binary_address.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
-- 
2.38.1

