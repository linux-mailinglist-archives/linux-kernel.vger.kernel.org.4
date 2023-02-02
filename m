Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4E68896A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjBBV5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBBV5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:57:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24474C0C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:56:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so3012851wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY0vlTeJqZKE/bujXYv8BkLNeLLbxRNo+nzLcSQF4Yk=;
        b=mT6B1rshBPNb/jZfy+ezLKF9F1DIij+0IVLWcPLJlhIuz9rWYW2KEjB1Y7FU0/wz+G
         5shof2tQQ1/OeP0PXIEdn+vb45K+y/ZQrIRGyltWRu+W1SbfKZevi8GwRtF2Qqa4MjMB
         CF604H0RNfdRfoiES6rIq+gBMd40gYDdx0mdoYb52uCQklmOvJi+ZhCc28hUV0VtChrG
         JMWhH3EZUAkdoBcl+TiGFjVPHAKepRIphktMOO7i9F1crxCsP4nV4wctgZXLbfz+Gqhk
         BBnBIdbmEtUJurgh33VP9Wjgw42VOF2cDjHx3VbxEkayBjojfkBAayE+dQ1DNOzSKdlB
         Gk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vY0vlTeJqZKE/bujXYv8BkLNeLLbxRNo+nzLcSQF4Yk=;
        b=w0v3ZpTkEi/irSwPYAf0cbBjxMrA6NeZylxdGVAcOvMwpNeGkNkTRX1i+yhfCK++8a
         7LUVAA0ArcDKlDk5RpooGuJqflSCps7tJ19LwvxBYaCQKUYz/PIx0WPJ/DiuGhDbdXkn
         wvyyq56a4wASzJzqKYbsl0AS+IKBnEBTsyadC+c5MkKqVYiPqdqCl0uqMdymHvS8etoy
         PDU30CA5JeQuXj02mFs99a4QioCfbumUVHaIKKv95Op2iTfW9kivrf5HZvI7XIXmqW4T
         x44FPM5xTbl9I5rAdCBeE7fsyVjkiiUhfti07qD0IJ852m26LrqOYLPRCSGSvq1XF2qq
         caYg==
X-Gm-Message-State: AO0yUKWBhtAz18adGIvm+7H42DqDo8DrwO0opfhZ0ss7WImFmiU4Qjmq
        WepqpBxf/MJbAAa/TePdEn+clA==
X-Google-Smtp-Source: AK7set+OhHgKX9n+m2LlCXlnV8DIDAcrMwMss3DyGb7+C/zsfBmefzr5cV35ZRvERfY5Hwa0ahXd8A==
X-Received: by 2002:a5d:560b:0:b0:2bf:cd9f:37f9 with SMTP id l11-20020a5d560b000000b002bfcd9f37f9mr6581774wrv.4.1675374999213;
        Thu, 02 Feb 2023 13:56:39 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:98fe:e4ee:fc7e:cd71])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d6d08000000b00297dcfdc90fsm506078wrq.24.2023.02.02.13.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:56:38 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v6 09/11] x86/mtrr: Avoid repeated save of MTRRs on boot-time CPU bringup
Date:   Thu,  2 Feb 2023 21:56:23 +0000
Message-Id: <20230202215625.3248306-10-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202215625.3248306-1-usama.arif@bytedance.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

There's no need to repeatedly save the BSP's MTRRs for each AP we bring
up at boot time. And there's no need to use smp_call_function_single()
even for the one time we *do* want to do it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 783f3210d582..b6eae3ad4414 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -721,11 +721,20 @@ void __init mtrr_bp_init(void)
  */
 void mtrr_save_state(void)
 {
+	static bool mtrr_saved;
 	int first_cpu;
 
 	if (!mtrr_enabled())
 		return;
 
+	if (system_state < SYSTEM_RUNNING) {
+		if (!mtrr_saved) {
+			mtrr_save_fixed_ranges(NULL);
+			mtrr_saved = true;
+		}
+		return;
+	}
+
 	first_cpu = cpumask_first(cpu_online_mask);
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
-- 
2.25.1

