Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139706CF00E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjC2RCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC2RCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:02:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027019B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:02:01 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TExNqX029835;
        Wed, 29 Mar 2023 17:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fOHY/sITK0CP1NqGzAYTxFUDAvVDj4hr7x88DX7JrHQ=;
 b=GLrUQYjd6CnsO/Gm4sukD05NJyhsyP3xQKf0OCtJc5whuk7fOsWNHcctI0qGrK4drlgL
 gNxGtuTro0OBuJvElz0uxoyrJV9hNcE3llYyUnqc6Ed3IfmgE1oHi9OWKhpA0bm6ZEYi
 t0z+pEML4XAwSnUYk79vN4sNdQltRSricxBC/OoVWAVFZJ/Q3KT6z0bU5WHyQiyKBy4n
 ZnoOFTXYaz1brOpdPNH4G62VrLxz1jCdMGy/GIc02uCGv/CJYHErwmTKoCBlzxKuuyHU
 1gyQJ3iYNE1yVudehuXsdZz9HzL8Ir3vCo7B1A7GYoKjnqedcQQY2fveFXQvSizm3OrN aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmp7j5ypf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:49 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32TDUUmF011234;
        Wed, 29 Mar 2023 17:01:49 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmp7j5yn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:48 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32SMN18q009613;
        Wed, 29 Mar 2023 17:01:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3phrk6n4js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32TH1iO623724790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 17:01:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C11F2004B;
        Wed, 29 Mar 2023 17:01:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A914920043;
        Wed, 29 Mar 2023 17:01:42 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.61.88])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Mar 2023 17:01:42 +0000 (GMT)
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     abhirupdeb@linux.vnet.ibm.com
Subject: [PATCH 0/5] staging: r8188eu: code cleanup and coding-style fix patches
Date:   Wed, 29 Mar 2023 22:31:34 +0530
Message-Id: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FKh5B_6c0vqWNRknlLBPGZHLt3dpP8Nl
X-Proofpoint-GUID: bAYXVG2_T5Te22YtzEm-UQthH98RGEDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290133
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches fixes the coding-style issues
reported by checkpatch.pl for the staging/r8188eu driver.

Abhirup Deb (5):
  staging: r8188eu: add blank line after declaration
  staging: r8188eu: refactor block-comments
  staging: r8188eu: remove redundant else after return
  staging: r8188eu: Replace "<<" with BIT macro
  staging: r8188eu: place constants on right side of comparison

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 61 +++++++-------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 10 +--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 23 ++++--
 drivers/staging/r8188eu/include/ieee80211.h   | 82 +++++++++----------
 drivers/staging/r8188eu/include/rtw_mlme.h    |  4 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  6 +-
 9 files changed, 98 insertions(+), 94 deletions(-)

-- 
2.31.1

