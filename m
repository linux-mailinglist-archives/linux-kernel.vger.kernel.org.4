Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E066041ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiJSKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiJSKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:48:14 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6DB120EFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666174931; x=1697710931;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=j3ZIc67EX1Vfhhx7dxQlpeBf7SlEqHwgd2N3XaU4/JE=;
  b=mEyxperhyrgBTjIn8yFvx1OwkhEtptvIij6dvCuTVh78A5PEHlAMlFC8
   QLeneSL9VA5lSjd2Ud4FzPyV49lPD5G/i/r8JD1h9Gi9LtZbn0l+jTIol
   ehRml5QOBND13idrbTKVboqkNJ1QWRoj8si54jZS6PfW3vBhgumVyA8WH
   M=;
X-IronPort-AV: E=Sophos;i="5.95,195,1661817600"; 
   d="scan'208";a="234267297"
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: micron-st: Enable locking for
 n25q256ax1/mt25qu256a
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 09:52:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com (Postfix) with ESMTPS id 4D4128020C;
        Wed, 19 Oct 2022 09:52:15 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 19 Oct 2022 09:52:14 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.15;
 Wed, 19 Oct 2022 09:52:14 +0000
Received: from [192.168.160.198] (10.85.143.176) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 19 Oct 2022 09:52:09 +0000
Message-ID: <01dfdbec-1a1f-6118-23fb-8b8f7b827c82@amazon.com>
Date:   Wed, 19 Oct 2022 12:52:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
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
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <f489048bd1fa65db1a050f1321c640de@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2022 12:38 PM, Michael Walle wrote:
> Am 2022-10-19 11:25, schrieb Farber, Eliav:
>> On 10/19/2022 11:21 AM, Michael Walle wrote:
>>> Hi,
>>>
>>> Am 2022-10-19 09:16, schrieb Eliav Farber:
>>>> n25q256ax1 [1] and mt25qu256a [2] (both have same jedec_id -
>>>> 0x20bb19)
>>>> use the 4 bit Block Protection scheme and support Top/Bottom
>>>> protection
>>>> via the BP and TB bits of the Status Register.
>>>> BP3 is located in bit 6 of the Status Register.
>>>> Tested on both n25q256ax1 and mt25qu256a.
>>>>
>>>> [1]
>>>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_256mb_3v.pdf 
>>>>
>>>> [2]
>>>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf 
>>>>
>>>
>>> If you respin, you can use a "Link:" tag for the URL above.
>>
>> Ack.
>>
>>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>>> ---
>>>> xxd -p
>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>
>>>> 53464450060101ff00060110300000ff84000102800000ffffffffffffff
>>>> ffffffffffffffffffffffffffffffffffffe520fbffffffff0f29eb276b
>>>> 273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
>>>> 03d4ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
>>>> ffffffffffffffffffe7ffff21dcffff
>>>>
>>>> md5sum
>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>
>>>> 5ea738216f68c9f98987bb3725699a32
>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>
>>>> cat
>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id 
>>>>
>>>> 20bb19104400
>>>>
>>>> cat
>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/partname 
>>>>
>>>> mt25qu256a
>>>>
>>>> cat
>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer 
>>>>
>>>> st
>>>
>>> That's the mt25qu256a SFDP. What about the n25q256ax1?
>>
>> On the same card, with same NOR flash memory I'm running two different
>> kernel versions.
>> First version is quite old - 4.19.239 which does not support mt25qu256a
>> and therefore device is detected as n25q256ax1.
>> Second version is 6.1.0-rc1 and it detects the same device as
>> mt25qu256a.
>> So I was able to dump SFDP when running version 6.1.0-rc1, but not when
>> running 4.19.239 which does not support the sysfs to dump the SFPD
>> information.
>> I checked that locking works with my changes when running on both
>> kernel
>> versions.
>
> So you've only tested on an mt25qu256a, correct? Then you should only
> add the locking to this flash device. (and maybe backport the mt25qu256a
> to your older kernel). 

I dumped SFDP tables only for mt25qu256a, but as I mentioned I tested
locking functionality for both (on 4.19.239 which detects the device as
n25q256ax1 and on 6.1.0-rc1  which detects the device as mt25qu256a).
This is the flow I used for testing the change on both versions:

# flash_lock -i /dev/mtd0
fDevice: /dev/mtd0
Start: 0
lLen: 0x1000000
Lock status: unlocked
Return code: 0
# flash_lock -l /dev/mtd0
# flash_lock -i /dev/mtd0
fDevice: /dev/mtd0
Start: 0
Len: 0x1000000
Lock status: locked
Return code: 1
# flash_lock -u /dev/mtd0
# flash_lock -i /dev/mtd0
Device: /dev/mtd0
Start: 0
Len: 0x1000000
Lock status: unlocked

Do you still want this patch to change only mt25qu256a?

--
Regards, Eliav
