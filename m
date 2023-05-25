Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F847101DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjEYADO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEYADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:03:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195199;
        Wed, 24 May 2023 17:03:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d41763796so1151293b3a.2;
        Wed, 24 May 2023 17:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684972992; x=1687564992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P/sfaSxrjpDVpW6nx9Gv6nwA0nMjU7/ydrxlKetNdAs=;
        b=LJE1lyDS4tz8fl5KK7DnLYDf6ibmmArWDPYukL3kmmDJKmSbSPBU6oC4kbecjg8NPa
         Af8rVyeur9e5XJbLTI36UvqhvINzz0EWOK0fjr4W70XXKiLzK+njPsbYeVCA42fZWN+W
         bQVbZdz+HKzgMqunb2NDd0A2O8fxr4z1cu19NNvgfDWSrljotg4+0LSxVgIP4ppeMlwD
         afQEWxMzBqqyCJEGhZ+h5kDZ5JVysrtCZlIzmJCoEoyK2AVHEKRuxu9a+MUrC6pfd+Jo
         KXBeAMp234fJe17M/dUH/Sy1OQX9Hj5kj9kzuN2fvAIZqD9KFY5GIN0Ty816WtIl3L1I
         rUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684972992; x=1687564992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/sfaSxrjpDVpW6nx9Gv6nwA0nMjU7/ydrxlKetNdAs=;
        b=SJbcwM1kbyugrDYGqLKnIphyDGBMD8uHsfDkPU1RSR+DMlLdX5wLIXrlvyToRWqIHg
         kRNdzlOQilsS4qKcGckjrqlRCuMObzdqVKYAyrovIRL6WEfdxMVeOdg58UwKMoM/HUgu
         rfBUT1n9kw8BYnhBm7FZ6scIqC7WanMnHvBs6X16Ur6mN2nAW1u99+urmlMmyI0AAfUW
         UcubEPEr1azBuDbrPb2XrgAzSxw8eL5xJ6dBi+1zT+JY+OcJUjzBEl9USAPcp1v5tVns
         HHkO/31hFIdQDHVI06MM8LCMQ4rIs0PwfrRkA2s5OKZKUXxSAF9z0jTJJIadd48jCgGL
         spUg==
X-Gm-Message-State: AC+VfDw6nTXdm0xfGid0fkn1nYMVOrQR29YmVuxV+we2MzcZFlgjHzmy
        O/GHBUdIi9ljpqX1P8ptwKw=
X-Google-Smtp-Source: ACHHUZ5jvp151opjVnOUx9o1pqEdym6iwvISEVh98WTz1GiRxLPg7DqkyxKMOdNUkD4mOTcQKpKfBg==
X-Received: by 2002:a05:6a00:1a53:b0:63d:260d:f9dd with SMTP id h19-20020a056a001a5300b0063d260df9ddmr6068460pfv.33.1684972991630;
        Wed, 24 May 2023 17:03:11 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:121:f908:b42d:c399])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b0064cca73d911sm22276pfn.103.2023.05.24.17.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 17:03:10 -0700 (PDT)
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
        bpf@vger.kernel.org
Subject: [PATCH] perf bpf filter: Fix a broken perf sample data naming in BPF
Date:   Wed, 24 May 2023 17:03:07 -0700
Message-ID: <20230525000307.3202449-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

BPF CO-RE requires 3 underscores for the ignored suffix rule but it
mistakenly used only 2.  Let's fix it.

Fixes: 3a8b8fc31748 ("perf bpf filter: Support pre-5.16 kernels where 'mem_hops' isn't in 'union perf_mem_data_src'")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index cffe493af1ed..fb94f5280626 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -25,7 +25,7 @@ struct perf_sample_data___new {
 } __attribute__((preserve_access_index));
 
 /* new kernel perf_mem_data_src definition */
-union perf_mem_data_src__new {
+union perf_mem_data_src___new {
 	__u64 val;
 	struct {
 		__u64   mem_op:5,	/* type of opcode */
@@ -108,7 +108,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		if (entry->part == 7)
 			return kctx->data->data_src.mem_blk;
 		if (entry->part == 8) {
-			union perf_mem_data_src__new *data = (void *)&kctx->data->data_src;
+			union perf_mem_data_src___new *data = (void *)&kctx->data->data_src;
 
 			if (bpf_core_field_exists(data->mem_hops))
 				return data->mem_hops;
-- 
2.41.0.rc0.172.g3f132b7071-goog

