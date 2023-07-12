Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B71750A35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjGLN6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjGLN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:58:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0EA19A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:58:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso5329701a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689170281; x=1691762281;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oC9OkzryYNUsrIJJk91LArI6yaBglzBIZ57i2Rttt4=;
        b=0I6prQ+o9hBKlVQK65s7zJ7P1j/BlSBXRgq9K89ET4q1kyAVoaQNR057+BT5H0+Fcq
         sE9AyJJP2iqUTpTvQhPV30I84yZm8zaxaV4tFF5Dbwg6bFr2Smh0E5Ed1NmksRxcTInD
         gKswgUhD4v7fWEpGm/hxipkDqNxf85J2bdnuH0emePe9I3bOTrvB7kFM0J7dyfgmELvj
         P5aY3YG3ZtRdiU3OK6jUTjqzTK0/RlW5GR4/zP1+/ogqDLhgJ3WnzTztmsthnyDusg1s
         z3H3A2BfuKxZlqDxtNJNjpaEM3BvwKAN8aIH9YPfMlA9+srHGi8GmOeuW2U/b9EY96yQ
         A1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170281; x=1691762281;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oC9OkzryYNUsrIJJk91LArI6yaBglzBIZ57i2Rttt4=;
        b=Ns1hlDXQSeC/xONzPiO1Shs1PQ1tAZRzYlRftsLnV28QAsbNak+Qxn2SagE12dpsgl
         89G+DNI4pVNgF0civmbpna/N0ojbaC7TRR1oJYnGCjMMaFBCRHnqlABD/iTaJFbJzrS2
         LNY9AcJk5pRJ7DMv7ipMbRteydlXS1nuEI6e7FSFmIrNNL1ZwJgpyKEoW7bdlmKZiv50
         Oho+FjGjmOUMMhVe74rer1toCydlMSQIlo17jEcBviq3sdNJKXtyV7lz1WkuyUcFciXd
         4/utLjJt6AMT1pSszzrfDSDUFeAho+z5zPN0xd5xJMg503qUWArXheh4G7wKPb9sX2Iy
         W8Kg==
X-Gm-Message-State: ABy/qLY7bNZ9PBcNqFZqaX4BJEjx1jmnnrJuOsKLf80oVEGbP5uhXeAL
        hYJnpkTv5Azs4NMiZXWCpwUPNw==
X-Google-Smtp-Source: APBJJlGMmRhlspwbc2SXLIA/EgEjHhFgOkiHVK6IGfF+ogbpCjLazhHNp932RmH00pOHrbsBL79krA==
X-Received: by 2002:a17:90a:b011:b0:263:4164:dfba with SMTP id x17-20020a17090ab01100b002634164dfbamr17923406pjq.6.1689170280755;
        Wed, 12 Jul 2023 06:58:00 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id g7-20020a63b147000000b00553b9e0510esm3551363pgp.60.2023.07.12.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:58:00 -0700 (PDT)
Date:   Wed, 12 Jul 2023 06:58:00 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 06:57:13 PDT (-0700)
Subject:     Re: [PATCH] riscv: correct pt_level name via pgtable_l5/4_enabled
In-Reply-To: <a7bb09c9-870a-d8f2-23c3-7f6fd2c68e2b@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alexghiti@rivosinc.com, Bjorn Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr, suagrfillet@gmail.com
Message-ID: <mhng-05add620-8132-496a-a514-4b78c78b3694@palmer-ri-x1c9a>
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

On Tue, 11 Jul 2023 04:14:10 PDT (-0700), alex@ghiti.fr wrote:
> Hi Song,
>
>
> On 11/07/2023 12:52, Song Shuai wrote:
>> The pt_level uses CONFIG_PGTABLE_LEVELS to display page table names.
>> But if downgrading page mode from kernel cmdline in 64BIT, it will
>> give a wrong name.
>>
>> Like, using no4lvl for sv39, ptdump named the 1G-mapping as "PUD"
>> that should be "PGD":
>>
>> 0xffffffd840000000-0xffffffd900000000    0x00000000c0000000         3G PUD     D A G . . W R V
>>
>> So select "P4D/PUD" or "PGD" via pgtable_l5/4_enabled to correct it.
>>
>> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> ---
>>   arch/riscv/mm/ptdump.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
>> index 20a9f991a6d7..cfdd327981ee 100644
>> --- a/arch/riscv/mm/ptdump.c
>> +++ b/arch/riscv/mm/ptdump.c
>> @@ -384,6 +384,11 @@ static int __init ptdump_init(void)
>>
>>   	kernel_ptd_info.base_addr = KERN_VIRT_START;
>>
>> +#ifdef CONFIG_64BIT
>> +	pg_level[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
>> +	pg_level[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
>> +#endif
>
>
> You don't need the #ifdef here as pgtable_lX_enabled are always declared.
>
>
>> +
>>   	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
>>   		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
>>   			pg_level[i].mask |= pte_bits[j].mask;
>
>
> The Fixes tag is wrong to me, if satp mode is restricted by the hardware
> itself (not from the command line), the same problem happens. Maybe that
> should be the sv48 introduction patch? Or the sv57? It will be more
> cumbersome to backport with the sv48 introduction though as this patch
> won't apply as-is.

Sometimes it's easier to base the fix on the original offending commit 
and then forward-port it via a merge, I haven't looked at this one to 
know for sure though.

> Otherwise, you can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks.

Song: do you have a v2 that addresses the comments?

>
> Thanks,
>
> Alex
