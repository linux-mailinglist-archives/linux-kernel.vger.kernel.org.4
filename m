Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6570664D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjEQLNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEQLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8242E197;
        Wed, 17 May 2023 04:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D9B6391F;
        Wed, 17 May 2023 11:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E0EC4339B;
        Wed, 17 May 2023 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684322029;
        bh=ivpfENKobVp/rhuC9q3XBqpYwMexIt1WJr5tlv/4oZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ulp89AX6Cr2YliUOJwEq8wLacS3EBVA2Pf2TGandRieVntdrB2QST9LGENmp2ogr0
         kst5xaJwTRe43jhE8PKgRgYjSJZ1eg6qEdCniBaCQz6H7gx5FHK/qVPVURHImQiT0B
         huiktQ3vwR93k7aYv49+TKdAvqRwb4bgZHEoTJCymGL3R6rPEFDLYbzBpwkMz46aLp
         L9ue2YVuB3UwiiVtocaq9Dlz96onY5QCWugKlvaBf+eCmsI+kE61eY+zXuVbEDC5vy
         coPSapfBy/XzLtoeP0GmRwElD5LQB28SYMZRcY1vmUb/aExLLY5NLIh8U9mTvvN78q
         3TQ7afU3FDwFg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso879883e87.0;
        Wed, 17 May 2023 04:13:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDwsUyETc6xvZXgrhK4pXvYndF8uUiHWOdwQh38zGRU78ZlDa/+f
        9S35RpRv7CvE3W9F3Z7f+nPWyid/K4Nt0atdhgo=
X-Google-Smtp-Source: ACHHUZ7+2d5wOFnG6e01YGipp51q9tg1LC1u1LEZCV6G7kOljNB4yL52v9aq23raxt6pM2043XO3f/i7p1WtmhnFA2c=
X-Received: by 2002:ac2:490c:0:b0:4f2:e953:98b1 with SMTP id
 n12-20020ac2490c000000b004f2e95398b1mr96067lfi.65.1684322027511; Wed, 17 May
 2023 04:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230516154605.517690-1-arnd@kernel.org> <20230516154605.517690-14-arnd@kernel.org>
In-Reply-To: <20230516154605.517690-14-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 May 2023 13:13:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF0AQ9cc64N9kRxV8s1TDTVdAb_4s2P-rriim5DNW_cCA@mail.gmail.com>
Message-ID: <CAMj1kXF0AQ9cc64N9kRxV8s1TDTVdAb_4s2P-rriim5DNW_cCA@mail.gmail.com>
Subject: Re: [PATCH 13/16] ARM: vfp: add vfp_entry prototype
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

On Tue, 16 May 2023 at 17:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> vfp_entry is only called from assembler code, so it does not
> need a declaration. Since gcc complains when extra warnings
> are enabled, add one anyway to avoid:
>
> arch/arm/vfp/vfpmodule.c:657:17: warning: no previous prototype for function 'vfp_entry' [-Wmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This one will conflict with my VFP asm to C conversion series.

> ---
>  arch/arm/vfp/vfp.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/vfp/vfp.h b/arch/arm/vfp/vfp.h
> index 5cd6d5053271..10d9c0da0fd4 100644
> --- a/arch/arm/vfp/vfp.h
> +++ b/arch/arm/vfp/vfp.h
> @@ -375,3 +375,6 @@ struct op {
>  };
>
>  asmlinkage void vfp_save_state(void *location, u32 fpexc);
> +struct thread_info;
> +asmlinkage void vfp_entry(u32 trigger, struct thread_info *ti, u32 resume_pc,
> +                         u32 resume_return_address);
> --
> 2.39.2
>
