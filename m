Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA17396F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjFVFqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFVFqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45B19F;
        Wed, 21 Jun 2023 22:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E342F61767;
        Thu, 22 Jun 2023 05:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8568C433C0;
        Thu, 22 Jun 2023 05:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687412795;
        bh=uZclBeKStX/fZ+zdzQQVR/V73bJdFZL4odhSDY8NQjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bq7A6O6+DP7oA07uYhI6eQ6ytpwKtm5ktEsOBlSqqvPrkPQlce8pldPPtJgLBOEwO
         Z/CYLUyh9rjEpnIya0YHz+55v/aBAneZfqJgYHSlcfKqugD1RF5YHpWl0kabLqkwrm
         p/ijqPHNTdR6LH5VgfJqf+lTslaa/j8EH2j/XCLl22/nf/6Of79oTtsc/v3PRShdIm
         nt4LZ0VM4Kva4479ggSWvM2aaoryCZ5O1SDDN+rjFCkfGnh8ZgIQdxXm59qo1pyUyY
         hQNFWrShbM/U6BEDVCj92kTgc5xULWuh4MDf0V1XVJi4v3av5fL6PjADgix5LIv8Gs
         QNkBf27Uhvy6g==
Date:   Wed, 21 Jun 2023 22:46:33 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v3 2/3] intel_idle: Sync up the SPEC_CTRL MSR value to
 x86_spec_ctrl_current
Message-ID: <20230622054633.ulrurzzvzjijvdhn@treble>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230622003603.1188364-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:36:02PM -0400, Waiman Long wrote:
> When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to
> 0 in order disable IBRS. However, the new MSR value isn't reflected
> in x86_spec_ctrl_current which is at odd with the other code that
> keep track of its state in that percpu variable. Fix that by updating
> x86_spec_ctrl_current percpu value to always match the content of the
> SPEC_CTRL MSR.

Is this fixing an actual bug or is there some other reason for doing
this?

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/idle/intel_idle.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index aa2d19db2b1d..07fa23707b3c 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -181,13 +181,17 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>  	u64 spec_ctrl = spec_ctrl_current();
>  	int ret;
>  
> -	if (smt_active)
> +	if (smt_active) {
> +		__this_cpu_write(x86_spec_ctrl_current, 0);
>  		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +	}
>  
>  	ret = __intel_idle(dev, drv, index);
>  
> -	if (smt_active)
> +	if (smt_active) {
>  		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
> +		__this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
> +	}

More candidates for update_spec_ctrl()?

-- 
Josh
