Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD916483A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiLIOUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLIOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:20:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2056076140
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:20:28 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9DZnAM017873;
        Fri, 9 Dec 2022 14:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=SWeLgeqnB0vNUWmVM+L79Y1vBkxy5zGsku/Gejs8BUc=;
 b=La1DG8dKDWeUC42domLDnSAwPkM0F9nbRAQJSMS2W1IVTvJiwF5dt3XxjP4MmTmQcsvs
 jYxMm7BNZk1zPWvPXVgzPqkP34bjKAlWUPLZruYPdOzd+2xCQ0lfbhi/r36N0qs4pXa2
 9hNduGTTeIu9X5zGF98CRql79SHK/HJsBhDfnHbjvKMRYTnqhzMyfXzkXZGKfMAO8XYs
 +8+QcrCztpF1865hJNq2wW1WXWAmAkSd+ajHDRbzhQFtmo69jwngzp1FL8Cv8VzFGrq8
 4LREjZanE3NYvQf5YLze+WFAsLy2cImsaN401P9ETJd6g2Eh5tFzwuqo1tlsb3nhCmd2 RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxnkkep0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:58 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B9DV2pL016824;
        Fri, 9 Dec 2022 14:19:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxnkkenh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9CD4NI016519;
        Fri, 9 Dec 2022 14:19:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3m9m5y62r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B9EJrd317039924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 14:19:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C192004B;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6481120049;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 1EF9AE027E; Fri,  9 Dec 2022 15:19:53 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] add s390 support to nolibc and rcutorture
Date:   Fri,  9 Dec 2022 15:19:34 +0100
Message-Id: <20221209141939.3634586-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: or8MF2xi8ugWovdhvAn5-u6EwqsVnUOn
X-Proofpoint-ORIG-GUID: 0jyPxZmyZ4Kheiq2amjG3pR5jeB2P4HS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=868 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1011 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090108
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
 tools/testing/selftests/nolibc/Makefile       |   4 +
 .../selftests/rcutorture/bin/functions.sh     |   6 +
 .../selftests/rcutorture/bin/mkinitrd.sh      |   2 +-
 7 files changed, 258 insertions(+), 24 deletions(-)
 create mode 100644 tools/include/nolibc/arch-s390.h

-- 
2.34.1

