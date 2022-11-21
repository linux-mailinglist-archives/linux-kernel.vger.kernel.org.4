Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC6631AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKUHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKUHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:53:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA819288
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:53:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so8215879pji.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nLzWG/ZTlfyMH+jybHcXaVQUlUlVa+L1Vc5qu2tDhc=;
        b=LBszov47TdVdBRHvE1cfnPBOe3cxsDJcrikL+M/vEKKxTQ/1XRbnsDBXfi0ePFG6gj
         ztTpDO8zLTFE3hLkjMN31cjLxh32u4WfDHpgvfXC52n/khIGcvE2RmdQtAb5CUfn+efb
         XLsVB/XW1MQgrAKGPLokqKPXBmfsNJVbXwp5D/DCBiSKz20SbNoTLRToQ48H/2mpyhxs
         h2tB1hHR43Qy5H/vEQHr8g4kcBA7m9FpONKrjjx9KoXlT/eMRFkcykAdIB2wkCUfcx8f
         9pwADcqEhGL7eiPFOTBJwG+ZkCEBUCbWU3vlMC882xV1yBZGFLCbbmwr4ZdD3DvqxSLm
         B1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nLzWG/ZTlfyMH+jybHcXaVQUlUlVa+L1Vc5qu2tDhc=;
        b=7ev2cK0TLws27trDAiCSAAugDw6/5yNQH26/LSNq8XYx59dni28QBT749j2fzaiOG+
         U0b0/ZtmVF6AoUMGhUVmxMlt/u19BVgobTQWPIcKL0LDmx1bb8e9TmqgSAVNSdyKS4C3
         kEUtTx8aLWnrKP19+YwmwkIXhImg89RucauzddP65bfHSMgisW/DiDQH3PrT5yY+h44R
         3TOa/43Q35SBe+vFTDhxnYsh9evTb92/YM7AKHunDnetROVBFKMjq5WhIbDbwkGCbnrz
         4mZKJNoyXC5ixOjW+IfCVwtbjBa6s6Xe0avYrwSc0gbeBd8NqPa59F71LwEQgazxf0Uz
         6e8w==
X-Gm-Message-State: ANoB5pl6wGi5NwZnMbyG2AddviWBrq//yK/ZCwKaWi/+s8ECjyhqmTkg
        ztKEP+PsezJAojbmvnTy5wPtlg==
X-Google-Smtp-Source: AA0mqf7DZy48KN08hxLT8+CVFI0g8Wo0+4J5TS1/NhepplENHGa0TG88nRS2vaAtfWgR3JWDBV8qVA==
X-Received: by 2002:a17:902:e40a:b0:17a:a81:2a52 with SMTP id m10-20020a170902e40a00b0017a0a812a52mr4100105ple.159.1669017181614;
        Sun, 20 Nov 2022 23:53:01 -0800 (PST)
Received: from leoy-huangpu.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm7006277pgm.74.2022.11.20.23.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:53:01 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/5] perf augmented_raw_syscalls: Remove unused variable 'syscall'
Date:   Mon, 21 Nov 2022 07:52:36 +0000
Message-Id: <20221121075237.127706-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121075237.127706-1-leo.yan@linaro.org>
References: <20221121075237.127706-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable 'syscall' is not used anymore, remove it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 7dc24c9173a7..4203f92c063b 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -389,7 +389,6 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 	unsigned int len = sizeof(augmented_args->args);
-	struct syscall *syscall;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
-- 
2.34.1

