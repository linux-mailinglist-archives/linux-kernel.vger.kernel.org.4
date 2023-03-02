Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAB6A79EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCBDRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCBDR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:17:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4699515CB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:17:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso1396635pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677727038;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgpf8cgLJj50M86L5F9BUoIAMwjT++SeEfR1/zwwwE0=;
        b=05BK9h2oN73d+vLQZ8AXICX+yqZH9PJw8eGQwQu3aLpPw/PQkKLBM+zl4FHFPDCMbr
         oT2a7ycW9j4IvNJVs7ZNd3qeiw85Qtha4m0oAo5Q0QiPipyRwzSV4J3XcelEef5d8yqB
         I4KXQDK7qQ+mAPYeZvAqQG78vIyZoGQH/5i1rIXtVNLbcQNF9Kn0gW9O7HWaBv1Z1Hfx
         4q2OGZuaoqmuPypq3KgIWVltCxcy5gmQYJ+016KcQmuC/U0yrGY0o6z+m+PHYIZUzGYI
         1grLiGwuTn7D4jkc5r6I/7tUA73EppBwvM41vkni8yrDAA+aUFBNlGO/ZUE432ubFqlh
         lUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677727038;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgpf8cgLJj50M86L5F9BUoIAMwjT++SeEfR1/zwwwE0=;
        b=pktwb0jpzhv81ApOdU3WGslMYsFdvh2RiHm8fj2d3atoY6U5L5sy5k+F4+DGMYa5Tb
         wc8rkhMWPOdOJqkpE+7olteq64m/VV0TPLsTkg/ddBTi1ZL+cqXwCtFUBMBOzkiynZ7/
         psiBZKFmpHWY7mKETUnMPw4MDs0prOTmE+d/6VF2x8UHmF48JUrNnkdgl7ucSjw1tpXv
         PZAZLDRMP+rkJ8m6LDkQqKvcJHu0kVDzyKKDA6DNvWpHxn8sXz49dMS6NJttpHmNUrVU
         lZa8qWwlV5yndsnF1kqtmk3naNmTRbJyB328sG3jJhMGBT0CNwN+N3bzKMvZSMktlMWq
         8WDw==
X-Gm-Message-State: AO0yUKU1wKF2DnR+M4hhNttrVFC/EFqgra4YHZv1+GovKEJFvBtGHWDB
        G49BPr4pBr/l3rtkNNQ6o7T9Qw==
X-Google-Smtp-Source: AK7set9sdV/+BdUm2bBjL395AsIYL1A1j9eCLS8ecMxY0Ws8WD4l1oqL273WzlVwyO1Yv4lm9xFKPQ==
X-Received: by 2002:a05:6a20:1bde:b0:cc:de56:957a with SMTP id cv30-20020a056a201bde00b000ccde56957amr8709472pzb.13.1677727037881;
        Wed, 01 Mar 2023 19:17:17 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id h192-20020a636cc9000000b00502f5cd216bsm8183287pgc.6.2023.03.01.19.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 19:17:16 -0800 (PST)
Date:   Wed, 01 Mar 2023 19:17:16 -0800 (PST)
X-Google-Original-Date: Wed, 01 Mar 2023 18:55:30 PST (-0800)
Subject:     Re: [PATCH v3 03/24] arm: Remove COMMAND_LINE_SIZE from uapi
In-Reply-To: <874b8076-b0d1-4aaa-bcd8-05d523060152@app.fastmail.com>
CC:     alexghiti@rivosinc.com, linux@armlinux.org.uk, corbet@lwn.net,
        Richard Henderson <richard.henderson@linaro.org>,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-78901e66-16df-4563-9e2c-3a9744ef2828@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 05:09:17 PST (-0800), Arnd Bergmann wrote:
> On Thu, Feb 23, 2023, at 10:54, Alexandre Ghiti wrote:
>> On Wed, Feb 15, 2023 at 2:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
>>> > On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
>>> >> From: Palmer Dabbelt <palmer@rivosinc.com>
>>> >>
>>> >> As far as I can tell this is not used by userspace and thus should not
>>> >> be part of the user-visible API.
>>> >>
>>> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>> >
>>> > Looks good to me. What's the merge plan for this?
>>>
>>> The easiest way is probably if I merge it through the whole
>>> series through the asm-generic tree. The timing is a bit
>>> unfortunate as we're just ahead of the merge window, so unless
>>> we really need this in 6.3, I'd suggest that Alexandre resend
>>> the series to me in two weeks with the Acks added in and I'll
>>> pick it up for 6.4.
>>
>> Sorry for the response delay, I was waiting to see if Palmer would
>> merge my KASAN patchset in 6.3 (which he does): I have to admit that
>> fixing the command line size + the KASAN patchset would allow 6.3 to
>> run on syzkaller, which would be nice.
>>
>> If I don't see this merged in 6.3, I'll send another round as you
>> suggested in 1 week now :)
>
> Hi Alexandre,
>
> I have no plans to still pick up the series for 6.3. The patches
> all look fine to me, but it's clearly too late now. What is the
> actual dependency for KASAN, do you just need a longer command
> line or something else? If it's just the command line size,
> I would suggest that Palmer can still pick up a oneline change
> to increase it and refer to this thread in the changelog as a
> reference for why it is not an actual UAPI break.

Sorry for being slow here, I just queued up the original patch in the 
RISC-V tree and intend on sending it for 6.3 -- the main worry was that 
it's a uABi change and we're confident it's not.  It's late, but I'd 
prefer to have this as it should let us start running syzkaller now and 
that'll probably find more bugs than this is likely to trigger.

https://lore.kernel.org/r/mhng-b5f934ff-a9bb-4c2b-9ba6-3ab68312077a@palmer-ri-x1c9a/
