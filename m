Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB5700E72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjELSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbjELSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D9E2121
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:15:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683915306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bHTCVQpH3fQ/pABs8cfWfCOPbU9EAxMD5mHdz0PRX7k=;
        b=MgSUHZiKBZ01lp7Nw5caQNawREnqpM7O8UY+2K0DLYQrdKYmgNCb7IesJ5LJ/eluM4yI2m
        KUKrMEeAGIkWUpSX0kI2EN7Aw8jmwnqHh62ETMY+4FOekSDEbwZA1ywLL+HkMjDWWye7cf
        tRpkTL2SR32Gp4yx2HY84ne+u6+c6WpBLeDxXlW9llqtZa0h+PJCUk4scCHHy8lehibbeF
        iGIiN9pq+pSwZBlLTxBXOa+mw/n4rItb6WKX/IUBurXyptH6y8mc712dIkUWhbrbaJ8K4W
        UZcFYduPlSG2llz7muJRsdXFc0zddX+1g+KTxY8w4NyDo9fO5rBQJJs7i0QVSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683915306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bHTCVQpH3fQ/pABs8cfWfCOPbU9EAxMD5mHdz0PRX7k=;
        b=vRZktW/zjlsNtytjqYotrnMznY++mHT8aj0bo7tbqTyI/iRaUk7uaZ5UexXusYtYdCQyf3
        6HQ8hdusIpfKNGAA==
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
        "Cascon, Pablo" <pablo.cascon@amd.com>
Subject: Re: [PATCH] cdx: add MSI support for CDX bus
In-Reply-To: <182c4d7b-9e91-c00e-43ab-a2c0bd671828@amd.com>
References: <20230508140950.12717-1-nipun.gupta@amd.com>
 <874jom2ash.ffs@tglx>
 <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
 <87bkityxk3.ffs@tglx> <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
 <87ednnes6o.ffs@tglx> <182c4d7b-9e91-c00e-43ab-a2c0bd671828@amd.com>
Date:   Fri, 12 May 2023 20:15:05 +0200
Message-ID: <875y8xbemu.ffs@tglx>
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

On Fri, May 12 2023 at 19:50, Nipun Gupta wrote:
> On 5/11/2023 3:59 AM, Thomas Gleixner wrote:
>> CDX is not any different than PCI. The actual "interrupt chip" is not
>> part of the bus, it's part of the device and pretending that it is a bus
>> specific thing is just running in to the same cul-de-sac sooner than
>> later.
>
> I understand your viewpoint, but would state that CDX bus is somewhat 
> different than PCI in the sense that firmware is a controller for
> all the devices and their configuration. CDX bus controller sends all 
> the write_msi_msg commands to firmware running on RPU over the RPmsg and 
> it is the firmware which interfaces with actual devices to pass this 
> information to devices in a way agreed between firmware and device. The 
> only way to pass MSI information to device is via firmware and CDX bus 
> controller is only entity which can communicate with the firmware for
> this.

Fair enough, but we wouldn't had this dicussion if the above information
would have been part of the changelog. See?

>> IIRC, there is a gap vs. interrupt affinity setting from user space,
>> which is irrelevant for I2C, SPI etc. configured interrupt chips as they
>> raise interrupt via an SoC interrupt pin and that's the entity which
>> does the affinity management w/o requiring I2C/SPI. IIRC I posted a
>> patch snippet to that effect in one of those lengthy PCI/MSI/IMS threads
>> because that is also required for MSI storage which happens to be in
>> queue memory and needs to be synchronized via some command channel. But
>> I can't be bothered to search for it as it's a no-brainer to fix that
>> up.
>
> Thanks for this analysis and pointing the hidden crucial issues with the 
> implementation. These needs to be fixed.
>
> As per your suggestion, we can add Firmware interaction code in the
> irq_bus_sync_xx APIs. Another option is to change the
> cdx_mcdi_rpc_async() API to atomic synchronous API.

I'm not a great fan of that. Depending on how long this update takes the
CPU will busy wait for it to complete with interrupts disabled and locks
held.

> We are evaluating both the solutions and will update the
> implementation accordingly.

Thanks,
 
         tglx
