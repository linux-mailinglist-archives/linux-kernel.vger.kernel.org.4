Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481C8710930
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbjEYJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbjEYJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24B191
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685008180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hAxjra5W1+1SvpBMN22QXJJOi5JB+teXZgPwJvUgVGE=;
        b=H5eCmI5ZjssqzzZPef2G9MeMirWeBvpgB42ph90+wq0JHNlgkrjIjNlJsOZTFfu7ONWP+M
        Q0aWm1eL9R9jB9KmuIf31QQq6/gw6wZ9LZHCoVsiaQBa0ta2GjzDVc3QO4bgsMfF103OMs
        D+eFVc/DBLhWApjVmJN9V/pIG2E5tgw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-FIiChdNTPFimlaeJDlZfEQ-1; Thu, 25 May 2023 05:49:38 -0400
X-MC-Unique: FIiChdNTPFimlaeJDlZfEQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-53425d37f33so902381a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008177; x=1687600177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAxjra5W1+1SvpBMN22QXJJOi5JB+teXZgPwJvUgVGE=;
        b=DBtByHAon5EpSh1gm8P3J+SGoHiCHyLM7g5Za4T4EKbXQQTH9inFKr0TXA18gxwQ6y
         NnxBCt66lLfuMyJZhOtF+UcEmLTHMPR/3rue6Fiw7Lbv8uT5WtWeS++avJJtK5oW1Sb/
         caaTFp1CE2oUStYBlP5M6QR0DoAjyQfWoxKHOnFZc0k/jclGDH/nHA3ngAFX6+dmZ8fu
         mI7ueoWqOXvOdwwDYXCmmHsPp/Cu8gafSzcf1imYPC0SYSU7Zbg4V6NxOSD+nXYK5qgY
         b2ojpWJzbC6DrnCgQ9UEH7Lz+CsbUu0OaAcprOFglYH9HqtwBpUZXAUvfOIac6Ccv9Yi
         WoBQ==
X-Gm-Message-State: AC+VfDwVApH1RZKLNk/g34cpYMEd+VyP1bNoQFxSi1GI2/MBAuDwB6Bj
        rdUkGdG/+UItmx3qWbh+9xqzh80zENZlkrzIa/SMyZRaViNMWAKi4BTrjqPd2PS6AKYX7zQLO7s
        J2ARKigdy7Nf0kL8LkuLQcmGR
X-Received: by 2002:a17:903:230f:b0:1af:a03:8d82 with SMTP id d15-20020a170903230f00b001af0a038d82mr1149855plh.57.1685008177412;
        Thu, 25 May 2023 02:49:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64F7+wAhODeQTh71SkG9KiZ+8BDhumZp7KJkEik3KY4RGXnQjHL9XswjQ5pC+GeNWlMRi+Sg==
X-Received: by 2002:a17:903:230f:b0:1af:a03:8d82 with SMTP id d15-20020a170903230f00b001af0a038d82mr1149833plh.57.1685008177110;
        Thu, 25 May 2023 02:49:37 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001ab2b4105ddsm1008282plh.60.2023.05.25.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:49:36 -0700 (PDT)
From:   Tao Liu <ltao@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        Tao Liu <ltao@redhat.com>
Subject: [PATCH] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date:   Thu, 25 May 2023 17:49:14 +0800
Message-Id: <20230525094914.23420-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
EFI config table.

Currently EFI system table is identity-mapped for the kexec kernel, but EFI
config table is not mapped explicitly:

    commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
                          tables to the ident map")

Later in the following 2 commits, EFI config table will be accessed when
enabling sev at kernel startup. This may result in a page fault due to EFI
config table's unmapped address. Since the page fault occurs at an early
stage, it is unrecoverable and kernel hangs.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

In addition, the issue doesn't appear on all systems, because the kexec
kernel uses Page Size Extension (PSE) for identity mapping. In most cases,
EFI config table can end up to be mapped into due to 1 GB page size.
However if nogbpages is set, or cpu doesn't support pdpe1gb feature
(e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
due to 2 MB page size, thus a page fault hang is more likely to happen.

In this patch, we will make sure the EFI config table is always mapped.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..755aa12f583f 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 #endif
 
 static int
-map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
+map_efi_sys_cfg_tab(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
@@ -244,10 +271,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	}
 
 	/*
-	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
-	 * not covered by pfn_mapped.
+	 * Prepare EFI systab, config table and ACPI tables for kexec kernel
+	 * since they are not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_sys_cfg_tab(&info, level4p);
 	if (result)
 		return result;
 
-- 
2.33.1

