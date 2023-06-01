Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5A71F45B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjFAVEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAVEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:04:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256F189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:04:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b04949e5baso11942045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1685653471; x=1688245471;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K31mK0e+lIqylDP59GLpflc/FdALwYXOTEKBXYSCF3s=;
        b=hD86mUY+jh5Zr2r/OzEM0gXDwcMSCuP0E3Mpln2EzFR5snPWjqAabs2J0xyA8iQNOw
         eET4SphsWQLerVWdmiRSkShubeB+xEDyJ4I7qEFAIcvb8WOTtKPqyMlXNNeaocvXW2kH
         5ES/j4TYGlpedOet+dBKJol76pC/VtZwTdVZrvBZ/ItjXWGyt3gCOt/mEraErqqALmMl
         RfimiiKTwlH65pIWR9c2C63g5VezIf2prF0S5uWvoVWKnBgkoCvdqIFwXncSO6rckt0U
         lvn3r0wtzRID1YMpNeWoWmP5b2vJHcbgEMsB0MGFSfs2GLlJNEHJz1m5IoFHbxT1zUiS
         jpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685653471; x=1688245471;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K31mK0e+lIqylDP59GLpflc/FdALwYXOTEKBXYSCF3s=;
        b=dv6XvkM+tVqnL+LjAz6OQbSFN8Enp9HL4lqpIaUUt4EZ69T1eCi4ZjnfhFjLq+U28s
         xaWZqVv4nixkDnxXbGCotEcBCOCxVDJEwF42g7dbpPLI5A2RjRHdHbh4szOJBut3mW4f
         WQv+3KvxsPDRi+Kg6fYtkIdy4qXw+Xu+WTNZCJY7NZ53TABSqhj4NB/rBAUz1vdUmDck
         TLdSaoMoccFNT1+4V6YJ/ZOrqdnLXH3uF+7EA3zG6l+kkbB2cWyo+/5NE8WHLg4/V4QJ
         r77AzC0+KPDwdzI+OIGKawqWvya8pbp0dWCEa/i/eUxVSizjKDprcRmq5v4fkABSGWHe
         EJ/w==
X-Gm-Message-State: AC+VfDy1F/eivneFw+SVJRFhorQMXH3kLqQ4HROdgjeEDlOjNV6MPbWE
        JF2+lFAUEHaSiWpW9Y7O1KVkjw==
X-Google-Smtp-Source: ACHHUZ4tEOZ/E7aubo2t8nuiBBW7VMGKRiaRb2mGTccmObI2XGljcRJI09ojuq0f4iNB65iD0dXc8g==
X-Received: by 2002:a17:903:4292:b0:1b1:78ba:f350 with SMTP id ju18-20020a170903429200b001b178baf350mr456252plb.46.1685653470704;
        Thu, 01 Jun 2023 14:04:30 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001b034d2e71csm4009814plk.34.2023.06.01.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:04:30 -0700 (PDT)
Date:   Thu, 01 Jun 2023 14:04:30 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Jun 2023 14:04:00 PDT (-0700)
Subject:     Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
In-Reply-To: <202306011331.880AF01743@keescook>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        linux@leemhuis.info, heiko.stuebner@vrull.eu,
        linux-hardening@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, joanbrugueram@gmail.com,
        masahiroy@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, hi@alyssa.is
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-cb8265a9-018d-483b-8de9-b7b2eaa5557f@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 13:31:33 PDT (-0700), keescook@chromium.org wrote:
> On Thu, Jun 01, 2023 at 01:17:03PM -0700, Palmer Dabbelt wrote:
>> On Thu, 01 Jun 2023 11:27:03 PDT (-0700), keescook@chromium.org wrote:
>> > On Thu, 1 Jun 2023 09:00:28 -0700, Kees Cook wrote:
>> > > With the addition of -fstrict-flex-arrays=3, struct sha256_state's
>> > > trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
>> > >
>> > > struct sha256_state {
>> > >         u32 state[SHA256_DIGEST_SIZE / 4];
>> > >         u64 count;
>> > >         u8 buf[SHA256_BLOCK_SIZE];
>> > > };
>> > >
>> > > [...]
>> >
>> > Applied to for-next/hardening, thanks!
>> >
>> > [1/1] riscv/purgatory: Do not use fortified string functions
>> >       https://git.kernel.org/kees/c/ca2ca08f479d
>>
>> Sorry, I'd just applied this to riscv/fixes as well.  I can drop it if you
>> want?  I was going to send a PR tomorrow, just LMK.
>
> I'm fine either way. I was carrying each arch's fix just since it was
> related to the -fstrict-flex-arrays=3 patch in the hardening tree.

Works for me, I'll drop it.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

The bots will probably get confussed and it was briefly visible to 
linux-next, so there might be a bit of spam.
