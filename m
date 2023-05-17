Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E847E706AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjEQOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjEQOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:22:50 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47540131
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:22:48 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ab1942ea59so698473a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684333367; x=1686925367;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuKCiN0GsJ8OHQMOtwjIA926PpAafXDesAG+PJNLB4w=;
        b=g7wrHU6uq2xD2GN9k9RTGAjOJ/G7rFP+fM4A5C7u57+yQPjVpAy1qE55kPrj/g++oW
         qWQURotC0kllC0VlqVvvOU9AbeiLAoEYqxnQ/V+Ufm24Tel/Erb1nQYYVsImpVe6aMGF
         9sDfQ44n0D+qFrKFbIPAcavZn6uKKKJKNfpjFdjvnpypY77ZWdK5gk2vvU2d21qbl9EX
         il/861WtuNjylHqNnWqbberJgdBfkprFbl0fzaBX8J+isBv0ZRe/4k6zU8+Fh81No1r6
         xxW9spxtZ3T70TVD+eiQ/iDfakr9s6aW0DadH4sRnCnMXJUon3ps0DnkXP47WF2WZtBL
         W8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333367; x=1686925367;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JuKCiN0GsJ8OHQMOtwjIA926PpAafXDesAG+PJNLB4w=;
        b=Cji2LRsjqTCfK7NasJsJgdtIlU+9r8sAZuDlyIVGPOTWHTOh1vpk+Yog9dfcPLHDsv
         tBCLwCdInK/U2Akvv4Mtfvg8gpEOJk1PSt44I9wgqvxPS5LWbyE1r1Zk1/Vw7ebKiTpY
         01sLTp1XixxPfOwcO8aZjLbmIEpaXCyWzc26EdsFjikZamM2Fx33locASmqfl9pBxrrj
         1sgXm+A4f/qXFHH4CwhyJ+S+xqMiIYQ4b+ZyL4EIUrqvVQDBoAkQC6ZfNntkVItmSW4u
         UaNGnSWJLkEtw+AqMOdRusQcvBmliuPlrux24I9Iu0fWp3+VERkSh++COER7MN3nSPjl
         IK+w==
X-Gm-Message-State: AC+VfDxb16eqIS215uctsAQqSW7CQJzgXXDsYAlQg09fL1U+y58LRHXr
        H3EvtRrNcAnHxpJsBevqL8E6xDYffpHMYQ==
X-Google-Smtp-Source: ACHHUZ70pendzTKPckgC9aqV96J1pBP9SjiuYTnponbHRo+mRGPTpdruy0wE048KwezXq1NELBIdOQ==
X-Received: by 2002:a05:6808:340c:b0:396:30e2:a183 with SMTP id by12-20020a056808340c00b0039630e2a183mr2333348oib.43.1684333367379;
        Wed, 17 May 2023 07:22:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.173.237])
        by smtp.gmail.com with ESMTPSA id r81-20020acaf354000000b0038ee0c3b38esm9960499oih.44.2023.05.17.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:22:46 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 51E80403B5; Wed, 17 May 2023 11:22:44 -0300 (-03)
Date:   Wed, 17 May 2023 11:22:44 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync arch prctl headers with the
 kernel sources
Message-ID: <ZGTjNPpD3FOWfetM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in this cset:

  a03c376ebaf38394 ("x86/arch_prctl: Add AMX feature numbers as ABI constants")
  23e5d9ec2bab53c4 ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
  2f8794bd087e7958 ("x86/mm: Provide arch_prctl() interface for LAM")

This picks these new prctls in a third range, that was also added to the
tools/perf/trace/beauty/arch_prctl.c beautifier.

  $ tools/perf/trace/beauty/x86_arch_prctl.sh > /tmp/before
  $ cp arch/x86/include/uapi/asm/prctl.h tools/arch/x86/include/uapi/asm/prctl.h
  $ tools/perf/trace/beauty/x86_arch_prctl.sh > /tmp/after
  $ diff -u /tmp/before /tmp/after
  @@ -20,3 +20,11 @@
   	[0x2003 - 0x2001]= "MAP_VDSO_64",
   };

  +#define x86_arch_prctl_codes_3_offset 0x4001
  +static const char *x86_arch_prctl_codes_3[] = {
  +	[0x4001 - 0x4001]= "GET_UNTAG_MASK",
  +	[0x4002 - 0x4001]= "ENABLE_TAGGED_ADDR",
  +	[0x4003 - 0x4001]= "GET_MAX_TAG_BITS",
  +	[0x4004 - 0x4001]= "FORCE_TAGGED_SVA",
  +};
  +
  $

With this 'perf trace' can translate those numbers into strings and use
the strings in filter expressions:

  # perf trace -e prctl
       0.000 ( 0.011 ms): DOM Worker/3722622 prctl(option: SET_NAME, arg2: 0x7f9c014b7df5)     = 0
       0.032 ( 0.002 ms): DOM Worker/3722622 prctl(option: SET_NAME, arg2: 0x7f9bb6b51580)     = 0
       5.452 ( 0.003 ms): StreamT~ns #30/3722623 prctl(option: SET_NAME, arg2: 0x7f9bdbdfeb70) = 0
       5.468 ( 0.002 ms): StreamT~ns #30/3722623 prctl(option: SET_NAME, arg2: 0x7f9bdbdfea70) = 0
      24.494 ( 0.009 ms): IndexedDB #556/3722624 prctl(option: SET_NAME, arg2: 0x7f562a32ae28) = 0
      24.540 ( 0.002 ms): IndexedDB #556/3722624 prctl(option: SET_NAME, arg2: 0x7f563c6d4b30) = 0
     670.281 ( 0.008 ms): systemd-userwo/3722339 prctl(option: SET_NAME, arg2: 0x564be30805c8) = 0
     670.293 ( 0.002 ms): systemd-userwo/3722339 prctl(option: SET_NAME, arg2: 0x564be30800f0) = 0
  ^C#

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/prctl.h' differs from latest version at 'arch/x86/include/uapi/asm/prctl.h'
  diff -u tools/arch/x86/include/uapi/asm/prctl.h arch/x86/include/uapi/asm/prctl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/prctl.h   | 8 ++++++++
 tools/perf/trace/beauty/arch_prctl.c      | 2 ++
 tools/perf/trace/beauty/x86_arch_prctl.sh | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f1868dd..e8d7ebbca1a4dc41 100644
--- a/tools/arch/x86/include/uapi/asm/prctl.h
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -16,8 +16,16 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_XCOMP_TILECFG		17
+#define ARCH_XCOMP_TILEDATA		18
+
 #define ARCH_MAP_VDSO_X32		0x2001
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+#define ARCH_GET_UNTAG_MASK		0x4001
+#define ARCH_ENABLE_TAGGED_ADDR		0x4002
+#define ARCH_GET_MAX_TAG_BITS		0x4003
+#define ARCH_FORCE_TAGGED_SVA		0x4004
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/tools/perf/trace/beauty/arch_prctl.c b/tools/perf/trace/beauty/arch_prctl.c
index fe022ca67e609533..a211348d320444c3 100644
--- a/tools/perf/trace/beauty/arch_prctl.c
+++ b/tools/perf/trace/beauty/arch_prctl.c
@@ -12,10 +12,12 @@
 
 static DEFINE_STRARRAY_OFFSET(x86_arch_prctl_codes_1, "ARCH_", x86_arch_prctl_codes_1_offset);
 static DEFINE_STRARRAY_OFFSET(x86_arch_prctl_codes_2, "ARCH_", x86_arch_prctl_codes_2_offset);
+static DEFINE_STRARRAY_OFFSET(x86_arch_prctl_codes_3, "ARCH_", x86_arch_prctl_codes_3_offset);
 
 static struct strarray *x86_arch_prctl_codes[] = {
 	&strarray__x86_arch_prctl_codes_1,
 	&strarray__x86_arch_prctl_codes_2,
+	&strarray__x86_arch_prctl_codes_3,
 };
 
 static DEFINE_STRARRAYS(x86_arch_prctl_codes);
diff --git a/tools/perf/trace/beauty/x86_arch_prctl.sh b/tools/perf/trace/beauty/x86_arch_prctl.sh
index 57fa6aaffe700c8b..fd5c740512c527dd 100755
--- a/tools/perf/trace/beauty/x86_arch_prctl.sh
+++ b/tools/perf/trace/beauty/x86_arch_prctl.sh
@@ -24,3 +24,4 @@ print_range () {
 
 print_range 1 0x1 0x1001
 print_range 2 0x2 0x2001
+print_range 3 0x4 0x4001
-- 
2.39.2

