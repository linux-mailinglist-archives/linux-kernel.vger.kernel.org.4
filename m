Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947A05B575E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiILJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiILJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:45:56 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A933437
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:45:55 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so2912321edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=uClVApymgkgK7fH66RPqLcCXsTpVvQDUaMyIyH9j81w=;
        b=mzaREv75OO9jeMTftu6qMrDvjWyoS7dmtczfI+DtBQstSDLGDMqZPaz7hb7dEGfdFa
         L5zrXlF3i7wXLMmc/QK6Cq1gQoQ9a8oRiW7/dJRFif9hjgAosjALtzl9zYJM/kgXcUiv
         BWoNUYm3av4TubtS3UGkngxlAUZMPWF08ez0R6WK4aVQK1mDMUs6iN3FjuBDChWgaNGZ
         M3tMcHSBdu3mzZG410pdINdYJt47pp8gj0t931+z+Ks59iJxlg22luFuhDE6QyxAau1S
         4cCXlV1yaGQUnjHo4h9/zLpYnBs2LRgoFzpg7EJ638CRr5+zBKFWhWu/kUaeeIeZOdq+
         jVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=uClVApymgkgK7fH66RPqLcCXsTpVvQDUaMyIyH9j81w=;
        b=ayj+3IopnHwArwOJzv90Bpb1gzG2AXFdvowBBzeAaKMa4dwCbjttN7JCxs5JWqOfjl
         uGNJzsQ8Z00xFIP6nSjawLEDBdKMh7ywTC/Jd6MvGWjbR3Ica95x/d0npBRacr1teFsg
         ldBUJZ2ys2hHc95j4thBV8EVZgn3KV4qoaIcLlarYWVnnMVQvDIJ2dT0/+wEFEgfN5fD
         vHGsDmUOLBY9qjoZkSsl5pYX3DTkP0wnI10An0my+Q8ncwDrdKJCsZTvkJyffWpvdqn3
         Wsi+lr3cvLOJKYJDmCXvIlfCYara1YwWjH3dJLNaaLG/n3TcPKL2Xj3I2je/w2hPT9F5
         bkKA==
X-Gm-Message-State: ACgBeo1+ljTnKcA8E74eO57AM/DvjT4BbzgVhCwAClXyQLEpkkVWDTFX
        QF/WRBH3CgGek50O3mzQBGxNLa7yOg==
X-Google-Smtp-Source: AA6agR7cvD8C/Dhvo0E3GiFQpr7GnkJ1DN4GnoER7SNLYE1VvkIUscG0N07VxTdgE9lGYtSmBjs0Lg5IVA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a05:6402:4011:b0:44e:b8b5:f52e with SMTP id
 d17-20020a056402401100b0044eb8b5f52emr21439836eda.352.1662975953684; Mon, 12
 Sep 2022 02:45:53 -0700 (PDT)
Date:   Mon, 12 Sep 2022 11:45:41 +0200
In-Reply-To: <20220912094541.929856-1-elver@google.com>
Mime-Version: 1.0
References: <20220912094541.929856-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912094541.929856-2-elver@google.com>
Subject: [PATCH v3 2/2] objtool, kcsan: Add volatile read/write
 instrumentation to whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds KCSAN's volatile instrumentation to objtool's uaccess whitelist.

Recent kernel change have shown that this was missing from the uaccess
whitelist (since the first upstreamed version of KCSAN):

  mm/gup.o: warning: objtool: fault_in_readable+0x101: call to __tsan_volatile_write1() with UACCESS enabled

Fixes: 75d75b7a4d54 ("kcsan: Support distinguishing volatile accesses")
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
v2:
* Fix commit message.
---
 tools/objtool/check.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a..67afdce3421f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -999,6 +999,16 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_read_write4",
 	"__tsan_read_write8",
 	"__tsan_read_write16",
+	"__tsan_volatile_read1",
+	"__tsan_volatile_read2",
+	"__tsan_volatile_read4",
+	"__tsan_volatile_read8",
+	"__tsan_volatile_read16",
+	"__tsan_volatile_write1",
+	"__tsan_volatile_write2",
+	"__tsan_volatile_write4",
+	"__tsan_volatile_write8",
+	"__tsan_volatile_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
-- 
2.37.2.789.g6183377224-goog

