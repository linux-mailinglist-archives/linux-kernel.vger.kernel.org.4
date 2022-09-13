Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7E5B6B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiIMKZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIMKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:25:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26915927E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:25:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j11-20020a17090a738b00b001faeb619f6eso5383712pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=MDx7DiqqlQBBDK5vXnsY4Li3nGa6YqWYJsSlvRR0dgI=;
        b=bRleO/diLA7l5EowhCnk0MioXpbQrrLmUn6FcOCG4LTErYM1XP+dCDEFv2BFEnes4N
         krlG9RO+ch9LCGN73ukIKi21DSYhcYoi6Gg9fY167j73oaTjzrNV6m5D7bhKsCSSCbKL
         tsFfDo8WUf0qKiGNDy5FwfjqXZ2knpKOJp2c4zCU8sKQ1x9J8bhno9FpfSwwVHBQt6xB
         smSSl0p2lpSKnwqwWWjtEJbiHkacwUuLhka38w00L27Ia/SJBi8nIjZsRENebU1MOA2Z
         3C9JVIVEu+i3egvqP7xEv7ZgqxGSnOi6/ZZTXyqmVOVV/QiZVXqXXv9aSmB1d8bE8sTK
         xOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=MDx7DiqqlQBBDK5vXnsY4Li3nGa6YqWYJsSlvRR0dgI=;
        b=iQ6ghvYNaDDYUG44an8VEi6vv1xo/rIblKKhWpv406m7/kRVshjX9jaV7GdVak/YE9
         oBChgNbCxzG130rRUE0n6b4DyTd4eno/b36MQynewsSRFW3zJ9ljco2bj40pUylI0dId
         YplkIM3kKWe5lnYbMeZ/omEb01Fg8l1woQB611CS+ytbgfzsGunsaXXW6C9oedXbVp+x
         fkz7UbQSv/ahF79oqI5bVn3BBuJe8J49X/AySnobZKURSy5pc5RcSavcu2ZC34NM/YnI
         y7VtYlrzFMPQe39kiAdt/ftULFmNOdnqinaP/CK7lhspvnpz4sWdxKMqU6FaDzk4ahza
         5MkQ==
X-Gm-Message-State: ACgBeo0o52i991xviIKeTsS8ZzugRc1j1APaMsSvmKX9PxY3uQ2kntaz
        NGNY9ocB/ItDFj95ICknZjv4ib6MJyU=
X-Google-Smtp-Source: AA6agR5Ecnlfj4VFDm6pgRrK1VOTRGYoarGlL6bQXuNZYAgfLdRYYbeI2C1rzFGsaK1addb3ja92LPG7dWI=
X-Received: from avagin.kir.corp.google.com ([2620:15c:29:204:d94b:8d9d:2b23:6608])
 (user=avagin job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr208304pjz.1.1663064755004; Tue, 13 Sep
 2022 03:25:55 -0700 (PDT)
Date:   Tue, 13 Sep 2022 03:25:49 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913102551.1121611-1-avagin@google.com>
Subject: [PATCH 0/2] Revert "fs/exec: allow to unshare a time namespace on vfork+exec"
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>
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

This reverts commits:
133e2d3e81de ("fs/exec: allow to unshare a time namespace on vfork+exec")
6342140db660 ("selftests/timens: add a test for vfork+exit")

Alexey pointed out a few undesirable side effects of the reverted change.
First, it doesn't take into account that CLONE_VFORK can be used with
CLONE_THREAD. Second, a child process doesn't enter a target time name-space,
if its parent dies before the child calls exec. It happens because the parent
clears vfork_done.

Eric W. Biederman suggests installing a time namespace as a task gets a new mm.
It includes all new processes cloned without CLONE_VM and all tasks that call
exec(). This is an user API change, but we think there aren't users that depend
on the old behavior.

It is too late to make such changes in this release, so let's roll back
this patch and introduce the right one in the next release.

Andrei Vagin (2):
  Revert "selftests/timens: add a test for vfork+exit"
  Revert "fs/exec: allow to unshare a time namespace on vfork+exec"

 fs/exec.c                                   |  7 --
 kernel/fork.c                               |  5 +-
 kernel/nsproxy.c                            |  3 +-
 tools/testing/selftests/timens/Makefile     |  2 +-
 tools/testing/selftests/timens/vfork_exec.c | 90 ---------------------
 5 files changed, 3 insertions(+), 104 deletions(-)
 delete mode 100644 tools/testing/selftests/timens/vfork_exec.c

-- 
2.37.2.789.g6183377224-goog

