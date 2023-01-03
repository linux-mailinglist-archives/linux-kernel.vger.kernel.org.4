Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE765C445
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjACQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbjACQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:52:09 -0500
X-Greylist: delayed 3238 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 08:51:22 PST
Received: from mailfo02.lmco.com (mailfo02.lmco.com [192.35.35.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20213CE9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmco.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=corpgw220615;
 bh=oFTBvU8pw6rn2ynalJQAs6xD4lOAVdSRJKYe3iwnpDc=;
 b=Zuf5XxoklsTS/VCIBMd0H420vFuDdmSfjBVj7QBL+ZTkQQekEfLGPbYfZ46uNcwLL06B
 yXntgPnhKT4XebZ0m2QuOuVwj6xmRym9h0G14j7V/LpETRzUTUZHaijt/pWWgZw2QFuc
 Wn9TJFmKpJoqFqzWiTRjtaO+4jOONb2cDdUgR1K0hiW/p2ru5YNRn9Cwftd869FZwRAZ
 sBSagQ16BSPNgr9xCT4nOzBwtHq75/H44lOqqEZN3a6mpCD3pCArV985VuFeSmeX3Kkn
 d68cg7t0omiMXzNXe+sH57RrrPG3tpo+tgcZ3tsVb0lJVFKyYrs1tJ1TjylWJzEVVQDU MQ== 
Received: from lmxpvfgd06w03.us.lmco.com ([172.23.84.34])
        by mailfo02.lmco.com (8.16.0.42/8.16.0.42) with ESMTP id 303FuoHC449496;
        Tue, 3 Jan 2023 15:56:50 GMT
Received: from lmxpvfgd07w02.us.lmco.com (172.23.84.41) by
 lmxpvfgd06w03.us.lmco.com (172.23.84.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.2308.27; Tue, 3 Jan 2023 10:56:49 -0500
Received: from emss04g01.ems.lmco.com (134.133.98.130) by
 lmxpvfgd07w02.us.lmco.com (172.23.84.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.2308.27 via Frontend Transport; Tue, 3 Jan 2023 10:56:48 -0500
Received: from pps.reinject (emss04g01.ems.lmco.com [127.0.0.1])
        by emss04g01.ems.lmco.com (8.16.0.42/8.16.0.42) with ESMTPS id 303Funmg452192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 15:56:49 GMT
Received: from emss04g01.ems.lmco.com (emss04g01.ems.lmco.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 303FuGR1451628;
        Tue, 3 Jan 2023 15:56:49 GMT
Received: from orlvm30702.orl.lmco.com (orlvm30702.orl.lmco.com [141.240.192.247])
        by emss04g01.ems.lmco.com with ESMTP id 303Fum55452178;
        Tue, 03 Jan 2023 15:56:49 +0000
From:   "Moore, Neil A" <neil.a.moore@lmco.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        Neil Moore <neil.a.moore@lmco.com>
Subject: [PATCH 0/1] x86: Add detection of the LMHS SRE hypervisor
Date:   Tue, 3 Jan 2023 10:56:47 -0500
Message-ID: <1672761408-30617-1-git-send-email-neil.a.moore@lmco.com>
X-Mailer: git-send-email 1.8.3.1
X-LM-Intranet-Inbound: IPlocal=127.0.0.1 FromIP=127.0.0.1 Env=neil.a.moore@lmco.com 
 g=nVu_ZP7w6MPN2OyMskC6o5U5w1uiH5gk q=303Funmg452192 m=1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.545,18.0.923
 definitions=2023-01-03_05:2023-01-03,2023-01-03 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.545,18.0.923
 definitions=2023-01-03_05:2023-01-03,2023-01-03 signatures=0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: KrjO0gt4rP2AgBPzYKV6Sx-8EdliGu5O
X-Proofpoint-ORIG-GUID: KrjO0gt4rP2AgBPzYKV6Sx-8EdliGu5O
X-LM-Outbound: External 172.23.84.34 cntry=** g=KrjO0gt4rP2AgBPzYKV6Sx-8EdliGu5O
 q=303FuoHC449496 m=1
X-LM-OBSENDER: neil.a.moore@lmco.com
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030135
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Moore <neil.a.moore@lmco.com>

LMHS SRE is a hypervisor focused on security, isolation, and determinism
targeting embedded, edge and cloud environments. This patch is part of our
initial engagement with the open-source community at large.

We've modeled the patch after the ACRN guest patches and based it on the
v6.1 tag.

This is my first contribution to the kernel, please let me know if I've done
something incorrect when submitting this patchset.

Happy to make any changes necessary, and thank you for your time.

Neil Moore (1):
  x86: Add detection of the LMHS SRE hypervisor

  arch/x86/Kconfig                  | 12 +++++++++++-
  arch/x86/include/asm/hypervisor.h |  2 ++
  arch/x86/include/asm/sre.h        | 13 +++++++++++++
  arch/x86/kernel/cpu/Makefile      |  1 +
  arch/x86/kernel/cpu/hypervisor.c  |  3 +++
  arch/x86/kernel/cpu/sre.c         | 31 +++++++++++++++++++++++++++++++
6 files changed, 61 insertions(+), 1 deletion(-)
  create mode 100644 arch/x86/include/asm/sre.h
  create mode 100644 arch/x86/kernel/cpu/sre.c

  --
  2.38.1
