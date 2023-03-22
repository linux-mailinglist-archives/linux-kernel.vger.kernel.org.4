Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54986C3FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCVBen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:34:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47189521CC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:34:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so66973975edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679448870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKfWyPdWdSRYOzolgK9AgL1vcMAf7TEF7SLZEQ3lWXY=;
        b=n43NCSzmVBHNDH1pvKVD3UejAZKe7GdCOXtD9IjVu53D9AoBVfyWszbm25SGWXrMBS
         gNNQEyrbYCPzPMTSdK3/fNXpCSlYogOcsWkp8CT5gcecpkllLzJdxGIeu98pdRU5HKrC
         M+pQV9qrY1LrzOODh4Kc58Y+wAjPdbJv+hRZliV/jG1zZxu2Habt3ZK0imwGGehhMvek
         d7/HAhPiChwz9xz/oH7WsEqxKJe0DIMxoTWy3q8BjyvjmauMYwkigyDGHnOtChcSVJZs
         2tIdy1Psh9ZIDTD8ESiix4IYNQj20L/N6gERJWKcWfazGuwHX0KnIgw+CnQG2OJq1VmM
         /Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKfWyPdWdSRYOzolgK9AgL1vcMAf7TEF7SLZEQ3lWXY=;
        b=WzAI6u6HMHJbkzcVk43fQzZKxTOykKAARwblvBuWD+S7yMt20B5cWV+NZl8XKLvS7W
         h1Eo1TS9TbTFLl6g1NgmD69ezWiKN5yyF6RMFv2AFvE0SRrum3/V2Ad/Nm480L5pZzBX
         k9z1zpp94fAq2/dJc055KGRdOH6NV4VuzMlhYkaXVo5Byls8mJz0UoaKTQWJQ285lvGy
         PptQYlhKaFBiHZYSfzB2sJlncgv0X6yuVpyK0SQs7B2x/jiJiMY7LzcDMB3bf8AO9Ooe
         BV2O2O/XQMJ/fVPB+qqMkXo4JXW6MKB+6FDTAppGhqcuCgwio9mEK2aFVbl1jXmBzs54
         CDrw==
X-Gm-Message-State: AO0yUKWdxdb4loTTg0qdfKDWBQQ3E85CeQIXOEqq76CoOlFDLXrTolrC
        LajjSMuI9nvxvZZNE49YgjWx1A==
X-Google-Smtp-Source: AK7set9YdsjIstOiO2dDOTaGksvG818z1gQgHdBRTBCbR5Hw2FrIepdu6uYc0tPCILkxyXAh24Lp1w==
X-Received: by 2002:a17:906:b084:b0:931:75f5:36db with SMTP id x4-20020a170906b08400b0093175f536dbmr5007473ejy.11.1679448869752;
        Tue, 21 Mar 2023 18:34:29 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af344e007f5e5982a136b54e.dip0.t-ipconnect.de. [2003:f6:af34:4e00:7f5e:5982:a136:b54e])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709067c8b00b009231714b3d4sm6356260ejo.151.2023.03.21.18.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:34:29 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH v4 3/6] KVM: x86: Ignore CR0.WP toggles in non-paging mode
Date:   Wed, 22 Mar 2023 02:37:28 +0100
Message-Id: <20230322013731.102955-4-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322013731.102955-1-minipli@grsecurity.net>
References: <20230322013731.102955-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If paging is disabled, there are no permission bits to emulate.
Micro-optimize this case to avoid unnecessary work.

Suggested-and-co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 arch/x86/kvm/x86.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c6d909778b2c..8a66ac7a4878 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -908,14 +908,20 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
 {
 	/*
 	 * CR0.WP is incorporated into the MMU role, but only for non-nested,
-	 * indirect shadow MMUs.  If TDP is enabled, the MMU's metadata needs
-	 * to be updated, e.g. so that emulating guest translations does the
-	 * right thing, but there's no need to unload the root as CR0.WP
-	 * doesn't affect SPTEs.
+	 * indirect shadow MMUs.  If paging is disabled, no updates are needed
+	 * as there are no permission bits to emulate.  If TDP is enabled, the
+	 * MMU's metadata needs to be updated, e.g. so that emulating guest
+	 * translations does the right thing, but there's no need to unload the
+	 * root as CR0.WP doesn't affect SPTEs.
 	 */
-	if (tdp_enabled && (cr0 ^ old_cr0) == X86_CR0_WP) {
-		kvm_init_mmu(vcpu);
-		return;
+	if ((cr0 ^ old_cr0) == X86_CR0_WP) {
+		if (!(cr0 & X86_CR0_PG))
+			return;
+
+		if (tdp_enabled) {
+			kvm_init_mmu(vcpu);
+			return;
+		}
 	}
 
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
-- 
2.39.2

