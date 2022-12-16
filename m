Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526EC64ED64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiLPPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiLPPFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:05:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129D35FBA5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:05:04 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz12so6764341ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyUCUG6V1YXnG4+Utm9POFDhIKIlQ77/PNhTST9BZEY=;
        b=7kUXBWg5N/sWO56ZCcrYsszd5Iur1Mz6vii+jvlPc6DvzZ8Poe6eARlfMHbWDY+eVl
         AFcIv5rPzjU0zPEWiyIO19JoilMxW9xtO3sRJQiDFPGseF1uZdlWnkF7qpJp3ieSWmJn
         BhFn/RdMTnk2w5UIaESFeVRJwcoxGuycae212iheU3BxSDKc4q72ob3UWFpxhcEQrgr8
         pKcHCr62XVkOBXayvbh4Qa0UZ6AhDVgIoqe/dGUcE0PIms9aPwlGUIlEDhz+d28YhN0+
         salfD5RlIj6odir80AI/AxmFZBLrbkrQJ4o5AdB5ONa6b2uB43WzBoNm9SrxFNEbPtvj
         nFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyUCUG6V1YXnG4+Utm9POFDhIKIlQ77/PNhTST9BZEY=;
        b=hcPSap9gYA3RourMEdv8D/iP6MGbk065GlAgtw3ZhnvbpAed0v//avFl65WKjBSsKy
         +eRvjGqoKRzmIEQ22MmquKDtjK7WVTyT5UuiVcZ6s779lD932bbmA7/qTcWXh/TUVcnS
         Hie337Jf7jn7p29J1FXR3n21Iq/Fo2rlmoy1WMn8PM7I5Mixdhm/aR3jr0lZy+WgM0ow
         T8oDSROmO5GLbbREh5a9cRE1JGML1J/TxehwsTKt0O7uJt/n4gkynpcDcwro+/kAZY+T
         oHjG7wiP4bOUN2fpp9GP3RighkcA/3Gptqk4H+gNVgHzoi4AM0eFFRSQ5ik0fqNJG8fk
         WfwQ==
X-Gm-Message-State: ANoB5plwhbwiWC76x2Zzlbca3oWR/6xp6IvG3S+tv4+sRq+XCDyLjdxo
        9VDbKNFY0KjLZXZ7rLsjZxcQOkfdq73oJX4K
X-Google-Smtp-Source: AA0mqf5wkAi2B3QvEFN6D+Uvc3NyBIGzQBTH4pObg0j/UYQAPt1rQ+zpeB0Kf/J1ouB1uFudu9JHig==
X-Received: by 2002:a17:907:c78f:b0:7c1:4e8f:df2f with SMTP id tz15-20020a170907c78f00b007c14e8fdf2fmr40633162ejc.17.1671203102404;
        Fri, 16 Dec 2022 07:05:02 -0800 (PST)
Received: from localhost.localdomain (p200300d9973eac0005dbc67c2510e9a9.dip0.t-ipconnect.de. [2003:d9:973e:ac00:5db:c67c:2510:e9a9])
        by smtp.googlemail.com with ESMTPSA id z1-20020a1709063a0100b00780982d77d1sm929456eje.154.2022.12.16.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:05:02 -0800 (PST)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Subject: [PATCH 3/3] kernel/irq/manage.c: disable_irq() might sleep.
Date:   Fri, 16 Dec 2022 16:04:41 +0100
Message-Id: <20221216150441.200533-3-manfred@colorfullife.com>
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

With the introduction of threaded interrupt handlers, it is virtually
never safe to call disable_irq() from non-premptible context.

Thus: Update the documentation, add a might_sleep() to catch any
offenders.

Fixes: 3aa551c9b4c4 ("genirq: add threaded interrupt handler support")

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
---
 kernel/irq/manage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5b7cf28df290..8ce75495e04f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -723,10 +723,13 @@ EXPORT_SYMBOL(disable_irq_nosync);
  *	to complete before returning. If you use this function while
  *	holding a resource the IRQ handler may need you will deadlock.
  *
- *	This function may be called - with care - from IRQ context.
+ *	Can only be called from preemptible code as it might sleep when
+ *	an interrupt thread is associated to @irq.
+ *
  */
 void disable_irq(unsigned int irq)
 {
+	might_sleep();
 	if (!__disable_irq_nosync(irq))
 		synchronize_irq(irq);
 }
-- 
2.38.1

