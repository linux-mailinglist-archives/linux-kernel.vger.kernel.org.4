Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAFE6A6876
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCAHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCAHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:55:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0625039B8D;
        Tue, 28 Feb 2023 23:54:59 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3215Q400032450;
        Wed, 1 Mar 2023 07:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZkS1pU86noQguWf85gIp646oBtrNlmZ9qt70vL5klFU=;
 b=Amit8+lWWn5C4PtPJ52F8J83fGZRNP+p5P92zqlv7/lNg47iSV7uT1p0F6a6AtNDZS0z
 FFjtGycmVvos29ZLam3xmtzD3TsDShPgh/ETygbzFKYBn6xwa5gJeKtKmnhObrngnNm1
 +Coi0bIFL/ZNJn6w1TR65gGaq5rGb7IXT+lItvx4mkRkUYJ9i7g9RWCJCiTW8wJItIy5
 AWo2QKFAYR7/B2ur88Qgb90KTAV24YwAyVD0eRPGu/PLZKxqoaO68eHyoQp3IGvayz8p
 MUmQ3CEsLpJxzCVNHw5e1VakITBmZ4LMV9torhGiK30R7ebHfznh04eAfJThh95m+ho0 Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p20j2gcy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 07:54:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3217sVPB026643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 07:54:31 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Feb 2023 23:54:30 -0800
From:   John Moon <quic_johmoo@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>
CC:     John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v2 1/2] check-uapi: Introduce check-uapi.sh
Date:   Tue, 28 Feb 2023 23:54:01 -0800
Message-ID: <20230301075402.4578-2-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301075402.4578-1-quic_johmoo@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O9iVGVe9mh0w6lLILGSRLZA4K30cBxrL
X-Proofpoint-GUID: O9iVGVe9mh0w6lLILGSRLZA4K30cBxrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the kernel community has been good at maintaining backwards
compatibility with kernel UAPIs, it would be helpful to have a tool
to check if a commit introduces changes that break backwards
compatibility.

To that end, introduce check-uapi.sh: a simple shell script that
checks for changes to UAPI headers using libabigail.

libabigail is "a framework which aims at helping developers and
software distributors to spot some ABI-related issues like interface
incompatibility in ELF shared libraries by performing a static
analysis of the ELF binaries at hand."

The script uses one of libabigail's tools, "abidiff", to compile the
changed header before and after the commit to detect any changes.

abidiff "compares the ABI of two shared libraries in ELF format. It
emits a meaningful report describing the differences between the two
ABIs."

The script also includes the ability to check the compatibilty of
all UAPI headers across commits. This allows developers to inspect
the stability of the UAPIs over time.

Signed-off-by: John Moon <quic_johmoo@quicinc.com>
---
   - Fixed issue where system UAPI headers were used instead of kernel
     source headers. Now, script will include all UAPI headers from
     source instead of just target ones.
   - Added logic to install all requires sanitized headers to the tmp
     directory up front (including across git commits)
   - Added filter for changes which only add types (which should be
     allowed for UAPI headers)
   - Added -b flag to specify "base commit" to compare against.
   - Modified logic to check for any changed UAPI files between the
     base commit and reference commit.
   - Added -a flag to check compatibility of all UAPI files.
   - Added threaded execution and -j flag to control number of jobs.
   - Added error log and -l option to control output path.
   - Added support for checking dirty git workspaces.
   - Added summary file output with header diffs
   - Added "arch/*/include/uapi" to list of files to check.
   - Addressed misc code review findings.

 scripts/check-uapi.sh | 451 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 451 insertions(+)
 create mode 100755 scripts/check-uapi.sh

diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
new file mode 100755
index 000000000000..022cc7f8a2a9
--- /dev/null
+++ b/scripts/check-uapi.sh
@@ -0,0 +1,451 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Script to check commits for UAPI backwards compatibility
+
+set -o errexit
+set -o pipefail
+
+print_usage() {
+	name=$(basename "$0")
+	cat << EOF
+$name - check for UAPI header stability across Git commits
+
+By default, the script will check to make sure the latest commit (or current
+dirty changes) did not introduce ABI changes when compared to HEAD^1. You can
+check against additional commit ranges with the -b and -r options.
+
+To force the script to check compatibility of all UAPI headers, use the -a
+option.
+
+Usage: $name [-b BASE_REF] [-r COMP_REF] [-a] [-j N] [-l ERROR_LOG]
+
+Options:
+    -b BASE_REF    Base git reference to use for comparison. If unspecified or empty,
+                   will use any dirty changes in tree to UAPI files. If there are no
+                   dirty changes, HEAD will be used.
+    -r COMP_REF    Compare BASE_REF to COMP_REF (e.g. -r v6.1). If unspecified or empty,
+                   will use BASE_REF^1.
+    -a             Check all UAPI headers for backwards compatibility.
+    -j JOBS        Number of checks to run in parallel (default: number of CPU cores)
+    -l ERROR_LOG   Write error log to file (default: "\$KERNEL_SOURCE/abi_error_log.txt")
+
+Environmental args:
+    ABIDIFF  Custom path to abidiff binary
+    CC       C compiler (default is "gcc")
+EOF
+}
+
+# Some UAPI headers require an architecture-specific compiler to build properly.
+ARCH_SPECIFIC_CC_NEEDED=(
+	"arch/hexagon/include/uapi/asm/sigcontext.h"
+	"arch/ia64/include/uapi/asm/intel_intrin.h"
+	"arch/ia64/include/uapi/asm/setup.h"
+	"arch/ia64/include/uapi/asm/sigcontext.h"
+	"arch/mips/include/uapi/asm/bitfield.h"
+	"arch/mips/include/uapi/asm/byteorder.h"
+	"arch/mips/include/uapi/asm/inst.h"
+	"arch/sparc/include/uapi/asm/fbio.h"
+	"arch/sparc/include/uapi/asm/uctx.h"
+	"arch/xtensa/include/uapi/asm/byteorder.h"
+	"arch/xtensa/include/uapi/asm/msgbuf.h"
+	"arch/xtensa/include/uapi/asm/sembuf.h"
+)
+
+# Print to stderr
+eprintf() {
+	# shellcheck disable=SC2059
+	printf "$@" >&2
+}
+
+# Print list of UAPI files to operate on
+get_uapi_files() {
+	local -r check_all="$1"
+	local -r base_ref="$2"
+	local -r ref="$3"
+	local -r args="--name-status --no-renames --format= --diff-filter=a -- ${UAPI_DIRS[*]}"
+
+	if [ "$check_all" = "true" ]; then
+		# Use find to print all of the UAPI files as if git had detected they were modified
+		# Ignore the headers that need an arch-specific compiler because we can't build all
+		# of those in one run (as only one CC can be passed).
+		# shellcheck disable=SC2046,SC2048,SC2086
+		find "${UAPI_DIRS[@]}" -type f -name '*.h' -printf 'M\t%p\n' \
+			| grep -v $(get_no_header_list | xargs -- printf '-e %s ') \
+				  ${ARCH_SPECIFIC_CC_NEEDED[*]/#/-e }
+	else
+		if [ -z "$base_ref" ] || [ -z "$ref" ]; then
+			# shellcheck disable=SC2086
+			git diff $args
+		else
+			# shellcheck disable=SC2086
+			git diff "$ref" "$base_ref" $args
+		fi
+	fi
+}
+
+# Compile the simple test app
+do_compile() {
+	local -r inc_dir="$1"
+	local -r header="$2"
+	local -r out="$3"
+	printf "int main(void) { return 0; }\n" | \
+		"${CC:-gcc}" -c \
+		  -o "$out" \
+		  -x c \
+		  -O0 \
+		  -std=c90 \
+		  -fno-eliminate-unused-debug-types \
+		  -g \
+		  "-I${inc_dir}" \
+		  -include "$header" \
+		  -
+}
+
+# Print the list of incompatible headers from the usr/include Makefile
+get_no_header_list() {
+	{
+		# shellcheck disable=SC2016
+		printf 'all: ; @echo $(no-header-test)\n'
+		cat "usr/include/Makefile"
+	} | make -f - | tr " " "\n" | grep -v "asm-generic"
+
+	# One additional header file is not building correctly
+	# with this method.
+	# TODO: why can't we build this one?
+	printf "asm-generic/ucontext.h\n"
+}
+
+# Save the current git tree state, stashing if needed
+save_tree_state() {
+	printf "Saving current tree state... "
+	current_ref="$(git rev-parse HEAD)"
+	readonly current_ref
+	if ! git diff-index --quiet HEAD; then
+		unstash="true"
+		git stash push --quiet
+	fi
+	printf "OK\n"
+}
+
+# Restore the git tree state, unstashing if needed
+restore_tree_state() {
+	printf "Restoring current tree state... "
+	git checkout --quiet "$current_ref"
+	if [ "$unstash" = "true" ]; then
+		git stash pop --quiet
+		unstash="false"
+	fi
+	printf "OK\n"
+}
+
+# Install headers for every arch and ref we need
+install_headers() {
+	local -r check_all="$1"
+	local -r base_ref="$2"
+	local -r ref="$3"
+
+	local arch_list=()
+	while read -r status file; do
+		if arch="$(printf "%s" "$file" | grep -o 'arch/.*/uapi' | cut -d '/' -f 2)"; then
+			# shellcheck disable=SC2076
+			if ! [[ " ${arch_list[*]} " =~ " $arch " ]]; then
+				arch_list+=("$arch")
+			fi
+		fi
+	done < <(get_uapi_files "$check_all" "$base_ref" "$ref")
+
+	deviated_from_current_tree="false"
+	for inst_ref in "$base_ref" "$ref"; do
+		if [ -n "$inst_ref" ]; then
+			if [ "$deviated_from_current_tree" = "false" ]; then
+				save_tree_state
+				trap 'rm -rf "$tmp_dir"; restore_tree_state;' EXIT
+				deviated_from_current_tree="true"
+			fi
+			git checkout --quiet "$(git rev-parse "$inst_ref")"
+		fi
+
+		printf "Installing sanitized UAPI headers from %s... " "${inst_ref:-dirty tree}"
+		make INSTALL_HDR_PATH="${tmp_dir}/${inst_ref}/usr" headers_install > /dev/null 2>&1
+		for arch in "${arch_list[@]}"; do
+			make ARCH="$arch" INSTALL_HDR_PATH="${tmp_dir}/${inst_ref}/${arch}/usr" \
+				headers_install > /dev/null 2>&1
+		done
+		printf "OK\n"
+	done
+
+	restore_tree_state
+	trap 'rm -rf "$tmp_dir"' EXIT
+}
+
+# Check file list for UAPI compatibility
+check_uapi_files() {
+	local -r check_all="$1"
+	local -r base_ref="$2"
+	local -r ref="$3"
+
+	install_headers "$check_all" "$base_ref" "$ref"
+
+	local passed=0;
+	local failed=0;
+	local -a threads=()
+
+	printf "Checking changes to UAPI headers starting from %s\n" "${base_ref:-dirty tree}"
+	while read -r status file; do
+		if [ "${#threads[@]}" -ge "$MAX_THREADS" ]; then
+			if wait "${threads[0]}"; then
+				passed=$((passed + 1))
+			else
+				failed=$((failed + 1))
+			fi
+			threads=("${threads[@]:1}")
+		fi
+
+		check_individual_file "$base_ref" "$ref" "$status" "$file" &
+		threads+=("$!")
+	done < <(get_uapi_files "$check_all" "$base_ref" "$ref")
+
+	for t in "${threads[@]}"; do
+		if wait "$t"; then
+			passed=$((passed + 1))
+		else
+			failed=$((failed + 1))
+		fi
+	done
+
+	total="$((passed + failed))"
+	if [ "$failed" -gt 0 ]; then
+		eprintf "error - %d/%d UAPI headers modified between %s and %s are not backwards compatible\n" \
+			"$failed" "$total" "$ref" "${base_ref:-dirty tree}"
+	else
+		printf "All %d UAPI headers modified between %s and %s are backwards compatible!\n" \
+			"$total" "$ref" "${base_ref:-dirty tree}"
+	fi
+
+	return "$failed"
+}
+
+# Print the path to a give header in the tmp_dir
+get_header() {
+	local -r ref="$1"
+	local -r arch="$2"
+	local -r base="$3"
+
+	if [ -z "$arch" ]; then
+		printf "%s" "${tmp_dir}/${ref}/usr/${base}"
+	else
+		printf "%s" "${tmp_dir}/${ref}/${arch}/usr/$(printf "%s" "$base" | cut -d '/' -f 3-)"
+	fi
+}
+
+# Check an individual file for UAPI compatibility
+check_individual_file() {
+	local -r base_ref="$1"
+	local -r ref="$2"
+	local -r status="$3"
+	local -r file="$4"
+
+	if [ "$status" = "D" ]; then
+		eprintf "error - UAPI header %s was incorrectly removed\n" "$file"
+		return 1
+	fi
+
+	local -r base=${file/uapi\//}
+	local -r uapi_arch="$(printf "%s" "$file" | grep -o 'arch/.*/uapi' | cut -d '/' -f 2)"
+	local -r base_header=$(get_header "$base_ref" "$uapi_arch" "$base")
+	local -r ref_header=$(get_header "$ref" "$uapi_arch" "$base")
+	local -r installed_base="$(printf "%s" "$base_header" | grep -o "usr/include/.*" | cut -d '/' -f 3-)"
+
+	# shellcheck disable=SC2076
+	if [[ " $(get_no_header_list | xargs) " =~ " $installed_base " ]]; then
+		eprintf "%s cannot be tested by this script (see usr/include/Makefile)\n" "$file"
+		return 1
+	fi
+
+	for h in "$base_header" "$ref_header"; do
+		if [ ! -f "$h" ]; then
+			eprintf "%s does not exist - cannot compare ABI\n" "$h"
+			return 1
+		fi
+	done
+
+	compare_abi "$file" "$base_header" "$ref_header" "$base_ref" "$ref" "$uapi_arch"
+}
+
+# Perform the A/B compilation and compare output ABI
+compare_abi() {
+	local -r file="$1"
+	local -r base_header="$2"
+	local -r ref_header="$3"
+	local -r base_ref="$4"
+	local -r ref="$5"
+	local -r uapi_arch="$6"
+	local -r log="${tmp_dir}/log/$(basename "$file").log"
+
+	mkdir -p "$(dirname "$log")"
+
+	if ! do_compile "${tmp_dir}/${base_ref}/${uapi_arch}/usr/include" "$base_header" "${base_header}.bin" 2> "$log"; then
+		eprintf "error - couldn't compile current version of UAPI header %s\n" "$file"
+		# shellcheck disable=SC2076
+		if [[ " ${ARCH_SPECIFIC_CC_NEEDED[*]} " =~ " $file " ]]; then
+			eprintf "warning - this file needs to be built with a %s compiler. Are you using one?\n" "$uapi_arch"
+		fi
+		cat "$log" >&2
+		exit 1
+	fi
+
+	if ! do_compile "${tmp_dir}/${ref}/${uapi_arch}/usr/include" "$ref_header" "${ref_header}.bin" 2> "$log"; then
+		eprintf "error - couldn't compile version of UAPI header %s at %s\n" "$file" "$ref"
+		# shellcheck disable=SC2076
+		if [[ " ${ARCH_SPECIFIC_CC_NEEDED[*]} " =~ " $file " ]]; then
+			eprintf "warning - this file needs to be built with a %s compiler. Are you using one?\n" "$uapi_arch"
+		fi
+
+		cat "$log" >&2
+		exit 1
+	fi
+
+	if "$ABIDIFF" --non-reachable-types "${ref_header}.bin" "${base_header}.bin" > "$log"; then
+		printf "No ABI differences detected in %s from %s -> %s\n" "$file" "$ref" "${base_ref:-dirty tree}"
+	else
+		# If the only changes were additions (not modifications to existing APIs), then
+		# there's no problem. Ignore these diffs.
+		if grep "Unreachable types summary" "$log" | grep -q "0 removed" &&
+		   grep "Unreachable types summary" "$log" | grep -q "0 changed"; then
+			return 0
+		fi
+		{
+			printf "!!! ABI differences detected in %s from %s -> %s !!!\n\n" "$file" "$ref" "${base_ref:-dirty tree}"
+			sed  -e '/summary:/d' -e '/changed type/d' -e '/^$/d' -e 's/^/  /g' "$log"
+			printf "\nHeader file diff (after headers_install):\n"
+			diff -Naur "$ref_header" "$base_header" \
+				| sed -e "s|${ref_header}|${ref}/${file}|g" \
+				      -e "s|${base_header}|${base_ref:-dirty}/${file}|g"
+			printf "\n"
+		} | tee "${base_header}.error" >&2
+		return 1
+	fi
+}
+
+# Make sure we have the tools we need
+check_deps() {
+	export ABIDIFF="${ABIDIFF:-abidiff}"
+
+	if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
+		eprintf "error - abidiff not found!\n"
+		eprintf "Please install abigail-tools (version 1.7 or greater)\n"
+		eprintf "See: https://sourceware.org/libabigail/manual/libabigail-overview.html\n"
+		exit 1
+	fi
+
+	read -r abidiff_maj abidiff_min _unused < <("$ABIDIFF" --version | cut -d ' ' -f 2 | tr '.' ' ')
+	if [ "$abidiff_maj" -lt 1 ] || { [ "$abidiff_maj" -eq 1 ] && [ "$abidiff_min" -lt 7 ]; }; then
+		eprintf "error - abidiff version too old: %s\n" "$("$ABIDIFF" --version)"
+		eprintf "Please install abigail-tools (version 1.7 or greater)\n"
+		eprintf "See: https://sourceware.org/libabigail/manual/libabigail-overview.html\n"
+		exit 1
+	fi
+
+	if [ ! -x "scripts/unifdef" ]; then
+		if ! make -f /dev/null scripts/unifdef; then
+			eprintf 'error - failed to build required dependency "scripts/unifdef"\n'
+			exit 1
+		fi
+	fi
+}
+
+main() {
+	MAX_THREADS=$(nproc)
+
+	base_ref=""
+	check_all="false"
+	while getopts "hb:r:aj:l:" opt; do
+		case $opt in
+		h)
+			print_usage
+			exit 0
+			;;
+		b)
+			base_ref="$OPTARG"
+			;;
+		r)
+			ref_to_check="$OPTARG"
+			;;
+		a)
+			check_all="true"
+			;;
+		j)
+			MAX_THREADS="$OPTARG"
+			;;
+		l)
+			abi_error_log="$OPTARG"
+			;;
+		*)
+			eprintf "error - invalid option %s\n" "$opt"
+			exit 1
+		esac
+	done
+
+	if [ -z "$KERNEL_SRC" ]; then
+		KERNEL_SRC="$(realpath "$(dirname "$0")"/..)"
+	fi
+
+	cd "$KERNEL_SRC"
+
+	abi_error_log="${abi_error_log:-${KERNEL_SRC}/abi_error_log.txt}"
+
+	check_deps
+
+	tmp_dir=$(mktemp -d)
+	trap 'rm -rf "$tmp_dir"' EXIT
+
+	# Set of UAPI directories to check by default
+	UAPI_DIRS=(include/uapi arch/*/include/uapi)
+
+	if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
+		eprintf "error - this script requires the kernel tree to be initialized with Git\n"
+		exit 1
+	fi
+
+	# If there are no dirty UAPI files, use HEAD as base_ref
+	if [ -z "$base_ref" ] && [ "$(get_uapi_files "" "" | wc -l)" -eq 0 ]; then
+		base_ref="HEAD"
+	fi
+
+	if [ -z "$ref_to_check" ]; then
+		if [ -n "$base_ref" ]; then
+			ref_to_check="${base_ref}^1"
+		else
+			ref_to_check="HEAD"
+		fi
+	fi
+
+	if [ -n "$ref_to_check" ] && ! git rev-parse --verify "$ref_to_check" > /dev/null 2>&1; then
+		printf 'error - invalid git reference "%s"\n' "$ref_to_check"
+		exit 1
+	fi
+
+	if [ -n "$base_ref" ]; then
+		if ! git merge-base --is-ancestor "$ref_to_check" "$base_ref" > /dev/null 2>&1; then
+			printf 'error - "%s" is not an ancestor of base ref "%s"\n' "$ref_to_check" "$base_ref"
+			exit 1
+		fi
+	fi
+
+	if [ "$check_all" != "true" ] && [ "$(get_uapi_files "$check_all" "$base_ref" "$ref_to_check" | wc -l)" -eq 0 ]; then
+		printf "No changes to UAPI headers were applied between %s and %s\n" "$ref_to_check" "$base_ref"
+		exit 0
+	fi
+
+	if ! check_uapi_files "$check_all" "$base_ref" "$ref_to_check"; then
+		eprintf "error - UAPI header ABI check failed\n"
+		{
+			printf 'Generated by "%s %s" from git ref %s\n\n' "$0" "$*" "$(git rev-parse "HEAD")"
+			find "$tmp_dir" -type f -name '*.error' -exec cat {} \;
+		} > "$abi_error_log"
+		eprintf "Failure summary saved to %s\n" "$abi_error_log"
+		exit 1
+	fi
+}
+
+main "$@"
--
2.17.1

