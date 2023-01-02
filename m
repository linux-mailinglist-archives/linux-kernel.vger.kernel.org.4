Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F465B003
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjABKwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjABKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:52:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6AE65;
        Mon,  2 Jan 2023 02:52:05 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30270twx004293;
        Mon, 2 Jan 2023 10:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QItSQryhxQg5FKSbZZWkQyqWRyFL1d3h+ftPdcrjYwc=;
 b=WP3mv8QDr/uvqw9hYPWT6ADzHxYJL7IVOFrW0ATk8nVTnUcJlVHxTP3VvyccCUAXWeA3
 G3kQVCTgdjuOvShVQXW/afAp2tGAHb3EoM2N8SErQRVqLWfypLX1X1Ok1l6d9Z/MJemP
 8P6vEGDQyjdzF1KSJj/r5F+mHf94tfF5l4HkDq/kJ2VmlGDWtKHg71Z0Lvy5N8faBPq0
 NoTw7aAJ+VgpZ5q8TRYhWfsI903lGmtSDIDhToLvXxRpZV3ZToa2kAphGysxH1UznXzc
 jcBEBEhqgBQ9zb3aKlDQBDftJLoSSOPMOwBhMN7+no7I6pkJ/uylTl/FWtJC3sd885m8 yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxucxp2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:36 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 302Ao5qC012972;
        Mon, 2 Jan 2023 10:51:35 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxucxp1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 301KpqgN030029;
        Mon, 2 Jan 2023 10:51:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6aa5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302ApVZ048562564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 10:51:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4DAF20040;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D19A72004D;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 834EFE06EB; Mon,  2 Jan 2023 11:51:30 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/5] add s390 support to nolibc and rcutorture
Date:   Mon,  2 Jan 2023 11:51:07 +0100
Message-Id: <20230102105112.1661651-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2aE_DMyiFErFne7HUh3ZAKK4AYJTpzJf
X-Proofpoint-ORIG-GUID: f-zT1V4Ny3QL43YLKHZqACy-W8PY7lyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=839 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these patches add support for the s390 architecture both to nolibc
and rcutorture. Note that this only adds support for the 64 bit
version, no support for 31 bit (compat) is added. For nolibc it
includes one bugfix to make the fd_set datatype match the kernel
type.

Changes in v2:

- use __attribute__((unused)) instead of __maybe_unused
- prefer aghi over lay, as lay is not present in all architecure levels
- add -m64 CFLAG to force 64 bit mode for compiler that can do 31bit and 64bit mode

Sven Schnelle (5):
  nolibc: fix fd_set type
  nolibc: add support for s390
  selftests/nolibc: add s390 support
  rcutorture: add support for s390
  rcutorture: build initrd for rcutorture with nolibc

 tools/include/nolibc/arch-s390.h              | 213 ++++++++++++++++++
 tools/include/nolibc/arch.h                   |   2 +
 tools/include/nolibc/sys.h                    |   2 +
 tools/include/nolibc/types.h                  |  53 +++--
 tools/testing/selftests/nolibc/Makefile       |   7 +-
 .../selftests/rcutorture/bin/functions.sh     |   6 +
 .../selftests/rcutorture/bin/mkinitrd.sh      |   2 +-
 7 files changed, 260 insertions(+), 25 deletions(-)
 create mode 100644 tools/include/nolibc/arch-s390.h

-- 
2.34.1

