Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43A74192E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjF1UBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjF1UBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:01:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13171FEF;
        Wed, 28 Jun 2023 13:01:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666ed230c81so151775b3a.0;
        Wed, 28 Jun 2023 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687982504; x=1690574504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=J9UHeSAtDRa1tBV+A6elzPizNDbYef1MWO1gfBdmee8=;
        b=jYpyHokZBf/wDq+Thhimi6BWl8Ao7q54AXXqyRDqWc9ylXCununK4TIZgB6ZQaOyXt
         il23nxf+D6HzYWRfPOL8sUo1mRRwFuuoP44OT4yEFoJgyyzmC9HwzSVQELJOWkdnY9nk
         f0N5qYS5TOkEEwFzkQ5ZVtp2XATmH2hx9u7iCm7J1c03X6Q4sqvNUym6ZLfeblFujBSz
         rNOW2EeK8Td0T5cshaQ8vm6cZ+RxBn72Gj/RxGBIR8Cbo9d1Ne9MQvl/tuOiRdhXZ1tz
         8MAYeIjDBcRp1p74a+uH3+fASHHSBG9/2zH7YsjzlU5t/+JGOBLyiN7oy3SpNC7axqQi
         tdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982504; x=1690574504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9UHeSAtDRa1tBV+A6elzPizNDbYef1MWO1gfBdmee8=;
        b=EOAw1gkRr1jJhbdevqm0po+HUbD9Fx1h02k2LNOIyEr87nACtc2MjmwMXulqx+87Nz
         8IFAjCiEhecYDIINVXCNqX12ogiXVWv8NYXwHbome40KDkpv0rYr7xVdEtzAdh6Fs1oR
         MG8kTjfvpF0eVVniZBFqh0Ua/TnLX0Um6BE/QFwAESMjt+IuqjtGAUtpMwvNAt+mJT8I
         Y8/YvBbWoW8G8rozvNbvOdx+2KudBy8gLm4E7jVraFBc9yzoceXEOtYUZVZeHIk7344D
         9DtXtJKxhb4ideW4ZMBX927oabs1vJrVy7Dr06EXZxBRRzlsroyL8NQytQdOMv+RegbZ
         1VAw==
X-Gm-Message-State: AC+VfDwVJsBWn1353lTpLnUHoe6C8AJEsgonnx194bUYIEO3/fDxRhtc
        d464NvYzmDs6BXYE3KIzFG0=
X-Google-Smtp-Source: ACHHUZ6jwu4ItZ+F+fSi9ezcWMgNHBXs8CTxZP0kYoBcpALG1jnUhG6RdYGL8KjtOzscaDidmFL8xQ==
X-Received: by 2002:a05:6a00:b90:b0:674:8fe0:126f with SMTP id g16-20020a056a000b9000b006748fe0126fmr14350665pfj.27.1687982504161;
        Wed, 28 Jun 2023 13:01:44 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:fc6b:e50c:c8f0:b09b])
        by smtp.gmail.com with ESMTPSA id f3-20020aa78b03000000b0065e154bac6dsm7340376pfd.133.2023.06.28.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:01:43 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHSET 0/4] perf lock contention: Add CSV style output support (v2)
Date:   Wed, 28 Jun 2023 13:01:37 -0700
Message-ID: <20230628200141.2739587-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is v2 of perf lock contention CSV output change.
I've added --output option and a test case according to Ian's feedback.

Sometimes we want to process the output by external programs.  Let's add
the -x option to specify the field separator like perf stat.

  $ sudo ./perf lock con -ab -x, sleep 1
  # output: contended, total wait, max wait, avg wait, type, caller
  19, 194232, 21415, 10222, spinlock, process_one_work+0x1f0
  15, 162748, 23843, 10849, rwsem:R, do_user_addr_fault+0x40e
  4, 86740, 23415, 21685, rwlock:R, ep_poll_callback+0x2d
  1, 84281, 84281, 84281, mutex, iwl_mvm_async_handlers_wk+0x135
  8, 67608, 27404, 8451, spinlock, __queue_work+0x174
  3, 58616, 31125, 19538, rwsem:W, do_mprotect_pkey+0xff
  3, 52953, 21172, 17651, rwlock:W, do_epoll_wait+0x248
  2, 30324, 19704, 15162, rwsem:R, do_madvise+0x3ad
  1, 24619, 24619, 24619, spinlock, rcu_core+0xd4

The first line is a comment that shows the output format.  Each line is
separated by the given string ("," in this case).  The time is printed
in nsec without the unit so that it can be parsed easily.

The code is available at 'perf/lock-con-csv-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf lock: Remove stale comments
  perf lock contention: Add -x option for CSV style output
  perf lock contention: Add --output option
  perf test: Test perf lock contention CSV output

 tools/perf/Documentation/perf-lock.txt    |   5 +
 tools/perf/builtin-lock.c                 | 383 ++++++++++++++++------
 tools/perf/tests/shell/lock_contention.sh |  36 ++
 3 files changed, 328 insertions(+), 96 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

