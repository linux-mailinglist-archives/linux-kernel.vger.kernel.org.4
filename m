Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C964ED63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiLPPFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiLPPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:05:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BCD5EDE2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:05:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so6855895eju.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx9LDDMonJXCHAOEK4zNyt/uyyr/R3Q1LY7CsDVkBng=;
        b=tGpMdq7Kwibgu2mRvf++7d/oi2e8xt7todBd0XWZDZjND7UkqeF4plqbdLW14bnGMS
         x3Z21HGKHuddpZBPnFiVJOHAugVjRXomYmsaBlSQcezJ2MAz4EVAW2vRQbHtgiV73gN7
         ZY+nEIr+xC1c7t4ehh96pKzqTi19hoVT51JUnXMtrCZiYUxMsHNucgNhNMIBdhuA72qL
         /SpWDOO02mf0su2sFRXiboics0+KzQx8mC4r/udaDvYD7lMhdx91QaZLyXLaDJOJ07tB
         0+uCK8lLM++SQcWEt/JAWbBQlQZ5N+Yfyoungfj6kAk93FObRSpb7I6Wvl1kIUEtvm/I
         5SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx9LDDMonJXCHAOEK4zNyt/uyyr/R3Q1LY7CsDVkBng=;
        b=wcohAWoimDNi1l+TE15D2Fna4lD2fL02bmz6xcX5pf2MXeiGsBJ93fcVm/GTwNfXRn
         fxN/WvyNH4YI0o2cuUMbavRzXknjhW47RKjQ4CNqR/FSqSdMXldLaOpsVrUn28AbjhDl
         f/wiOXia7EM09g4+3yOAm3hR7jgBxkmcdQFlANEN70AZOsJWbgibYf+3GvBsPeuD/BgO
         DESoAbskvviycXs8I4YDMRh6HtwyvYJO/qK95m5oajrYaQ5WqFo3Aks+IwmfvJbhKZOQ
         zJs8IWQur4Xsix98b6C6DFFqv5UmXXPvlC+6X0sweaEpZCGNYFhV/4jb0RGm8plhgLDb
         nP7g==
X-Gm-Message-State: ANoB5pmGCasiooG8N2lcL6LSvEALVJnWOYGD8XSa54M8+8n7NYZMAn2s
        D2F0GesOd5kRBUettn6C2SF/tPYB8JfSZib2
X-Google-Smtp-Source: AA0mqf4Nat12N8CuCRsRWRZrI2y5m3Rg/KQk+CKY4AANOZr7qN/BcqXELlOe705pZquKZI3L4idO0g==
X-Received: by 2002:a17:906:a08c:b0:7ad:fe21:7a15 with SMTP id q12-20020a170906a08c00b007adfe217a15mr24302330ejy.22.1671203098391;
        Fri, 16 Dec 2022 07:04:58 -0800 (PST)
Received: from localhost.localdomain (p200300d9973eac0005dbc67c2510e9a9.dip0.t-ipconnect.de. [2003:d9:973e:ac00:5db:c67c:2510:e9a9])
        by smtp.googlemail.com with ESMTPSA id z1-20020a1709063a0100b00780982d77d1sm929456eje.154.2022.12.16.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:04:58 -0800 (PST)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>,
        "Sun, Jiebin" <jiebin.sun@intel.com>
Subject: [PATCH 2/3] include/linux/percpu_counter.h: Race in uniprocessor percpu_counter_add()
Date:   Fri, 16 Dec 2022 16:04:40 +0100
Message-Id: <20221216150441.200533-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216150441.200533-1-manfred@colorfullife.com>
References: <20221216150155.200389-1-manfred@colorfullife.com>
 <20221216150441.200533-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu interface is supposed to be preempt and irq safe.

But:
The uniprocessor implementation of percpu_counter_add() is not irq safe:
if an interrupt happens during the +=, then the result is undefined.

Therefore: switch from preempt_disable() to local_irq_save().
This prevents interrupts from interrupting the +=, and as a side effect
prevents preemption.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: "Sun, Jiebin" <jiebin.sun@intel.com>
---
 include/linux/percpu_counter.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index a3aae8d57a42..521a733e21a9 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -152,9 +152,11 @@ __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
 static inline void
 percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 {
-	preempt_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	fbc->count += amount;
-	preempt_enable();
+	local_irq_restore(flags);
 }
 
 /* non-SMP percpu_counter_add_local is the same with percpu_counter_add */
-- 
2.38.1

