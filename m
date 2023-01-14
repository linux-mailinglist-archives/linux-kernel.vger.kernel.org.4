Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97D66A874
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjANB5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjANB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42D8A200
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673661408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hwyNBnBNcOY5o3TI1UxsJTjGkKbM0dQkaLFkc1W7j5I=;
        b=ffASZqYDMSBL7KOvTO5bxdjaht0RjJlqcPePn2bm3/LijpO7QgyIw4eK5rcCy4bXovTdhn
        PBMTHCpSiRU83brBcp59pQk2yl9eVFAcbXnOH7091a6sA+X77BNzsSiyHL4QEB44txnDfy
        Vc1pOzYJ8RkB3Ytfgx/LdP3AECltNBQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-yG1GdS3GMNKSSYk8dIa6EA-1; Fri, 13 Jan 2023 20:56:47 -0500
X-MC-Unique: yG1GdS3GMNKSSYk8dIa6EA-1
Received: by mail-qk1-f200.google.com with SMTP id u11-20020a05620a430b00b007052a66d201so16424033qko.23
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwyNBnBNcOY5o3TI1UxsJTjGkKbM0dQkaLFkc1W7j5I=;
        b=GoAs9y2HToMIMnRYFHW6FblyQ9BKzSK32cQy1KayvANB8Krkx5CllgfXPRlNtPEibh
         ZL1onird7HF0/IhDGOSC/v8ijIJEJnvf43xLb+f63HP97TVSGg0VDR1HPOFc/vPFEs+n
         HTgWKFeBqSPPjrTf2ATndgOR6flkb+ADiH5yA3AystAXh4jblRrvGHzp/nOsR6Nr0Xf5
         6IOWqtBe54aZsQO2zql7IQWqe3fcyw+chxn8CvhCUzzxgZubY43qBN2jzm8fauxaV5Ke
         J2XxTlchpqWp1+c6x3lXx4Si9UlthgoVaRrc1yhTbwIBHB8VlviQUNIRs4L3140FKUzr
         dMVw==
X-Gm-Message-State: AFqh2kqNK9yIy0es32nIYyyoYz+g19sCBbuu/TH0YZTXVdlmbbKKOQKK
        37tZnXMrrclxunDH+DjTP0dzn8m0X95GBIDJReT+R8yJWy7nJm/FvV2AcHlGUdXooMN1HyQyKg3
        g7h4DpcExStu4CTBpco59hKKq
X-Received: by 2002:a0c:8067:0:b0:4c6:f5e2:f13a with SMTP id 94-20020a0c8067000000b004c6f5e2f13amr115831002qva.37.1673661407149;
        Fri, 13 Jan 2023 17:56:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZl/PpthyxDzFL+KrWDgOWGYjIZfEmrSWqy8vxMd9Aa5yd8txUc+zlb9SV3mWCyRBu7AkMNA==
X-Received: by 2002:a0c:8067:0:b0:4c6:f5e2:f13a with SMTP id 94-20020a0c8067000000b004c6f5e2f13amr115830987qva.37.1673661406887;
        Fri, 13 Jan 2023 17:56:46 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13774578qko.23.2023.01.13.17.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:56:46 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mikelley@microsoft.com, jinankjain@linux.microsoft.com,
        nunodasneves@linux.microsoft.com
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/hyperv: conditionally build hv_get_nested_reg()
Date:   Fri, 13 Jan 2023 20:56:43 -0500
Message-Id: <20230114015643.3950640-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
[arch/x86/kernel/cpu/mshyperv.c:44]: (style) The function 'hv_get_nested_reg' is never used.

hv_get_nested_reg() is built unconditially but is only used conditionally in
hv_get_register() and hv_set_register() by CONFIG_HYPERV.

Move the conditional #if to also include hv_get_nested_reg()

Fixes: 89acd9b2ff8e ("Drivers: hv: Setup synic registers in case of nested root partition")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b8bb13daacf7..9ca202970569 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,6 +41,7 @@ bool hv_root_partition;
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
+#if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_reg(unsigned int reg)
 {
 	switch (reg) {
@@ -61,7 +62,6 @@ static inline unsigned int hv_get_nested_reg(unsigned int reg)
 	}
 }
 
-#if IS_ENABLED(CONFIG_HYPERV)
 u64 hv_get_non_nested_register(unsigned int reg)
 {
 	u64 value;
-- 
2.27.0

