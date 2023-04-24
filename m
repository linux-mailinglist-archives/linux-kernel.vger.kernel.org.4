Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41FC6D13F5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCaAUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaAU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:20:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE1312CE3;
        Thu, 30 Mar 2023 17:19:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kc4so19704285plb.10;
        Thu, 30 Mar 2023 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680221885; x=1682813885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjnFvVF+FOS6EOnQPMD9dOZfjJDVnvpVeRajQigpjns=;
        b=UTd0iBah0+coeAuBT+dAUyXvXWcyjJcNi/m8NIDNOzFy8ZO1tZLvUhyl2Gr5a64cVx
         O1LGhODXXDmJvvlBzuDXMqZp29lCqBBXr8EUUGcZE2cueYLIv4ReN7OR2WeE6STj7QWA
         E0SXy6WOC3EhuziBak6OGCDoBCOv1yidmrz0uD6Oz1vOs9DLvaIf+jGMDS776WwVrLe8
         LleUngPFZjH7j2cMoYbfMMh4ObaZadIBcqyRuuQMhdWOFfkz1XLAPztdy6P7Oznk0lpO
         XSsNm1VOaoIHSr3IRuOpXrlngIbTeymxjGMCBXkSpouyKdKckBhQANwdS7SfrW31PIqE
         kVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680221885; x=1682813885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjnFvVF+FOS6EOnQPMD9dOZfjJDVnvpVeRajQigpjns=;
        b=NBnebYRE2hKFcxl4wlB5LDPHQLxKK5ZaDobjvEUIo01tj8+b0jD7QPyPO3BvuSFsHm
         2O8/dxoQwqh4lI3qahDmH04YCldhgcXyAcETU0jl3b5TaVF2G0pfw8SXdM5V0i1ohaZ+
         gLbViDjwF83whQsGBV55cLU9zxjmgguigfiF3qT/ecFv2yTeuiO0hMZJkoyCeAHkuJIL
         5Mkz2yqT7k9wev6IKRJfY+6LRUBs3zOHMLuX9gvd/mwfLdZtF6htHOdXmgCvzQq9U3Cq
         lpPSYZKek6zSrjvIn4KPuSr24nSzuR2gePtPbMYPE0eP3HCAY7ZErRQDUUbfF1mHdPxl
         70Cw==
X-Gm-Message-State: AAQBX9eUcop6F0hO0kBmKZR9MP8RcBNwa1hZ5pwnAjZdN8I43jQdgDKh
        tPggBLhwptGjXR6SFZD26Ls=
X-Google-Smtp-Source: AKy350aUpMe2Oba774PHhZWiIs4Kpj5S0LkhFv6tlX8qHcRc0A5maN8iAgLsN5GAP2s8H5Y2bps9fA==
X-Received: by 2002:a17:903:2312:b0:1a1:a6e5:764b with SMTP id d18-20020a170903231200b001a1a6e5764bmr33545679plh.60.1680221884970;
        Thu, 30 Mar 2023 17:18:04 -0700 (PDT)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a06eb43880sm277692pld.153.2023.03.30.17.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:18:04 -0700 (PDT)
Date:   Thu, 30 Mar 2023 17:18:03 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v13 016/113] KVM: TDX: x86: Add ioctl to get TDX
 systemwide parameters
Message-ID: <20230331001803.GE1112017@ls.amr.corp.intel.com>
References: <cover.1678643051.git.isaku.yamahata@intel.com>
 <cb0ae8b4941aaa45e1e5856dde644f9b2f53d9a6.1678643052.git.isaku.yamahata@intel.com>
 <20230325104306.00004585@gmail.com>
 <20230329231722.GA1108448@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329231722.GA1108448@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 04:17:22PM -0700,
Isaku Yamahata <isaku.yamahata@gmail.com> wrote:

> On Sat, Mar 25, 2023 at 10:43:06AM +0200,
> Zhi Wang <zhi.wang.linux@gmail.com> wrote:
> 
> > On Sun, 12 Mar 2023 10:55:40 -0700
> > isaku.yamahata@intel.com wrote:
> > 
> > Does this have to be a new generic ioctl with a dedicated new x86_ops? SNP
> > does not use it at all and all the system-scoped ioctl of SNP going through
> > the CCP driver. So getting system-scope information of TDX/SNP will end up
> > differently.
> > 
> > Any thought, Sean? Moving getting SNP system-wide information to
> > KVM dev ioctl seems not ideal and TDX does not have a dedicated driver like
> > CCP. Maybe make this ioctl TDX-specific? KVM_TDX_DEV_OP?
> 
> We only need global parameters of the TDX module, and we don't interact with TDX
> module at this point.  One alternative is to export those parameters via sysfs.
> Also the existence of the sysfs node indicates that the TDX module is
> loaded(initialized?) or not in addition to boot log.  Thus we can drop system
> scope one.
> What do you think?
> 
> Regarding to other TDX KVM specific ioctls (KVM_TDX_INIT_VM, KVM_TDX_INIT_VCPU,
> KVM_TDX_INIT_MEM_REGION, and KVM_TDX_FINALIZE_VM), they are specific to KVM.  So
> I don't think it can be split out to independent driver.

Here is the patch to export those info via sysfs.

From e0744e506eb92e47d8317e489945a3ba804edfa7 Mon Sep 17 00:00:00 2001
Message-Id: <e0744e506eb92e47d8317e489945a3ba804edfa7.1680221730.git.isaku.yamahata@intel.com>
In-Reply-To: <8e0bc0e8e5d435f54f10c7642a862629ef2acb89.1680221729.git.isaku.yamahata@intel.com>
References: <8e0bc0e8e5d435f54f10c7642a862629ef2acb89.1680221729.git.isaku.yamahata@intel.com>
From: Isaku Yamahata <isaku.yamahata@intel.com>
Date: Thu, 30 Mar 2023 00:05:03 -0700
Subject: [PATCH] x86/virt/tdx: Export TD config params of TDX module via sysfs

TDX module has parameters for VMM to configure TD.  User space VMM, e.g.
qemu, needs to know it. Export them to user space via sysfs.

TDX 1.0 provides TDH.SYS.INFO to provide system information in
TDSYSINFO_STRUCT.  Its future extensibility is limited because of its
struct.  From TDX 1.5, TDH.SYS.RD(metadata field_id) to read the info
specified by field id.  So instead of exporting TDSYSINFO_STRUCT, adapt
metadata way to export those system information.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-tdx |  23 +++
 arch/x86/include/asm/tdx.h                   |  33 ++++
 arch/x86/virt/vmx/tdx/tdx.c                  | 164 +++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h                  |  18 ++
 4 files changed, 238 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-tdx

diff --git a/Documentation/ABI/testing/sysfs-firmware-tdx b/Documentation/ABI/testing/sysfs-firmware-tdx
new file mode 100644
index 000000000000..1f26fb178144
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-tdx
@@ -0,0 +1,23 @@
+What:           /sys/firmware/tdx/tdx_module/metadata
+Date:           March 2023
+KernelVersion:  6.3
+Contact:        Isaku Yamahata <isaku.yamahata@intel.com>, kvm@vger.kernel.org
+Users:          qemu, libvirt
+Description:
+                The TDX feature requires a firmware that is known as the TDX
+                module.  The TDX module exposes its metadata in the following
+                read-only files.  The information corresponds to the TDX global
+                metadata specified by 64bit field id.  The file name is hex
+                string in lower case.  The value is binary.
+                User space VMM like qemu needs refer to them to determine what
+                parameters are needed or allowed to configure guest TDs.
+
+                ================== ============================================
+                1900000300000000   ATTRIBUTES_FIXED0
+                1900000300000001   ATTRIBUTES_FIXED1
+                1900000300000002   XFAM_FIXED0
+                1900000300000003   XFAM_FIXED1
+                9900000100000004   NUM_CPUID_CONFIG
+                9900000300000400   CPUID_LEAVES
+                9900000300000500   CPUID_VALUES
+                ================== ============================================
\ No newline at end of file
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 05870e5ed131..c650ac22a916 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -110,6 +110,39 @@ struct tdx_cpuid_config {
 	u32	edx;
 } __packed;
 
+struct tdx_cpuid_config_leaf {
+	u32	leaf;
+	u32	sub_leaf;
+} __packed;
+static_assert(offsetof(struct tdx_cpuid_config, leaf) ==
+	      offsetof(struct tdx_cpuid_config_leaf, leaf));
+static_assert(offsetof(struct tdx_cpuid_config, sub_leaf) ==
+	      offsetof(struct tdx_cpuid_config_leaf, sub_leaf));
+static_assert(offsetofend(struct tdx_cpuid_config, sub_leaf) ==
+	      sizeof(struct tdx_cpuid_config_leaf));
+
+struct tdx_cpuid_config_value {
+	u32	eax;
+	u32	ebx;
+	u32	ecx;
+	u32	edx;
+} __packed;
+static_assert(offsetof(struct tdx_cpuid_config, eax) -
+	      offsetof(struct tdx_cpuid_config, eax) ==
+	      offsetof(struct tdx_cpuid_config_value, eax));
+static_assert(offsetof(struct tdx_cpuid_config, ebx) -
+	      offsetof(struct tdx_cpuid_config, eax) ==
+	      offsetof(struct tdx_cpuid_config_value, ebx));
+static_assert(offsetof(struct tdx_cpuid_config, ecx) -
+	      offsetof(struct tdx_cpuid_config, eax) ==
+	      offsetof(struct tdx_cpuid_config_value, ecx));
+static_assert(offsetof(struct tdx_cpuid_config, edx) -
+	      offsetof(struct tdx_cpuid_config, eax) ==
+	      offsetof(struct tdx_cpuid_config_value, edx));
+static_assert(offsetofend(struct tdx_cpuid_config, edx) -
+	      offsetof(struct tdx_cpuid_config, eax) ==
+	      sizeof(struct tdx_cpuid_config_value));
+
 #define TDSYSINFO_STRUCT_SIZE		1024
 #define TDSYSINFO_STRUCT_ALIGNMENT	1024
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index f9f9c1b76501..56ca520d67d6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -33,6 +33,12 @@
 #include <asm/tdx.h>
 #include "tdx.h"
 
+#ifdef CONFIG_SYSFS
+static int tdx_sysfs_init(void);
+#else
+static inline int tdx_sysfs_init(void) { return 0;}
+#endif
+
 u32 tdx_global_keyid __ro_after_init;
 EXPORT_SYMBOL_GPL(tdx_global_keyid);
 static u32 tdx_guest_keyid_start __ro_after_init;
@@ -399,6 +405,10 @@ static int __tdx_get_sysinfo(struct tdsysinfo_struct *sysinfo,
 	if (ret)
 		return ret;
 
+	ret = tdx_sysfs_init();
+	if (ret)
+		return ret;
+
 	pr_info("TDX module: atributes 0x%x, vendor_id 0x%x, major_version %u, minor_version %u, build_date %u, build_num %u",
 		sysinfo->attributes,	sysinfo->vendor_id,
 		sysinfo->major_version, sysinfo->minor_version,
@@ -1367,3 +1377,157 @@ int tdx_enable(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(tdx_enable);
+
+#ifdef CONFIG_SYSFS
+
+static struct kobject *tdx_kobj;
+static struct kobject *tdx_module_kobj;
+static struct kobject *tdx_metadata_kobj;
+
+#define TDX_METADATA_ATTR(_name, field_id_name, _size)		\
+static struct bin_attribute tdx_metadata_ ## _name = {		\
+	.attr = {						\
+		.name = field_id_name,				\
+		.mode = 0444,					\
+	},							\
+	.size = _size,						\
+	.read = tdx_metadata_ ## _name ## _show,		\
+}
+
+#define TDX_METADATA_ATTR_SHOW(_name, field_id_name)					\
+static ssize_t tdx_metadata_ ## _name ## _show(struct file *filp, struct kobject *kobj,	\
+					       struct bin_attribute *bin_attr,		\
+					       char *buf, loff_t offset, size_t count)	\
+{											\
+	struct tdsysinfo_struct *sysinfo = &PADDED_STRUCT(tdsysinfo);			\
+											\
+	return memory_read_from_buffer(buf, count, &offset,				\
+				       &sysinfo->_name,					\
+				       sizeof(sysinfo->_name));				\
+}											\
+TDX_METADATA_ATTR(_name, field_id_name, sizeof_field(struct tdsysinfo_struct, _name))
+
+TDX_METADATA_ATTR_SHOW(attributes_fixed0, TDX_METADATA_ATTRIBUTES_FIXED0_NAME);
+TDX_METADATA_ATTR_SHOW(attributes_fixed1, TDX_METADATA_ATTRIBUTES_FIXED1_NAME);
+TDX_METADATA_ATTR_SHOW(xfam_fixed0, TDX_METADATA_XFAM_FIXED0_NAME);
+TDX_METADATA_ATTR_SHOW(xfam_fixed1, TDX_METADATA_XFAM_FIXED1_NAME);
+
+static ssize_t tdx_metadata_num_cpuid_config_show(struct file *filp, struct kobject *kobj,
+						  struct bin_attribute *bin_attr,
+						  char *buf, loff_t offset, size_t count)
+{
+	struct tdsysinfo_struct *sysinfo = &PADDED_STRUCT(tdsysinfo);
+	/*
+	 * Although tdsysinfo_struct.num_cpuid_config is defined as u32 for
+	 * alignment, TDX 1.5 defines metadata NUM_CONFIG_CPUID as u16.
+	 */
+	u16 tmp = (u16)sysinfo->num_cpuid_config;
+
+	WARN_ON_ONCE(tmp != sysinfo->num_cpuid_config);
+	return memory_read_from_buffer(buf, count, &offset, &tmp, sizeof(tmp));
+}
+TDX_METADATA_ATTR(num_cpuid_config, TDX_METADATA_NUM_CPUID_CONFIG_NAME, sizeof(u16));
+
+static ssize_t tdx_metadata_cpuid_leaves_show(struct file *filp, struct kobject *kobj,
+					      struct bin_attribute *bin_attr, char *buf,
+					      loff_t offset, size_t count)
+{
+	struct tdsysinfo_struct *sysinfo = &PADDED_STRUCT(tdsysinfo);
+	ssize_t r;
+	struct tdx_cpuid_config_leaf *tmp;
+	u32 i;
+
+	tmp = kmalloc(bin_attr->size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	for (i = 0; i < sysinfo->num_cpuid_config; i++) {
+		struct tdx_cpuid_config *c = &sysinfo->cpuid_configs[i];
+		struct tdx_cpuid_config_leaf *leaf = (struct tdx_cpuid_config_leaf *)c;
+
+		memcpy(tmp + i, leaf, sizeof(*leaf));
+	}
+
+	r = memory_read_from_buffer(buf, count, &offset, tmp, bin_attr->size);
+	kfree(tmp);
+	return r;
+}
+
+TDX_METADATA_ATTR(cpuid_leaves, TDX_METADATA_CPUID_LEAVES_NAME, 0);
+
+static ssize_t tdx_metadata_cpuid_values_show(struct file *filp, struct kobject *kobj,
+					      struct bin_attribute *bin_attr, char *buf,
+					      loff_t offset, size_t count)
+{
+	struct tdsysinfo_struct *sysinfo = &PADDED_STRUCT(tdsysinfo);
+	struct tdx_cpuid_config_value *tmp;
+	ssize_t r;
+	u32 i;
+
+	tmp = kmalloc(bin_attr->size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	for (i = 0; i < sysinfo->num_cpuid_config; i++) {
+		struct tdx_cpuid_config *c = &sysinfo->cpuid_configs[i];
+		struct tdx_cpuid_config_value *value = (struct tdx_cpuid_config_value *)&c->eax;
+
+		memcpy(tmp + i, value, sizeof(*value));
+	}
+
+	r = memory_read_from_buffer(buf, count, &offset, tmp, bin_attr->size);
+	kfree(tmp);
+	return r;
+}
+
+TDX_METADATA_ATTR(cpuid_values, TDX_METADATA_CPUID_VALUES_NAME, 0);
+
+static struct bin_attribute *tdx_metadata_attrs[] = {
+	&tdx_metadata_attributes_fixed0,
+	&tdx_metadata_attributes_fixed1,
+	&tdx_metadata_xfam_fixed0,
+	&tdx_metadata_xfam_fixed1,
+	&tdx_metadata_num_cpuid_config,
+	&tdx_metadata_cpuid_leaves,
+	&tdx_metadata_cpuid_values,
+	NULL,
+};
+
+static const struct attribute_group tdx_metadata_attr_group = {
+	.bin_attrs = tdx_metadata_attrs,
+};
+
+static int tdx_sysfs_init(void)
+{
+	struct tdsysinfo_struct *sysinfo;
+	int ret;
+
+	tdx_kobj = kobject_create_and_add("tdx", firmware_kobj);
+	if (!tdx_kobj) {
+		pr_err("kobject_create_and_add tdx failed\n");
+		return -EINVAL;
+	}
+
+	tdx_module_kobj = kobject_create_and_add("tdx_module", tdx_kobj);
+	if (!tdx_module_kobj) {
+		pr_err("kobject_create_and_add tdx_module failed\n");
+		return -EINVAL;
+	}
+	tdx_metadata_kobj = kobject_create_and_add("metadata", tdx_module_kobj);
+	if (!tdx_metadata_kobj) {
+		pr_err("Sysfs exporting tdx global metadata failed %d\n", ret);
+		return -EINVAL;
+	}
+
+	sysinfo = &PADDED_STRUCT(tdsysinfo);
+	tdx_metadata_cpuid_leaves.size = sysinfo->num_cpuid_config *
+		sizeof(struct tdx_cpuid_config_leaf);
+	tdx_metadata_cpuid_values.size = sysinfo->num_cpuid_config *
+		sizeof(struct tdx_cpuid_config_value);
+	ret = sysfs_create_group(tdx_metadata_kobj, &tdx_metadata_attr_group);
+	if (ret)
+		pr_err("Sysfs exporting tdx module attributes failed %d\n", ret);
+
+	return ret;
+}
+#endif
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index db0cbcceb5b3..a48f38fe6cc4 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -93,4 +93,22 @@ struct tdmr_info_list {
 	int max_tdmrs;	/* How many 'tdmr_info's are allocated */
 };
 
+/* TDX metadata base field id. */
+#define TDX_METADATA_ATTRIBUTES_FIXED0		0x1900000300000000ULL
+#define TDX_METADATA_ATTRIBUTES_FIXED1		0x1900000300000001ULL
+#define TDX_METADATA_XFAM_FIXED0		0x1900000300000002ULL
+#define TDX_METADATA_XFAM_FIXED1		0x1900000300000003ULL
+#define TDX_METADATA_NUM_CPUID_CONFIG		0x9900000100000004ULL
+#define TDX_METADATA_CPUID_LEAVES		0x9900000300000400ULL
+#define TDX_METADATA_CPUID_VALUES		0x9900000300000500ULL
+
+/* File name for sysfs: hex with lower case. */
+#define TDX_METADATA_ATTRIBUTES_FIXED0_NAME	"1900000300000000"
+#define TDX_METADATA_ATTRIBUTES_FIXED1_NAME	"1900000300000001"
+#define TDX_METADATA_XFAM_FIXED0_NAME		"1900000300000002"
+#define TDX_METADATA_XFAM_FIXED1_NAME		"1900000300000003"
+#define TDX_METADATA_NUM_CPUID_CONFIG_NAME	"9900000100000004"
+#define TDX_METADATA_CPUID_LEAVES_NAME		"9900000300000400"
+#define TDX_METADATA_CPUID_VALUES_NAME		"9900000300000500"
+
 #endif
-- 
2.25.1



-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
