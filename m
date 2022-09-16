Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06B95BAD8C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIPMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIPMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:41:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F3AA6AEB;
        Fri, 16 Sep 2022 05:41:32 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GCP112025532;
        Fri, 16 Sep 2022 12:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8MVoDvB4SqNFBOByHaTdY7CgpP45sKEOY1RYgqE6ac0=;
 b=mUbv0oH8rIUZgsogEk6hRYrmwdj01DwaVw7YMc79YS8qEUoBCZBVkst57GGIF2PbX0KD
 1kbcXX9BkTJs57snbwDesSXzgmpvd/qyYsJ4vew+kTMbJEpf6BY04nIi5tWHtqXk+Rdz
 wnEOsBnxJVf8UmszmoX9ahGkcXLjWZzUnX2ucYQvEAgcgdUptAFcYjqzLbkRjY+/9e/1
 8i9jW3gfxf+Pvmfmaur3nxFZ7wesOn3YUWGHlQtMNSiBa9Xi7OX9qY7lwEl3elLMHqpl
 RHVzKWfDj6daQiBXdOScGy8nGpITJ2z57r4ueJgvMVOTWEtPvyY84JtL63x+zBpHWJb2 YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jms4p0sxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 12:41:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28GCRr9V012110;
        Fri, 16 Sep 2022 12:41:22 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jms4p0svb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 12:41:21 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GCcBc3002645;
        Fri, 16 Sep 2022 12:41:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3jm91t8r35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 12:41:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GCfGiU42271022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 12:41:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA790AE051;
        Fri, 16 Sep 2022 12:41:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F815AE045;
        Fri, 16 Sep 2022 12:41:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Sep 2022 12:41:16 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kbuild: rpm-pkg: fix breakage when V=1 is used
Date:   Fri, 16 Sep 2022 14:41:12 +0200
Message-Id: <20220916124112.1175522-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lUz6XvSvSx7UF8zcAjmHR8jpqRQPNk2J
X-Proofpoint-GUID: uU_xWPU3qkZCWUBC4OgQVjjtAS77-eIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_06,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing make V=1 binrpm-pkg results in:

 Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.EgV6qJ
 + umask 022
 + cd .
 + /bin/rm -rf /home/scgl/rpmbuild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x
 + /bin/mkdir -p /home/scgl/rpmbuild/BUILDROOT
 + /bin/mkdir /home/scgl/rpmbuild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x
 + mkdir -p /home/scgl/rpmbuild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x/boot
 + make -f ./Makefile image_name
 + cp test -e include/generated/autoconf.h -a -e include/config/auto.conf || ( \ echo >&2; \ echo >&2 " ERROR: Kernel configuration is invalid."; \ echo >&2 " include/generated/autoconf.h or include/config/auto.conf are missing.";\ echo >&2 " Run 'make oldconfig && make prepare' on kernel src to fix it."; \ echo >&2 ; \ /bin/false) arch/s390/boot/bzImage /home/scgl/rpmbuild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x/boot/vmlinuz-6.0.0-rc5+
 cp: invalid option -- 'e'
 Try 'cp --help' for more information.
 error: Bad exit status from /var/tmp/rpm-tmp.EgV6qJ (%install)

Because the make call to get the image name is verbose and prints
additional information.

Fixes: 21b42eb46834 ("kbuild: rpm-pkg: fix binrpm-pkg breakage when O= is used")
Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---


I don't know much about Kbuild so there may be better ways to fix this.


 scripts/package/mkspec | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 8fa7c5b8a1a1..c920c1b18e7a 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -88,10 +88,10 @@ $S
 	mkdir -p %{buildroot}/boot
 	%ifarch ia64
 	mkdir -p %{buildroot}/boot/efi
-	cp \$($MAKE image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
+	cp \$($MAKE -s image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
 	ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
 	%else
-	cp \$($MAKE image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
+	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
 	%endif
 $M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
-- 
2.34.1

