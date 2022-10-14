Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768465FF298
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJNQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJNQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:53:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786A1D4DEC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:53:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3586920096bso51062047b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc0BD757OBRsWzCUX9oyngIwjPQp+BAyfWqnsfk61u8=;
        b=ioc3m6C5Fm/7qjEnH220M8dI3J7PTpr2dgi5QH5knbwJSaMVZo3DOqoVftmEFc47uu
         W/XNCfPuCaPU/lK8Ubz8O0FeUc0ZkQyUaEisH2Yj+VAgrBTfdxCDRVLbpuDRxFCap6Qr
         3qOBQ5T3dcWgZuwvW97ingzURD8DirZTk3f/mtLpAUdN3kYgDM5m7SvkNzkicBLv7LVF
         Ps+K0ygARA3b8OW44TOQ0TZrvNby3xXW+dp1QmQ9/ckbd4lgL25p6VBIY5KTthYdNqi5
         yqeKNRiFt8o8zVZaa37WDrhsuD9QD1pslQfcD/7KLv71DzgKqUj0KrdUd5zafiWy3L2U
         yHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc0BD757OBRsWzCUX9oyngIwjPQp+BAyfWqnsfk61u8=;
        b=UCTDEhRhRoa2rNhAqRhBych7tIdQ/oa9XuMpht52sK+OBrTUs6uL2mB6xeGRJdH7tt
         hiZ6ToeDSNMnNGUhPdPHx6Lsv2XxpKaWh/68shntSFSEb6L3YNiF4p+1B/kIwOb+VYCW
         FzfdBr9quqxAUA+DCllnd8pnEuL632yTcxHAQ2NoYd5D8/UTfYFIv39A6f33J3tGpNlD
         bzxu97XxbxQQ+A2k7mQ0GWaAk4GNtR0gt0J6QoyLclFhZEeYzF0hG0K4WYmrTcNIjQq8
         0Rx85vlEukTqWLR7ntjESOBsRyA2vdXIuvsGBQmtPqqUeXNDhBqqGPp+rqFtl4MxtEPs
         osxQ==
X-Gm-Message-State: ACrzQf01/iYTnlw6nxwqWUTixXOM772NbmlT53qESJNy9Uyrmw9eXLV4
        bGGcbJuE8l6l9vSRCsOEwgmYYku+yXH8L7abmbc=
X-Google-Smtp-Source: AMsMyM6R/JyO3K9ikaIzjDtG/9LUjuv/rAAlcjNa1CT0oDMtyliH9swRPu7SzFz8mSGv7Rfu1AQoWBRF9MD8foW7/04=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:ff3e:881c:4c2c:b8c9])
 (user=ndesaulniers job=sendgmr) by 2002:a25:7c41:0:b0:6b4:fa81:9803 with SMTP
 id x62-20020a257c41000000b006b4fa819803mr5331099ybc.592.1665766386031; Fri,
 14 Oct 2022 09:53:06 -0700 (PDT)
Date:   Fri, 14 Oct 2022 09:53:02 -0700
In-Reply-To: <20221014164756.843991-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20221014164756.843991-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665766382; l=2345;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=8HfLbf4qs/mk/4RV44RQCCc8Q6kO5IPcR6SJl0HTqUI=;
 b=ItISVPZeSrDGVs3uBlS4saLOlHhj6pQ08OLur37IOFyLGVWyNIsnXGAvDmo56prRy6IxulxHD1V/
 AH3DpJIBDLDuLrWr+6cIPVK6SM1+HlS2KyrAeWgFOjin7RDxUMJJ
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221014165302.845203-1-ndesaulniers@google.com>
Subject: [PATCH v3] kbuild: add -fno-discard-value-names to cmd_cc_ll_c
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

Explicitly enable -fno-discard-value-names so that the IR always contains
value names regardless of whether assertions were enabled or not.
Assertions generally are not enabled in releases of clang packaged by
distributions.

Link: https://github.com/ClangBuiltLinux/linux/issues/1467
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> v3:
* Fix typo in commit message
  "enable -fdiscard-value-names" -> "enable -fno-discard-value-names"

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

