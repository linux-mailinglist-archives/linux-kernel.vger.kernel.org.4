Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B164D870
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLOJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLOJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:20:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007733F04A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:20:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2080626pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wu5pKKt/tYg5j4ptIlawG89Bmd9AY8kHRaAGqPqkAs=;
        b=QFKuTxlmPSvSiGvceKI4jRcxQaPyAjRxEIe0jeAsm9mJMiBq4DitPskSJWUUIb4B3w
         Smq+oC/Sz4TApQ7i4RMCOwudRKNzT/ErbL+9E8ebSRVa9h1nO25UAc4SIBSSFhssMpa1
         Dun3NPFKzDk4ylkMUEPnMux4UJCxWM3rpzY8klpS57EKwJG15KH41hXr96Ojped9mj9S
         IKt3vhb7yUx46syZ8OB4D6Eiz7vxQvN2kF5HpaamIlywYdVBGiW234HXFT9RGq8DYvaS
         T8pIp7dw91J9GUx1aHr67DFfP+V6xKoqmakiltZ33fGFh6NaYmwwQ7At/x8CXsL3RXe4
         w9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Wu5pKKt/tYg5j4ptIlawG89Bmd9AY8kHRaAGqPqkAs=;
        b=AiX7QgBwvgyqkeuRe7JobAbSG29Iy/NJBx6BET1KFydjkRfbH8NUCVGRjVo1cMXg0Z
         H54zGqrQLfQ6sM9Wt2eILsQRC0B4XQSUC48gCflnFR/5p4oRpulJN4dBXnRDcFuWNaUb
         GBecNrCZtr0ITJ2q1/rVsY2/uH8yVpw1Vb9mcA1Wj87SMbhOABOjPYCNXwIQzmUcBcA6
         x8fiRRcgugQ25QAfawamADiOzl5OZbxFV0UASxGOv9IxWPzan0sCzhaFSYrBn0DU6IXQ
         cZAQXvYadLJ7rSME/sKkm8Bpvi9V+pBu7FwMdtWJBrfHPMHHcSMDKiC831WoJ25Wn/G2
         MEHQ==
X-Gm-Message-State: ANoB5plJ8Ya0DP6MvyvL6eAdeT1jThRruhj/jNKbkks3pqQ2mu2CWd2a
        4vnAs3jWZhgIWBZYDvuomjezvA==
X-Google-Smtp-Source: AA0mqf70RQs4sQ5MceUFw8rJq3Pan6mecsXIuJiWTtzNDL4Zj6BVMoEbSzC2IGLD52G5Dj5oAUME7Q==
X-Received: by 2002:a17:903:4283:b0:189:7100:c50e with SMTP id ju3-20020a170903428300b001897100c50emr29499311plb.48.1671096010440;
        Thu, 15 Dec 2022 01:20:10 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id n15-20020a170903110f00b00188f8badbcdsm3302643plh.137.2022.12.15.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:20:10 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     shakeelb@google.com, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, hannes@cmpxchg.org, vbabka@suse.cz,
        willy@infradead.org, vasily.averin@linux.dev,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/memcontrol: Skip root memcg in memcg_memory_event_mm
Date:   Thu, 15 Dec 2022 09:19:07 +0000
Message-Id: <20221215091907.763801-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory events aren't supported on root cgroup, so there is no need
to account MEMCG_OOM_KILL on root memcg.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 567f12323f55..09f75161a3bc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1142,7 +1142,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
-	if (likely(memcg))
+	if (likely(memcg && !mem_cgroup_is_root(memcg)))
 		memcg_memory_event(memcg, event);
 	rcu_read_unlock();
 }
-- 
2.25.1

