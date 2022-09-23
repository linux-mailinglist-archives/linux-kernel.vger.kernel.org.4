Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC295E7422
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiIWGaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIWG36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:29:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D50128A30
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:28:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f23so10894878plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=WXct63XdfXnmhrU6JkhDEgH7DhFZYz4ydjHuX9xt76w=;
        b=F3LcOqv9MMAa1OjNe2c8oDp+Y7yfE7B5udJC69BMUWjQAAxPH0W6qwRzPWU4KYLrkB
         1G+McWJQbCE/1gO7CSTGzHcYbWm7bKGidbgru6oGMiMbI0kyK+cz7gloXQ0zgdqhpkku
         kbxt41lcoXybkDxKlv5Hxq33piDkPM2JqDRIp/P8gfiHnGk3xZZ9YgZhr0svY4rAWSN5
         35VZlD6QGxZraaUcTxXVHXF9BvB0SH5NSQxCaHbDKjpkoe/o7RPkRbN5UjrEea4scfhx
         mT+ExVqffmn3XSA3q+jZrycP/QtSUrdspxx2c+0IlDXO0keq/sNHBVhpCbT/H2Qa5fbV
         79Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=WXct63XdfXnmhrU6JkhDEgH7DhFZYz4ydjHuX9xt76w=;
        b=JmJNqyfDVNtmILeI2sS4iqJYOfnJhTADz0+d0FZMJIpqq7yE3iChuWjHBMtWj6YUFl
         gKqynRB+SHi6Ty4XnKfiSOZ1j3hg//+oEYKA0e2pOtwspbtUH+51yTgEy130wys9a/+G
         B3+d4D/KUa3Q0YT8bwRK9GQ2GJOXBI8nd3/FHsTrw/7LXj+b/RQWuWCds8KxYFGe84Nr
         31eepF6lg5mfMYkXCXwb/C4EtGhO8LWDzsytMGF3Cx6XYJy8sFD7qP9EZH818lXX7Iue
         uB9UhnHJz4XUZEL4fx5h7x4Pe9XaSGq48uT1+JA+jMNDVL/xqhrGAdMw5RUo84P3c94z
         xEPQ==
X-Gm-Message-State: ACrzQf2R+fOxxftPBlPZtwHv+aszecJtehQBaLr2lvfwXI1X61aTWdzQ
        TMu1gEVB2HpIJuj4rA1fX+4=
X-Google-Smtp-Source: AMsMyM6NmmWM06lTwON8IcHn3oajWjJmQOdy64FUh3zkaDiGKiEb/bynUKP2tYjAx1DKku27z7034g==
X-Received: by 2002:a17:90b:4f8d:b0:203:747c:7b7e with SMTP id qe13-20020a17090b4f8d00b00203747c7b7emr7752199pjb.98.1663914503291;
        Thu, 22 Sep 2022 23:28:23 -0700 (PDT)
Received: from localhost (27-32-155-116.static.tpgi.com.au. [27.32.155.116])
        by smtp.gmail.com with ESMTPSA id i4-20020a626d04000000b0054a1534516dsm5683336pfc.97.2022.09.22.23.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 23:28:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 23 Sep 2022 16:28:16 +1000
Message-Id: <CN3KGNCORWST.2ZBOWWZZMIJ06@bobo>
Subject: Re: [PATCH] powerpc/irq: Refactor irq_soft_mask_{set,or}_return()
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.11.0
References: <18473da42362ee8f07bce36b9caef8ba77d7633f.1663656054.git.christophe.leroy@csgroup.eu>
In-Reply-To: <18473da42362ee8f07bce36b9caef8ba77d7633f.1663656054.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 20, 2022 at 4:41 PM AEST, Christophe Leroy wrote:
> This partialy reapply commit ef5b570d3700 ("powerpc/irq: Don't
> open code irq_soft_mask helpers") which was reverted by
> commit 684c68d92e2e ("Revert "powerpc/irq: Don't open code
> irq_soft_mask helpers"")
>
> irq_soft_mask_set_return() and irq_soft_mask_or_return()
> are overset of irq_soft_mask_set().
>
> Have them use irq_soft_mask_set() instead of duplicating it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/include/asm/hw_irq.h | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index 983551859891..e8de249339d8 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -157,36 +157,18 @@ static inline notrace void irq_soft_mask_set(unsign=
ed long mask)
> =20
>  static inline notrace unsigned long irq_soft_mask_set_return(unsigned lo=
ng mask)
>  {
> -	unsigned long flags;
> -
> -#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
> -	WARN_ON(mask && !(mask & IRQS_DISABLED));
> -#endif
> +	unsigned long flags =3D irq_soft_mask_return();
> =20
> -	asm volatile(
> -		"lbz %0,%1(13); stb %2,%1(13)"
> -		: "=3D&r" (flags)
> -		: "i" (offsetof(struct paca_struct, irq_soft_mask)),
> -		  "r" (mask)
> -		: "memory");
> +	irq_soft_mask_set(mask);
> =20
>  	return flags;
>  }
> =20
>  static inline notrace unsigned long irq_soft_mask_or_return(unsigned lon=
g mask)
>  {
> -	unsigned long flags, tmp;
> +	unsigned long flags =3D irq_soft_mask_return();
> =20
> -	asm volatile(
> -		"lbz %0,%2(13); or %1,%0,%3; stb %1,%2(13)"
> -		: "=3D&r" (flags), "=3Dr" (tmp)
> -		: "i" (offsetof(struct paca_struct, irq_soft_mask)),
> -		  "r" (mask)
> -		: "memory");
> -
> -#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
> -	WARN_ON((mask | flags) && !((mask | flags) & IRQS_DISABLED));
> -#endif
> +	irq_soft_mask_set(flags | mask);
> =20
>  	return flags;
>  }
> --=20
> 2.37.1

