Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3844073BC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjFWQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFWQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF82117;
        Fri, 23 Jun 2023 09:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C13961A5F;
        Fri, 23 Jun 2023 16:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A6EC433C0;
        Fri, 23 Jun 2023 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687536034;
        bh=lGUFlPPTlGJTju7ucb5booe1R91+kYqXJSf7ei+QnP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SvsCFQ3mSl1g+Uj3A/P+4AeMMM07O1NdJbdW3MF8udVS+lGl3PntY8TJYPU4J8DqQ
         jEbcyU5mfdNs3XfXQzJ/v18YY3fKxusKK5iQywDj0eI6jDvfDAXPqS8uGguF9D4/Qx
         Atlb7jER8C31ofSo9i754crSFo8Beos7Amq1Hk+0QTHgBsP3gW1Q/V3yGkb0nTnoSt
         1VynU1+2NZ+f89dGVdWexxOC/3eTNjtQUZsGp6dKW4ZcPdTQn4iw+lzhf60odpFQWR
         Mo3OBqNY98ZzxO0i8DIxZ/DyP6TUSqFRgFdDBF/oBvMvxRGqAt2Bpkj82lvm7qG0/T
         JUIXrz9j8VdpQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b475b54253so13683451fa.2;
        Fri, 23 Jun 2023 09:00:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDzFafpxb9e6Bl6oGTnwUGyLS0babjcmhiAFIWB44taexe2xyZJ/
        wxPapVZAQlCMqFUchARep5uuNDBAcS96dwby2X0=
X-Google-Smtp-Source: ACHHUZ4fq7MCLDlaEZHXWx5o/WgiiFb/1l+Zx3Kkk2u7+fAPlHJP0IXZA00yHDYF6iUz+7MFDKfBtyAH+BwdsKdhR0E=
X-Received: by 2002:a2e:a175:0:b0:2b3:3175:5d46 with SMTP id
 u21-20020a2ea175000000b002b331755d46mr14342611ljl.45.1687536032826; Fri, 23
 Jun 2023 09:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230623134351.1898379-1-kernel@xen0n.name> <20230623134351.1898379-4-kernel@xen0n.name>
In-Reply-To: <20230623134351.1898379-4-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 24 Jun 2023 00:00:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4MS3_ty+jGcor-bW7OaesJp_2avnE71ima99vAzatuPA@mail.gmail.com>
Message-ID: <CAAhV-H4MS3_ty+jGcor-bW7OaesJp_2avnE71ima99vAzatuPA@mail.gmail.com>
Subject: Re: [PATCH 3/9] LoongArch: Prepare for assemblers with proper FCSR
 bank support
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Fri, Jun 23, 2023 at 9:44=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> The GNU assembler (as of 2.40) mis-treats FCSR operands as GPRs, but
> the LLVM IAS does not. Probe for this and refer to FCSRs as "$fcsrNN"
> if support is present.
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/Kconfig                | 3 +++
>  arch/loongarch/include/asm/fpregdef.h | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 743d87655742..c8e4f8b03c55 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -242,6 +242,9 @@ config SCHED_OMIT_FRAME_POINTER
>  config AS_HAS_EXPLICIT_RELOCS
>         def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
>
> +config AS_HAS_FCSR_BANK
> +       def_bool $(as-instr,x:movfcsr2gr \$t0$(comma)\$fcsr0)
The word "bank" is difficult to understand, at least for me, so use
"class" may be better.

Huacai
> +
>  config CC_HAS_LSX_EXTENSION
>         def_bool $(cc-option,-mlsx)
>
> diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/inclu=
de/asm/fpregdef.h
> index b6be527831dd..b0ac640db74c 100644
> --- a/arch/loongarch/include/asm/fpregdef.h
> +++ b/arch/loongarch/include/asm/fpregdef.h
> @@ -40,6 +40,12 @@
>  #define fs6    $f30
>  #define fs7    $f31
>
> +#ifdef CONFIG_AS_HAS_FCSR_BANK
> +#define fcsr0  $fcsr0
> +#define fcsr1  $fcsr1
> +#define fcsr2  $fcsr2
> +#define fcsr3  $fcsr3
> +#else
>  /*
>   * Current binutils expects *GPRs* at FCSR position for the FCSR
>   * operation instructions, so define aliases for those used.
> @@ -48,5 +54,6 @@
>  #define fcsr1  $r1
>  #define fcsr2  $r2
>  #define fcsr3  $r3
> +#endif
>
>  #endif /* _ASM_FPREGDEF_H */
> --
> 2.40.0
>
