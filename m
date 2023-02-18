Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C969BB00
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 17:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBRQ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 11:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBRQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:27:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359132D78;
        Sat, 18 Feb 2023 08:27:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id qb8-20020a17090b280800b002341a2656e5so933046pjb.1;
        Sat, 18 Feb 2023 08:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B37g7B5ar/zjjY7gik7eq16rDy7XTQy/OaSpZGsEq0g=;
        b=bVa3PxJNt2w4zIlONGnFvuntctpEtTmbqCMOHyzBbJSmggv2XC4grUoeL08I2dfHWf
         zj2XwOJItqqBF7HHAaMNn/H6sKEB47WBkiCMEkV9NVsc4AKm1lxe9tlT8YZFKqEpI/ln
         7s2Dpao6mzaF9O2SpB5pEbrhaK7bq9u/EKDn8iJy8K/pkwwZBsnnbKJy40D3UjKZiVql
         q/M1rT1+ER37U1oPlM74rO01m0iDB76bpG07kbL8h27jNnElyGzG+iHRbivuJST6pn46
         5yCdqUWvDPixTMA2p2ynPwgU8B//YKPjy50IR757OsO+HxIxbB6OdGxar849PT20Jnor
         3vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B37g7B5ar/zjjY7gik7eq16rDy7XTQy/OaSpZGsEq0g=;
        b=K6puLu2QyruYjaavUzaf2Gs1KuspZNaRoSXgqm/DrdXCYcpgOrbsSkX8tPmAFyZsu5
         B2m4/frawOkkyEM/3QsIwX5eRFY7S0/40sS7XTpysNMz94vS+cd5whKkRs/jfNbVtpmG
         wlD7gxHnXLa2/v9Y++T3Lj2bNFjpSq7k4zIGn/jQrxYG2VdPBlhZFNpXn8a9r+92Ttxn
         lj/cIw5RM+TKlkZufom+ggDiqUqDsqTrdUtGUP2ydwTyLWWuFKCv/TyrrRZMNBBCoYk3
         yaqx7xdQxAKsjkHtw6V2Ex0iKIMPIBbfpF4cLu6tpZV+Qvx62AbDNSPBrWuUmP6oIfkD
         /NoA==
X-Gm-Message-State: AO0yUKXKtL0J2w6lqOmRFr55AR9afIuy9PuF2mfcNg+ZlDIkv8WBi4gd
        I/ZoXJ53i5b4YbZBGTq6Tn67264RsUo=
X-Google-Smtp-Source: AK7set/3Jd/okF363wMci6e9ISMyoVSRzAcFrWtOiQAViZjbS8W60DCYnEtOL5+i8MuuxTKZPJIp0A==
X-Received: by 2002:a05:6a20:4b14:b0:c7:49c4:c28c with SMTP id fp20-20020a056a204b1400b000c749c4c28cmr7574454pzb.20.1676737646459;
        Sat, 18 Feb 2023 08:27:26 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:4f8:5d48:b81d:df32])
        by smtp.gmail.com with ESMTPSA id f4-20020a655504000000b004fb5f4bf585sm2886976pgr.78.2023.02.18.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 08:27:25 -0800 (PST)
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
Subject: [PATCH] perf test: Fix offcpu test prev_state check
Date:   Sat, 18 Feb 2023 08:27:24 -0800
Message-Id: <20230218162724.1292657-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
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

On Fedora 36, the perf record offcpu profiling tests are failing.
It was because the BPF checks the prev task's state being S or D
but actually it has more bits set.  Let's check the LSB 8 bits
for the purpose of offcpu profiling.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 38e3b287dbb2..d877a0a9731f 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -277,7 +277,7 @@ int on_switch(u64 *ctx)
 	else
 		prev_state = get_task_state(prev);
 
-	return off_cpu_stat(ctx, prev, next, prev_state);
+	return off_cpu_stat(ctx, prev, next, prev_state & 0xff);
 }
 
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.39.2.637.g21b0678d19-goog

