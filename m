Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF466C6899
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjCWMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCWMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:40:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2E2726
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:40:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso3249977pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l22jS9A4e1C/PCC1oUu93RwDdLyt3Y018WPXLhkvBHA=;
        b=jo/4TaIRmx15peiBHkAs34j7i9MfuA6ulwk8L4eFd46BeEq/UACAl7ur4XobFxYxqm
         vYPhTQupqDgk//JXCHYIgtFNcRNgK8984bpEcAj4xT1/i0Uidlb2VnhSI5X5+zeBMGoX
         QhqP/YfqsVQnge3umd/k1jYHGgonQ5rdXwZscjym6MvCLlVn3wIA99RY54buU7+m174Z
         gWF2wvfRgzPkA+dRhoWfOmJpuq9jiTVZOlz8Lo6mNlYDK4f0D+jsE2R45NNHyzsv2x+n
         O34PLUM2wS6fMAxQWMsHNzIoLNqNdta8fpGCZlnYPnz1xy33N+AgFXveeTkX+aQV/K1/
         oQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l22jS9A4e1C/PCC1oUu93RwDdLyt3Y018WPXLhkvBHA=;
        b=ogKbbLcGKvRnnzI6cih7qpBVU169suhnKnwLq3gZOjbSLBFCxlx2ygmlWiAGc3W3lj
         PjI8cxD4sLzmIUtTMaH68H23LVd1ZGxEiA2BntLywkEQOWKpLsvZxV0uH0LqTrnLKN8X
         VyEp9B02OFoSKjRwlZBkTlqUxYTUP7u0fSDwFGg/w2RDIo1gNlM2nH3DYTeUzQZAiR18
         Bi534VhA2EiHrhSA5UJOg5SgMpwQfjfpYVOCNtbUOGIRwfCUnYVKRB/AuzSlIYlHgpkj
         nSOErthCgSlYD2UFxUHRw5NgNFDi9cv24LPNcd3yRQjKia2bOh5ukXTMupeuhid+686n
         T3RQ==
X-Gm-Message-State: AO0yUKUqub3lvEzkdQm3wYGIZtICWX5hraddOvBw/HxlmSN4/WpTKPyR
        bLCeIGjIesiAsVzzGgtNG28=
X-Google-Smtp-Source: AK7set9Isx1m4iVIIeq2lRufLyOFJqOrT7oZL8Y87oohW5hymb0XXvr7/mDzkpyIOwAWmhqDS/a4Ag==
X-Received: by 2002:a17:903:2301:b0:1a1:8fd4:251 with SMTP id d1-20020a170903230100b001a18fd40251mr6415378plh.55.1679575226931;
        Thu, 23 Mar 2023 05:40:26 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902744600b0019ac23cb6edsm12219749plt.181.2023.03.23.05.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:40:26 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH V2] riscv: export cpu/freq invariant to scheduler
Date:   Thu, 23 Mar 2023 20:39:24 +0800
Message-Id: <20230323123924.3032174-1-suagrfillet@gmail.com>
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
changes from V1:
  - fix the leading underscore and tidy the patch up 
---
 arch/riscv/include/asm/topology.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/riscv/include/asm/topology.h

diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
new file mode 100644
index 000000000000..727e8d163a3b
--- /dev/null
+++ b/arch/riscv/include/asm/topology.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_TOPOLOGY_H
+#define _ASM_RISCV_TOPOLOGY_H
+
+#include <linux/arch_topology.h>
+
+/* Replace task scheduler's default frequency-invariant accounting */
+#define arch_scale_freq_tick	topology_scale_freq_tick
+#define arch_set_freq_scale	topology_set_freq_scale
+#define arch_scale_freq_capacity	topology_get_freq_scale
+#define arch_scale_freq_invariant	topology_scale_freq_invariant
+
+/* Replace task scheduler's default cpu-invariant accounting */
+#define arch_scale_cpu_capacity	topology_get_cpu_scale
+
+/* Enable topology flag updates */
+#define arch_update_cpu_topology	topology_update_cpu_topology
+
+#include <asm-generic/topology.h>
+#endif /* _ASM_RISCV_TOPOLOGY_H */
-- 
2.20.1

