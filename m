Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1869B3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBQUXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBQUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:23:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BBE5BDA2;
        Fri, 17 Feb 2023 12:23:10 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HAE3MF000980;
        Fri, 17 Feb 2023 20:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sBPBhaoGd2iMZdoCne4QqY85561OWikgFZulR4Sut9E=;
 b=NJaRCUijfZis7s/QWMRCX/IxRxEDbIMmXBCu9FDyNci4UYhBCtV8hke5vZle4gCTHXfG
 iyZgcwLQiDVpQjF5D939OECA+AhYvYPog/8gOUcKGpsBMQj1YvKGEmQptwf8z2Wo525b
 VC4LgiKqZw40IanWiZ0ewt05eVINqs1QDAX3gWd1k5YhlD5BASZEejJD+PWqf6CScd2z
 LYrO8slL4vx95a7wllYynubgV/UMq9RsST7op5EeIcZBB8lM7CsH3CY5jS3SnwvGhSH7
 PPGdHa9zM95KU/Dji6Y08gZH4SJcesH3KymzH/PllTh4EoPGERDJU13i1XZMEIJ4EPLH QA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsgttd37y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:22:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HKMv8d020864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:22:57 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 12:22:56 -0800
From:   John Moon <quic_johmoo@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>
CC:     John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
Date:   Fri, 17 Feb 2023 12:22:34 -0800
Message-ID: <20230217202234.32260-2-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217202234.32260-1-quic_johmoo@quicinc.com>
References: <20230217202234.32260-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: btv7j7xiIrdPERWhhOaRtSjFO9aqzbLj
X-Proofpoint-ORIG-GUID: btv7j7xiIrdPERWhhOaRtSjFO9aqzbLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_14,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170178
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the kernel community has been good at maintaining backwards
compatibility with kernel UAPIs, it would be helpful to have a tool
to check if a patch introduces changes that break backwards
compatibility.

To that end, introduce check-uapi.sh: a simple shell script that
checks for changes to UAPI headers using libabigail.

libabigail is "a framework which aims at helping developers and
software distributors to spot some ABI-related issues like interface
incompatibility in ELF shared libraries by performing a static
analysis of the ELF binaries at hand."

The script uses one of libabigail's tools, "abidiff", to compile the
changed header before and after the patch to detect any changes.

abidiff "compares the ABI of two shared libraries in ELF format. It
emits a meaningful report describing the differences between the two
ABIs."

Signed-off-by: John Moon <quic_johmoo@quicinc.com>
---
 scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)
 create mode 100755 scripts/check-uapi.sh

diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
new file mode 100755
index 000000000..b9cd3a2d7
--- /dev/null
+++ b/scripts/check-uapi.sh
@@ -0,0 +1,245 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Script to check a patch for UAPI stability
+set -o errexit
+set -o pipefail
+
+print_usage() {
+	name=$(basename "$0")
+	cat << EOF
+$name - check for UAPI header stability across Git commits
+
+By default, the script will check to make sure the latest commit did
+not introduce ABI changes (HEAD^1). You can check against additional
+commits/tags with the -r option.
+
+Usage: $name [-r GIT_REF]
+
+Options:
+    -r GIT_REF     Compare current version of file to GIT_REF (e.g. -r v6.1)
+
+Environmental Args:
+    ABIDIFF        Custom path to abidiff binary
+    ARCH           Architecture to build with (e.g. ARCH=arm)
+    CC             C compiler (default is "gcc")
+    CROSS_COMPILE  Cross-compiling toochain prefix
+EOF
+}
+
+# Get the file and sanitize it using the headers_install script
+get_header() {
+	local -r ref="$1"
+	local -r file="$2"
+	local -r out="$3"
+
+	if [ ! -x "${KERNEL_SRC}/scripts/unifdef" ]; then
+		if ! make -C "${KERNEL_SRC}/scripts" unifdef; then
+			errlog 'error - failed to build required dependency "scripts/unifdef"'
+			exit 1
+		fi
+	fi
+
+	mkdir -p "$(dirname "$out")"
+	(
+		cd "$KERNEL_SRC"
+		git show "${ref}:${file}" > "${out}.in"
+		scripts/headers_install.sh "${out}.in" "$out"
+	)
+}
+
+# Compile the simple test app
+do_compile() {
+	local -r compiler="$1"
+	local -r inc_dir="$2"
+	local -r header="$3"
+	local -r out="$4"
+	echo "int main(int argc, char **argv) { return 0; }" | \
+		"$compiler" -c \
+		  -o "$out" \
+		  -x c \
+		  -O0 \
+		  -std=c90 \
+		  -fno-eliminate-unused-debug-types \
+		  -g \
+		  "-I$inc_dir" \
+		  -include "$header" \
+		  -
+}
+
+# Print to stderr
+errlog() {
+	echo "$@" >&2
+}
+
+# Grab the list of incompatible headers from the usr/include Makefile
+get_no_header_list() {
+	{
+		cat "${KERNEL_SRC}/usr/include/Makefile"
+		# shellcheck disable=SC2016
+		printf '\nall:\n\t@echo $(no-header-test)\n'
+	} | make -C "${KERNEL_SRC}/usr/include" -f - --just-print \
+	  | grep '^echo' \
+	  | cut -d ' ' -f 2-
+}
+
+# Check any changed files in this commit for UAPI compatibility
+check_changed_files() {
+	refs_to_check=("$@")
+
+	local passed=0;
+	local failed=0;
+
+	while read -r status file; do
+		local -r base=${file/uapi\//}
+
+		# Get the current version of the file and put it in the install dir
+		get_header "HEAD" "$file" "${tmp_dir}/usr/${base}"
+
+		for ref in "${refs_to_check[@]}"; do
+			if ! git rev-parse --verify "$ref" > /dev/null 2>&1; then
+				echo "error - invalid ref \"$ref\""
+				exit 1
+			fi
+
+			if check_uapi_for_file "$status" "$file" "$ref" "$base"; then
+				passed=$((passed + 1))
+			else
+				failed=$((failed + 1))
+			fi
+		done
+	done < <(cd "$KERNEL_SRC" && git show HEAD --name-status --format="" --diff-filter=a -- include/uapi/)
+
+	total=$((passed + failed))
+	if [ "$total" -eq 0 ]; then
+		errlog "No changes to UAPI headers detected in most recent commit"
+	else
+		errlog "${passed}/${total} UAPI header file changes are backwards compatible"
+	fi
+
+	return "$failed"
+}
+
+# Check UAPI compatibility for a given file
+check_uapi_for_file() {
+	local -r status="$1"
+	local -r file="$2"
+	local -r ref="$3"
+	local -r base="$4"
+
+	# shellcheck disable=SC2076
+	if [[ " $(get_no_header_list) " =~ " ${base/include\//} " ]]; then
+		errlog "$file cannot be tested by this script (see usr/include/Makefile)."
+		return 1
+	fi
+
+	if [ "$status" = "D" ]; then
+		errlog "UAPI header $file was incorrectly removed"
+		return 1
+	fi
+
+	if [ "$status" = "R" ]; then
+		errlog "UAPI header $file was incorrectly renamed"
+		return 1
+	fi
+
+	# Get the "previous" verison of the API header and put it in the install dir
+	get_header "$ref" "$file" "${tmp_dir}/usr/${base}.pre"
+
+	compare_abi "${CROSS_COMPILE}${CC:-gcc}" "$file" "$base" "$ref"
+}
+
+# Perform the A/B compilation and compare output ABI
+compare_abi() {
+	local -r compiler="$1"
+	local -r file="$2"
+	local -r base="$3"
+	local -r ref="$4"
+
+	pre_bin="${tmp_dir}/pre.bin"
+	post_bin="${tmp_dir}/post.bin"
+	log="${tmp_dir}/log"
+
+	if ! do_compile "$compiler" "${tmp_dir}/usr/include" "${tmp_dir}/usr/${base}.pre" "$pre_bin" 2> "$log"; then
+		errlog "Couldn't compile current version of UAPI header $file..."
+		cat "$log" >&2
+		return 1
+	fi
+
+	if ! do_compile "$compiler" "${tmp_dir}/usr/include" "${tmp_dir}/usr/${base}" "$post_bin" 2> "$log"; then
+		errlog "Couldn't compile new version of UAPI header $file..."
+		cat "$log" >&2
+		return 1
+	fi
+
+	if "$ABIDIFF" --non-reachable-types "$pre_bin" "$post_bin" > "$log"; then
+		echo "No ABI differences detected in $file (compared to file at $ref)"
+	else
+		errlog "!!! ABI differences detected in $file (compared to file at $ref) !!!"
+		echo >&2
+		sed  -e '/summary:/d' -e '/changed type/d' -e '/^$/d' -e 's/^/  /g' "$log" >&2
+		echo >&2
+		return 1
+	fi
+}
+
+# Make sure we have the tools we need
+check_deps() {
+	export ABIDIFF="${ABIDIFF:-abidiff}"
+
+	if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
+		errlog "error - abidiff not found!"
+		errlog "Please install abigail-tools (version 1.7 or greater)"
+		errlog "See: https://sourceware.org/libabigail/manual/libabigail-overview.html"
+		exit 1
+	fi
+
+	read -r abidiff_maj abidiff_min _ < <("$ABIDIFF" --version | cut -d ' ' -f 2 | tr '.' ' ')
+	if [ "$abidiff_maj" -lt 1 ] || ([ "$abidiff_maj" -eq 1 ] && [ "$abidiff_min" -lt 7 ]); then
+		errlog "error - abidiff version too old: $("$ABIDIFF" --version)"
+		errlog "Please install abigail-tools (version 1.7 or greater)"
+		errlog "See: https://sourceware.org/libabigail/manual/libabigail-overview.html"
+		exit 1
+	fi
+}
+
+main() {
+	refs_to_check=( "HEAD^1" )
+	while getopts "hr:" opt; do
+		case $opt in
+		h)
+			print_usage
+			exit 0
+			;;
+		r)
+			refs_to_check+=( "$OPTARG" )
+			;;
+		esac
+	done
+
+	check_deps
+
+	tmp_dir=$(mktemp -d)
+	trap 'rm -rf $tmp_dir' EXIT
+
+	if [ -z "$KERNEL_SRC" ]; then
+		KERNEL_SRC="$(realpath "$(dirname "$0")"/..)"
+	fi
+	export KERNEL_SRC
+
+	if ! (cd "$KERNEL_SRC" && git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
+		errlog "error - this script requires the kernel tree to be initialized with Git"
+		exit 1
+	fi
+
+	export ARCH
+	export CC
+	export CROSS_COMPILE
+
+	if ! check_changed_files "${refs_to_check[@]}"; then
+		errlog "UAPI header ABI check failed"
+		exit 1
+	fi
+}
+
+main "$@"
--
2.17.1

