Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD0694CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBMQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBMQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:31:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3D1E1FB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:31:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o18so12885078wrj.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNEDXzKGcLxGE5vSCOn4Gl1824w8NdzbMa0+BJPShNE=;
        b=b2NaKfo18h8EQ0ckZNBtyxLzCyw5M9p4fhmVsYeoz0XiLrx8boQvjYY21CLoNE1E3l
         H2uKeunpMpjc+4/RcIpCjUOFvo5V5nIvIHtgLSh2lVO0FW8OgZi1NfbTMWhbOHibIBxs
         5jJ1DPqKsLjmJeU6t5Ic1ZjRykllSad8RqWA+6ZU/GJDJpmmrDDnBr+JpjL/ET+8ogU+
         1XGH9acCYd2vKMnrzWIs7LrbpER/2dfdUV24Ux6YMuwQ5jDUN6s6bF663wPubApxlPhv
         iecR8CIbWzOtqjCLXu9oCTSgZxTZm1srzQXDdvH4enhvnQgNSAOW5E2PyoF1rWUytJkY
         tZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNEDXzKGcLxGE5vSCOn4Gl1824w8NdzbMa0+BJPShNE=;
        b=pbXE3arJT4q5Quq7Ew5y2ni0ej3R+ad+uajpUHI5HtuTXHht3hPVHHJ8GASymZIwPf
         decaSXtWMvLefEkpXq07pItKXBWytqSTZZTfurUehHDpVdmk1ifDo511idRTITiomUDN
         bfmk5FOqy4+gGSci1pigM/22gnCVXgGB4HakHwL9ob23JEMl8g53mY0ExHs6TcDvns9J
         Ek+TfLabbssnMR1B7dxn5ie9b/737ndWlBo3EmSFMkLg7UpZJ2hoEWkP+EiEQYqck5IF
         9FL+eKproF3qi5JynLOegrhiITsAJrLTQBN0LupShKJwVV+w+SKseUGZf47aFxPn6PvD
         k+Zw==
X-Gm-Message-State: AO0yUKUVoXOevY/7O+XxEcCk8qPeWCohEGK1hoM3IHVWMOkDFGQF5IUF
        nvPukJmqFYa5/6X6kKmkf2fFEQ==
X-Google-Smtp-Source: AK7set/LWizz6X1on8RNDb5ylCVP38yg270tfMyvtYLfp4tz2hO9d2gTLmo4FUtabOqeuqe1yUlNrw==
X-Received: by 2002:a05:6000:1c7:b0:2c5:585d:74c6 with SMTP id t7-20020a05600001c700b002c5585d74c6mr4064199wrx.12.1676305901519;
        Mon, 13 Feb 2023 08:31:41 -0800 (PST)
Received: from nuc.fritz.box (p200300f6af2efd00225e3e97da45b943.dip0.t-ipconnect.de. [2003:f6:af2e:fd00:225e:3e97:da45:b943])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b002c556a4f1casm3877993wrt.42.2023.02.13.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 08:31:41 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 5/5] KVM: Shrink struct kvm_vcpu
Date:   Mon, 13 Feb 2023 17:33:51 +0100
Message-Id: <20230213163351.30704-6-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213163351.30704-1-minipli@grsecurity.net>
References: <20230213163351.30704-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reshuffle the members of struct kvm_vcpu to make use of otherwise unused
padding holes, allowing denser packing without disrupting the grouping
nor introducing wrong cacheline sharing.

The embedded mutex and spinlocks continue to not share cachelines, so no
regressions because of lock contention leading to cacheline trashing is
expected.

This allows us to save 40 bytes for 64 bit builds.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 include/linux/kvm_host.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4f26b244f6d0..6e3e5a540037 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -330,8 +330,8 @@ struct kvm_vcpu {
 	int srcu_depth;
 #endif
 	int mode;
+	unsigned int guest_debug;
 	u64 requests;
-	unsigned long guest_debug;
 
 	struct mutex mutex;
 	struct kvm_run *run;
@@ -340,8 +340,8 @@ struct kvm_vcpu {
 	struct rcuwait wait;
 #endif
 	struct pid __rcu *pid;
-	int sigset_active;
 	sigset_t sigset;
+	int sigset_active;
 	unsigned int halt_poll_ns;
 	bool valid_wakeup;
 
@@ -356,10 +356,10 @@ struct kvm_vcpu {
 
 #ifdef CONFIG_KVM_ASYNC_PF
 	struct {
-		u32 queued;
 		struct list_head queue;
 		struct list_head done;
 		spinlock_t lock;
+		u32 queued;
 	} async_pf;
 #endif
 
-- 
2.39.1

