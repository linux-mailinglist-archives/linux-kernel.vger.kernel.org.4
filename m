Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0466A69F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCAJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCAJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:43:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C3E3AC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:43:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A14B61298
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAA8C433D2;
        Wed,  1 Mar 2023 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677663812;
        bh=ot4Z2xK8UNxIYbmHAgiI5cpF545tn/mJuRLFj3fnJwc=;
        h=From:To:Cc:Subject:Date:From;
        b=RI8TDBH22AEvTMsZRhIgYHcGRb/mwN66vEOO2UR0BkGQEFZy3fjEkAguSaPUiB6dh
         PQoO+Jl3z3uKPbzITJyrnkeA8S4ljjDNLpeP8xs+xNMkR6P+InZ6her/KfPLBR1zir
         rG0TX4RadPxTkjiKo9BPc9/ggoN3wDTlZj39GLXOheKsNhzRI9OU4OGSGYGBxtveGR
         bx15UcH8na8Pd3jS+IjpGo0wDvB8sSUEyEjxEYD7ha86IL1ipCxd+2vt+M5uXJIh5J
         dFBsf0RLoJ9sU9+uF2uBBerzN9b4ERnKL+eSlk9tc8F7M5ScdwAyC2j01l1YHA66Ag
         NwEIidIj4DEfw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [RFC PATCH] checkpatch: Support __initconst combined with struct definition
Date:   Wed,  1 Mar 2023 10:43:20 +0100
Message-Id: <20230301094320.15954-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Checkpatch sometimes report a false positive for __initconst. E.g., for the
following snippet:

 | static const struct strspn_test {
 | 	const char str[16];
 | 	const char accept[16];
 | 	const char reject[16];
 | 	unsigned a;
 | 	unsigned r;
 | } tests[] __initconst = {
 | 	{ "foobar", "", "", 0, 6 },
 | 	{ "abba", "abc", "ABBA", 4, 4 },
 | 	{ "abba", "a", "b", 1, 1 },
 | 	{ "", "abc", "abc", 0, 0},
 | };

checkpatch would report:

 | ERROR: Use of __initconst requires a separate use of const
 | #190: FILE: ./test_string.c:190:
 | +	} tests[] __initconst = {

Improve the reporting by trying harder to find the 'const'.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---

In [1], Andy asked if it was possible to fix the __initconst false
positive in checkpatch, rather than the code.

I did a crude hack that searches backwards for the 'const' in the
struct definition, but I'm sure the Perl hackers out there hate it,
hence the RFC. ;-)

Björn

[1] https://lore.kernel.org/linux-riscv/CAHp75VfK3RM+SP90d3nOXEobY81Xd_94tLL=Qt86mmdNwXaQpg@mail.gmail.com/

---
 scripts/checkpatch.pl | 54 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c9..d2370233e2c1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1854,6 +1854,48 @@ sub ctx_statement_full {
 	return ($level, $linenr, @chunks);
 }
 
+sub ctx_block_outer_rev {
+	my ($linenr, $open, $close) = @_;
+	my $line;
+	my $start = $linenr;
+	my $blk = '';
+	my @res = ();
+
+	my $level = 0;
+	my @stack = ($level);
+	for ($line = $start; $line >= 0; $line--) {
+		next if ($rawlines[$line] =~ /^-/);
+
+		$blk .= $rawlines[$line];
+
+		# Handle nested #if/#else.
+		if ($lines[$line] =~ /^.\s*#\s*(?:ifndef|ifdef|if)\s/) {
+			$level = pop(@stack);
+		} elsif ($lines[$line] =~ /^.\s*#\s*(?:else|elif)\b/) {
+			$level = $stack[$#stack - 1];
+		} elsif ($lines[$line] =~ /^.\s*#\s*endif\b/) {
+			push(@stack, $level);
+		}
+
+		foreach my $c (split(//, $lines[$line])) {
+			if ($c eq $close && $level > 0) {
+				$level--;
+				last if ($level == 0);
+			} elsif ($c eq $open) {
+				$level++;
+			}
+		}
+
+		if ($level <= 1) {
+			push(@res, $rawlines[$line]);
+		}
+
+		last if ($level == 0);
+	}
+
+	return @res;
+}
+
 sub ctx_block_get {
 	my ($linenr, $remain, $outer, $open, $close, $off) = @_;
 	my $line;
@@ -6502,7 +6544,17 @@ sub process {
 # check for $InitAttributeConst (ie: __initconst) without const
 		if ($line !~ /\bconst\b/ && $line =~ /($InitAttributeConst)/) {
 			my $attr = $1;
-			if (ERROR("INIT_ATTRIBUTE",
+			my $error = 1;
+			if ($line =~ /}/) {
+			# The const might be part of a struct definition. Try to find that...
+				my @ctx = ctx_block_outer_rev($linenr, '}', '{');
+				if (@ctx) {
+					if ($ctx[$#ctx] =~ /\bconst\b/) {
+						$error = 0;
+					}
+				}
+			}
+			if ($error && ERROR("INIT_ATTRIBUTE",
 				  "Use of $attr requires a separate use of const\n" . $herecurr) &&
 			    $fix) {
 				my $lead = $fixed[$fixlinenr] =~

base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
-- 
2.37.2

