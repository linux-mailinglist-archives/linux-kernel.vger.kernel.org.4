Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F26C42F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCVGTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCVGTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:19:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF6E59823
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:19:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso22678416pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679465967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jc51COu0/vb2WtPcXns+ijC7xX+URRIqs+FR67VjlYA=;
        b=qZtyFC84Al62Sso4KsjHcPRvpZkBY6BavXqrs+ZH4zNQ2woVOYXp2bMeKRP8mADppq
         lGoZECsOFIfmiDIScrAeY1PXzkOqQLjOWOklE4tyYZ/MH1hQXP5BFj2SDCFPsK21XkIE
         yaYI7ZYmrTBzrBuPr2Myy6bjpvoNN8Vl6/TdJ443fYwd+s+ObXMDKWFGZuVFwRLip+fU
         mCaqMLReN07NXdDGuR5DY95n9hrcZfZCB3rGZkViKwgtbJrGPsk+ILA4MAdR5NSbIVfa
         DcihQfMxzVCW3zTkVtXmPWbCvLpvHNAWzyBL89Hloas1Rav96hDLYGw9W0IZJ/Dpi5dm
         XXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679465967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jc51COu0/vb2WtPcXns+ijC7xX+URRIqs+FR67VjlYA=;
        b=cULxo/yqH8+LH4Tiwa4Z79nfpSfjkc3HJ1EWRhpLeASJxlAz4I9A0VLxtwJexc1hp4
         LhatV4BFB1OBEBvwefxlVEuxQzLS8j0qJ3wQFJfQZ8JjjECJkV3R7wM5gFtGxqhihkL6
         Vui309LYBBm0tScx9VmC356BRJme6xrwvzAKr1KWTGLaOUvifnJEQjfeO4HNxBN8Ddet
         jOCf4Z7pe+PklVla4SQwKzBYz04KGmC7lxiJqzueUIOdEkKjsjtguQBjDKkD/KTjxJBr
         FTdWTgaKx4AAW66oWOnhqoi3yMQEelWaaxy/BP5cSkkEvTMMJNhdHfOh359S7xPhLBE7
         /laA==
X-Gm-Message-State: AO0yUKWZ9bx4uNrivFMXOK/aLSdEXijParPuBY0Nqmzq3RDlkpC2WSkg
        nplq9c+GMZxQdrRYQDFosa0=
X-Google-Smtp-Source: AK7set9aeuGYwThhMZ+VFuX1iBJaOqFLd8r6mEH8v8V8V1hkznxp2niK+mrhEwJycH4r/ihwVIrNZg==
X-Received: by 2002:a05:6a20:cc5f:b0:db:9a60:a52d with SMTP id hq31-20020a056a20cc5f00b000db9a60a52dmr29000pzb.41.1679465966916;
        Tue, 21 Mar 2023 23:19:26 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id j24-20020a62e918000000b006258dd63a3fsm9232369pfh.56.2023.03.21.23.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:19:26 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [RFC PATCH] riscv: export cpu/freq invariant to scheduler
Date:   Wed, 22 Mar 2023 14:18:56 +0800
Message-Id: <20230322061856.2774840-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V now manages CPU topology using arch_topology which provides
CPU capacity and frequency related interfaces to access the cpu/freq
invariant in possible heterogeneous or DVFS-enabled platforms.

Here adds topology.h file to export the arch_topology interfaces for
replacing the scheduler's constant-based cpu/freq invariant accounting.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/include/asm/topology.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/riscv/include/asm/topology.h

diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
new file mode 100644
index 000000000000..14bbd2472af6
--- /dev/null
+++ b/arch/riscv/include/asm/topology.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RISCV_TOPOLOGY_H
+#define __ASM_RISCV_TOPOLOGY_H
+
+#include <linux/arch_topology.h>
+
+/* Replace task scheduler's default frequency-invariant accounting */
+#define arch_scale_freq_tick topology_scale_freq_tick
+#define arch_set_freq_scale topology_set_freq_scale
+#define arch_scale_freq_capacity topology_get_freq_scale
+#define arch_scale_freq_invariant topology_scale_freq_invariant
+
+/* Replace task scheduler's default cpu-invariant accounting */
+#define arch_scale_cpu_capacity topology_get_cpu_scale
+#define arch_update_cpu_topology topology_update_cpu_topology
+
+
+#include <asm-generic/topology.h>
+#endif /* __ASM_RISCV_TOPOLOGY_H */
-- 
2.20.1

