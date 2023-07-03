Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A0745A54
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGCKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGCKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:33:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF99EE;
        Mon,  3 Jul 2023 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jUUST+pTV/4ng8wB0em4I/zFSWFIzrwruNy94bYcubQ=; b=bZgglhjrJ9YzLn+sG4WglTktGF
        8iD39nRKO6vYiN18s57xpXy8ME8jpneRQ0CQfnyuxwtVdOGclfdRXbL9xP4PczkHSrOSMxa1xIQqE
        e7kZHTcGzsajOCD42RZrrlDDMrQzLkhtWEMvpeh/eOkt8E04HDdygN/2Khzux068xzCMeTPwp5nNo
        QID/rvjDCHnwEX45sW6agBYfeu/cev378Sn3V1bJP4RV3L/HzTyIlvEcEqbT3fhoA135y1TJtU8zS
        90D8fp+MjYAMvhoxleMVeBzeVfCtrRmZcNU8+X21wp9BagLWJ6bo/XklHUGzd0pteOH6vgFW4VqzP
        T+kPvzyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGGrY-00A3wH-1j;
        Mon, 03 Jul 2023 10:32:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A32630012F;
        Mon,  3 Jul 2023 12:32:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11721202A2A17; Mon,  3 Jul 2023 12:32:56 +0200 (CEST)
Date:   Mon, 3 Jul 2023 12:32:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v4 4/4] intel_idle: Add ibrs_off module parameter to
 force disable IBRS
Message-ID: <20230703103255.GE4253@hirez.programming.kicks-ass.net>
References: <20230628022554.1638318-1-longman@redhat.com>
 <20230628022554.1638318-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628022554.1638318-5-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:25:54PM -0400, Waiman Long wrote:

> @@ -69,6 +69,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
>  static unsigned int disabled_states_mask __read_mostly;
>  static unsigned int preferred_states_mask __read_mostly;
>  static bool force_irq_on __read_mostly;
> +static bool ibrs_off __read_mostly;
>  
>  static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
>  
> @@ -1919,12 +1920,15 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>  	}
>  
>  	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
> -			   state->flags & CPUIDLE_FLAG_IBRS) {
> +			((state->flags & CPUIDLE_FLAG_IBRS) || ibrs_off)) {
>  		/*
>  		 * IBRS mitigation requires that C-states are entered
>  		 * with interrupts disabled.
>  		 */
> -		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
> +		if (ibrs_off && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
> +			state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
> +		else
> +			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);

If you're respinning this, you can leave out the else and avoid the
indent on the WARN:

+		if (ibrs_off && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
+			state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);

Same effect, simpler code and all that.

>  		state->enter = intel_idle_ibrs;
>  		return;
>  	}
