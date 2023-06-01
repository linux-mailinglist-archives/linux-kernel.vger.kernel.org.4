Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E47194E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjFAH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjFAH7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:59:09 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197510EA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:56:04 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5F8345FD78;
        Thu,  1 Jun 2023 10:56:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685606162;
        bh=bynRxu2YS2NLYpOmBv2P/K8koFPB1hWG1xtDiAfV4T4=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=cL7PeMXRt3ihVTWPNXGzKvOMMMOiY7WEQihZFjoSYMlglG1bLGikbytyTWa3c3Rqh
         0rfq5pWthpQgdmVKG49RrtT/RaOk1zr3Fx96wgr//DrwwmGE+QFCfidyjaSlPFdyGj
         ydbNeoiO+ysojESbIMh6FDx1xAjkZG6bJxPqVo3/cX4JEzWLVO1ovaLa8x4cw5qkAp
         gtyLynlDmJ8rR2yhXGGXk8pUrmBbJpyC/lnNjJmjE4i7sZHRacJnstd0dai/f7RviL
         lEUZccZtCygh3ATOXWIqFa8KHjfAZ5IlR+AknuCDnPHM9pXYNUgaboVFz9UFH+1jl2
         LS3dBqUsYExJA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Jun 2023 10:56:01 +0300 (MSK)
Message-ID: <c1380e3b-e439-3240-d193-572205f5a860@sberdevices.ru>
Date:   Thu, 1 Jun 2023 10:51:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v5 0/6] refactoring, fixes and updates for Meson NAND
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
 <20230601095041.30d646d2@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230601095041.30d646d2@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/01 03:13:00 #21393813
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.06.2023 10:50, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:43 +0300:
> 
>> Hello,
>>
>> this patchset does several things:
> 
> All the fixes should contain:
> 
> Fixes: <hash> ("log")
> Cc: stable@vger.kernel.org

Hello Miquel,

Sorry. my fault, I'll add this in the next version for 0001 (anyway i think current is not final).

Thanks, Arseniy

> 
>>
>> 1) Fixes value of ready/busy command. This new value was suggested by
>>    Liang Yang <liang.yang@amlogic.com>.
>>
>> 2) Adds waiting for command completion by calling 'nand_soft_waitrdy()'
>>    instead of using ready/busy pin and command from 1). This is really
>>    needed because I don't have device with such pin implemented.
>>
>> 3) It moves OOB free bytes to non-protected by ECC area. Here are some
>>    details:
>>
>>    Current OOB free bytes are 4 bytes (2 x 2 user bytes) under ECC engine.
>>    Here is how it looks like in the current implementation:
>>
>>    [ 2B user bytes ][     14B ECC codes    ]
>>    [ 2B user bytes ][     14B ECC codes    ]
>>    [ 16B unused area, not protected by ECC ]
>>    [ 16B unused area, not protected by ECC ]
>>
>>    All 4 user bytes are protected by ECC. This patch changes OOB free
>>    bytes in this way:
>>
>>    [ 2B unused area ][     14B ECC codes     ]
>>    [ 2B unused area ][     14B ECC codes     ]
>>    [  16B user bytes, not protected by ECC   ]
>>    [  16B user bytes, not protected by ECC   ]
>>
>>    Now OOB user bytes are 32 bytes instead of 4 bytes and not protected
>>    by ECC.
>>
>>    Motivation of this layout comes from problem with JFFS2. It uses OOB
>>    free bytes for cleanmarkers. Each cleanmarker is 4 bytes and written
>>    by JFFS2 driver (small remark - cleanmarkers are always written in
>>    case of NAND storage for JFFS2).
>>    We have two ways to write this data to OOB (e.g. user bytes):
>>
>>    1) ECC mode. In this case it will be ECC covered user bytes, e.g.
>>       writing this bytes will update ECC codes. Problem fires, when
>>       JFFS2 tries to write this page later - this write makes controller
>>       to update ECC codes again, but it is impossible to do it correctly,
>>       because we can't update bits from 0 to 1 (only from 1 to 0).
>>
>>    2) Raw mode. In this case ECC codes won't be updated. But later, it
>>       will be impossible to read this page in ECC mode, because we have
>>       some user bytes, but ECC codes are missed.
>>
>>    So let's move OOB free bytes out of ECC area. In this case we can
>>    read/write OOB separately in raw mode and at the same time work with
>>    data in ECC mode. JFFS2 is happy now. User bytes are untouched - all
>>    of them are ignored during non-OOB access.
>>
>>    I've tested this with mount/unmount/read/write cases for JFFS2 and
>>    nanddump/nandwrite utlities on AXG family (A113X SoC).
>>
>>    Here is link to discussion:
>>    https://lore.kernel.org/linux-mtd/a9f8307a-77d7-a69f-ce11-2629909172d2@sberdevices.ru/T/#m3087bd06386a7f430cd5e343e22b25d724d3e2d7
>>
>> 4) Replaces calculation of OOB related thing with macros. This is just
>>    cosmetic change.
>>
>> 5) Checks buffer length on accesses to NAND controller.
>>
>> 6) Removes useless bitwise OR with zeroes.
>>
>> Link to v1:
>> https://lore.kernel.org/linux-mtd/20230412061700.1492474-1-AVKrasnov@sberdevices.ru/
>> Link to v2:
>> https://lore.kernel.org/linux-mtd/20230426073632.3905682-1-AVKrasnov@sberdevices.ru/
>> Link to v3:
>> https://lore.kernel.org/linux-mtd/20230510110835.26115-1-AVKrasnov@sberdevices.ru/
>> Link to v4:
>> https://lore.kernel.org/linux-mtd/20230515094440.3552094-1-AVKrasnov@sberdevices.ru/
>>
>> Changelog:
>>
>> v1 -> v2:
>>  * Add patch which renames dts value for chip select.
>>  * Add patch which moves OOB to non-protected ECC area.
>> v2 -> v3:
>>  * Change patch which fixes read/write access according discussion link
>>    in 1) above.
>> v3 -> v4:
>>  * Remove patch which renames dts value for chip select.
>>    Here is link to discussion:
>>    https://lore.kernel.org/linux-mtd/20230510110835.26115-7-AVKrasnov@sberdevices.ru/
>>  * Pass 1 to 'meson_nfc_queue_rb()' in case of NAND_OP_WAITRDY_INSTR.
>>    This fixes ONFI page processing during NAND driver initialization.
>> v4 -> v5:
>>  * Move update of 'NFC_CMD_RB_INT' to the separate patch.
>>  * Replace code which uses extra status and READ0 commands for waiting
>>    command with 'nand_soft_waitrdy()'. In fact this patch adds second
>>    mode for command waiting by using 'nand_soft_waitrdy()'.
>>  * For OOB layout patch see changelog in a patch file.
>>  * For check length patch see changelog in a patch file.
>>
>> Arseniy Krasnov (6):
>>   mtd: rawnand: meson: fix ready/busy command
>>   mtd: rawnand: meson: wait for command in polling mode
>>   mtd: rawnand: meson: only expose unprotected user OOB bytes
>>   mtd: rawnand: meson: use macro for OOB area
>>   mtd: rawnand: meson: check buffer length
>>   mtd: rawnand: meson: remove unneeded bitwise OR with zeroes
>>
>>  drivers/mtd/nand/raw/meson_nand.c | 234 +++++++++++++++++++++++-------
>>  1 file changed, 182 insertions(+), 52 deletions(-)
>>
> 
> 
> Thanks,
> Miquèl
