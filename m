Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F16FC7C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEINTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjEINTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:19:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D126AD;
        Tue,  9 May 2023 06:19:05 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349DA36l005056;
        Tue, 9 May 2023 13:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=XEH3nBB8VPNk1hip/0tDBrjO5m1Jjx8aKaWPX0Ovbh8=;
 b=ER7xAWBZ/7Kn05m08G9fSGnpxD4DblgA1NYY8ixs+5FC+ggbaOSVO2HMZL010yfIrGrt
 ocmxijt3P5dVvxzytWyeG/9mjuLD7mBRcflCyQgujCIObhrNlD6c3nvjut7Dg/M+tHXa
 VJyopy1TtDOdCj9rR5Qh0+G8kAFg1Dd1O+9exjtL38aaQ0n3fISiV87kV8y9lkVBtaHo
 LI9lCsdaqszwf7QdSFPKWXgctuD1xhYIMTG6Va46RIcDmzLTz5ShYKMEpAp4kIEfUKW2
 tK4FxnKrho+IPSYfR8oQplmX4Bdsqv1NPseDwpv+bx9rrnUfLGNMjUmJEfwPX5iF1Qsf Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfpa61jgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 13:18:59 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 349DAFak005772;
        Tue, 9 May 2023 13:18:59 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfpa61jfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 13:18:59 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 348Na7nV030769;
        Tue, 9 May 2023 13:18:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qf84e8f3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 13:18:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 349DIprL54460772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 May 2023 13:18:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF1412007A;
        Tue,  9 May 2023 13:18:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91FBA20078;
        Tue,  9 May 2023 13:18:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  9 May 2023 13:18:51 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, leo.yan@linaro.org, irogers@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: reduce run time of perf test Test java symbol
Date:   Tue,  9 May 2023 15:18:47 +0200
Message-Id: <20230509131847.835974-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rjiuW1ce2WILyuQvif_rW9fhxCWyDR8j
X-Proofpoint-ORIG-GUID: C-9LWF3gHB2CKGH-jQUSjVJZMutB5TSr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test case Test java symbol might run a long time. On Fedora 38 the
run time is very, very long:

 Output before:
 # time ./perf test 108
 108: Test java symbol                  : Ok
 real   22m15.775s
 user   3m42.584s
 sys    4m30.685s
 #

The reason is a lookup for the server for debug symbols as shown in
 # cat /etc/debuginfod/elfutils.urls
 https://debuginfod.fedoraproject.org/
 #
This lookup is done for every symbol/sample, so about 3500 lookups
will take place.
To omit this lookup, which is not needed, unset environment variable
DEBUGINFOD_URLS=''.

 Output after:
 # time ./perf test 108
 108: Test java symbol                  : Ok

 real	0m6.242s
 user	0m4.982s
 sys	0m3.243s
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: leo.yan@linaro.org
Cc: irogers@google.com
---
 tools/perf/tests/shell/test_java_symbol.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
index 90cea8811926..499539d1c479 100755
--- a/tools/perf/tests/shell/test_java_symbol.sh
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -56,7 +56,7 @@ if [ $? -ne 0 ]; then
 	exit 1
 fi
 
-if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
+if ! DEBUGINFOD_URLS='' perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
 	echo "Fail to inject samples"
 	exit 1
 fi
-- 
2.40.0

