Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981E965BB2B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjACHVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjACHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:20:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F22995BE;
        Mon,  2 Jan 2023 23:20:41 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3035hlRx005582;
        Tue, 3 Jan 2023 07:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Z3d1cCXB1ySYlJ1Na0DWz0TXYx8d+FHAjJ6gUzBHV4Y=;
 b=HDss4lW6kvxR0E61VfUkPoEo3p6sYMccqfUCUTN3rAuIwJPuHeG9S1wT1Z7sqkTsksAu
 l6+dLQdNNrplQ5S7VGk+YlEv8u0sRB2+BeUzlCz7/mEZCtpd/7qAKeWjDsH0bxx0AtAY
 lmINL8MDK9Bh9a72oXzClg2DLSHjNZxOzYyMOKt15zpSVI/cIpSHAARGJWM8d0zpABpP
 e2doezs/wLci4tgsRJ3yp18SUjpIU6Bqx3iNJOJPYOyIaBUS/F4470Q9Ixtz8KmOE+5C
 p607CHXFzOCieMpdXpBTp2Augp1Yn2ICdHlq3587gPBESTP1VE2LAdErK8DrSWFHVhVB nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvefhhf5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:07 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3037GgaF030926;
        Tue, 3 Jan 2023 07:20:07 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvefhhf4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:07 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302LqS8O021495;
        Tue, 3 Jan 2023 07:20:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6ag96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3037K29A51183966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 07:20:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DFF62004B;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D78320040;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 2EDEEE0342; Tue,  3 Jan 2023 08:20:02 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 0/5] add s390 support to nolibc and rcutorture
Date:   Tue,  3 Jan 2023 08:19:52 +0100
Message-Id: <20230103071957.222360-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gLpdyLqSp3l6OMOje1ek9bn5zvzNSWPD
X-Proofpoint-GUID: mRNRojS0Oxl-E4TOmj6Kn7kUo7Y6tRtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=885 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v3:

- fix envp handling in startup assembly

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

 tools/include/nolibc/arch-s390.h              | 222 ++++++++++++++++++
 tools/include/nolibc/arch.h                   |   2 +
 tools/include/nolibc/sys.h                    |   2 +
 tools/include/nolibc/types.h                  |  53 +++--
 tools/testing/selftests/nolibc/Makefile       |   7 +-
 .../selftests/rcutorture/bin/functions.sh     |   6 +
 .../selftests/rcutorture/bin/mkinitrd.sh      |   2 +-
 7 files changed, 269 insertions(+), 25 deletions(-)
 create mode 100644 tools/include/nolibc/arch-s390.h

-- 
2.34.1

