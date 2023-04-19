Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D806E782F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjDSLLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjDSLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BF7A88
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso2689620b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902617; x=1684494617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmVkd/UrXriHJHxvxxsPlqAajEG3FYZbywzFeJQXIHk=;
        b=zPbQZG9UKwm7GRyIqZChI5pPpnjrvhb8Q5Cx0LVS9GCn0om8iAHe+VSMXHgYhN4iIE
         8hHCqRn6dwTm2nsiT9GilKXMZ1FCN5xuGY6ikI9a3/jb7VDcGrJSy6OtfIdK3QlW6N6+
         RxvuxkbB2fpmlt3qaEEq/XF6YsyaBgL3a3uLDu9C3fO+5Ry3wbbsbycb9tLDG71pLFqj
         6Ph52NPqQie9WLd/4O6LUZjHBRNlMGRcO41aMzbPqSyM/UYae08hx6DIu6+5KiIvg/BL
         iP1p9QGFXCiDa/ohQY7K8Ow0ju7miafcpNFTqcaScbcUWUl3Y1ontHOlSlMSlZHcrBr2
         V3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902617; x=1684494617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmVkd/UrXriHJHxvxxsPlqAajEG3FYZbywzFeJQXIHk=;
        b=aWnw9Z/BjF0t7W4h75rW7ho2isMU9OcrOLddU7sJlE3zFoCoMSoAGADzTSn5zQAIfT
         +bRf1pHBVYPJDmDDZQH0QtqWLoc338bNtubNXFJnfSa/gYPMS+wkPT0yr2J6TlEZ2eVZ
         A+85gPZqW/OE7mBtAcQrcLCKhchtNB6roTkVqYj9ikxH1sF1v19e0wmjsuD79EGMm8Mi
         RmyG2zm8MK5KS/DWEK+oupMwBq99PN4+G3pHZyfOgopMi6DEa8OxjsKru4h4uFFDlXQs
         0ODpBBTxeKgxkULBG8usK1cJmdvLW/3fVrZY3lFqR8kztJ8jX0VgHxxWoxbzXJ4B1OMb
         j4dw==
X-Gm-Message-State: AAQBX9cBoRhdmGwUTzPfHhgdYAs6DF4OEqgyiskKNxnlCBWpn5vBvj2h
        mcYe6l22MRzlVl69vJV1KtXI+g==
X-Google-Smtp-Source: AKy350Zyw3Ulaxp08aBwcGKciKhzrEtrdld4xIv32oyd3Jnf/nHEuPYG4H87WQ56JWkt1m7BYEv28Q==
X-Received: by 2002:a17:902:c941:b0:1a6:387a:6572 with SMTP id i1-20020a170902c94100b001a6387a6572mr6089976pla.13.1681902616795;
        Wed, 19 Apr 2023 04:10:16 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:16 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 05/21] RISC-V: QoS: define prototypes for resctrl interface
Date:   Wed, 19 Apr 2023 04:10:55 -0700
Message-Id: <20230419111111.477118-6-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the prototypes for the resctrl interface functions that are
implemented on RISC-V.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 include/linux/riscv_qos.h | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
index 95016810b575..537e503a8e99 100644
--- a/include/linux/riscv_qos.h
+++ b/include/linux/riscv_qos.h
@@ -3,6 +3,7 @@
 #ifndef __LINUX_RISCV_QOS_H
 #define __LINUX_RISCV_QOS_H
 
+#include <linux/resctrl_types.h>
 #include <linux/iommu.h>
 #include <linux/types.h>
 
@@ -31,4 +32,61 @@ struct cbqri_controller_info {
 
 extern struct list_head cbqri_controllers;
 
+bool resctrl_arch_alloc_capable(void);
+bool resctrl_arch_mon_capable(void);
+bool resctrl_arch_is_llc_occupancy_enabled(void);
+bool resctrl_arch_is_mbm_local_enabled(void);
+bool resctrl_arch_is_mbm_total_enabled(void);
+
+struct rdt_resource;
+/*
+ * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
+ *   CLOSID on x86 is RCID on RISC-V
+ *     RMID on x86 is MCID on RISC-V
+ *      CDP on x86 is AT (access type) on RISC-V
+ */
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level ignored);
+bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid);
+bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
+int  resctrl_arch_mon_ctx_alloc_no_wait(struct rdt_resource *r, int evtid);
+void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid, int ctx);
+void resctrl_arch_reset_resources(void);
+void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid);
+u32  resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid);
+int  resctrl_arch_set_cdp_enabled(enum resctrl_res_level ignored, bool enable);
+void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
+void resctrl_arch_set_cpu_default_closid(int cpu, u32 closid);
+void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 pmg);
+u32  resctrl_arch_system_num_rmid_idx(void);
+void resctrl_sched_in(void);
+
+static inline bool resctrl_arch_event_is_free_running(enum resctrl_event_id evt)
+{
+	/* must be true for resctrl L3 monitoring files to be created */
+	return true;
+}
+
+static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
+{
+	return val;
+}
+
+/* Pseudo lock is not supported on RISC-V */
+static inline int resctrl_arch_pseudo_lock_fn(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_l2_residency(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_l3_residency(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_cycles_lat_fn(void *_plr) { return 0; }
+static inline u64 resctrl_arch_get_prefetch_disable_bits(void) { return 0; }
+
+/* Not needed for RISC-V */
+bool resctrl_arch_match_iommu_closid(struct iommu_group *group, u32 closid);
+bool resctrl_arch_match_iommu_closid_rmid(struct iommu_group *group, u32 closid, u32 rmid);
+int  resctrl_arch_set_iommu_closid_rmid(struct iommu_group *group, u32 closid, u32 rmid);
+
+/* Not needed for RISC-V */
+static inline void resctrl_arch_enable_mon(void) { }
+static inline void resctrl_arch_disable_mon(void) { }
+static inline void resctrl_arch_enable_alloc(void) { }
+static inline void resctrl_arch_disable_alloc(void) { }
+
 #endif /* __LINUX_RISCV_QOS_H */
-- 
2.34.1

