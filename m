Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C533602DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJROEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiJROD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:03:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BAD039B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:03:32 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDhpQE019711;
        Tue, 18 Oct 2022 14:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=/1XJhabtQUGv3oxTHCHZbo8H+yW04oSQHMIEjdxLC6I=;
 b=pol7DiP4eSdmHE+a6I+Irj7XBDGipNeUI6a64dc0ud5/Lc9scP/xTPvH6UgxZv4gnD0v
 yAzvwrVrAKM9bZQxSx7Y7xKRJIs/FFUTF9E7ndb4rNT6QT/JAixrQecHeOSDbrbkvb0Q
 GAOoaSL7y8IcFmwzfTdkQ9QfZi/ryK7WQjK/l/UIWPva83wRiequjmktOFn4cfWFIuJZ
 E9WvBl6+4p5QeTVa/6ip2wq6RL7eas5WCN3l7AALeYQ6w63rTXuRKrQRMzN19QhIIi9S
 IedfRBHdVmGXoP6SSizTkT48B694alxg0sRAqhBF0PtyOUcDjBbfMR/LQfdXZz1KLfZN gg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9w9dgqvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:03:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IDtB8F024085;
        Tue, 18 Oct 2022 14:03:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg95c40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:03:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IE3LNH64225622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:03:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFB834C044;
        Tue, 18 Oct 2022 14:03:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EE2C4C04A;
        Tue, 18 Oct 2022 14:03:20 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.89.190])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Oct 2022 14:03:20 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] selftests/ftrace: Capture dependency on external 
Date:   Tue, 18 Oct 2022 19:32:57 +0530
Message-Id: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oA4BWmALP0Ps_VBnLlKMmXPRy-lCJR5m
X-Proofpoint-ORIG-GUID: oA4BWmALP0Ps_VBnLlKMmXPRy-lCJR5m
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the below patch:
http://lkml.kernel.org/r/20221017101927.303547-1-naveen.n.rao@linux.vnet.ibm.com

The second patch is new, and converts some other tests to use the new 
way of specifying dependency on external programs.

- Naveen


Naveen N. Rao (2):
  selftests/ftrace: Add check for ping command for trigger tests
  selftests/ftrace: Convert tracer tests to use 'requires' to specify
    program dependency

 tools/testing/selftests/ftrace/test.d/functions           | 8 +++++++-
 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 7 +------
 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 7 +------
 .../trigger/inter-event/trigger-field-variable-support.tc | 2 +-
 .../inter-event/trigger-inter-event-combined-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onchange-action-hist.tc   | 2 +-
 .../trigger/inter-event/trigger-onmatch-action-hist.tc    | 2 +-
 .../inter-event/trigger-onmatch-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-snapshot-action-hist.tc   | 2 +-
 .../inter-event/trigger-synthetic-event-dynstring.tc      | 2 +-
 .../trigger/inter-event/trigger-trace-action-hist.tc      | 2 +-
 12 files changed, 18 insertions(+), 22 deletions(-)


base-commit: 6c0f39e87b6ab1a3009e3a49d3e6f6db8dc756a8
-- 
2.38.0

