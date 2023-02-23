Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5736A0B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjBWOC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjBWOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:02:17 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4C65193F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:02:14 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id d10-20020a4aa58a000000b0051fed0d7766so1042510oom.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWz1JmSwtExY2FG4Iz+RvjaIL8oZVVK8PrJJdtZoj6Y=;
        b=VYwPaw0zz7TAe9b+0OfdlnmckOWGt2FfAPvFAhglsAcanHFS2ktoiVTyY6rXK0YO5p
         JMQMySyDJ8yOp92y/vqufSABCUDHpAaLXMBjw6bgENX0Jwzgs/u4l5DtDJWlw8R1jOwc
         HRxh5MjAt1lmHq7ff3SCVftcJjyIX40/iJl1XkY3idi+poUlzghT7incki1q8J/E4b+V
         qRrktTCR/hzIj8qJWJLIAytd8kK/5JQG223ZwYEQQscDVNFmIUoInYiqjzdxf+W6dam7
         5tLiMUrcMcoThxa98hX9mCrUt5Z0oHamxsYuplXPQ7HmDUyiqIB0mfvtIyb2JXVLwjAW
         DDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWz1JmSwtExY2FG4Iz+RvjaIL8oZVVK8PrJJdtZoj6Y=;
        b=7+yXl0LwBUtBfw8KtkE8rL2KjFK0VIG9Zb5066TgK2qB3tq1iG/zze0zupH3vOgGQD
         k/2igg6RV43vPPu864vD/Mvo6utJdFcSGrQRzgbjy6tBIeu5uhIoR+3CYTl6vUiGPAkq
         bxwmsfjQ8NOt9Zfmx2T94izDVu16HBoWFEsNwIbjQNE4VCujHuKiq86VNHF+dn7osBZk
         s7fEL+bZBqoug/mMPJ+6l4G0YUddbR5W3/NvG1lUREsUZz/4QCAl6SRT/JsRk0EpwbFT
         DyM2LFOs7R0vxRgZbXn27jZr9J5rKBn7rCJ0dVhNshyTC42CgFBJzNUesx2mRhU2Yuy/
         NU3Q==
X-Gm-Message-State: AO0yUKUdKQB3NYaqYI3uV9+Fv3ZutUyb21cRQ+5LargitQOjqsKHZoIT
        LGw7gTJvEXx6gWe4qjDq6mI=
X-Google-Smtp-Source: AK7set+QzNar5zL7VLuyRm4w/Ig82/0XlN79uVJV96NE1bzHaW/3xPj+Nzl0Z6RBsaf7Zwg41RvsLA==
X-Received: by 2002:a4a:d638:0:b0:51a:6ea9:5053 with SMTP id n24-20020a4ad638000000b0051a6ea95053mr5343004oon.9.1677160933620;
        Thu, 23 Feb 2023 06:02:13 -0800 (PST)
Received: from quaco.ghostprotocols.net ([187.19.237.165])
        by smtp.gmail.com with ESMTPSA id u1-20020a4ac981000000b004fd878ef510sm1459204ooq.21.2023.02.23.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:02:12 -0800 (PST)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB2FC4049F; Thu, 23 Feb 2023 11:02:09 -0300 (-03)
Date:   Thu, 23 Feb 2023 11:02:09 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH FYI 1/1] tools headers svm: Sync svm headers with the kernel
 sources
Message-ID: <Y/dx4T6Z2CXS7eZJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

To pick the changes in:

  8c29f01654053258 ("x86/sev: Add SEV-SNP guest feature negotiation support")

That triggers:

  CC      /tmp/build/perf-tools/arch/x86/util/kvm-stat.o
  CC      /tmp/build/perf-tools/util/header.o
  LD      /tmp/build/perf-tools/arch/x86/util/perf-in.o
  LD      /tmp/build/perf-tools/arch/x86/perf-in.o
  LD      /tmp/build/perf-tools/arch/perf-in.o
  LD      /tmp/build/perf-tools/util/perf-in.o
  LD      /tmp/build/perf-tools/perf-in.o
  LINK    /tmp/build/perf-tools/perf

But this time causes no changes in tooling results, as the introduced
SVM_VMGEXIT_TERM_REQUEST exit reason wasn't added to SVM_EXIT_REASONS,
that is used in kvm-stat.c.

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/svm.h' differs from latest version at 'arch/x86/include/uapi/asm/svm.h'
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/svm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/svm.h b/tools/arch/x86/include/uapi/asm/svm.h
index f69c168391aa58cf..80e1df482337dfe0 100644
--- a/tools/arch/x86/include/uapi/asm/svm.h
+++ b/tools/arch/x86/include/uapi/asm/svm.h
@@ -116,6 +116,12 @@
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
+#define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
+#define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
+	/* SW_EXITINFO1[3:0] */					\
+	(((((u64)reason_set) & 0xf)) |				\
+	/* SW_EXITINFO1[11:4] */				\
+	((((u64)reason_code) & 0xff) << 4))
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 /* Exit code reserved for hypervisor/software use */
-- 
2.39.2

