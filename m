Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5C605ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJTJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJTJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:16:13 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BD1FAC7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666257359; x=1697793359;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=50K2fOMXsk+lwezuCkWwD6hRARUwosKvthRX0IylFyg=;
  b=DNfryAeHFlB6YklclwRRr50/rf2zxM//z5aObnNTLwgAwj6pw9FDRvZv
   yC5CVyr8zs6P0wZMxsjcCHU3RM+bAZrRoDXCXTb2YH74HfBmEILyEw8Sx
   dZxNKAbcQWi3V5D+O1UJVdQZKKfZsgiRFJDUuga+0M6q3uHBByckkx3HJ
   U=;
X-IronPort-AV: E=Sophos;i="5.95,198,1661817600"; 
   d="scan'208";a="142228806"
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: micron-st: Enable locking for
 n25q256ax1/mt25qu256a
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:15:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com (Postfix) with ESMTPS id 36EC7C0932;
        Thu, 20 Oct 2022 09:15:46 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 20 Oct 2022 09:15:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.15;
 Thu, 20 Oct 2022 09:15:46 +0000
Received: from [192.168.104.103] (10.85.143.175) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 20 Oct 2022 09:15:42 +0000
Message-ID: <a1411e79-d0ec-31e7-a190-ec2622928070@amazon.com>
Date:   Thu, 20 Oct 2022 12:15:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To:     Michael Walle <michael@walle.cc>
CC:     <tudor.ambarus@microchip.com>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <amitlavi@amazon.com>, <dkl@amazon.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20221019071631.15191-1-farbere@amazon.com>
 <73bfa5ae90e2269387540019806c2839@walle.cc>
 <1ba2e7ff-cf6c-1292-72e0-14b5b5b9282c@amazon.com>
 <f489048bd1fa65db1a050f1321c640de@walle.cc>
 <01dfdbec-1a1f-6118-23fb-8b8f7b827c82@amazon.com>
 <41a05a89cd30b21dce866bc3209fe836@walle.cc>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <41a05a89cd30b21dce866bc3209fe836@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2022 1:23 PM, Michael Walle wrote:
> Am 2022-10-19 11:52, schrieb Farber, Eliav:
>> On 10/19/2022 12:38 PM, Michael Walle wrote:
>>> Am 2022-10-19 11:25, schrieb Farber, Eliav:
>>>> On 10/19/2022 11:21 AM, Michael Walle wrote:
>>>>> Hi,
>>>>>
>>>>> Am 2022-10-19 09:16, schrieb Eliav Farber:
>>>>>> n25q256ax1 [1] and mt25qu256a [2] (both have same jedec_id -
>>>>>> 0x20bb19)
>>>>>> use the 4 bit Block Protection scheme and support Top/Bottom
>>>>>> protection
>>>>>> via the BP and TB bits of the Status Register.
>>>>>> BP3 is located in bit 6 of the Status Register.
>>>>>> Tested on both n25q256ax1 and mt25qu256a.
>>>>>>
>>>>>> [1]
>>>>>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_256mb_3v.pdf 
>>>>>>
>>>>>> [2]
>>>>>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf 
>>>>>>
>>>>>
>>>>> If you respin, you can use a "Link:" tag for the URL above.
>>>>
>>>> Ack.
>>>>
>>>>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>>>>> ---
>>>>>> xxd -p
>>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>>>
>>>>>> 53464450060101ff00060110300000ff84000102800000ffffffffffffff
>>>>>> ffffffffffffffffffffffffffffffffffffe520fbffffffff0f29eb276b
>>>>>> 273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
>>>>>> 03d4ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
>>>>>> ffffffffffffffffffe7ffff21dcffff
>>>>>>
>>>>>> md5sum
>>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>>>
>>>>>> 5ea738216f68c9f98987bb3725699a32
>>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>>>
>>>>>> cat
>>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id 
>>>>>>
>>>>>> 20bb19104400
>>>>>>
>>>>>> cat
>>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/partname 
>>>>>>
>>>>>> mt25qu256a
>>>>>>
>>>>>> cat
>>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer 
>>>>>>
>>>>>> st
>>>>>
>>>>> That's the mt25qu256a SFDP. What about the n25q256ax1?
>>>>
>>>> On the same card, with same NOR flash memory I'm running two
>>>> different
>>>> kernel versions.
>>>> First version is quite old - 4.19.239 which does not support
>>>> mt25qu256a
>>>> and therefore device is detected as n25q256ax1.
>>>> Second version is 6.1.0-rc1 and it detects the same device as
>>>> mt25qu256a.
>>>> So I was able to dump SFDP when running version 6.1.0-rc1, but not
>>>> when
>>>> running 4.19.239 which does not support the sysfs to dump the SFPD
>>>> information.
>>>> I checked that locking works with my changes when running on both
>>>> kernel
>>>> versions.
>>>
>>> So you've only tested on an mt25qu256a, correct? Then you should only
>>> add the locking to this flash device. (and maybe backport the
>>> mt25qu256a
>>> to your older kernel).
>>
>> I dumped SFDP tables only for mt25qu256a, but as I mentioned I tested
>> locking functionality for both (on 4.19.239 which detects the device as
>> n25q256ax1 and on 6.1.0-rc1  which detects the device as mt25qu256a).
>> This is the flow I used for testing the change on both versions:
>
> You said you've tested on the same board, thus it has the same flash
> device. But with the older kernel it was detected as a different part.
>
> So the question is, what is the correct part number? I.e. what is the
> _actual_ flash device soldered on your board?

I have found out that we use MT25QU256ABA8ESF-0SIT so I'll release a
patch for mt25qu256a only.

--
Thanks, Eliav
