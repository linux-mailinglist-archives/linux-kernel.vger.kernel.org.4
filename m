Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0ED6A8EFF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCCBzM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 20:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCCByo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:54:44 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17401041D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:53:26 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0530F24E3BC;
        Fri,  3 Mar 2023 09:53:20 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 09:53:20 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 09:53:19 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 3 Mar 2023 09:53:19 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZRZ0zqkG7/pRhhEiAX6gFjug0Aa7cUgAAgAEC65D///aKAIAAiLXg//+GvACAAI+BwP//lVOAAJFkcXD//+axAP//cjXQgADMoID//pX2AIACjLaA//93Q9AAFcQCgP//eFGw//9zGYD/+hI3MA==
Date:   Fri, 3 Mar 2023 01:53:19 +0000
Message-ID: <94325d78a0b74d8289b77ec743840941@EXMBX066.cuchost.com>
References: <20230224120715.wgqnqmkadsbqusus@orel>
 <180fda36f9974809b436c52e4b3eda58@EXMBX066.cuchost.com>
 <20230227075942.rgl4hqnwttwvoroe@orel>
 <178ca008701147828d2e62402ff4f78a@EXMBX066.cuchost.com>
 <20230227114435.eow57ax5zhysz3kv@orel>
 <a6c319dd867f4f1d97e9d950b9e7c636@EXMBX066.cuchost.com>
 <20230228050457.zfbflfawctaccepv@orel>
 <803ac603023c4eeda4a0b8e414cce6f1@EXMBX066.cuchost.com>
 <20230228071845.k6s6bcnesdsnw3jl@orel>
 <abd16b950ca744b081fc9f545977b8fa@EXMBX066.cuchost.com>
 <20230228073725.m5t6rkcbgbi3g26z@orel>
In-Reply-To: <20230228073725.m5t6rkcbgbi3g26z@orel>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.50.196.81]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,


> -----Original Message-----
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Tuesday, February 28, 2023 3:37 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> On Tue, Feb 28, 2023 at 07:29:40AM +0000, JeeHeng Sia wrote:
> >
> >
> > > -----Original Message-----
> > > From: Andrew Jones <ajones@ventanamicro.com>
> > > Sent: Tuesday, 28 February, 2023 3:19 PM
> > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > >
> > > On Tue, Feb 28, 2023 at 05:33:32AM +0000, JeeHeng Sia wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Andrew Jones <ajones@ventanamicro.com>
> > > > > Sent: Tuesday, 28 February, 2023 1:05 PM
> > > > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > > > > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > > > > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > > > >
> > > > > On Tue, Feb 28, 2023 at 01:32:53AM +0000, JeeHeng Sia wrote:
> > > > > > > > > > 	load image;
> > > > > > > > > > loop:	Create pbe chain, return error if failed;
> > > > > > > > >
> > > > > > > > > This loop pseudocode is incomplete. It's
> > > > > > > > >
> > > > > > > > > loop:
> > > > > > > > >         if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
> > > > > > > > > 	   return page_address(page);
> > > > > > > > > 	Create pbe chain, return error if failed;
> > > > > > > > > 	...
> > > > > > > > >
> > > > > > > > > which I pointed out explicitly in my last reply. Also, as I asked in my
> > > > > > > > > last reply (and have been asking four times now, albeit less explicitly
> > > > > > > > > the first two times), how do we know at least one PBE will be linked?
> > > > > > > > 1 PBE correspond to 1 page, you shouldn't expect only 1 page is saved.
> > > > > > >
> > > > > > > I know PBEs correspond to pages. *Why* should I not expect only one page
> > > > > > > is saved? Or, more importantly, why should I expect more than zero pages
> > > > > > > are saved?
> > > > > > >
> > > > > > > Convincing answers might be because we *always* put the restore code in
> > > > > > > pages which get added to the PBE list or that the original page tables
> > > > > > > *always* get put in pages which get added to the PBE list. It's not very
> > > > > > > convincing to simply *assume* that at least one random page will always
> > > > > > > meet the PBE list criteria.
> > > > > > >
> > > > > > > > Hibernation core will do the calculation. If the PBEs (restore_pblist) linked successfully, the hibernated image will be
> restore
> > > else
> > > > > > > normal boot will take place.
> > > > > > > > > Or, even more specifically this time, where is the proof that for each
> > > > > > > > > hibernation resume, there exists some page such that
> > > > > > > > > !swsusp_page_is_forbidden(page) or !swsusp_page_is_free(page) is true?
> > > > > > > > forbidden_pages and free_pages are not contributed to the restore_pblist (as you already aware from the code). Infact,
> the
> > > > > > > forbidden_pages and free_pages are not save into the disk.
> > > > > > >
> > > > > > > Exactly, so those pages are *not* going to contribute to the greater than
> > > > > > > zero pages. What I've been asking for, from the beginning, is to know
> > > > > > > which page(s) are known to *always* contribute to the list. Or, IOW, how
> > > > > > > do you know the PBE list isn't empty, a.k.a restore_pblist isn't NULL?
> > > > > > Well, this is keep going around in a circle, thought the answer is in the hibernation code. restore_pblist get the pointer from
> the
> > > PBE,
> > > > > and the PBE already checked for validity.
> > > > >
> > > > > It keeps going around in circles because you keep avoiding my question by
> > > > > pointing out trivial linked list code. I'm not worried about the linked
> > > > > list code being correct. My concern is that you're using a linked list
> > > > > with an assumption that it is not empty. My question has been all along,
> > > > > how do you know it's not empty?
> > > > >
> > > > > I'll change the way I ask this time. Please take a look at your PBE list
> > > > > and let me know if there are PBEs on it that must be there on each
> > > > > hibernation resume, e.g. the resume code page is there or whatever.
> > > > >
> > > > > > Can I suggest you to submit a patch to the hibernation core?
> > > > >
> > > > > Why? What's wrong with it?
> > > > Kindly let me draw 2 scenarios for you. Option 1 is to add the restore_pblist checking to the hibernation core and option 2 is to
> add
> > > restore_pblist checking to the arch solution
> > > > Although I really don't think it is needed. But if you really wanted to add the checking, I would suggest to go with option 1. again,
> I
> > > really think that it is not needed!
> > >
> > > This entire email thread is because you've first coded, and now stated,
> > > that you don't think the PBE list will ever be empty. And now, below, I
> > > see you're proposing to return an error when the PBE list is empty, why?
> > > If there's nothing in the PBE list, then there's nothing to do for it.
> > > Why is that an error condition?
> > >
> > > Please explain to me why you think the PBE list *must* not be empty
> > > (which is what I've been asking for over and over). OIOW, are there
> > > any pages you have in mind which the resume kernel always uses and
> > > are also always going to end up in the suspend image? I don't know,
> > > but I assume clean, file-backed pages do not get added to the suspend
> > > image, which would rule out most kernel code pages. Also, many pages
> > > written during boot (which is where the resume kernel is at resume time)
> > > were no longer resident at hibernate time, so they won't be in the
> > > suspend image either. While it's quite likely I'm missing something
> > > obvious, I'd rather be told what that is than to assume the PBE list
> > > will never be empty. Which is why I keep asking about it...
> > The answer already in the Linux kernel hibernation core, do you need me to write a white paper to explain in detail or you need a
> conference call?
> 
> I'm not sure why you don't just write a paragraph or two here in this
> email thread explaining what "the answer" is. Anyway, feel free to
> invite me to a call if you think it'd be easier to hash out that way.
Thank you very much to free up time to join the call. It was very nice to talk to you over the conference call and I did learn a lot from you.
Below is the summary of the experiment that benefit everyone:
To avoid inspecting a huge log, the experiment was carried out on the Qemu with 512MB of memory (128000 pages). 
During hibernation, there are 22770 pages (out of 128000 pages) were identified need to be stored to the disk. Those pages consists of the kernel text code, rodata, page table, stack/heap/kmalloc/vmalloc memory, user space app, rootfs.....etc. The number of pages need to be stored to the disk are depends on the "workload" on the system.
When resume, only 21651 pages were assigned to the restore_pblist. The rest of the pages consists of meta_data pages and forbidden pages which were handled by the "resume kernel". Arch code will handle the pages assigned to the restore_pblist.
From the experiment, we also know that the game that is activated before hibernation is still "alive" after resume from hibernation and can continue to play without problem.

Thanks
Jee Heng
