Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F2719423
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjFAH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjFAHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C58E180
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685604309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aefU4VwU8oFOQYKmAqFmOKJxhlCYs6WtVK98Xo9Ylw8=;
        b=WETCygIfvoUR4I/DFrO0Vu0WkJ/DyQ+6nprEwNcFQcTNr4cqMn7qoM4qlWhev97ZLRCc/8
        SboM+RmR1oFlStBSlFS3jlU1DdEm/9UhS6Qtx1bEi/xwrNRc1DFxtHudmodzACopnj7vRy
        kbWjh8FFJMa5rew0SV22jWLX2isBTmM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-oUVdstSjMGWKwHLJB7JtBw-1; Thu, 01 Jun 2023 03:25:08 -0400
X-MC-Unique: oUVdstSjMGWKwHLJB7JtBw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-528ab7097afso566462a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604307; x=1688196307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aefU4VwU8oFOQYKmAqFmOKJxhlCYs6WtVK98Xo9Ylw8=;
        b=PQjxXAEYSS7baW7CSbcDyJph30QjAAVj3P+JmVJIomsHogVO77gj1yo3bLmNnsB7T/
         WAjEq4rP20nrvZJy4tmV4Wls2Coi9nAFwNq53Yz+JD40eFjWbqVDOTLYNBrbK1kDoAYt
         jjkbid2G8OECKrrVfkgXGQ76LY3Q7Gg3HnZJCMHn1RXU6XgFMoTnJ9FiyAcciGCnhO/6
         KgjOL3wb9xokW66rHBwa/el/YOqOGayJsY/J6f0ByD+shIxDvHhq78bYkInwDgEaVfzH
         HznseSFTGq6rEpBexBdxZBjrORIF4Hi2qabJ4zXAH4t6Dd8Js+Nagr2mhx9lD9URtoFe
         MVSQ==
X-Gm-Message-State: AC+VfDz511Gpo29Mywaym1fLFiI2kP94cQ6RxGCGtMatZ5TS2QiojKy9
        BKHF7HT+berYiL9aOfGTTmWw2p7jRlNMB1qnMyBJCr8hmEXNAQkBGQdSQxFIV6JMyeYp24s7aN9
        luOtlVTyTbz4qQiMkQE5huVpz
X-Received: by 2002:a05:6a21:998c:b0:10c:37ed:3e88 with SMTP id ve12-20020a056a21998c00b0010c37ed3e88mr8900710pzb.23.1685604307395;
        Thu, 01 Jun 2023 00:25:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63I95P8dhhdJ7s5jrMayaANp/DzsGmHfYS5azIKGpulSOOXmtAzsGrmoW2rz/wazIGcv1tqA==
X-Received: by 2002:a05:6a21:998c:b0:10c:37ed:3e88 with SMTP id ve12-20020a056a21998c00b0010c37ed3e88mr8900696pzb.23.1685604307121;
        Thu, 01 Jun 2023 00:25:07 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001ac5896e96esm2644901plg.207.2023.06.01.00.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:25:06 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 5/5] x86/crash: make the page that stores the LUKS volume key inaccessible
Date:   Thu,  1 Jun 2023 15:24:44 +0800
Message-Id: <20230601072444.2033855-6-coxu@redhat.com>
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

This adds an addition layer of protection for the saved copy of LUKS
volume key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..82d1ecb35827 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -546,9 +546,23 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_luks_volume_key_inaccessible(void)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->luks_volume_key_addr) {
+		start_paddr = kexec_crash_image->luks_volume_key_addr;
+		end_paddr = start_paddr + kexec_crash_image->luks_volume_key_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_luks_volume_key_inaccessible();
 }
 
 void arch_kexec_unprotect_crashkres(void)
-- 
2.40.1

