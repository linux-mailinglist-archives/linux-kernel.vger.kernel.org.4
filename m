Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6F607CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJUQvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiJUQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:51:13 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E42892FF;
        Fri, 21 Oct 2022 09:51:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5B7D25C154A;
        Fri, 21 Oct 2022 16:42:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a201 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A4C355C0D94;
        Fri, 21 Oct 2022 16:42:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666370539; a=rsa-sha256;
        cv=none;
        b=UE6llF/Nvv35jSXJEi7IvlfDkVYFb+0IfOJ3O83ZXAiiyRd9FNLQhuuv0yh77yg+2N8xv4
        0hCfH9yaiiUayFBiyww++bLscz0/GduthzSCpgMN5qHClqKpVe+Ix2yG3U/IdAgA3BzMd8
        i1phYNFC4Q4xuWh3XIq96m3kHfqWt+CRliK7IRmZx1UP0/7mKLtqCz67QEFK2Y/tTw0yZe
        Xv8Gy17cT8ubxkf1VHjL7GPfplyF7ZlHarl6pt9ComBU2jqAsot1hXGSPIpTKEs6s7m0Iu
        mE3PY/lo8VKZVhRg4pJsor6nEUsJY7oiVGFQZ7WFkMPsy0bPQiie+PHk504wyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666370539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4OwkcN5POLEwtg8auuKqNVlwWE+94+S6v3JaLCq+AJc=;
        b=tLoYGLcVkzqdm7NWfRQcODRYeDUrffqGr2SRp0tHPCF7Kqvf2MWrsq3iJk3gjOjh/shIIa
        VpdF5ktAVyElscM67U6T4s64nNRcmx0ELfYU1ovnANmhxjm/jOsSq0qMIBuC/Zn1OyJLoK
        0l9N0/IJ8S1Vzr/sxX4m8IyK7m+ScfDcz9Jki5VcwVSO7OF5SyFlN5SGodLCMZPvVUXjfv
        Pbg+IobHvROPGwnPNI13MDQrKUnTRLWcT1ifKt3jA0lucR0YEWEHROEWoj59H6h6J/N1w8
        ppV4sJzJ2nQZJ6bFR/5NJUq7VRR20/3mAT9Fc0ml091PcKx4QTaKbl8Nk7C98A==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-vkcdq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Bottle: 36a6e867549300e2_1666370540027_107651071
X-MC-Loop-Signature: 1666370540027:353579783
X-MC-Ingress-Time: 1666370540026
Received: from pdx1-sub0-mail-a201 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.77.227 (trex/6.7.1);
        Fri, 21 Oct 2022 16:42:20 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a201 (Postfix) with ESMTPSA id 4Mv9HG40wyz2d;
        Fri, 21 Oct 2022 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666370539;
        bh=4OwkcN5POLEwtg8auuKqNVlwWE+94+S6v3JaLCq+AJc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=AoUDkEQ/xfajJlhlQoP0eD/WZ0KA0RYPif0k+H9kxESARaCTexsiOkktwD2mAPeKP
         Eu+HVY8PmPqqnIbqnu/DKFkAkQLfBW2SNQ6wIzeZxRRPNkOXjCQgSBSqjUJoXvX7jH
         wNe/mB5BBKC3XoQ89wkVWBLmBbFWcCsgK0796Jp1WjESWNLh3d4CERN34t6Y45mQfV
         uUuo0NqyFMzZ/exgsZvF6mZUkHscmvQPfWmUscqCPi2FpANBZzOvgnL6GPYiKnDCl3
         ghCcKOYLYh9EcstV9R7Bvy4hvKgR2o/7IJkigybj/a17ig8PrrUwpU1YB0y1atqsYd
         bnnHT7c6OpFbA==
Date:   Fri, 21 Oct 2022 09:20:55 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221021162055.nuxvfdrfhv42nlim@offworld>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <20221018103619.00004c39@huawei.com>
 <20221018115227.00002a4c@huawei.com>
 <20221020223125.hyrfpt2noiicisxa@offworld>
 <Y1Idsv0Nuu+V9aMj@iweiny-desk3>
 <20221021094931.0000795f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221021094931.0000795f@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, Jonathan Cameron wrote:

>On Thu, 20 Oct 2022 21:18:58 -0700
>Ira Weiny <ira.weiny@intel.com> wrote:
>
>> On Thu, Oct 20, 2022 at 03:31:25PM -0700, Davidlohr Bueso wrote:
>> > On Tue, 18 Oct 2022, Jonathan Cameron wrote:
>> >
>> > > Reality is that it is cleaner to more or less ignore the infrastructure
>> > > proposed in this patch.
>> > >
>> > > 1. Query how many CPMU devices there are. Whilst there stash the maximim
>> > >   cpmu vector number in the cxlds.
>> > > 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
>> > > 3. Carry on as before.
>> > >
>> > > Thus destroying the point of this infrastructure for that usecase at least
>> > > and leaving an extra bit of state in the cxl_dev_state that is just
>> > > to squirt a value into the callback...
>> >
>> > If it doesn't fit, then it doesn't fit.
>> >
>> > However, while I was expecting pass one to be in the callback, I wasn't
>> > expecting that both pass 1 and 2 shared the cpmu_regs_array. If the array
>> > could be reconstructed during pass 2, then it would fit a bit better;
>> > albeit the extra allocation, cycles etc., but this is probing phase, so
>> > overhead isn't that important (and cpmu_count isn't big enough to matter).
>
>I thought about that approach, but it's really ugly to have to do
>
>1) For the IRQ number gathering.
>  a) Parse 1 to count CPMUs
>  b) Parse 2 to get the register maps - grab the irq numbers and unmap them again
>2) For the CPMU registration
>  a) Parse 3 to count CPMUs (we could stash the number of CPMUS form 1a) but
>     that's no advantage over stashing the max irq in current proposal.
>     Both are putting state where it's not relevant or wanted just to make it
>     available in a callback.  This way is even worse because it's getting
>     stashed as a side effect of a parse in a function doing something different.
>  b) Parse 4 to get the register maps and actually create the devices. Could have
>     stashed this earlier as well, but same 'side effects' argument applies.
>
>Sure, can move to this however with appropriate comments on why we are playing
>these games because otherwise I suspect a future 'cleanup' would remove double, double
>pass.
>
>To allow for an irq registration wrapper that turns a series of straight
>line calls into callbacks in an array.  The straight line calls aren't exactly
>complex in the first place.
>//find cpmu filling in cxl_cpmu_reg_maps.
>
>max_irq = -1
>rc = cxl_mailbox_get_irq()
>if (rc < 0)
>	return rc;
>max_irq = max(max_irq, rc);
>
>rc = cxl_events_get_irq()
>if (rc < 0)
>	return rc;
>max_irq = max(max_irq, rc);
>
>rc = cxl_cpmus_get_irq(cxl_cpmu_reg_maps);
>if (rc < 0)
>	return rc;
>max_irq = max(max_irq, rC);
>
>...
>
>if (irq > 0) {
>
>	pci_get...
>}
>
>//create all the devices...

Yes, this was sort of what I pictured if we go this way. It doesn't make
my eyes sore.

>
>> >
>> > But if we're going to go with a free-for-all approach, can we establish
>> > who goes for the initial pci_alloc_irq_vectors()? I think perhaps mbox
>> > since it's the most straightforward and with least requirements, I'm
>> > also unsure of the status yet to merge events and pmu, but regardless
>> > they are still larger patchsets. If folks agree I can send a new mbox-only
>> > patch.
>>
>> I think there needs to be some mechanism for all of the sub-device-functions to
>> report their max required vectors.
>>
>> I don't think that the mbox code is necessarily the code which should need to
>> know about all those other sub-device-thingys.  But it could certainly take
>> some 'max vectors' value that probe passed to it.
>>
>> I'm still not sure how dropping this infrastructure makes Jonathan's code
>> cleaner.  I still think there will need to be 2 passes over the number of
>> CPMU's.
>>
>
>Primarily that there is no need to stash anything about the CPMUs in the
>cxl_device_state (option 1) or repeat all the counting and discovery logic twice
>(option 2).
>
>I can live with it (it's what we have to do in pcie port for the equivalent)
>but the wrapped up version feels like a false optimization.
>
>Saves a few lines of code and adds a bunch of complexity elsewhere that looks to
>me to outweigh that saving.

Yeah it's hard to justify the extra complexity here when the alternative isn't
even that bad.

Thanks,
Davidlohr
