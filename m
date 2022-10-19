Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC760421B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiJSKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiJSKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:53:45 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC19A4456D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:24:54 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 35C101D1E;
        Wed, 19 Oct 2022 12:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666175002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdGIaEcZtyU5pPGSMfXan4IZw9UXyG5z5ZP2c3+GG/o=;
        b=GYfkPWhHQI1u1Eu13Xp8yDik3OsF2DoWbYRGtftUGBlKGAs+lYecZsOZrVTjeR4l7bPrpI
        fjrVLWMP7x3ljbhg96FFgqrSub0yK0TL2Nm9Ikxk60l8z1QKvQlqPlysSoRV438MKXpClE
        cIce6nfsj0Ny25F6FJRQLwvG5QxJSY3f+wZLwA/fmT2UoJWxYXpAlhGP9Dey1BD98XaLp3
        3s8nP5KC79Vtuzo4FNtpy1QAINSocsIcHs/tBLOaE+RyKtovdIBR5xOZ76AxDNtG+tetbA
        jbFyXpjIAIbTl+11yiTHVU1OxDMthX3Ar6xix1EHeJeq8MDHuwsrBiMjPet4eA==
MIME-Version: 1.0
Date:   Wed, 19 Oct 2022 12:23:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, jonnyc@amazon.com, hhhawa@amazon.com,
        hanochu@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: micron-st: Enable locking for
 n25q256ax1/mt25qu256a
In-Reply-To: <01dfdbec-1a1f-6118-23fb-8b8f7b827c82@amazon.com>
References: <20221019071631.15191-1-farbere@amazon.com>
 <73bfa5ae90e2269387540019806c2839@walle.cc>
 <1ba2e7ff-cf6c-1292-72e0-14b5b5b9282c@amazon.com>
 <f489048bd1fa65db1a050f1321c640de@walle.cc>
 <01dfdbec-1a1f-6118-23fb-8b8f7b827c82@amazon.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <41a05a89cd30b21dce866bc3209fe836@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-19 11:52, schrieb Farber, Eliav:
> On 10/19/2022 12:38 PM, Michael Walle wrote:
>> Am 2022-10-19 11:25, schrieb Farber, Eliav:
>>> On 10/19/2022 11:21 AM, Michael Walle wrote:
>>>> Hi,
>>>> 
>>>> Am 2022-10-19 09:16, schrieb Eliav Farber:
>>>>> n25q256ax1 [1] and mt25qu256a [2] (both have same jedec_id -
>>>>> 0x20bb19)
>>>>> use the 4 bit Block Protection scheme and support Top/Bottom
>>>>> protection
>>>>> via the BP and TB bits of the Status Register.
>>>>> BP3 is located in bit 6 of the Status Register.
>>>>> Tested on both n25q256ax1 and mt25qu256a.
>>>>> 
>>>>> [1]
>>>>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_256mb_3v.pdf 
>>>>> [2]
>>>>> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf
>>>> 
>>>> If you respin, you can use a "Link:" tag for the URL above.
>>> 
>>> Ack.
>>> 
>>>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>>>> ---
>>>>> xxd -p
>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>> 53464450060101ff00060110300000ff84000102800000ffffffffffffff
>>>>> ffffffffffffffffffffffffffffffffffffe520fbffffffff0f29eb276b
>>>>> 273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
>>>>> 03d4ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
>>>>> ffffffffffffffffffe7ffff21dcffff
>>>>> 
>>>>> md5sum
>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>> 5ea738216f68c9f98987bb3725699a32
>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
>>>>> cat
>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id 
>>>>> 20bb19104400
>>>>> 
>>>>> cat
>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/partname 
>>>>> mt25qu256a
>>>>> 
>>>>> cat
>>>>> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer 
>>>>> st
>>>> 
>>>> That's the mt25qu256a SFDP. What about the n25q256ax1?
>>> 
>>> On the same card, with same NOR flash memory I'm running two 
>>> different
>>> kernel versions.
>>> First version is quite old - 4.19.239 which does not support 
>>> mt25qu256a
>>> and therefore device is detected as n25q256ax1.
>>> Second version is 6.1.0-rc1 and it detects the same device as
>>> mt25qu256a.
>>> So I was able to dump SFDP when running version 6.1.0-rc1, but not 
>>> when
>>> running 4.19.239 which does not support the sysfs to dump the SFPD
>>> information.
>>> I checked that locking works with my changes when running on both
>>> kernel
>>> versions.
>> 
>> So you've only tested on an mt25qu256a, correct? Then you should only
>> add the locking to this flash device. (and maybe backport the 
>> mt25qu256a
>> to your older kernel).
> 
> I dumped SFDP tables only for mt25qu256a, but as I mentioned I tested
> locking functionality for both (on 4.19.239 which detects the device as
> n25q256ax1 and on 6.1.0-rc1  which detects the device as mt25qu256a).
> This is the flow I used for testing the change on both versions:

You said you've tested on the same board, thus it has the same flash
device. But with the older kernel it was detected as a different part.

So the question is, what is the correct part number? I.e. what is the
_actual_ flash device soldered on your board?

-michael
