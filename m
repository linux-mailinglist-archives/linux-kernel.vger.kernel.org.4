Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87F6D50DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjDCSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjDCSkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:40:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422E115
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:40:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x4-20020a170902ec8400b001a1a5f6f272so17890566plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680547245;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l7KXY8lY6kh4yGHJrlGOwQN4b74JegDEme6RD0OCgco=;
        b=MmY3StUttrl+Dl0KtrfiUBQYX1fBd6olu28lJlPxriJAesyrYGeWv6rxB4igcoDrrS
         uCxzoybWGwVCrc4KwE7tXIatVHRsynan93kGhqKUPlW8el7kw8FlXpbKl6K13DlBtDto
         XlL9eWWTT8IqQPo+92gSOLxNTUA283A7elT3V3+K1t7iDtr/f+02Z6BM4G5/44Fp0j63
         z/eBYq3xcA8Yf4hFF1seNWEB+EXU3+BFcuSPJPk6Zu/5FCiugkgJjThlQcBlNWI0AuCv
         JuqiPg6gKulnsFOgJgblvM7b9R9mcszWjoCokybbHOgaJ1QFwMrmoVZHrAat7+GRGwVO
         UkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547245;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7KXY8lY6kh4yGHJrlGOwQN4b74JegDEme6RD0OCgco=;
        b=sA1lkJvtjK/RiEjIrCuKRKJhRbz3lA6D0MX/ejagUqXsxta4CJ2ywTro0iVUthdtjp
         +W8anIFaJn1skGHTUBWWlozb/Zlv+B+UVjHy6ng4V+9d1rr7aG+kZUiWMz1VAoO+8tdP
         buWCNM6X420Z6/7BaQpSAKWCuzpnvSQG4ue+jEF/kwUwNLAiAy25xHTuPRKCl8B62nUN
         Ntxi/rbF6sKSVi2B24D6e6wfVoF7Df/GYQppOhYq00ZKy2pb0rBr9lXYkjA1ati/BgAq
         3MTcpWI29r6SrazRIOTxce73zO5PmEGRy4aQs7UcED9ai0foNFf8aoz0l0YpictnLcqH
         BYuQ==
X-Gm-Message-State: AAQBX9cWA5j33h2sAHywFoKnfkcdQso+r5SDKFGpczQE3WsS8qyDAuj7
        oU5SJ4scewWTGPy1eH8B1NVya0kvOY3C
X-Google-Smtp-Source: AKy350ZZdr2WR9ZcTjWW1hUH12pOOyW8M+tD+hF6gzQBIwL78qeJrSAkQU0Lm7teFIKEXeaZuysvtGqqeaPZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a17:903:1358:b0:19f:3cc1:e3bd with SMTP id
 jl24-20020a170903135800b0019f3cc1e3bdmr28764plb.4.1680547244921; Mon, 03 Apr
 2023 11:40:44 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:40:29 -0700
Message-Id: <20230403184033.1836023-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 0/4] Support for llvm-addr2line
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addr2line command is started and then addresses piped to it. In
order to determine the end of a addr2lines output a ',' it output with
an expectation to get '??\n??:0\n' as a reply. llvm-addr2line differs
in that ',' generates a reply of ','.

The approach detects and then caches the addr2line style. When records
are read the sentinel is detected appropriately.

Comparing the output there is a little more inline data on my machine
with llvm-addr2line:
$ sudo perf record -a -g sleep 1
$ sudo perf report --addr2line=addr2line > a.txt
$ sudo perf report --addr2line=llvm-addr2line > b.txt
$ wc -l a.txt b.txt
  12386 a.txt
  12477 b.txt

Some other small changes, switching to the api/io code to avoid file
streams wrapping the command's stdin/stdout. Ignore SIGPIPE for when
addr2line exits and writes fail.

v2. Address review comments from Arnaldo and Namhyung, fixing a
    realloc error path, argument ordering and a comment.

Ian Rogers (4):
  tools api: Add io__getline
  perf srcline: Simplify addr2line subprocess
  perf srcline: Support for llvm-addr2line
  perf srcline: Avoid addr2line SIGPIPEs

 tools/lib/api/io.h        |  45 ++++++++++
 tools/perf/tests/api-io.c |  36 ++++++++
 tools/perf/util/srcline.c | 171 +++++++++++++++++++++++---------------
 3 files changed, 184 insertions(+), 68 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

