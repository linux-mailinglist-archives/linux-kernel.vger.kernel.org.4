Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AB60F377
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiJ0JRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiJ0JQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:16:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEC4BD24
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:16:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m2so943287pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie-ntu-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0jwfzDPpiiIA6G13h9XyMG8TS+aWs3VsgaKFJG4r/Y=;
        b=VdH5bBMbuaoLKAdZotjR+kRjpk0oZGv9hrkl9h8A1KXDH/zF2a2KjFmyUrMxaStb29
         OyM0t531gOXJxVZxcFvVpf+ikh/UTgH8jszdO9mTAXfGLrTm5K83EJ01xVDx/dH+21OT
         wPBqotTm8VEsHI+4Awayn7e/oFkQCmr6F8VVbfwvBEJnqxyz6fWjo5aJ3df/mEpFIlQI
         DqdG6aC4WjX3SaEKNbjoEkK7BI7vOq1S4KrtFYB2XT0pZs3JndlEEPjv17XnDosPvHWc
         VjY/MloT7ayanxfnaXkjo3bFpNcvKlSDIhSyOWgdfC3yluP02Ul6H15CxjCLHvklufr6
         kb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0jwfzDPpiiIA6G13h9XyMG8TS+aWs3VsgaKFJG4r/Y=;
        b=I81TZNaqnmv5x2VVvvopFA6AfZ3LQsPDxUQjMo7/F5dXO8ISyboHoRDFXhhljVe337
         B5Zo7f/sbuC6FoEvARg7JAYHq+coWl7jOnSMAGfnmLSXPChUTEdk18jH4SYJZIkPIRZo
         pCBx9ndIQ/r/T3rIx9I8Ruya1jsfohDqgGcsHfB0dMWzqBd3h6ZdhpAe6ra082JFOWNE
         CeFIAVk/CYfqujoDVYc+1H7dKJ2ZRq3BYjyrZ/rU6YiSpSZGwBdpnY663G8I7GrPJxgC
         evAGCdgJ9amOSLmy6cqIGFeKtolGAIM5buNDuRjvwPW8YzYAHlVr5kzW/dYpzq2N000b
         Hodg==
X-Gm-Message-State: ACrzQf3d5/Dzbrss36rhGR5MWqJJ0OVWDvyiXleFEukGFQ80Df4m/Ndr
        yZti2RgeEvAlC4XWmotZ48hKjXqPqnodKFHhz0IxP8eU1lEJaIDeFjHvjer9sMocoT//jxgAT8t
        dEkk5hzePXKHB/KFCEv+Da+Dtg8xMJMw63G8tvmtOTSuolzijARyUI6401U7zGi5HBtQmFjBilS
        fQTuZqU6jaxXKBZwom8K+2ODjbKzE=
X-Google-Smtp-Source: AMsMyM4aHQAm15VDE1/vKTcXNEmcnXBX2pjTWeY3+FHq6p29Ayj+aYLyA1TFLyvsRWVx1l2oc2LxaQ==
X-Received: by 2002:a17:902:b90b:b0:186:8a4d:d4b7 with SMTP id bf11-20020a170902b90b00b001868a4dd4b7mr26808587plb.129.1666862199646;
        Thu, 27 Oct 2022 02:16:39 -0700 (PDT)
Received: from rhythm-ZenBook-UX425EA-UX425EA.csie.ntu.edu.tw (114-45-31-164.dynamic-ip.hinet.net. [114.45.31.164])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b00178650510f9sm721113plm.160.2022.10.27.02.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 02:16:39 -0700 (PDT)
From:   Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To:     maz@kernel.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Subject: [PATCH] KVM: arm64: Update comment of create_hyp_mappings
Date:   Thu, 27 Oct 2022 17:15:23 +0800
Message-Id: <20221027091523.139598-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HYP_PAGE_OFFSET is removed since 4.8, and the method for generating Hyp
VAs has evolved. Update the functional description of
create_hyp_mappings accordingly.

Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---
 arch/arm64/kvm/mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c9a13e487..a9ae4a3f9 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -424,9 +424,10 @@ void kvm_unshare_hyp(void *from, void *to)
  * @to:		The virtual kernel end address of the range (exclusive)
  * @prot:	The protection to be applied to this range
  *
- * The same virtual address as the kernel virtual address is also used
- * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
- * physical pages.
+ * The Hyp virtual address is generated by masking the kernel VA with
+ * va_mask then inserting tag_val for the higher bits starting from
+ * tag_lsb. See kvm_compute_layout() in va_layout.c for more info.
+ * Both Hyp VA and kernel VA ranges map to the same underlying physical pages.
  */
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 {
-- 
2.34.1

