Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCE6BA501
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCOCID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCOCIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:08:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB701ABED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:07:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13so7225425pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678846079;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqJu2BEDPepML92DLQ5OvgUAstRMzlQ9eysHMa3CrAA=;
        b=aHXf6zaUqySAf91usVWsf/WPytJ4oo/lfPrjMEou8J7jlCioJJeomAO3TJ0SF+P2/j
         qsCSNUhsTR/Z2z030RVnKEFmTuo0uTA3ussyQY+I/iEvHM+AdQdQRPxsd7+joss3SxvX
         7s1xa2PoRXTmeO9NJLI7tapu+jtfRK74DUiMc+33O3nhyTWPQUYtBVUs6hsTwgG3K5Bd
         sBRRA8JIkvIQ40yMTQ4RAz7yHXH2+KBETJHXuXjm1asXSDM02eKCMNFV9r9vJ8fqhS3B
         Lvw6Q0GmvlDhElQXD1UKYjST0kh/VoRQ8ufQ4YZqly44ZaISBLXOPjSE0cXB+yNTk88x
         N2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678846079;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqJu2BEDPepML92DLQ5OvgUAstRMzlQ9eysHMa3CrAA=;
        b=nkKudPrASJTMWS2G5+9bR68NNnD1lGownsOkPTybxpWLaJiohQXO3fLg6/VtOrjFWj
         idoLI+9Oeg2yWRbwgqy7Hj2KPmAA9YyeGWv4IYDthNtreVFpSrgRxh1krOZf7eYRM2dW
         dzgMoBI9aUJGF7hpfQrYGFd1RwL70CpE74oE3YLXHiUZeZlXi568DSjICfHE7tOsmco/
         SNVN10Az2mrzNaIiibWEMiuwIZoi9S8i3q+YCF2b2vgsio4bIlA6p0MNjVkqVp7V4cSZ
         OtBrdEy4Ymj7jZbyyJoJxX4rWoddMLX9xUKaieaVYXB78GMaEFlEW2dAqOK3VhR2AAwx
         A+FQ==
X-Gm-Message-State: AO0yUKV7WPiY1mLlRe2rj+8lIR+RNbOKpL2ECmICIEhzqfLGGjkDrJAg
        llpCOqlLceD1ssKdDmbEfEgxuw==
X-Google-Smtp-Source: AK7set/4d4meE0FaW+MSNz3OomO/EWSt91fL4Ho/JVwVfKyJpvpuMlf/6fPVmbw8HNSfdZgm+emhBQ==
X-Received: by 2002:a17:902:e54c:b0:1a0:428b:d8c5 with SMTP id n12-20020a170902e54c00b001a0428bd8c5mr1055599plf.45.1678846078774;
        Tue, 14 Mar 2023 19:07:58 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b00192aa53a7d5sm2400503pls.8.2023.03.14.19.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 19:07:58 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:07:58 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Mar 2023 19:07:05 PDT (-0700)
Subject:     Re: [PATCH v2 4/5] riscv: Select ARCH_DMA_DEFAULT_COHERENT
In-Reply-To: <Y/fmqwboOv/JhWf/@spud>
CC:     jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-9bf3f6be-12f9-466e-90b8-50f2d96971fe@palmer-ri-x1c9a>
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

On Thu, 23 Feb 2023 14:20:27 PST (-0800), Conor Dooley wrote:
> On Thu, Feb 23, 2023 at 11:36:43AM +0000, Jiaxun Yang wrote:
>> For riscv our assumption is unless a device states it is non-coherent,
>> we take it to be DMA coherent.
>> 
>> Select ARCH_DMA_DEFAULT_COHERENT to ensure dma_default_coherent
>> is always initialized to true.
>> 
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  arch/riscv/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 1d46a268ce16..b71ce992c0c0 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -233,6 +233,7 @@ config LOCKDEP_SUPPORT
>>  
>>  config RISCV_DMA_NONCOHERENT
>>  	bool
>> +	select ARCH_DMA_DEFAULT_COHERENT
>
> Since we are always coherent by default, I feel like you should put this
> in the main "config RISCV" section, where OF_DMA_DEFAULT_COHERENT
> currently is, no?

Seems reasonable to me.  With that

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

as I'm assuming these should all stay together.

Thanks!

>
> Wouldn't bother respinning for that unless the dma folk have comments
> for you.
>
>>  	select ARCH_HAS_DMA_PREP_COHERENT
>>  	select ARCH_HAS_SETUP_DMA_OPS
>>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>> -- 
>> 2.37.1 (Apple Git-137.1)
>> 
