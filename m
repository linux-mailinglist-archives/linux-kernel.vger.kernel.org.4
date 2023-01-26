Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925C567D512
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjAZTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjAZTHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:07:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E113627A8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t13-20020a056902018d00b0074747131938so2860627ybh.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yC7KxDOwmbLkSe3SAx+cCoB6TAXe5zpAN4zyxeJ2dgo=;
        b=ZU46dpygD/bT8paN+r29EXFPvP7T+JZAMP7ZJlfp9JJ41ykWkCvu/RMcnNEeZN7y8L
         KpJYAwrIYMrawsxI/PMe56OgOxjasgs1nnI8Br6r/Lm9TxD1wGHCQybCP56BxjykKgi/
         d4YbRuUlirhgmypW3UInzDz8P2AfwJratR1sffeemvXijQxNXZhD6MGZDFhhuhAvX+I7
         FdtBrm98GAQ8CiAnFZ4JyeVQlx2l59rxBsxFhVRy5y8Ai/PzOK36GRsANkR6lt98br4v
         loeDagdg+bLkcAPdgspNpVIsDiNztzddXDdc0HSXdpypi2Ygsaoim2td3XiV/BD7tUVI
         mFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yC7KxDOwmbLkSe3SAx+cCoB6TAXe5zpAN4zyxeJ2dgo=;
        b=U4KhxvkrGjLL2PStQ7iMa0AfxcguvrZyXXg9D/vWuy5oQFVf5tA6IpMRXVgCKvSmNU
         2PydAbD1jI0M2SJ6WR30pXxBwKhxvwhN+w3EiAPKfnsNbbXc0tpxZ6bnHFUhIU6O47Ld
         ilN2XnLJVEShz3zZiObYG5npqW1lWUb+LhFdW292u0nDRBevrfv7FJX0qUp9L7BZfoFs
         wr9LRhP+CnTG7vmpsqrrYEvPWav2MRtWraKhjI8tNAjSYqPf+P24R+5yi8U2p6MHGdv5
         efP+IFDKsYShFJWd6VxYi7DO4dxyLh6/SApcwEhYnKiHyH6fbA8jzlwBYCiI/l1f86c9
         C4+Q==
X-Gm-Message-State: AO0yUKVUAVW9b17oEhcMZJpo3KpQ1B3izjVi40JN/hvvX5DIoNa/+FZs
        dOWUOEZG/j7MDFBhowjkUJWpyg/Rnu9B
X-Google-Smtp-Source: AK7set92h/zdh7EkpeQdqTn9+HGOPdlBPyutqm4NlQlwfmiLk6uvNy9lxKmi1Oen3yEkGtCOYzrAJpt1Cc1z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a0d:d4c4:0:b0:506:4828:ea11 with SMTP id
 w187-20020a0dd4c4000000b005064828ea11mr1487091ywd.189.1674760025278; Thu, 26
 Jan 2023 11:07:05 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:06:03 -0800
Message-Id: <20230126190606.40739-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 0/3] objtool build improvements
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
being set for say gcc, and then CC being overridden to clang.

v4. Rebase and look to address review comments from Josh Poimboeuf
    <jpoimboe@kernel.org>. Removes the reviewed-by/tested-by given
    the scope of changes.
v3. Is a rebase that removes the merged "tools lib subcmd: Add install
    target" patch. In:
https://lore.kernel.org/lkml/CAKwvOd=kgXmpfbVa1wiEvwL0tX3gu+dDTGi-HEiRXSojwCLRrg@mail.gmail.com/
    Nick rightly points out that:
WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
    became:
WARNINGS := -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
    losing the EXTRA_WARNINGS which v3 now adds back in. Previous
    testing had added the warnings to the end rather than the
    beginning, thereby causing unexpected build issues that aren't present in v3.
v2. Include required "tools lib subcmd: Add install target" that is
    already in Arnaldo's tree:
https://lore.kernel.org/lkml/20221109184914.1357295-3-irogers@google.com/
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=630ae80ea1dd253609cb50cff87f3248f901aca3
    When building libsubcmd.a from objtool's Makefile, clear the
    subdir to avoid it being appended onto OUTPUT and breaking the
    build.

Ian Rogers (3):
  objtool: Install libsubcmd in build
  objtool: Properly support make V=1
  objtool: Alter how HOSTCC is forced

 tools/objtool/.gitignore |  1 +
 tools/objtool/Build      |  2 --
 tools/objtool/Makefile   | 62 ++++++++++++++++++++++++++++------------
 3 files changed, 44 insertions(+), 21 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

