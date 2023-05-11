Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7F6FEBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbjEKG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbjEKG1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:27:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F0210F;
        Wed, 10 May 2023 23:27:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64384c6797eso6655908b3a.2;
        Wed, 10 May 2023 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683786451; x=1686378451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wccq2cR0tl91tz/Xz/oRtoRCvVeKB1PntoUZvC+KoPo=;
        b=X/nJr+o62wE8h5IO6ySscvVRFTeLOXrjZ+GvnMkMet3bf3AQvsKLeZZizE8UZoHNxR
         f8OLSsbDXLcejOpnV6r2N7DL0A3RDpI0sKiNfwCg9ce2OxvAaJTuP+MvL75uBkRBIe9g
         tLKzz0HWVZGEmmJiGAV9+9g0Z7VzjM1rdnHGlX1tJMGaqZgDxfNfsSPYWjqbY17xNXh3
         SEI12+/bIprRSGwQRghk08j0DcDsuDAp2d2NyIuuBr9mX1mzQPwl81DLStVCR4BdZgB1
         ZYgabkfqBb6VzPdQdl1lY/3aMfkd73ff8JI1VZC+id5FeoCJaEqv7eDSqYb2cx1xEqa7
         Dm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683786451; x=1686378451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wccq2cR0tl91tz/Xz/oRtoRCvVeKB1PntoUZvC+KoPo=;
        b=gyc3C/V//QddVKYSbT/YuJ89VxPVFKYINuGJdqal9VVMUa2ztN1i7Mn+uGhMYFKKin
         d8qEULCeUEe2SdNw0sY/rM1Q3GxJTkqbTrsvIexSCgwMy2ij5bbYb3+SpSEG/WLquzqv
         tzygum1vCrQQUZqUFcDDPEAu74eziz0/UcoaG8i6uOwAtO9snDt4NWkUBL1MV1Y83oFy
         ueDaC++F0fO58mW/xrY4EUAjIaAOULHm5ppi+54j2i1AYG/IJhJfNTwecodD1ERgYgFB
         6gRrihli4IPwQpxQUwbic8IuQ0TH83cwmyzMYEop9M465BmAq65xuKIpv9wnaTQGCVGF
         2l5w==
X-Gm-Message-State: AC+VfDy5TgeH3TfSMT9MwZRXKTkHRxChskOjxvcjCtSB7C6/sXOc0jne
        5X0OJd0qalCPPqD9hCh3xN4=
X-Google-Smtp-Source: ACHHUZ4cl9qdIjCGVU4AHXVztOqh3mEj5WMrHpNEs/6hw9KS/NeeX9Lp6vYF+Savuc3W/ZSgVYaA/A==
X-Received: by 2002:a17:902:ecc3:b0:1ab:528:5f85 with SMTP id a3-20020a170902ecc300b001ab05285f85mr26717839plh.59.1683786450600;
        Wed, 10 May 2023 23:27:30 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c18c:3210:36c3:c88c])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001ac2be2639asm4925683plb.223.2023.05.10.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:27:30 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/3] perf annotate browser: Add '<' and '>' keys for navigation
Date:   Wed, 10 May 2023 23:27:25 -0700
Message-ID: <20230511062725.514752-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230511062725.514752-1-namhyung@kernel.org>
References: <20230511062725.514752-1-namhyung@kernel.org>
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

The hists__find_annotations() allow to move to next or previous symbols
for annotation using the arrow keys.  But TUI annotate_browser__run()
uses the RIGHT key as ENTER to handle jump/call instructions.  That
makes the navigation to the next function impossible.

I'd like to change it back to move the next symbol but I'm afraid if
some users get confused.  So I added a new pair of keys to handle that.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c     | 4 +++-
 tools/perf/ui/browsers/annotate.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 63cdf6ea6f6d..425a7e2fd6fb 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -342,7 +342,7 @@ static void hists__find_annotations(struct hists *hists,
 		notes = symbol__annotation(he->ms.sym);
 		if (notes->src == NULL) {
 find_next:
-			if (key == K_LEFT)
+			if (key == K_LEFT || key == '<')
 				nd = rb_prev(nd);
 			else
 				nd = rb_next(nd);
@@ -378,9 +378,11 @@ static void hists__find_annotations(struct hists *hists,
 					return;
 				/* fall through */
 			case K_RIGHT:
+			case '>':
 				next = rb_next(nd);
 				break;
 			case K_LEFT:
+			case '<':
 				next = rb_prev(nd);
 				break;
 			default:
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 12c3ce530e42..70bad42b807b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -781,9 +781,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			ui_browser__help_window(&browser->b,
 		"UP/DOWN/PGUP\n"
 		"PGDN/SPACE    Navigate\n"
+		"</>           Move to prev/next symbol\n"
 		"q/ESC/CTRL+C  Exit\n\n"
 		"ENTER         Go to target\n"
-		"ESC           Exit\n"
 		"H             Go to hottest instruction\n"
 		"TAB/shift+TAB Cycle thru hottest instructions\n"
 		"j             Toggle showing jump to target arrows\n"
@@ -913,6 +913,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			annotation__toggle_full_addr(notes, ms);
 			continue;
 		case K_LEFT:
+		case '<':
+		case '>':
 		case K_ESC:
 		case 'q':
 		case CTRL('c'):
-- 
2.40.1.521.gf1e218fcd8-goog

