Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07E9637532
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiKXJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKXJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:30:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32399122941
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:30:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so799339wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcInVSFUNn3V5gEBEwa46hG0c1UErYT5MY3Lep/oon4=;
        b=3U8QF/IxWYVg6NG1OREUoIauxTEjXWySLivW3OoiK8D11df7Rh1iNX1uqA1lBUzNk/
         ZZKzsDnzstwokJqPuVkX0A/kidsn3HFivPBhPNcQI1yvwjuMtTL9u82zvoepm70Tl4ir
         4+RjclN95QEUehpDyItjE35OcZLndsYbjwItRQkgTd7KRkg8wOc3uN8LECUKIdeAGZAV
         bW0FFU2xAeSbzr1FohDjzLwPUBQMTu8RHGIEiMxtfk9c8AUcmU9luvWLkQQ6ZMtsoqbG
         Ygb1PLG82VSFdsp3VMSb7lAu9kGI5Cj3J5CGKFN8RW4f4JToQ8MKzaDWdVK0DzfTfnyp
         B7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcInVSFUNn3V5gEBEwa46hG0c1UErYT5MY3Lep/oon4=;
        b=S39ZdpmQtMAR0zFJ0qrbhZ6B+VhrT3ByCqR5nuPXpalSF+2Op464f9oAMl4nsQ2nZp
         Jmk5LA1rAXPSovWbW7flFIPQKar9vJtL651fLR3YejiC/U5tmrGrnvd1iESrJ5Rr98rB
         EKyWDP+4pgsZZWMhXPHPNvHzn5MjyZlCkNStsznzFIZl4y/Mf5hqTufchd0h1Cg+Qv5t
         8TNwG9VYzy4bRxtyvUQv54HISVOS620VEeB4pnZzlWueeS8Ly9IJmkc4oTDUrFB3uGRd
         z4PdDWBw/Led+cqnh1eRY8CCFC6ocjfDnd8t1KAabICSsaQyj2WYOn1odH9XVR0LuNld
         Eo6w==
X-Gm-Message-State: ANoB5pnYUtaOSCoEy77EPBMWxT4CZVwHCjFGqSTUE43UJ5+U6LrCeAz8
        Clgb0ZfYpDiAGDo4C/tz454jqQ==
X-Google-Smtp-Source: AA0mqf4crTB40uwfsg1ylnZejqCYL+Y/+FPaqGBbpi33Lt/Gm3Lxt/Vb0EDvIH6aMI3lgkxSpfZDJw==
X-Received: by 2002:a05:600c:4e46:b0:3cf:8762:23d9 with SMTP id e6-20020a05600c4e4600b003cf876223d9mr10470781wmq.112.1669282225613;
        Thu, 24 Nov 2022 01:30:25 -0800 (PST)
Received: from vermeer ([145.224.92.100])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0560001c1100b00236695ff94fsm885373wrb.34.2022.11.24.01.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:30:25 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:30:21 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     "Hongren (Zenithal) Zheng" <i@zenithal.me>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>, Conor.Dooley@microchip.com
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Y385rS/5zDaDJ3Os@vermeer>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0i22SdbHjB/MX@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqY0i22SdbHjB/MX@Sun>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:46:35AM +0800, Hongren (Zenithal) Zheng wrote:
> diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
> index 46dc3f5ee99f..bfed3e5c338c 100644
> --- a/arch/riscv/include/uapi/asm/hwcap.h
> +++ b/arch/riscv/include/uapi/asm/hwcap.h
> @@ -22,4 +22,26 @@
>  #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
>  #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
>  
> +/*
> + * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
> + *
> + * As only 32 bits of elf_hwcap (in kernel) could be used
> + * and RISC-V has reserved 26 bits of it, other caps like
> + * bitmanip and crypto can not be placed in AT_HWCAP
> + */

Have we agreed that multi-letter ISA extensions would use hwcap to be
exposed to userspace? With so many potential extensions, we could
quickly run out of space on AT_HWCAP2 as well.

Cheers,
Samuel.

