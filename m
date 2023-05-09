Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D426FD1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjEIWBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:01:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F003C01
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:01:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683669661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDyQesVulIAKivK4LjzcECDsXU9nYN7xiYGHX/QgwL8=;
        b=ORf7S7zL2K/FJ9EgSSdB+xfzpv5z8jk73vF8YD4/TRK8xkyp2dxrhbOohCK286TD22odNz
        uB5CJjYMiMMDj4JMhz3vbMuTJUFXxV38UhCcmHtQaFuOZL1/ymWbGDppbJugcYr/DUazeI
        fOsdaomyAPMaic6w0loXqRB3gImf66KIEesJBMtZcRWHgd5Rml9FUroiqTc3H3kciRJenM
        z/UmFlG5Ylr9IOH8LApFO7B4fQYK6XaGsP06UEd1Z+4h9uBqI0GDyYqqGFpsmKR06L6bjB
        5tLCAONJZbmIJFHbRJpkP0vE7jw7l9LA+jr0k72dy1oJ0Pe6Bx7IDWVvzALvgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683669661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDyQesVulIAKivK4LjzcECDsXU9nYN7xiYGHX/QgwL8=;
        b=7R0TT/nhFwzLEBAAMFMfNH1GUjdXcpgZ8HclOJKb2xw2QLV4uL+4FHmOhvi+5R5s/plck8
        9sKwEgIDK09ZDADA==
To:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>
Subject: RE: [PATCH] cdx: add MSI support for CDX bus
In-Reply-To: <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
References: <20230508140950.12717-1-nipun.gupta@amd.com>
 <874jom2ash.ffs@tglx>
 <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
Date:   Wed, 10 May 2023 00:01:00 +0200
Message-ID: <87bkityxk3.ffs@tglx>
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

On Tue, May 09 2023 at 11:06, Nipun Gupta wrote:
>> -----Original Message-----
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Tuesday, May 9, 2023 1:32 PM
>> To: Gupta, Nipun <Nipun.Gupta@amd.com>; gregkh@linuxfoundation.org;
>> maz@kernel.org; jgg@ziepe.ca; linux-kernel@vger.kernel.org

Can you please fix your mail client to not copy half of the mail header
into your reply?

>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.

That's also relevant information for me, right?
 
>> The only real CDX specific functionality here is a CDX specific
>> irq_write_msi_msg() callback, right?
>> 
>> And I gave you a pointer how this should be handled, but instead of
>> helping this effort along you go off and implement it differently just
>> because. Sigh!
>
> As you rightly mentioned the irq_chip has only irq_write_msi_msg() as
> callback, but there is also cdx_msi_prepare() in msi_domain_ops which
> needs to fetch device ID from CDX device, due to which we are currently
> using separate CDX domain.

Sure. But where is that information in the changelog?

> IIUC, as per your suggestion we should have CDX bus token added into 
> its_init_dev_msi_info() of
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/tree/drivers/irqchip/irq-gic-v3-its-msi-parent.c?h=devmsi-arm,
> and register CDX specific 'msi_prepare' here; so that we can use
> msi_create_device_irq_domain() to create a per device domain?

Correct.

I'm not insisting on that, but you could at least have had the courtesy
of responding to my review reply and explain to me why you want to solve
it differently and why my suggestion is not the right solution.

Alternatively you could have added that information in the changelog or
cover letter.

So in summary you ignored _all_ review comments I made, went off and did
something different and provided a slightly different useless changelog
with the extra add on of a broken Signed-off-by chain.

Feel free to ignore my reviews and the documentation which we put out
there to make collaboration feasible for both sides, but please don't be
upset when I ignore you and your patches in return.

Thanks,

        tglx


