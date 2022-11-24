Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D296373D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKXI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKXI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:26:17 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99538DA4E0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:26:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k7so859245pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iq+4pfpVj2YEkmw3BdrSeu5qIO7TFnvAEvQVd61pySI=;
        b=c9D3h9my8OzUH9sGDlOD2tEvIgNEtuRwLd5yV0iddgrBlQ6Vd/kkD/2cOnt/qJGtHl
         hwB+GCmeBHg6jpsWCCpSx9B1vLeir0CF3rStUqkQDDwL/W+c1tD34kFkDQsnUd7odEIl
         b3/WnZhkr8aFhMRhFpnrGwW3DZsGQd5f4vZxD77drUNjVnVvRgK+VkrfryBQc/skVA1y
         nY1yscS3s7/BCgvaMtXZLnowbEhUAX35ZJGD57/5oQSppZPBuEr3PM9mcJCeBJT0behS
         COV0ZMk8jSdHFpYzeGDAacRJr8FRCdnGkhjHPwM/tCiDTHY2Y3/u0bHyFADgqJ0jL8Dg
         vKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq+4pfpVj2YEkmw3BdrSeu5qIO7TFnvAEvQVd61pySI=;
        b=qb2veD0yeAQXW9RVEtKPQRgpb/jRI9l02YxGOHNIeGizavSWtFp/2Fjt3ptku0yys/
         I6jqX3WBboVsRAfDFDZEy07ZLe7c94RauZsN1KdouTyAI2TmHU/10t+XjJertCxQ/c2r
         vvC+yz//KvbYnLa66CAnsPNt/9u7MNjVhICc3V+oIbO0laXv9nrf3JEVG0+7+h57Gm4N
         tAwxT9OAfNvXY80Nc2Jtk96Y/mylmT5RKLSVozzAHhDTXBrChH+IEvjRQ9ziaNzjlwuo
         uTzjHDBngWPc1cfoc4ddotvpUgiusD1Qws671/I6k75vDAkiD4qml3szzW5w2wBmDXB8
         Nc7w==
X-Gm-Message-State: ANoB5pmxz5svVqVfH/MPaLEENKQ6D+0jYrZFKrgiYDoHr0XERRwr2Dv9
        mwlvaUnWrCs7l6R/hXFYgQ9bUzKFyi43nA==
X-Google-Smtp-Source: AA0mqf5MGYHuYsuRjUW2rJsuasqSdOayajlDgv8RqUu8ILUS+dhJ7O4r/rxC1MiPkD7GHc5HNv84eg==
X-Received: by 2002:a17:90a:a381:b0:218:6dc3:55b8 with SMTP id x1-20020a17090aa38100b002186dc355b8mr34448206pjp.189.1669278375137;
        Thu, 24 Nov 2022 00:26:15 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0017849a2b56asm638907pla.46.2022.11.24.00.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 00:26:14 -0800 (PST)
Date:   Thu, 24 Nov 2022 00:26:12 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221124082612.GC1149630@debug.ba.rivosinc.com>
References: <20221124005006.1788315-1-debug@rivosinc.com>
 <CAJF2gTSwMZQvSNxb2_5GNrVG0pwfXWsHmp8zZG=gFHnhc95bjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJF2gTSwMZQvSNxb2_5GNrVG0pwfXWsHmp8zZG=gFHnhc95bjQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 09:32:19AM +0800, Guo Ren wrote:
>> +.macro asm_per_cpu dst sym tmp
>> +       REG_L \tmp, TASK_TI_CPU_NUM(tp)
>> +       slli \tmp, \tmp, 0x3
>> +       la \dst, __per_cpu_offset
>> +       add \dst, \dst, \tmp
>> +       REG_L \tmp, 0(\dst)
>> +       la \dst, \sym
>> +       add \dst, \dst, \tmp
>Another tricky asm code of using percpu, I don't know how the percpu
>maintenance guy thinks.

On this, if you can point me to someone, I would like to get their feedback.
While discussing this, one issue that comes in my mind is if the shift of 0x3 
is correct or not on 32bit systems. I don't know what's the size of each entry
in `__per_cpu_offset`. On 64bit it's 8 bytes and thus 3 bit shift.
