Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93375BB1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIPR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiIPR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:59:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582AB6D23;
        Fri, 16 Sep 2022 10:59:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so367260pja.1;
        Fri, 16 Sep 2022 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=tRAA+E/aZ0xiHg9vChgfLqoCdmlsysypclNjGI6q1Cw=;
        b=V6MLItuOP77XFx9Hqo1Q3gSRFJcZ3QRC1t0Hos78M0E1YpdhrOTaEVK4SSyNeqaIUr
         zTPyRvR994g/t2tjRJkwl1p8bKoBNlzuW8DcwqRS9MKVJH8n4HUmwJtIlygia/nrwK+I
         MZwcVTXwaZinT2Dt5pLYsukR7Fqojepeg0o+6WKlpxg02vs+1Ma3giY+EjT+SXIC6U4D
         wPwDONMK5blbzqpC1Am/0KoDnPmIGa9XT0pXn543rJthGA4ckJptRB8kx/PxgBGPkCn9
         e0PUA5R+QQl8bp25VcKIuDitG4IlZ1MoBmfRCJ06hbofBWEe+CkOByBQo+youwGRTuZQ
         WekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=tRAA+E/aZ0xiHg9vChgfLqoCdmlsysypclNjGI6q1Cw=;
        b=dW7p1X7TPZ+Szfw6RLdCCfnuZV/k9vKaG5W1g7GF6VjByLip763Ko9augz2Xox3LQ4
         RkLu5X4jzgGG3kY3b8DHxStznKjXElvZH1MjB9bJ4qn2ANHwotosLU5NWIcVWLWuxgNU
         x3ashboCTwAypgkDOAScdLF6Oa+WL2kQxaJKwonv+QhM/YLU3xFdC/sFm7+4OlrnocKZ
         ujvV7aVRg/jZnRYQeKFtetDAy80QvmlBDxFWdoe4odmiXvSQ3ZA/Kufi7XiimGCcV6ot
         Ukb514rCH4KwHSo5Cn8DSmUgG0C82R5W2rYlbpsTxrhLJ+i4DM4V155ZmKah7rF1lx/P
         ruGQ==
X-Gm-Message-State: ACrzQf0AaUlAh0QQd1KwAnDIa22z6ycInelpGMjnbPDooVlAnkIBNJur
        RzswwNpnjUYeMHnCprT6MQ0=
X-Google-Smtp-Source: AMsMyM6OszkoMEcwKsk477YoosB/TDoancb8k0Dx/0gBB2WWEHtHxVlFbZSVATEYXryXaSU4XsGxBg==
X-Received: by 2002:a17:902:784d:b0:178:6946:3ff7 with SMTP id e13-20020a170902784d00b0017869463ff7mr976449pln.133.1663351145576;
        Fri, 16 Sep 2022 10:59:05 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id jo21-20020a170903055500b001767f6f04efsm15059458plb.242.2022.09.16.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:59:05 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf tools: Fix MMAP2 build-ID synthesis in namespaces (v1)
Date:   Fri, 16 Sep 2022 10:58:58 -0700
Message-Id: <20220916175902.1155177-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The perf record --buildid-mmap enables PERF_RECORD_MISC_MMAP_BUILD_ID
which includes a build-ID of the DSO.  It requires to read the info from the
file when synthesizing.  But I found some issues in the current code that it
didn't check duplicate files and didn't handle namespaces.

I think chroot is not a concern since perf will see it from the outside so
that it can see the full path.

The code is available at 'perf/mmap2-buildid-fix-v1' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf tools: Move dsos functions to util/dsos.c
  perf tools: Add perf_event__synthesize_{start,stop}()
  perf record: Save DSO build-ID for synthesizing
  perf tools: Honor namespace when synthesizing build-id

 tools/perf/builtin-inject.c        |  3 ++
 tools/perf/builtin-record.c        |  3 ++
 tools/perf/builtin-stat.c          |  2 +
 tools/perf/builtin-top.c           |  4 ++
 tools/perf/util/auxtrace.c         |  2 +
 tools/perf/util/dsos.c             | 29 +++++++++++++
 tools/perf/util/dsos.h             |  3 ++
 tools/perf/util/machine.c          | 29 -------------
 tools/perf/util/synthetic-events.c | 65 ++++++++++++++++++++++++++----
 tools/perf/util/synthetic-events.h |  3 ++
 10 files changed, 107 insertions(+), 36 deletions(-)


base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
-- 
2.37.3.968.ga6b4b080e4-goog

