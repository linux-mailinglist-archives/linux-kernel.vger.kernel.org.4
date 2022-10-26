Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB45D60E7DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiJZTAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiJZS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:59:40 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1102E114A;
        Wed, 26 Oct 2022 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666810779; x=1698346779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s5typUUdhXFp1GKE5UGm4GuEmmY0sum1RlFlPPqo1JA=;
  b=G02k/YxDdqLS2w8W7Jf0MZaSoag+xci2C07bpVqaiULbV3FujVcE92x1
   Na/WPBk/GCL/nryza3LRZdhLr9PDAfmv2TpxL1rMd3dtD+WqVre05/5Ge
   DdQ3apZ89KK0+jIW4G40jBcXhgTPkgAvw7wyn2td1KmARFvjEomnx+ejK
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Oct 2022 11:59:39 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 11:59:38 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:37 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 18/21] gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
Date:   Wed, 26 Oct 2022 11:58:43 -0700
Message-ID: <20221026185846.3983888-19-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm platforms, there is a firmware entity which controls access
to physical pages. In order to share memory with another VM, this entity
needs to be informed that the guest VM should have access to the memory.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/rsc_mgr.c     | 52 +++++++++++++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h     |  3 ++
 drivers/virt/gunyah/rsc_mgr_rpc.c |  7 +++++
 include/linux/gunyah_rsc_mgr.h    | 12 ++++++-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index f2f776edecb8..6e590f2a8cfa 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -105,6 +105,13 @@ struct gh_rsc_mgr {
 static struct gh_rsc_mgr *__rsc_mgr;
 SRCU_NOTIFIER_HEAD_STATIC(gh_rm_notifier);
 
+/* Needs to be out of the gh_rsc_mgr struct as platform_ops might probe before
+ * rsc mgr probes. We can't defer the platform_ops because it might be that
+ * Linux is not a Gunyah guest.
+ */
+static struct gunyah_rm_platform_ops *rm_platform_ops;
+static DECLARE_RWSEM(rm_platform_ops_lock);
+
 static struct gh_rm_connection *gh_rm_alloc_connection(u32 msg_id, u8 type)
 {
 	struct gh_rm_connection *connection;
@@ -498,6 +505,51 @@ int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
 	return ret;
 }
 
+int gh_rm_platform_pre_mem_share(struct gh_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_mem_share)
+		ret = rm_platform_ops->pre_mem_share(mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+
+int gh_rm_platform_post_mem_reclaim(struct gh_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->post_mem_reclaim)
+		ret = rm_platform_ops->post_mem_reclaim(mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+
+int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
+{
+	int ret = 0;
+
+	down_write(&rm_platform_ops_lock);
+	if (!rm_platform_ops)
+		rm_platform_ops = platform_ops;
+	else
+		ret = -EEXIST;
+	up_write(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_register_platform_ops);
+
+void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
+{
+	down_write(&rm_platform_ops_lock);
+	if (rm_platform_ops == platform_ops)
+		rm_platform_ops = NULL;
+	up_write(&rm_platform_ops_lock);
+}
+EXPORT_SYMBOL_GPL(gh_rm_unregister_platform_ops);
+
 int gh_rm_register_notifier(struct notifier_block *nb)
 {
 	return srcu_notifier_chain_register(&gh_rm_notifier, nb);
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index f6ed58405ef4..49becf82edf7 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -130,6 +130,9 @@ struct gh_vm_set_boot_context_req {
 int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
+int gh_rm_platform_pre_mem_share(struct gh_rm_mem_parcel *mem_parcel);
+int gh_rm_platform_post_mem_reclaim(struct gh_rm_mem_parcel *mem_parcel);
+
 struct gh_rm_device {
 	struct device dev;
 	const char *name;
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index 17f88c3d5726..c7e3bb975640 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -120,6 +120,10 @@ static int gh_rm_mem_lend_common(u32 message_id, struct gh_rm_mem_parcel *p)
 	if (initial_n_mem_entries > GH_RM_MAX_MEM_ENTRIES)
 		initial_n_mem_entries = GH_RM_MAX_MEM_ENTRIES;
 
+	ret = gh_rm_platform_pre_mem_share(p);
+	if (ret)
+		return ret;
+
 	/* The format of the message goes:
 	 * request header
 	 * ACL entries (which VMs get what kind of access to this memory parcel)
@@ -163,6 +167,7 @@ static int gh_rm_mem_lend_common(u32 message_id, struct gh_rm_mem_parcel *p)
 
 	if (resp_size != sizeof(u32)) {
 		ret = -EIO;
+		gh_rm_platform_post_mem_reclaim(p);
 		goto out;
 	}
 
@@ -234,6 +239,8 @@ int gh_rm_mem_reclaim(struct gh_rm_mem_parcel *parcel)
 	if (resp_size)
 		pr_warn("Received unexpected payload for MEM_RECLAIM: %lu\n", resp_size);
 
+	ret = gh_rm_platform_post_mem_reclaim(parcel);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(gh_rm_mem_reclaim);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 78d516032f6a..6e5e67e96688 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -119,7 +119,6 @@ struct gh_rm_hyp_resource {
 } __packed;
 
 ssize_t gh_rm_get_hyp_resources(u16 vmid, struct gh_rm_hyp_resource **resources);
-int gh_rm_get_vmid(u16 *vmid);
 
 #define GH_RM_BOOT_CONTEXT_REG_SET_REGISTERS	0
 #define GH_RM_BOOT_CONTEXT_REG_SET_PC		1
@@ -143,4 +142,15 @@ void gh_rm_driver_unregister(struct gh_rm_driver *ghrm_drv);
 #define module_gh_rm_driver(ghrm_drv) \
 	module_driver(ghrm_drv, gh_rm_driver_register, gh_rm_driver_unregister)
 
+#if IS_ENABLED(CONFIG_GUNYAH)
+int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
+void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
+int gh_rm_get_vmid(u16 *vmid);
+#else
+static inline int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
+	{ return 0; }
+static inline void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops) { }
+static inline int gh_rm_get_vmid(u16 *vmid) { return -ENODEV; }
+#endif
+
 #endif
-- 
2.25.1

