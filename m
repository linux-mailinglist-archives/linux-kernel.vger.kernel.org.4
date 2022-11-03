Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB06175CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKCEyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKCEys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:54:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F7317AAA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:54:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h9-20020a25e209000000b006cbc4084f2eso1076005ybe.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jZXowGsurJE+s3+HfBZ6GT+6g7K96tSBIPyO+vNCcsA=;
        b=NxXkPe3pHcYT8iN7ya3pJumFi+pQ0vkHaIriviOdmvPthV36Y5/415d2g41J5VldXl
         WQ8ILJP0mmK8scFWbpLeRf3cPnKM0ktYsPaaIPcBU/2yYdwFDwkAEtUVtU9FutGvJ81Z
         og9FRK7xk9I9WPZsv3H/fnCJNmGcbyN1oc+FREMP61iWQKUCdwJQ7Sz1/+1eXI+oKVSv
         OoclwxiwCBCXSv+1uJDQc/IzPL7kZBvAsodPlJwaHbAuBW63OeLXfFo3/GwP6qNh5D7M
         fpWFMFamJD/hFyEDZ8iRGyDIxLrMz4ysj5Q0WwN7pmWqcbb+IMC58wX1oVfkE+L4KRz1
         po5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZXowGsurJE+s3+HfBZ6GT+6g7K96tSBIPyO+vNCcsA=;
        b=HEYGZIEl1Wnl/NVDspADRw7eGX2Akrx28mSwADTi3SeZo9H1gwTOzHD+oSl4QQmKof
         9yd3W3n18z/k6ZzP2qEZeD+nVaKykTAmDP+39HlfdzYjjTO9ToFqRcvdVZqHYfdSjwFT
         Igr0Sq+wrVJeNIXwbTyiPivCnoqOUyz5qMHUAOXd3wwwpXHXjOexP4uNZnDh2LWaDVZa
         IctLDrpyM1ot2p/6VlJzyLM2F+dAsrSZciqclvrrzDrARZPSWrSTbxzQuYlTCgsSs/QC
         miTR9dNqK0itALzR0pdK4NJWebchQV2RpxroScqv98LCMgpCRc2ypz5/LgzBePQb0Fog
         7uIQ==
X-Gm-Message-State: ACrzQf0gsSiErGmSqJfNXM/Zh3nm+ka1ya5PZaGYSN4IMlsWKROpFACh
        VH4OzZU5P6Q9uZVruZpWvIqsFfLgYbSq
X-Google-Smtp-Source: AMsMyM5gQLmkoq2wQlEnKPsDCXgEFk1fpShBi3BSXv4S72Lx55H99KGCQPG78W+rGnj5gX7yY6U9qKtx776d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a25:6dc4:0:b0:6c1:822b:391f with SMTP id
 i187-20020a256dc4000000b006c1822b391fmr25547855ybc.586.1667451287286; Wed, 02
 Nov 2022 21:54:47 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:30 -0700
Message-Id: <20221103045437.163510-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 0/7] Fix perf trace libbpf 1.0+ compatibility
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf trace can augment system calls with a BPF program passed as an
event. The BPF code for this lives in examples. This patch fixes the
example code to not used deprecated/removed APIs in libbpf. As libbpf
has similar header files to tools/perf/include/bpf the code is
transitioned to use the more standard libbpf code and the perf BPF
header files removed.

Ian Rogers (7):
  perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility
  perf trace: Etcsnoop fix libbpf 1.0+ compatibility
  perf trace: Augmented syscalls fix libbpf 1.0+ compatibility
  perf trace: hello fix libbpf 1.0+ compatibility
  perf trace: empty fix libbpf 1.0+ compatibility
  perf trace: 5sec fix libbpf 1.0+ compatibility
  perf bpf: Remove now unused BPF headers

 tools/perf/Makefile.perf                      |  5 --
 tools/perf/examples/bpf/5sec.c                |  8 +-
 .../examples/bpf/augmented_raw_syscalls.c     | 75 ++++++++++++++-----
 tools/perf/examples/bpf/augmented_syscalls.c  | 58 +++++++++-----
 tools/perf/examples/bpf/empty.c               | 13 +++-
 tools/perf/examples/bpf/etcsnoop.c            | 41 ++++++++--
 tools/perf/examples/bpf/hello.c               | 24 +++++-
 tools/perf/include/bpf/bpf.h                  | 70 -----------------
 tools/perf/include/bpf/linux/socket.h         | 24 ------
 tools/perf/include/bpf/pid_filter.h           | 21 ------
 tools/perf/include/bpf/stdio.h                | 16 ----
 tools/perf/include/bpf/unistd.h               | 10 ---
 12 files changed, 169 insertions(+), 196 deletions(-)
 delete mode 100644 tools/perf/include/bpf/bpf.h
 delete mode 100644 tools/perf/include/bpf/linux/socket.h
 delete mode 100644 tools/perf/include/bpf/pid_filter.h
 delete mode 100644 tools/perf/include/bpf/stdio.h
 delete mode 100644 tools/perf/include/bpf/unistd.h

-- 
2.38.1.273.g43a17bfeac-goog

