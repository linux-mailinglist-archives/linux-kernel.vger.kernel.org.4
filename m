Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E66987F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBOWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBOWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:00 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B91A486
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:33:58 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id v6so158029ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onPboIVuwFQM+u11FAIAIUF6FsX292G7WEiPOTqQPg8=;
        b=N/nnLNCloXEfghvTNAXw+I6rZ21KJHDzNBWYN1//+agMoDmkc4p2uF5tGKWwVYGWnv
         wEqyDErcLL+IQCmktHXDkEEa9CFd3WXlYLeAnXmWRus0ztYASmQctA99YmsCYrsFabbC
         ViuxzH6SA3drPTIGVbzUJEMGqhtF+LCznfCg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onPboIVuwFQM+u11FAIAIUF6FsX292G7WEiPOTqQPg8=;
        b=S2SsudhOJf/gAaK2Iinn7kfxSGKDJRjEOMbcFzIQTtB2xUh/uF2cTnVgcpIZao61xc
         5J3H9HIrMbrP1iILIrDWIWz2qPdtxtzLEGTvvLmyEKWsaQJz3Le45N0qcGAWTXh508IW
         gWyJjSCd4ybPtvX1pUtdFWDTpiPneG84NJeiTtHW9Ec4wsLb3ys8r77gIYXf7WouS5Bw
         5Qe9U50Toj726DdT22PKihjdZGvAc4xtKmh/o7Zb5EsMziYilEzl7e0HMHSr2zUAUQ8w
         6dWJYohYWhx54LQpZFDOTlTA5C2KJ1nyKX+w7ncNh7s/PxW9UXaKFuwKINReA3XX1W2R
         dlrg==
X-Gm-Message-State: AO0yUKWvqwhWWxeD8omusv361p7KbLCOygCz4t3umzeHX41bfMXlXqFL
        WV4zaJSb5boEQMrE2kYi5Rq/qqrIOQPVUpLq
X-Google-Smtp-Source: AK7set9iJvaog96LALhe884wzN0xuXErl0FzajFZhkV85AuS0ZFd+QdHTbYidcus7alXRIzwIWNnJw==
X-Received: by 2002:a05:6e02:1d17:b0:315:4f67:7055 with SMTP id i23-20020a056e021d1700b003154f677055mr4026600ila.1.1676500438087;
        Wed, 15 Feb 2023 14:33:58 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:33:57 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/6] use canonical ftrace path whenever possible
Date:   Wed, 15 Feb 2023 15:33:44 -0700
Message-Id: <20230215223350.2658616-1-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 * Dropped patches which were pulled into maintainer trees.
 * Split BPF patches out into another series targeting bpf-next.
 * trace-agent now falls back to debugfs if tracefs isn't present.
 * Added Acked-by from mst@redhat.com to series.
 * Added a typo fixup for the virtio-trace README.

Steven, assuming there are no objections, would you feel comfortable
taking this series through your tree?

---
The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

There are many places where this older debugfs path is still used in
code comments, selftests, examples and tools, so let's update them to
avoid confusion.

I've broken up the series as best I could by maintainer or directory,
and I've only sent people the patches that I think they care about to
avoid spamming everyone.

Ross Zwisler (6):
  tracing: always use canonical ftrace path
  selftests: use canonical ftrace path
  leaking_addresses: also skip canonical ftrace path
  tools/kvm_stat: use canonical ftrace path
  tools/virtio: use canonical ftrace path
  tools/virtio: fix typo in README instructions

 include/linux/kernel.h                        |  2 +-
 include/linux/tracepoint.h                    |  4 ++--
 kernel/trace/Kconfig                          | 20 +++++++++----------
 kernel/trace/kprobe_event_gen_test.c          |  2 +-
 kernel/trace/ring_buffer.c                    |  2 +-
 kernel/trace/synth_event_gen_test.c           |  2 +-
 kernel/trace/trace.c                          |  2 +-
 samples/user_events/example.c                 |  4 ++--
 scripts/leaking_addresses.pl                  |  1 +
 scripts/tracing/draw_functrace.py             |  6 +++---
 tools/kvm/kvm_stat/kvm_stat                   |  2 +-
 tools/lib/api/fs/tracing_path.c               |  4 ++--
 .../testing/selftests/user_events/dyn_test.c  |  2 +-
 .../selftests/user_events/ftrace_test.c       | 10 +++++-----
 .../testing/selftests/user_events/perf_test.c |  8 ++++----
 tools/testing/selftests/vm/protection_keys.c  |  4 ++--
 tools/tracing/latency/latency-collector.c     |  2 +-
 tools/virtio/virtio-trace/README              |  4 ++--
 tools/virtio/virtio-trace/trace-agent.c       | 12 +++++++----
 19 files changed, 49 insertions(+), 44 deletions(-)

-- 
2.39.1.637.g21b0678d19-goog

