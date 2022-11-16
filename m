Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD662B70D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKPJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiKPJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:57:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6699175B0;
        Wed, 16 Nov 2022 01:57:49 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668592667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BB+ucvWV0kFUPadADn4TTS4/yULan76KkzlFoRsm0Q=;
        b=4RFgpdOVjQRrzw5QqeItJWa3vp+Jl952HXbXFQBRDbwHwvpSQyZPlzBOvK0AdcIBD5sRWm
        A2vlpVGcjqRDNNCjtgtmEwwq2DcMbv3U+1xWWrn5+1L4HcvyDv8ygq+gUO3BOZU78vjwDk
        3X2rA+Uh+APDdC2INPI+8qkOQggQTFWW5NGe4PKy3ruoI81OfnZJZjIFBbmbD6T4WPbXi8
        KizvqU4O6dkACs6ZtfqESpc/nDEzvmFlpuAC+OHTOzdpVL3PjwMEpu2BCFR8BnDnc46bIu
        /FQXzFOMncUPeERYaV16LM/VtLixeIfATbtrFjaLFWknkmlMU8DmBcDES85fHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668592667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BB+ucvWV0kFUPadADn4TTS4/yULan76KkzlFoRsm0Q=;
        b=z+1dUe97sEOWLw/cegGzba+3BTH6AeeymeXuLjEC06H5XKj65i4zOAyqUoxihVZIoifen3
        o6paqU+yJCdKh3AA==
From:   "tip-bot2 for Srikar Dronamraju" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] scripts/faddr2line: Fix regression in name
 resolution on ppc64le
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220927075211.897152-1-srikar@linux.vnet.ibm.com>
References: <20220927075211.897152-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <166859266638.4906.8897216149530448372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2d77de1581bb5b470486edaf17a7d70151131afd
Gitweb:        https://git.kernel.org/tip/2d77de1581bb5b470486edaf17a7d70151131afd
Author:        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate:    Tue, 27 Sep 2022 13:22:11 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Nov 2022 10:42:10 +01:00

scripts/faddr2line: Fix regression in name resolution on ppc64le

Commit 1d1a0e7c5100 ("scripts/faddr2line: Fix overlapping text section
failures") can cause faddr2line to fail on ppc64le on some
distributions, while it works fine on other distributions. The failure
can be attributed to differences in the readelf output.

  $ ./scripts/faddr2line vmlinux find_busiest_group+0x00
  no match for find_busiest_group+0x00

On ppc64le, readelf adds the localentry tag before the symbol name on
some distributions, and adds the localentry tag after the symbol name on
other distributions. This problem has been discussed previously:

  https://lore.kernel.org/bpf/20191211160133.GB4580@calabresa/

This problem can be overcome by filtering out the localentry tags in the
readelf output. Similar fixes are already present in the kernel by way
of the following commits:

  1fd6cee127e2 ("libbpf: Fix VERSIONED_SYM_COUNT number parsing")
  aa915931ac3e ("libbpf: Fix readelf output parsing for Fedora")

[jpoimboe: rework commit log]

Fixes: 1d1a0e7c5100 ("scripts/faddr2line: Fix overlapping text section failures")
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Link: https://lore.kernel.org/r/20220927075211.897152-1-srikar@linux.vnet.ibm.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 scripts/faddr2line | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 5514c23..0e73aca 100755
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
