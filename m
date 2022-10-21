Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF96074CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJUKP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:15:43 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2087.outbound.protection.outlook.com [40.107.23.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C017EF1B;
        Fri, 21 Oct 2022 03:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTeueDlF31XY/o4XC7rYVdA1wlWF3I7YnO9fnt5sNoIOwmsFoTZOzgSGsOsFqCOC0912bQqhR1awmyZu934xvm2YAJw7v6M6eVsvyFPwE7yOR0+Xul44KzxemM8vCcFwcA69SDZ+vLUHLXJmDSgVkACydNAav6JF4yxq7KxuuYBYZsaycxkteqv8VdmS0anpqQnjAn7/Y5Sg/h+fyEfK4GZpXABxniwMiWz+DBURbjeO0UA3pbRWzLNYlckiIb26jaPI1tFw9JLLyq45ocRWv8UedOKX6IgUo5t/Z59iVojQHqSJAwVNzpLgJJayarqrQi0n5lcNS2y2+BqJNsxnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uojlt1iwd2XRGNWQ1Tcn4xvLLLHcGeXKutHKznig1XM=;
 b=c881KOlxrb+utYS+D3At0fW2za0sljr0ZjufuSoPB9l7T37HSK1CJWXwYAjPhYVsrIgXjGW0UYULfeu3Vn5KfTKRDDSuEt07j02sjHXMTL2ERTgur8KS0mSutT+R3O4t88I1MvqjzvaAP13Y8yxMiz52mTRTCPcORPpm3Fn0s7p01n4bP7SvbVUpZajWmUUj6paV3A7V/1i9SeBeMZDxR5OwGK34ZkjqFyVJmI9+w40sxbHAhcrucLDyet4LGWlox/psZxgnG13iux44ljNpxJCXj+HqSkBw4BPuy6fL61FBjiTAZvXv/KbkTmNkmt89IIo+Ue2eTWnlkJNcsnITGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.48) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uojlt1iwd2XRGNWQ1Tcn4xvLLLHcGeXKutHKznig1XM=;
 b=ddhbW8hPzrPcZtwg1ophLU6826hAUu6i8OWdFQKeUkEsSyIXYwsp9GpmxZTB1Vo4scNPYmJOl++6bzNpStjMeJXIoZhWO/mWvKGUaMe1vz/mwLl6fDuNQw92TcJKJfvXVECQKakkSIjGUUsUooluHSUjlDWBS22LYQXtqKGDpKY=
Received: from AS9PR04CA0094.eurprd04.prod.outlook.com (2603:10a6:20b:50e::23)
 by GV0P278MB0049.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 10:15:34 +0000
Received: from AM0EUR02FT035.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:50e:cafe::94) by AS9PR04CA0094.outlook.office365.com
 (2603:10a6:20b:50e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Fri, 21 Oct 2022 10:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch; pr=C
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM0EUR02FT035.mail.protection.outlook.com (10.13.54.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 10:15:33 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 21 Oct
 2022 12:15:18 +0200
Received: from cs-ccr-fecosdev.cern.ch (128.141.98.33) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 21 Oct
 2022 12:15:17 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Federico Vaga" <federico.vaga@cern.ch>
Subject: [PATCH 1/2] package: add tar development package for 3rd party modules
Date:   Fri, 21 Oct 2022 12:14:52 +0200
Message-ID: <20221021101452.1367745-2-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221021101452.1367745-1-federico.vaga@cern.ch>
References: <20221021101452.1367745-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.141.98.33]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT035:EE_|GV0P278MB0049:EE_
X-MS-Office365-Filtering-Correlation-Id: 977344f1-935a-4831-ea4d-08dab34d30ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDje6GP4i9RBfrTZaXJY9m5UkFhHLyE4WJCeEcR04cImN39hPAAmdBpRZd921jz7E+zn3SmcKHbtehHxtHgkQlSNRrWJqgFzS1ACWwegj5RM2RUuPNUv0LZfrQxhOsBflFvC6H6wg8lkqowcyWXxQBk9VFX5deTWtOgQis9bhTvZMLPcdXe0peQ7iAX7gYFkTCMP8hnATFicvuFaB962Frw14x+L7u0JYPpcwr3eDK1ks4IvvSF7qER9NY35q+4mcLijsigbBCTWCuBDQ26QiCIUmtWNR8Wla8epNxb9pMnmcXPSOVMPrfAnnL2BwbjHaw7OW0QWETLwwHYKBb8l6QiLmBF4zA95G93duvryX3mUiJJ80iwwUXUj4Bs0VCjeuCnJPmrp6njoSiCPTHpNGMGemX6h+jgMIY1YtQJ/Gx/RpJ3uaafOAEzTMfE0EnOJUbEW+OwvFzIpqFMd20MJJyGt0/efLK2tAN6efbAPFPtLjKVLkw693ZpWObS6G6UPwgiXUJ0OMyUffTTkYsn2c9IUIJ0+urBLvsgfzuTk3tLbOb6FRYCvieUWgaaotFoEa6qWlY/jQG8o6qEMJafYucG/ojhQG9i07QTuQ/V+r/PvOgmCBw5SPbo2afTEfrwiU+ZvrnZj98zIOPpbhmurR9fM7875UTVyVgEZGfXNdBS4gAL3PFEa6p+jHJweIl/A5X3m0jdFemnGloAc9CgJfpvs7Km7w/MCWQ/7+aEI3uU6xk8BELaR1hNHAAWKuYddug9c0Fffq7zRYpaN+rAvbw==
X-Forefront-Antispam-Report: CIP:188.184.36.48;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx12.cern.ch;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(786003)(70586007)(110136005)(54906003)(316002)(36756003)(4326008)(107886003)(44832011)(6666004)(40480700001)(8936002)(41300700001)(7696005)(36860700001)(5660300002)(41320700001)(7636003)(82740400003)(426003)(2616005)(186003)(16526019)(956004)(47076005)(336012)(8676002)(2906002)(356005)(40460700003)(70206006)(82310400005)(1076003)(86362001)(83380400001)(26005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 10:15:33.6879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977344f1-935a-4831-ea4d-08dab34d30ce
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT035.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0049
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most, if not all, Linux distributions provides a Linux development
package which purpose is to support the building of out-of-tree modules
without providing the entire source tree.

What ends up in this development directory is a mixture of source
files (mainly headers) and generated ones (headers, and tools produced
by `make modules_prepare`).

This patch is an attempt to generate a tarball archive containing all
required files to build external modules. It could be than reused by
packagers.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 Makefile                       |   2 +-
 scripts/Makefile.package       |  13 +++
 scripts/package/buildtar-devel | 207 +++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 scripts/package/buildtar-devel

diff --git a/Makefile b/Makefile
index cfbe6a7de640..36a58394ce16 100644
--- a/Makefile
+++ b/Makefile
@@ -1578,7 +1578,7 @@ CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
 		  arch/$(SRCARCH)/include/generated .objdiff \
-		  debian snap tar-install \
+		  debian snap tar-install* \
 		  .config .config.old .version \
 		  Module.symvers \
 		  certs/signing_key.pem \
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 8bbcced67c22..9523a4dfaee5 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -112,6 +112,13 @@ $(tar-pkgs):
 	$(MAKE) -f $(srctree)/Makefile
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
+tar-dev-pkgs := dir-dev-pkg tar-dev-pkg targz-dev-pkg tarbz2-dev-pkg
+tar-dev-pkgs += tarxz-dev-pkg tarzst-dev-pkg
+PHONY += $(tar-dev-pkgs)
+$(tar-dev-pkgs):
+	$(MAKE) -f $(srctree)/Makefile
+	+$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar-devel $@
+
 # perf-pkg - generate a source tarball with perf source
 # ---------------------------------------------------------------------------
 
@@ -159,6 +166,12 @@ help:
 	@echo '  tarbz2-pkg          - Build the kernel as a bzip2 compressed tarball'
 	@echo '  tarxz-pkg           - Build the kernel as a xz compressed tarball'
 	@echo '  tarzst-pkg          - Build the kernel as a zstd compressed tarball'
+	@echo '  dir-dev-pkg         - Module development as a plain directory structure'
+	@echo '  tar-dev-pkg         - Module development as an uncompressed tarball'
+	@echo '  targz-dev-pkg       - Module development as a gzip compressed tarball'
+	@echo '  tarbz2-dev-pkg      - Module development as a bzip2 compressed tarball'
+	@echo '  tarxz-dev-pkg       - Module development as a xz compressed tarball'
+	@echo '  tarzst-dev-pkg      - Module development as a zstd compressed tarball'
 	@echo '  perf-tar-src-pkg    - Build $(perf-tar).tar source tarball'
 	@echo '  perf-targz-src-pkg  - Build $(perf-tar).tar.gz source tarball'
 	@echo '  perf-tarbz2-src-pkg - Build $(perf-tar).tar.bz2 source tarball'
diff --git a/scripts/package/buildtar-devel b/scripts/package/buildtar-devel
new file mode 100644
index 000000000000..87706d50a302
--- /dev/null
+++ b/scripts/package/buildtar-devel
@@ -0,0 +1,207 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+#
+# (C) 2022 CERN (home.cern)
+# Author Federico Vaga <federico.vaga@cern.ch>
+#
+# This script is used to build a 3rd party kernel module development tarball
+# from the currently prepared kernel.
+#
+
+set -ex
+
+#
+# Some variables and settings used throughout the script
+#
+tmpdir="${abs_objtree}/tar-install-dev"
+tarball="${abs_objtree}/linux-${KERNELRELEASE}-${ARCH}-dev.tar"
+
+#
+# Figure out how to compress, if requested at all
+#
+case "${1}" in
+    dir-pkg-dev|tar-pkg-dev)
+        opts=
+		;;
+	targz-pkg-dev)
+		opts="-I ${KGZIP}"
+		tarball=${tarball}.gz
+		;;
+	tarbz2-pkg-dev)
+		opts="-I ${KBZIP2}"
+		tarball=${tarball}.bz2
+		;;
+	tarxz-pkg-dev)
+		opts="-I ${XZ}"
+		tarball=${tarball}.xz
+		;;
+	tarzst-pkg-dev)
+		opts="-I ${ZSTD}"
+		tarball=${tarball}.zst
+		;;
+	*)
+		echo "Unknown tarball target \"${1}\" requested, please add it to ${0}." >&2
+		exit 1
+		;;
+esac
+
+#
+# Clean-up and re-create the temporary directory
+#
+
+rm -rf -- "${tmpdir}"
+mkdir -p -- "${tmpdir}"
+
+#
+# Copy required files
+#
+FILTER_FILE=$(mktemp)
+cat <<EOF > ${FILTER_FILE}
+
+#
+# Include the following files and directories required to build external modules
+#
+
++ /arch/
++ /arch/${ARCH}/
++ /arch/${ARCH}/**.h
++ /arch/${ARCH}/**/Makefile*
++ /.config
++ /drivers/
++ /drivers/**/Kbuild*
++ /drivers/**/Kconfig*
++ /drivers/**/Makefile*
++ /include/*
++ /include/**/*.h
++ /Kbuild
++ /Kconfig
++ /Makefile
++ /Module.symvers
++ /scripts/Makefile.*
++ /scripts/basic
++ /scripts/basic/fixdep
++ /scripts/bin2c
++ /scripts/checkincludes.pl
++ /scripts/checkstack.pl
++ /scripts/checkversion.pl
++ /scripts/check-local-export
++ /scripts/depmod.sh
++ /scripts/extract-cert
++ /scripts/gcc-goto.sh
++ /scripts/gcc-version.sh
++ /scripts/gcc-x86_32-has-stack-protector.sh
++ /scripts/gcc-x86_64-has-stack-protector.sh
++ /scripts/genksyms
++ /scripts/genksyms/genksyms
++ /scripts/headers_install.sh
++ /scripts/kallsyms
++ /scripts/Kbuild.include
++ /scripts/kconfig
++ /scripts/kconfig/conf
++ /scripts/kernel-doc
++ /scripts/ld-version.sh
++ /scripts/Lindent
++ /scripts/makelst
++ /scripts/mksysmap
++ /scripts/mkuboot.sh
++ /scripts/mod/
++ /scripts/mod/modpost
++ /scripts/module.lds
++ /scripts/patch-kernel
++ /scripts/pahole-flags.sh
++ /scripts/recordmcount
++ /scripts/recordmcount.pl
++ /scripts/setlocalversion
++ /scripts/sign-file
++ /scripts/subarch.include
++ /scripts/unifdef
++ /scripts/ver_linux
++ /tools
++ /tools/objtool/
++ /tools/objtool/objtool
++ /.version
+
+#
+# Completly ignore the following directories
+#
+- /arch/*
+- /Documentation
+- /LICENSES
+- /block
+- /certs
+- /crypto
+- /drivers/*
+- /fs
+- /init
+- /io_uring
+- /ipc
+- /kernel
+- /lib
+- /MAINTAINERS
+- /mm
+- /modules.*
+- /net
+- /README
+- /rust
+- /samples
+- /scripts/*
+- /scripts/basic/Makefile
+- /scripts/genksyms/*
+- /scripts/kconfig/*
+- /scripts/mod/*
+- /security
+- /sound
+- /System.map
+- /tools/*
+- /tools/objtool/*
+- /usr
+- /virt
+
+#
+# Completly ignore intermediate directories
+#
+- /source
+- /tar-install*
+- /${O}
+#
+# Completly ignore the following files
+#
+
+- .*
+- *.a
+- *.c
+- *.o
+- *.S
+- *vmlinux*
+EOF
+
+#
+# Copy from object directory as well when it is not the same as the source one
+#
+if [ "${abs_objtree}" != "${abs_srctree}" ]
+then
+    rsync -a --filter="merge ${FILTER_FILE}" ${abs_objtree}/ ${tmpdir}
+fi
+rsync -a --filter="merge ${FILTER_FILE}" ${abs_srctree}/ ${tmpdir}
+rm ${FILTER_FILE}
+
+if [ "${1}" = dir-pkg-dev ]; then
+	echo "Kernel tree successfully created in $tmpdir"
+	exit 0
+fi
+
+#
+# Create the tarball
+#
+if tar --owner=root --group=root --help >/dev/null 2>&1; then
+	opts="$opts --owner=root --group=root"
+fi
+
+opts="$opts"
+
+tar cf $tarball -C $tmpdir $opts .
+
+echo "Tarball successfully created in $tarball"
+
+exit 0
-- 
2.27.0

