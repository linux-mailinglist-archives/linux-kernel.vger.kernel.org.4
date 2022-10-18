Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C30F602DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiJROEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiJROEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:04:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0791ED25A9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:04:00 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDNCHF014417;
        Tue, 18 Oct 2022 14:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=/1XJhabtQUGv3oxTHCHZbo8H+yW04oSQHMIEjdxLC6I=;
 b=HtEQutT7U5LZejlJV3xA+9QlG6ZwXHUphX6EFEDYwfyqs+fIKi9j1sGDB3QrIFs5P9Bl
 DaI2sSfw6d8YT9IACiWFh40fRT2diTwYacQTgv3WkH4aqhT39yl5AnOl1zNi65uFhWDZ
 44BFvpw2BnKE0Pt1ifjDlhgL4dQJUeLeev+N587tkrQqBEfZYsejojb+gu02eClJ50fA
 ENfkMznej+YtSYFytJOdMZyb9ZGFd8T8ogL83LOVseaLESTGW3gXQJChe0/qbq5S6oEs
 sw2941yjxRsQSP4uQYkwog6WblIZoAMMEv1c2KunLL1nuSV2bIB+VrkEFDj8WXImfFZN 2g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9tqn7fsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:03:55 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IDsEWZ005108;
        Tue, 18 Oct 2022 14:03:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3k99fn1kcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:03:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IE3o2n066196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:03:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81C77A404D;
        Tue, 18 Oct 2022 14:03:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB0DDA4051;
        Tue, 18 Oct 2022 14:03:48 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.89.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Oct 2022 14:03:48 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] selftests/ftrace: Capture dependency on external programs
Date:   Tue, 18 Oct 2022 19:33:39 +0530
Message-Id: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RXmQ2V7fu6IQCzJzFY9_8kfMU9j8ZDJR
X-Proofpoint-ORIG-GUID: RXmQ2V7fu6IQCzJzFY9_8kfMU9j8ZDJR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

