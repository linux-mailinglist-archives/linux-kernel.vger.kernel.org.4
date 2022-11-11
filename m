Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E56625A48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiKKMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKMJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:09:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C560E8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:09:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso4570160pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s08YO+rPBtB2uwv5IJoOR+YbywlIrwvyXquHPxbqQy4=;
        b=wasi9M2E49zmc8HflupPJNJX5BOmd2HA+06pH/USFgAM0KLcYG99l21PRZKLEgKcra
         jFNwx7+tVkwsLkBE4hN9Q3f99EDBwjEvJZN34raW4fmp4ud7gNy3iMoiLXuYMS/VR3hv
         oBSvnUauT4yeROtVjXG6dkHKH3bJh3R6ZJMhOr1odUsIhtCvEV3sJrIfS0IqGOrtGm+M
         YS86+6HFQoKkghzN1ri6Pp5vvF8SsdunwDzkhoHHN0rPYtRYliVmwXefESGRdYMh8Kfp
         hu9CTkyLFwuN3CEXVb6GHX/3yuJEgs44zZEu23KZzsDncrixneN5TMrsdnQ6tf+OJE27
         viNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s08YO+rPBtB2uwv5IJoOR+YbywlIrwvyXquHPxbqQy4=;
        b=Nk5Qw2a1FHw+EmhB920g3P9dNzsSClni+RSGkCNv33DSbTt2umAv0+LtSlinUM1fGg
         sC4KtV4QHi+llDp2CAAtT0BnBIANtVP6zwc2oXNVAAmbytgm47p+GHB2jZgDEsPaSu6f
         5ib7JViCpl7UH4aYmq474PeK3+5K6wBHcnVZD2+ccKYGoEzj9gHviStNrTGFuBAQHITt
         XX2uxx+IuAsPZdBWZBtQpCtHA+HckygbtIpmYqs4rhI0jJzzNox9rc7MyD4jawa8kSWa
         8RGcpHwWvf9HgB0vv8Pla+buZ4btcSCbXe9V8XbSNC0reHE28cDeWhk1vCLUrseezJCd
         Bz1g==
X-Gm-Message-State: ANoB5pn/30UvU3k7Qyj8Ods8KldjVJQ30S/7qjtA+mxX91b0NBv6fck7
        9PwYt0CvBjxnQLR7C0k4Y6i6wQ==
X-Google-Smtp-Source: AA0mqf6rpQlgVdwVPyESpUxSQWjA5DMRtVgmrD4pFlVUaKBVHikeqFObg/7efwTHDzbZ/ttmPse5eg==
X-Received: by 2002:a17:902:b711:b0:186:a3a0:601c with SMTP id d17-20020a170902b71100b00186a3a0601cmr2265120pls.105.1668168586808;
        Fri, 11 Nov 2022 04:09:46 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id mp14-20020a17090b190e00b0020ae09e9724sm1453408pjb.53.2022.11.11.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 04:09:45 -0800 (PST)
Date:   Fri, 11 Nov 2022 20:09:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 0/7] Fix perf trace libbpf 1.0+ compatibility
Message-ID: <Y247VY99skmc1wRk@leoy-huanghe.lan>
References: <20221103045437.163510-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian, Arnaldo,

On Wed, Nov 02, 2022 at 09:54:30PM -0700, Ian Rogers wrote:
> Perf trace can augment system calls with a BPF program passed as an
> event. The BPF code for this lives in examples. This patch fixes the
> example code to not used deprecated/removed APIs in libbpf. As libbpf
> has similar header files to tools/perf/include/bpf the code is
> transitioned to use the more standard libbpf code and the perf BPF
> header files removed.

I think you missed to update the code examples/bpf/sys_enter_openat.c,
either you could remove it (since it's duplicate with
augmented_raw_syscalls.c), or we should apply below fixing:

From f30af3b43060e482c54e113cbe90223173c69abd Mon Sep 17 00:00:00 2001
From: Leo Yan <leo.yan@linaro.org>
Date: Fri, 11 Nov 2022 12:02:24 +0000
Subject: [PATCH] perf trace: sys_enter_openat.c fix libbpf 1.0+ compatibility

Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
headers.

With fixing:

  # ./perf trace -e examples/bpf/sys_enter_openat.c
  0.000 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
  1.596 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
  1.832 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
  1.864 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/examples/bpf/sys_enter_openat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
index c4481c390d23..8edfa7c147d1 100644
--- a/tools/perf/examples/bpf/sys_enter_openat.c
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -14,7 +14,9 @@
  * the return value.
  */
 
-#include <bpf/bpf.h>
+#include <linux/bpf.h>
+#include <linux/limits.h>
+#include <bpf/bpf_helpers.h>
 
 struct syscall_enter_openat_args {
 	unsigned long long unused;
@@ -25,9 +27,10 @@ struct syscall_enter_openat_args {
 	long		   mode;
 };
 
-int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+SEC("syscalls:sys_enter_openat")
+int syscall_enter_openat(struct syscall_enter_openat_args *args)
 {
 	return 1;
 }
 
-license(GPL);
+char _license[] SEC("license") = "GPL";
