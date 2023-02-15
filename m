Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754AC6974B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjBODRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBODRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:17:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39AA2B297
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:17:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e12so1478693plh.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HoOW7mnikI/W6qgH9CzqhnH7tqIVURB7YzkTuqqxeg=;
        b=yRLLo+Y2l9Rqw6rar1SCyG1SxgiM4k2LfTdR7HicsoJ3ot5+CNso463IU5kURN1h86
         nSFxSUeaFV+/D+mlWEOgnks7/Y7ZVhJVAKTYCKDTrGq9/HdNNX1yUcykVibwEyQ9jpsq
         fU2wTqpQfQzfy7JvALOZOQzvr7brLByl3XKurkcI3DHXCgcX79yvkS83ZaA37iqJpA4C
         KDea2/o8hQGM0PGNNPafiUtTbhNWi6DCUjkL8d/7qDUr80FhqUKabcI2fl9lQK7gQu4M
         02O+3gWIonFsGFOLw244Xs+ECHNZsDJtJA1ZejtNyupqPwLJb7iaz5xgprNxEmyL672c
         dJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HoOW7mnikI/W6qgH9CzqhnH7tqIVURB7YzkTuqqxeg=;
        b=Bk/Ti+bvX5q4ijNi41r9n/3i3JgOgs0PTnVurT+V0UYbBbivF8Xa95T7xW65ePitZ3
         koUbvl1JpkYkGLlZ8W+mUIdcYcd/ciipFH0y/L6RCWnnc00vbZ9chxO29Oq1BxQXT/eE
         DAQCxUbcwmaXd0ujIwAE95De1rPrXWGb/VP6pqjwESKRBv8HaPzlHNBVmPkizO1SKubJ
         QV5qD3O16hJ7Eo7Rs8E0IzUWX4h/h2pDV53OeobSksvYiuCB/hNI3iAcz6ctdMGK+mCC
         llW3NMMEl8HGvIOb5KydttoVbL7A3TLSvpniWSETg8Os7xmeGdyi+DmxiS0hdDUfSKyE
         GfWg==
X-Gm-Message-State: AO0yUKWw7QAVXaGv1Fdaiym9Nbr86tQAgXFb+ALcanarQJOHOP1b2Vtm
        azuqSKalGGgPBPv5QNNCJw2yAQ==
X-Google-Smtp-Source: AK7set+1aqVANLzDp5HMuErgCQtOQR3yuVXnnsXY/YD+E/CloFSoZS7gNIcwS34GPrlK9OomuYcunQ==
X-Received: by 2002:a17:903:32c1:b0:19a:6b55:a453 with SMTP id i1-20020a17090332c100b0019a6b55a453mr1399170plr.9.1676431032105;
        Tue, 14 Feb 2023 19:17:12 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00198f2407ea1sm10792632plp.241.2023.02.14.19.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 19:17:11 -0800 (PST)
Date:   Tue, 14 Feb 2023 19:17:11 -0800 (PST)
X-Google-Original-Date: Tue, 14 Feb 2023 19:17:04 PST (-0800)
Subject:     Re: [PATCH v16 0/9] RISC-V IPI Improvements
In-Reply-To: <86357k1ihd.wl-maz@kernel.org>
CC:     apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-a886c4b4-d748-420f-889b-76ada4f9a432@palmer-ri-x1c9>
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

On Sun, 05 Feb 2023 03:04:14 PST (-0800), Marc Zyngier wrote:
> On Tue, 03 Jan 2023 14:12:12 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
>>
>> This series aims to improve IPI support in Linux RISC-V in following ways:
>>  1) Treat IPIs as normal per-CPU interrupts instead of having custom RISC-V
>>     specific hooks. This also makes Linux RISC-V IPI support aligned with
>>     other architectures.
>>  2) Remote TLB flushes and icache flushes should prefer local IPIs instead
>>     of SBI calls whenever we have specialized hardware (such as RISC-V AIA
>>     IMSIC and RISC-V SWI) which allows S-mode software to directly inject
>>     IPIs without any assistance from M-mode runtime firmware.
>
> [...]
>
> I'm queuing patches 3 and 9 via the irqchip tree as they are
> standalone.
>
> For the rest, I need an Ack from the riscv maintainers as they change
> a large amount of arch-specific code, and the couple of irqchip
> patches depend on these changes.
>
> Palmer, Paul?

I haven't gotten time to give this a proper review, but I think we've 
got enough of a mess with our interrupt handling that it doesn't really 
matter so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if you want to take it for this cycle that's fine with me, but I'm also 
fine holding off so it can have a while to bake in linux-next -- there's 
no real rush for any of this, as there's no hardware yet.

>
> Thanks,
>
> 	M.
