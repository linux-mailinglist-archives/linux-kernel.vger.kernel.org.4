Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CF63BF83
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiK2L4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiK2L4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:56:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D556D54;
        Tue, 29 Nov 2022 03:56:41 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATBnK25033128;
        Tue, 29 Nov 2022 11:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=NY+0QW6Uv3vOb9Zhh5f1sQdP9Z54YYkJ1Uz4vT2I6Dg=;
 b=iDYg+qjnrhLnN3PzHwsT2EfG5LfLqbMdMcnCiDbXm3XWQeh269mCvCUOCUk6l0UdrvDI
 WDnv/tSR64HBYMCfuHEmBd4jAKGn+MCGN0t0A9T0ot/7ZlXLbqtBInnMTf4uUKPYnSdp
 VzWk9AE91jFWx5RGg20k5ks/1TjOpil8QQELGOSTr7dRnY9/JbiFuRGXLJZjYCS4+UK3
 CY6f22IvG56ga1ipwlYEjssgZnt33+DCnFTZwd49G40gU5QVHjz3gf0W1bRr8ajt+wY0
 I3UIQJA6CBRBlUKYyRilqW9FaBn7u941uBjDlvp7IFHp/kLK4jC7iV5HKaI7jbNqm1fO Ag== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5hhy83ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:56:02 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATBpRRw009114;
        Tue, 29 Nov 2022 11:56:01 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3m3aea18sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:56:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATBtxvW11010600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 11:56:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7112B5804E;
        Tue, 29 Nov 2022 11:55:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B4058055;
        Tue, 29 Nov 2022 11:55:56 +0000 (GMT)
Received: from Dannys-MacBook-Pro.local (unknown [9.211.123.96])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Nov 2022 11:55:56 +0000 (GMT)
Date:   Tue, 29 Nov 2022 19:55:53 +0800
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@linux.ibm.com
Subject: [PATCH 5/6] Supporting functions for ghash.
Message-ID: <Y4XzSXTRGXBK8Z4y@Dannys-MacBook-Pro.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c4Cjy_O6O_-anPiCW-ZVDSy51wFstMGW
X-Proofpoint-GUID: c4Cjy_O6O_-anPiCW-ZVDSy51wFstMGW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This perl code is taken from the OpenSSL project and added gcm_init_htable function
used in the p10-aes-gcm-glue.c code to initialize hash table.  gcm_hash_p8 is used
to hash encrypted data blocks.

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/ghashp8-ppc.pl | 370 +++++++++++++++++++++++++++++
 1 file changed, 370 insertions(+)
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl

diff --git a/arch/powerpc/crypto/ghashp8-ppc.pl b/arch/powerpc/crypto/ghashp8-ppc.pl
new file mode 100644
index 000000000000..b56603b4a893
--- /dev/null
+++ b/arch/powerpc/crypto/ghashp8-ppc.pl
@@ -0,0 +1,370 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+
+# This code is taken from the OpenSSL project but the author (Andy Polyakov)
+# has relicensed it under the GPLv2. Therefore this program is free software;
+# you can redistribute it and/or modify it under the terms of the GNU General
+# Public License version 2 as published by the Free Software Foundation.
+#
+# The original headers, including the original license headers, are
+# included below for completeness.
+
+# ====================================================================
+# Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
+# project. The module is, however, dual licensed under OpenSSL and
+# CRYPTOGAMS licenses depending on where you obtain it. For further
+# details see https://www.openssl.org/~appro/cryptogams/.
+# ====================================================================
+#
+# GHASH for PowerISA v2.07.
+#
+# July 2014
+#
+# Accurate performance measurements are problematic, because it's
+# always virtualized setup with possibly throttled processor.
+# Relative comparison is therefore more informative. This initial
+# version is ~2.1x slower than hardware-assisted AES-128-CTR, ~12x
+# faster than "4-bit" integer-only compiler-generated 64-bit code.
+# "Initial version" means that there is room for futher improvement.
+
+$flavour=shift;
+$output =shift;
+
+if ($flavour =~ /64/) {
+	$SIZE_T=8;
+	$LRSAVE=2*$SIZE_T;
+	$STU="stdu";
+	$POP="ld";
+	$PUSH="std";
+} elsif ($flavour =~ /32/) {
+	$SIZE_T=4;
+	$LRSAVE=$SIZE_T;
+	$STU="stwu";
+	$POP="lwz";
+	$PUSH="stw";
+} else { die "nonsense $flavour"; }
+
+$0 =~ m/(.*[\/\\])[^\/\\]+$/; $dir=$1;
+( $xlate="${dir}ppc-xlate.pl" and -f $xlate ) or
+( $xlate="${dir}../../perlasm/ppc-xlate.pl" and -f $xlate) or
+die "can't locate ppc-xlate.pl";
+
+open STDOUT,"| $^X $xlate $flavour $output" || die "can't call $xlate: $!";
+
+my ($Xip,$Htbl,$inp,$len)=map("r$_",(3..6));	# argument block
+
+my ($Xl,$Xm,$Xh,$IN)=map("v$_",(0..3));
+my ($zero,$t0,$t1,$t2,$xC2,$H,$Hh,$Hl,$lemask)=map("v$_",(4..12));
+my ($Xl1,$Xm1,$Xh1,$IN1,$H2,$H2h,$H2l)=map("v$_",(13..19));
+my $vrsave="r12";
+my ($t4,$t5,$t6) = ($Hl,$H,$Hh);
+
+$code=<<___;
+.machine	"any"
+
+.text
+
+.globl	.gcm_init_p8
+	lis		r0,0xfff0
+	li		r8,0x10
+	mfspr		$vrsave,256
+	li		r9,0x20
+	mtspr		256,r0
+	li		r10,0x30
+	lvx_u		$H,0,r4			# load H
+	le?xor		r7,r7,r7
+	le?addi		r7,r7,0x8		# need a vperm start with 08
+	le?lvsr		5,0,r7
+	le?vspltisb	6,0x0f
+	le?vxor		5,5,6			# set a b-endian mask
+	le?vperm	$H,$H,$H,5
+
+	vspltisb	$xC2,-16		# 0xf0
+	vspltisb	$t0,1			# one
+	vaddubm		$xC2,$xC2,$xC2		# 0xe0
+	vxor		$zero,$zero,$zero
+	vor		$xC2,$xC2,$t0		# 0xe1
+	vsldoi		$xC2,$xC2,$zero,15	# 0xe1...
+	vsldoi		$t1,$zero,$t0,1		# ...1
+	vaddubm		$xC2,$xC2,$xC2		# 0xc2...
+	vspltisb	$t2,7
+	vor		$xC2,$xC2,$t1		# 0xc2....01
+	vspltb		$t1,$H,0		# most significant byte
+	vsl		$H,$H,$t0		# H<<=1
+	vsrab		$t1,$t1,$t2		# broadcast carry bit
+	vand		$t1,$t1,$xC2
+	vxor		$H,$H,$t1		# twisted H
+
+	vsldoi		$H,$H,$H,8		# twist even more ...
+	vsldoi		$xC2,$zero,$xC2,8	# 0xc2.0
+	vsldoi		$Hl,$zero,$H,8		# ... and split
+	vsldoi		$Hh,$H,$zero,8
+
+	stvx_u		$xC2,0,r3		# save pre-computed table
+	stvx_u		$Hl,r8,r3
+	stvx_u		$H, r9,r3
+	stvx_u		$Hh,r10,r3
+
+	mtspr		256,$vrsave
+	blr
+	.long		0
+	.byte		0,12,0x14,0,0,0,2,0
+	.long		0
+.size	.gcm_init_p8,.-.gcm_init_p8
+
+.globl	.gcm_init_htable
+	lis		r0,0xfff0
+	li		r8,0x10
+	mfspr		$vrsave,256
+	li		r9,0x20
+	mtspr		256,r0
+	li		r10,0x30
+	lvx_u		$H,0,r4			# load H
+
+	vspltisb	$xC2,-16		# 0xf0
+	vspltisb	$t0,1			# one
+	vaddubm		$xC2,$xC2,$xC2		# 0xe0
+	vxor		$zero,$zero,$zero
+	vor		$xC2,$xC2,$t0		# 0xe1
+	vsldoi		$xC2,$xC2,$zero,15	# 0xe1...
+	vsldoi		$t1,$zero,$t0,1		# ...1
+	vaddubm		$xC2,$xC2,$xC2		# 0xc2...
+	vspltisb	$t2,7
+	vor		$xC2,$xC2,$t1		# 0xc2....01
+	vspltb		$t1,$H,0		# most significant byte
+	vsl		$H,$H,$t0		# H<<=1
+	vsrab		$t1,$t1,$t2		# broadcast carry bit
+	vand		$t1,$t1,$xC2
+	vxor		$IN,$H,$t1		# twisted H
+
+	vsldoi		$H,$IN,$IN,8		# twist even more ...
+	vsldoi		$xC2,$zero,$xC2,8	# 0xc2.0
+	vsldoi		$Hl,$zero,$H,8		# ... and split
+	vsldoi		$Hh,$H,$zero,8
+
+	stvx_u		$xC2,0,r3		# save pre-computed table
+	stvx_u		$Hl,r8,r3
+	li		r8,0x40
+	stvx_u		$H, r9,r3
+	li		r9,0x50
+	stvx_u		$Hh,r10,r3
+	li		r10,0x60
+
+	vpmsumd		$Xl,$IN,$Hl		# H.lo�H.lo
+	vpmsumd		$Xm,$IN,$H		# H.hi�H.lo+H.lo�H.hi
+	vpmsumd		$Xh,$IN,$Hh		# H.hi�H.hi
+
+	vpmsumd		$t2,$Xl,$xC2		# 1st reduction phase
+
+	vsldoi		$t0,$Xm,$zero,8
+	vsldoi		$t1,$zero,$Xm,8
+	vxor		$Xl,$Xl,$t0
+	vxor		$Xh,$Xh,$t1
+
+	vsldoi		$Xl,$Xl,$Xl,8
+	vxor		$Xl,$Xl,$t2
+
+	vsldoi		$t1,$Xl,$Xl,8		# 2nd reduction phase
+	vpmsumd		$Xl,$Xl,$xC2
+	vxor		$t1,$t1,$Xh
+	vxor		$IN1,$Xl,$t1
+
+	vsldoi		$H2,$IN1,$IN1,8
+	vsldoi		$H2l,$zero,$H2,8
+	vsldoi		$H2h,$H2,$zero,8
+
+	stvx_u		$H2l,r8,r3		# save H^2
+	li		r8,0x70
+	stvx_u		$H2,r9,r3
+	li		r9,0x80
+	stvx_u		$H2h,r10,r3
+	li		r10,0x90
+
+	vpmsumd		$Xl,$IN,$H2l		# H.lo�H^2.lo
+	 vpmsumd	$Xl1,$IN1,$H2l		# H^2.lo�H^2.lo
+	vpmsumd		$Xm,$IN,$H2		# H.hi�H^2.lo+H.lo�H^2.hi
+	 vpmsumd	$Xm1,$IN1,$H2		# H^2.hi�H^2.lo+H^2.lo�H^2.hi
+	vpmsumd		$Xh,$IN,$H2h		# H.hi�H^2.hi
+	 vpmsumd	$Xh1,$IN1,$H2h		# H^2.hi�H^2.hi
+
+	vpmsumd		$t2,$Xl,$xC2		# 1st reduction phase
+	 vpmsumd	$t6,$Xl1,$xC2		# 1st reduction phase
+
+	vsldoi		$t0,$Xm,$zero,8
+	vsldoi		$t1,$zero,$Xm,8
+	 vsldoi		$t4,$Xm1,$zero,8
+	 vsldoi		$t5,$zero,$Xm1,8
+	vxor		$Xl,$Xl,$t0
+	vxor		$Xh,$Xh,$t1
+	 vxor		$Xl1,$Xl1,$t4
+	 vxor		$Xh1,$Xh1,$t5
+
+	vsldoi		$Xl,$Xl,$Xl,8
+	 vsldoi		$Xl1,$Xl1,$Xl1,8
+	vxor		$Xl,$Xl,$t2
+	 vxor		$Xl1,$Xl1,$t6
+
+	vsldoi		$t1,$Xl,$Xl,8		# 2nd reduction phase
+	 vsldoi		$t5,$Xl1,$Xl1,8		# 2nd reduction phase
+	vpmsumd		$Xl,$Xl,$xC2
+	 vpmsumd	$Xl1,$Xl1,$xC2
+	vxor		$t1,$t1,$Xh
+	 vxor		$t5,$t5,$Xh1
+	vxor		$Xl,$Xl,$t1
+	 vxor		$Xl1,$Xl1,$t5
+
+	vsldoi		$H,$Xl,$Xl,8
+	 vsldoi		$H2,$Xl1,$Xl1,8
+	vsldoi		$Hl,$zero,$H,8
+	vsldoi		$Hh,$H,$zero,8
+	 vsldoi		$H2l,$zero,$H2,8
+	 vsldoi		$H2h,$H2,$zero,8
+
+	stvx_u		$Hl,r8,r3		# save H^3
+	li		r8,0xa0
+	stvx_u		$H,r9,r3
+	li		r9,0xb0
+	stvx_u		$Hh,r10,r3
+	li		r10,0xc0
+	 stvx_u		$H2l,r8,r3		# save H^4
+	 stvx_u		$H2,r9,r3
+	 stvx_u		$H2h,r10,r3
+
+	mtspr		256,$vrsave
+	blr
+	.long		0
+	.byte		0,12,0x14,0,0,0,2,0
+	.long		0
+.size	.gcm_init_htable,.-.gcm_init_htable
+
+.globl	.gcm_gmult_p8
+	lis		r0,0xfff8
+	li		r8,0x10
+	mfspr		$vrsave,256
+	li		r9,0x20
+	mtspr		256,r0
+	li		r10,0x30
+	lvx_u		$IN,0,$Xip		# load Xi
+
+	lvx_u		$Hl,r8,$Htbl		# load pre-computed table
+	 le?lvsl	$lemask,r0,r0
+	lvx_u		$H, r9,$Htbl
+	 le?vspltisb	$t0,0x07
+	lvx_u		$Hh,r10,$Htbl
+	 le?vxor	$lemask,$lemask,$t0
+	lvx_u		$xC2,0,$Htbl
+	 le?vperm	$IN,$IN,$IN,$lemask
+	vxor		$zero,$zero,$zero
+
+	vpmsumd		$Xl,$IN,$Hl		# H.lo�Xi.lo
+	vpmsumd		$Xm,$IN,$H		# H.hi�Xi.lo+H.lo�Xi.hi
+	vpmsumd		$Xh,$IN,$Hh		# H.hi�Xi.hi
+
+	vpmsumd		$t2,$Xl,$xC2		# 1st phase
+
+	vsldoi		$t0,$Xm,$zero,8
+	vsldoi		$t1,$zero,$Xm,8
+	vxor		$Xl,$Xl,$t0
+	vxor		$Xh,$Xh,$t1
+
+	vsldoi		$Xl,$Xl,$Xl,8
+	vxor		$Xl,$Xl,$t2
+
+	vsldoi		$t1,$Xl,$Xl,8		# 2nd phase
+	vpmsumd		$Xl,$Xl,$xC2
+	vxor		$t1,$t1,$Xh
+	vxor		$Xl,$Xl,$t1
+
+	le?vperm	$Xl,$Xl,$Xl,$lemask
+	stvx_u		$Xl,0,$Xip		# write out Xi
+
+	mtspr		256,$vrsave
+	blr
+	.long		0
+	.byte		0,12,0x14,0,0,0,2,0
+	.long		0
+.size	.gcm_gmult_p8,.-.gcm_gmult_p8
+
+.globl	.gcm_ghash_p8
+	lis		r0,0xfff8
+	li		r8,0x10
+	mfspr		$vrsave,256
+	li		r9,0x20
+	mtspr		256,r0
+	li		r10,0x30
+	lvx_u		$Xl,0,$Xip		# load Xi
+
+	lvx_u		$Hl,r8,$Htbl		# load pre-computed table
+	 le?lvsl	$lemask,r0,r0
+	lvx_u		$H, r9,$Htbl
+	 le?vspltisb	$t0,0x07
+	lvx_u		$Hh,r10,$Htbl
+	 le?vxor	$lemask,$lemask,$t0
+	lvx_u		$xC2,0,$Htbl
+	 le?vperm	$Xl,$Xl,$Xl,$lemask
+	vxor		$zero,$zero,$zero
+
+	lvx_u		$IN,0,$inp
+	addi		$inp,$inp,16
+	subi		$len,$len,16
+	 le?vperm	$IN,$IN,$IN,$lemask
+	vxor		$IN,$IN,$Xl
+	b		Loop
+
+.align	5
+Loop:
+	 subic		$len,$len,16
+	vpmsumd		$Xl,$IN,$Hl		# H.lo�Xi.lo
+	 subfe.		r0,r0,r0		# borrow?-1:0
+	vpmsumd		$Xm,$IN,$H		# H.hi�Xi.lo+H.lo�Xi.hi
+	 and		r0,r0,$len
+	vpmsumd		$Xh,$IN,$Hh		# H.hi�Xi.hi
+	 add		$inp,$inp,r0
+
+	vpmsumd		$t2,$Xl,$xC2		# 1st phase
+
+	vsldoi		$t0,$Xm,$zero,8
+	vsldoi		$t1,$zero,$Xm,8
+	vxor		$Xl,$Xl,$t0
+	vxor		$Xh,$Xh,$t1
+
+	vsldoi		$Xl,$Xl,$Xl,8
+	vxor		$Xl,$Xl,$t2
+	 lvx_u		$IN,0,$inp
+	 addi		$inp,$inp,16
+
+	vsldoi		$t1,$Xl,$Xl,8		# 2nd phase
+	vpmsumd		$Xl,$Xl,$xC2
+	 le?vperm	$IN,$IN,$IN,$lemask
+	vxor		$t1,$t1,$Xh
+	vxor		$IN,$IN,$t1
+	vxor		$IN,$IN,$Xl
+	beq		Loop			# did $len-=16 borrow?
+
+	vxor		$Xl,$Xl,$t1
+	le?vperm	$Xl,$Xl,$Xl,$lemask
+	stvx_u		$Xl,0,$Xip		# write out Xi
+
+	mtspr		256,$vrsave
+	blr
+	.long		0
+	.byte		0,12,0x14,0,0,0,4,0
+	.long		0
+.size	.gcm_ghash_p8,.-.gcm_ghash_p8
+
+.asciz  "GHASH for PowerISA 2.07, CRYPTOGAMS by <appro\@openssl.org>"
+.align  2
+___
+
+foreach (split("\n",$code)) {
+	if ($flavour =~ /le$/o) {	# little-endian
+	    s/le\?//o		or
+	    s/be\?/#be#/o;
+	} else {
+	    s/le\?/#le#/o	or
+	    s/be\?//o;
+	}
+	print $_,"\n";
+}
+
+close STDOUT; # enforce flush
-- 
2.31.1


