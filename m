Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031363B609
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiK1Xia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiK1XiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:38:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC560D8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:38:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q12so7972762pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwMkGfYrczoT5UC7Q2IMcaUlV/rVQBcUruupNeEXsUY=;
        b=ADfvVneUt918f/bZRbOmHw0Lcwnvyt6F5cRCxrWm2cERkXdkAXkMibQUkLW32/0CPC
         xoiY4PVZj4K6AmDHv/oqDe9DRPZj3RFebAJ3KZi5JImqUysRWHq/qzQHsA+rXwDoXJjy
         nlHuX2YYEEqG4zbPue9trNucnVeo3dSqaqvgPiYB78L5+wb/zp6wj41+A5rrpwAyc7G7
         WhGGdFSJDlkKtXbvzadzN/hyrzh1GblrzU6Lbw7pnGTxnOyubpVU0ZazlTR4YAPDqDBp
         TeUfh9u11OgkI5j+Lbe6ZhdDki8KMfooATNi2+5ls3HJbhPC68DTQyNbDP+aitoNLDvo
         fHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwMkGfYrczoT5UC7Q2IMcaUlV/rVQBcUruupNeEXsUY=;
        b=5L7nJEYMmQcjm+k0aKcpysidoef17HqPWMOlwKn6j1NQQZwyRraT/n8II42t703BAK
         z80U1qxZmxa2nO2IE4MiG+Q2XybW0ylglZbEUdT2OY6e6YwHY73wjFyGg8CNM8oNYbBU
         gJ9RDESBARrz9y4bk0y9768dXhkXuMulnaoTCJEGvCx7chQ0fO5aqTAuPNO8vO3YYs7O
         CI1tzwSiAB9ZNRirMtnSxsWbparWWcsyqnKxWWiRKLp9frRNIRsa+5Mp+c03+gu+gqV/
         Fs7sQVSNyPZ/9HHtqdz87AO/GLfKtQHf3is63dIaF1nAEdxFUYfmofeqm+GvBjEZ7UtV
         kn3g==
X-Gm-Message-State: ANoB5pmINPqQHy/44TnipMN+UtePvVp7BFhC35blGWc8hHf/f3qE9p+V
        C5bRb4c8kSuB6E5kM4noMEz12w==
X-Google-Smtp-Source: AA0mqf43vI3ugt5v69DI5oTlWcd2zZKdHLfUR6d4brHgj6w2E8fp0HIkDh9akuPP+JDhiGFYhNSuOA==
X-Received: by 2002:a63:4302:0:b0:439:3ca0:5a29 with SMTP id q2-20020a634302000000b004393ca05a29mr28673385pga.443.1669678693663;
        Mon, 28 Nov 2022 15:38:13 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c200-20020a624ed1000000b00574d8d64560sm5730203pfb.175.2022.11.28.15.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:38:13 -0800 (PST)
Date:   Mon, 28 Nov 2022 15:38:13 -0800 (PST)
X-Google-Original-Date: Mon, 28 Nov 2022 15:37:43 PST (-0800)
Subject:     Re: [PATCH] riscv: Fix NR_CPUS range conditions
In-Reply-To: <20221128183559.5ei5fx4cl4mo3ioj@kamzik>
CC:     Conor Dooley <conor@kernel.org>, samuel@sholland.org,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        heinrich.schuchardt@canonical.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ajones@ventanamicro.com
Message-ID: <mhng-a00a65f6-76e1-4ec0-bb7f-7919e75ca4c9@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 10:35:59 PST (-0800), ajones@ventanamicro.com wrote:
> On Sat, Nov 26, 2022 at 03:32:04PM +0000, Conor Dooley wrote:
>> On Sat, Nov 26, 2022 at 12:15:56AM -0600, Samuel Holland wrote:
>> > The conditions reference the symbol SBI_V01, which does not exist. The
>> > correct symbol is RISCV_SBI_V01.
>>
>> Huh, good spot.
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Yeah, huh. It never occurred to me that we don't have some sort of symbol
> referencing checking in kconfig. Or maybe we do and I just don't know how
> to enable it? Anyway, this issue made me wonder how many more dangling
> references we may have. I wrote a script to look for them and found 29,
> including this one. I'm not exactly sure how to report them since they
> touch so many different places. For now, I've opened this kernel BZ
>
> https://bugzilla.kernel.org/show_bug.cgi?id=216748

Thanks.  This is on fixes, it's sort of jumping the queue (I've got a 
bunch of stuff still staged from last week, but thanksgiving screwed up 
the flow) but it's small enough it doesn't seem worth waiting.

>
>>
>> >
>> > Fixes: e623715f3d67 ("RISC-V: Increase range and default value of NR_CPUS")
>> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>> > ---
>> >
>> >  arch/riscv/Kconfig | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index fec54872ab45..acbfe34c6a00 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -319,9 +319,9 @@ config SMP
>> >  config NR_CPUS
>> >  	int "Maximum number of CPUs (2-512)"
>> >  	depends on SMP
>> > -	range 2 512 if !SBI_V01
>> > -	range 2 32 if SBI_V01 && 32BIT
>> > -	range 2 64 if SBI_V01 && 64BIT
>> > +	range 2 512 if !RISCV_SBI_V01
>> > +	range 2 32 if RISCV_SBI_V01 && 32BIT
>> > +	range 2 64 if RISCV_SBI_V01 && 64BIT
>
> And for this patch,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew
