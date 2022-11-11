Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E527E624FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKKBn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiKKBnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:43:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7591264A34
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:43:04 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c1-20020a170902d48100b0018723580343so2525545plg.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4x/ZOtSpWk9/3ogowMPSnEkswUrYlJBht55aGP6vlw=;
        b=TJGAJEvpGOatam2eQMAYKoLHifGaCKcgJ8RPGSg+GXW2tqhAlddReaZHE/EKUpB/tx
         wjBR+3fkVuz5yXDC3v0NzMfaMkv2C+uXqhDrFlw9iL37AzlIQdssxZgqr4y5+ezJy9KR
         IGL9cS+FdQPPMmyeCQT+IIERkTkpC7c6Z2i51BEsaPh+mKQ8ctl+6nfK3X4QpbWqHbE3
         WwUKGXkYBcRy+rkkT9p+dt2ShAwGDdwHm6+sZD0REr1/vQfkXzc/5f9Yb9cOYN+KQikL
         7M1RLkXjbhCoOocrZWjPma3UEXdsVvYchcMh+jKKc7dzFmX2/imWhcLvUEsJdE4IXiAg
         YiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4x/ZOtSpWk9/3ogowMPSnEkswUrYlJBht55aGP6vlw=;
        b=g21jXWtHRiczb1/438VY7JmScDlsg1+RaTSgISwuCm6JADU8pHQD9pIu/RgYZRq+PZ
         REj8sfmSvxe8kUYH6DuIgNJKZw7xQfZEZ50+Ln0Vg2kKwSlkBGtnWHBcHQsbfLIQlzRQ
         S7FhmNkL10DwhQSotezC/K5Yz8jNGbksij9b0BH7pGEXitS94PzfCaBUzdzlwJCknMWj
         UQQqgvrFDR2Y17tSgRXl+Ukm00zL+szYrFme8se8facnzhVcSwqXD4UBdN10VhasLA1G
         I9H59hqgPb4Fx9wa/m9c1PW+mgFtXhFClbqM996DPjw43jNX3k5ZGs0NVtZ6Fu3YRBte
         JOVA==
X-Gm-Message-State: ANoB5pmUlAeeWkgruyTftjUMpm0Qo3yqPYC8yck5/SDPU44F7gA+JTsP
        zez9HqAnk3hTu928JP/WS3wRUt1TP46hvpY0
X-Google-Smtp-Source: AA0mqf467VSoly0Pym2TsVrqMJzRUABw5L6WkuXLvTk+pZVpwyNu+Jak6Hp2K4udCnAfjs2qiA538m2BwRv5AKP+
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:3022:b0:560:e4d1:8df5 with
 SMTP id ay34-20020a056a00302200b00560e4d18df5mr337333pfb.39.1668130983874;
 Thu, 10 Nov 2022 17:43:03 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:43 +0000
In-Reply-To: <20221111014244.1714148-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-6-vannapurve@google.com>
Subject: [V1 PATCH 5/6] KVM: selftests: Add get_free_huge_2m_pages
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API to query free 2MB hugepages in the system.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../testing/selftests/kvm/include/test_util.h  |  1 +
 tools/testing/selftests/kvm/lib/test_util.c    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 140a61f68fe5..f4df49c8b5ba 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -115,6 +115,7 @@ struct vm_mem_backing_src_alias {
 bool thp_configured(void);
 size_t get_trans_hugepagesz(void);
 size_t get_def_hugetlb_pagesz(void);
+size_t get_free_huge_2mb_pages(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index ebbac8246016..4f28ae73f150 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -145,6 +145,24 @@ size_t get_trans_hugepagesz(void)
 	return size;
 }
 
+size_t get_free_huge_2mb_pages(void)
+{
+	size_t free_pages;
+	FILE *f;
+	int ret;
+
+	f = fopen("/sys/kernel/mm/hugepages/hugepages-2048kB/free_hugepages", "r");
+	TEST_ASSERT(f != NULL, "Error in opening hugepages-2048kB/free_hugepages");
+
+	do {
+		ret = fscanf(f, "%ld", &free_pages);
+	} while (errno == EINTR);
+	TEST_ASSERT(ret < 1, "Error reading hugepages-2048kB/free_hugepages");
+	fclose(f);
+
+	return free_pages;
+}
+
 size_t get_def_hugetlb_pagesz(void)
 {
 	char buf[64];
-- 
2.38.1.431.g37b22c650d-goog

