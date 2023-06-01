Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39B719426
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjFAHZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjFAHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E3E18C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685604306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgH6lkMBE6SH6kwKQ2OLQdShNDxo5U5zIXrPWoXTrzY=;
        b=Ic1/+iMatjM9SMHanwDvYALW62vQLEMabsTxInIjq4qAeiwnEMmT6T4miSP0p1TAFASM+A
        JFc4w6g7stwqUdOldQQHCEOH16dVaYybE/fdexDPFeee+T8PMfOGQO2ldw408p4T0uJd9t
        37CqvX5FX62VftGPIqCzYb9wQwF7bkQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-9esEm7IFNhmHtrhKtE_vPg-1; Thu, 01 Jun 2023 03:25:05 -0400
X-MC-Unique: 9esEm7IFNhmHtrhKtE_vPg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2568caac092so105325a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604304; x=1688196304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgH6lkMBE6SH6kwKQ2OLQdShNDxo5U5zIXrPWoXTrzY=;
        b=DCip9q1FcegtiUB8eYvU0LGklsXXLSlYGi2S9YetDwABjdwAUkAmUOi0V8mqz2u+Hw
         cuIjUUN5uFfGyFfH+PLSi+G8OW/E7Rf3YvtG20QI9a/v5NbpZzrcCJdnqmbaXgdxuNSE
         mLZO69sXHkmQI+mqvnOXiY38e9YrTrJPTIyz8Gfq9Co+G3v5eVo/Bz2kRH4AMxyKOS3+
         gnu5yY0EQBOKYuxiUFEyrGsYmV12bGGk8SbS7LDVwUgsuVyMaTBj6u+0025DInrKXu1a
         +VVDFTJ9U2B3LptbV09VYn70hTyV66Am6/sjfhc2WCxG82sJhvHbbRjnqRMCbu6O4z1g
         FmWA==
X-Gm-Message-State: AC+VfDwFcca25ITcTulUIb/uNmd9DxlMoPBYfJviquEyVNsyFSCpnCzj
        wHuziQewDLYxlBTvxfSTTS2s31tiZoKkufWXxlKbkfgFq4p7zFyKly8JpcxU+9NbgKGYOzQDu6d
        I4lXhU62up8CeqhACz5/hLpRR
X-Received: by 2002:a17:90a:1d5:b0:258:ad44:1881 with SMTP id 21-20020a17090a01d500b00258ad441881mr348554pjd.11.1685604303891;
        Thu, 01 Jun 2023 00:25:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xgKGdx+9FIXW6GTYR3P3F8V57UwAyR9jIH88D5P2XGZN+XYlgvqnsqFZh+mlMZMuhp1bt/w==
X-Received: by 2002:a17:90a:1d5:b0:258:ad44:1881 with SMTP id 21-20020a17090a01d500b00258ad441881mr348543pjd.11.1685604303582;
        Thu, 01 Jun 2023 00:25:03 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a4e8b00b00256799877ffsm702466pjh.47.2023.06.01.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:25:03 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 4/5] x86/crash: pass the LUKS volume key to kdump kernel
Date:   Thu,  1 Jun 2023 15:24:43 +0800
Message-Id: <20230601072444.2033855-5-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1st kernel will build up the kernel command parameter luksvolumekey as
similar to elfcorehdr to pass the memory address of the stored info of
LUKS volume key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/include/asm/crash.h      |  1 +
 arch/x86/kernel/crash.c           | 47 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++
 include/linux/kexec.h             |  4 +++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 8b6bd63530dc..485f75dce2ca 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -4,6 +4,7 @@
 
 struct kimage;
 
+int crash_load_luks_volume_key(struct kimage *image);
 int crash_load_segments(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..32d4a9e3badf 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -289,6 +289,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -297,7 +298,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude LUKS volume key region */
+	if (image->luks_volume_key_addr) {
+		start = image->luks_volume_key_addr;
+		end = start + image->luks_volume_key_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
@@ -368,6 +381,38 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	return ret;
 }
 
+int crash_load_luks_volume_key(struct kimage *image)
+{
+	int ret;
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+
+	image->luks_volume_key_addr = 0;
+	ret = crash_pass_temp_luks_volume_key(&kbuf.buffer, &kbuf.bufsz);
+	if (ret)
+		return ret;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		vfree((void *)kbuf.buffer);
+		return ret;
+	}
+	image->luks_volume_key_addr = kbuf.mem;
+	image->luks_volume_key_sz = kbuf.bufsz;
+	pr_debug("Loaded LUKS volume key at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->luks_volume_key_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return ret;
+}
+
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..a859e9e5c876 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->luks_volume_key_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"luksvolumekey=0x%lx ", image->luks_volume_key_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -433,6 +437,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_luks_volume_key(image);
+		if (ret)
+			pr_debug("Either no LUKS volume key or error to retrieve the LUKS volume key\n");
 	}
 
 	/*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5b2440444112..20d213076e46 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -374,6 +374,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* LUKS volume key buffer */
+	unsigned long luks_volume_key_addr;
+	unsigned long luks_volume_key_sz;
 };
 
 /* kexec interface functions */
-- 
2.40.1

