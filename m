Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12A5EC6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiI0Oj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiI0Oj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:39:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8B659E5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:35:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4McMby15FRz4x3w;
        Wed, 28 Sep 2022 00:35:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1664289327;
        bh=UWxzGMQ9wLrUZe/HWPNAFfpFCGdiaXy8kMeH+LApu/c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MOtxzu3QNT9wNQFnE2dLYzyNrc+qt2UT7wT3HSspcZg29VNc/5GMr315CeNUXxBlQ
         Lu2vGDxYToXvbHP/8E+bCJv+hYnDHhfic4uyK7nBvlziKQiceNTGsel7/sOcRs/ejJ
         WaZWTtxw8DXRESZyDEHToeo8fQ8YEXG+iGHiqOVaYtx/7eJFAwykeAm4V9uNJ9TEgA
         VV9OpL4qMyhyBCwOeip5NEkQ/QcwSdi6iArsH01EEybM2SCf24MzmpKPU91UKcliS1
         PNqRZEtVMMw/P352iSbN8OHZ4DgYQcTa8aHYrohOtQHIHqmbA7ifkslU/kpzIibnA+
         FSwQPgn5YX71A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     cgel.zte@gmail.com, benh@kernel.crashing.org
Cc:     paulus@samba.org, maz@kernel.org, jgg@ziepe.ca, tglx@linutronix.de,
        lv.ruyi@zte.com.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] powerpc/fsl_msi: fix return error value in error
 handing path
In-Reply-To: <20220425024149.3437751-1-lv.ruyi@zte.com.cn>
References: <20220425024149.3437751-1-lv.ruyi@zte.com.cn>
Date:   Wed, 28 Sep 2022 00:35:25 +1000
Message-ID: <87edvwzxzm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> This function fsl_msi_setup_hwirq() seems to return zero on success and
> non-zero on failure, but it returns zero in error handing path.

I agree it seems wrong, but I can't be sure the current code is wrong,
so unless you're able to test this on actual hardware (or qemu), I'll
drop this patch.

cheers

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  arch/powerpc/sysdev/fsl_msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
> index b3475ae9f236..10f974cfa2f3 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -353,7 +353,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
>  	if (!virt_msir) {
>  		dev_err(&dev->dev, "%s: Cannot translate IRQ index %d\n",
>  			__func__, irq_index);
> -		return 0;
> +		return -EINVAL;
>  	}
>  
>  	cascade_data = kzalloc(sizeof(struct fsl_msi_cascade_data), GFP_KERNEL);
> -- 
> 2.25.1
