Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375A05FF280
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJNQsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:48:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A71D346D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:48:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t8-20020a258388000000b006bfb0865043so4797153ybk.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZK2Ju4zSJK/cFpoidH2hzfPFGWx+ElmNubQLi9yMXQ=;
        b=ODM98BgJ/cKX1b/UZJZWr5JmMNrGuznQCVCMo06L5Ss1vTUP23ycGuGpUMPjwuSDKp
         j36q2FVyfTmyxl+/RJbca7QQ40v9VCiLGiqDQWeo0Bd4LUDepGc88Zcert4lHdJPfpDR
         COKUqItbECqRdReNDe0V2UqnP+u+g9lUME5ch1ulxh1KicqbP01tRq5wJrc/231XyPa7
         R9+jLT5Nnk1UHImgA8Fe1p5k6y0qOQc8REE136O/uD1KeJIdGHsylPzXJjfnSEBpavnV
         odxcZndY4511ArXjpnT+W+mbaAjUwnQbV0dYgkPK6uLnG+L2O4SdXweCgGu41fPagJsI
         B76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZK2Ju4zSJK/cFpoidH2hzfPFGWx+ElmNubQLi9yMXQ=;
        b=neMk1NOs51A/cmsiM2C2nRt4JI6+yIV1U7Xx9qAb1nlw0XAzyHgRXH6etU4IuOfliR
         R33QrZQjfnyC0FGu7nQuffpH16QaSOHb/GYlho2D+nYyUM2t+moazaXXFiLgJ/1cROjt
         nR1xHdULJBJdkVbBwjbsZ9mJBnK+DpxZdhjJpFDr8hGuOk/3I2EdM3DLMK4kmyhmc7CS
         00NzPNWzu0v0lBRxmIM0a6jFw9kqA2i0BxLxufaHj0Jth/Eb3pd4R31FqAfPFjdEiLfk
         UrXTQ6Zl51Q3Tji6aI+/3stH1CbGpaufpuCEhPRWc4SynhOp5TOmXK1EEu7kPukj66+6
         xYVA==
X-Gm-Message-State: ACrzQf1HIlK1sQKRnxHH9dngSN0NcodEY1IbIPRhg8eskqIRaFgbu1D7
        bbzqr2e1ALn8ru6PpSXwtsCG0DBjDw7TRiim4IM=
X-Google-Smtp-Source: AMsMyM5v9kUJtiJrQNAYWu6hHLvOpX+vIujvu+NwJcpv1H+JJe66wf45HAi7nkt9Ldh+JszCV15k0iGrMXtD83KH7fk=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:ff3e:881c:4c2c:b8c9])
 (user=ndesaulniers job=sendgmr) by 2002:a81:468b:0:b0:364:8aa:8196 with SMTP
 id t133-20020a81468b000000b0036408aa8196mr4253949ywa.468.1665766082016; Fri,
 14 Oct 2022 09:48:02 -0700 (PDT)
Date:   Fri, 14 Oct 2022 09:47:56 -0700
In-Reply-To: <CAK7LNAT7yY3VL=so0+h=fsefT2QXsKHn4KjCFJ5VtGGkvSRjLg@mail.gmail.com>
Mime-Version: 1.0
References: <CAK7LNAT7yY3VL=so0+h=fsefT2QXsKHn4KjCFJ5VtGGkvSRjLg@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665766076; l=2224;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=8DTYldYpKZ2G8xj/84VezeBfD7KI9kJfAVZPcDwBDkg=;
 b=+Ngjjr5PZ7w9Yvg5XA7ztowz8vknz4VbMPJYWfMddmK/y0ivoHQAWynJyc9xe1DztL5gowdoj2P1
 BW8svoFJCzo84gyAnzQnjhXR+4Up0E0cV9bvMqJhVip6S+oas4Ro
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221014164756.843991-1-ndesaulniers@google.com>
Subject: [PATCH v2] kbuild: add -fno-discard-value-names to cmd_cc_ll_c
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
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

When debugging LLVM IR, it can be handy for clang to not discard value
names used for local variables and parameters. Compare the generated IR.

-fdiscard-value-names:
  define i32 @core_sys_select(i32 %0, ptr %1, ptr %2, ptr %3, ptr %4) {
    %6 = alloca i64
    %7 = alloca %struct.poll_wqueues
    %8 = alloca [64 x i32]

-fno-discard-value-names:
  define i32 @core_sys_select(i32 %n, ptr %inp, ptr %outp, ptr %exp,
                              ptr %end_time) {
    %expire.i = alloca i64
    %table.i = alloca %struct.poll_wqueues
    %stack_fds = alloca [64 x i32]

The rule for generating human readable LLVM IR (.ll) is only useful as a
debugging feature:

$ make LLVM=1 fs/select.ll

As Fangrui notes:
  A LLVM_ENABLE_ASSERTIONS=off build of Clang defaults to
  -fdiscard-value-names.

  A LLVM_ENABLE_ASSERTIONS=on build of Clang defaults to
  -fno-discard-value-names.

Explicitly enable -fdiscard-value-names so that the IR always contains
value names regardless of whether assertions were enabled or not.
Assertions generally are not enabled in releases of clang packaged by
distributions.

Link: https://github.com/ClangBuiltLinux/linux/issues/1467
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Only update commit message:
  * Pick up Nathan & Fangrui's RB tags.
  * Add link (I forgot I filed a bug about this a while ago!).
  * Add note from Fangrui.
  * Add final paragraph.


 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 22adbf89cb31..41f3602fc8de 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -140,7 +140,7 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
 # LLVM assembly
 # Generate .ll files from .c
 quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
-      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
+      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -fno-discard-value-names -o $@ $<
 
 $(obj)/%.ll: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_ll_c)
-- 
2.38.0.413.g74048e4d9e-goog

