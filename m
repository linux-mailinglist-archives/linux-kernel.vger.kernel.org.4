Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313C665F2A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjAER1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjAER1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:27:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2EA59D23
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:23:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs20so34704671wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcfKvBPEIZCBpfejnS73x0WwQlLjDoYOq2loLUX6TbU=;
        b=KwTi/H999k5fva2x4E5wBta5Rx9fvc3JiOCJaif8gKrNStViCRTQIJjqOJ+RkI+kjG
         bM32qjnNVWALAET3QCG4YDk0O705dgkfl2PfMRQSiKS3cX4asOWiKDNABJ51/Nrp41gg
         fVGpKaGTnNqm8/+uSoIDeG9rZQpdb8V5uGEBQIBWoxCTWSg+0HNSjXEoy9eXdJgQJ6vC
         qVPjg/atlKyDzrkoDWHxsykXvOfgYXqolFnE5HF9jwpodI04uIu8Vn6LMa9H71Xeypmf
         WcIcTR4hfxQ17/9nJ2Xf+ANDx++GsspwhdR256Vf/Fgq9oyh6/wGQuOXh3ZHtAswozK2
         kajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcfKvBPEIZCBpfejnS73x0WwQlLjDoYOq2loLUX6TbU=;
        b=u4771WuS+GKdtOGuesF90Njpxl4OCFXCedEdFDlc7ULoZLUfuDjOrbq6x9Rt1D5TYt
         xaoCqMyheLeax49+IUiVDWoik2KSQrNS9cWYsxdVa2jIZ7w96Y1TL3JcGVbWAwznnBzQ
         FzBh5Agef/yK+MRYkYuOdBtt8basAHxTl2HmrGkPZhYDv5SovBaXIdco6nIAQi5piL+9
         lz9TEbFN2axydlHb9P5Z3qC6xncqx+PffXMan2QWal43kebiRjzhKq/QsOBHF3J90m+W
         7hQ+7vP6v+ju6IeItMLqJcYLHvxA90K+9Z6m8w32iEdIEpUlL+dYaCA39qSkHrjvlFDS
         uUdQ==
X-Gm-Message-State: AFqh2kqL9BUuz8BVvQMizLifz8of9P5L3hJR7BVGrLRyjFOsCo4xSNH7
        lF3d5AmPQTp43qGLXdBln/JQmIlmXSh+ibAz
X-Google-Smtp-Source: AMrXdXsVuG3jlXxidmoUuxedWXclZfrZDMaXokX92TAiPz2xuCOg2zd6+8EV0DNZLOtS/hNregUGCw==
X-Received: by 2002:adf:9dd1:0:b0:242:f3f:28df with SMTP id q17-20020adf9dd1000000b002420f3f28dfmr32911549wre.58.1672939379261;
        Thu, 05 Jan 2023 09:22:59 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:dca6:3efa:4e3:1e42])
        by smtp.gmail.com with ESMTPSA id s13-20020adfdb0d000000b002420dba6447sm37871273wri.59.2023.01.05.09.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:22:58 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] perf build: Fix build error when NO_LIBBPF=1
Date:   Thu,  5 Jan 2023 17:22:43 +0000
Message-Id: <20230105172243.7238-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent updates to perf build result in the following output when cross
compiling to aarch64, with libelf unavailable, and therefore
NO_LIBBPF=1 set.

```
  $make -C tools/perf

  <cut>

  Makefile.config:428: No libelf found. Disables 'probe' tool, jvmti
  and BPF support in 'perf record'. Please install libelf-dev,
  libelf-devel or elfutils-libelf-devel

  <cut>

  libbpf.c:46:10: fatal error: libelf.h: No such file or directory
      46 | #include <libelf.h>
         |          ^~~~~~~~~~
  compilation terminated.

  ./tools/build/Makefile.build:96: recipe for target
  '.tools/perf/libbpf/staticobjs/libbpf.o' failed

```

plus one other include error for <gelf.h>

The issue is that the commit noted below adds libbpf to the prepare:
target but no longer accounts for the NO_LIBBPF define. Additionally
changing the include directories means that even if the libbpf target
build is prevented, bpf headers are missing in other parts of the build.

This patch ensures that in the case of NO_LIBBPF=1, the build target is
changed to a header only target, and the headers are installed, without
attempting to build the libbpf.a target.

Applies to perf/core

Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/Makefile.perf | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 13e7d26e77f0..ee08ecf469f6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -305,7 +305,11 @@ else
 endif
 LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
+ifndef NO_LIBBPF
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+else
+LIBBPF = $(LIBBPF_INCLUDE)/bpf/bpf.h
+endif
 CFLAGS += -I$(LIBBPF_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
@@ -826,10 +830,16 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
 
+ifndef NO_LIBBPF
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
 		$@ install_headers
+else
+$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBBPF_DIR) OUTPUT=$(LIBBPF_OUTPUT)/ \
+		DESTDIR=$(LIBBPF_DESTDIR) prefix= install_headers
+endif
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
-- 
2.17.1

