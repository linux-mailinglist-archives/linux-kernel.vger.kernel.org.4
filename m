Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5A74FB81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGKW62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:58:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F62110CF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:58:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666edfc50deso91403b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689116304; x=1691708304;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeLvW6D54qYtLtvV95QMxdsxsHGn9g+mFHvvl4agGGw=;
        b=zveT6mE3hRwUkRV2JFTDkocB6GXTSrdEgogx+FhQ+HIkVEC1zMVussEvCpIzB2P3Jx
         7Vzn/l649Laf9WvcAHiWt6r8huPY/x6wdX9lMbtF3W1kRtGOU/RI19r19YVumF4PIIO3
         90QF9budYvTYIF3k1PiIzb5j8EzKyOmGaVXCfmFeNHMk9r5XC+vOwezgxvX1zCz6udXt
         0uWU6TQHvKl2pt7tUFCRhQFKWppfopqopa2EXyVoMwl8krZxuuzXLqvTVqGcMtdZ+dvG
         hWokZ0zM2mlIYSdDD3W26xLVg50rq4lR/Gn6h3HGkJS1kPOGRgi1bNgqqQKEnRR1fYb6
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689116304; x=1691708304;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeLvW6D54qYtLtvV95QMxdsxsHGn9g+mFHvvl4agGGw=;
        b=BmnpSE87AC1QUCEeHW3cc+tDgGXua4jPnqIUtvUmhKUkR2pSyGS6EdtLS8TLx4xW6F
         E18X5saUPJcArPTw+Qrdv5i1WWxaSLqjkJ3ojSp4qYGAozEcDKJ4PSk/sIEhjumhhZ2m
         9mxffNxlcwhRYFTkSXPEpiyGQaHzKBLGnljrPc4KkE9hxSMGvuVr+M4Hj+kaKEsIrWbW
         U5rDNltrLQNHbH0O91n+L6/Loat08J3m5tsQupeWz05cVnTR9API8aEQDJWw4AkMzHuY
         JI6bZWMBMteWpMyeO51cRw/ri+W/5r4cui98v5sKGG49O47Gr+Z7EPLhkR+kQ2HKAP1D
         mnwQ==
X-Gm-Message-State: ABy/qLZxXDcGDtU3AAb+8poDMb0NhT7FrM87vLQC8ODOgTLjjnV0scgH
        gPt46omVTIqbPEZsaSxBVNdB5Q==
X-Google-Smtp-Source: APBJJlGbVeR+usq5mkjJSkRjIfg6unR5oIgdwcaqHF6GztUBJut44qmTWRK0Xdqw5QfzKHKOS6iUNA==
X-Received: by 2002:a05:6a00:3927:b0:673:6cb4:7b0c with SMTP id fh39-20020a056a00392700b006736cb47b0cmr322214pfb.2.1689116304551;
        Tue, 11 Jul 2023 15:58:24 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id j9-20020a62b609000000b00678afd4824asm2254698pff.175.2023.07.11.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:58:23 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:58:23 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Jul 2023 15:57:37 PDT (-0700)
Subject:     Re: [PATCH V2] riscv: Add BUG_ON() for no cpu nodes in devicetree
In-Reply-To: <20230630-blasphemy-tapestry-85755d24cbc3@spud>
CC:     suagrfillet@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, sunilvl@ventanamicro.com,
        heiko.stuebner@vrull.eu, apatel@ventanamicro.com,
        Evan Green <evan@rivosinc.com>, greentime.hu@sifive.com,
        leyfoon.tan@starfivetech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-e321737a-1406-4d22-b93b-6baa1b900461@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 11:39:24 PDT (-0700), Conor Dooley wrote:
> On Fri, Jun 30, 2023 at 06:59:38PM +0800, Song Shuai wrote:
>> When only the ACPI tables are passed to kernel, the tiny devictree created
>> by EFI Stub doesn't provide cpu nodes.
>> 
>> While if append the "acpi=off" to kernel cmdline to disable ACPI for kernel
>> the BUG_ON() in of_parse_and_init_cpus() indicates there's no boot cpu
>> found in the devicetree, not there're no cpu nodes in the devicetree.
>> 
>> Add BUG_ON() in the first place of of_parse_and_init_cpus() to make it clear.
>> 
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>
> I'm still not really convinced that this is needed - not finding the
> boot CPU is a strong a hint as any that your DT is completely broken.
> Especially if you intentionally go out of your way to disable ACPI on a
> system that requires it to boot.
>
> I'll leave it up to Palmer or whoever to determine whether this is a
> valuable change. Code change itself much improved though, thanks - I'd
> give an R-b/A-b other than that I question whether there's any value in
> adding another BUG_ON(). You could've kept the part of the comment that
> explained what the error meant though, but that's not a big deal.

IIUC this is just reduntant: if the BUG_ON triggers then there's no 
CPUs, so we'll end up with no iterations of the loop and thus no found 
CPU and thus a BUG_ON.  The only difference is the SBI probing, but 
that's just poking SBI to turn off spinwait.

So I think we already crash sufficiently on systems with an empty DT.  
Sorry if I'm missing something, though?

> Thanks,
> Conor.
>
>> ---
>> Changes since V1:
>> https://lore.kernel.org/linux-riscv/20230629105839.1160895-1-suagrfillet@gmail.com/
>> - revise the commit-msg and move the BUG_ON into of_parse_and_init_cpus() as Conor suggests
>> 
>> ---
>>  arch/riscv/kernel/smpboot.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>> index 6ca2b5309aab..04d33afbdf55 100644
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -147,6 +147,8 @@ static void __init of_parse_and_init_cpus(void)
>>  	int cpuid = 1;
>>  	int rc;
>>  
>> +	BUG_ON(!of_get_next_cpu_node(NULL));
>> +
>>  	cpu_set_ops(0);
>>  
>>  	for_each_of_cpu_node(dn) {
>> -- 
>> 2.20.1
>> 
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
