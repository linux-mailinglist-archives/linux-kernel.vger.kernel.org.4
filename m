Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7FB7351B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjFSKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjFSKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:12:40 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06551AC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:12:38 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 63D0D240105
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687169557; bh=hlz9xdgXTaNM8Hwr4aFQnKwEdtuMsiWJWknoXRW3xfI=;
        h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
         Message-ID:From;
        b=K7GunXmX6bLemJB2At2rnphb+JSI67iR1tHJg2kW+HHMAOU4NWog0/dyEMRkMj4JR
         XlOuttvBoBMrRw2/dCfBBjiGlh2NB8KgcPdBkh+/UghilUoRp+n7ubvSssZ4HLBL49
         svYFKUi0X+3kEbKFAzWY20iFDnsfkmrh00Z0vHhh5/gCxWQY/6dt0Wk6Z0WLgfGBjR
         8csQ6ohnm3eSsEM1fUcVkwfk74D6KMsT4NN+Et4OQ6y65Ew1tg0G1DcVJJzOuk98FX
         YHdHaI4w8iQ2VrgrZLBHByj8jrbmVgDvffmaHuKIkcB9e2aVjERZaWBcay0ARnIshW
         lH61JjQoFO5OQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Ql5DN3F21z6tx8;
        Mon, 19 Jun 2023 12:12:36 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Jun 2023 10:12:36 +0000
From:   Anne Macedo <retpolanne@posteo.net>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: xhci: parameterize Renesas delay/retry
In-Reply-To: <f4b0f337-c530-8c4f-dc22-cfaf834dd5f0@gmail.com>
References: <20230618224656.2476-2-retpolanne@posteo.net>
 <f4b0f337-c530-8c4f-dc22-cfaf834dd5f0@gmail.com>
Message-ID: <5a057964ae1e26ed934035c183bf2967@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2023 10:19, Christian Lamparter wrote:
> On 6/19/23 00:46, Anne Macedo wrote:
>> Cards based on Renesas uPD720202 have their firmware downloaded during
>> boot by xhci-pci. At this step, the status of the firmware is read and
>> it takes a while for this read to happen (up to a few seconds). The
>> macros RENESAS_RETRY and RENESAS_DELAY are used to retry reading this
>> status byte from PCI a few times. If it can't read the status byte in
>> RENESAS_RETRY tries, it times out.
>> 
>> However, since this may vary from card to card, these retry and delay
>> values need to be tweaked. In order to avoid having to patch the code 
>> to
>> change these values, CONFIG_USB_XHCI_PCI_RENESAS_RETRY and
>> CONFIG_USB_XHCI_PCI_RENESAS_DELAY are introduced.
>> 
>> If applied, this patch helps to fix errors such as:
>> 
>> ROM Download Step 34 failed at position 136 bytes
>> Firmware Download Step 2 failed at position 8 bytes with (-110)
>> 
>> while loading xhci-pci when using these cards.
>> 
>> This error in particular has been noticed by this e-mail [1].
>> 
>> [1] https://lore.kernel.org/lkml/20190626070658.GP2962@vkoul-mobl/
> 
> Can you tell me on what hardware (is it something older, with maybe
> a Synopsys/Designware PCIe host controller?) do you experience these
> errors and what delay+retry values are you configuring in order to
> get your DUT up an running?

It's a PH61 Rev 1.2 board with the Renesas uPD720201 host controller.
I'm using 10 as the delay and 6000 as the retry.
> 
> From what I can tell, the quoted [1] link to Vinod's mail was just
> an update during development. This was v3 of the patch series back
> then (and it went on to v10 I think, so this wasn't an issue with
> what's in the kernel right now).
> 

I see. That was the only reference I found to the timeout error I was
seeing, so that's why I decided to tweak these retry+delay values.

> Note: If you are interested I still got the "uPD720201/uPD720202 User's
> Manual" back then from Renesas site. (Nowadays they want you to
> register or something.). This document was the base for the code and
> maybe there's something in there you can quote to extend the
> retries/delays.

Definitely interested! I did find a .pdf on Google though, I can check 
it.

> 
> (From what I vaguely remember. Most of the transfer was fast and
> no retries where necessary, but some register write took so long.
> Vinod  also posted hints about a newer firmware for the
> uPD720201/uPD720202. Have you tried that as well?)

I was using the upd72020x-fw AUR package on my Arch Linux build,
if that's any relevant. However, it's quite old and I don't really know
how it works. I missed these hints, sorry, could you point me to
them?
> 
> Regards,
> Christian

