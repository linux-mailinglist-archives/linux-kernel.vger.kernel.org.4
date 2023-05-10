Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC106FE831
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjEJXwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJXwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:52:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE3930CB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:52:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683762749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uaKrKcom2BFXuduCtXHjmPL2zo+W2OJy2ayP/8xBNV8=;
        b=XBfHxqn/hLdvoVjp6SThnbKPPOUC4JXB/+7PSNHC0ccdieoa4P5nucsg63QeexNswbq07I
        30yQpVQC1jEmcg5VIRmhLpsauzhWKf+cizwLmXgj4f4sWiuJca0KpEVGbjDUalmNg+2GzY
        u0ZyAhVLHD2A590YwLHYunLQpfpJUfXecLNOvMR5Lw7SBF4ZpeztGr9QDDQHmvtyCkwcQm
        XTXpAkJeFEHMY4JQQ7ol2V8t6Lr4UWY7g1/5Kb0weYgRhhDt5XvwyCR+UfSTo5wrLnhyje
        +V/y8h0LHK4CeD5ZxRdlDR+nd01UMwk7RwrveUio4wnmOD6lKievc0fQW1H1mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683762749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uaKrKcom2BFXuduCtXHjmPL2zo+W2OJy2ayP/8xBNV8=;
        b=pBq2XPTbqdTYY0w4zaegRDbWep+egrwxn2M41WKRU4XqWV1alaSYaygKx9N2l0WFYbBpVg
        DqfKOwtSrLMNaKBQ==
To:     Nipun Gupta <nipun.gupta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] cdx: add MSI support for CDX bus
In-Reply-To: <87ednnes6o.ffs@tglx>
References: <20230508140950.12717-1-nipun.gupta@amd.com>
 <874jom2ash.ffs@tglx>
 <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
 <87bkityxk3.ffs@tglx> <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
 <87ednnes6o.ffs@tglx>
Date:   Thu, 11 May 2023 01:52:28 +0200
Message-ID: <878rdveocj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nipun!

On Thu, May 11 2023 at 00:29, Thomas Gleixner wrote:
> On Wed, May 10 2023 at 19:34, Nipun Gupta wrote:
> #2) That's actually the worse part of it and completely broken versus
>     device setup
>
>     probe()
>       cdx_msi_domain_alloc_irqs()
>       ...
>       request_irq() {
>         ...
>         irq_activate()
>           irq_chip_write_msi_msg()
>             ...
>             queue_work()
>           ...
>       }
>
>       enable_irq_in_device()
>       
>         <- device raises interrupt and eventually uses an uninitialized
>            MSI message because the scheduled work has not yet completed.
>
>     That's going to be a nightmare to debug and it's going to happen
>     once in a blue moon out in the field.

Here is another failure scenario:

cpu_down()
  // No scheduling possible as this happens in stomp_machine() context
  __cpu_disable()
    // Point of no return
    set_cpu_online(cpu, false);
    irq_migrate_all_off_this_cpu()
      ...
      set_affinity()

That works with your current implementation by some definition of works
because you schedule the affinity change async.

But what makes sure that this takes effect _before_ the CPU goes into
lala land and cannot respond to an interrupt anymore?

Nothing, other than pure luck, which is not really a solid engineering
principle.

While the regular operations can be fixed via the bus_lock mechanics,
this one falls flat on its nose because in that context this can't
schedule anymore so acquiring a mutex or waiting for some async muck to
complete is a no-no.

Not the end of the world though. There is a way to handle that
gracefully and we need that for the PCI/IMS implementations which will
do that via command queues too.

irq_migrate_all_off_this_cpu() is invoked from stomp_machine() context
with interrupts disabled because the current x86 interrupt management
hardware trainwreck requires it at least in the case that interrupt
remapping is not available.

Of course that got copied to all other architectures... Whether they
really require it or not from a hardware POV is a different
story. Though they all rely on the stomp_machine() context which
prevents concurrent modifications.

So from a historical POV all of this makes sense to some extent, but
that does not prevent us to fix this and make it an two stage process
which can actually handle both worlds.

I'm way too tired to think that through, but you get the idea and you
are welcome to beat me to it.

Thanks,

        tglx
