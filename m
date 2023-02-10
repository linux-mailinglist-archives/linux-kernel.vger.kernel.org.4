Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF040691572
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjBJAcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBJAby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:31:54 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EEF113D0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:31:53 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z7-20020aa79587000000b00593f19705d5so1791650pfj.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+fQX1KYX7m+MKDXvC9TpLUvb23KTkcLLlbaBWIUtq+k=;
        b=mrSpI7sLKW8Uif58ICcPWzR9/7fsxF/m4jSPvHSMW+ojCKiCmFJBVZRkFSvzeu8Szn
         yrpBlBlCmcVEKArgHoYpXljxss3+T556owr4o/sEluhUMNoeRN3sHQau0+Nvh1wj7etQ
         wxxWmrTP5e82mSvMaGdWYEZ2Q2vheEoNYM7cGOvxEeaQKNkwNtWwvK0OlR3QFL8XAD6V
         8CDEiuW3eskkKAN+eKZ3ozQMINpDLi/CyI6+8JrkXcFTiLfJRSWB1lK92vTrYbPZMFBr
         57uWzVCaIiXIytusjrVV2JqXeaHkDKIuesgc9/t90OdLlURvO7s6pZI4XJIRz3RH7I/i
         IaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fQX1KYX7m+MKDXvC9TpLUvb23KTkcLLlbaBWIUtq+k=;
        b=r66/gowG0i8iZn/2vF58W3YEDlAx+bfJ/X6GAjPEvgXmM09sL4gYvnQyZ4R/gSh265
         h0xIkQmvFUan8zPxh8KGtocNIUXLR5yIEnitMR0Q0WvqBuCY/ROMMGIpS7HLN5EwVf2u
         nis2vp5Rq8T8cwQHKuTeiiwRdXhDvmqB/d7ONWZJ0GXmePUAu28j1lVzVrb4+NMD7vKj
         a6IrxGkCVghuktBGF7dLb8LKPpPXzV+Yw3Cm790auMkZ0MbWKy/eHzn60EmV4SJ7ytjW
         wV4xrZNxMKvUX2UhbY2L4GrQlyVGKrau9KNHEDRGiiaHh1jLeDmRHLHK3nAZ4x6VTp2k
         l8EA==
X-Gm-Message-State: AO0yUKXMPZUN7rdh5sdYTFibsJUHZ6sIUoIfNbvjSxnhjgkJ3+uo5D0V
        4N/dAWDKLt8U6w8KuobCNWP6bGHc9yI=
X-Google-Smtp-Source: AK7set/XDIzgJ/wUbZ/JDeptz3169Kgai62OVnoTGZLJBmh5XesLCtPUHinn6BcI6rrusF44ephavhiYAks=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3d84:0:b0:4fb:48c8:28fb with SMTP id
 k126-20020a633d84000000b004fb48c828fbmr739276pga.122.1675989112919; Thu, 09
 Feb 2023 16:31:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:28 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-2-seanjc@google.com>
Subject: [PATCH v2 01/21] KVM: x86: Rename kvm_init_msr_list() to clarify it
 inits multiple lists
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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

Rename kvm_init_msr_list() to kvm_init_msr_lists() to clarify that it
initializes multiple lists: MSRs to save, emulated MSRs, and feature MSRs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f706621c35b8..7b91f73a837d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7071,7 +7071,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 	msrs_to_save[num_msrs_to_save++] = msr_index;
 }
 
-static void kvm_init_msr_list(void)
+static void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
@@ -9450,7 +9450,7 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_caps.max_guest_tsc_khz = max;
 	}
 	kvm_caps.default_tsc_scaling_ratio = 1ULL << kvm_caps.tsc_scaling_ratio_frac_bits;
-	kvm_init_msr_list();
+	kvm_init_msr_lists();
 	return 0;
 
 out_unwind_ops:
-- 
2.39.1.581.gbfd45094c4-goog

