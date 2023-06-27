Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50B73F8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjF0J07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjF0J0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:26:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583219A8;
        Tue, 27 Jun 2023 02:26:52 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R9PKQ9005824;
        Tue, 27 Jun 2023 09:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rmtHEQvElFnOaqzt2Bdg2pmC8IvPaNV2o+NWS6XdJIo=;
 b=M9ssyCAoxEhAUdhsBKTmPs9gcBifY0qXzHES5nYtlCWFzz15BJgpllrpRLwvRzAGppd/
 jdZh/1ucpyiDYMmWUEQAzwAEiej5Ngya5GGnl+yYInCpOypBLLwnBb+SucQTu40l28yI
 Y0s9FCU+XF6km6t2chePTct3fHIHAJZuy5VynCJsBD6tB+q/i7xgr3HtWlAJf0pdA699
 RkJF4ttW3Vw2i+Ewa39CsGRdFlKqZjOI59J1wL5KTIhXOszVg0eN6AWYATpw1CWwZcul
 cMiKUHZjDO2tM/WSFZBkncxyBC7kPfoTIkfUIQB4UvKQol6DHAZpFOlSu/XfBo6Wd923 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw4680t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:26:49 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R9PI6c005241;
        Tue, 27 Jun 2023 09:26:49 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw4680su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:26:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R2n9Kt001450;
        Tue, 27 Jun 2023 09:26:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr451rdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:26:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35R9QhNQ39387480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 09:26:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7535A2004B;
        Tue, 27 Jun 2023 09:26:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C5E620043;
        Tue, 27 Jun 2023 09:26:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jun 2023 09:26:43 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, hca@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: perf test case Daemon operations dumps core
Date:   Tue, 27 Jun 2023 11:26:33 +0200
Message-Id: <20230627092633.2135105-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sGWoQyU7VxmytPHsl3toxfPRwyeLSuJA
X-Proofpoint-GUID: zvnrrGrPPiZZVDFKANmkAiAXwUxKRThp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf test case Daemon operations dumps core all the time.
I narrowed it down to this invocation:

Segmentation fault (core dumped)
....
(gdb) where
    at builtin-daemon.c:1527
    argv=0x3ffe66f9630) at perf.c:323
    at perf.c:377
    at perf.c:421
(gdb)

Normally this goes unnoticed, the core dumps are only shown in
verbose mode and when core dump generation is enabled on fedora 38:

 # ./perf test daemon
 80: daemon operations                   : Ok
 # ll core*
-rw------- 1 root root 3551232 Jun 27 10:08 core.4586
-rw------- 1 root root 3551232 Jun 27 10:08 core.4688
-rw------- 1 root root 3551232 Jun 27 10:08 core.4812
-rw------- 1 root root 3551232 Jun 27 10:08 core.4857
-rw------- 1 root root 3551232 Jun 27 10:08 core.4893
-rw------- 1 root root 3551232 Jun 27 10:08 core.4933
-rw------- 1 root root 3551232 Jun 27 10:08 core.4947
-rw------- 1 root root 3551232 Jun 27 10:08 core.4949
 # ./perf test -v daemon
 80: daemon operations                  :
--- start ---
test child forked, pid 4974
test daemon list
./tests/shell/daemon.sh: line 133:  4980 Segmentation fault \
		(core dumped) perf daemon start --config ${config}
test daemon reconfig
./tests/shell/daemon.sh: line 133:  5082 Segmentation fault \
		(core dumped) perf daemon start --config ${config}
test daemon stop
./tests/shell/daemon.sh: line 133:  5206 Segmentation fault \
		(core dumped) perf daemon start --config ${config}
test daemon signal
./tests/shell/daemon.sh: line 133:  5250 Segmentation fault \
		(core dumped) perf daemon start --config ${config}
signal 12 sent to session 'test [5252]'
signal 12 sent to session 'test [5252]'
test daemon ping
./tests/shell/daemon.sh: line 133:  5286 Segmentation fault \
		(core dumped) perf daemon start --config ${config}
test daemon lock
./tests/shell/daemon.sh: line 133:  5326 Segmentation fault \
		(core dumped) perf daemon start --config ${config}
test child finished with 0
---- end ----
daemon operations: Ok
 # ll core*|wc -l
16
 #

The root cause is in function cmd_daemon():

    argc = parse_options(argc, argv, daemon_options, daemon_usage,
		         PARSE_OPT_STOP_AT_NON_OPTION);

    if (argc) {
	if (!strcmp(argv[0], "start"))
		ret = __cmd_start(&__daemon, daemon_options, argc,
				  argv);
	if (!strcmp(argv[0], "signal"))
		    ^^^^^^^
Parameter argv[0] is set to NULL in function __cmd_start() and the
next strcmp() accesses a NULL pointer.

Output after:

 # ./perf daemon start --config /tmp/perf-daemon-config
 #
 # ./perf test -v daemon
 80: daemon operations                                               :
--- start ---
test child forked, pid 6517
test daemon list
test daemon reconfig
test daemon stop
test daemon signal
signal 12 sent to session 'test [6780]'
signal 12 sent to session 'test [6780]'
test daemon ping
test daemon lock
test child finished with 0
---- end ----
daemon operations: Ok
 #

Fixes: 92294b906e6c ("perf daemon: Dynamically allocate path to perf")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index f5674d824a40..83954af36753 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1524,7 +1524,7 @@ int cmd_daemon(int argc, const char **argv)
 	if (argc) {
 		if (!strcmp(argv[0], "start"))
 			ret = __cmd_start(&__daemon, daemon_options, argc, argv);
-		if (!strcmp(argv[0], "signal"))
+		else if (!strcmp(argv[0], "signal"))
 			ret = __cmd_signal(&__daemon, daemon_options, argc, argv);
 		else if (!strcmp(argv[0], "stop"))
 			ret = __cmd_stop(&__daemon, daemon_options, argc, argv);
-- 
2.41.0

