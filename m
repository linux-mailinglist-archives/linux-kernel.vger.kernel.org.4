Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C7E6B6615
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCLNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:04:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE7E3D911;
        Sun, 12 Mar 2023 06:04:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v21so53534ple.9;
        Sun, 12 Mar 2023 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678626266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C88fNbpNNCW2fZzaHvdAaN4smyngfaWHvN+4TC6Vu/U=;
        b=kFCMPQc2sYve/lVbIe5ls9dYN2LyCmd5x8+hMcazTbYR9xurnuNhzQ2Y0slbv7wd5L
         6EJ35TorXe63WI+WssUbGxjKRnBrkU6QRY3UBAj5J1lIiBi/tRoukyeoCwPWfn1FcSvj
         7jvxgwdBXFP9aK2Us1XOkOrchnH9yg3XQPcs0jb79r7z/CEAu5/ArcttodT4NZJWXYtT
         iuaR+o8uWnaKHWr2IgkrHLNHzzJk+yL4wPBd0xRsRM9kQnuEe+DzsiYsnGs6ArTW3PhK
         +DK04Jia/RfxHevH3+rAut53e67/N0RfN8QIgoamVaODHsYHaa7m7dVqnAed1JiMSAUl
         8WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C88fNbpNNCW2fZzaHvdAaN4smyngfaWHvN+4TC6Vu/U=;
        b=ltars5YyvvPbFLaqfjtwQ/Kq/5xADuysAr+n9tSxR56kvV9gPFbS+W5aSnHJuKH+L0
         OjEk6oB6/JXqGucTsI1ZeZecO0Rx71518G85TJ2vWYGM2h7HDG4cqUJgHVNJf8UwBxDt
         rsEKPjD3/6ifB9zPC9EXb7kjmPvfH/OP5wE0PwpCAPGp85bR7SYy+UmuvOYJKqBT1Am+
         lDbjMFtxe0jPd6zmXi3ZJwAsm1WbHhrq2lQMjIOo4/Bigz6adP48wy13RdaX1C+Ptuuv
         RDSqJJ8S+x6w8SKL0rNDDSFH76Oq9gDKgWDqOqhN5Fy66lf7mwXzurFQ4j28grvsEXc6
         8vHQ==
X-Gm-Message-State: AO0yUKWHB2Lip4oEIFQ/FNXPpU/XTedwR07epJx2vaoBLiuBzIFdlzdE
        4SGusTBwhpN1ySOHbHQ7EsqclwFuH6JHWL8j
X-Google-Smtp-Source: AK7set99HL/INURs2FdURDjFPoChaZAtIVfwXX188EPMfu1XBIsb0kvse3VwuBAqN+9DXJPqMewUBw==
X-Received: by 2002:a17:902:c404:b0:19f:e9e7:4cb with SMTP id k4-20020a170902c40400b0019fe9e704cbmr1677531plk.45.1678626266013;
        Sun, 12 Mar 2023 06:04:26 -0700 (PDT)
Received: from kim-GL702ZC.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id kp15-20020a170903280f00b0019926c77577sm2858624plb.90.2023.03.12.06.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:04:25 -0700 (PDT)
From:   Paran Lee <p4ranlee@gmail.com>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Paran Lee <p4ranlee@gmail.com>
Subject: [RESEND PATCH] perf tools riscv: Add support for riscv lookup_binutils_path
Date:   Sun, 12 Mar 2023 22:03:05 +0900
Message-Id: <20230312130303.87954-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to know RISC-V binutils path.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 tools/perf/arch/common.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 59dd875fd5e4..6ac7a22244c0 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -43,6 +43,20 @@ const char *const powerpc_triplets[] = {
 	NULL
 };
 
+const char *const riscv32_triplets[] = {
+	"riscv32-unknown-linux-gnu-",
+	"riscv32-linux-android-",
+	"riscv32-linux-gnu-",
+	NULL
+};
+
+const char *const riscv64_triplets[] = {
+	"riscv64-unknown-linux-gnu-",
+	"riscv64-linux-android-",
+	"riscv64-linux-gnu-",
+	NULL
+};
+
 const char *const s390_triplets[] = {
 	"s390-ibm-linux-",
 	"s390x-linux-gnu-",
@@ -168,6 +182,10 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		path_list = powerpc_triplets;
 	else if (!strcmp(arch, "sh"))
 		path_list = sh_triplets;
+	else if (!strcmp(arch, "riscv32"))
+		path_list = riscv32_triplets;
+	else if (!strcmp(arch, "riscv64"))
+		path_list = riscv64_triplets;
 	else if (!strcmp(arch, "s390"))
 		path_list = s390_triplets;
 	else if (!strcmp(arch, "sparc"))
-- 
2.34.1

