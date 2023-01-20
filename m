Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D7676026
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjATWZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:25:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04C61AB;
        Fri, 20 Jan 2023 14:25:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41272620C9;
        Fri, 20 Jan 2023 22:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F50C433D2;
        Fri, 20 Jan 2023 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674253543;
        bh=qZS/7/GOzpHQKm/h9ObL2qWFU4ssJxaos9J2z8A2QPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2r6q1n3ZFj47g1FU8qoI4wfGM/c2v3nz2PDFSgYdHVyeY+QOYMhI0/xiqdTDU8P3
         bkWTfDClcn5fgu19DOv5OcEhApTug6u4vSrbyBQ2kxg4C8/XMf0Qa05cQlVoCQcIpB
         avAiiVod7n/uEiRW3LrEB/kYbMBuBeFgeYUz/hCERQzbAHBrUkDpj7cBGzv9CyooRL
         huqR6gFPGy3e5G315es7LEJgh0yYtMbGSXnAA1WCpvoRQoDHiSFJd2iWrW22xEP+vd
         DtTmtXeCGqRptMY6O8niZqt4YOEA4oXEPQNeWHQioZJuCveHW6PMD24aogrNnBs4Pv
         dyC7S7qql8JAQ==
Date:   Fri, 20 Jan 2023 23:25:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with
 nohz subsystem
Message-ID: <Y8sU5ADeKpow5aUY@lothringen>
References: <20230119204434.4017605-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119204434.4017605-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Google) wrote:
> -static int tick_nohz_cpu_down(unsigned int cpu)
> +static int tick_nohz_cpu_hotplug_ret(unsigned int cpu)
>  {
>  	/*
>  	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
> @@ -522,6 +522,16 @@ static int tick_nohz_cpu_down(unsigned int cpu)
>  	return 0;
>  }
>  
> +static int tick_nohz_cpu_down(unsigned int cpu)
> +{
> +	return tick_nohz_cpu_hotplug_ret(cpu);
> +}
> +
> +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
> +{
> +	return tick_nohz_cpu_hotplug_ret(cpu) == 0;

This is still calling the hotplug function for the CPU in order to know if the
CPU is hotpluggable...

Why not:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ba2ac1469d47..a46506f7ec6d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -532,7 +532,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
-static int tick_nohz_cpu_down(unsigned int cpu)
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
 	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
@@ -540,8 +540,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
-		return -EBUSY;
-	return 0;
+		return false;
+	return true;
+}
+
+static int tick_nohz_cpu_down(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
 }
 
 void __init tick_nohz_init(void)




>  void __init tick_nohz_init(void)
>  {
>  	int cpu, ret;
> -- 
> 2.39.0.246.g2a6d74b583-goog
> 
