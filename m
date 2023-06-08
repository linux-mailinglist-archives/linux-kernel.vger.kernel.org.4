Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD537279A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjFHIKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjFHIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8391730;
        Thu,  8 Jun 2023 01:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC3C064A13;
        Thu,  8 Jun 2023 08:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B23AC433EF;
        Thu,  8 Jun 2023 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686211807;
        bh=C+rHEG/c674R9h1WxP8EIaYcHRasurafDpURUrS3qQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dltILT6bKoAPPSMw5xWupLlWDU5o4L9XaCS2ZMazGeizX3vQkdHsebLwKQt7o9eML
         Hw1UbbLRwG/6ACxqRnlrCSt5s8OMn5gIbNNfeGnBuy8AFt6L/TbOJBj8a+YUqnTG9I
         kP+UVBudNizPrK8D7y1H8uL9vpMU2YbL7Rtpzc/LxMXvsWNXQlAAG0tcb8IncOg7k0
         mwaeg8Vj4WMRvdrl71eLX79qM2bmeHVkfvBjrcoOpCXqlQ1dBdFSCMMBUH7Iho9GoT
         aLp/Tm7pd9CB4gSGsthy8sWEeW5Q5312RL5IuzuoiyljinRV2rHi0QNeQEW6gUl2T0
         sF2i5kx3SZcFA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so432817e87.1;
        Thu, 08 Jun 2023 01:10:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDw0v9ubmUZbwUa1VY2v0wEIUts5aXTVGw7ZZMZaJYQybR6+OS+R
        MRqhl9cqrg8yDxQTPNuh+tCtrxhg7pXqrDcFBZg=
X-Google-Smtp-Source: ACHHUZ7ExumTs8tcu5KAEIGJtXlT6yHg7zABGWDQMrQgZdOrl3AS9d+MFyjfACdjHRn3fAjMpyShhY6nm6Xe9O08LqM=
X-Received: by 2002:ac2:4c30:0:b0:4f2:74d3:8996 with SMTP id
 u16-20020ac24c30000000b004f274d38996mr2668920lfq.8.1686211805289; Thu, 08 Jun
 2023 01:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZIFVGwImU3kpaGeH@work>
In-Reply-To: <ZIFVGwImU3kpaGeH@work>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Jun 2023 10:09:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFErhC7k+zg2ga-Lgo9f6muarbO6AJVx3g0KCGTLWkakg@mail.gmail.com>
Message-ID: <CAMj1kXFErhC7k+zg2ga-Lgo9f6muarbO6AJVx3g0KCGTLWkakg@mail.gmail.com>
Subject: Re: [PATCH][next] ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 at 06:11, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> If function pwrdm_read_prev_pwrst() returns -EINVAL, we will end
> up accessing array pwrdm->state_counter through negative index
> -22. This is wrong and the compiler is legitimately warning us
> about this potential problem.
>
> Fix this by sanity checking the value stored in variable _prev_
> before accessing array pwrdm->state_counter.
>
> Address the following -Warray-bounds warning:
> arch/arm/mach-omap2/powerdomain.c:178:45: warning: array subscript -22 is below array bounds of 'unsigned int[4]' [-Warray-bounds]
>
> Link: https://github.com/KSPP/linux/issues/307
> Fixes: ba20bb126940 ("OMAP: PM counter infrastructure.")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/20230607050639.LzbPn%25lkp@intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Nice to see this work paying off.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Does the error case need further handling here?


> ---
>  arch/arm/mach-omap2/powerdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 777f9f8e7cd8..5e05dd1324e7 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -174,7 +174,7 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>                 break;
>         case PWRDM_STATE_PREV:
>                 prev = pwrdm_read_prev_pwrst(pwrdm);
> -               if (pwrdm->state != prev)
> +               if (prev >= 0 && pwrdm->state != prev)
>                         pwrdm->state_counter[prev]++;
>                 if (prev == PWRDM_POWER_RET)
>                         _update_logic_membank_counters(pwrdm);
> --
> 2.34.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
