Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A075BB1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIPR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiIPR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:59:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92ACB6D0C;
        Fri, 16 Sep 2022 10:59:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f23so5892772plr.6;
        Fri, 16 Sep 2022 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=cUos+vcM9RRP8jutVG/rSrtmvF3gBZ9cbF4X9vnuVXA=;
        b=mDL1f6wdW3HYPP3qHIuExoLh4wMpLe1oSX6/1SvYT298q6552lcJjjzEr9HiBBdb0s
         cgy3JkLLgigeVlyz7a565GqGJU4+06YddMU0R9rGvC2XEyTKSt3XJ+NgsoTwgrnI6DXz
         /c+25Lu3WHlsouJUahvrr3lgOkbkNTI3du/KkuA+TxB3tRfZA/PIF/Bi2WCumkJz0LUZ
         Q2HnZEOW2+suQgvGOoaHgmQEsboC4p8/LXq38ozCn/fFVj8xjVgKxC3SiQ5cuFBtXfxX
         Gor3O6b5JJqU3oydXwVzqfJ6xaA/foC1nGZ9v2SygXkGegPGXKLkvTKNf9KyrjlrpfKK
         KGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=cUos+vcM9RRP8jutVG/rSrtmvF3gBZ9cbF4X9vnuVXA=;
        b=GUKK6puyEfXbQht1Q+DAhEpRtKoxvCycalOnKtKTdkDa8bvqfLpVsAGwDi1Q/81E+F
         yIwQPT0vENbW8rNsmOeGocvejikQnj6jL09cQo93Ns6AyRKkBrgLcBaGqSUkfMKjfTGS
         j90tzr1IaDttMMxcgue+V+bpqL8r3L/6oplGIj6/ulAf1k3UFjNCHexsvx+pfkB3htfY
         lEKR0G+Tdt3p4k7yakKzDxF47FDb9wiT4vIIsppxQj/26ICv+SQb/x/wkeKTwesNL5g+
         7h91gGh0sJfHz2ckwDyeuk3jMtvU5pGwJ9crxmfZl5cLB1SU8kceeSK2X8OkwhAflSz5
         eruA==
X-Gm-Message-State: ACrzQf0G4qwYXSB2/ZSW4B+Gze2EAh5WSJaFlbTiS7FHAWompsdGshO+
        VM9DJMmsgzqwen12b785/Aw=
X-Google-Smtp-Source: AMsMyM7hhgcaLiNuABgMK+AUqf9lco8WK6JwmsakaTsF1Zw+04inBwzNO8HhdjxkPC8tBuo576bBPg==
X-Received: by 2002:a17:90b:38ca:b0:202:fb75:7dc3 with SMTP id nn10-20020a17090b38ca00b00202fb757dc3mr17663941pjb.192.1663351149748;
        Fri, 16 Sep 2022 10:59:09 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id jo21-20020a170903055500b001767f6f04efsm15059458plb.242.2022.09.16.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:59:09 -0700 (PDT)
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
Subject: [PATCH 4/4] perf tools: Honor namespace when synthesizing build-id
Date:   Fri, 16 Sep 2022 10:59:02 -0700
Message-Id: <20220916175902.1155177-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220916175902.1155177-1-namhyung@kernel.org>
References: <20220916175902.1155177-1-namhyung@kernel.org>
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

It needs to go into a namespace before reading a file.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index e6978b2dee8f..d0d540d09196 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -391,6 +391,8 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	struct build_id _bid, *bid = &_bid;
 	struct dso *dso = NULL;
 	struct dso_id id;
+	struct nsinfo *nsi;
+	struct nscookie nc;
 	int rc;
 
 	if (is_kernel) {
@@ -410,8 +412,14 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 		goto out;
 	}
 
+	nsi = nsinfo__new(event->pid);
+	nsinfo__mountns_enter(nsi, &nc);
+
 	rc = filename__read_build_id(event->filename, bid) > 0 ? 0 : -1;
 
+	nsinfo__mountns_exit(&nc);
+	nsinfo__put(nsi);
+
 out:
 	if (rc == 0) {
 		memcpy(event->build_id, bid->data, sizeof(bid->data));
-- 
2.37.3.968.ga6b4b080e4-goog

