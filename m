Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1728172D83A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbjFMDs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFMDsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:48:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F061A5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:48:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a33c35b1so74344897b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686628100; x=1689220100;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yRFC2gTGY007exC0q04MPM2juCknJSwNc/jlO0n+WpM=;
        b=VTWfjUVR8/UW1zs2ihPMDXWF3W50tJ+8vNMUicZElwkf6TK3Qpfo71NnZNRyhZ4lMh
         1cgRzyRkY4qxCCnK74TPSj6Si1gl2Xo85izzGgGCkK+WlK4i5aI+Vl1qcbJ+DZeXNyhy
         53ElrNS7kpDILNA2tLMEro7VstfXg6d1fxusQnOMoB4dHnD4KlxEIY5F9DsbVHpIf3PU
         Tp9G7njcFEWQk7HQAnMhWLlMQEs75aNWGNim6jLyQPeAupbigfRdUVxfQW1ND+rqP6/H
         SGOiskS8HRJi30IigNaKRQTkjLgOK7fG6ghqadu28kCraVYyZCagS+Pkz1okJDa6Eba0
         zuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628100; x=1689220100;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRFC2gTGY007exC0q04MPM2juCknJSwNc/jlO0n+WpM=;
        b=jwzbGo6xVIZKMF9vKSYZrRNcct6LUgUKxjEo03pS+EYoWT8L1ErLlJHFhwIc2eX+K8
         INF1LFMAYgoT2/Zg31l4u0PkaxzfYrFXIDjHlslIImd4a/vLvucVDEkcDZz5CDUlwwu5
         dACalKLBF6Z1fcurHPRPn6i2AdSk3Vg6eJrCSmgqIKRK763kR0VP2ZuoTDrQ5kaijmyP
         153v+/9MEarYslhSIdSewkcJ7oq64fcJCJMmlG4G2tXBAhjB1RHlCRhgEY/QfwXNnbwy
         xcSixNMYQGeRYJAOcNvJh7Ty2IV7w/U+EGFeQHmZKrxr0MmLSjSyBTjs9I2ij1N3IQ3F
         Agpw==
X-Gm-Message-State: AC+VfDwB4bMgM+15EmVMm2672mjUd6tQF4plQ5chxMrv4o3/+WalBWjn
        H2VHlPGvvfhx4JCqCpDcQnOsYIGLU5L3
X-Google-Smtp-Source: ACHHUZ6WvZmHfRtOL6PifDmP9nAuzb3DebSOsXHxUxvJFPY38MyU0uRAiIHoxg8oAsOrrCaJ6xJR+YkM+R6K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a704:56d6:f79d:33e7])
 (user=irogers job=sendgmr) by 2002:a81:b3c1:0:b0:559:e97a:cb21 with SMTP id
 r184-20020a81b3c1000000b00559e97acb21mr284968ywh.9.1686628100761; Mon, 12 Jun
 2023 20:48:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 20:48:15 -0700
Message-Id: <20230613034817.1356114-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 0/2] Fix srcline addr2line issue with the ',' sentinel
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Changbin Du <changbin.du@huawei.com>
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

addr2line makes it hard to detect when inline output has finished. To
detect it srcline issues a bogus ',' symbol and expects to see a
filename:line of "??:0". For binutils addr2line ',' gets turned into
address 0 and if there is a symbol there then the sentinel isn't
detected, this problem has been occurring with kernel binaries.

The issue was reported by and debugged by Changbin Du <changbin.du@huawei.com>.

v2. Incorporate feedback from Changbin.

Ian Rogers (2):
  perf srcline: Make addr2line configuration failure more verbose
  perf srcline: Make sentinel reading for binutils addr2line more robust

 tools/perf/util/srcline.c | 93 ++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 20 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

