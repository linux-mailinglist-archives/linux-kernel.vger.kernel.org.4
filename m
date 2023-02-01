Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E497685F52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBAF6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBAF6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA0B298F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675231043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvFgQ42DvoCwUpRNdMIDhG/znNt/mEf1w8gINrnts+c=;
        b=JRZ/GToo7VVWrCvidJgJH5D2Wz63Nd2GlKIL42P/5y/KEN8pMXpMs+D27rGIuyyo+Ez06w
        XEOQB0CApb+oIMOsek6Q81Po2PK0O6KCoZI9CfzClTzDDoYzRU1TbF15915BuDIqopMyAk
        deC8lrNM4JJHcy8oN42qRZIfaig3ptQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-p6_ONdGKNkSsAezBr8wVGA-1; Wed, 01 Feb 2023 00:57:22 -0500
X-MC-Unique: p6_ONdGKNkSsAezBr8wVGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E44D2800159;
        Wed,  1 Feb 2023 05:57:21 +0000 (UTC)
Received: from localhost (ovpn-13-89.pek2.redhat.com [10.72.13.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C14FD53A0;
        Wed,  1 Feb 2023 05:57:20 +0000 (UTC)
Date:   Wed, 1 Feb 2023 13:57:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
 <Y9AXKgJvUuilsWUX@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9AXKgJvUuilsWUX@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/23 at 05:36pm, Catalin Marinas wrote:
> On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region up down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region.
> > 
> > While we observed an unexpected case where a reserved region crosses the
> > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > This looks very strange because we have two low memory regions
> > [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> > why that happened.
> > 
> > Here, for crashkernel=xM,high, search the high memory for the suitable
> > region above the high and low memory boundary. If failed, try reserving
> > the suitable region below the boundary. Like this, the crashkernel high
> > region will only exist in high memory, and crashkernel low region only
> > exists in low memory. The reservation behaviour for crashkernel=,high is
> > clearer and simpler.
> 

Thanks for looking into this. Please see inline comments.

> Well, I guess it depends on how you look at the 'high' option: is it
> permitting to go into high addresses or forcing high addresses only?
> IIUC the x86 implementation has a similar behaviour to the arm64 one, it
> allows allocation across boundary.

Hmm, x86 has no chance to allocate a memory region across 4G boundary
because it reserves many small regions to map firmware, pci bus, etc
near 4G. E.g one x86 system has /proc/iomem as below. I haven't seen a
x86 system which doesn't look like this.

[root@ ~]# cat /proc/iomem 
00000000-00000fff : Reserved
00001000-0009fbff : System RAM
0009fc00-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c93ff : Video ROM
000c9800-000ca5ff : Adapter ROM
000ca800-000ccbff : Adapter ROM
000f0000-000fffff : Reserved
  000f0000-000fffff : System ROM
00100000-bffeffff : System RAM
  73200000-74001b07 : Kernel code
  74200000-74bebfff : Kernel rodata
  74c00000-75167cbf : Kernel data
  758a4000-75ffffff : Kernel bss
  af000000-beffffff : Crash kernel
bfff0000-bfffffff : Reserved
c0000000-febfffff : PCI Bus 0000:00
  fc000000-fdffffff : 0000:00:02.0
    fc000000-fdffffff : cirrus
  feb80000-febbffff : 0000:00:03.0
  febd0000-febd0fff : 0000:00:02.0
    febd0000-febd0fff : cirrus
  febd1000-febd1fff : 0000:00:03.0
  febd2000-febd2fff : 0000:00:04.0
  febd3000-febd3fff : 0000:00:06.0
  febd4000-febd4fff : 0000:00:07.0
  febd5000-febd5fff : 0000:00:08.0
  febd6000-febd6fff : 0000:00:09.0
  febd7000-febd7fff : 0000:00:0a.0
fec00000-fec003ff : IOAPIC 0
fee00000-fee00fff : Local APIC
feffc000-feffffff : Reserved
fffc0000-ffffffff : Reserved
100000000-13fffffff : System RAM

> What x86 seems to do though is that if crash_base of the high allocation
> is below 4G, it gives up on further low allocation. On arm64 we had this
> initially but improved it slightly to check whether the low allocation
> is of sufficient size. In your example above, it is 126MB instead of
> 128MB, hence an explicit low allocation.

Right. From code, x86 tries to allocate crashkernel high reion top down.
If crashkernel high region is above 4G, it reserves 128M for
crashkernel low. If it only allocates region under 4G, no further
action. But arm64 allocates crashkernel high memory top down and could
cross the 4G boudary. This will bring 3 issues:

1) For crashkernel=x,high, it could get crashkernel high region across
4G boudary. Then user will see two memory regions under 4G, and one
memory region above 4G. The two low memory regions are confusing.

2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
and y <= 128M, e.g "crashkernel=256M,high crashkernel=64M,low", when
crashkernel high region crosses 4G boudary and the part below 4G of
crashkernel high reservation is bigger than y, the expected crahskernel
low reservation will be skipped. But the expected crashkernel high
reservation is shrank and could not satisfy user space requirement.

3) The crossing boundary behaviour of crahskernel high reservation is
different than x86 arch. From distros point of view, this brings
inconsistency and confusion. Users need to dig into x86 and arm64
details to find out why.

For upstream kernel dev and maintainers, issue 3) could be a slight
impaction. While issue 1) and 2) cause actual affect. With a small code
change to fix this, we can get simpler, more understandable
crashkernel=,high reservation behaviour.

> 
> Is the only problem that some users get confused? I don't see this as a
> significant issue. However, with your patch, there is a potential
> failure if there isn't sufficient memory to accommodate the request in
> either high or low ranges.

I think we don't need to worry about the potential failure. Before, w/o
crashkernel=,high support, no matter how large the system memory is, you
can only reserve crashkernel memory under 4G. With crashkernel=,high
support, we don't have the limitation. If one system can only satisfy
crashkernel reservation across 4G boudary, I think she/he need consider
to decrease the value of crashkernel=,high and try again. However, the
corssing boundary reservation for crashkernel high region could bring
obscure semantics and behaviour, that is a problem we should fix.

Thanks
Baoquan

