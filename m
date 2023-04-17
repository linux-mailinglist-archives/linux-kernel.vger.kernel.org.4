Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244576E47BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDQMaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjDQMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:30:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0CE49E9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:30:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso1314674e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681734612; x=1684326612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/JB5DRDshib4Tz8g7yVBW+9lQnfgBzFAQIBePQQwSg=;
        b=vCxJdFhdT+WCdGm7iu3cW5J4HK1ht+4ta0pd6M/4Mx/Jr+uAZq31KR0AYIxFlYex10
         nrmTFjSLjZKAKIadFTbS2ZPZvGno4TuQAUNY6xOyAR+rqoLdzLJqFpzk5w2QnY0zrU0B
         z9AUV+qXvtTi8r9hE0+HDTLzryfade54+QIUZcG+C94fqFyfOjTiRFU21BCEnWtGuTMh
         zdrSYa86ucUMDuuQtx7ESPaBvN/3LOQjI1uu5zpBTwkZFCPGx6fNgbrLg9HvFWqJlfJc
         i2F1r6ZshEcXDi6HRd4xOgP7ACrmFah9b3JDhVbOVwL5H/NtQzGHKVXVXZf1UfSl9s9+
         ipCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734612; x=1684326612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/JB5DRDshib4Tz8g7yVBW+9lQnfgBzFAQIBePQQwSg=;
        b=LMIKXY7w3tnxogiQ7r5rWcxxLgUDT/sK91yXRf/0LtJA+w6ma5RcGtqivmreERBj9Q
         OHxeEhklPjS3UoEozVS0k9udfqKjJ3hFDh4vxMBXeHGTuXNmfpUeJcilMmIzIEOXA/KC
         kjrqShj8lyYYZ74qw3zDlNni1yGOtstwo0qRqS6VrxQHEhB/9YFxadg1U+iPCf8Jnmio
         6Ax5H3DnEceGB+iu0yyJdBDsmD+JJ6zFM0Zz6Djf31/hYTfJyr4C1p2c9LBP/mC0fzUW
         nkZggqsQYJrLxim0P0WspF4epsPK/V3Acjnok2xqhZ2izNrU5Q301mMJc8SzllDLzhUN
         xwVQ==
X-Gm-Message-State: AAQBX9cgk4kykowhFkxFgARjyRBDUPkhGdyXy//NrtXQOLSesKnUTNvf
        ZUvKQBb8mySrm+20z3O36QFEeEm4TAioz9G1rV+7Iw==
X-Google-Smtp-Source: AKy350asj3McUx7cd43SB9wv7K+s/l9AmPs16fLHun2t6r4FImgn7a2GqXnKPqh6TsP4gy2ji6dEKA==
X-Received: by 2002:ac2:4210:0:b0:4ea:f5dd:8aa1 with SMTP id y16-20020ac24210000000b004eaf5dd8aa1mr1972414lfh.18.1681734611756;
        Mon, 17 Apr 2023 05:30:11 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b004cb23904bd9sm2020078lfh.144.2023.04.17.05.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:30:11 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     stable@vger.kernel.org
Cc:     acme@redhat.com, andres@anarazel.de, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [backport PATCH 0/2] stable v5.15, v5.10 and v5.4: fix perf build errors
Date:   Mon, 17 Apr 2023 14:29:41 +0200
Message-Id: <20230417122943.2155502-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to see these patches backported. They are needed so perf
can be cross compiled with gcc on v5.15, v5.10 and v5.4.
I built it with tuxmake [1] here are two example commandlines:
tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 --kconfig defconfig perf
tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12 --kconfig defconfig perf

Tried to build perf with both gcc-11 and gcc-12.

Patch 'tools perf: Fix compilation error with new binutils'
and 'tools build: Add feature test for init_disassemble_info API changes'
didn't apply cleanly, thats why I send these in a patchset.

When apply 'tools build: Add feature test for
init_disassemble_info API changes' to 5.4 it will be a minor merge
conflict, do you want me to send this patch in two separate patches one
for 5.4 and another for v5.10?

The sha for these two patches in mainline are.
cfd59ca91467 tools build: Add feature test for init_disassemble_info API changes
83aa0120487e tools perf: Fix compilation error with new binutils

The above patches solves these:
util/annotate.c: In function 'symbol__disassemble_bpf':
util/annotate.c:1729:9: error: too few arguments to function 'init_disassemble_info'
 1729 |         init_disassemble_info(&info, s,
      |         ^~~~~~~~~~~~~~~~~~~~~


Please apply these to v5.10 and v5.4
a45b3d692623 tools include: add dis-asm-compat.h to handle version differences
d08c84e01afa perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK>

The above patches solves these:
/home/anders/src/kernel/stable-5.10/tools/include/linux/kernel.h:43:24: error: comparison of distinct pointer types lacks a cast [-Werror]
   43 |         (void) (&_max1 == &_max2);              \
      |                        ^~
builtin-sched.c:673:34: note: in expansion of macro 'max'
  673 |                         (size_t) max(16 * 1024, PTHREAD_STACK_MIN));
      |                                  ^~~


Please apply these to v5.15, v5.10 and v5.4
8e8bf60a6754 perf build: Fixup disabling of -Wdeprecated-declarations for the python scripting engine
4ee3c4da8b1b perf scripting python: Do not build fail on deprecation warnings
63a4354ae75c perf scripting perl: Ignore some warnings to keep building with perl headers

Build error that the above 3 patches solves are:
/usr/lib/x86_64-linux-gnu/perl/5.36/CORE/handy.h:125:23: error: cast from function call of type 'STRLEN' {aka 'long unsigned int'} to non-matching type '_Bool' [-Werror=bad-function-cast]
  125 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^

Cheers,
Anders
[1] https://tuxmake.org/

Andres Freund (2):
  tools perf: Fix compilation error with new binutils
  tools build: Add feature test for init_disassemble_info API changes

 tools/build/Makefile.feature                        |  1 +
 tools/build/feature/Makefile                        |  4 ++++
 tools/build/feature/test-all.c                      |  4 ++++
 tools/build/feature/test-disassembler-init-styled.c | 13 +++++++++++++
 tools/perf/Makefile.config                          |  8 ++++++++
 tools/perf/util/annotate.c                          |  7 ++++---
 6 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c

--
2.39.2

