Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAC6C71BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCWUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCWUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:44:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0940D1422E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:44:34 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t2-20020a632d02000000b005075b896422so6264269pgt.19
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679604273;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUfH+Md25yxJlsQyV3Gh/pKDcR3vpRAyfVLlwmvSTm8=;
        b=r5sFoUsvHJiYHwcBYyaeQ803fagCsoXB1Z7YeDcDG0mUp8kslqinFa8KGSlkzW9EXW
         NxfOb2OYUZBuswWowzazRO2qyHrCxEPF8naVv+u+mNkRPpdEurDFVJ/goqcUg8snJoeG
         KY3lCFbrgMlNuenjPczaQz2cyAo+gZpgG0Jpbxza0v0fc2TfqnH3uuA/8M9Cb55QkzbT
         wX0S8KjgcuxsQ3R9Jgyy67SI2Wll4Q91qgkHTK2zfdlFDO4v+t7OT8BhrmOntmgQEeh/
         0VT/WEVh6xsoziimpAjAGMR6JrmRMTNmlAj6tPwyge0Bo+JvfPqVtpwZDXbRWzGQJSjT
         21jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679604273;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUfH+Md25yxJlsQyV3Gh/pKDcR3vpRAyfVLlwmvSTm8=;
        b=k6KujZ86RdF8vF/hVJbBNLxyGhqn1lr3DQtJsaUX1LUcxOAjJoFGcOzanyozl9Vxei
         9wB4vXhz3CgM1Ut4Own1cF4g3BSxXHPo9PIigld+GWfwEPJITpbN6ULeWIOnzpUPLvC8
         mgZtKLmeXspdQSMl3peZ8iLFJglUW0KtPPdufYliYouv3oQaQ6HEo37Qyhd9mVhS4KZo
         D8bvj7wELgJM4ivCLYFZhjKHe2su5Ra5FCCya7eWJ6qMQo+Ka1LxAr8Csj0K9iCyeTna
         XpDkE5N+e1Yvpm0vfYzUFHD86OpSUGxGVOYldtqKZTGdkSWB13FM9cGIWtz6OkUqwQYn
         AOJA==
X-Gm-Message-State: AAQBX9fY6qGb2WypZ2BxP58qHU5jqy8kT/xsktCF0viNnupFYrl3LN8/
        WVT6OK9tz9aUeYjWCehXSpHI7MHLyU6l
X-Google-Smtp-Source: AKy350ZV6PnQ26m1GatpX9oDOCaJcCw7tvcdGEWSqd7uKp/+FB9YfwsG8w+HiPvG0MJ+mrSr4FfqZgWlRD0L
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a17:903:22c6:b0:1a0:6000:7fd0 with SMTP id
 y6-20020a17090322c600b001a060007fd0mr94758plg.5.1679604273533; Thu, 23 Mar
 2023 13:44:33 -0700 (PDT)
Date:   Thu, 23 Mar 2023 20:44:27 +0000
Mime-Version: 1.0
Message-ID: <20230323204427.3594372-1-maskray@google.com>
Subject: [PATCH] Makefile: use -z pack-relative-relocs
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>
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

Commit 27f2a4db76e8 ("Makefile: fix GDB warning with CONFIG_RELR")
added --use-android-relr-tags to fix a GDB warning

BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr.dyn'

The GDB warning has been fixed in version 11.2.

The DT_ANDROID_RELR tag was deprecated since DT_RELR was standardized.
Thus, --use-android-relr-tags should be removed. While making the
change, replace --pack-dyn-relocs=relr with -z pack-relative-relocs,
which is supported since LLD 15.

As of today, GNU ld supports the latter option for x86 and powerpc64
ports and has no intention to support --pack-dyn-relocs=relr. In the
absence of the glibc symbol version GLIBC_ABI_DT_RELR,
--pack-dyn-relocs=relr and -z pack-relative-relocs are identical in
ld.lld.

Link: https://github.com/ClangBuiltLinux/linux/issues/1057
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=a619b58721f0a03fd91c27670d3e4c2fb0d88f1e
Signed-off-by: Fangrui Song <maskray@google.com>
---
 Makefile                      | 2 +-
 scripts/tools-support-relr.sh | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a2c310df2145..30c2edc35813 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,7 +1113,7 @@ LDFLAGS_vmlinux	+= -X
 endif
 
 ifeq ($(CONFIG_RELR),y)
-LDFLAGS_vmlinux	+= --pack-dyn-relocs=relr --use-android-relr-tags
+LDFLAGS_vmlinux	+= -z pack-relative-relocs
 endif
 
 # We never want expected sections to be placed heuristically by the
diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-relr.sh
index cb55878bd5b8..58c2e8b02ce8 100755
--- a/scripts/tools-support-relr.sh
+++ b/scripts/tools-support-relr.sh
@@ -7,8 +7,7 @@ trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
 cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
 void *p = &p;
 END
-$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=relr \
-  --use-android-relr-tags -o $tmp_file
+$LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o $tmp_file
 
 # Despite printing an error message, GNU nm still exits with exit code 0 if it
 # sees a relr section. So we need to check that nothing is printed to stderr.
-- 
2.40.0.348.gf938b09366-goog

