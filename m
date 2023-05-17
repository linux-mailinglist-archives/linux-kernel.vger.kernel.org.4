Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98095707261
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjEQTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQTlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056211F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D9E62C1F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3093C433EF;
        Wed, 17 May 2023 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684352469;
        bh=NG9a8/HxZiREAt48f4XHXBbPjBYheg34T+R3HqxYF04=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KrIqwaxHjOrDIPcl5GFZ4nH02dTUeLfqkP1kFzv/oso+V9602cACvTve631+G0rWd
         qtmhyeex4Ww16mQqeXJe4I0VdROcdDIphtG8zWUwkGE3VVRJZZ7LU6zfFzPwYK8lB/
         fPBBGX+YK0Zdziz8IjNrQ7PzM9+6teg4K2OYcAg+f4cPl0CHM0mKhaY5eaKYbHXlD1
         9k4SV00HQBe9mmYDJwkCc8m+jajh5QE9FlFrVGp0Uh9NpFSbFGrQnduYLqVJb+5HOo
         6zT00Pg9RJ4tOu/96uMrG1I/nGlSr1tYtyyNU/nvtjXO6MupmAlnFlhPFd+Ip+Gvxv
         LhBFq2V8MuPgA==
Date:   Wed, 17 May 2023 12:41:06 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: xen_debug_interrupt prototype to global header
In-Reply-To: <20230517124525.929201-1-arnd@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2305171240550.128889@ubuntu-linux-20-04-desktop>
References: <20230517124525.929201-1-arnd@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The xen_debug_interrupt() function is only called on x86, which has a
> prototype in an architecture specific header, but the definition also
> exists on others, where the lack of a prototype causes a W=1 warning:
> 
> drivers/xen/events/events_2l.c:264:13: error: no previous prototype for 'xen_debug_interrupt' [-Werror=missing-prototypes]
> 
> Move the prototype into a global header instead to avoid this warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/x86/xen/xen-ops.h | 2 --
>  include/xen/events.h   | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
> index 84a35ff1e0c9..0f71ee3fe86b 100644
> --- a/arch/x86/xen/xen-ops.h
> +++ b/arch/x86/xen/xen-ops.h
> @@ -72,8 +72,6 @@ void xen_restore_time_memory_area(void);
>  void xen_init_time_ops(void);
>  void xen_hvm_init_time_ops(void);
>  
> -irqreturn_t xen_debug_interrupt(int irq, void *dev_id);
> -
>  bool xen_vcpu_stolen(int vcpu);
>  
>  void xen_vcpu_setup(int cpu);
> diff --git a/include/xen/events.h b/include/xen/events.h
> index 44c2855c76d1..ac1281c5ead6 100644
> --- a/include/xen/events.h
> +++ b/include/xen/events.h
> @@ -138,4 +138,7 @@ int xen_test_irq_shared(int irq);
>  
>  /* initialize Xen IRQ subsystem */
>  void xen_init_IRQ(void);
> +
> +irqreturn_t xen_debug_interrupt(int irq, void *dev_id);
> +
>  #endif	/* _XEN_EVENTS_H */
> -- 
> 2.39.2
> 
