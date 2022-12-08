Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077706479ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLHXaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLHXaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:30:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746A86ACED
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:30:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so2383339pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xjcdkPHdm6uKkgcgf2wZxDGHKg/K8iOgm6bCXEn/oQ=;
        b=rb5booq/HHdSewBCekfBW2j8iIo4ZxuYd7rba/kPyLbrSTVQ/N+gk8E8V90ISLagt8
         43UERn2GsQVbsvToJftGQMxF01nC8iLFbvTjt2YthHiu3RCEHoga3QFwA29gjNEdUxDa
         JFFyD2YYXauV+1tjc6UoWjtZWR8TKqzSiFae91cjyhBF3c2XgraZTyxU8MNxGRVpy8kr
         2u2QrGtPwQTk9tZamvfsyPStS/ootU8voYx9kWfrBxHa7aQZ3z+oUTSA4tyuI5pdBXVK
         jyKSEEbm07aXR9ii2qXKosDYfcc6OfcSkmTHMYWf49aGsqjXQ2fDRZYQkWLEvLIqu2y/
         qtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xjcdkPHdm6uKkgcgf2wZxDGHKg/K8iOgm6bCXEn/oQ=;
        b=OLopxjV4Q6yhax52H3XKEcodRElWOBFaBeXb3JyvhTS276bOSN8Z/wFlSG/Kv2oqRb
         GjKJH8JBKVfS8P6doSC3hHIWCoHO9SCfVxVbuMRYZ+8dqjki8iZrJ+r+Byf8ttWiQdjt
         mbieeRLXgf6MNvdI5/Iq36ySZFTK751JMesHAFPH/5kSimh41gXcstHlqgjyDPqcmm0u
         C7sFqK3KxZr2FtvnamqivK9+MG/W2BuQKsUEzi0t7S66jZ3NGZMsRR1plmvjpoZFavzL
         DO42BcvmeQU9io45dQk4rTe16FvoioTXPldIcxJMd1nBNig22HuYbIxNsW8yiqyjr0dd
         /RCg==
X-Gm-Message-State: ANoB5pllJVRHZ+Z/BZayM+DGey2hQjnHoyVKBlRsLDu8Iw2JTPKGfSSe
        0/qIN3Nc4kR1BI41WcxggcWdAA==
X-Google-Smtp-Source: AA0mqf4jlf5nNpHTGQ5fF5ipKRiwgNSh829jsjgr+RN3u82vvhuvmYKHy6QyXAd4yoda9cNA1qDUYw==
X-Received: by 2002:aa7:9555:0:b0:576:c9a1:ec35 with SMTP id w21-20020aa79555000000b00576c9a1ec35mr4679501pfq.17.1670542208857;
        Thu, 08 Dec 2022 15:30:08 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c2-20020aa79522000000b00575acb243besm52081pfp.1.2022.12.08.15.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:30:08 -0800 (PST)
Date:   Thu, 08 Dec 2022 15:30:08 -0800 (PST)
X-Google-Original-Date: Thu, 08 Dec 2022 15:29:52 PST (-0800)
Subject:     Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
In-Reply-To: <Y3fxsWPLPlKGfMBj@curiosity>
CC:     guoren@kernel.org, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr,
        Christoph Hellwig <hch@lst.de>, ajones@ventanamicro.com,
        gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com, apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     geomatsi@gmail.com
Message-ID: <mhng-1d55338a-53a1-42eb-bf5c-91655fde2734@palmer-ri-x1c9a>
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

On Fri, 18 Nov 2022 12:57:21 PST (-0800), geomatsi@gmail.com wrote:
> Hi Guo Ren,
>
>
>> After use_asid_allocator is enabled, the userspace application will
>> crash by stale TLB entries. Because only using cpumask_clear_cpu without
>> local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
>> Then set_mm_asid would cause the user space application to get a stale
>> value by stale TLB entry, but set_mm_noasid is okay.
>
> ... [snip]
>
>> +	/*
>> +	 * The mm_cpumask indicates which harts' TLBs contain the virtual
>> +	 * address mapping of the mm. Compared to noasid, using asid
>> +	 * can't guarantee that stale TLB entries are invalidated because
>> +	 * the asid mechanism wouldn't flush TLB for every switch_mm for
>> +	 * performance. So when using asid, keep all CPUs footmarks in
>> +	 * cpumask() until mm reset.
>> +	 */
>> +	cpumask_set_cpu(cpu, mm_cpumask(next));
>> +	if (static_branch_unlikely(&use_asid_allocator)) {
>> +		set_mm_asid(next, cpu);
>> +	} else {
>> +		cpumask_clear_cpu(cpu, mm_cpumask(prev));
>> +		set_mm_noasid(next);
>> +	}
>>  }
>
> I observe similar user-space crashes on my SMP systems with enabled ASID.
> My attempt to fix the issue was a bit different, see the following patch:
>
> https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/
>
> In brief, the idea was borrowed from flush_icache_mm handling:
> - keep track of CPUs not running the task
> - perform per-ASID TLB flush on such CPUs only if the task is switched there

That way looks better to me: leaking hartids in the ASID allocator might 
make the crashes go away, but it's just going to end up trending towards 
flushing everything and that doesn't seem like the right long-term 
solution.

So I've got that one on for-next, sorry I missed it before.

Thanks!

>
> Your patch also works fine in my tests fixing those crashes. I have a
> question though, regarding removed cpumask_clear_cpu. How CPUs no more
> running the task are removed from its mm_cpumask ? If they are not
> removed, then flush_tlb_mm/flush_tlb_page will broadcast unnecessary
> TLB flushes to those CPUs when ASID is enabled.
>
> Regards,
> Sergey
