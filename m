Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22273926D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFUWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUWVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:21:35 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199D1735
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:21:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id BBCEF240103
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687386089; bh=2++oFhvzVHoWY9oFuxZxGHn0C2w6fbWftjEc4nzcKoY=;
        h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
         Message-ID:From;
        b=L0wjlGzM512/zbwFYfMWDZuDtsOOJLCG/3/jz8fchlTsqwwyLrWy+NVaEcFwiXySc
         EIvbEZQrfSegmoM131JnXff6N7YdsORADRADtsg5Ua6C1zGcfplX3P7mvKgZKRQnDn
         itc/Fz0k0r2M49fn24g8a2yZjR7lydbyjjYxIY5GSfcQ1Pr303KUg2mcCZP8eoNrpp
         WgqVsGyrIIole2DNAN9GDQfW0taXYEbGLrPchfuMJ2mqDm7VeBbU4wZmmW0csZhNfT
         mNP6b0UB/q57iPcFzxTh0vSGmbw68CyNRtuSJR1sSOIBOPuELlkgqr7xlKuuDw9O4n
         DGP2PkBZUsGug==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmdJS3tpkz6twy;
        Thu, 22 Jun 2023 00:21:28 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 21 Jun 2023 22:21:28 +0000
From:   Anne Macedo <retpolanne@posteo.net>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: xhci: parameterize Renesas delay/retry
In-Reply-To: <03b73c54-5500-0b8b-c45e-b57320cc6bb8@gmail.com>
References: <20230618224656.2476-2-retpolanne@posteo.net>
 <f4b0f337-c530-8c4f-dc22-cfaf834dd5f0@gmail.com>
 <5a057964ae1e26ed934035c183bf2967@posteo.net>
 <03b73c54-5500-0b8b-c45e-b57320cc6bb8@gmail.com>
Message-ID: <97f3c6e0ec70c4284a4ddfb86d6b0592@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.2023 22:20, Christian Lamparter wrote:
> On 6/19/23 12:12, Anne Macedo wrote:
>> On 19.06.2023 10:19, Christian Lamparter wrote:
>>> On 6/19/23 00:46, Anne Macedo wrote:
>>>> Cards based on Renesas uPD720202 have their firmware downloaded=20
>>>> during
>>>> boot by xhci-pci. At this step, the status of the firmware is read=20
>>>> and
>>>> it takes a while for this read to happen (up to a few seconds). The
>>>> macros RENESAS_RETRY and RENESAS_DELAY are used to retry reading=20
>>>> this
>>>> status byte from PCI a few times. If it can't read the status byte=20
>>>> in
>>>> RENESAS_RETRY tries, it times out.
>>>>=20
>>>> However, since this may vary from card to card, these retry and=20
>>>> delay
>>>> values need to be tweaked. In order to avoid having to patch the=20
>>>> code to
>>>> change these values, CONFIG_USB_XHCI_PCI_RENESAS_RETRY and
>>>> CONFIG_USB_XHCI_PCI_RENESAS_DELAY are introduced.
>>>>=20
>>>> If applied, this patch helps to fix errors such as:
>>>>=20
>>>> ROM Download Step 34 failed at position 136 bytes
>>>> Firmware Download Step 2 failed at position 8 bytes with (-110)
>>>>=20
>>>> while loading xhci-pci when using these cards.
>>>>=20
>>>> This error in particular has been noticed by this e-mail [1].
>>>>=20
>>>> [1] https://lore.kernel.org/lkml/20190626070658.GP2962@vkoul-mobl/
>>>=20
>>> Can you tell me on what hardware (is it something older, with maybe
>>> a Synopsys/Designware PCIe host controller?) do you experience these
>>> errors and what delay+retry values are you configuring in order to
>>> get your DUT up an running?
>>=20
>> It's a PH61 Rev 1.2 board with the Renesas uPD720201 host controller.
>> I'm using 10 as the delay and 6000 as the retry.
>=20
> Oh? Is this an old MSI PH61 mainboard or is this an add-in pcie card
> (found something on amazon with that name and rev too)?

It's the add-in pcie card, exactly the one that's available on Amazon.

>=20
> If it's an add-in pcie card, could it be that the EEPROM chip on it
> is (getting) a bit wonky? Or do you have a really fast machine?
> (Latest crop of i7/i9 Alder/Raptor Lake or Ryzen 5000/7000 Series)
>=20

I do have a fast machine, but I believe the EEPROM chip might have gone=20
wonky
for sure. It was the first card I found on my local retailer for adding=20
USB-C
headers to my setup.


>>> From what I can tell, the quoted [1] link to Vinod's mail was just
>>> an update during development. This was v3 of the patch series back
>>> then (and it went on to v10 I think, so this wasn't an issue with
>>> what's in the kernel right now).
>>>=20
>>=20
>> I see. That was the only reference I found to the timeout error I was
>> seeing, so that's why I decided to tweak these retry+delay values.
>>=20
>>> Note: If you are interested I still got the "uPD720201/uPD720202=20
>>> User's
>>> Manual" back then from Renesas site. (Nowadays they want you to
>>> register or something.). This document was the base for the code and
>>> maybe there's something in there you can quote to extend the
>>> retries/delays.
>>=20
>> Definitely interested! I did find a .pdf on Google though, I can check=
=20
>> it.
>=20
> There's also Renesas loader code floating around on github.

ACK - I believe I saw this one as well.

>=20
>>>=20
>>> (From what I vaguely remember. Most of the transfer was fast and
>>> no retries where necessary, but some register write took so long.
>>> Vinod=C2=A0 also posted hints about a newer firmware for the
>>> uPD720201/uPD720202. Have you tried that as well?)
>>=20
>> I was using the upd72020x-fw AUR package on my Arch Linux build,
>> if that's any relevant. However, it's quite old and I don't really=20
>> know
>> how it works. I missed these hints, sorry, could you point me to
>> them?
>=20
> Yes, I was talking about "K2026090.mem". I didn't know this version=20
> existed,
> but Vinod knew about it:
> https://patches.linaro.org/project/linux-arm-msm/patch/20200113084005.849=
071-5-vkoul@kernel.org/
>=20
> Looking on google leads to startech.com and they have/had this as a=20
> product:
> https://www.startech.com/en-de/cards-adapters/pciusb3s22
>=20
> The K2026090.mem Firmware file is in the "[renesas upd72020x] firmware
> update.zip"
> (see in the "RE202.A10" folder).

Will try that!

>=20
> I don't know how it works with pcie cards that are supposed to have the=
=20
> firmware
> stored on the EEPROM chip. In my case of the WNDR4700 - there is no
> extra chip and
> the driver has to upload the firmware - I just have to put the file=20
> renamed as
> renesas_usb_fw.mem into /lib/firmware/ and it works.
>=20

I wrote a bpf program to trace the PCI read/write calls from this=20
specific Renesas
device [1]. On the manual you mentioned, there's a step on the firmware=20
download
where a register is changed when the firmware download finishes. On my=20
bpftrace,
I see that it takes a long while for it to actually change, so I'm not=20
sure what could be
the problem.

I also wrote a patch for my dev environment to allow me to erase the ROM=20
as needed [2], but
it hangs for a long time as well until the timeout is reached.

I *think* that the kernel module erases the ROM at some point when=20
starting up and then polls
if the ROM has been reset.

I've been thinking about Greg's suggestion of setting this timeout=20
dynamically, and I was taking
a look at different ways to deal with waiting and timeouts on kernel=20
modules. Do you think it's
worth it to implement something like a better waiting logic for this=20
module?

I didn't find anything on the card and in the manual that could point me=20
to a way of discovering
how long to set the timeout on it.

[1]=20
https://github.com/retpolanne/kernel-workspace/blob/main/bpf/renesas-pci-tr=
ace.bt
[2]=20
https://github.com/retpolanne/kernel-workspace/blob/main/patches/erase-rom=
=2Epatch
> Regards,
> Christian
