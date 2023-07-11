Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587274F52D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGKQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGKQaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C829CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDACA61515
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083BBC433C8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689092999;
        bh=gJ41FrkMgC8wmnXMSCJF6e1D3EvOp1u4fS6IyfvlNmg=;
        h=Date:From:To:Subject:From;
        b=klhIFyJMPy7Gs6zUB4+BVgnFiUTfVv7GqGieFXyvnufOVpEdY+OQvRtTTKt4BEX/x
         aMC/a7MexjGu5TjE6hzGoHscNGhkVF+dDNtGYxmqVD2XRx0vQ/sgidy8+TSCxa1fhp
         xBuA6rHkS9+/TflO4g+KkoXv+NDdKrcA5rbr1/Nlwx2Va0cGQsyr3LF2MJ6eGnVj8F
         j8ZORZnqwPcEy9l+w6LWt9Vt6Rg4WpGI1xKTwzfJYdUJFzlPCmyOSwQVJaf5O1eIWU
         7RGpaUUnZpSibbPyx5l9mhtIdOVcDi1D31B2R25CYVj3h9dUCXToGO7LHTcwhj8Nnu
         jerbcB68zzPuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2AF7640516; Tue, 11 Jul 2023 13:29:56 -0300 (-03)
Date:   Tue, 11 Jul 2023 13:29:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/prctl.h with the
 kernel sources
Message-ID: <ZK2DhOB6JJKu2A7M@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in:

  1fd96a3e9d5d4feb ("riscv: Add prctl controls for userspace vector management")

That adds some RISC-V specific prctl options:

  $ tools/perf/trace/beauty/prctl_option.sh > before
  $ cp include/uapi/linux/prctl.h tools/include/uapi/linux/prctl.h
  $ tools/perf/trace/beauty/prctl_option.sh > after
  $ diff -u before after
  --- before	2023-07-11 13:22:01.928705942 -0300
  +++ after	2023-07-11 13:22:36.342645970 -0300
  @@ -63,6 +63,8 @@
   	[66] = "GET_MDWE",
   	[67] = "SET_MEMORY_MERGE",
   	[68] = "GET_MEMORY_MERGE",
  +	[69] = "RISCV_V_SET_CONTROL",
  +	[70] = "RISCV_V_GET_CONTROL",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

That now will be used to decode the syscall option and also to compose
filters, for instance:

  [root@five ~]# perf trace -e syscalls:sys_enter_prctl --filter option==SET_NAME
       0.000 Isolated Servi/3474327 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23f13b7aee)
       0.032 DOM Worker/3474327 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23deb25670)
       7.920 :3474328/3474328 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24fbb10)
       7.935 StreamT~s #374/3474328 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24fb970)
       8.400 Isolated Servi/3474329 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24bab10)
       8.418 StreamT~s #374/3474329 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24ba970)
  ^C[root@five ~]#

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Chiu <andy.chiu@sifive.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index f23d9a16507f6f46..3c36aeade991e945 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -294,4 +294,15 @@ struct prctl_mm_map {
 
 #define PR_SET_MEMORY_MERGE		67
 #define PR_GET_MEMORY_MERGE		68
+
+#define PR_RISCV_V_SET_CONTROL		69
+#define PR_RISCV_V_GET_CONTROL		70
+# define PR_RISCV_V_VSTATE_CTRL_DEFAULT		0
+# define PR_RISCV_V_VSTATE_CTRL_OFF		1
+# define PR_RISCV_V_VSTATE_CTRL_ON		2
+# define PR_RISCV_V_VSTATE_CTRL_INHERIT		(1 << 4)
+# define PR_RISCV_V_VSTATE_CTRL_CUR_MASK	0x3
+# define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
+# define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.37.1

