Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967ED62E7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiKQWFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbiKQWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:05:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD01F2D7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:03:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so2807098ybr.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfxYDuXklSdFBnB842iyXLpCafR1Yynr/t8/u3lWnLk=;
        b=QB6NtROf6U1rxz3MyBkb7hyXnsEAUKn8Yt7U8Js/VGrXwQui98OWbEU535c27I3kV4
         cvi1UMKhtUodANPnqcN9MZfZG7RB5/e1U81ZDY8y9TP1DQuxEisw6ZNl6Uo0vX5ALiNC
         hYAFvtbhHBZwcR2Uq42KK2KnkeD7Rb+sH79PCGMl0pcaHtfrHDdumqzv7upUM1Y5Ahha
         rFlnLIvVk3OJR2Q3L7iCbGWmoU8wXyS9fKP5aiLtPszslHHZmg49vcpgskGqmYLRCM+2
         wiClBH8WViK/yNDBnKbQvt1kuLEyfHPbRaSaOZmZ6SG77F4PK3TaAlF/1Q+C3XNo1THY
         xwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfxYDuXklSdFBnB842iyXLpCafR1Yynr/t8/u3lWnLk=;
        b=4UDtcJvFKXUWjuA1UQRkrZUl7NePa6Do+BdCgzSnDiQ+T0qNw6Dzy9lSAdL6Hwv1zw
         Rc8otu1NLGTZ5Au+01Ukxqp7KhGMyV5Za7ljrvxq7U4pnL9USv1waROAC4qIl1rf6qcZ
         7w5zynW++Vlnxm/sQ94BvEg5V4ATSyoxSWbbPj5IwzBh0NHVXqyQgnJpN5OIZBf3begU
         rqHFgS0Rqc9gCV3vkpmvJqC45aNsXiCgYVwVK0tSP7EysRmtw8We89V8Jt++jXfloGNN
         T4SISqSWNjrnDHgS4Zm36SLwWbl+5zlpZH3M4pGIpfCISrvGfTz6SGQUAs6ZZIo3njmu
         am/g==
X-Gm-Message-State: ANoB5plfvARA4iv3IwQ8DeoNqGzPntnXMqzz8+EM+4NAUOCtMCHwCsLZ
        KHm0qSAhsuemG0oh97Aw5OArjzVFB6XW
X-Google-Smtp-Source: AA0mqf6jZaYoAVCrlYwRZY8eE8TGFmtwjrHL90Yo9gR5Yof6nlyvd2wV12j+TFtuN3SnPLeBkHN3eGgbrpnn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a0d:fb83:0:b0:373:65e2:ad91 with SMTP id
 l125-20020a0dfb83000000b0037365e2ad91mr4098454ywf.66.1668722628801; Thu, 17
 Nov 2022 14:03:48 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:03:36 -0800
Message-Id: <20221117220339.341290-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v1 0/3] objtool build improvements
From:   Ian Rogers <irogers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

Ian Rogers (3):
  objtool: Install libsubcmd in build
  objtool: Properly support make V=1
  objtool: Alter how HOSTCC is forced

 tools/objtool/Build    |  2 --
 tools/objtool/Makefile | 68 +++++++++++++++++++++++++++++-------------
 2 files changed, 48 insertions(+), 22 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

