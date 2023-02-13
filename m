Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3C69500E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjBMS5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBMS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:45 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58EC1CAFA;
        Mon, 13 Feb 2023 10:57:44 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1442977d77dso16297431fac.6;
        Mon, 13 Feb 2023 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx9tTMJiSK3aN1a8Ha38HJ8pQWFwoYnzXFo+Xp9k7Yc=;
        b=kdbR0U1uF6p9WpZYN9ndpHtdCvfkSHBZ3woLf3cQlVZh2ABRW2Zog/kv7JvC5k9MIJ
         y5e33kUGQk98Jwbe9Jkthe7mUM6aupcdEz4/GAvQ+UTkDs0xVLoNyCL5KAI0/T14qmih
         U73Zn+c1x0i7SUOfcfRsZQGhYRUSo3zwWyHWdDmHwPOXFp0Chhz3j6b27poHm+0+CNtZ
         uO94syer0odfNfw/L6HWcaOp3DQde+QnHtQRdtKvQnGGLqo+ZcvJOE+W8FV3RxDk5cC5
         PWti4cip0uV/tvxuWMUkq2Z2SfE1HBoppSAvK8vk20SAyP404zmC/+uUn8vSsEhlNVoc
         t3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nx9tTMJiSK3aN1a8Ha38HJ8pQWFwoYnzXFo+Xp9k7Yc=;
        b=5U3ffZ+iSX42dVFDGy4Y5Na7nPCaOWBLocjZoV4213Ehe+6HtoFZxgvX/uHvq07UlH
         EPaiXF4j2HfYQ7/BE/YfnkxUWu2uhuQM3bfcEkbXvYLoTqAlPFSZj9LEhZDqeNhk1+NA
         0bpO2vGgjNCj4bVPhpJB0DNAvUI/QDwkE0rguQwCTc49NNdKydZ5aK5AFAhF+8WOwEbt
         mSvijSQE0vnIQHun9bYhtbjp1vwdJUsFi+ZB4cVcfQFP+isdVYsvJg6V0+EI+l7v/6lJ
         XMdMcjUT6c6jXmYoi6w3EbLpL5MM5L6qL7qtLPazUw/UNTccdixG+c/XcvBE6xsxRIma
         ILrA==
X-Gm-Message-State: AO0yUKUrAoSf/hvLkrajMznkiGQ9kSyI5PrLWxG1xuYBuGBsw6AUPWA7
        17O2UrlyZVoRi+1GFTuSrT8=
X-Google-Smtp-Source: AK7set9PSQDnsRqLvoRE0toOk3rUH3JLz0pYserqe4XcU8n6Y26J97wWJxDU0bz8tf5fidFmlrGaeQ==
X-Received: by 2002:a05:6870:8a20:b0:16e:676:bfea with SMTP id p32-20020a0568708a2000b0016e0676bfeamr2598306oaq.9.1676314664010;
        Mon, 13 Feb 2023 10:57:44 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:5829:dabf:a50e:e9f2])
        by smtp.gmail.com with ESMTPSA id ef15-20020a0568701a8f00b0016df97ab05bsm1654958oab.31.2023.02.13.10.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:57:43 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] of: prepare to add processing of EXPECT_NOT to of_unittest_expect
Date:   Mon, 13 Feb 2023 12:56:56 -0600
Message-Id: <20230213185702.395776-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185702.395776-1-frowand.list@gmail.com>
References: <20230213185702.395776-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/dtc/of_unittest_expect processes EXPECT messages that
document expected kernel messages triggered by unittest.  Add
processing of EXPECT_NOT messages that document kernel messages
triggered by unittest that are not expected.

This is commit 1 of 2, renaming existing variables in anticipation
of the changes needed to process EXPECT_NOT, so that commit 2 of 2
will be smaller and easier to read.  This commit is not intended
to make any functional changes.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
 scripts/dtc/of_unittest_expect | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/dtc/of_unittest_expect b/scripts/dtc/of_unittest_expect
index 96b12d9ea606..7b25bb693162 100755
--- a/scripts/dtc/of_unittest_expect
+++ b/scripts/dtc/of_unittest_expect
@@ -9,7 +9,7 @@
 # on the console log that results from executing the Linux kernel
 # devicetree unittest (drivers/of/unitest.c).
 
-$VUFX = "220201a";
+$VUFX = "230121a";
 
 use strict 'refs';
 use strict subs;
@@ -274,7 +274,7 @@ while ($line = <ARGV>) {
 	if ($line =~ /^\s*$exp_begin/) {
 		$data = $line;
 		$data =~ s/^\s*$exp_begin//;
-		push @begin, $data;
+		push @exp_begin_stack, $data;
 
 		if ($verbose) {
 			if ($print_line_num) {
@@ -302,20 +302,20 @@ while ($line = <ARGV>) {
 
 		$found = 0;
 		$no_begin = 0;
-		if (@found_or_begin > 0) {
-			$begin = pop @found_or_begin;
+		if (@exp_found_or_begin > 0) {
+			$begin = pop @exp_found_or_begin;
 			if (compare($data, $begin)) {
 				$found = 1;
 			}
 		} elsif (@begin > 0) {
-			$begin = pop @begin;
+			$begin = pop @exp_begin_stack;
 		} else {
 			$no_begin = 1;
 		}
 
 		if ($no_begin) {
 
-			$expect_missing_begin++;
+			$exp_missing_begin++;
 			print "** ERROR: EXPECT end without any EXPECT begin:\n";
 			print "       end ---> $line\n";
 
@@ -325,20 +325,20 @@ while ($line = <ARGV>) {
 				$line_num = sprintf("%4s ", $.);
 			}
 
-			$expect_not_found++;
+			$exp_missing++;
 			printf "** %s%s$script_name WARNING - not found ---> %s\n",
 					$line_num,  $timestamp, $data;
 
 		} elsif (! compare($data, $begin)) {
 
-			$expect_missing_end++;
+			$exp_missing_end++;
 			print "** ERROR: EXPECT end does not match EXPECT begin:\n";
 			print "       begin -> $begin\n";
 			print "       end ---> $line\n";
 
 		} else {
 
-			$expect_found++;
+			$exp_found++;
 
 		}
 
@@ -357,7 +357,7 @@ while ($line = <ARGV>) {
 	}
 
 	$found = 0;
-	foreach $begin (@begin) {
+	foreach $begin (@exp_begin_stack) {
 		if (compare($begin, $line)) {
 			$found = 1;
 			last;
@@ -365,12 +365,12 @@ while ($line = <ARGV>) {
 	}
 
 	if ($found) {
-		$begin = shift @begin;
+		$begin = shift @exp_begin_stack;
 		while (! compare($begin, $line)) {
-			push @found_or_begin, $begin;
-			$begin = shift @begin;
+			push @exp_found_or_begin, $begin;
+			$begin = shift @exp_begin_stack;
 		}
-		push @found_or_begin, $line;
+		push @exp_found_or_begin, $line;
 
 		if ($hide_expect) {
 			$suppress_line = 1;
@@ -391,18 +391,18 @@ if (! $no_expect_stats) {
 	print  "\n";
 	print  "** EXPECT statistics:\n";
 	print  "**\n";
-	printf "**   EXPECT found          : %4i\n", $expect_found;
-	printf "**   EXPECT not found      : %4i\n", $expect_not_found;
-	printf "**   missing EXPECT begin  : %4i\n", $expect_missing_begin;
-	printf "**   missing EXPECT end    : %4i\n", $expect_missing_end;
+	printf "**   EXPECT found          : %4i\n", $exp_found;
+	printf "**   EXPECT not found      : %4i\n", $exp_missing;
+	printf "**   missing EXPECT begin  : %4i\n", $exp_missing_begin;
+	printf "**   missing EXPECT end    : %4i\n", $exp_missing_end;
 	printf "**   unittest FAIL         : %4i\n", $unittest_fail;
 	printf "**   internal error        : %4i\n", $internal_err;
 }
 
-if (@begin) {
+if (@exp_begin_stack) {
 	print "** ERROR: EXPECT begin without any EXPECT end:\n";
 	print "          This list may be misleading.\n";
-	foreach $begin (@begin) {
+	foreach $begin (@exp_begin_stack) {
 		print "       begin ---> $begin\n";
 	}
 }
-- 
Frank Rowand <frowand.list@gmail.com>

