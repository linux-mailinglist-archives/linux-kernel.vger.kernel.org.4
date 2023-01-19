Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593FC674107
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjASSb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjASSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:31:49 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D994C8A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:31:46 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l15-20020a170902f68f00b001948ddc7cddso1808570plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSuiBVm55Q80Tk0UPfBL9kzPamY+Qqa2tBQ8WoHmUiI=;
        b=PBdaBmAqFJb9V7fBj1q6ZWOgsj2wnTFqbx3DuY8v+5ZG/7IsnCWzCvJb6ai+Yj4l7T
         bwLnzbUcBrgx4KXhrOKir9eCFKGiWIAdn426HYOfXoK6biy7c/uZYEbI4uWi/mYdBhHc
         WzTbUwkWte+V2dtcmbK6YNPfBWYkCRNlCh2Nyq+bm+KlmLAV1Fh/OKPuMS7nTmJ5pmqA
         T3IfJm/+dWZmfFX6bn5Z/ChMIX9NWV0FdH9GEHCzDvjEVsoNJ3rGhhhAXkrf6HMx4MJb
         chznyhMZs5cBhS3cMMcahT6zUqQ6XGqDavm4uYJr75s3QBGkHgDSukvkOpAHtrxFEr6r
         AJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSuiBVm55Q80Tk0UPfBL9kzPamY+Qqa2tBQ8WoHmUiI=;
        b=SDhSqtDxiOXCe8OXm6xIL9dSXr18iK2DqI9e/O5lRDXHaU4KcSdtngK7nm577H48j1
         DnolrKzNpcPHyZWpgRPp6g3OVno7EeeVawKjKCT2qbH0+yt86NWBnaA2dO7KOVS0rR0t
         csyuEoHHv4TUxZ23yEmWIqVmFeIAQ8WWgl0PgfnxMqkmLRSQLPe/HpjuPcga4w3FR1F/
         sdRog3zCAzqlaK0kasLvGj37QfU5C54HFT4aM7pHxgXgH+55OaLxrvrGHaHiRtrGWgbV
         bgbL5EeH5rPf1/IXPZ2ZzDOvtxXDMO/PDpUVXJgHlzkRoOJdIvxpfq47s1axSml9QGmt
         QugA==
X-Gm-Message-State: AFqh2koGD46r9n2tviCMc9Gc8cDQX5RZvVUNYVmrtr5sVUch5rL07WY4
        lxpPTMTPtedaFTow+6a2raokLlbPvMAz
X-Google-Smtp-Source: AMrXdXtsxYiVhuSjUb9OTQPGztNrobPwSI7MihfNsySf7aq292BvQTRsTTNhd4egDqahfTeW50jRWeHJHzVS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:93c6:b65e:5f33:bc6b])
 (user=irogers job=sendgmr) by 2002:a63:3381:0:b0:4b4:e491:c331 with SMTP id
 z123-20020a633381000000b004b4e491c331mr851563pgz.19.1674153105597; Thu, 19
 Jan 2023 10:31:45 -0800 (PST)
Date:   Thu, 19 Jan 2023 10:31:18 -0800
In-Reply-To: <20230119183118.126387-1-irogers@google.com>
Message-Id: <20230119183118.126387-3-irogers@google.com>
Mime-Version: 1.0
References: <20230119183118.126387-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

HOSTCC is always wanted when building. Setting CC to HOSTCC happens
after tools/scripts/Makefile.include is included, meaning flags are
set assuming say CC is gcc, but then it can be later set to HOSTCC
which may be clang. tools/scripts/Makefile.include is needed for host
set up and common macros in objtool's Makefile. Rather than override
CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
builds and the linkage step. This means the Makefiles don't see things
like CC changing and tool flag determination, and similar, work
properly.

Also, clear the passed subdir as otherwise an outer build may break by
inadvertently passing an inappropriate value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 76b737b2560d..ac8e302babc6 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -18,14 +18,11 @@ else
 endif
 
 # always use the host compiler
-AR       = $(HOSTAR)
-CC       = $(HOSTCC)
-LD       = $(HOSTLD)
-ARCH     = $(HOSTARCH)
+HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
+		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+
 RM      ?= rm
 CROSS_COMPILE =
-CFLAGS  := $(KBUILD_HOSTCFLAGS)
-LDFLAGS := $(KBUILD_HOSTLDFLAGS)
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
@@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
-		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
+		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
-		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 CFLAGS += -g \
@@ -76,11 +73,11 @@ export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-	$(Q)$(MAKE) $(build)=resolve_btfids
+	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-	$(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
+	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
 
 clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.cmd           \
-- 
2.39.0.246.g2a6d74b583-goog

