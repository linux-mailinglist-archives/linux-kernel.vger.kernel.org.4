Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3A64E1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiLOT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLOT2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F59947310;
        Thu, 15 Dec 2022 11:28:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l10so7893plb.8;
        Thu, 15 Dec 2022 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcnm4Zq93QUEsGpL/XwELq+tM+TYBnIw8vL4+pn2Juc=;
        b=djhlXXsB0/6QWxwYZIivL1rWWU3Jgt1lnyFA1luTJfnAArtoWBQXRYf1klMZtruE3f
         3ZClMW21ekZecQNwH+Y6NcYFgh9TI92hIAqpZNrpg429K0Au152qTR1MQdAlvyn+BLUz
         79G4lwNmD66L36k76vbaXmpBebWzkEmCqe3LV57J2F92T7li+nnUpDbzAN9TxmimL14t
         sv48p2QjfyiOcmK/4hJLULCuDMkWusZeq7xINUt9cb171D6nRZazmcCbupZRx2jrJvfN
         d9NNtNXPNOhSJYysvE4q7A6A8yGkD9Fa/vm6ZskShaknok0qcMQbyH6RvT3uva532tfF
         MBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tcnm4Zq93QUEsGpL/XwELq+tM+TYBnIw8vL4+pn2Juc=;
        b=4mzEQnl28/zDW5iMfJKkE250aSISMZxzNV7WAxhaIni0ZQSilhbG+1+T1U9swtOcrf
         2odoBT60/4TS1X1gaojLY8jr6TaRZIxyYbJ6yydnqGP12teJPpfZHtOGAVDsoQrMNTB2
         Rlu4vV3yKXrWhXENkIOlCQqL0YN3VmKQL3OFajViDk77J0qn2Q1EwcYJWqv3uGsi2fmr
         X59uK3wpcbKEwdV1sIvLp3HGAAwn6CVrIwG/DQM5eol8ZfL2baDPpKTqmQZwEI0en8hA
         aB9tIoQeN04BTKIan7wTpn3gBDrIJEBLHryc/8fpIa4Yygv2GxEgUlTmcbgomPne3tFZ
         cM5Q==
X-Gm-Message-State: ANoB5pnMRPew/PajQDzMs1/Z4b80juKOfYHznWOJJAaytlCUrdj3FWna
        FheUo2ISUAaMeOFUKDf9Z/I=
X-Google-Smtp-Source: AA0mqf5bzZfmeiVhTJoNjkSfzB2h1Uj3QUZFd2TiAnFN84jx3Bc1gqSryxFYbBsInbEjDMzSkfWf2g==
X-Received: by 2002:a17:90a:fe0a:b0:219:8cba:cbbd with SMTP id ck10-20020a17090afe0a00b002198cbacbbdmr30647158pjb.32.1671132501846;
        Thu, 15 Dec 2022 11:28:21 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:21 -0800 (PST)
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
Subject: [PATCH 1/9] perf srcline: Do not return NULL for srcline
Date:   Thu, 15 Dec 2022 11:28:09 -0800
Message-Id: <20221215192817.2734573-2-namhyung@kernel.org>
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

The code assumes non-NULL srcline value always, let's return the usual
SRCLINE_UNKNOWN ("??:0") string instead.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/srcline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index af468e3bb6fa..5319efb16a5a 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -716,7 +716,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 
 	if (!show_addr)
 		return (show_sym && sym) ?
-			    strndup(sym->name, sym->namelen) : NULL;
+			    strndup(sym->name, sym->namelen) : SRCLINE_UNKNOWN;
 
 	if (sym) {
 		if (asprintf(&srcline, "%s+%" PRIu64, show_sym ? sym->name : "",
-- 
2.39.0.314.g84b9a713c41-goog

