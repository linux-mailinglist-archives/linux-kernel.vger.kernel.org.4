Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7A6D0DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjC3SjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjC3SjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:39:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3BD53E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:39:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so19677335ybc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2U8QUctphzNcHKFtorNgxLmK4+8NLFcRnbJiYAJzuAk=;
        b=Hj8wOroWD45sTFPIEx4Y9GnOts8Xb7rDnQaK+4CqIK/M+8apuoZ2Gc91cudxa03uhu
         /G8XELSG30NWcBb1GBwrTjCWyOr+ENgsdxshP4Q2yb+Y0fpCqA951mAggXzsIVgZpsze
         HsQ7DaToRGm8XSX1uvFkt2g83kIul6rR5ZXQkbG7FOYZpwQwwnEQAkutIdxuufoBylGo
         P+fxsYlSkX46x4/uWbp1TE4/Q3yia1/fcagSU3zqkzJD9Qa2l/yVqOrGUuRmRMBK/DFm
         pSr1TpxMrfg8/MyDiOO4JWZ4LMzKpsU0d70smMmapiE6Pif245xAU6z0KEvSKL1rY0Yq
         ugmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U8QUctphzNcHKFtorNgxLmK4+8NLFcRnbJiYAJzuAk=;
        b=xpYDxAnkQJooVvhiPfscaum6RTftpO250ixkAGKpC0ETOY6KKzDpcoz3Yjq3oBP6GZ
         zLnBmqT9lb4l13i8xCEEv4ukqFKRH2Jgvk3h9mjHYK2CTcKTwTd+gS2VyYLdIjRtVAlH
         r1TlujwU21MAulXCIaf/huE2GCXWa1/kZkmwRcqwlDLAQWQA08YvQZ/Q/CdfUmdcMOSn
         VtCJHgpLilb/gGUhmueyDH9GldHQNnThS2ZeMJwQFDzxCG/MHljuSm4OjnuiaSplEoy+
         l89GmtBT64YFRyjyTyC9C2L9axzAl4LUT12BzSf9i12ibTHMHKdhxTFz5Ssgbp7rrdRz
         3MAg==
X-Gm-Message-State: AAQBX9eiVJ6oLCg4FFY3RaB87V0u0I9jJSjhe1/tLvoTJYrOSZUTKXAy
        /+SuLRg80bmY5kY6P+iuK5rOKfiVS8eY
X-Google-Smtp-Source: AKy350aITBhRw3nhzJl5DrlBG23PbTNNFKSYGz4YYA9/uEHzMD1izDLfkL69SpiqNTkyLh5m6vvE5zAK5VUG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with SMTP
 id w3-20020a056902100300b00b1d506198e3mr16637242ybt.6.1680201540592; Thu, 30
 Mar 2023 11:39:00 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:38:27 -0700
In-Reply-To: <20230330183827.1412303-1-irogers@google.com>
Message-Id: <20230330183827.1412303-3-irogers@google.com>
Mime-Version: 1.0
References: <20230330183827.1412303-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 3/3] perf build: Conditionally define NDEBUG
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a build is done without DEBUG=1 then define NDEBUG. This will
compile out asserts and other debug code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3066d0c318c3..236d763181c5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -228,6 +228,7 @@ ifndef DEBUG
 endif
 
 ifeq ($(DEBUG),0)
+CORE_CFLAGS += -DNDEBUG=1
 ifeq ($(CC_NO_CLANG), 0)
   CORE_CFLAGS += -O3
 else
-- 
2.40.0.348.gf938b09366-goog

