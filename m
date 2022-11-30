Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228C63CDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiK3DAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiK3DAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:00:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9A6F362
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:00:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso664200pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UTTKtw9h/uDbm2sJVfPVsezkUtjRi/h4SZI/iHnG9Y=;
        b=k8lZtI/9upV1XjKYxj6UK1eTBLZPJiWF8ENyjv+QbEmsPmmQpquoHC7g8okx1kKPSt
         mQjm6DM42IDKuL6H/+eyk2r5qa5kUwjsgCHGJrYVNSMnG9oJNnba3UywSf9LybkTImG5
         hT1Ha5Xj86XyySxPYQCUGL8E2aepf74J1kp34+yUiX7lHgjjikglWYXIuzh/agr1AGDG
         cdyWNV3WLjWaPD/Le7vUFBw+TDVGujDmgKOITjkIezWsglloj2WtWt5cl0VWSIIKTou4
         enUwlbAG01JqIIWExb2MszQEfqHcnoLwuVZlRCBTcD8U/Kf80nYUCM0dnJ/AWDDzaG9P
         hy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UTTKtw9h/uDbm2sJVfPVsezkUtjRi/h4SZI/iHnG9Y=;
        b=jQfVwfGn3m0ewH61u31ZvUlalyrtzG7OOgiuFbqaMyvS6OWXS/6L7wDxIfnLVqlbWt
         8xz8wkoPEtddL+Khd3lPvubNRBquNBPOdfrdcgk2ezokjL331LmAZ6Uody/VCZ9GdNcP
         xVOTVf1yFZWEN+GjvG0nMvik8n4HMBDKSLdi9SA03IiBmEeE7uKdbYXQmJyWSiVgyOvP
         cI/VhFZCAv5jb9IWIkxhIdj7DFx9hnqCiXDPy0uInOLPhw0EqR+uIjpN80KZbqnJ9oVC
         QLk8jiTykkcf6jEui+z/JDnbnjqaMe9q3zqwtWdd9xCPzxoJ8nZwCBokvYEtaYzZjrcM
         6GbQ==
X-Gm-Message-State: ANoB5plh1+Mgw6D5vIsLwXzHkMLjRb9QqxfqA6azrFyM8Zlg3Vvyyqzs
        IDXHoOxPaMAc0wlCQ4P9haNQCA==
X-Google-Smtp-Source: AA0mqf7aaJe0L4LvowJ1ooGBcGu5N74WM1WKdlGm9HYpnPv86VmcYosD/uucvwnEBzXbnPsu5kdMcw==
X-Received: by 2002:a17:902:70c9:b0:176:a0cc:5eff with SMTP id l9-20020a17090270c900b00176a0cc5effmr49371814plt.128.1669777231878;
        Tue, 29 Nov 2022 19:00:31 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902eb8e00b0018685aaf41dsm55167plg.18.2022.11.29.19.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 19:00:31 -0800 (PST)
Date:   Tue, 29 Nov 2022 19:00:31 -0800 (PST)
X-Google-Original-Date: Tue, 29 Nov 2022 19:00:23 PST (-0800)
Subject:     Re: [PATCH 1/2] RISC-V: Align the shadow stack
In-Reply-To: <CAMKF1sryF=inn0B=n=cZi7ZmRcWh3cAtR4uq9DYJfVpD_zOpVA@mail.gmail.com>
CC:     jszhang@kernel.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Khem Raj <raj.khem@gmail.com>
Message-ID: <mhng-5a2b0379-88e4-43be-8d47-1f019aed05e0@palmer-ri-x1c9a>
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

On Tue, 29 Nov 2022 18:56:48 PST (-0800), Khem Raj wrote:
> On Tue, Nov 29, 2022 at 6:50 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> On Tue, 29 Nov 2022 18:47:55 PST (-0800), Khem Raj wrote:
>> > Hi Palmer
>> >
>> > On Tue, Nov 29, 2022 at 6:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>> >>
>> >> The standard RISC-V ABIs all require 16-byte stack alignment.  We're
>> >> only calling that one function on the shadow stack so I doubt it'd
>> >> result in a real issue, but might as well keep this lined up.
>> >
>> > Is 16-byte alignment required on rv32 as well ?
>>
>> For the standard ABIs that's the case, it's so the Q extension can spill
>> without aligning the stack.  There's also at least a proposed embedded
>> ABI that has just XLEN (32-bit on rv32) alignment, as the bigger stack
>> alignment has an impact on some use cases.
>
> Thanks, so in this case 16byte will be valid for both rv64/rv32 here.

Yes, though the long-alignment wouldn't break anything because we don't 
have Q support and we're just calling that one function -- it's not like 
the compiler is actively checking for 16-byte alignment or anything, 
it's just assuming it.

Still best to keep things to the spec where we can, though.

>> >> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
>> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> >> ---
>> >>  arch/riscv/kernel/traps.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> >> index be54ccea8c47..acdfcacd7e57 100644
>> >> --- a/arch/riscv/kernel/traps.c
>> >> +++ b/arch/riscv/kernel/traps.c
>> >> @@ -206,7 +206,7 @@ static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>> >>   * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
>> >>   * to get per-cpu overflow stack(get_overflow_stack).
>> >>   */
>> >> -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
>> >> +long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
>> >>  asmlinkage unsigned long get_overflow_stack(void)
>> >>  {
>> >>         return (unsigned long)this_cpu_ptr(overflow_stack) +
>> >> --
>> >> 2.38.1
>> >>
>> >>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
