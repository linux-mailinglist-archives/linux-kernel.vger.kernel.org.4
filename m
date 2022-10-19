Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB33604060
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJSJwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiJSJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:52:07 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C06E31B1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666171561; x=1697707561;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=66n6UWckGr9pYzJ89YQCqoPVrnClEd2k3PCNw2hP3jc=;
  b=ieBVry3iTK1auZE2CNcFpZS7zlDukvq7FlSXEOTIxPmy0BmZ0/0h8CeJ
   jWtOlKF5lsmeQIYNTkiji2H/twURFV7b3WPbkchs7H6pzT/3A/97SUvqI
   mhuPGItJqqNwFTkoL3hOZDpKTrNEH+Wh2Xak46XCmfjZDWexqpNpZC3DZ
   Y=;
X-IronPort-AV: E=Sophos;i="5.95,195,1661817600"; 
   d="scan'208";a="253598703"
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: micron-st: Enable locking for
 n25q256ax1/mt25qu256a
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 09:25:45 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 9E2B6416A3;
        Wed, 19 Oct 2022 09:25:43 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 19 Oct 2022 09:25:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.15;
 Wed, 19 Oct 2022 09:25:40 +0000
Received: from [192.168.160.198] (10.85.143.176) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 19 Oct 2022 09:25:36 +0000
Message-ID: <1ba2e7ff-cf6c-1292-72e0-14b5b5b9282c@amazon.com>
Date:   Wed, 19 Oct 2022 12:25:36 +0300
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
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <73bfa5ae90e2269387540019806c2839@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2022 11:21 AM, Michael Walle wrote:
> Hi,
>
> Am 2022-10-19 09:16, schrieb Eliav Farber:
>> n25q256ax1 [1] and mt25qu256a [2] (both have same jedec_id - 0x20bb19)
>> use the 4 bit Block Protection scheme and support Top/Bottom protection
>> via the BP and TB bits of the Status Register.
>> BP3 is located in bit 6 of the Status Register.
>> Tested on both n25q256ax1 and mt25qu256a.
>>
>> [1]
>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_256mb_3v.pdf 
>>
>> [2]
>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf 
>>
>
> If you respin, you can use a "Link:" tag for the URL above.

Ack.

>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> xxd -p
>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>
>> 53464450060101ff00060110300000ff84000102800000ffffffffffffff
>> ffffffffffffffffffffffffffffffffffffe520fbffffffff0f29eb276b
>> 273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
>> 03d4ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
>> ffffffffffffffffffe7ffff21dcffff
>>
>> md5sum
>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>
>> 5ea738216f68c9f98987bb3725699a32
>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>
>>
>> cat
>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id 
>>
>> 20bb19104400
>>
>> cat
>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/partname 
>>
>> mt25qu256a
>>
>> cat
>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer 
>>
>> st
>
> That's the mt25qu256a SFDP. What about the n25q256ax1? 

On the same card, with same NOR flash memory I'm running two different
kernel versions.
First version is quite old - 4.19.239 which does not support mt25qu256a
and therefore device is detected as n25q256ax1.
Second version is 6.1.0-rc1 and it detects the same device as mt25qu256a.
So I was able to dump SFDP when running version 6.1.0-rc1, but not when
running 4.19.239 which does not support the sysfs to dump the SFPD
information.
I checked that locking works with my changes when running on both kernel
versions.

--
Regards, Eliav
