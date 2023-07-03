Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA202745A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjGCKbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGCKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:30:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C03719B3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:30:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc0981756so40072305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688380185; x=1690972185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msJWpyA7yo6ChYj6KxpLPwqEqEdFIUqzWnqvB6326h8=;
        b=uG7u5pKuhtwVbr2UgzP8QRIsfl1iHAteUv24U80QoHbW76XH60V8ImE2VNBLxQa9Qq
         kLRpwlK6YtuNENBihvqHpD6PyWaah6uVndRmhCfpY/XXqkgmtI/BwUInZ8BSkTfG/Dao
         18RUARVnFlz7VWwr0WMyVF8SsKwfdStnu625yEymLkZ2+Kj86OmvzzI8YUNG7JLtpSGp
         HEsvosPWjYgwvL8q8M9NlgK/Mj6nmGfLdNG759I8DxJ2cICoqAa9ihOBTlJF9w24ph2d
         TbkH2F7e9NyNZM63JA/5/MZmRvOX3RU0Jb+i7iMf+YaKFCuFhigY9yyshw65JxqmZDgQ
         EZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688380185; x=1690972185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msJWpyA7yo6ChYj6KxpLPwqEqEdFIUqzWnqvB6326h8=;
        b=a4IDgd3WrvzPZu+zaKd0rukL8gEBTaiEQbSylp56h7Fh+eYw7NPzZoZmFFfs7idhmG
         ee/xU7YGgIcCtORKA3E00J62WPIrctf4/FngJEvCA9sN4P/kuWEWTwlFXBbAOtGajRPv
         sYtYI/k530ixZJiEIykmgjHoB07Bbi+HHA7L/FUTTO+dsjDsIxHzG0Y2v8fMLAHgoHp6
         i27fT7CxFLTasNstun6oHl87wSRknUmfDnujdrPpCs/dlcACPoE8F4tdlxCjd5L3/hMY
         BKAOEOOk29LTSf2MLYe+MA+Zke/BJlV7xx82jO1Ub4Vi53t+n5VLRyYiuZX+uO2boF7t
         YPUg==
X-Gm-Message-State: ABy/qLaXSSc79r9lZTiyJg5VsKj5olkKDIP4gyNFCo60d5wb9pzGSq3f
        gNyIOhFe1+FTnsDvW5vmwLVUqg==
X-Google-Smtp-Source: APBJJlHzl6eBn9aWNVBkstLjO2nceNNNQ/v7qgOzbBPVd6Bz/h0VoFqe818reHfXXfYJfj+v9+U3ow==
X-Received: by 2002:a05:600c:22c4:b0:3fb:d1c1:9b79 with SMTP id 4-20020a05600c22c400b003fbd1c19b79mr4086786wmg.30.1688380184737;
        Mon, 03 Jul 2023 03:29:44 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b003140f47224csm12786759wrj.15.2023.07.03.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 03:29:43 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:29:41 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        palmer@dabbelt.com, bjorn@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <20230703102941.GA4328@aspen.lan>
References: <20230702025708.784106-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702025708.784106-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> debug the kernel.
>
> Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> of the kernel side.

<snip>

> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: stable@vger.kernel.org

I pushed this though the kgdb test suite that originally found the
problem (although it didn't occur to me when I reported it that
the problem was nothing to do with kgdb ;-) ). So FWIW:

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
