Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42869A319
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBQAuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBQAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:00 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F034F3C7B7;
        Thu, 16 Feb 2023 16:49:56 -0800 (PST)
X-QQ-mid: bizesmtp76t1676594974t44ilj1c
Received: from localhost.localdomain ( [116.30.131.224])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 17 Feb 2023 08:49:31 +0800 (CST)
X-QQ-SSF: 01200000000000C0T000000A0000000
X-QQ-FEAT: znfcQSa1hKbHsodWWJ7dLyJeU0dQLSJ2PPtzz1iLzMNgSELCkUn2ujNlhycbg
        vLg03SNvb9EFMysNu9WjgjH2yYBaAi1fGVqPKaFhctNfTwt+bbxYpXQIVh9rDo/8cNrLyPt
        ToX08gVh/Po6w/uiFpE5NpG8RVgjCEHPEAjNBEvKB228hcFV2zJd7lPvufzHTfmfzprQ+fT
        BT5FvJHdZIQ0ZHz+hIneTfMRDTSLb6HDEunI+ke40/IGoYkdjw1kyDvwLpdYHmyCpkkWnqA
        O1Hes08eR/3n/SlY9lwkeFrEDn7M4DXKn75YILTWaoiJycDGTzD8fi1d+13MWbJyxm4+S3n
        g5P3PHo4ATnp0TD9593FPSzON//EjXHb6RjyzNWaKJfKxUqmS92Hopcemr0iQ8IBGReu7VW
X-QQ-GoodBg: 0
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Palmer Dabbelt <palmer@rivosinc.com>, Willy Tarreau <w@1wt.eu>,
        Paul Burton <paulburton@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [RFC PATCH 1/5] syscall: Allow configure used system calls
Date:   Fri, 17 Feb 2023 08:49:21 +0800
Message-Id: <ad53ec9ec7168b6ca5a55e4c6b4583baa4dd0fc6.1676594211.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1676594211.git.falcon@tinylab.org>
References: <cover.1676594211.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new CONFIG_SYSCALLS_USED is added to configure the system calls used
in a target system (especially for the ultra small embedded systems),
the other system calls will be disabled.

If further enabling CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION, the other
ones (if also not used by kernel itself) will be removed automatically.

The used system calls should be listed one by one like this:

    write exit reboot

The architecture should implement it and then select the
HAVE_SYSCALLS_USED option.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 44e90b28a30f..2c4b8b234168 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1502,6 +1502,10 @@ config BPF
 	bool
 	select CRYPTO_LIB_SHA1
 
+config HAVE_SYSCALLS_USED
+	bool
+	default n
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
@@ -1728,6 +1732,24 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config SYSCALLS_USED
+	string "Configure used syscalls (EXPERIMENTAL)"  if EXPERT
+	depends on HAVE_SYSCALLS_USED
+	default ""
+	help
+          This option allows to configure the system calls used in a target
+          system, the other system calls will be disabled.
+
+          If further enabling CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION, the
+          other ones (if also not used by kernel itself) will be removed
+          automatically.
+
+          The used system calls should be listed one by one like this:
+
+              write exit reboot
+
+          If unsure, keep this empty.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
-- 
2.25.1

