Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338670A21A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjESVuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjESVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:49:48 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5FB19BB
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:29 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4QNL8F1tK7z1sG8n;
        Fri, 19 May 2023 23:49:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4QNL8D5nw0z1qqlY;
        Fri, 19 May 2023 23:49:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id XyLPMARxDKv3; Fri, 19 May 2023 23:48:59 +0200 (CEST)
X-Auth-Info: UdoOlGJyC/tj1C8t/F+qwKRDlPRVzwm7sF3nVhFHfZv+Z8M1psgK2wdJJpzQJ6gi
Received: from igel.home (aftr-62-216-205-130.dynamic.mnet-online.de [62.216.205.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 19 May 2023 23:48:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 79E822C1CCF; Fri, 19 May 2023 23:48:59 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
In-Reply-To: <6fc7f0e1-0dde-9b41-0d60-6b0bd65bb630@ghiti.fr> (Alexandre
        Ghiti's message of "Fri, 19 May 2023 13:08:12 +0200")
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
        <20230215143626.453491-2-alexghiti@rivosinc.com>
        <87wn1h5nne.fsf@igel.home>
        <4adb27d2-325d-3ce0-23b1-ec69a973b4bf@ghiti.fr>
        <87ttwi91g0.fsf@igel.home>
        <6fc7f0e1-0dde-9b41-0d60-6b0bd65bb630@ghiti.fr>
X-Yow:  YOW!!  Up ahead!  It's a DONUT HUT!!
Date:   Fri, 19 May 2023 23:48:59 +0200
Message-ID: <87sfbsvvp0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 19 2023, Alexandre Ghiti wrote:

> I have tested the following patch successfully, can you give it a try
> while I make sure this is the only place I forgot to add the -fno-pie
> flag?
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fbdccc21418a..153864e4f399 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -23,6 +23,10 @@ ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
>  endif
> +ifdef CONFIG_RELOCATABLE
> +CFLAGS_alternative.o += -fno-pie
> +CFLAGS_cpufeature.o += -fno-pie
> +endif
>  ifdef CONFIG_KASAN
>  KASAN_SANITIZE_alternative.o := n
>  KASAN_SANITIZE_cpufeature.o := n

I can confirm that this fixes the crash.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
