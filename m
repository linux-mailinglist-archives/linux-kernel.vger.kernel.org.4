Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE99066AE93
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 00:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjANXAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 18:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjANXAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 18:00:32 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E9E3BC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 15:00:31 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d16so9054037qtw.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3XCi6AfxSAqS5zfTvqe8suxE7tzF8peDwUROyvJdd0=;
        b=DCvz3bkLZakEpTkPpr0XwSu/dWqJzzD2YWAY+4X20tODPd+44+2woBDINF6C7uavGE
         AFTr9bhlIK4sYaWzqEJmomyk79njyBOlnElNd3+5Rps98ZI84gaEsfE9zyATVnfNXZYK
         W+UnBkv5gQcCvTEjV02mQ9yo4neMJ3xGyVMrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3XCi6AfxSAqS5zfTvqe8suxE7tzF8peDwUROyvJdd0=;
        b=lLktVYkfQPuQQaUsGc9d4DBOSykCti4G5xUNKDmlXYBhBOU3pB/Ua4agHP7XkkhBWV
         de3hExmGZXZL0Ig0hPt0EMYAtvuOs2qJkb6Mua81DyAa4ZBWY7OtfGX8LXNBSBeLdOHP
         7FK0SwpnlfrImd/VWFEmZkP5Bd/WlCXPA4iJx8R/zAt5i3Hjrd/3XlaqJyLi4v5iJxYM
         id0ma+H34d2Ix0UIdN8aexvUCbpNfSn7cF9g25vxaAFR3yW1KkRCyw+3T+ezlJcEqJT3
         yxTxB3y5lWrYkxhihCxnTtylI141fZ4ZFEKaPFtzrCvEpTy/709GabnBqI1JbYvXtME6
         AolQ==
X-Gm-Message-State: AFqh2kph7Uz+7+x8qVofWLeUVhTojxnYxz0b5cQOKZ81MBfoPIpzvdZR
        QppFOxLMdvNepaYisLuPZYmSAg==
X-Google-Smtp-Source: AMrXdXtV8kzhjM0mYYtQvEKOs5VCP5FkGjdffWhpq0GZ23j78oKYxQYXe68DedpEtslq0G1ShXI9ig==
X-Received: by 2002:a05:622a:4d47:b0:3a6:46b4:2a6b with SMTP id fe7-20020a05622a4d4700b003a646b42a6bmr132730359qtb.27.1673737230600;
        Sat, 14 Jan 2023 15:00:30 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006fa4ac86bfbsm15132169qki.55.2023.01.14.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 15:00:30 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Sat, 14 Jan 2023 18:00:18 -0500
Subject: [PATCH] tools: bpf: Disable stack protector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAAI0w2MC/x2MQQqEMAwAvyI5b8FUobpfkT2kGjUHu5KICOLfr
 R6HGeYEYxU2+BYnKO9i8k8Z8FNAP1Oa2MmQGXzpqxKxdnEdXYsNMfoQQyDIZSRjF5VSPz/tQrax
 PmJVHuV4993vum5craNsbgAAAA==
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673737229; l=1810;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=QjHX5cBfbMx9A2AI5fA8Eg+Dzw4jlnZ+WyV+BAFRgnE=;
 b=SEteZLNsaPCTQYt40+vXrNdYOdi+lpPaAj0mBIbbUzFE4hE2tqD65Jb57PS7BkA4E8FTe4SJf0h+
 PnvXw2BLD200psGUovhBHMkygtVbohD3sm4+bOBG6vI4565haZmp
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid build errors on distros that force the stack protector on by
default.
e.g.
  CLANG   /home/peter/linux/work/tools/bpf/bpftool/pid_iter.bpf.o
skeleton/pid_iter.bpf.c:53:5: error: A call to built-in function '__stack_chk_fail' is not supported.
int iter(struct bpf_iter__task_file *ctx)
    ^
1 error generated.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 tools/bpf/bpftool/Makefile    | 1 +
 tools/bpf/runqslower/Makefile | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index f610e184ce02a..36ac0002e386f 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -215,6 +215,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
 		-I$(or $(OUTPUT),.) \
 		-I$(srctree)/tools/include/uapi/ \
 		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
+		-fno-stack-protector \
 		-g -O2 -Wall -target bpf -c $< -o $@
 	$(Q)$(LLVM_STRIP) -g $@
 
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 8b3d87b82b7a2..f7313cc966a04 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -60,8 +60,9 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
-	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
-		 -c $(filter %.c,$^) -o $@ &&				      \
+	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		\
+		 -fno-stack-protector 					\
+		 -c $(filter %.c,$^) -o $@ &&				\
 	$(LLVM_STRIP) -g $@
 
 $(OUTPUT)/%.o: %.c | $(OUTPUT)

---
base-commit: 97ec4d559d939743e8af83628be5af8da610d9dc
change-id: 20230114-bpf-918ae127b77a

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
