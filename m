Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97DC60721F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJUI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiJUI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:26:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546CF0188;
        Fri, 21 Oct 2022 01:26:24 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L8DFQi011308;
        Fri, 21 Oct 2022 08:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zYFwWlKHLIqKID6jP8gRJWcqxPLr50ivrBdQZkwRy1E=;
 b=QfA7lyvVILhsuZtFzWf3i5ARKostnQfwA3PTY6qPPQDtww1ccNuiOxrV1ndwrK1LUhPy
 d4rWv6w+f/MEFzE/PoGJzG1i1wDGvTt+f8/P1y7sjF2IM/pACQArXfzuFm381o+L7e/x
 FOkKmhkYmAjbmfAlooR6tOjU7oe7i+zi/BSqrqfJbW/juKEFWTWzPDmlDpKlm0EGYdsS
 6zIUNEXW6chwE5ehCrl4dukBEaJSoVr+p+XqHyhwRIDhPunA3erRyjmqM9hfVyT6yqRp
 v6n6S12Ggivnoia078D9nzwNw1XzuOOylLl62KHmqcFWOcrsQGusZyu44GsNJmmCvYzP Kw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbqqhrba6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 08:26:14 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29L8KW3X002601;
        Fri, 21 Oct 2022 08:26:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3k7mg9fn41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 08:26:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29L8Q9MB44040592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 08:26:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2DD652052;
        Fri, 21 Oct 2022 08:26:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7B4D05204F;
        Fri, 21 Oct 2022 08:26:09 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf list: Fix PMU name pai_crypto in perf list on s390
Date:   Fri, 21 Oct 2022 10:25:57 +0200
Message-Id: <20221021082557.2695382-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ez9bo-iXwJJpwk5F9RCFwsI7z3u0FrjX
X-Proofpoint-ORIG-GUID: Ez9bo-iXwJJpwk5F9RCFwsI7z3u0FrjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210210047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e0b23af82d6f4 ("perf list: Add PMU pai_crypto event description for IBM z16")
introduced the Processor Activity Instrumentation for cryptographic
counters for z16. The PMU device driver exports the counters via sysfs
files listed in directory /sys/devices/pai_crypto.

To specify an event from that PMU, use perf stat -e pai_crypto/XXX/

However the json file mentioned in above commit exports the counter
decriptions in file pmu-events/arch/s390/cf_z16/pai.json.
Rename this file to pmu-events/arch/s390/cf_z16/pai_crypto.json
to make the naming consistent.

Now perf list shows the counter names under pai_crypto section:
pai_crypto:
  CRYPTO_ALL
       [CRYPTO ALL. Unit: pai_crypto]
  ....

Output before was
pai:
  CRYPTO_ALL
       [CRYPTO ALL. Unit: pai_crypto]
  ....

Fixes: e0b23af82d6f4 ("perf list: Add PMU pai_crypto event description for IBM z16")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z16/{pai.json => pai_crypto.json}     | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/perf/pmu-events/arch/s390/cf_z16/{pai.json => pai_crypto.json} (100%)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_z16/pai.json
rename to tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
-- 
2.37.3

