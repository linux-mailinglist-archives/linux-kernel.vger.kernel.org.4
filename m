Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002CF6F3ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjEAWxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEAWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:53:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E73593
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:52:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b35789313so2215927b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682981579; x=1685573579;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTv50nIrfCNQoHawn5oqdnZtRiKF6KBiXdv3yqP+nIQ=;
        b=5TH88B+l/7j3ul1jwKaO8gqEIyO8rojGINeSxc/bgUfFZH6rQ2VQJceO7sXn/TesAe
         Dse5qoBWDUWo+CCuFQUJycg4nuA6rH1yzXNsEoWs/kPtjbf9BDPzDPVOVQZQc7txtUrS
         InabVGT7UQdNZ5sLtDPo64Hc5FHZ8bmxGpUWCoQ1BnGK+t0sXueblI7MOrAgrFW4LE4v
         SBIYW6GovG/szVV9akB4v+u89SJ2w4T8q4nzMILasOH+58gqMPT8HseOtzO3GXrkyWX+
         h9rwpQto2t5kXHJT3KZAWuQkM56eusondqvpKJlQLsNoJ+DwAoFE7ytDpOYC29BTi8JI
         rTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981579; x=1685573579;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTv50nIrfCNQoHawn5oqdnZtRiKF6KBiXdv3yqP+nIQ=;
        b=R33sffem0N+E9eLauLDZ7vJ+nMGForFqRDM6XkPyR+dYIC4G9b76H32pJ0OI0Lvywq
         gJVxqswql4K81Pig+vdIuGAe40EHF8/g6UmcO30Yj7IM09yf8Ea2h8u6908qixgZXhNt
         NNHZsnd1Ds33Bikl5+w84r4yZO0TO2twClVZ1X72U7UdsW20DyRfnkOWh28a90q6F2nt
         Rz5tttEe4tnG2yrOhlgaT7DWxVOfUppWVoYI0q0gnnzqN2JXtfzS2Y2hmXjlHxKE3vRg
         bOpn+AaGB52090bAAjMp7HHemUWiWK+7QD6T2/lJ9AZ2MvW2kys9ZKz+nfCHohp1ITKW
         w6dg==
X-Gm-Message-State: AC+VfDySFh9d8iMjT7ZecomLnwGgVlFfghxY99mcqoCcv/D2jZOiTPYJ
        LiBIHv3aKlOnjYVRi4kS6mtOJg==
X-Google-Smtp-Source: ACHHUZ5nK2f1+8bX7jtr1uIhCEVldW9ZMDhDwM/VQw5iiDhuDlrHmavF3TrbDWZd82s5R2fExE/J4A==
X-Received: by 2002:a05:6a20:9191:b0:f2:dc4d:935d with SMTP id v17-20020a056a20919100b000f2dc4d935dmr19737997pzd.18.1682981578961;
        Mon, 01 May 2023 15:52:58 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id m15-20020a056a00080f00b00627e87f51a5sm15911641pfk.161.2023.05.01.15.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:52:58 -0700 (PDT)
Date:   Mon, 01 May 2023 15:52:58 -0700 (PDT)
X-Google-Original-Date: Mon, 01 May 2023 15:52:33 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: fixup in-flight collision with ARCH_WANT_OPTIMIZE_VMEMMAP rename
In-Reply-To: <20230429-neurology-sudoku-8d53b23d01b8@spud>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-e1596f31-67bc-4e2e-b86e-a32da907eecd@palmer-ri-x1c9a>
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

On Sat, 29 Apr 2023 02:32:33 PDT (-0700), Conor Dooley wrote:
> On Sat, Apr 29, 2023 at 10:27:33AM +0100, Conor Dooley wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>> 
>> Lukas warned that ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP had been
>> renamed in the mm tree & that RISC-V would need a fixup as part of the
>> merge. The warning was missed however, and RISC-V is selecting the
>> orphaned Kconfig option.
>> 
>> Fixes: 89d77f71f493 ("Merge tag 'riscv-for-linus-6.4-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")
>> Reported-by: Lukas Bulwhan <lukas.bulwhan@gmail.com>
>
> That should have been Lukas Bulwahn <lukas.bulwahn@gmail.com>.

I think I got that right, but the email bounced.  I'm not sure if it's 
just the list issues, though.

> This is what I get for hand-typing an email address that I could have
> copied from lore I suppose.
>
>> Link: https://lore.kernel.org/linux-riscv/CAKXUXMyVeg2kQK_edKHtMD3eADrDK_PKhCSVkMrLDdYgTQQ5rg@mail.gmail.com/
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> I guess you picking this up for your second PR makes the most sense
>> Palmer?
>> 
>> CC: Palmer Dabbelt <palmer@dabbelt.com>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> CC: Lukas Bulwhan <lukas.bulwhan@gmail.com>
>> CC: linux-riscv@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> ---
>>  arch/riscv/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 5c88ac4b52be..e1bdb3fb16cc 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -46,9 +46,9 @@ config RISCV
>>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>  	select ARCH_WANT_FRAME_POINTERS
>>  	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
>> -	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>>  	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
>> +	select ARCH_WANT_OPTIMIZE_VMEMMAP
>>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>>  	select BUILDTIME_TABLE_SORT if MMU
>> -- 
>> 2.39.2
>> 
