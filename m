Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30564E1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLOT2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLOT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1E4AF13;
        Thu, 15 Dec 2022 11:28:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id js9so195289pjb.2;
        Thu, 15 Dec 2022 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tipLqS6lnT+NPiZNAnQKxBxZNV4m8p01r3QYvYfozxo=;
        b=OQnOVTdSIOnnq3cpTAUZRcQj3kjXX0N3xhDZgDjXC3RAarlzoMtiwDG1g4Q3iHe0Hk
         HUtW8k7FIWj9dVATdx2xAjLtZXS9odIJ6JSMk7BGooFihyVViCGEWvkWNLwPFPFCHDyF
         3koLjxv3dSMRnz3mYaLwsu9bd7OzKo1ORevXHebSpkNVTUPA7CkRk2Uee0nY0p1a+eS2
         zUDmeYd2p6RtYOVLiV750h3iXyJ8r6ujriYJkVilBjXkR9VJGJp2so8INGb2BE7isVrN
         Ly/4zbn/AsO/YXgrScrb+eyB4H+dZbK7MBA5tVbWABHfxqcuZdhiKZ6IzD1s99JHIP1B
         p7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tipLqS6lnT+NPiZNAnQKxBxZNV4m8p01r3QYvYfozxo=;
        b=LtgXagXAdV6dTC0bVwgPlOGLbAq8jA/jMqyIj9y6JxP3inl9R+KavOl3uYo3AGjG10
         PquivvrIqy/z02zrUZONGw/ULqvvmK+n1m3riTUr+VEB4LFMu1MwUONyFu6ThuBUrSq/
         O0i4zDuOXkRMQoxqXOs26maLNY9lSZvIw8+doozLrvge5DWYdKZWiCmkOQN6bbOnQJ8J
         Syjz1eIZWay15qw51sdrLz1wPN3nHBrcIHDBJaTZhaRL8BW4IvHMIU60P+x/LDGu0NoH
         sR7LU8juxtHWbku6CyGVOBzxJQf3Wai2uvyhJut8XVbVCTtWXQbiny2IiEBKarWV3XI5
         1WoA==
X-Gm-Message-State: ANoB5pnRV2ZeHG4yZobREcrG8VBoHWgtYY0C5CISPUd3OaFOO/oyfLnG
        jmtiE4ncHvnZBCSW2JAW86U=
X-Google-Smtp-Source: AA0mqf4hbL5bGQZvyFF4VjCmmD/ncx8gME3LI/FmJAMq7lqpKbnSu68hkSbUXKwNK82rM9tWAnzbSA==
X-Received: by 2002:a17:90a:1b45:b0:219:64ca:49a0 with SMTP id q63-20020a17090a1b4500b0021964ca49a0mr29623814pjq.22.1671132503015;
        Thu, 15 Dec 2022 11:28:23 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:22 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/9] perf report: Ignore SIGPIPE for srcline
Date:   Thu, 15 Dec 2022 11:28:10 -0800
Message-Id: <20221215192817.2734573-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221215192817.2734573-1-namhyung@kernel.org>
References: <20221215192817.2734573-1-namhyung@kernel.org>
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

It can get SIGPIPE when it uses an external addr2line process and the
process was terminated unexpectedly.  Let's ignore the signal and move
on to the next sample.  The sample will get the default srcline value
anyway.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2ee2ecca208e..d98112f173b0 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -949,6 +949,7 @@ static int __cmd_report(struct report *rep)
 	struct perf_data *data = session->data;
 
 	signal(SIGINT, sig_handler);
+	signal(SIGPIPE, SIG_IGN);
 
 	if (rep->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, rep->cpu_list,
-- 
2.39.0.314.g84b9a713c41-goog

