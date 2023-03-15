Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5A6BA6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCOFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjCOFTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:19:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5759C64851;
        Tue, 14 Mar 2023 22:16:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n16so4881060pfa.12;
        Tue, 14 Mar 2023 22:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678857345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85u2mP267MsDWaYI2anR0VTKt7dL+xKQUjJLVotEHs4=;
        b=gBap95uEBpqian2RBARTrUhbt/kKcSUXiSo5c7Duq2LsgHsJd7sdPPRFiFg1axqEcx
         LCEFgPx4s/l6A65imFaWZtjeJ9PYLAon3RKjoOlwq50YBEm/FikgnG8vlR6/pgNyWaVm
         iUN0iCRDvqZzEzTi215AXkU5Fxb833GIShXRKYfuOxbeaLqRanNK5+oUDbdpif7kdJ+j
         +/cPDEjjw3PAjywDo0XsFGrDw+DOyzfVWoJfaBf9LtEA13/OQSUQF9Usn6szyjPME+L/
         UcdSXy/53dTBtT/b6TWWxp/bKilr/mflre5QrDHlMp8h885ORIa5iS0l1bJMOCQkRi9K
         aFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678857345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85u2mP267MsDWaYI2anR0VTKt7dL+xKQUjJLVotEHs4=;
        b=6IPjcmvTFPsRKi471HyzO/d+EcYG1M3qHJOxlazq90agO0cnVHPdjfeS8yEGDlsVFE
         MNzrT/3sAkTnKU+7Z9FGMSfU9IWMTPsNJZSMCu0QwBH88C1XNeoeTETh5n7ufRPnlT/j
         SCmPOzNlXVJ+u384Yz/1p5ISeY/8sJ1Bcg9GN36kWk0p2jaXnIcgm+HTXOyNntU2vrh9
         rkxRHvgQNGXkN6Fv1mDQHxxi2EEEZczFEeJ6NdOnKQ8ewibZTFJN3XJdaoYV6EeJmIQS
         +0qi5N8TTkOsAClCaP7p/fA3hO9DSzrGu9etktcUzAp8JXSbIJ26QJnPvloQJY+nrI7+
         Oy/w==
X-Gm-Message-State: AO0yUKV1iR3HEsYazyzG2ODx10FsaoJrE0UIFe9jLO1sKGupLu0obEds
        jeSYFCbybWQ0S1X4J2+01I0=
X-Google-Smtp-Source: AK7set/qpV14jNC8aoJAxGYlBsaChSOHlujZd1EeVD7OBA4G2dFhCb+/fwJ/AIoqn083Mq9weK9KRQ==
X-Received: by 2002:a62:3814:0:b0:623:c7ff:46c8 with SMTP id f20-20020a623814000000b00623c7ff46c8mr10052331pfa.1.1678857345006;
        Tue, 14 Mar 2023 22:15:45 -0700 (PDT)
Received: from kim-GL702ZC.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id z64-20020a636543000000b004e28be19d1csm2442903pgb.32.2023.03.14.22.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 22:15:44 -0700 (PDT)
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
Subject: [PATCH v2] perf tools riscv: Add support for riscv lookup_binutils_path
Date:   Wed, 15 Mar 2023 14:15:01 +0900
Message-Id: <20230315051500.13064-1-p4ranlee@gmail.com>
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

Add RISC-V binutils path on lookup triplets.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 tools/perf/arch/common.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 59dd875fd5e4..e80d4d22cabf 100644
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
@@ -166,6 +180,10 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		path_list = arm64_triplets;
 	else if (!strcmp(arch, "powerpc"))
 		path_list = powerpc_triplets;
+	else if (!strcmp(arch, "riscv32"))
+		path_list = riscv32_triplets;
+	else if (!strcmp(arch, "riscv64"))
+		path_list = riscv64_triplets;
 	else if (!strcmp(arch, "sh"))
 		path_list = sh_triplets;
 	else if (!strcmp(arch, "s390"))
-- 
2.34.1

