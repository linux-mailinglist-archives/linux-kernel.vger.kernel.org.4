Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A168633128
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKVALq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:11:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F270B4806
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:11:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-360b9418f64so125245977b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0hXMTY80VdIvqYOcPDvs1KFXXEcVE57ImwJ1NC0xJ0=;
        b=TeqnmqJc1Rpqk70LVMY/kdh7hasPCpSgcBBcUhLqyxDfT5WaVvRNM7FYAUTaga37sw
         6Np9ZU2dXwZcWiX7YfSOwu828UybvO9/mFeQQYf7ZB4/mNpk3avcTf2mJ7BaTxzOkPVQ
         0KuXd8ML4QgvIFgLuZfZ/Fp/Lspvq2eGgi5AwBucXp/cRHy7Uh3UDGmkgd1yZhWy4Q4G
         FCWuRGgcSGO32vZIs4IjN4ciloXEqjPVyUA7hxHVX114wjW/NcmmpqDCJ3ZFyaTl7IYw
         IXr3GB87CVq+xFUS6gm96w4K3MjxaXPUouuaFtGLS62310cL60JDty4T6RyPyQO5kXcl
         axww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0hXMTY80VdIvqYOcPDvs1KFXXEcVE57ImwJ1NC0xJ0=;
        b=4tF54WhiF9g0y002BIPaxYHe8sMP5BnvJBtvEyJEP/KxtXVz+6nawv8Z3nsGlTggzN
         AUEbHl0+CKP+rpzT9SCF7tb7+WufnALozWVc28VdiYh49eEKFfkArDtdnG8iDmNbZXOF
         7kvkY4t8/JgWmJql46b3sX0LSlZW2RBfqvIuQReh6eGDBen5o5a9l0tjnlZOziMpCxXo
         L8bSflCIOgyoe/XmMw5ikUEWgmxCpDcusuSgqfXdE4IXp3K1Ifk4AogIwY9qbyPdufFy
         Qps51pWOFRqY7m5kuy/6SlZZS7vZhQl08idx3Wxwi+OFXIxtCGdoCnjrhKGHdyPV2VEX
         Io4g==
X-Gm-Message-State: ANoB5plt3gvNuoVxuyU/XdRNAc3/ISnbzyk3pjBK6ual1LrsbZsvxliL
        YqHEYdovdi9/PTTyodXjFpTGbGm7hpPU
X-Google-Smtp-Source: AA0mqf665OYUODFhCpZtd4KUTkQgZM7xzDGktxRFFcuT8xEoFsoZmHMvVA27Dj7kN9vTqVa6BccMxrZS+IfC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2107:a1f5:8582:5608])
 (user=irogers job=sendgmr) by 2002:a81:7cd6:0:b0:357:6958:372a with SMTP id
 x205-20020a817cd6000000b003576958372amr1716354ywc.255.1669075901807; Mon, 21
 Nov 2022 16:11:41 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:11:21 -0800
Message-Id: <20221122001125.765003-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 0/4] objtool build improvements
From:   Ian Rogers <irogers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
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

Install libsubcmd and then get headers from there, this avoids
inadvertent dependencies on things in tools/lib. Fix V=1
support. Clean up how HOSTCC is used to override CC to avoid CFLAGS
being set for say gcc, and then CC being overridden to clang. Support
HOSTCFLAGS as a make option.

v2. Include required "tools lib subcmd: Add install target" that is
    already in Arnaldo's tree:
https://lore.kernel.org/lkml/20221109184914.1357295-3-irogers@google.com/
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=630ae80ea1dd253609cb50cff87f3248f901aca3
    When building libsubcmd.a from objtool's Makefile, clear the
    subdir to avoid it being appended onto OUTPUT and breaking the
    build.

Ian Rogers (4):
  tools lib subcmd: Add install target
  objtool: Install libsubcmd in build
  objtool: Properly support make V=1
  objtool: Alter how HOSTCC is forced

 tools/lib/subcmd/Makefile | 49 ++++++++++++++++++++++++++++
 tools/objtool/Build       |  2 --
 tools/objtool/Makefile    | 68 +++++++++++++++++++++++++++------------
 3 files changed, 97 insertions(+), 22 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

