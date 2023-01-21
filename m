Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2F67624A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjAUAUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjAUAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:20:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7979574B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:19:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso7506666ybp.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSbqzQIHhtOUZi+XNLRvr0hBcTc63rTSHvkLvHdhRjs=;
        b=j+nuqFxlj28fkfuax2AYTnMDYPRfm95o2qjUDWXSKBksDH8jYemCh9w0e7ftn6QOsw
         vpC45E1/+deGYoDby3+FGoPiHS/LxF8nPJlBFrNMv7dO3xcEw9B5XVWgl0O5VgU3jgOn
         erfriF1fdySfCtOnV7cj/oaFKAgRrxKVOEzhHDO25dAOE3ttKTo9UtZOYVLCEg0QEyXW
         wA+NvIShIINGq/JGFEvnFz+GRzfD3HO9/HUL0rGzM1JR3hW/+R0Skr5OAs3FZLV6eI/I
         +q4fhfZYPwBOyIYJbBA4rPW7OYqyLr9hI0S+wNSVgcM3BAOP0WApHvrLpY4CzghElk6I
         t/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSbqzQIHhtOUZi+XNLRvr0hBcTc63rTSHvkLvHdhRjs=;
        b=UjhGg9dDcW/q/yxQCz5EmcKKB9SZRGQsiACIrSBppdCNwL+0H4h/3NC6QDTYAG64yn
         UzjuDKvT3vqn8UEzOC1s7rQA7a6vQ8XAwXLfiTF8IXQoqa6OP0jsA+61Haa6xojtJtYv
         wn6mkFyaAX1T72R3x6H66R3rwaVZ5M20ss4uzSYVi4Vx0kgRvtoCQ4ZUfxLHrCIaLsue
         AsqPRXHgrtdbsqJm9hXuX7acS0vLTfzNqubwqfIPTsrFfo2gn4IgldPTkO4at9iW46ai
         zpm+ID6CdEQCDjUMd9iS7fYCMQym3g83jM5X/fYCaUpqRvtkHVaPRgWYAPIzYCIOfODZ
         yPUQ==
X-Gm-Message-State: AFqh2kpWMjph1KngBX/ojAVKih/kmHG0T1Vuyoi4zxpGyHkopu5GTCA7
        ICbvOboIUjF4+HIKy+XzdI/0lvSixEH2o28+4g==
X-Google-Smtp-Source: AMrXdXu1DCnVzLJkLaux9FqMEFGGeDFnVXCqWlSa4HMsaQ9DZUE7PtkSZ+oUJjuui87VSyvC9iSnO+Q32CJrzh9ORQ==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a0d:eb93:0:b0:4fb:2084:1f62 with SMTP
 id u141-20020a0deb93000000b004fb20841f62mr956118ywe.513.1674260294752; Fri,
 20 Jan 2023 16:18:14 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:39 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-29-ackerleytng@google.com>
Subject: [RFC PATCH v3 28/31] KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h | 2 ++
 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 857a297e51ac6..c8e4b9ce795ea 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 
 #define TDG_VP_INFO 1
+#define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_MAP_GPA 0x10001
@@ -38,5 +39,6 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		uint64_t *r8, uint64_t *r9,
 		uint64_t *r10, uint64_t *r11);
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index e0a39f29a0662..2ebc47e268779 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -205,3 +205,8 @@ uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_o
 		*data_out = args.r11;
 	return ret;
 }
+
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
+{
+	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
+}
-- 
2.39.0.246.g2a6d74b583-goog

