Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A201370A84E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjETNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjETNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9CB0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684588764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTn8gTlrwHnM2AKAy5qI/9dWkXoUP9wXNayQrQJHG40=;
        b=GIK+EGQjJbe58mNB7cjqx22fzSiyOsgfRgL8zYNKWQB+tGr2t1B2A5MrfhFzrB1lMVv5wb
        9dCYIruujHXNQR+6VRUT7BAo/Ha1FymACcHvRQk6oFz0FG0xgJMj9pskkkuGoYldJuhX7b
        4DO4LRQ91FmoCdQ5pTpHlzMa3tj7lp4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-R6-VQ7OUNkChkXTGHWJMQw-1; Sat, 20 May 2023 09:19:19 -0400
X-MC-Unique: R6-VQ7OUNkChkXTGHWJMQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD0013C02535;
        Sat, 20 May 2023 13:19:18 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 935C74F2DE4;
        Sat, 20 May 2023 13:19:17 +0000 (UTC)
Date:   Sat, 20 May 2023 21:19:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org
Subject: Re: [PATCH -next v4 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZGjI0kDmtnxKY3NP@MiWiFi-R3L-srv>
References: <20230410130553.3226347-1-chenjiahao16@huawei.com>
 <20230410130553.3226347-2-chenjiahao16@huawei.com>
 <ZEnaPzx3O9NWixIR@MiWiFi-R3L-srv>
 <366da9fb-0a3c-ac62-3df3-7a7f328973a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366da9fb-0a3c-ac62-3df3-7a7f328973a6@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/23 at 04:47pm, chenjiahao (C) wrote:
......
> > > @@ -1163,8 +1185,12 @@ static void __init reserve_crashkernel(void)
> > >   {
> > >   	unsigned long long crash_base = 0;
> > >   	unsigned long long crash_size = 0;
> > > +	unsigned long long crash_low_size = 0;
> > >   	unsigned long search_start = memblock_start_of_DRAM();
> > >   	unsigned long search_end = memblock_end_of_DRAM();
> > > +	unsigned long search_low_max = (unsigned long)dma32_phys_limit;
> > > +	char *cmdline = boot_command_line;
> > > +	bool fixed_base = false;
> > >   	int ret = 0;
> > > @@ -1180,14 +1206,34 @@ static void __init reserve_crashkernel(void)
> > >   		return;
> > >   	}
> > > -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > > +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> > >   				&crash_size, &crash_base);
> > > -	if (ret || !crash_size)
> > > +	if (ret == -ENOENT) {
> > > +		/* Fallback to crashkernel=X,[high,low] */
> > > +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> > > +		if (ret || !crash_size)
> > > +			return;
> > > +
> > > +		/*
> > > +		 * crashkernel=Y,low is valid only when crashkernel=X,high
> > > +		 * is passed.
> > > +		 */
> > > +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> > > +		if (ret == -ENOENT)
> > > +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > > +		else if (ret)
> > > +			return;
> > > +
> > > +		search_start = search_low_max;
> > > +	} else if (ret || !crash_size) {
> > > +		/* Invalid argument value specified */
> > >   		return;
> > > +	}
> > >   	crash_size = PAGE_ALIGN(crash_size);
> > >   	if (crash_base) {
> > > +		fixed_base = true;
> > >   		search_start = crash_base;
> > >   		search_end = crash_base + crash_size;
> > >   	}
> > > @@ -1201,16 +1247,31 @@ static void __init reserve_crashkernel(void)
> > >   	 */
> > >   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> > >   					       search_start,
> > > -					       min(search_end, (unsigned long) SZ_4G));
> > > +					       min(search_end, search_low_max));
> > Here, it seems not right in case crashkernel=,high is specified. In that
> > case, search_start == search_low_max, then the min(search_end,
> > search_low_max) will get search_low_max too. Then you make the fallback
> > in below code block to try to get crashkernel reservation above 4G. This
> > doesn't comply with the crashkernel=,high grammer which has been
> > implemented in other architectures.
> > 
> > For crashkernel=,high, user explicitly require memory reservation above
> > 4G. Why does crashkernel=,high is needed? E.g on big end server with
> > huge memory, while the low memory under 4G is limited and precious.
> > Hence, user want to put the main crashkernel reservation above 4G to
> > contain kdump kernel/initrd and run user space program, while with few
> > low memory for pci device driver. E.g crashkernel=2G,high, it won't
> > impact much if there's huge memory above 4G and get crashkernel
> > reservation there. However, it impacts a lot if it reserves memory
> > below 4G.
> > 
> > I would strongly suggest that risc-v also reserve memory from above 4G
> > for crashkernel=,high, then fallback to below 4G. That's consistent with
> > crashkernel=,high grammer.
> 
> Sorry for late response.
> 
> I have got the point here. So with the original implication of "crashkernel=,high",
> there is even no need to try reserving low memory under 4G. I have arranged another
> version of patchset, in which I updated the allocation logic in that case.
> 
> For example, when "crashkernel=1G,high" is specified, the previous logic is like:
> alloc range: crash_size: 0x40000000 (1G), crash_base: 4G_limit,
>              crash_max: 4G_limit
> alloc range high: crash_size: 0x40000000 (1G), crash_base: 4G_limit,
>                   crash_max: memblock_range_end
> alloc range low: low_size: 0x8000000 (128MB,default), crash_base: 0x0,
>                  crash_max: 4G_limit
> 
> After revision, the logic is like:
> alloc range: crash_size: 0x40000000 (1G), crash_base: memblock_range_start,
>              crash_max: memblock_range_end
> alloc range low: low_size: 0x8000000 (128MB,default), crash_base: 0x0,
>                  crash_max: 4G_limit
> 
> Please let me know if there is any problem exist.

Sorry for late reply.

Hmm, it doesn't seem completely correct. I will comment in your v5
patch. Please see over there.

