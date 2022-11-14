Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38575627CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiKNLqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiKNLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110523392;
        Mon, 14 Nov 2022 03:45:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B9556106E;
        Mon, 14 Nov 2022 11:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EBBC433D6;
        Mon, 14 Nov 2022 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426305;
        bh=cDaL2fr4ds1QFPZqTUk+kKTp3g2JDWGKaf0MMC6B8X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axz9z9rmp0DF1yNW2Noyvv4Ams50QT88IMMv7mytIv0BAoxo3ZprIJOr3jD2qNkrH
         hLr2L8iLnT9EqQrGmrVi+ERKM2z7/wk2jkUtqr2gQggsZfBszIRDNeWhDZG0m/xMPI
         g6leDXiyanYdsK11/1nbv9vxpama8/y0C7iVa5DVRx60ByfqeVTVBFztfRXZJdEy1G
         vlLWZCVQlFb/1TNrxcaswglRAzWwC4BgmYFyM8qtqLiXtG+5cBribG3CViVtlQEqZE
         ZksYWKtDotJ7HbrcxfDMelz0cNtFB3Cf4kpoaaIORBy+haBnZdaPlB7QSUCHuNlwsq
         7N3JHoXdEPk5Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 28/46] scripts, lto: re-add gcc-ld
Date:   Mon, 14 Nov 2022 12:43:26 +0100
Message-Id: <20221114114344.18650-29-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The primary goal of the script is to mangle linker command line arguments
into something which gcc understands. Such as converting "-z now" into
"-Wl,-z,now".

The script was removed by commit 86879fd277e8 (scripts: remove obsolete
gcc-ld script) as there was no use in the kernel. It had been added long
time ago to support exactly these lto patches, so we need to add it back
now.

Since the removed version, it is improved a bit:
* some missing linker and gcc command line arguments were added, and
* when V=1 is specified, it prints the final gcc command line

[js] rebase + commit message massage

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/gcc-ld | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 scripts/gcc-ld

diff --git a/scripts/gcc-ld b/scripts/gcc-ld
new file mode 100755
index 000000000000..13e85ece8d04
--- /dev/null
+++ b/scripts/gcc-ld
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# run gcc with ld options
+# used as a wrapper to execute link time optimizations
+# yes virginia, this is not pretty
+
+ARGS="-nostdlib"
+
+for j in "$@" ; do
+	if [ "$j" = -v ] ; then
+		exec `$CC -print-prog-name=ld` -v
+	fi
+done
+
+while [ "$1" != "" ] ; do
+	case "$1" in
+	-save-temps*|-m32|-m64) N="$1" ;;
+	-r) N="$1" ;;
+	-flinker-output*) N="$1" ;;
+	-[Wg]*) N="$1" ;;
+	-[olv]|-[Ofd]*|-nostdlib) N="$1" ;;
+	--end-group|--start-group|--whole-archive|--no-whole-archive|\
+--no-undefined|--hash-style*|--build-id*|--eh-frame-hdr|-Bsymbolic)
+		 N="-Wl,$1" ;;
+	-[RTFGhIezcbyYu]*|\
+--script|--defsym|-init|-Map|--oformat|-rpath|\
+-rpath-link|--sort-section|--section-start|-Tbss|-Tdata|-Ttext|-soname|\
+--version-script|--dynamic-list|--version-exports-symbol|--wrap|-m|-z)
+		A="$1" ; shift ; N="-Wl,$A,$1" ;;
+	-[m]*) N="$1" ;;
+	-*) N="-Wl,$1" ;;
+	*)  N="$1" ;;
+	esac
+	ARGS="$ARGS $N"
+	shift
+done
+
+[ -n "$V" ] && echo >&2 $CC $ARGS
+
+exec $CC $ARGS
-- 
2.38.1

