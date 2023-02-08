Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786C668F7EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjBHTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBHTWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:22:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 872821BD1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:22:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3471477;
        Wed,  8 Feb 2023 11:23:26 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11F5D3F703;
        Wed,  8 Feb 2023 11:22:42 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:22:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V7 2/6] arm64/perf: Add BRBE registers and fields
Message-ID: <Y+P2fSWlJ4+PH5sG@FVFF77S0Q05N.cambridge.arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-3-anshuman.khandual@arm.com>
 <Y8AKAZMq7YzOpwwV@FVFF77S0Q05N>
 <16dcb986-74df-9a78-5cfc-e9f59fbe0997@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16dcb986-74df-9a78-5cfc-e9f59fbe0997@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:32:47AM +0530, Anshuman Khandual wrote:
> On 1/12/23 18:54, Mark Rutland wrote:
> > Hi Anshuman,
> > 
> > On Thu, Jan 05, 2023 at 08:40:35AM +0530, Anshuman Khandual wrote:
> >> This adds BRBE related register definitions and various other related field
> >> macros there in. These will be used subsequently in a BRBE driver which is
> >> being added later on.
> > 
> > I haven't verified the specific values, but this looks good to me aside from
> > one minor nit below.
> > 
> > [...]
> > 
> >> +# This is just a dummy register declaration to get all common field masks and
> >> +# shifts for accessing given BRBINF contents.
> >> +Sysreg	BRBINF_EL1	2	1	8	0	0
> > 
> > We don't need a dummy declaration, as we have 'SysregFields' that can be used
> > for this, e.g.
> > 
> >   SysregFields BRBINFx_EL1
> >   ...
> >   EndSysregFields
> > 
> > ... which will avoid accidental usage of the register encoding. Note that I've
> > also added an 'x' there in place of the index, which we do for other registers,
> > e.g. TTBRx_EL1.
> > 
> > Could you please update to that?
> 
> There is a problem in defining SysregFields (which I did explore earlier as well).
> SysregFields unfortunately does not support enums fields. Following build failure
> comes up, while trying to convert BRBINFx_EL1 into a SysregFields definition.
> 
> Error at 932: unexpected Enum (inside SysregFields)

This is a problem, but it's one that we can solve. We're in control of
gen-sysreg.awk and the language it parses, so we can make this an expected and
supported case -- see below.

> ===============================================================================
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index a7f9054bd84c..519c4f080898 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -921,10 +921,7 @@ Enum       3:0     BT
>  EndEnum
>  EndSysreg
>  
> -
> -# This is just a dummy register declaration to get all common field masks and
> -# shifts for accessing given BRBINF contents.
> -Sysreg BRBINF_EL1      2       1       8       0       0
> +SysregFields BRBINFx_EL1
>  Res0   63:47
>  Field  46      CCU
>  Field  45:32   CC
> @@ -967,7 +964,7 @@ Enum        1:0     VALID
>         0b10    SOURCE
>         0b11    FULL
>  EndEnum
> -EndSysreg
> +EndSysregFields
>  
>  Sysreg BRBCR_EL1       2       1       9       0       0
>  Res0   63:24
> ===============================================================================
> 
> There are three enum fields in BRBINFx_EL1 as listed here.
> 
> Enum    13:8            TYPE
> Enum    7:6		EL
> Enum    1:0     	VALID
> 
> However, BRBINF_EL1 can be changed as BRBINFx_EL1, indicating its more generic
> nature with a potential to be used for any index value register thereafter.

It's certainly better to use the BRBINFx_EL1 name, but my main concern here is
to avoid the dummy values used above to satisfy the tools, so that those cannot
be accidentally misused.

I'd prefer that we fix gen-sysreg.awk to support Enum blocks within
SysregFields blocks (patch below), then use SysregFields as described above.

Thanks,
Mark.

---->8----
From 0c194d92b0b9ff3b32f666a4610b077fdf1b4b93 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 8 Feb 2023 17:55:08 +0000
Subject: [PATCH] arm64/sysreg: allow *Enum blocks in SysregFields blocks

We'd like to support Enum/SignedEnum/UnsignedEnum blocks within
SysregFields blocks, so that we can define enumerations for sets of
registers. This isn't currently supported by gen-sysreg.awk due to the
way we track the active block, which can't handle more than a single
layer of nesting, which imposes an awkward requirement that when ending
a block we know what the parent block is when calling change_block()

Make this nicer by using a stack of active blocks, with block_push() to
start a block, and block_pop() to end a block. Doing so means hat when
ending a block we don't need to know the parent block type, and checks
of the active block become more consistent. On top of that, it's easy to
permit *Enum blocks within both Sysreg and SysregFields blocks.

To aid debugging, the stack of active blocks is reported for fatal
errors, and an error is raised if the file is terminated without ending
the active block. For clarity I've renamed the top-level element from
"None" to "Root".

The Fields element it intended only for use within Systeg blocks, and
does not make sense within SysregFields blocks, and so remains forbidden
within a SysregFields block.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/tools/gen-sysreg.awk | 93 ++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index 7f27d66a17e1..066ebf5410fa 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -4,23 +4,35 @@
 #
 # Usage: awk -f gen-sysreg.awk sysregs.txt
 
+function block_current() {
+	return __current_block[__current_block_depth];
+}
+
 # Log an error and terminate
 function fatal(msg) {
 	print "Error at " NR ": " msg > "/dev/stderr"
+
+	printf "Current block nesting:"
+
+	for (i = 0; i <= __current_block_depth; i++) {
+		printf " " __current_block[i]
+	}
+	printf "\n"
+
 	exit 1
 }
 
-# Sanity check that the start or end of a block makes sense at this point in
-# the file. If not, produce an error and terminate.
-#
-# @this - the $Block or $EndBlock
-# @prev - the only valid block to already be in (value of @block)
-# @new - the new value of @block
-function change_block(this, prev, new) {
-	if (block != prev)
-		fatal("unexpected " this " (inside " block ")")
-
-	block = new
+# Enter a new block, setting the active block to @block
+function block_push(block) {
+	__current_block[++__current_block_depth] = block
+}
+
+# Exit a block, setting the active block to the parent block
+function block_pop() {
+	if (__current_block_depth == 0)
+		fatal("error: block_pop() in root block")
+
+	__current_block_depth--;
 }
 
 # Sanity check the number of records for a field makes sense. If not, produce
@@ -84,10 +96,14 @@ BEGIN {
 	print "/* Generated file - do not edit */"
 	print ""
 
-	block = "None"
+	__current_block_depth = 0
+	__current_block[__current_block_depth] = "Root"
 }
 
 END {
+	if (__current_block_depth != 0)
+		fatal("Missing terminator for " block_current() " block")
+
 	print "#endif /* __ASM_SYSREG_DEFS_H */"
 }
 
@@ -95,8 +111,9 @@ END {
 /^$/ { next }
 /^[\t ]*#/ { next }
 
-/^SysregFields/ {
-	change_block("SysregFields", "None", "SysregFields")
+/^SysregFields/ && block_current() == "Root" {
+	block_push("SysregFields")
+
 	expect_fields(2)
 
 	reg = $2
@@ -109,12 +126,10 @@ END {
 	next
 }
 
-/^EndSysregFields/ {
+/^EndSysregFields/ && block_current() == "SysregFields" {
 	if (next_bit > 0)
 		fatal("Unspecified bits in " reg)
 
-	change_block("EndSysregFields", "SysregFields", "None")
-
 	define(reg "_RES0", "(" res0 ")")
 	define(reg "_RES1", "(" res1 ")")
 	print ""
@@ -123,11 +138,13 @@ END {
 	res0 = null
 	res1 = null
 
+	block_pop()
 	next
 }
 
-/^Sysreg/ {
-	change_block("Sysreg", "None", "Sysreg")
+/^Sysreg/ && block_current() == "Root" {
+	block_push("Sysreg")
+
 	expect_fields(7)
 
 	reg = $2
@@ -156,12 +173,10 @@ END {
 	next
 }
 
-/^EndSysreg/ {
+/^EndSysreg/ && block_current() == "Sysreg" {
 	if (next_bit > 0)
 		fatal("Unspecified bits in " reg)
 
-	change_block("EndSysreg", "Sysreg", "None")
-
 	if (res0 != null)
 		define(reg "_RES0", "(" res0 ")")
 	if (res1 != null)
@@ -178,12 +193,13 @@ END {
 	res0 = null
 	res1 = null
 
+	block_pop()
 	next
 }
 
 # Currently this is effectivey a comment, in future we may want to emit
 # defines for the fields.
-/^Fields/ && (block == "Sysreg") {
+/^Fields/ && block_current() == "Sysreg" {
 	expect_fields(2)
 
 	if (next_bit != 63)
@@ -200,7 +216,7 @@ END {
 }
 
 
-/^Res0/ && (block == "Sysreg" || block == "SysregFields") {
+/^Res0/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(2)
 	parse_bitdef(reg, "RES0", $2)
 	field = "RES0_" msb "_" lsb
@@ -210,7 +226,7 @@ END {
 	next
 }
 
-/^Res1/ && (block == "Sysreg" || block == "SysregFields") {
+/^Res1/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(2)
 	parse_bitdef(reg, "RES1", $2)
 	field = "RES1_" msb "_" lsb
@@ -220,7 +236,7 @@ END {
 	next
 }
 
-/^Field/ && (block == "Sysreg" || block == "SysregFields") {
+/^Field/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(3)
 	field = $3
 	parse_bitdef(reg, field, $2)
@@ -231,15 +247,16 @@ END {
 	next
 }
 
-/^Raz/ && (block == "Sysreg" || block == "SysregFields") {
+/^Raz/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(2)
 	parse_bitdef(reg, field, $2)
 
 	next
 }
 
-/^SignedEnum/ {
-	change_block("Enum<", "Sysreg", "Enum")
+/^SignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
+	block_push("Enum")
+
 	expect_fields(3)
 	field = $3
 	parse_bitdef(reg, field, $2)
@@ -250,8 +267,9 @@ END {
 	next
 }
 
-/^UnsignedEnum/ {
-	change_block("Enum<", "Sysreg", "Enum")
+/^UnsignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
+	block_push("Enum")
+
 	expect_fields(3)
 	field = $3
 	parse_bitdef(reg, field, $2)
@@ -262,8 +280,9 @@ END {
 	next
 }
 
-/^Enum/ {
-	change_block("Enum", "Sysreg", "Enum")
+/^Enum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
+	block_push("Enum")
+
 	expect_fields(3)
 	field = $3
 	parse_bitdef(reg, field, $2)
@@ -273,16 +292,18 @@ END {
 	next
 }
 
-/^EndEnum/ {
-	change_block("EndEnum", "Enum", "Sysreg")
+/^EndEnum/ && block_current() == "Enum" {
+
 	field = null
 	msb = null
 	lsb = null
 	print ""
+
+	block_pop()
 	next
 }
 
-/0b[01]+/ && block == "Enum" {
+/0b[01]+/ && block_current() == "Enum" {
 	expect_fields(2)
 	val = $1
 	name = $2
-- 
2.30.2

