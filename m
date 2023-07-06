Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49174A482
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGFTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:45:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B11BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:45:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7fb1a82c4so6285295ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688672716; x=1691264716;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrNhiTqDQItKHcCBe+k1gh83J9Zxaz0xFFK2k4JYDbk=;
        b=2G9krPYp+J1M049iq9qKlWbi8hvMukNAJ3a0MDGLFJQNVU4DW/0O5Q5eoZtUw5vyWU
         TAlQnQUi5eYli+xFyLOXpDhmrjiGlt+J8wlZJfH+Mn75qLUu1IEgZ2T8FEZ6lPNTch4R
         fWpSyxvFCCJQKW/9GYkRWwcAXIDgG/NKunkK1iwVukBy1Lmxk2WpIzKrElawSv8FsASi
         6nom6jfIcfZZLB5Wct6j/VgnSQmGvjKpCTbuJFxL/2XwPEUnvXh7wwGA1ly+O4CklJCp
         6qSgQNH44kWwp6qLB5mQFx8trUltNAK01LDYljiGd+BcomL+NOcYYPYoCIStzzk/PZR8
         FH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688672716; x=1691264716;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrNhiTqDQItKHcCBe+k1gh83J9Zxaz0xFFK2k4JYDbk=;
        b=FZ/jHPg14KHeemfURZbuDI9zrp5aIvnZMhfeD22QWnDqtRC3+EZDXYXOu0iFj7OUAG
         svYDvJ1xVl0Uo05hteYhehYkf1JhuosKgVl89cQmSkAn5rWv/fhue5+EnfDRRgQ5ZFzm
         EWn83QaIL7CQFCAai2hbfabEcj/XOLR1Yp+zzmv6koFAaVMPcuJ0b28Q/BUWbUYVI4hw
         qFhXRcEgySrCgx0DsYPfQUM+JBLjy4PHQibBSo6yUIZi7/WMIAuE58Br3wRgKfH2nQFI
         s1R/lrRpuOXvHACNAQMXzOlVSu9l4wGPadQC9r3uUPcMUM/aZ2vL55wSNPgdXp+rlmu2
         jPOw==
X-Gm-Message-State: ABy/qLbw4087QFyDj2fZnjO+jhVMjT8uAlhn66K6GTBDdndT3B1RCrtW
        11XpTWXwh5iEH4h4ZGfsblMMow==
X-Google-Smtp-Source: APBJJlEOjvLvA7GdlM4mx+7ttBgWvWAOkGPMRSO1WGP2vSp3DNx4FH+IJgkckUOcCrgrOEmxjvK4Nw==
X-Received: by 2002:a17:902:ecc2:b0:1b1:ae33:30de with SMTP id a2-20020a170902ecc200b001b1ae3330demr3234128plh.13.1688672715791;
        Thu, 06 Jul 2023 12:45:15 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b001b9be3b94d3sm180213plg.140.2023.07.06.12.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:45:15 -0700 (PDT)
Date:   Thu, 06 Jul 2023 12:45:15 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jul 2023 12:44:29 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
In-Reply-To: <CALs-Hssc6Uxf-6FKbye2n-CD0FWWE4xDmUWvN1NoKNFpn88SKg@mail.gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        heiko.stuebner@vrull.eu, Paul Walmsley <paul.walmsley@sifive.com>,
        sunilvl@ventanamicro.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Evan Green <evan@rivosinc.com>
Message-ID: <mhng-ebe222a1-57eb-41cf-a541-38b4b5595ac0@palmer-ri-x1c9a>
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

On Thu, 06 Jul 2023 12:34:30 PDT (-0700), Evan Green wrote:
> On Thu, Jul 6, 2023 at 3:53 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>>
>> On Thu, Jul 06, 2023 at 10:01:31AM +0200, Andrew Jones wrote:
>> > On Wed, Jul 05, 2023 at 10:29:31AM -0700, Evan Green wrote:
>> > > In /proc/cpuinfo, most of the information we show for each processor is
>> > > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
>> > > compatible, and the mmu size. But the ISA string gets filtered through a
>> > > lowest common denominator mask, so that if one CPU is missing an ISA
>> > > extension, no CPUs will show it.
>> > >
>> > > Now that we track the ISA extensions for each hart, let's report ISA
>> > > extension info accurately per-hart in /proc/cpuinfo. We cannot change
>> > > the "isa:" line, as usermode may be relying on that line to show only
>> > > the common set of extensions supported across all harts. Add a new "hart
>> > > isa" line instead, which reports the true set of extensions for that
>> > > hart. This matches what is returned in riscv_hwprobe() when querying a
>> > > given hart.
>> > >
>> > > Signed-off-by: Evan Green <evan@rivosinc.com>
>> > >
>> > > ---
>> > >
>> > > Changes in v2:
>> > >  - Added new "hart isa" line rather than altering behavior of existing
>> > >    "isa" line (Conor, Palmer)
>> > >
>> > >
>> > > I based this series on top of Conor's riscv-extensions-strings branch
>> > > from July 3rd, since otherwise this change gets hopelessly entangled
>> > > with that series.
>> > >
>> > > I was unsure if I could snuggle the new "hart isa" line in just below
>> > > "isa". Aesthetically it would be quite pleasing, but it runs the risk of
>> > > breaking brittle usermode parsers that are assuming a specific line
>> > > order. So I put it at the end.
>> >
>> > Actually, they're probably only aesthetically pleasing when they match. If
>> > there are differences, then I'd guess having them side by side, almost the
>> > same, but different, would make them even harder to look at then they
>> > already are. So I think I'll be happier with them separated by a few lines
>> > anyway.
>>
>> This list is eventually going to be so big that I don't think doing
>> by-eye anything is going to be useful, so aesthetics be damned.
>> That said, a parser that relies on the order of individual lines like
>> that might deserve to be broken ;)
>>
>> Anyway, change looks good to me:
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> I was thinking the uabi doc might need an update - should we add to it
>> that "isa" means the common set & "hart isa"?
>
> I did do a little search for documentation to update, but failed to
> come up with any. Which doc are you thinking of?

Should be somewhere like Documentation/arch/riscv/uabi.rst
