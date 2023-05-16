Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8801705606
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjEPSdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEPSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:33:09 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1859CB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:33:02 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-552621bdbbbso1743692eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684261982; x=1686853982;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XH0y+GTalSRtMGbisTzJJVpaGWPePAl2Mpmnaf9OUxE=;
        b=HWtc9Z02lS5k5RwvWtOlHK0AD+3B3Pw9wAMNhzPLQ4YEsoZKA5DdHsmgUcj1cL8MC+
         atLMYF70U4BpQbVqCbdf/3cqlw96HaRmbFKOOxWsKonFoPkMNQXUKWkozXk9Pf6LlhD6
         sI2s5nM0Bvamx7XZf7s3kjYsMxObm/E1jRg+c8eBfvanYc7IUX0QLHEPgvVLHJMjFO3s
         VxhptOF7iCgcfDt8hAEs6aVqCnMbFPfv3kyzAo8CetwBTutWBcWfQUPRkhta+UKB46FC
         wHSm9zVsmOmgSYNu0Q8uF9vXPBIaD3suk4c7GJY2yWWsSZq+ZSn+WZaVi6lXwsziQGUm
         JM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261982; x=1686853982;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XH0y+GTalSRtMGbisTzJJVpaGWPePAl2Mpmnaf9OUxE=;
        b=CXEpC29vNl8HEWAuLgqL2tAxaxCR1KguQqkFgHs1ir+7k5BGb0wkPhBOVwP7+2rfB9
         ZwFDW8xckm7z8Fwgof57btPKpm8tLbhTLnnifCMx2Ux7lvHmPiZTx3wuEb2X9qeLyDJ0
         ibsbI77UF4wrf5eMIROcwy/D4Qhd/xLx5Ju+75owpEMJ1ixX5gMLX7j6Oja9SSF6/W2I
         qIopw3onJopqEULUd73N9BZ7Z1Vh1OiuAErmi5hzNxyXH1hzWIwDt3NFqvpBFDg7y8XV
         U/oay6NMGQVB+lgFLZNF656o/pfqJaqUzDvjUbEMWm4QhNM0acEfQAKIUWbcFjMBDF7d
         Lvpw==
X-Gm-Message-State: AC+VfDytNac0KXlLnTMCwlMfInD7RvKaIvFly1oS5A9l1E4fXyJdT3pz
        Q9BSKdTd1nidncmRTu6mwyffdyhFWRw/cw==
X-Google-Smtp-Source: ACHHUZ4KYXgPdS1EVNlQmkfSKCXh4Ru9AlZkruYSiPyUYZFjrzO/n2EK403329umZkZimGHSkdNUtg==
X-Received: by 2002:a4a:91cf:0:b0:54c:723b:36a8 with SMTP id e15-20020a4a91cf000000b0054c723b36a8mr11420813ooh.4.1684261981716;
        Tue, 16 May 2023 11:33:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m12-20020a056820034c00b00545442d89b3sm3140411ooe.23.2023.05.16.11.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:33:01 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39808403B5; Tue, 16 May 2023 15:32:59 -0300 (-03)
Date:   Tue, 16 May 2023 15:32:59 -0300
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync s390 syscall table file
 that wires up the memfd_secret syscall
Message-ID: <ZGPMW0p++D1Jdvf6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

To pick the changes in these csets:

  7608f70adcb1ea69 ("s390: wire up memfd_secret system call")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible (adapted from the x86_64 test output):

  # perf trace -v -e memfd_secret
  event qualifier tracepoint filter: (common_pid != 13375 && common_pid != 3713) && (id == 447)
  ^C#

That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
tracepoints.

  $ grep memfd_secret tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
  447    common  memfd_secret            sys_memfd_secret
  $

This addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/entry/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 799147658dee20dd..b68f47541169f9af 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -449,7 +449,7 @@
 444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
 445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
-# 447 reserved for memfd_secret
+447  common	memfd_secret		sys_memfd_secret		sys_memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
-- 
2.39.2

