Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBA6BAF09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCOLSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjCOLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:18:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4582F4489;
        Wed, 15 Mar 2023 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fLp/3lhmGZhhr6T35BEOzQ7BwCL8lH8JN5yPMH5YQqA=; b=fkBu5WFzLh5l28dnaby02Efvus
        9kFvQpTolF5xxKpH5rjq4/xTE8Bn4Z0Jqxl0BsbtaRhl6WyfYGsdf4/x/8GDVQx6/xGpba/kzd0Rm
        Fm+u0KpufOzhUK/oMlrlMt19uIS4yPmndYnwlLbdGqyiNHjv2kVykldjkEnArTBsHgl9C3WeR/kM5
        o4FkQkjT1K25hmReMEyHmR9KTRSUHT5Qiu8Zx0fLzjr5+XjLZlwQea00S/W6xVocHoN/XYVTA6p4W
        4Ych9bWQ6vyzbeMpeWlUYV0Gie1ywZZNPGdrCgeleMDxmKGukAunjxbezWWoQjCkEpRUZdxpd2jjU
        84C02fuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcP73-0025TW-0p;
        Wed, 15 Mar 2023 11:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA5E13001F7;
        Wed, 15 Mar 2023 12:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 680F2212F1AE1; Wed, 15 Mar 2023 12:16:06 +0100 (CET)
Date:   Wed, 15 Mar 2023 12:16:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Klimov <alexey.klimov@linaro.org>
Cc:     draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
Message-ID: <20230315111606.GB2006103@hirez.programming.kicks-ass.net>
References: <20230314230004.961993-1-alexey.klimov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314230004.961993-1-alexey.klimov@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(could you wrap your email please)

On Tue, Mar 14, 2023 at 11:00:04PM +0000, Alexey Klimov wrote:
> #regzbot introduced: 0c5ffc3d7b15 #regzbot title:
> CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck
> reboots
> 
> The upstream changes are being merged into android-mainline repo and
> at some point we started to observe kernel panics on reboot or long
> reboot times.

On what hardware? I find it somewhat hard to follow this DT code :/

> Looks like adding CPUIDLE_FLAG_RCU_IDLE flag to idle driver caused
> this behaviour.  The minimal change that is required for this system
> to avoid the regression would be one liner that removes the flag
> (below).
> 
> But if it is a real regression, then other idle drivers if used will
> likely cause this regression too withe same ufshcd driver. There is
> also a suspicion that CPUIDLE_FLAG_RCU_IDLE just revealed or uncovered
> some other problem.
> 
> Any thoughts on this? 

So ARM has a weird 'rule' in that idle state 0 (wfi) should not have
RCU_IDLE set, while others should have.

Of the dt_init_idle_driver() users:

 - cpuidle-arm: arm_enter_idle_state()
 - cpuidle-big_little: bl_enter_powerdown() does ct_cpuidle_{enter,exit}()
 - cpuidle-psci: psci_enter_idle_state() uses CPU_PM_CPU_IDLE_ENTER_PARAM_RCU()
 - cpuidle-qcom-spm: spm_enter_idle_state() uses CPU_PM_CPU_IDLE_ENTER_PARAM()
 - cpuidle-riscv-sbi: sbi_cpuidle_enter_state() uses CPU_PM_CPU_IDLE_ENTER_*_PARAM()

All of them start on index 1 and hence should have RCU_IDLE set, but at
least the arm, qcom-spm and riscv-sbi don't actually appear to abide by
the rules.

Fixing that gives me the below; does that help?

---

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 7cfb980a357d..58fa81f0fa7d 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -39,7 +39,7 @@ static __cpuidle int arm_enter_idle_state(struct cpuidle_device *dev,
 	 * will call the CPU ops suspend protocol with idle index as a
 	 * parameter.
 	 */
-	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
+	return CPU_PM_CPU_IDLE_ENTER_RCU(arm_cpuidle_suspend, idx);
 }
 
 static struct cpuidle_driver arm_idle_driver __initdata = {
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index c6e2e91bb4c3..429db2d40114 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -64,7 +64,7 @@ static __cpuidle int spm_enter_idle_state(struct cpuidle_device *dev,
 	struct cpuidle_qcom_spm_data *data = container_of(drv, struct cpuidle_qcom_spm_data,
 							  cpuidle_driver);
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(qcom_cpu_spc, idx, data->spm);
+	return CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(qcom_cpu_spc, idx, data->spm);
 }
 
 static struct cpuidle_driver qcom_spm_idle_driver = {
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index be383f4b6855..04a601cda06b 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -100,10 +100,9 @@ static __cpuidle int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
 	u32 state = states[idx];
 
 	if (state & SBI_HSM_SUSP_NON_RET_BIT)
-		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, state);
-	else
-		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
-							     idx, state);
+		return CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(sbi_suspend, idx, state);
+
+	return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM_RCU(sbi_suspend, idx, state);
 }
 
 static __cpuidle int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..dd92bdafe2d3 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -334,6 +334,9 @@ extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 #define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
 	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 0, 0)
 
+#define CPU_PM_CPU_IDLE_ENTER_RCU(low_level_idle_enter, idx)	\
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 0, 1)
+
 #define CPU_PM_CPU_IDLE_ENTER_RETENTION(low_level_idle_enter, idx)	\
 	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 1, 0)
 
