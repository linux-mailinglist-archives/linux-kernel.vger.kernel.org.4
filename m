Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0345C5EBC01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiI0HxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiI0HxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:53:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A4AB402
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:52:58 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R7RrfN003060;
        Tue, 27 Sep 2022 07:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cHE7lrcn16mA8EML+xbjQhGs1OhtEXPVbBeJ62ihTBQ=;
 b=d1vmthHcxItFfX9L08QJPLx1h10e9dVVzI6BYva99/ezMI2bXea1V1F6Q2CN/e+KOuXi
 8x77prl/hRyCD8bt0muR601DZ3pati5ifBXLtEwDrQCuxBBgOvJXnu6YSEyQvTlgpYZc
 7ZUJwdkhn/VD1bIW/heMVfFB0X3m40FEkmDcEqrC8Jfnl53aEwJ+4i91/0z4nKCt+OgU
 Iy3VVXY2Y2B3InNw/w2XbMYpODwkT5Fl0jrBCRDsJyeMJF19yDPpkIP0CeLUG0cRq+Vc
 Ga1NB+r+vzP2YnNypHWVDland0bI/04JEhAz1gdfciBW1aGw41HKEcbF9LrZLx4W9jHA 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juvtdgkjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 07:52:33 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R7UCdp009678;
        Tue, 27 Sep 2022 07:52:33 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juvtdgkhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 07:52:33 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R7psu3015958;
        Tue, 27 Sep 2022 07:52:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3jssh92m9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 07:52:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R7qS5S5374586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 07:52:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0D9752050;
        Tue, 27 Sep 2022 07:52:28 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.43.94.238])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A705752051;
        Tue, 27 Sep 2022 07:52:26 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] scripts/faddr2line: Fix regression in name resolution on ppc64le
Date:   Tue, 27 Sep 2022 13:22:11 +0530
Message-Id: <20220927075211.897152-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HWBmjJbKSMX3_2jZ8JK5u-A6ZPIZoGVt
X-Proofpoint-ORIG-GUID: OejE7pt4GMwj1nz1Jcx1kkT4W3GvQReb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1d1a0e7c5100 ("scripts/faddr2line: Fix overlapping text section failures")
can cause scripts/faddr2line to fail on ppc64le machines on few
distributions, while working on other distributions. The failure can be
attributed to difference in readelf output on various distributions.

$ ./scripts/faddr2line vmlinux find_busiest_group+0x00
no match for find_busiest_group+0x00

Expected output was:
$ ./scripts/faddr2line vmlinux find_busiest_group+0x00
find_busiest_group+0x00/0x3d0:
find_busiest_group at kernel/sched/fair.c:9595

On ppc64le, readelf adds localentry tag before the symbol name on few
distributions and adds the localentry tag after the symbol name on few
other distributions. This problem has been discussed in the reference
URL given below. This problem can be overcome by filtering out
localentry tags in readelf output. Similar fixes are already present in
kernel by way of commits:

1fd6cee127e2 ("libbpf: Fix VERSIONED_SYM_COUNT number parsing")
aa915931ac3e ("libbpf: Fix readelf output parsing for Fedora")

Fixes: 1d1a0e7c5100 ("scripts/faddr2line: Fix overlapping text section failures")
Reference: https://lore.kernel.org/bpf/20191211160133.GB4580@calabresa/
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 scripts/faddr2line | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 5514c23f45c2..0e73aca4f908 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -74,7 +74,8 @@ command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
 find_dir_prefix() {
 	local objfile=$1
 
-	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | ${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
+	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' |
+		${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
 	local file_line=$(${ADDR2LINE} -e $objfile $start_kernel_addr)
@@ -178,7 +179,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(${READELF} --symbols --wide $objfile | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
@@ -259,7 +260,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${READELF} --symbols --wide $objfile | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
+	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage

base-commit: bf682942cd26ce9cd5e87f73ae099b383041e782
-- 
2.31.1

