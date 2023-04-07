Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55D96DB5F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDGVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjDGVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:54:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135D08E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:54:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c0c9de33aso62737697b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680904453; x=1683496453;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=60/gaWjqwxGxXAf1RFA4/q2SLdJZklouAa0oPsZCWds=;
        b=Qhw2EW+4aO8HOMqvj77ihzfS9g7ZnLOebOfTVGs6Bp9HHfKeM/qrmTLAdJ4l6ISnyn
         RxMjmlopmXxB72k1bOqeirBew5mWplug6Ewd97bK1c3CHX6xS57pmGQ+IXE9usrR4rqu
         CxicbSo6xuyGKKBUUpSlvjtrI4dqhONtSgvPMZBVKouvL/OLtM04DwPcvFAbakyMoCnH
         4nuyN5Mdb437ug/HXqRLDNACmbsJZBnLF42y8Ynk40Q36E/WunmTExf0Zt4zDPxozIlI
         1LO7SJm6yWEA+Nl785MDoP6Nu4ULYAKyV1tUp2ac/sm6ZgSxwOi0KJQ8kCFw6DAVvFDJ
         13rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904453; x=1683496453;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60/gaWjqwxGxXAf1RFA4/q2SLdJZklouAa0oPsZCWds=;
        b=g/Q7J/ORFxp+8ZGKYQfFzFstH6W06CtMEbg3KprbZFeTggRkpTLSlrw6DGY0dJL4pw
         e5RkkVLqwVxbvU3CZsCy57KDVVczHrqs5QBV3XHY8WMIkRssCckP0ZKP/FKfxMpEkYEW
         pDjbg/cFWmDxQjqqFSAmtZGenjGasJmW7abfXqPym7lEHkhtG92+70+aRvpUvMdtbJpZ
         yc+7bdno0Kqcm4JYNFq66d7cNsoFRQFJB2V/qkdX3/ajHVxYRVFqHjyjzg+jQujcuwv0
         HyLCEyIMIVMWUwlRMdkWPTv+iSlWpWRPzoQE3hrMn4tQwZVsfxOER9BoGAgpIfMuh9+q
         HlkA==
X-Gm-Message-State: AAQBX9dbyBVRQMMDAbwxc49iTUwkGCvcmUFRmiIdfDHhix2RsGEhCO7n
        zeE2NV+5SGVz5GCe4RKgk2H9bxsVZSBD1klX5W0=
X-Google-Smtp-Source: AKy350YZGLQttBsJBiSzvsH4GXxX/gr2XTEnt3Gm4td0CS9uL/uv9ncEDsszE1P48ehWX4928Not5n2uGYBZW+FTRjY=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:5eb4:e720:fec7:a2d3])
 (user=ndesaulniers job=sendgmr) by 2002:a25:be11:0:b0:b7d:4c96:de0 with SMTP
 id h17-20020a25be11000000b00b7d4c960de0mr228715ybk.5.1680904453185; Fri, 07
 Apr 2023 14:54:13 -0700 (PDT)
Date:   Fri,  7 Apr 2023 14:54:06 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680904446; l=996;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=C5/yj3qDa9KhR4UNMrn1PEBO+c6lL+GF6BnPy8SNCPE=;
 b=pIUDMTLAc1jlTZb6Z0m7DMdK+Ax1Hgzz92XKoj37sCgoRZKH8ki7vbYVV0XRchPisfI/FnNeR2bn
 plcEouwqAu8IQbI4r2ZX1l3w0OCcB2wrdspMuUqOfJy5KMBscdN+
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230407215406.768464-1-ndesaulniers@google.com>
Subject: [PATCH] ubsan: remove cc-option test for UBSAN_TRAP
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
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

-fsanitize-undefined-trap-on-error has been supported since GCC 5.1 and
Clang 3.2.  The minimum supported version of these according to
Documentation/process/changes.rst is 5.1 and 11.0.0 respectively. Drop
this cc-option check.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Masahiro, Kees: get_maintainer.pl leaves much to be desired for this
file. Can one of you please pick this up?

 lib/Kconfig.ubsan | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index fd15230a703b..0e7ad0782399 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -15,7 +15,6 @@ if UBSAN
 config UBSAN_TRAP
 	bool "On Sanitizer warnings, abort the running kernel code"
 	depends on !COMPILE_TEST
-	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
 	help
 	  Building kernels with Sanitizer features enabled tends to grow
 	  the kernel size by around 5%, due to adding all the debugging
-- 
2.40.0.577.gac1e443424-goog

