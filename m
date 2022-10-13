Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789C5FE49A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJMV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJMV6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:58:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BEBB1DF1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:58:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so3061016pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=7rCkn9jK5l0UbesP3+Ce+8gzCsYUhag1x17HoTBJI/4=;
        b=Bd5MANJdFPf7AAPWzhjx8DS8Ad1Fihxg8XpuuWgzMF3mM8ig4dYismUPALwegG2Ii9
         jR1SkFDzMmgnMPgGGOPFY36c/c1OYknQVPtQbIcC6VRG8sEhbPTdgINWCLxsTMQ5CFCC
         uO08684sdudbseuckZV95KSkORuPemJCWTsh356bMYGH6oEOrdEIRE0IdIrxtGxDDOoQ
         kDPk4WkFV3734A6ctSYzJ9Xq3r5PXYOvgLBADqSGyTmpeqjI60cNGIdIlB5X+514toDw
         f4y4/vr/i9T+m/5wKX4A4dsFXMfkiQCacvVOZCnUP2f+byjb7zbDonNbKEId4xZqYhnj
         H0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rCkn9jK5l0UbesP3+Ce+8gzCsYUhag1x17HoTBJI/4=;
        b=yi8E+uPss58X6PRIJQ3vpOx8qU3L/Szkl7V0XjtNccmkvCZp7A+tIPPniCNPUiDiKw
         xISeyeqc440l4uPUl1zJ0XK82s9e/SoIFIfa+vcL4PncRHIYxZ5cnENvH9V90d3ay0L4
         0CfBtgT97CxcAE7YrzcdklLt9XoX0PruIJySZn7NpmK+EKGrO84I9LPKHph6FldOnHtb
         6ZfxtS+PldoAz75gc75B3WbPvUYNAxQqdpUekd4gZCDVxKSzdthGPQLuq+PK/+Uk/cNw
         N6Nvb36OGyEGStN7fMgqe0xpxS22k3w6REsM5eg5Cd/BUPe/eGk6tiDhnvny9itqgV+V
         VI9Q==
X-Gm-Message-State: ACrzQf1t6eC+jv8AEwv+ORZJl8Pf0i+suFpMZ/MBPAZl7IOaW7M3daJx
        t+b9bFtQV7uTsiy0TgLMIX8g5CdQGgOSVzOM
X-Google-Smtp-Source: AMsMyM4SRC6xnMWj/gwE8eZ+Q3U24gEYPJOYp/vdSetGB94EYLZjmaejWcDXYSPyBh8ObAxpXsrnfw==
X-Received: by 2002:a17:903:2402:b0:184:29:8ac0 with SMTP id e2-20020a170903240200b0018400298ac0mr1999186plo.174.1665698279505;
        Thu, 13 Oct 2022 14:57:59 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id i6-20020a628706000000b00553b37c7732sm175476pfe.105.2022.10.13.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:57:59 -0700 (PDT)
Subject: [PATCH] get_maintainer: Add the --for-tree argument
Date:   Thu, 13 Oct 2022 14:57:38 -0700
Message-Id: <20221013215738.32326-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     joe@perches.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently wanted to look up the maintainers for each tree path via a
script, and I couldn't find a better way to do that than poking
get_maintainer.pl to add a new argument.  This lets folks run something
like

    $ ./scripts/get_maintainer.pl --for-tree git://github.com/kvm-riscv/linux.git
    Anup Patel <anup@brainfault.org> (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
    kvm@vger.kernel.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
    kvm-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
    linux-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))

to find out who owns a tree.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 scripts/get_maintainer.pl | 48 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..70abefadd295 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -23,6 +23,7 @@ use File::Spec::Functions;
 
 my $cur_path = fastgetcwd() . '/';
 my $lk_path = "./";
+my $for_tree = undef;
 my $email = 1;
 my $email_usename = 1;
 my $email_maintainer = 1;
@@ -239,6 +240,7 @@ if ($#ARGV > 0) {
 
 if (!GetOptions(
 		'email!' => \$email,
+		'for-tree=s' => \$for_tree,
 		'git!' => \$email_git,
 		'git-all-signature-types!' => \$email_git_all_signature_types,
 		'git-blame!' => \$email_git_blame,
@@ -300,7 +302,7 @@ if (defined $self_test) {
     exit 0;
 }
 
-if (-t STDIN && !@ARGV) {
+if (-t STDIN && !@ARGV && !$for_tree) {
     # We're talking to a terminal, but have no command line arguments.
     die "$P: missing patchfile or -f file - use --help if necessary\n";
 }
@@ -527,7 +529,7 @@ sub read_mailmap {
 
 ## use the filenames on the command line or find the filenames in the patchfiles
 
-if (!@ARGV) {
+if (!@ARGV && !$for_tree) {
     push(@ARGV, "&STDIN");
 }
 
@@ -951,6 +953,47 @@ sub get_maintainers {
 	}
     }
 
+    if ($for_tree) {
+        my $tvi = find_first_section();
+        while ($tvi < @typevalue) {
+            my $start = find_starting_index($tvi);
+            my $end = find_ending_index($tvi);
+            $tvi = $end + 1;
+
+            my $i;
+            my $tree_match = 0;
+            for ($i = $start; $i < $end; $i++) {
+                my $line = $typevalue[$i];
+                if ($line =~ m/^([A-Z]):(.*)/) {
+                    my $type = $1;
+                    my $value = $2;
+
+                    if ($type eq 'T') {
+                        if ($for_tree eq $value || "git $for_tree" eq $value) {
+                            $tree_match = 1
+                        }
+                    }
+                }
+            }
+
+            if ($tree_match) {
+                for ($i = $start; $i < $end; $i++) {
+                    my $line = $typevalue[$i];
+                    if ($line =~ m/^([A-Z]):(.*)/) {
+                        my $type = $1;
+                        my $value = $2;
+
+                        if ($type eq 'M' || $type eq 'L') {
+                            my $role = get_maintainer_role($i);
+                            push_email_address($value, $role)
+                        }
+                    }
+                }
+            }
+        }
+    }
+
+
     foreach my $email (@email_to, @list_to) {
 	$email->[0] = deduplicate_email($email->[0]);
     }
@@ -1074,6 +1117,7 @@ Output type options:
   --multiline => print 1 entry per line
 
 Other options:
+  --for-tree => Get maintainers for the given tree
   --pattern-depth => Number of pattern directory traversals (default: 0 (all))
   --keywords => scan patch for keywords (default: $keywords)
   --sections => print all of the subsystem sections with pattern matches
-- 
2.38.0

