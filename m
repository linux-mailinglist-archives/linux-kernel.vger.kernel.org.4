Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B485064BDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiLMUaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiLMU3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:29:54 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45CFD1B;
        Tue, 13 Dec 2022 12:26:25 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f9so614891pgf.7;
        Tue, 13 Dec 2022 12:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eunpPqNIioAIh6oggqPAPCImtIarWZxO3LlqXOoyfU=;
        b=ZnAX3SjX1+BI5veXj4o/UF4Lsjtb07nZ9a2RWWK17Atuf+n8l8h8pwKO4X3pY/k5om
         pFPjNE/Z5TnrLtLq/iYWa0hr/tkfmpGJuJNLQYs1g0ei1E7Pd5oHPBn9b32fRHmGyXiT
         4e8XTZvXfK5En7qf/QBAWwdOwUAW+kQoklPu6nL5fv9la9TudN3ka3hszUE0hdeR0lVs
         9psLKqVnh23ekJf/rd69lngrisc7GazzY/XI4VFKB76qyZag4FF4SRnEFKaStcawU2b8
         TsOVwKBEWt1P+S9CCOrdMtT3FXDWTKsreHocqTJw4rb9MhmOqFMuk/SfskhOetNSknCN
         Rr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eunpPqNIioAIh6oggqPAPCImtIarWZxO3LlqXOoyfU=;
        b=4H62Wx+17nxJynR6dysR9ma4rt0cUKkoM5glLfzVDUA8sBE1Py2nCUHWTiLu1AMp9c
         5uekvtL+j0OOXpPev51mY9xGnX/+vZAkbj2xCCXQnpsHg3vfEXrljZbMLyr994jUV551
         /ZMP/3vkpOT/2SgFmUSGhjq2DEMlIf+v5d9Ml57XjKU4SCnxRKnfPBjKfFG5+mqSwZQL
         uA2qR1vCaVI+2BqMXOa3tsxLiB93TSNdnTxBiB5TV6W7sRM6IgZFXAJlb3rwayK+zByz
         MHyB97tGXX5ufj4c0Y1A0+K5NqCi/YCByGoreHKDs3EqkCsMYEe/GLBH6UV2WdKWY6Vz
         m7kA==
X-Gm-Message-State: ANoB5pmEc+rGAMbd1LLyEVD67lkXKEAoAZhWjpdqKGSJG4SurQ3swY5s
        liTOiNmHCwtKR9m/Bq1YVnA=
X-Google-Smtp-Source: AA0mqf7kzaiTGwjM7e0zM0LMUECvs/p0b9BGGN/53EWoMXlVd6Nkf4r5tdCqhn5+fPq5BAK3cjMoFw==
X-Received: by 2002:aa7:8b48:0:b0:56b:ae1d:a3c6 with SMTP id i8-20020aa78b48000000b0056bae1da3c6mr5043203pfd.1.1670963184803;
        Tue, 13 Dec 2022 12:26:24 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b00571bdf45888sm8023394pfl.154.2022.12.13.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:26:24 -0800 (PST)
Date:   Wed, 14 Dec 2022 09:26:15 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Vipin Sharma <vipinsh@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] scripts/tags.sh: choose which directories to exclude from
 being indexed
Message-ID: <Y5jf59VCL/HAt60q@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5fdgI4uTpXZQ9yn@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's common for drivers that share same physical components to also
duplicate source code (or at least portions of it). A good example is
both drivers/gpu/drm/amdgpu/* and drivers/gpu/drm/radeon/* have a header
file called atombios.h.

While their contents aren't the same, a lot of their structs have
the exact same names which makes navigating through the code base a bit
messy as cscope will show up 'references' across drivers which aren't
exactly correct.

Add IGNORE_DIRS variable, which specifies which directories
to be ignored from indexing.

Example:
        make ARCH=x86 IGNORE_DIRS="drivers/gpu/drm/radeon tools" cscope

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

- v3: change commit message wording and rst syntax (Req Bagas Sanjaya)
      change makefile variable scope to global, use blank space
      separator and change variable name to IGNORE_DIRS.
      (Req: Vipin Sharma)
- v2: change approach to include everything unless specified by the 
  IGNOREDIRS variable: (Req: Vipin Sharma)
- v1: https://lore.kernel.org/lkml/Y5OKDvbGk4Kro6MK@mail.google.com/
---
 Documentation/kbuild/kbuild.rst | 7 +++++++
 scripts/tags.sh                 | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 08f575e6236c..5202186728b4 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -278,6 +278,13 @@ To get all available archs you can also specify all. E.g.::
 
     $ make ALLSOURCE_ARCHS=all tags
 
+IGNORE_DIRS
+-----------
+For tags/TAGS/cscope targets, you can choose which directories won't
+be included in the databases, separated by blank space. E.g.::
+
+    $ make IGNORE_DIRS="drivers/gpu/drm/radeon tools" cscope
+
 KBUILD_BUILD_TIMESTAMP
 ----------------------
 Setting this to a date string overrides the timestamp used in the
diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..1ad45f17179a 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -17,6 +17,13 @@ ignore="$(echo "$RCS_FIND_IGNORE" | sed 's|\\||g' )"
 # tags and cscope files should also ignore MODVERSION *.mod.c files
 ignore="$ignore ( -name *.mod.c ) -prune -o"
 
+# ignore arbitrary directories
+if [ -n "${IGNORE_DIRS}" ]; then
+	for i in ${IGNORE_DIRS}; do
+		ignore="${ignore} ( -path $i ) -prune -o"
+	done
+fi
+
 # Use make KBUILD_ABS_SRCTREE=1 {tags|cscope}
 # to force full paths for a non-O= build
 if [ "${srctree}" = "." -o -z "${srctree}" ]; then
-- 
2.38.1

