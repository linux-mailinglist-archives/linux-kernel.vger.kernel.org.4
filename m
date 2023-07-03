Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7726745FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGCPYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGCPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:24:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12CE41;
        Mon,  3 Jul 2023 08:24:02 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363FHo1m028226;
        Mon, 3 Jul 2023 15:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=j99sFteJVA+vQCpOENH04nWpFXQAHtpI2spxsYR8pb8=;
 b=RIP0GMAuYd1ROapylBoEohN+1MH/eGX7tFgC6RPFHPzv8vGZvc3/1fPI3qAkoEC7BMmf
 Pw5uJcBisDlUs5NSe5080I81u1PBvlJqundtF8xprRTCYew40eN5tV20Sdj3Efh+3UdF
 AhEDKJvxOSQwsBEFy0WJqUgQMD9tUq5jrCBr05/ueE4kXmRx/RMHbVUeH6xf3lLhhGym
 mIfZ9ESbD5V0kHXtTnhs95w8BUYzlFuMKFm92LO2vhqzgrz0Okm5cHCq6wzG4pi7/jXB
 tDBrj9znuk21122C1XbdfGo3f0Mvt7vh+S4N7jpRYpSC8wjffLBQkP3nzX0jtGOMVeiC YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm0uer3pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:24:00 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FJGM1031879;
        Mon, 3 Jul 2023 15:23:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm0uer3p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:23:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 362Nq53m000478;
        Mon, 3 Jul 2023 15:23:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4scyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:23:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 363FNtdn33293046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 15:23:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88EB42004B;
        Mon,  3 Jul 2023 15:23:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E88B20040;
        Mon,  3 Jul 2023 15:23:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jul 2023 15:23:55 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/1] Input: gameport: Handle HAS_IOPORT dependencies
Date:   Mon,  3 Jul 2023 17:23:54 +0200
Message-Id: <20230703152355.3897456-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VQBEA2pt5--z9bZgGyPj6pvlHEfJ-n9J
X-Proofpoint-ORIG-GUID: mHqMxSvlGaFLAD1RrMEtBIcL0mYygvTL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up to my ongoing effort of making the inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this as
a complete treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. Now about half of
the per-subsystem patches have been merged so I'm changing over to stand
alone subsystem patches. These series are stand alone and should be merged
via the relevant tree such that with all subsystems complete we can follow
this up with the last patch[1] that will make the I/O port accessors
compile-time optional.

Thanks,
Niklas

Changes since v5 for Gameport:
- Added a dev_err() print when registering a port without .trigger() || .read()
  and disabled CONFIG_HAS_IOPORT (Dmitry Torokhov).
  I added this where the default functions are set instead of in the handlers
  themselves so there is naturally one error print per port.
- Rebased to deal with default handler functions.

[0] https://lore.kernel.org/all/20230516110038.2413224-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/all/20230516110038.2413224-42-schnelle@linux.ibm.com/
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (1):
  Input: gameport: add ISA and HAS_IOPORT dependencies

 drivers/input/gameport/Kconfig    |  4 +++-
 drivers/input/gameport/gameport.c | 28 +++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)


base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
-- 
2.39.2

