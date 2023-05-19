Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF070A229
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjESVzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjESVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:55:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ACC1B4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:55:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae615d5018so22361535ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1684533329; x=1687125329;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uXFG3N07SM/6noHGA5ZD0BhWKs4fe06jSmLKiYiFpA=;
        b=qi8xAHodXi1tTUlxkODdWEQyiAwma/a9BvGcwY/aQkz6Qrfgd/uYwIsQ3ftgzEUzB7
         gQPnW4y98zBiQ1VJR1u1WmO0yXGgMdTnoKC4h1pdaN0elORWUcBRgyEH9K9ragANYapi
         wvIqmSO9V822mFO1HA5NixmIP6q/D+Q5AwrBbbtETBnZBo3FeUikHs11UulsM7CkjzDJ
         J8h6sS8sJhSFcDl/4uQ/P1JP35ibHi6+NnvdLdBO39EeIwkui0FYW8krsRQlEj+OcJaT
         1EkX2USheSSzI+PFRacvW1yO7xokuC0lKYP8KIO4GPA1Hd/ORj085Er5URM/OrxF27lc
         9Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684533329; x=1687125329;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uXFG3N07SM/6noHGA5ZD0BhWKs4fe06jSmLKiYiFpA=;
        b=FXkK7NWFWanCG/XS+smQAMRkT++U43MC+tla+Y85TxqvJ+l7rmkfIEAUclEGu2eqvB
         ZG5+/kn0+/k/RRL/mmR7vTaS8z06FE8G7Fg3JTTHXJNB3SczflCbv0LjTzrQJlJZu2Rm
         jb4A2rJ12eGYHae15p+U3Q92oUriRYMfRb3UWsuyjMfxd29x4FMXsoLU3rNcMsX2RT7/
         23rgTs/q8ebvPjP0dr8JpHXONyZ2k/0XKbZ3+K/ERcKWNZwf0Wn0rl9RG3j5RnICwUfS
         gDZFulIDhgCGySUnH8MN2b0l5uDlUxOxvH4xIqYqIQA2w0lyZBhCYSrYU7Wl7AerT74x
         vaMw==
X-Gm-Message-State: AC+VfDzcH/fcvMlbAfaLkSKrOxR+pPLeSB6ZUwyigumWyeuZzMwpiz+t
        9HwKEs5TXPCK1IaBlyRn19ajrA==
X-Google-Smtp-Source: ACHHUZ5/ROOeL9x3rAVEVvDuoSZzBU2MR5h4O3UXzZfGGu9m3CMVQZIexSY6expZXuqtDJrP1h/97g==
X-Received: by 2002:a17:902:e746:b0:1aa:df9e:2d19 with SMTP id p6-20020a170902e74600b001aadf9e2d19mr4239865plf.54.1684533329317;
        Fri, 19 May 2023 14:55:29 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902869700b001a98f844e60sm80031plo.263.2023.05.19.14.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:55:28 -0700 (PDT)
Date:   Fri, 19 May 2023 14:55:28 -0700 (PDT)
X-Google-Original-Date: Fri, 19 May 2023 14:55:05 PDT (-0700)
Subject:     Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
In-Reply-To: <87sfbsvvp0.fsf@igel.home>
CC:     alex@ghiti.fr, alexghiti@rivosinc.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-d3720bcf-5eda-46da-b640-0606ef3a60e2@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 14:48:59 PDT (-0700), schwab@linux-m68k.org wrote:
> On Mai 19 2023, Alexandre Ghiti wrote:
>
>> I have tested the following patch successfully, can you give it a try
>> while I make sure this is the only place I forgot to add the -fno-pie
>> flag?
>>
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index fbdccc21418a..153864e4f399 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -23,6 +23,10 @@ ifdef CONFIG_FTRACE
>>  CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
>>  CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
>>  endif
>> +ifdef CONFIG_RELOCATABLE
>> +CFLAGS_alternative.o += -fno-pie
>> +CFLAGS_cpufeature.o += -fno-pie
>> +endif
>>  ifdef CONFIG_KASAN
>>  KASAN_SANITIZE_alternative.o := n
>>  KASAN_SANITIZE_cpufeature.o := n
>
> I can confirm that this fixes the crash.

Thanks.  Alex: can you send a patch?
