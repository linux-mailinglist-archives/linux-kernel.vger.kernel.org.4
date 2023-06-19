Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93682735C34
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjFSQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFSQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:31:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B6A10E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:31:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687192316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYKT1Z+JVwwJsKw0q3cks8YKnol3mCoxnKVkfPe7seM=;
        b=v8l87Zm2qhJ70z7OOsuLY7kIzTLpPY808eWRKCNJwvv4Ix0ysWr257Ewl/9JO9NScW84nt
        b88Qjwyg6qTtTrYUgtH+1JbPaPV6roeVyEp8S1CpLKXLy04gwKVx40PvHjStUQDH5/46yz
        ZWU/jGDP6OrEEA//gX+BzOckTw6A+mOtwpiPhjgbfBPmkjR49M9tlwu2VcZbuijeGtI8jI
        52mKv73dSJ6AzW4ny3FYO6YyH3YlGtKETL57TmES62grU5O2Zz5+Ffer4kt8VpEGwATG5W
        E2NMr37Dk9yxJWfkCiN1mcVk9AxNQNIvbQ56I7bSwFfj/83QGi+Nb2arXYNV4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687192316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYKT1Z+JVwwJsKw0q3cks8YKnol3mCoxnKVkfPe7seM=;
        b=yToMZ8wkEKPMu7VfAZS2p+jBxNcyGohRuDUmZurihVjTEqSoBdMYQkFX6fRZHylj5EUn4i
        uv6pVLBR2wcmdiBQ==
To:     Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, gorcunov@openvz.org, suresh.b.siddha@intel.com,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v1] x86/apic: Fix kernel panic when "intremap=off" and
 "x2apic_phys" are set
In-Reply-To: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
References: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
Date:   Mon, 19 Jun 2023 18:31:55 +0200
Message-ID: <871qi7qupw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17 2023 at 02:52, Dheeraj Kumar Srivastava wrote:
> x2APIC mode requires "Interrupt Remapping" to be enabled and the
> "physical x2apic" driver can be used only when x2APIC mode is enabled.
> However when "intremap=off" and "x2apic_phys" kernel command line
> parameters are passed, "physical x2apic" driver is being used even when
> x2APIC mode is disabled ("intremap=off" disables x2APIC mode).
> This results in the below kernel panic:
>
>   unchecked MSR access error: RDMSR from 0x80f at rIP: 0xffffffff87eab4ec
>   (native_read_msr+0xc/0x40)
>   Call Trace:
>   <TASK>
>   native_apic_msr_read+0x1f/0x30
>   setup_local_APIC+0x4e/0x380
>   ? zen_untrain_ret+0x1/0x1
>   ? enable_IR_x2apic+0xe8/0x250
>   apic_intr_mode_init+0x4c/0x120
>   x86_late_time_init+0x28/0x40
>   start_kernel+0x626/0xa80
>   x86_64_start_reservations+0x1c/0x30
>   x86_64_start_kernel+0xbf/0x110
>   secondary_startup_64_no_verify+0x10b/0x10b
>   </TASK>
>
> This is due to an incorrect conditional check in x2apic_phys_probe().
> Fix it here by returning 0 when "x2apic_mode" is not set in
> x2apic_phys_probe(). This now prevents default_setup_apic_routing() from
> selecting "physical x2apic" driver.
>
> Fixes: 9ebd680bd029 ("x86, apic: Use probe routines to simplify apic selection")
> Reviewed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
