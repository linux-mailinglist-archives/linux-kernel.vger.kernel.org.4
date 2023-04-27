Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8C6F0EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjD0XFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344175AbjD0XFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:05:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C582D40;
        Thu, 27 Apr 2023 16:05:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b78b344d5so7137951b3a.1;
        Thu, 27 Apr 2023 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682636707; x=1685228707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In1jC5aMTJeXFFu1GOLM89hDF8A0gRuTYGTK8R3GUQA=;
        b=kb13oXouVsalgzAXfCrJ9C6LOHHlMnB3wIIENBte3E7lIOvdo1M1rdAI8s4Kusqy2K
         1Fal7nzjG9zElqXMAHVZbGahhQqXQ2IHZVAOuS65/meoHEojml+TKuugjQiMJ4L3YM3P
         J4W5s00Idg4JFlUWwzCgrMJ0Kxx9Jn20Tko6sxORno1jaRPjClIjua2Kgl64bbCeyCY6
         L3T3TpJvGYlMTuqVGiFIClH/V8vuMTo9i94UKAnhWtwP2b+gY4L6pmwrMrknSPfNSAef
         XRzMKL5Z4JkO4cANNdMPXvPtgWcRGUpemwgj1V2CI0Ye/ULEQR/DkCd/HkyJP+HvxW2A
         Lf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682636707; x=1685228707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=In1jC5aMTJeXFFu1GOLM89hDF8A0gRuTYGTK8R3GUQA=;
        b=hb6Fvw0ULtQTG+XBSN76DEWeXPKlM19pBMAN50TrhS1gAya5Z4R0KYS9RYZLXYhR3d
         Zoafu9irh354vtVTr3msaVSEte3O2ywgTPThR/2odeMDzc2CFjSZLOPBDTLf0uO9omiL
         iLv4A7DhENDNPluipQg+z5bObbBi77RJsKFtw5jO3uoHnl/4QSmgsK9OG6lNgKqB+3rz
         SW7HIHGNAEmgihpdZu6O6URJ4+0SiASXMXpzTFs/HTUpKcRu8RmYGudVRSy7sgJlNx/W
         eoGfAZ5vEcsrqlyElTSeUcz9iuYcDODjCTOJid6vgafIHdlHrTvZmE5k6Wihp0WiJ3Si
         Boew==
X-Gm-Message-State: AC+VfDxDRCq8jre6dHUhi7uZSp0UIhnBsrdobPCcIMKV/qaQrb6w285t
        3o8gbDHJvLWXrU4+1yTJIdM=
X-Google-Smtp-Source: ACHHUZ4OrgQaXiabBXA8/t9nHmhQt1036EB5HnNBjE6lm7Jv9W3STbgyKCIJds8dP7nB1qN74GiESw==
X-Received: by 2002:a05:6a21:78d:b0:f1:377a:b762 with SMTP id mg13-20020a056a21078d00b000f1377ab762mr3380293pzb.33.1682636706789;
        Thu, 27 Apr 2023 16:05:06 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:55cd:594d:edb:e780])
        by smtp.gmail.com with ESMTPSA id p10-20020aa79e8a000000b005d22639b577sm13636436pfq.165.2023.04.27.16.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:05:06 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf list: Modify the warning message about scandirat(3)
Date:   Thu, 27 Apr 2023 16:05:02 -0700
Message-ID: <20230427230502.1526136-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230427230502.1526136-1-namhyung@kernel.org>
References: <20230427230502.1526136-1-namhyung@kernel.org>
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

It should mention scandirat() instead of scandir().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/print-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 0a97912fd894..299973876550 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -131,7 +131,7 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 	free(sys_namelist);
 }
 #else
-	printf("\nWARNING: Your libc doesn't have the scandir function, please ask its maintainers to implement it.\n"
+	printf("\nWARNING: Your libc doesn't have the scandirat function, please ask its maintainers to implement it.\n"
 	       "         As a rough fallback, please do 'ls %s' to see the available tracepoint events.\n", events_path);
 #endif
 	close(events_fd);
-- 
2.40.1.495.gc816e09b53d-goog

