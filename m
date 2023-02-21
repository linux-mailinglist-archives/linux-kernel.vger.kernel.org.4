Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9AC69E4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjBUQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjBUQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:38:02 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71D2D143
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:39 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g13-20020a63f40d000000b005015be7b9faso2219323pgi.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V/DDoXnf2opyFk/JIknDREbRoogTSxKXRqdxFHEiFI8=;
        b=azZPMaZPqkrP+aRIze5KyWBJigIWuhR7vtvT2AIX7QbIONV/SEZfaTC3RTMNBJ/gmU
         WYfczP8dXkhdM244WOARnjbjac48VMe8eRTwD7rTm6azex04IDUSY5aK7pYJUH5Q9fSQ
         cAuHVy840VC+14rudyO4RSecU0L00tAeBdKtH7NcPLH8GxDkvp1xvPKlLwmrkMt57oNf
         sBPRwczKUdtLW4cbVPp72zxUCHV+SKGOro4n/9T6lq8U5i6fhwmfhXtLw29/sNy2c/G6
         ful7j4FyU0Ce4ymO3+jQVgWQIIwUy0pocwJ+mztGJ2ZXd0XKM3AY0LmeezohXhHHMwUK
         vnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/DDoXnf2opyFk/JIknDREbRoogTSxKXRqdxFHEiFI8=;
        b=UJB9u2rTD55R3KSwHKH2ojKv39rtZXBmxnnfQjztpASsyGs0TpsR3coynr8sf19qEK
         5baqXmG2lvj2syktFIeAJjYX8OXMXCaszYrVTKyB64cOqdRZzfgg/Znr15HWU3PaW4kA
         kpye9WOztwaT8rhysf4yNrPA0yZ5bYR5tbF1DcQTQTxYpjk4neXqIlDlNZMrWCwzf1iE
         MJCxOflydb3S2qH8lvqDe2Szc/8gSgfLk99zEbtnVq8+UFNFT4DR2/7DTVwREpAMZKDv
         XzoAsxmr3eL6FdaKmDZuPTeP0w9eR9eDRgCqnmdLJaeKyBHP83d2t1/dvCRCdEwVCn1B
         KV4w==
X-Gm-Message-State: AO0yUKWtfyWWxEKFPEgDytnAS3ecfdCI5Pm7xb8+ZL/dVmdYtw5lW3w4
        zaf+Pvus4BfWJs+wRSRU8ZstSQZWgW3e
X-Google-Smtp-Source: AK7set+uCt7SuZB25GG76skCLbvVlwbw3NDGyd+ph4vafj6zCKa42RtEONl+cA12mbmKCbURNFSBFoNJic7t
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:77c1:0:b0:4fc:27da:54a5 with SMTP id
 s184-20020a6377c1000000b004fc27da54a5mr681202pgc.1.1676997459042; Tue, 21 Feb
 2023 08:37:39 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:54 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-13-mizhang@google.com>
Subject: [PATCH v3 12/13] KVM: selftests: x86: Check that the palette table
 exists before using it
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
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

From: Aaron Lewis <aaronlewis@google.com>

Check that the palette table exists before using it. The maximum number of
AMX palette tables is enumerated by CPUID.1DH:EAX. Assert that the palette
used in amx_test, CPUID.1DH.1H, does not exceed that maximum.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
 tools/testing/selftests/kvm/x86_64/amx_test.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 5cfd7ef40d78..a6a86c41ed75 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -223,6 +223,7 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_XSTATE_MAX_SIZE		KVM_X86_CPU_PROPERTY(0xd,  0, ECX,  0, 31)
 #define X86_PROPERTY_XSTATE_TILE_SIZE		KVM_X86_CPU_PROPERTY(0xd, 18, EAX,  0, 31)
 #define X86_PROPERTY_XSTATE_TILE_OFFSET		KVM_X86_CPU_PROPERTY(0xd, 18, EBX,  0, 31)
+#define X86_PROPERTY_AMX_MAX_PALETTE_TABLES	KVM_X86_CPU_PROPERTY(0x1d, 0, EAX,  0, 31)
 #define X86_PROPERTY_AMX_TOTAL_TILE_BYTES	KVM_X86_CPU_PROPERTY(0x1d, 1, EAX,  0, 15)
 #define X86_PROPERTY_AMX_BYTES_PER_TILE		KVM_X86_CPU_PROPERTY(0x1d, 1, EAX, 16, 31)
 #define X86_PROPERTY_AMX_BYTES_PER_ROW		KVM_X86_CPU_PROPERTY(0x1d, 1, EBX, 0,  15)
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index deacd21cf744..2fd6a8a928d9 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -30,6 +30,7 @@
 #define XSAVE_SIZE			((NUM_TILES * TILE_SIZE) + PAGE_SIZE)
 
 /* Tile configuration associated: */
+#define PALETTE_TABLE_INDEX		1
 #define MAX_TILES			16
 #define RESERVED_BYTES			14
 
@@ -120,6 +121,10 @@ static void check_xtile_info(void)
 	GUEST_ASSERT(xtile.xsave_size == 8192);
 	GUEST_ASSERT(sizeof(struct tile_data) >= xtile.xsave_size);
 
+	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_AMX_MAX_PALETTE_TABLES));
+	GUEST_ASSERT(this_cpu_property(X86_PROPERTY_AMX_MAX_PALETTE_TABLES) >=
+		     PALETTE_TABLE_INDEX);
+
 	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_AMX_NR_TILE_REGS));
 	xtile.max_names = this_cpu_property(X86_PROPERTY_AMX_NR_TILE_REGS);
 	GUEST_ASSERT(xtile.max_names == 8);
-- 
2.39.2.637.g21b0678d19-goog

