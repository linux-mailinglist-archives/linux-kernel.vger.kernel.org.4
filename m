Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9B604EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiJSRhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiJSRg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:36:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65184108DCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:36:01 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q12-20020a170902dacc00b00184ba4faf1cso12353656plx.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oEUha9Ig0lUbuggvj/VkuyhzVDYkc+4vZ7LkSZEK1Y=;
        b=Opn0BKSunXq6+cLFdcH+VElXoQhwG3Y/XFfn3ORbnxERBOC82DazlrCoUG61rYDfrH
         6Kqxu4I0pvSp/uMXawAxDo4XDhWjjvQiyhrPtuaMue4qRi5Yt6HUlb1qLoTFKh7nM4Ki
         in76KqD3Fx/9nUUvz9MJ9AG2iQiuF5htfQfblDaeVg+2KvsJJeLwgkyofdyHAuiZ5gyn
         eVHoY5YJWCQt1oGEgSpIBwLEjN5PnAoe0wmGHqFNla9Sql/tAVo29BCNwL1mgS18ibXH
         yRRdWOkE6yVV75ugIdZfADVs0Nozdd1G1v8WvRmmZm2rZqaZZJ0DUBblOWM/XaJ/M+Wn
         uHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oEUha9Ig0lUbuggvj/VkuyhzVDYkc+4vZ7LkSZEK1Y=;
        b=pijPTNA1N5+7mOKL/3HwgxRHUx1LgIYcdr0HU9zBOz4DuIp7wDzeHectph+o7faYDu
         RAaNtSWsejmp8dL7KgVd8WA4HnXa6nWBR8rfHB2OwWzMSpb1z1xHKOVVZXB9ztwSpdSz
         UchbwR2o2aLQkb+3tlgQgb0YLvxkyNI71hFL6m7ie6pKHOS8bNg07w1T9jg6hq7wzNX2
         8j7EMno7elupdivi4keOQeXE69VRdMkfKh7EtReKvf0l/8sD1ozdNRCd/QhkSh5FiqdQ
         RnsTWQu8i2+xegp5/qDYWJs+ztR7Ii5RTJGSD+oUaOYIQF8taWhO4a6mSpidaPKlWFax
         CcMQ==
X-Gm-Message-State: ACrzQf26G+n5iWFaC4Eapp3nt+IidpnfQBDx6uNqxp9XPnuiRaj0PpW+
        WEXcvMo/Zt28YjwVhZCcYs3OPbokcppNRWc9og==
X-Google-Smtp-Source: AMsMyM4/9VP/KMwSHsv6NrUKutBE6qis24mBDi4I3l7Qic7xnIce0fp0orQyQTRicr+QRt/fPORExqUGjFmRTznDTA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:32c1:b0:185:5398:8c66 with
 SMTP id i1-20020a17090332c100b0018553988c66mr9642944plr.135.1666200951940;
 Wed, 19 Oct 2022 10:35:51 -0700 (PDT)
Date:   Wed, 19 Oct 2022 17:35:36 +0000
In-Reply-To: <20221019173537.1238121-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221019173537.1238121-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019173537.1238121-2-dionnaglaze@google.com>
Subject: [PATCH v2 1/2] x86/sev: Rename snp_guest_issue_request's fw_err
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

The GHCB specification declares that the firmware error value for a
guest request will be stored in the lower 32 bits of EXIT_INFO_2.
The upper 32 bits are for the VMM's own error code. The fw_err argument
is thus a misnomer, and callers will need access to all 64 bits.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev.h | 4 ++--
 arch/x86/kernel/sev.c      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..4312d6be129f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -196,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *exitinfo2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -217,7 +217,7 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
-					  unsigned long *fw_err)
+					  unsigned long *exitinfo2)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a428c62330d3..a4eca63e8b90 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2175,7 +2175,7 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *exitinfo2)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2186,7 +2186,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	if (!fw_err)
+	if (!exitinfo2)
 		return -EINVAL;
 
 	/*
@@ -2218,7 +2218,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
+		*exitinfo2 = ghcb->save.sw_exit_info_2;
 
 		ret = -EIO;
 	}
-- 
2.38.0.413.g74048e4d9e-goog

