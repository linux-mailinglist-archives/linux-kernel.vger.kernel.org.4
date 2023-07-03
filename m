Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F074558D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGCGly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCGlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:41:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E718CC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1688366505;
        bh=SN/rqNOkg+BIF6QEZthBWLDM9wkNG/KuvshHNv3WAaU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=orPFhELO3x8zhKRBvFINPr9F22tOnD/GhNoegEV88m1K6gEhq++oIuYIWchaBYwLE
         WlJV8fZ8rjUF/79SjbaS1A5B+IdxU8KGoM8POcfmbBWwTjEhVWNL0NUCcR2GKjmgmr
         mQvcvy7CQEk4cJllSjWqMSsjQLt5tPshjs7kP4vyvs9NTDrxaAGmIIwh/LDiI/6nPs
         sb+CJzgj+jjQNmT71spEfLqrIilpqBoUF6Isc3/ujiB3RXg4oa/qPeOSwwi6CYa/5D
         1VZDebBZZbGruRDJhAAEllFwQ+scA7gqasszGYYE+4Qo5dzYTleeTuuBxeFe1uU3pF
         kd0UIeWQgBslg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvbtc66BSz4wqX;
        Mon,  3 Jul 2023 16:41:44 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     Gautam Menghani <gautam@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove unnecessary endian conversion code
 in XICS
In-Reply-To: <20230630055628.17790-1-gautam@linux.ibm.com>
References: <20230630055628.17790-1-gautam@linux.ibm.com>
Date:   Mon, 03 Jul 2023 16:41:41 +1000
Message-ID: <878rbxwl7e.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautam Menghani <gautam@linux.ibm.com> writes:
> Remove an unnecessary piece of code that does an endianness conversion but
> does not use the result. The following warning was reported by Clang's
> static analyzer:
>
> arch/powerpc/sysdev/xics/ics-opal.c:114:2: warning: Value stored to
> 'server' is never read [deadcode.DeadStores]
>         server = be16_to_cpu(oserver);
>
> As the result of endianness conversion is never used, delete the line
> and fix the warning.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/sysdev/xics/ics-opal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
> index 6cfbb4fac7fb..5fe73dabab79 100644
> --- a/arch/powerpc/sysdev/xics/ics-opal.c
> +++ b/arch/powerpc/sysdev/xics/ics-opal.c
> @@ -111,7 +111,6 @@ static int ics_opal_set_affinity(struct irq_data *d,
>  		       __func__, d->irq, hw_irq, rc);
>  		return -1;
>  	}
> -	server = be16_to_cpu(oserver);
>  
>  	wanted_server = xics_get_irq_server(d->irq, cpumask, 1);
>  	if (wanted_server < 0) {

My first question with a patch like this is always going to be "how did
the code end up like this?"

Has the code changed and this assignment became unused? If so the commit
that did that should be identified.

If the code has always been like this that's also useful to know. Or
something else happened for it to end up this way :)

The second question will be "is there actually a bug here?". ie. should
server actually be used, and the bug is not that it's a dead assignment
but rather that server is not where it should be.

cheers
