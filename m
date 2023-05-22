Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A170B6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjEVHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:41:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD87B0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:41:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPqBp6vY8z4x3x;
        Mon, 22 May 2023 17:41:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684741285;
        bh=GjeGaNzNWtwtfRRm1b1ouqteUst+s4Mvd+JyTpGYURs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ixl/y+Ivja1fcLNUxy/lob16vq86tLXx0GIPO2v0yYNq4iaCAVKKvW7aKt7BiieRZ
         cBckiQigthAWzA6b6/NDSyKC4Ty1hot//ArRd67kQI+oSs1wBBKwauQpq75+O3yZdc
         wPt2HLltRqGodtPEn3ad1ISq/zzB8BR5EHYfEiqHVbeDl78U+s6yAuDMezrJZk/Gmo
         Uo5wT2q2V/Tp1LsqYsHRbpEG0wl29mi4PP8oRdRwa9Xc7seSvJyGwWOdfkaNmq6c44
         izok3ZuCpZYbzJY/JlZ4d8KV9fQzTa9znBp7zAa5FWF+NeWhWUvrZo+XTSUmMXaUlZ
         Y75TX8jmE0vBg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sachinp@linux.vnet.ibm.com,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Gaurav Batra <gbatra@linux.vnet.ibm.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Probing nvme disks fails on Upstream kernels on powerpc Maxconfig
In-Reply-To: <20230522072412.GA3902@linux.vnet.ibm.com>
References: <20230323095333.GI1005120@linux.vnet.ibm.com>
 <906d4d0e-b487-00a5-9399-7d1edc5e20a4@leemhuis.info>
 <87bkk2khl0.fsf@mpe.ellerman.id.au>
 <2a80cb20-0c9f-2d0c-e951-c4f005f3e4b3@ozlabs.ru>
 <20230522072412.GA3902@linux.vnet.ibm.com>
Date:   Mon, 22 May 2023 17:41:22 +1000
Message-ID: <87edn8ak4d.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Alexey Kardashevskiy <aik@ozlabs.ru> [2023-04-13 22:09:22]:
>
>> > > On 23.03.23 10:53, Srikar Dronamraju wrote:
>> > > > 
>> > > > I am unable to boot upstream kernels from v5.16 to the latest upstream
>> > > > kernel on a maxconfig system. (Machine config details given below)
>> > > > 
>> > > > At boot, we see a series of messages like the below.
>> > > > 
>> > > > dracut-initqueue[13917]: Warning: dracut-initqueue: timeout, still waiting for following initqueue hooks:
>> > > > dracut-initqueue[13917]: Warning: /lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2f93dc0767-18aa-467f-afa7-5b4e9c13108a.sh: "if ! grep -q After=remote-fs-pre.target /run/systemd/generator/systemd-cryptsetup@*.service 2>/dev/null; then
>> > > > dracut-initqueue[13917]:     [ -e "/dev/disk/by-uuid/93dc0767-18aa-467f-afa7-5b4e9c13108a" ]
>> > > > dracut-initqueue[13917]: fi"
>> > > 
>> > > Alexey, did you look into this? This is apparently caused by a commit of
>> > > yours (see quoted part below) that Michael applied. Looks like it fell
>> > > through the cracks from here, but maybe I'm missing something.
>> > 
>> > Unfortunately Alexey is not working at IBM any more, so he won't have
>> > access to any hardware to debug/test this.
>> > 
>> > Srikar are you debugging this? If not we'll have to find someone else to
>> > look at it.
>> 
>> Has this been fixed and I missed cc:? Anyway, without the full log, I still
>> see it is a huge guest so chances are the guest could not map all RAM so
>> instead it uses the biggest possible DDW with 2M pages. If that's the case,
>> this might help it:
>> 
>
> Hi Alexey, Michael
>
> Sorry for the late reply, but I didnt have access to this large system.
> This weekend, I did get access and tested with the patch. However it didn't
> help much, system is still stuck at dracut with similar message except the
> trace.
>
> However this patch
> https://lore.kernel.org/all/20230418204401.13168-1-gbatra@linux.vnet.ibm.com/
> from Gaurav Batra does solve this issue.

Thanks.

There was a v3 of that patch:
  https://lore.kernel.org/all/20230504175913.83844-1-gbatra@linux.vnet.ibm.com/

Which is merged now into mainline as:
  096339ab84f3 ("powerpc/iommu: DMA address offset is incorrectly calculated with 2MB TCEs")

Presumably it also fixes the bug for you, so I'll mark this as fixed,
but if you can test that exact commit that would be good to confirm the
bug is fixed in mainline.

cheers


#regzbot fixed-by: 096339ab84f3 
