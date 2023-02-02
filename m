Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06386889F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjBBWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjBBWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:43:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9386A315
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:43:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4fa63c84621so34294407b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETyfBjp/kDN4jefKK3Q6zUxbaFrFVt3ACbzabZOwIuE=;
        b=f+YzL74Biy2AeE/Zv7pl/NQCIMJRpyiBH1LQMN3/bPSp6adF98sWUVFEwoLqYrIBb/
         DOVb7otliIKxY4YUT9qhHBiCjbR9+0a/ItIQlht2WP6mWTWOr0eYmi3AsCnwZOGbhRRg
         bBSyUM8ZJbdDUVrRIMqJitkLWOY7x1tO1GoyqR8HUq+jitRYiv7pI4q1I41omUzKjp+P
         v2SkAtSoTa7EsvXYotDrR3Tqzjl6XANJKeUV/uollY/5OpQnwaLe/e2rLlM7iwQMzvxC
         WsS1KDS12DFVrGGYl6ju5odsW6Z/mLL1fzb5sJBvBwkeVoEG45+KzS+YS/HHMmuHxmem
         2y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETyfBjp/kDN4jefKK3Q6zUxbaFrFVt3ACbzabZOwIuE=;
        b=o4FST9g1+yqSP/FWee4zx9uWJzvN+UcYj/35/WyEu8F3bVWfKYUMT+ekEjEUteX+Yz
         o5+A09P3u6uZ+j4lKo/kfb35y/AVSlCMMDYjlyJHt5WCrpUjaTh4YoBa3zOzLHnfm5VD
         o3lODqEjRnFuYydSTOxjldyUIXJdZoFGuu/sdkrPPptPly/0B1Gc4o7Tq/lmaIwFk7sv
         79dRe+YJjdgPkYKreKazeOtcs/x7BL+nQr+DRXbZRkU+ixkg9Lug8VuW5UtABmbrTHYU
         MWNz52BNxqMe5IgjKDTifohNG690wcYKrkqdcnqO4KdWbncLF/a5lzeE/rTeNQBUNaNQ
         RM0A==
X-Gm-Message-State: AO0yUKXS1iGGqkF+8JdCREdEEsKcz816s5ps8C4tfEYWTOvsPBMETor9
        5hBX1sBekX+dbN3Ma8BoFmSHQ5RTEAqh
X-Google-Smtp-Source: AK7set/rWasqhCe1rRkmQpf716Pzhpp5i99MJwOKd7NBWl/NsSb8CYPvVep2h7PP5FQmT5YBD92oe1PMprOL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bb5:4c1f:1143:605])
 (user=irogers job=sendgmr) by 2002:a81:6d48:0:b0:525:196c:d720 with SMTP id
 i69-20020a816d48000000b00525196cd720mr47098ywc.278.1675377821580; Thu, 02 Feb
 2023 14:43:41 -0800 (PST)
Date:   Thu,  2 Feb 2023 14:42:53 -0800
Message-Id: <20230202224253.40283-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v1] tools/resolve_btfids: Tidy HOST_OVERRIDES
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't set EXTRA_CFLAGS to HOSTCFLAGS, ensure CROSS_COMPILE isn't
passed through.

This patch is based on top of:
https://lore.kernel.org/bpf/20230202112839.1131892-1-jolsa@kernel.org/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index abdd68ac08f4..2abdd85b4a08 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,9 +17,9 @@ else
   MAKEFLAGS=--no-print-directory
 endif
 
-# always use the host compiler
+# Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+		  CROSS_COMPILE=""
 
 RM      ?= rm
 HOSTCC  ?= gcc
-- 
2.39.1.519.gcb327c4b5f-goog

