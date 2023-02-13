Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B07F69500F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjBMS5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBMS5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:46 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE9DBEE;
        Mon, 13 Feb 2023 10:57:45 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-16debd2786aso6418684fac.7;
        Mon, 13 Feb 2023 10:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2Ija/xk/Xo2pgXxKw0oJtRB4E5NlGaSmHRfzbCfeiQ=;
        b=Xd6GCFHfxB5FndpuQ2ZmtVl7YnsK2pEcHH4HNYPU10TMvtQZ2tnTN8Id5adCWNTzN7
         nRRQcfjQ9WDSQYxA7uvOQwOrmDSk9ec5ZLk2N0g5gsDVG9GLtKPJSMIPQnieoU26/Tn4
         PZhiJapmfRLK1q7/22I3+sAd2I8jMKSyEX53jUde2LA+vVJv+h5R25d2bGonYd07dL+e
         3jIG47LwbIVSzP2279Fo/1DG8XXae3HtE4vgS26HJH3TVWQJmVn35cC6lBHl1pnT+HQK
         OLCr2s3iRQy9YY5750lI6FJ2wBgzJyglW4CDOF3IwD2V7rBIBVEZeFHYU/7tzP/N7XPg
         dgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2Ija/xk/Xo2pgXxKw0oJtRB4E5NlGaSmHRfzbCfeiQ=;
        b=XLV/RRL7FdJc3CxCIXlSnpXx17dFoHdsroFRxE63xnyST5RjMMAM3BW//3l34hj8ys
         09cjhRr6MYW5L5xflBJoGM5WewgtqQx/nyniRcp8j/b85ZcSS9qwQFFJ6xz8CZDH8Ojx
         vJyN1qWHbf8bw6gOw1vEmuBjVSS/UgsCLR6uyebCOyyN2faZm+n0pYceBnsKEyfiNcyO
         jf4kYDgWEGeFofKfwHZHW2zFgy11cKAvSuoNlRWBp+DRA64YQCW6G01qWHT/VA4eBSbf
         jEcW+OMpHVu+ggRpKy0d3s1y7JzcNP6I85aAZ7RCcQi+15ZWulzOVwv5nK3AGteHt0Dq
         6CEg==
X-Gm-Message-State: AO0yUKXUxvXt6h8OYzsBnsXZp+dYG+kjETqT/t6osbmoZJsq6e80KKeP
        H0Os3kddvCWBpm2tDei4r34=
X-Google-Smtp-Source: AK7set+2KTSjrciPJXnLbIcpDg/Dc9KYl0dZzhIzEXl/nO5RZ8kM0Zg8PjBl6OukL5JyU+Ni0rtiJw==
X-Received: by 2002:a05:6871:68e:b0:16e:121b:7e69 with SMTP id l14-20020a056871068e00b0016e121b7e69mr2198173oao.6.1676314664899;
        Mon, 13 Feb 2023 10:57:44 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:5829:dabf:a50e:e9f2])
        by smtp.gmail.com with ESMTPSA id ef15-20020a0568701a8f00b0016df97ab05bsm1654958oab.31.2023.02.13.10.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:57:44 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] of: add processing of EXPECT_NOT to of_unittest_expect
Date:   Mon, 13 Feb 2023 12:56:57 -0600
Message-Id: <20230213185702.395776-3-frowand.list@gmail.com>
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

This is commit 2 of 2, implementing the processing of EXPECT_NOT
messages.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
 scripts/dtc/of_unittest_expect | 157 ++++++++++++++++++++++++++++++---
 1 file changed, 145 insertions(+), 12 deletions(-)

diff --git a/scripts/dtc/of_unittest_expect b/scripts/dtc/of_unittest_expect
index 7b25bb693162..0a535a8e9821 100755
--- a/scripts/dtc/of_unittest_expect
+++ b/scripts/dtc/of_unittest_expect
@@ -9,7 +9,7 @@
 # on the console log that results from executing the Linux kernel
 # devicetree unittest (drivers/of/unitest.c).
 
-$VUFX = "230121a";
+$VUFX = "230211a";
 
 use strict 'refs';
 use strict subs;
@@ -62,6 +62,8 @@ sub compare {
 			} else {
 				return 0;
 			}
+		} elsif ($type eq "all") {
+			return 1;
 		} elsif ($type eq "") {
 			if ($expect_next ne $got_next) {
 				return 0;
@@ -130,6 +132,7 @@ usage:
 
      <<int>> matches: [+-]*[0-9]+
      <<hex>> matches: (0x)*[0-9a-f]+
+     <<all>> matches: anything to end of line
 
   'EXPECT \\' (begin) and 'EXPECT /' (end) lines are suppressed.
 
@@ -240,6 +243,8 @@ if ($#ARGV != 0) {
 $pr_fmt = "### dt-test ### ";
 $exp_begin = "${pr_fmt}EXPECT \\\\ : ";
 $exp_end   = "${pr_fmt}EXPECT / : ";
+$expnot_begin = "${pr_fmt}EXPECT_NOT \\\\ : ";
+$expnot_end   = "${pr_fmt}EXPECT_NOT / : ";
 
 
 $line_num = "";
@@ -250,6 +255,8 @@ while ($line = <ARGV>) {
 
 	chomp $line;
 
+	$suppress_line = 0;
+
 	$prefix = "  ";  ## 2 characters
 
 
@@ -306,6 +313,7 @@ while ($line = <ARGV>) {
 			$begin = pop @exp_found_or_begin;
 			if (compare($data, $begin)) {
 				$found = 1;
+				$exp_found++;
 			}
 		} elsif (@begin > 0) {
 			$begin = pop @exp_begin_stack;
@@ -316,7 +324,7 @@ while ($line = <ARGV>) {
 		if ($no_begin) {
 
 			$exp_missing_begin++;
-			print "** ERROR: EXPECT end without any EXPECT begin:\n";
+			print "** ERROR: EXPECT end without matching EXPECT begin:\n";
 			print "       end ---> $line\n";
 
 		} elsif (! $found) {
@@ -329,17 +337,97 @@ while ($line = <ARGV>) {
 			printf "** %s%s$script_name WARNING - not found ---> %s\n",
 					$line_num,  $timestamp, $data;
 
-		} elsif (! compare($data, $begin)) {
+		} elsif (! compare($data, $begin) and ($data ne $begin)) {
 
 			$exp_missing_end++;
 			print "** ERROR: EXPECT end does not match EXPECT begin:\n";
 			print "       begin -> $begin\n";
 			print "       end ---> $line\n";
 
+		}
+
+		next LINE;
+	}
+
+
+	# -----  find EXPECT_NOT begin
+
+	if ($line =~ /^\s*$expnot_begin/) {
+		$data = $line;
+		$data =~ s/^\s*$expnot_begin//;
+		push @expnot_begin_stack, $data;
+
+		if ($verbose) {
+			if ($print_line_num) {
+				$line_num = sprintf("%4s ", $.);
+			}
+			printf "%s %s%s%s\n", $prefix, $line_num,  $timestamp, $line;
+		}
+
+		next LINE;
+	}
+
+
+	# -----  find EXPECT_NOT end
+
+	if ($line =~ /^\s*$expnot_end/) {
+		$data = $line;
+		$data =~ s/^\s*$expnot_end//;
+
+		if ($verbose) {
+			if ($print_line_num) {
+				$line_num = sprintf("%4s ", $.);
+			}
+			printf "%s %s%s%s\n", $prefix, $line_num,  $timestamp, $line;
+		}
+
+		$found = 0;
+		$no_begin = 0;
+		if (@expnot_found_or_begin > 0) {
+			$begin = pop @expnot_found_or_begin;
+			if (compare($data, $begin)) {
+				$found = 1;
+				$expnot_found++;
+			}
+		} elsif (@expnot_begin_stack <= 0) {
+			$no_begin = 1;
+		}
+
+		if ($no_begin) {
+
+			$expnot_missing_begin++;
+			print "** ERROR: EXPECT_NOT end without matching EXPECT_NOT begin:\n";
+			print "       end ---> $line\n";
+
+		}
+
+		if ($found) {
+
+			if ($print_line_num) {
+				$line_num = sprintf("%4s ", $.);
+			}
+
+			printf "** %s%s$script_name WARNING - next line matches EXPECT_NOT\n",
+					$line_num,  $timestamp;
+			printf "** %s%s%s\n", $line_num,  $timestamp, $line;
+
 		} else {
 
-			$exp_found++;
+			$expnot_missing++;
+
+		}
+
+		if (@expnot_begin_stack > 0) {
+			$begin = pop @expnot_begin_stack;
+
+			if (! compare($data, $begin) and ($data ne $begin)) {
 
+				$expnot_missing_end++;
+				print "** ERROR: EXPECT_NOT end does not match EXPECT_NOT begin:\n";
+				print "       begin -> $begin\n";
+				print "       end ---> $line\n";
+
+			}
 		}
 
 		next LINE;
@@ -374,12 +462,38 @@ while ($line = <ARGV>) {
 
 		if ($hide_expect) {
 			$suppress_line = 1;
-			next LINE;
 		}
 		$prefix = "ok"; # 2 characters
 	}
 
 
+	$found = 0;
+	foreach $begin (@expnot_begin_stack) {
+		if (compare($begin, $line)) {
+			$found = 1;
+			last;
+		}
+	}
+
+	if ($found) {
+		$begin = shift @begin;
+		while (! compare($begin, $line)) {
+			push @expnot_found_or_begin, $begin;
+			$begin = shift @begin;
+		}
+		push @expnot_found_or_begin, $line;
+
+		if ($hide_expect) {
+			$suppress_line = 1;
+		}
+		$prefix = "**"; # 2 characters
+	}
+
+
+	if ($suppress_line) {
+		next LINE;
+	}
+
 	if ($print_line_num) {
 		$line_num = sprintf("%4s ", $.);
 	}
@@ -391,18 +505,37 @@ if (! $no_expect_stats) {
 	print  "\n";
 	print  "** EXPECT statistics:\n";
 	print  "**\n";
-	printf "**   EXPECT found          : %4i\n", $exp_found;
-	printf "**   EXPECT not found      : %4i\n", $exp_missing;
-	printf "**   missing EXPECT begin  : %4i\n", $exp_missing_begin;
-	printf "**   missing EXPECT end    : %4i\n", $exp_missing_end;
-	printf "**   unittest FAIL         : %4i\n", $unittest_fail;
-	printf "**   internal error        : %4i\n", $internal_err;
+	printf "**   non-zero values expected:\n";
+	print  "**\n";
+	printf "**     EXPECT found              : %4i\n", $exp_found;
+	printf "**     EXPECT_NOT not found      : %4i\n", $expnot_missing;
+	print  "**\n";
+	printf "**   zero values expected:\n";
+	print  "**\n";
+	printf "**     EXPECT not found          : %4i\n", $exp_missing;
+	printf "**     missing EXPECT begin      : %4i\n", $exp_missing_begin;
+	printf "**     missing EXPECT end        : %4i\n", $exp_missing_end;
+	print  "**\n";
+	printf "**     EXPECT_NOT found          : %4i\n", $expnot_found;
+	printf "**     missing EXPECT_NOT begin  : %4i\n", $expnot_missing_begin;
+	printf "**     missing EXPECT_NOT end    : %4i\n", $expnot_missing_end;
+	print  "**\n";
+	printf "**     unittest FAIL             : %4i\n", $unittest_fail;
+	printf "**     internal error            : %4i\n", $internal_err;
 }
 
 if (@exp_begin_stack) {
-	print "** ERROR: EXPECT begin without any EXPECT end:\n";
+	print "** ERROR: EXPECT begin without matching EXPECT end:\n";
 	print "          This list may be misleading.\n";
 	foreach $begin (@exp_begin_stack) {
 		print "       begin ---> $begin\n";
 	}
 }
+
+if (@expnot_begin_stack) {
+	print "** ERROR: EXPECT_NOT begin without matching EXPECT_NOT end:\n";
+	print "          This list may be misleading.\n";
+	foreach $begin (@expnot_begin_stack) {
+		print "       begin ---> $begin\n";
+	}
+}
-- 
Frank Rowand <frowand.list@gmail.com>

