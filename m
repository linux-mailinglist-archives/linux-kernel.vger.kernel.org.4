Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD6737535
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFTTmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFTTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:42:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD21729
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:42:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b51780c1b3so39751055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687290131; x=1689882131;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHU5CwA5u8pSrmDppHcT4qFU7dGFryoenZ6OqORvEs8=;
        b=F/4PvAGbsDJNMQNZRVwv4lMqDOI41XUjCyn+5TQG4/s17oVEsd/Cihbm/Sxav0pkON
         pbv+U1N1KxMshXDXoW0C1j7II1qehV4llRKEAU8f8IVNfBRrhB739/AtdkiR4SbEkkCC
         R4teCwxSranNzpKONPzRHai9FyQf+zBbHejZUcNu5JtGkDDxcwRaoFlUMXm4sVwudHyC
         sTzdUjL+NShCSigwrAroMAwD29HI4El1WLCPgJrbam8yzZDr7ogsO/PvbAfbzmrCQKTN
         bAk1Jj6SmKaaHKM566zCi6lNRuDtsbc6lXb+mV8AyeA0qaVlJK1yd8SMdgEy988DbhFE
         33ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290131; x=1689882131;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHU5CwA5u8pSrmDppHcT4qFU7dGFryoenZ6OqORvEs8=;
        b=K5womokYxO2lh8Pw07HmQVBZtcBgFkLEw1dovpmXwOy6zPsGBmYhAmBKYbETXTxZB3
         RKcdT3EByzzZ/OPisExRT1C5puCMpmZNPYlxtcUw7YdRygFBij86Sw/3t20WZB9NzMGU
         FMwiLQRKdWhClLz5PLuRl2h0/4qKNcY3f/7PJNwBroJIyOO1MJui/IJTpb0eZ8kEMNuw
         xqThkbvsO7UsImH/8l+O5aAhnXMEaLN/1LiJt/JAP9HHJTAjDQrHtPSJ2XmoJ4V6EkT7
         luIBbvcrOLegnLW4izQwamVihdIjsPL2Q9ojI8C0V9ql8stJTkkRN2+jgqggT/1oX3HR
         W8Vw==
X-Gm-Message-State: AC+VfDxfyThNk97sw8wi+FIlxp61lPwVc4hASS8Rd+cQkwWCqTl1fWOH
        FKLuurOLa6otTYnZWndCmxWXUw==
X-Google-Smtp-Source: ACHHUZ7M5H+Lb2l7RjrGwDbavqFd07Q1CmIGajRPCoPGx5ZVej4nFjxGA1fiO3QiDimYzv6xtZ1t2A==
X-Received: by 2002:a17:903:48a:b0:1b5:cbc:b4c with SMTP id jj10-20020a170903048a00b001b50cbc0b4cmr12337830plb.46.1687290131574;
        Tue, 20 Jun 2023 12:42:11 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jm2-20020a17090304c200b001b558c37f91sm1950372plb.288.2023.06.20.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:42:11 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:42:11 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 12:41:31 PDT (-0700)
Subject:     Re: [PATCH v5 1/4] RISC-V: add Zbc extension detection
In-Reply-To: <75cf8335-af1f-e06c-c770-b2b540e812ed@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>, heiko@sntech.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Jeff Law <jlaw@ventanamicro.com>
Message-ID: <mhng-5286e1ed-b3ae-40ce-bd33-8871a1a07f3a@palmer-ri-x1c9a>
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

On Tue, 20 Jun 2023 12:37:00 PDT (-0700), Jeff Law wrote:
>
>
> On 6/20/23 13:09, Palmer Dabbelt wrote:
>> On Mon, 12 Jun 2023 14:31:14 PDT (-0700), Conor Dooley wrote:
>>> Hey Heiko,
>>>
>>> On Mon, Jun 12, 2023 at 11:04:39PM +0200, Heiko Stuebner wrote:
>>>> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>>>>
>>>> Add handling for Zbc extension.
>>>>
>>>> Zbc provides instruction for carry-less multiplication.
>>>>
>>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
>>>> ---
>>>>  arch/riscv/Kconfig             | 22 ++++++++++++++++++++++
>>>>  arch/riscv/include/asm/hwcap.h |  1 +
>>>>  arch/riscv/kernel/cpu.c        |  1 +
>>>>  arch/riscv/kernel/cpufeature.c |  1 +
>>>>  4 files changed, 25 insertions(+)
>>>
>>> Plumbing into the hwprobe stuff would be nice, but that's not a
>>> requirement for getting stuff merged :)
>>
>> IIRC we talked about this on IRC, but IMO we shouldn't require something
>> be user visible for it to be merged in the kernel.
> Note that exposing Zbc is potentially useful.  We've got GCC and LLVM
> code that can detect and rewrite a bitwise CRC into clmul.

Ya, there's another thread about adding it.  IMO we should do so, just 
that we shouldn't gate kernel support on also sorting out the uABI as 
sometimes that's complicated.

It's simple for this one, though, so I'm not opposed to taking it for 
the merge window if it shows up in the next day or two...

>
> Jeff
