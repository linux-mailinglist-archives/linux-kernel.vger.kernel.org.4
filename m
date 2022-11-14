Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E5628CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiKNXC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiKNXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0EF1B7B5;
        Mon, 14 Nov 2022 15:02:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id io19so11492230plb.8;
        Mon, 14 Nov 2022 15:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt0OZoaxk4oNSiXVua0yf4Wn8zR1kll8hc9QqXyH+pA=;
        b=jcCl/FyxwF3w7YMSk3Qw/Vq3k7ny8Me1VSIXUCAQy0kPHz04yRm68l9gT56RqRB7s3
         gK8a7gbS0ZDoygeaAfUqQopGM/82KP1s6SScgdXGARymg+iDxMU5JtpKZOtx5IzkxFjK
         WfWTQnf88m4QF2Y0pRJQKDWSwwdKvML/JgXrXTz9EikSAav+lDT0ZurpRK37CCWZLzSd
         lG4GPJCdbdfn+3P5T+cmKS2npifOuuag0uwI4HQHxjjY8iTd0I1MeFcrmWtqDi5ipaNP
         gPtvdjPcx0L4/5hb6cegUBmRe/6thNB3On6+9C3T84Exn79BE4YEcFRTPyy45tRF6A8B
         dOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rt0OZoaxk4oNSiXVua0yf4Wn8zR1kll8hc9QqXyH+pA=;
        b=AuQsUcCaWh88OGf31fpw/33a2j2dkGJcC+IyXqBnFMzGGc15Q32X3t4V084fpcCMSe
         ym6bazRh0CeRpyOptCL64jTsNOTcoW4MCL7u0YrXwb+SI9BLwmjAamvNVypu/kXxdCj3
         UluJ4CLnYnjApYJZ5tO5nPF4k/GmldN2v/RWgkra47DT6/mUEP5mnETdowqyG70Jh8Ea
         X5hkHUy88VHD4u0Pm200DsR9JTZB7T6S0lq7/iVZE7gtRJajvs6AgL2Fw7W984SPIhrU
         M5qwkKu93ybk3GI4nIkIpkQvCwib8FN4IzAqCzgmJLRy3ULi8uIPbwJ43eYJ09sKZGM+
         qTIw==
X-Gm-Message-State: ANoB5pkfozXy2LZ/xdcWy/v/AUs1Y4aeeAj1e9n35BJyzRaTGHK1DgEE
        GyG7jdC5XTqqSNTMUk5kUQs=
X-Google-Smtp-Source: AA0mqf7qaTM0zSR6kESEG1Y3F7PoqZE0/2XaKfu/q+kfsI5i/AA12NePc4QMCb/czDt8bGfbFWbhVg==
X-Received: by 2002:a17:902:be13:b0:186:748f:e8c5 with SMTP id r19-20020a170902be1300b00186748fe8c5mr1358372pls.73.1668466951601;
        Mon, 14 Nov 2022 15:02:31 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:31 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 01/19] perf stat: Clear screen only if output file is a tty
Date:   Mon, 14 Nov 2022 15:02:09 -0800
Message-Id: <20221114230227.1255976-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --interval-clear option makes perf stat to clear the terminal at
each interval.  But it doesn't need to clear the screen when it saves
to a file.  Make it fail when it's enabled with the output options.

  $ perf stat -I 1 --interval-clear -o myfile true
  --interval-clear does not work with output

   Usage: perf stat [<options>] [<command>]

      -o, --output <file>   output file name
          --log-fd <n>      log output to fd, instead of stderr
          --interval-clear  clear screen in between new interval

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d5e1670bca20..1d79801f4e84 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2403,6 +2403,14 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
+	if (stat_config.interval_clear && !isatty(fileno(output))) {
+		fprintf(stderr, "--interval-clear does not work with output\n");
+		parse_options_usage(stat_usage, stat_options, "o", 1);
+		parse_options_usage(NULL, stat_options, "log-fd", 0);
+		parse_options_usage(NULL, stat_options, "interval-clear", 0);
+		return -1;
+	}
+
 	stat_config.output = output;
 
 	/*
-- 
2.38.1.493.g58b659f92b-goog

