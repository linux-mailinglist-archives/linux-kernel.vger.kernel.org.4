Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89264D681
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLOGjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLOGjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:39:36 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50B4876B;
        Wed, 14 Dec 2022 22:39:35 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF526gf014205;
        Thu, 15 Dec 2022 06:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=1DDzeZH6s0CceZ3jMIt18KfkIYHpzJkKm7d81VrfBXE=;
 b=i3lDLix5P3tQMPD96uhBr+F6D7KAmjM2hd0nUKZww7HIVpBSva42dLfOBCqsD0aQdNp0
 CG8mQLCJFGYYUFxp0Ex3XD6hztrkcZePEDc5rtHNAVpJRGxy6YT3Nnu2tiZ/GfUDyk4z
 K9bYbCRbvn/8AQgWFs7S/3vaX0VONDYnyA3T5EgE4c4hARwzAjkILKJVj8aBRzoCNiwo
 mVQdToRW5tMEIV7UpH08hl0VJyHMWbWdZ8pvuqR6tB33j/2itiAeGbIPLmwyeG94J0KB
 /gSkx4EqYE2zirM4mliqB3RlnrJ61cOjaWtbH8jJ3Im9TU12BOXuWGW8b31eZl2TyBqT 1Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mfm57uu7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 06:39:30 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id DC030807131;
        Thu, 15 Dec 2022 06:39:29 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 89CA380C77C;
        Thu, 15 Dec 2022 06:39:29 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 2/8] doc: support kernel-doc for asm functions
Date:   Thu, 15 Dec 2022 00:38:51 -0600
Message-Id: <20221215063857.161665-3-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215063857.161665-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: T3aVu_cFQCLclcq6Mryyelc1M6rhVEW9
X-Proofpoint-ORIG-GUID: T3aVu_cFQCLclcq6Mryyelc1M6rhVEW9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support kernel-doc comments in assembly language files for functions
called by C functions.

The comment must include a line containing:
    * Prototype: asmlinkage ... rest of C prototype...

and that function name must match the name used in line like:
    SYM_FUNC_START(name)
    SYM_FUNC_START_SOMETHING(name)

or
    SOMETHING name

which is used in a few places in which SYM_FUNC_START is nested.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/kernel-doc | 48 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index aea04365bc69..f3a89301e3ab 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -174,6 +174,7 @@ my %nosymbol_table = ();
 my $declaration_start_line;
 my ($type, $declaration_name, $return_type);
 my ($newsection, $newcontents, $prototype, $brcount, %source_map);
+my %asmprototypes;
 
 if (defined($ENV{'KBUILD_VERBOSE'})) {
 	$verbose = "$ENV{'KBUILD_VERBOSE'}";
@@ -248,7 +249,7 @@ my $doc_decl = $doc_com . '(\w+)';
 # while trying to not match literal block starts like "example::"
 #
 my $doc_sect = $doc_com .
-    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$';
+    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|prototype|notes?|examples?)\s*:([^:].*)?$';
 my $doc_content = $doc_com_body . '(.*)';
 my $doc_block = $doc_com . 'DOC:\s*(.*)?';
 my $doc_inline_start = '^\s*/\*\*\s*$';
@@ -277,6 +278,7 @@ my $section_intro = "Introduction";
 my $section = $section_default;
 my $section_context = "Context";
 my $section_return = "Return";
+my $section_asmprototype = "Prototype";
 
 my $undescribed = "-- undescribed --";
 
@@ -468,6 +470,13 @@ sub dump_section {
             $new_start_line = 0;
 	}
     }
+
+    if ($name eq $section_asmprototype) {
+        # extract the function name for future matching to SYM_FUNC_START.*(name)
+        # since that doesn't include arguments like a C function call
+        my ($func) = ($contents =~ /^.*\s+(\S+)\(/);
+	$asmprototypes{$func} = $contents;
+    }
 }
 
 ##
@@ -1848,9 +1857,31 @@ sub syscall_munge() {
 sub process_proto_function($$) {
     my $x = shift;
     my $file = shift;
+    my $funcname;
 
     $x =~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
 
+    # support asm functions declared with one of these starting in
+    # the first column:
+    #     SYM_FUNC_START(name)
+    #     SYM_FUNC_START_LOCAL(name)
+    #     SYM_FUNC_START_WEAK(name)
+    # or for nested macros:
+    #     SOMESTRING<whitespace>name
+    if ($file =~ /\.S$/) {
+        if ($x =~ /^SYM_FUNC_START/) {
+	    ($funcname) = ($x =~ /^SYM_FUNC_START.*\((.*)\)/);
+        } elsif ($x =~ /^[A-Za-z0-9_]+\s+[A-Za-z0-9_]+/) {
+	    ($funcname) = ($x =~ /^[A-Za-z0-9_]+\s+([A-Za-z0-9_]+)/);
+        }
+    }
+    if (defined $funcname) {
+	$prototype = $asmprototypes{$funcname};
+	dump_function($asmprototypes{$funcname}, $file);
+	reset_state();
+	return;
+    }
+
     if ($x =~ m#\s*/\*\s+MACDOC\s*#io || ($x =~ /^#/ && $x !~ /^#\s*define/)) {
 	# do nothing
     }
@@ -2085,6 +2116,8 @@ sub process_body($$) {
 	    $newsection = $section_default;
 	} elsif ($newsection =~ m/^context$/i) {
 	    $newsection = $section_context;
+	} elsif ($newsection =~ m/^prototype$/i) {
+	    $newsection = $section_asmprototype;
 	} elsif ($newsection =~ m/^returns?$/i) {
 	    $newsection = $section_return;
 	} elsif ($newsection =~ m/^\@return$/) {
@@ -2135,6 +2168,16 @@ sub process_body($$) {
 		$contents = "";
 		$new_start_line = $.;
 		$state = STATE_BODY;
+	    } elsif ($section eq $section_asmprototype) {
+		my ($protoline) = /Prototype:\s+(.+)$/;
+		my ($funcname) = $protoline =~ /Prototype\.*\s+(\S+)\(/;
+
+		$asmprototypes{$funcname} = $protoline;
+		dump_section($file, $section, $contents);
+		$section = $section_default;
+		$contents = "";
+		$new_start_line = $.;
+		$state = STATE_BODY;
 	    } else {
 		if ($section ne $section_default) {
 		    $state = STATE_BODY_WITH_BLANK_LINE;
@@ -2150,7 +2193,7 @@ sub process_body($$) {
 	    $declaration_purpose =~ s/\s+/ /g;
 	} else {
 	    my $cont = $1;
-	    if ($section =~ m/^@/ || $section eq $section_context) {
+	    if ($section =~ m/^@/ || $section eq $section_context || $section eq $section_asmprototype) {
 		if (!defined $leading_space) {
 		    if ($cont =~ m/^(\s+)/) {
 			$leading_space = $1;
@@ -2286,6 +2329,7 @@ sub process_file($) {
 	}
 	# Replace tabs by spaces
         while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
+
 	# Hand this line to the appropriate state handler
 	if ($state == STATE_NORMAL) {
 	    process_normal();
-- 
2.38.1

