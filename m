Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF13620134
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiKGVdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiKGVdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CBD2EF64;
        Mon,  7 Nov 2022 13:33:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f63so11639310pgc.2;
        Mon, 07 Nov 2022 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gyy9yeqWT2k5QTrvk/RJBXpqivCI5uZGvU+9WCo85hA=;
        b=HIuQrVRyIVVkhXLShtxIMtpAcxjbqwECAJLv0mP+/vKOUyDfwJc/or06UW36RQYN//
         oni3DRPy+QD+l6S1OwolsIToWrMNTBwZ2tQdZFaPauy2L/u22g0+6RKbS1pcaU2DBApD
         6jB7qDCE96NqM4lE9ihqePMbW4x/oyVeM5zxiRlWSd43RlU/411KpWHAgEitSe/nXeoc
         /cK5cQ7u2krDgiQWxThJQ+YIVMeGwzmdwSYPFJhFbb/9ov7O0tcjluImQAec1NiYAf2n
         f7150J57hwzOPyTOdKr2hM72dy4qSwqqBTl/Hb22LZPEv7aa6xfC2Wm1OJXjAZir0uaF
         kB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyy9yeqWT2k5QTrvk/RJBXpqivCI5uZGvU+9WCo85hA=;
        b=Y4O94Yfr3gtofiOlnhy3xtlSInlYxZLib9MI7JJA3bYeanB0eGUiUDMeIkyRH+wlx/
         rfsgfhGq91F8JD2N5TNb4omcAGs8ijDSlIcUFR8YTJ6OIke7OwqFMw1sy5Qzpzo4Hsfh
         NE0HRmw7FJncDAs0T3HCXez46/Co+HcpVkAtmiVc7II/ucg0plR2zGzt2F94oekRDtVa
         4uHOG/4RbsWWdlOItScImK41GLHYDzHFjtFMjw0Qu0CK8mRPyLNAOmqBChCj8UAVSjVa
         IgwMnjcEXCaXSqD8iU5k/LShwX/oONYiMSg7KEtXy9Oj5gsnp0EAwKvZAIaaFin2gnfE
         QNpw==
X-Gm-Message-State: ACrzQf2iodTEgRbmVamjYDDc3XKXZDpTJ7sJrNKigzU4zS+n7b51CX65
        eNYzpQ22zTCDRuzqvbDLf/I=
X-Google-Smtp-Source: AMsMyM5Rco8mhyMPCyHwszz/07Hk6KhJOxrPQnfsnSRGtim9C+Zs9mQkjzGRTh+CrpGKwAheVsZZRg==
X-Received: by 2002:a05:6a00:1304:b0:555:6d3f:1223 with SMTP id j4-20020a056a00130400b005556d3f1223mr53000295pfu.60.1667856798413;
        Mon, 07 Nov 2022 13:33:18 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:17 -0800 (PST)
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
        James Clark <james.clark@arm.com>
Subject: [PATCHSET 0/9] perf stat: Cleanup perf stat output display (v1)
Date:   Mon,  7 Nov 2022 13:33:05 -0800
Message-Id: <20221107213314.3239159-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

I'm working on cleaning up the perf stat code and found a number of issues.
Before moving on to the real changes, I'd like to fix those first.  I'll
think about how to test this properly.

You can get it from 'perf/stat-cleanup-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (9):
  perf stat: Fix crash with --per-node --metric-only in CSV mode
  perf stat: Increase metric length to align outputs
  perf stat: Clear screen only if output file is a tty
  perf stat: Move common code in print_metric_headers()
  perf stat: Fix --metric-only --json output
  perf stat: Do not indent headers for JSON
  perf stat: Add header for interval in JSON output
  perf stat: Fix condition in print_interval()
  perf stat: Consolidate condition to print metrics

 tools/perf/util/stat-display.c | 55 ++++++++++++++--------------------
 1 file changed, 23 insertions(+), 32 deletions(-)


base-commit: 96e6d929a6c3368ad6327a52f870294747888c77
-- 
2.38.1.431.g37b22c650d-goog

