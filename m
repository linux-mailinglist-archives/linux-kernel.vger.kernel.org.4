Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B261403A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJaV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaV61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:58:27 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA39FF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:58:22 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 11469 invoked from network); 31 Oct 2022 22:58:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1667253498; bh=1KcDlAJydwsD6iBxe2zLcIj/QaQqPMYu3avBARGdTDE=;
          h=Subject:To:Cc:From;
          b=ml+ldyWhxTB2iNZmeR7Iq+R1NcEIQUPpwnz+1HnyqjMfs/X2Ek9XzC4h8F/779xg4
           c1qr9v/HpclUStvbjDTCY9RHj+cLy0CxloIEofcx5pRZGwOjadqs2szgK56x3/h4+j
           ugI2dv/C2PkGp+PUTbQUBHpyobiL3qO3hi7K/cUM=
Received: from aaew218.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.126.218])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <brian.gix@intel.com>; 31 Oct 2022 22:58:18 +0100
Message-ID: <58ab7693-b98a-6714-d6cf-f8e188bae254@o2.pl>
Date:   Mon, 31 Oct 2022 22:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: "Bluetooth: hci0: HCI_REQ-0xfcf0" errors in dmesg
Content-Language: en-GB
To:     "Gix, Brian" <brian.gix@intel.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
References: <aac93511-d5e5-7a1b-6b1c-65e008ce068e@o2.pl>
 <CABBYNZKXYaRT_N9YTHX2aKRBRVHhORejT=+LJNvrJgL2QYjSLA@mail.gmail.com>
 <beb8dcdc3aee4c5c833aa382f35995f17e7961a1.camel@intel.com>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <beb8dcdc3aee4c5c833aa382f35995f17e7961a1.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 78f8c89d63433d3137dcbe83300b425f
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [QVN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2022 o 22:08, Gix, Brian pisze:
> On Mon, 2022-10-31 at 13:37 -0700, Luiz Augusto von Dentz wrote:
>> On Mon, Oct 31, 2022 at 1:15 PM Mateusz Jończyk <mat.jonczyk@o2.pl>
>> wrote:
>>> On 6.1.0-rc3, I have been seeing this error message in dmesg:
>>>
>>>         Bluetooth: hci0: HCI_REQ-0xfcf0
>>>
>>> It is printed on every boot, resume from suspend and rfkill unblock
>>> of the Bluetooth device.
>>> The device seems to be functioning normally though (but I have done
>>> limited testing only).
>>>
>>> After some investigation, it turned out to be caused by
>>>         commit dd50a864ffae ("Bluetooth: Delete unreferenced
>>> hci_request code")
>>> which modified hci_req_add() in net/bluetooth/hci_request.c to
>>> always print an error message
>>> when that function is executed.
[...]
> This, I suspect, will be an ongoing issue, particularily with Vender
> Opcodes, which we don't have much direct visability and testing
> capabilities.  The error gets logged because it is using a deprecated
> (but still working) mechanism to issue HCI opcodes.
>
> If I can get the source code path of the call as it is being
> contructed, I can try making you a patch Mateusz...  But you will
> probably need to do the testing/verification for me.

Sure, what info would you like me to provide? The MSFT
Vendor Opcode 0xFCF0 is defined in drivers/bluetooth/btrtl.c, line 725.

I'm not sure if I have any additional Bluetooth LE devices around, unfortunately.

Additionally, I think that the error message is a bit cryptic, and perhaps could
be changed and/or demoted to a notice for kernel 6.1.

Greetings,

Mateusz

