Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BBB634CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiKWBOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiKWBNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:13:37 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25926FB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:12:27 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN0xhlB017115;
        Wed, 23 Nov 2022 01:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=qVouojN9cstmnjrsvce7aW4C98dm2Ear/s92uJ0hoEs=;
 b=VnJZms42mLdYNRFbc2KOkMN8QmoxNntu4idT2ZmxNvlCGVi4fhBQrQT/42ZwbeYp9dPp
 GM/lBeAya91wj05de5zEbvoRsVYqt72ivT3BxfycQl1ga3jZIhWTplHus9DIUpHonubl
 IeoTMudREaXa479IEX0tldp4neIsNSqM/SlTGjhdjQ18B5HmoYGvEthikCl6wDYsD3ij
 Y1OGxb84IwSaVn1QO0yRywfb+smATogbAk0X4lsYTFii9Lk5HYUPoT/wVDG5wdObrGCB
 BmtXX5lbRJ4d5OMxxhQhaapH1aoBEbUVbgc7qWhU6UQ0+zSPTgHGC97XWRrGnxwjnM5C 3A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m19ebg2x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 01:12:23 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B3D8D8066C6;
        Wed, 23 Nov 2022 01:12:22 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6916680037B;
        Wed, 23 Nov 2022 01:12:22 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 4/5] checkpatch: discard processed lines
Date:   Tue, 22 Nov 2022 19:12:01 -0600
Message-Id: <20221123011202.939319-5-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123011202.939319-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
 <20221123011202.939319-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MM2LWR7p7xorESY3mFSTyIs1UBki2eO5
X-Proofpoint-GUID: MM2LWR7p7xorESY3mFSTyIs1UBki2eO5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 mlxlogscore=377 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advance the line numbers so messages don't repeat previously
processed lines.

Before:
	WARNING: please write 4 lines of help text that fully describes the
	config symbol (detected 3 lines)
	#195: FILE: crypto/Kconfig:837:
	+config CRYPTO_GHASH_CLMUL_NI_INTEL
	+       tristate "GHASH (x86_64 with CLMUL-NI)"
		depends on X86 && 64BIT
	+       select CRYPTO_CRYPTD
	+       select CRYPTO_CRYPTD
	+       select CRYPTO_CRYPTD
		help
	+         GCM GHASH hash function (NIST SP800-38D)
	+         GCM GHASH hash function (NIST SP800-38D)

		  Architecture: x86_64 using:
	+         * CLMUL-NI (carry-less multiplication new instructions)
	+         * CLMUL-NI (carry-less multiplication new instructions)
	+         * CLMUL-NI (carry-less multiplication new instructions)

	+config CRYPTO_GHASH_S390
	+config CRYPTO_GHASH_S390
	+config CRYPTO_GHASH_S390
	+config CRYPTO_GHASH_S390

After:
	WARNING: please write 4 lines of help text that fully describes the
	config symbol (detected 3 lines)
	#195: FILE: crypto/Kconfig:837:
	+config CRYPTO_GHASH_CLMUL_NI_INTEL
	+       tristate "GHASH (x86_64 with CLMUL-NI)"
		depends on X86 && 64BIT
	+       select CRYPTO_CRYPTD
		help
	+         GCM GHASH hash function (NIST SP800-38D)

		  Architecture: x86_64 using:
	+         * CLMUL-NI (carry-less multiplication new instructions)

	+config CRYPTO_GHASH_S390

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b7a98adcaeb..d11d58e36ee9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1971,21 +1971,25 @@ sub raw_line {
 	$cnt++;
 
 	my $line;
+	my $consumed;
 	while ($cnt) {
 		$line = $rawlines[$offset++];
+		$consumed++;
 		next if (defined($line) && $line =~ /^-/);
 		$cnt--;
 	}
 
-	return $line;
+	return ($line, $consumed);
 }
 
 sub get_stat_real {
 	my ($linenr, $lc) = @_;
 
-	my $stat_real = raw_line($linenr, 0);
+	my ($stat_real, $consumed) = raw_line($linenr, 0);
 	for (my $count = $linenr + 1; $count <= $lc; $count++) {
-		$stat_real = $stat_real . "\n" . raw_line($count, 0);
+		my ($more, $consumed) = raw_line($count, 0);
+		$stat_real = $stat_real . "\n" . $more;
+		$count += $consumed - 1;
 	}
 
 	return $stat_real;
@@ -1996,7 +2000,8 @@ sub get_stat_here {
 
 	my $herectx = $here . "\n";
 	for (my $n = 0; $n < $cnt; $n++) {
-		$herectx .= raw_line($linenr, $n) . "\n";
+		my ($more, $consumed) = raw_line($linenr, $n);
+		$herectx .= $more . "\n";
 	}
 
 	return $herectx;
@@ -4323,7 +4328,7 @@ sub process {
 			}
 
 			my (undef, $sindent) = line_stats("+" . $s);
-			my $stat_real = raw_line($linenr, $cond_lines);
+			my ($stat_real, $consumed) = raw_line($linenr, $cond_lines);
 
 			# Check if either of these lines are modified, else
 			# this is not this patch's fault.
@@ -5420,7 +5425,7 @@ sub process {
 					$herectx = $here . "\n";
 					my $cnt = statement_rawlines($if_stat);
 					for (my $n = 0; $n < $cnt; $n++) {
-						my $rl = raw_line($linenr, $n);
+						my ($rl, $consumed) = raw_line($linenr, $n);
 						$herectx .=  $rl . "\n";
 						last if $rl =~ /^[ \+].*\{/;
 					}
@@ -5617,8 +5622,9 @@ sub process {
 				my $cond_lines = 1 + $#newlines;
 				my $stat_real = '';
 
-				$stat_real = raw_line($linenr, $cond_lines)
-							. "\n" if ($cond_lines);
+				my $consumed;
+				($stat_real, $consumed) = raw_line($linenr, $cond_lines)
+							           . "\n" if ($cond_lines);
 				if (defined($stat_real) && $cond_lines > 1) {
 					$stat_real = "[...]\n$stat_real";
 				}
@@ -7024,7 +7030,7 @@ sub process {
 			my $cnt = statement_rawlines($stat);
 			my $herectx = $here . "\n";
 			for (my $n = 0; $n < $cnt; $n++) {
-				my $rl = raw_line($linenr, $n);
+				my ($rl, $consumed) = raw_line($linenr, $n);
 				$herectx .=  $rl . "\n";
 				$ok = 1 if ($rl =~ /^[ \+]\{/);
 				$ok = 1 if ($rl =~ /\{/ && $n == 0);
-- 
2.38.1

