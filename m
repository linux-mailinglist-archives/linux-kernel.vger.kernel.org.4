Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035806BE5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCQJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCQJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:44:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08415298F0;
        Fri, 17 Mar 2023 02:43:55 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H8nlSh013447;
        Fri, 17 Mar 2023 09:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=g1FlgkwM5CiKkppb/wvdX6s6a66SPKK8cQI3YryJtj8=;
 b=RzDKyQ660QoNWsOCdXE0avn+taApPNVWHUxXUSyfBbM25eoBbJiZxX2fIH2rpGA0umA6
 Lj51DUYeJNTHtmAeBqBkaik708QNe5dQDVZ7m8kFJQFBTOM+fFE1n7PzWNvEUvtiT50H
 9L4dpQXOhGsD7SAdRx2urj7Q+Qaabt2SN19w/EA9xTsSoZVsFkY34Yf7yANGp9/vf3J1
 WfLbodTXFkWzj/iygXngVEAAFjScY3z+7w797KCoo0X4u/tKi2/LWAQn0gk63oR8WbVx
 0tnJCmpwNLpOCJXUhU3U8Nc1xk3d7oG/+UM2cPZaOo7AI+3CDDzVp3gF8YUFDhC3YZEZ /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcn1qhf4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 09:43:52 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H9Tq3n007990;
        Fri, 17 Mar 2023 09:43:51 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcn1qhf3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 09:43:51 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32GHnRqg015999;
        Fri, 17 Mar 2023 09:43:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pbs549mw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 09:43:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32H9hjOf46334376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 09:43:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B5220043;
        Fri, 17 Mar 2023 09:43:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B7620040;
        Fri, 17 Mar 2023 09:43:45 +0000 (GMT)
Received: from localhost (unknown [9.171.35.234])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Mar 2023 09:43:44 +0000 (GMT)
Date:   Fri, 17 Mar 2023 10:43:43 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.3-rc3
Message-ID: <your-ad-here.call-01679046223-ext-4713@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1je-A4lTfIqLoOHlslBUFNE_NhcMPJRy
X-Proofpoint-GUID: B15velBrSFDe97Cv9ye_adR7VoR3-631
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_05,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=561
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.3-rc3. The s390-specific PCI fix adds a
function to the common PCI code, which has been acked by Bjorn Helgaas as
the PCI maintainer.
https://lore.kernel.org/all/20230308231449.GA1057317@bhelgaas/

Thank you,
Vasily

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-3

for you to fetch changes up to d7a0bdbf17276b757d2b89f5351bbee9ecf58fe6:

  s390: update defconfigs (2023-03-13 09:15:11 +0100)

----------------------------------------------------------------
s390 updates for 6.3-rc3

- Update defconfigs.

- Fix early boot code by adding missing intersection check to prevent
  potential overwriting of the ipl report.

- Fix a use-after-free issue in s390-specific code related to PCI
  resources being retained after hot-unplugging individual functions,
  by removing the resources from the PCI bus's resource list and using
  the zpci_bar_struct's resource pointer directly.

----------------------------------------------------------------
Heiko Carstens (1):
      s390: update defconfigs

Niklas Schnelle (1):
      PCI: s390: Fix use-after-free of PCI resources with per-function hotplug

Sven Schnelle (1):
      s390/ipl: add missing intersection check to ipl_report handling

 arch/s390/boot/ipl_report.c          |  8 ++++++++
 arch/s390/configs/debug_defconfig    | 13 ++++---------
 arch/s390/configs/defconfig          | 12 +++---------
 arch/s390/configs/zfcpdump_defconfig |  2 +-
 arch/s390/pci/pci.c                  | 16 ++++++++++------
 arch/s390/pci/pci_bus.c              | 12 +++++-------
 arch/s390/pci/pci_bus.h              |  3 +--
 drivers/pci/bus.c                    | 21 +++++++++++++++++++++
 include/linux/pci.h                  |  1 +
 9 files changed, 54 insertions(+), 34 deletions(-)
