Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C080F6992C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjBPLKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjBPLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:10:13 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917F4224
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:10:12 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PHXKX1zpxz9sTL;
        Thu, 16 Feb 2023 12:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1676545808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cp0Jdbn8qsTqbb34HVg+YijwzLsVoOWb0viZR1J/NEg=;
        b=xhZpkWeZ/fKKIJ56LZV7DW+vtFSYAO4yGTaTSnS9icbXPXfPTJWUPXdIsWTf97M5tLtWJ/
        ZfhUzUw2L9M7NPVVX2Df/CQso1N32VXAtbKCQREKtC2kcff2QEwrqry30kyTDXdwuBhnyX
        RXlfb0Z6lG5IShP1y4TcuEwlVcjBkkbqAu53meTrjub+H65r6lM4IIYR/7PQ54EMcQSu8C
        /JIE5ORo7J35uPTuAzAViXFW51mhQN7Qz2Fe7gG0qlGxGIr22I65SCBLQAy4BzcUUGBKRP
        9EgFJZeJqo2gmeAH4434kMLNzOabqegBakU2Yg4UgS2oK47YtwqEVOdaTV+EFQ==
Date:   Thu, 16 Feb 2023 12:10:05 +0100
From:   "Erhard F." <erhard_f@mailbox.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 6.2-rc7 fails building on Talos II: memory.c:(.text+0x2e14):
 undefined reference to `hash__tlb_flush'
Message-ID: <20230216121005.5033ffec@yea>
In-Reply-To: <a2b50c13-6ddc-e310-559e-ee429e96c527@csgroup.eu>
References: <20230216005535.6bff7aa6@yea>
        <a2b50c13-6ddc-e310-559e-ee429e96c527@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1eab50639c59a028a84
X-MBO-RS-META: eie6moxr4du9w8diask4c8su8orzgfn5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 06:29:52 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Can you try with :
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h 
> b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> index d5cd16270c5d..2bbc0fcce04a 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> @@ -97,8 +97,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>   {
>   	if (radix_enabled())
>   		radix__tlb_flush(tlb);
> -
> -	return hash__tlb_flush(tlb);
> +	else
> +		hash__tlb_flush(tlb);
>   }
> 
>   #ifdef CONFIG_SMP

With the patch applied my 6.2-rc7 .config builds. Thanks Christophe!

Regards,
Erhard
