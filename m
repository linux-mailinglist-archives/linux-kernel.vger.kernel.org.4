Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0A6FCE02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjEISvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEISu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:50:59 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178B2D43;
        Tue,  9 May 2023 11:50:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39427327edbso170731b6e.3;
        Tue, 09 May 2023 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683658257; x=1686250257;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgWCiGkQTALl0i92ZMPzKhrU04PC3r9JkzGT//gCMRc=;
        b=io46sRONIioDIH77mTLjFK+zJCHD3d3WZzrghFP51GxmNGEzI/fTJIcB+BNScSKcT1
         b1nnmjW9FDO7IZL9N20wTx5hrUjjIVDv6MjjM+hxylUowO/3j/ClzQ4bdWO1FPHZV0mG
         5rW43k/o+547bNy2UGFa/vua0dhkVuxSuEjjp1OM/88B9wmzm8kDj/4MTT+fHoQJFdVU
         VVwpjbFiNSY/IbhAYDLKdFSGgm9qYhelIIMe/qQZp6PnWkqbzVG1/y2rM+uj9Zx5+mMA
         cNWW9/zk94jS9hc4+1UFxP8j2XA7lLBzOGXQP43a5FDmys511r39fEk9D8Se4iiALO8Z
         fJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683658257; x=1686250257;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgWCiGkQTALl0i92ZMPzKhrU04PC3r9JkzGT//gCMRc=;
        b=LbwpvuF54g/0ina7b6oag6+6w1O6cSyhUHl1KBWb7J0vyT4WMgxrwY9LMvjPagjriD
         CtN82i4NBMPLjoPzTvXncmEZVxi/QRCWpGRCfj8alR84cPvmFHss1p5zhdHPD73bzcb4
         iSch9YD1IO94/Zl2gtjq+0qeFT+OQQIkPOPVxYZb/u+UQXJMQisS/uLwct/maWxmeVY1
         PS8EKuJ0qYlof12tEuV+o/vpMnu9dT359h6VDhiqQjiLAHqFbRckJRe9vwuiHq84HouH
         7mR38VzFZ8p+Ekabx+T66xAtaUCwa6VemkirWcum584zf/t3DnRdFTbPuBlt8gIG3o3e
         38mg==
X-Gm-Message-State: AC+VfDyKEzP0+62+w+jKlyezsCt4avtOGT3CvRtIYMjx0cGhZjhF9wGv
        ilG+PNtSmygTuf/06jIzgZk=
X-Google-Smtp-Source: ACHHUZ7pef41tELahiecYFgWgFHUnXpNh17J4TSzxVy/Kkpj24nyOOszy0LvlLBabhDzp0vaeyIVRQ==
X-Received: by 2002:a05:6808:10c:b0:38d:e097:aca1 with SMTP id b12-20020a056808010c00b0038de097aca1mr1568753oie.15.1683658257620;
        Tue, 09 May 2023 11:50:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.238.117])
        by smtp.gmail.com with ESMTPSA id i3-20020aca3b03000000b0039208555951sm1489313oia.29.2023.05.09.11.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:50:57 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39D11403B5; Tue,  9 May 2023 15:50:54 -0300 (-03)
Date:   Tue, 9 May 2023 15:50:54 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <songliubraving@meta.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf build: Gracefully fail the build if
 BUILD_BPF_SKEL=1 is specified and clang isn't available
Message-ID: <ZFqWDrVhaIq5QDwo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namhyung,

	The one you acked disabled the build and emitted a warning, but
then that was when we were trying to have BUILD_BPF_SKEL=1 as default,
this one is for the current situation, where we need to explicitely ask
for those features by explicitely adding BUILD_BPF_SKEL=1 to the make
command line, I think I can keep your Acked-by, right?

- Arnaldo

---

Build BPF skels require having a compiler able to generate BPF bytecode,
and so far this is only possible with clang, so check for its
availability and fail the build when the user explicitely ask for BPF
skels to be built.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Song Liu <songliubraving@meta.com>
Cc: Yang Jihong <yangjihong1@huawei.com>,
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4884520f954f4b2a..70268442f7eeca50 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -216,6 +216,12 @@ ifeq ($(call get-executable,$(BISON)),)
   dummy := $(error Error: $(BISON) is missing on this system, please install it)
 endif
 
+ifeq ($(BUILD_BPF_SKEL),1)
+  ifeq ($(call get-executable,$(CLANG)),)
+    dummy := $(error $(CLANG) is missing on this system, please install it to be able to build with BUILD_BPF_SKEL=1)
+  endif
+endif
+
 ifneq ($(OUTPUT),)
   ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
     BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
-- 
2.39.2

