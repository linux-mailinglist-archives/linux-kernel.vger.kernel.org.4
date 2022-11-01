Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD637615397
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKAUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:54:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5D10579;
        Tue,  1 Nov 2022 13:54:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KouXi002166;
        Tue, 1 Nov 2022 20:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=n2s34LQyv0LHx7fXgxlmeU16+bMoGpAgw9+p/6CncvM=;
 b=iyEQB6n+NCuqXe9ec0M75io+TJ/4MkRe42H6U/QObo3C+/aNMOt4ri1WktXK/Ky+AIaj
 55pzrwZTjkXsbYCJIGnVUiULRkPS8hhaWHsnbqP9I40JSOk625Fa3P1Z+wgkqioRfK75
 qLkoy5QLdqWIBnABCWz5SyTwDQ3ytRNeO2tZzpDvMjO49eAGUsPPyNX5X0rEESXa/CjZ
 iv2tZ8Xfz0L738rRuZQ6dhjzrRZbr/39GcRC2O+GiEz9Yc2WcCPMhNReSBHN7zT/e/vB
 Wv6knytnB9Qjt12iRzW/iH2QkvorCxfFyGXhjL0xV1rdryXFojls6M/wNlKj3x7oMG/6 iA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjwjjm0vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:53:44 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1KolAu004373;
        Tue, 1 Nov 2022 20:53:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3kgutabxq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:53:43 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KrfYR41222430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:53:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43D1B58051;
        Tue,  1 Nov 2022 20:53:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CE5D5805A;
        Tue,  1 Nov 2022 20:53:41 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.92.229])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:53:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, joel@jms.id.au,
        andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/2] watchdog: aspeed: Add pre-timeout interrupt support
Date:   Tue,  1 Nov 2022 15:53:36 -0500
Message-Id: <20221101205338.577427-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: anovv7hUhdukI8PdpmiJ5Zc1erPNhdyi
X-Proofpoint-GUID: anovv7hUhdukI8PdpmiJ5Zc1erPNhdyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=748
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the core pre-timeout interrupt on AST2500 and AST2600.

Changes since v1:
 - Use watchdog core support for pre-timeout interrupt, rather than new
   dts property

Eddie James (2):
  watchdog: aspeed: Enable pre-timeout interrupt
  ARM: dts: aspeed: Setup watchdog pre-timeout interrupt

 arch/arm/boot/dts/aspeed-g5.dtsi |   3 +
 arch/arm/boot/dts/aspeed-g6.dtsi |   4 ++
 drivers/watchdog/aspeed_wdt.c    | 104 ++++++++++++++++++++++++++-----
 3 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.31.1

