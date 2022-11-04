Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6765761955F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiKDLbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDLbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70697B1C4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667561439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9ieE4VIDGcBaiULL1C+z5L6S0lWIm/B8H9v1NRSxPo=;
        b=gAR02Aj8AYRUhmjLI+TOuvOa+bDU/kEgG/NAnDulhvyWd8SraunnW4oX4aDpnEJJfAZsqk
        /rLjlbiVA8pqWZVTXqT6JXTtZv7XyNkT1KM7SFFZmEsolnPtefNwP/CmfEfu6CTYNpxtZV
        Hq1Mv6Rz0Bb320aewkmAyXBzMSmQ+U0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-282-2zYp7OsXMkWZ78UyaOendA-1; Fri, 04 Nov 2022 07:30:38 -0400
X-MC-Unique: 2zYp7OsXMkWZ78UyaOendA-1
Received: by mail-pg1-f200.google.com with SMTP id k71-20020a63844a000000b004701e90da0dso2309333pgd.22
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9ieE4VIDGcBaiULL1C+z5L6S0lWIm/B8H9v1NRSxPo=;
        b=LR0toxKy55NaIPecI2j16LdYZ+EMsixUPcVlxbNunuZgG4bXQz1L6lq2oaCyZy1rE+
         OUA8/XkLOr0OvMzc/CVaBxuRLqzJEvspW8elWUp7slP2HJdyflf1bRjV7FNU+X1JMP7D
         sJ9qpqihn/cEuoTfeWlcUPNGmiZQIXiwoM5yC5r3hRYh+Lff7RUi3Bcxl8FKcJDY0e51
         Lj4RGahAdBze7AFc4Ns4ln1aV9bTVbk97AHkCZlMWkRANwzJkh9ybMfXMICsrg5kZh7i
         U3lnTyNx6JD0R115QDxIKctUP6T6GiPgXPAU2eAUIdA9pvcOzbLhQ6bmnZ8XBG2+RPsn
         RoDw==
X-Gm-Message-State: ACrzQf0lpbRYmegEFc97syZVTIK3HBL+6wP7c+GSdk73noB2bApzih0y
        d88JOwsGpUSpZOn4jYcpboolCg3kJY7bU9IeaIghbGI9PN5X9B+KskRXnol3LSuOPjQeCaFnV0P
        UagvIawz2GyArX7Azh0CZQbg3
X-Received: by 2002:a17:902:f28b:b0:186:b069:63fc with SMTP id k11-20020a170902f28b00b00186b06963fcmr35566382plc.38.1667561437565;
        Fri, 04 Nov 2022 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qypMeRgTqbqOB76+RxKWKqrfx12CwgsfSjDZBxgJGySGlq0PpZpwe2FJNfIghklVFI91+FQ==
X-Received: by 2002:a17:902:f28b:b0:186:b069:63fc with SMTP id k11-20020a170902f28b00b00186b06963fcmr35566345plc.38.1667561437294;
        Fri, 04 Nov 2022 04:30:37 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k30-20020aa7999e000000b0056bcfe015c9sm2458149pfh.204.2022.11.04.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:36 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [RFC v2 3/5] x86/crash: pass the LUKS volume key to kdump kernel
Date:   Fri,  4 Nov 2022 19:29:58 +0800
Message-Id: <20221104113000.487098-4-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
index 9730c88530fc..5ceda2802482 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -304,6 +304,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -312,7 +313,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
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
@@ -383,6 +396,38 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
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
index f299b48f9c9f..e556dbf96695 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -75,6 +75,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
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
@@ -371,6 +375,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_luks_volume_key(image);
+		if (ret)
+			pr_debug("Either no LUKS volume key or error to retrieve the LUKS volume key\n");
 	}
 
 	/*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c0edb64bf6c4..ed7a0ec70129 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -385,6 +385,10 @@ struct kimage {
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
2.37.3

