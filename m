Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7577644840
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiLFPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiLFPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:44:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E981E25C5B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:44:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so7175069ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aE7vQ7ifHlbnr3PbOOnaFcE/HhvvlrbK+Yy5Ud2k1a4=;
        b=Jl/iPMDwwxX60DJER5vY0jOZ5Y+KfOxRIbI0+v45AMbdeRVxGXtT9grIHSXHnqsyWa
         bb/Ki5lvPlTS2p5kpPK+RSJQ7yCf/nIHu3poNThTU2cyerSZzi3wz8FWpgTe3LZgQB+d
         3vdTWswldFFK/PXW3N9yfcbzIkWnkfdzAKwGxLyHp0YrfGtCsEtzd861pTUMnOoozVQG
         42ivRbiT/9hKZyqmn/Kli9AIWLkltJA/tnseV43/tccOzanZNm+3VtoqWJYIv2up1kIJ
         6KYT88PFjdjUkqYcQNzZe55nn21YMlE2E+dGM3ky74XO1/TowqZHN2vgvi94SUaSOsiV
         aKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE7vQ7ifHlbnr3PbOOnaFcE/HhvvlrbK+Yy5Ud2k1a4=;
        b=h3q+L1hqiahizpUrtjgJ9VuaiUIKv2T0mOoAFHUGANuMCAXapB4XUkpTB+F12hfXQI
         8S7PEDe6hvrkpdKor8R6Skn3+EeYRfKCqHqRP1Izz2lvFulEw3ossolcK5ZYhgTg1Jy3
         6P7nUhffssStSmr65n395BLgd4LpdqMm4VOFVEiJ4cPsWTgq+taTJhftx9zBMaYvRIGP
         BRiAWyuV4Izc0ir36pxFtNUd9pONlXagNkNtkasBGX2yWsSACdcphB5UMMCVqe7sMzuL
         CkDYrhZTgi+bqkJqrhQY0BMyJUEAyzTDtFmXi/sKnAor2XLySYXFZ0FEO1kOa2qgQWAc
         6WDg==
X-Gm-Message-State: ANoB5pn0uS17QlnrbdhD2pRvllLmWAWurHeNKp+KUmiTQRlc9pDwL0bN
        tWpzYl/xRnXimsdRvWdjjZdHXVzD4zaj5Z1d3KU=
X-Google-Smtp-Source: AA0mqf6+XwmQZxDozeSpn3VoiD2AA8pdBIym5knKcEM9BJmp91wL49cqKKpBLwj8+eQts7lr3hyqNQ==
X-Received: by 2002:a17:906:c303:b0:7ad:95d2:9df2 with SMTP id s3-20020a170906c30300b007ad95d29df2mr26727120ejz.607.1670341479919;
        Tue, 06 Dec 2022 07:44:39 -0800 (PST)
Received: from localhost.localdomain ([86.48.7.22])
        by smtp.gmail.com with ESMTPSA id vs21-20020a170907139500b007c0ae137404sm6595550ejb.97.2022.12.06.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:44:39 -0800 (PST)
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 0/3] perf: introduce perf based task analyzer
Date:   Tue,  6 Dec 2022 10:44:03 -0500
Message-Id: <20221206154406.41941-1-petar.gligor@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petar Gligoric <petar.gligoric@rohde-schwarz.com>

This patch-series introduces the task analyzer and adds the feature to
output csv files for further analysis in thirds party script 
(e.g. pandas and friends). 

The task analyzer dissects recorded perf.data files based on
sched:sched_switch events. It outputs useful information for the user
of each task, like times between schedule in/schedule out of the same
task.

    Switched-In      Switched-Out CPU      PID      TID             Comm    Runtime     Time Out-In
15576.658891407   15576.659156086   4     2412     2428            gdbus        265            1949
15576.659111320   15576.659455410   0     2412     2412      gnome-shell        344            2267
15576.659491326   15576.659506173   2       74       74      kworker/2:1         15           13145
[...]
 
The user can modify the output to his liking and his necessity. He can
either limit the output to tasks he wants or filter tasks he does not
present in the output. The output can also be limited via the time or
specific tasks can be highlight via colors. A combination of those 
options is also possible.
Additionally the user can print out a summary of all tasks, which is a
table of information from all tasks throughout the whole trace.
Information, like total runtime, how many times the tasks have been 
scheduled in, what the max runtime was and when it occurred, just to 
name few.

Summary
    Task Information                       Runtime Information
PID   TID            Comm Runs Accumulated    Mean  Median  Min   Max          Max At
 14    14     ksoftirqd/0   13         334      26      15    9   127 15571.621211956
 15    15     rcu_preempt  133        1778      13      13    2    33 15572.581176024
 16    16     migration/0    3          49      16      13   12    24 15571.608915425
[...]

The standard task as well as the summary can be printed in either
nanoseconds, milliseconds or microseconds(standard). 
Both standard as well as summary can be saved in a user specified file
in csv format.        

v2:
 - Add tests for new perf task-analyzer suggested by Ian Rogers

Hagen Paul Pfeifer (1):
  perf script: introduce task analyzer

Petar Gligoric (2):
  perf script: task-analyzer add csv support
  perf test: Add new task-analyzer tests

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>

 .../scripts/python/bin/tasks-analyzer-record  |   2 +
 .../scripts/python/bin/tasks-analyzer-report  |   3 +
 tools/perf/scripts/python/tasks-analyzer.py   | 937 ++++++++++++++++++
 3 files changed, 942 insertions(+)
 create mode 100755 tools/perf/scripts/python/bin/tasks-analyzer-record
 create mode 100755 tools/perf/scripts/python/bin/tasks-analyzer-report
 create mode 100755 tools/perf/scripts/python/tasks-analyzer.py
-- 
2.30.2

