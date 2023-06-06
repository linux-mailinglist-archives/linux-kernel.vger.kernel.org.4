Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206CF723A79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjFFHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbjFFHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:30 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA98210E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:46:41 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id DE8415FD25;
        Tue,  6 Jun 2023 10:46:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686037599;
        bh=lRMWN/tD4OOoNCtqA+UPt6GfxG1C8vpIv90IFWvR00M=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=AvQEZS9z22/DoSIs9ApFpGPl4UeUttRv6JhCPs0VAALC63ibq80Z9mI5LdohOVGVy
         VXgnlIlBpAKM8tnjgtat9D8SVlQYOM9skaaPMOY7cw7F5gBnu/u+EWkercoYMTEwdq
         wLgXZOxt1KCEq3xDfaDw0R8GSdgYcd1y56rIwFRaSmSFF8JgGBSBv3vXn4aG7h39Vy
         CmjWqNtmhZiV03QcGC9KJQQuUjcD2ZqNr7hh/CsgS5WDPosuRRVvr0DdEJOmXuN/yK
         ZpUBLAelbGigzbab4d26PruMTWGpSde+YMGq9yoWtrMhr4PxeH7z0g7Bj+WX8cHJQY
         Eu+Zc3Z4Nd1PA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  6 Jun 2023 10:46:39 +0300 (MSK)
Message-ID: <94822bba-d63b-3578-25b3-19768025a90d@sberdevices.ru>
Date:   Tue, 6 Jun 2023 10:41:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v5 3/6] mtd: rawnand: meson: only expose unprotected
 user OOB bytes
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
 <20230601061850.3907800-4-AVKrasnov@sberdevices.ru>
 <20230601103111.6840acc0@xps-13>
 <8242530c-7b6b-29ce-581b-c5644a965b60@sberdevices.ru>
 <20230605114850.77cf9197@xps-13>
 <53f31185-70d9-7264-a99a-cf71f8fc52eb@sberdevices.ru>
 <20230606091107.78c792ff@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230606091107.78c792ff@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/06 04:28:00 #21442352
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.06.2023 10:11, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 07:42:58 +0300:
> 
>> On 05.06.2023 12:48, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@sberdevices.ru wrote on Fri, 2 Jun 2023 11:53:47 +0300:
>>>   
>>>> Hello Miquel, thanks for review!
>>>>
>>>> On 01.06.2023 11:31, Miquel Raynal wrote:  
>>>>> Hi Arseniy,
>>>>>
>>>>> AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:46 +0300:
>>>>>     
>>>>>> This moves free bytes of OOB to non-protected ECC area. It is needed to    
>>>>>
>>>>> As we discussed, I expect this commit to just change the OOB layout to
>>>>> expose unprotected OOB bytes to the user, that is the only change this
>>>>> commit should carry. If that does not work, you should add a
>>>>> preparation patch.    
>>>>
>>>> Ok, but I thought, if i change only OOB layout, e.g. update 'free' callback of
>>>> mtd_ooblayout_ops, I also need to implement code which performs read/write
>>>> according new layout (it must be done in a single patch)?  
>>>
>>> No, this is orthogonal.
>>>
>>> The driver must read the the whole OOB area (and perhaps reorder the
>>> data), but you should not make any decision regarding what bytes you
>>> want or not want to expose.
>>>
>>> Then, the user (no matter what "user" is here) will decide how to deal
>>> with the data.  
>>
>> Hello Miquel!
>>
>> Ok, so in case of:
>> 1) read I just need to read OOB data using 'nand_change_read_column_op()' and place it to 'oob_buf'.
>> 2) write I need to write OOB data using 'nand_change_write_column_op()' to controller internal RAM and then call PAGE_PROG.
>>    Even in ECC mode, data which occupies places of ECC codes will be removed by hw ( as You mentinoed below).
>>
>> That's all?:)
> 
> Sounds right :)
> 
> If you find too costly to make many nand_change_read_column_op() and
> want to leverage DMA instead, you can as well read everything
> (data+oob) in one go in a bounce buffer and then perform memcpy's into
> your final buffer in order to reorganize the data. That's entirely up to
> you (and same of course in the write path, you could first
> memcpy/reorder the data into a DMA bounce buffer locally, and then send
> all the data in a single DMA transfer and call PAGE_PROG).

Got it!

Thanks, Arseniy

> 
>>
>>>   
>>>> Main thing is:
>>>>
>>>> I guess that general confuse with this patch is that You consider
>>>> that we change only OOB layout by moving user bytes out of ECC area, but at the same
>>>> time I also increased size of OOB from 4 bytes (e.g. 2 x 2 bytes clean markers)
>>>> to 32 bytes (e.g. tail of page after data and ECC codes), so if this
>>>> assumption is correct, in the next version I won't change size of user area in
>>>> OOB, thus this patch will be reduced as some comments from this review.  
>>>
>>> Exposing only 4 bytes was a mistake in the first place, please fix this
>>> in a dedicated patch.  
>>
>> So current (not merged) version exposes bytes 0,1,16,17 of OOB, You mean this is wrong?
>> Correct way is to expose 32,33,48,49 (e.g. shifted by 32)?
>>
>> Thanks, Arseniy
>>
>>>   
>>>>>> make JFFS2 works correctly with this NAND controller. Problem fires when
>>>>>> JFFS2 driver writes cleanmarker to some page and later it tries to write
>>>>>> to this page - write will be done successfully, but after that such page
>>>>>> becomes unreadable due to invalid ECC codes. This happens because second
>>>>>> write needs to update ECC codes, but it is impossible to do it correctly
>>>>>> without block erase. So idea of this patch is to use the unprotected OOB
>>>>>> area to store the cleanmarkers, so that they can be written by the
>>>>>> filesystem without caring much about the page being empty or not: the
>>>>>> ECC codes will not be written anyway.
>>>>>>
>>>>>> JFFS2 is only useful on tiny NAND devices, where UBI does not fit, which
>>>>>> are usually true SLC flashes, with the capability of writing a page with
>>>>>> empty (0xFF) data, and still be able to write actual data to it later in
>>>>>> a second write.
>>>>>>
>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>> ---
>>>>>>  Changelog v4->v5:
>>>>>>  * Drop cosmetic changes from this patch.
>>>>>>  * Do not ignore ECC protected user bytes provided by hw. Even these
>>>>>>    bytes are out of user area of OOB, its values are still read from
>>>>>>    the provided OOB buffer and written by hardware. Same behaviour is
>>>>>>    preserved for read access - such bytes are read from DMA buffer and
>>>>>>    placed to OOB buffer.
>>>>>>  * OOB read and write become more lightweight because I removed heavy
>>>>>>    READ0 and PAGEPROG command from it (both commands are still sent
>>>>>>    when OOB access is performed using OOB callbacks). In case of page
>>>>>>    read/write OOB data is handled in the internal SRAM of the controller.
>>>>>>  * Commit message updated.
>>>>>>  * Temporary buffer for OOB read/write is removed. Seems everything
>>>>>>    works correctly without it.
>>>>>>
>>>>>>  drivers/mtd/nand/raw/meson_nand.c | 134 ++++++++++++++++++++++++++----
>>>>>>  1 file changed, 117 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> index 82a629025adc..e42c28be02f3 100644
>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> @@ -358,8 +358,11 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
>>>>>>  static void meson_nfc_get_data_oob(struct nand_chip *nand,
>>>>>>  				   u8 *buf, u8 *oobbuf)
>>>>>>  {
>>>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>  	int i, oob_len = 0;
>>>>>>  	u8 *dsrc, *osrc;
>>>>>> +	u8 *oobtail;
>>>>>>  
>>>>>>  	oob_len = nand->ecc.bytes + 2;
>>>>>>  	for (i = 0; i < nand->ecc.steps; i++) {
>>>>>> @@ -368,17 +371,27 @@ static void meson_nfc_get_data_oob(struct nand_chip *nand,
>>>>>>  			memcpy(buf, dsrc, nand->ecc.size);
>>>>>>  			buf += nand->ecc.size;
>>>>>>  		}
>>>>>> +
>>>>>>  		osrc = meson_nfc_oob_ptr(nand, i);
>>>>>>  		memcpy(oobbuf, osrc, oob_len);
>>>>>>  		oobbuf += oob_len;
>>>>>>  	}
>>>>>> +
>>>>>> +	oobtail = meson_chip->data_buf + nand->ecc.steps *
>>>>>> +		  (nand->ecc.size + oob_len);
>>>>>> +
>>>>>> +	/* 'oobbuf' points to the start of user area. */
>>>>>> +	memcpy(oobbuf, oobtail, mtd->oobsize - nand->ecc.steps * oob_len);
>>>>>>  }
>>>>>>  
>>>>>>  static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>>>>>  				   const u8 *buf, u8 *oobbuf)
>>>>>>  {
>>>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>  	int i, oob_len = 0;
>>>>>>  	u8 *dsrc, *osrc;
>>>>>> +	u8 *oobtail;
>>>>>>  
>>>>>>  	oob_len = nand->ecc.bytes + 2;
>>>>>>  	for (i = 0; i < nand->ecc.steps; i++) {
>>>>>> @@ -391,6 +404,12 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>>>>>  		memcpy(osrc, oobbuf, oob_len);
>>>>>>  		oobbuf += oob_len;
>>>>>>  	}
>>>>>> +
>>>>>> +	oobtail = meson_chip->data_buf + nand->ecc.steps *
>>>>>> +		  (nand->ecc.size + oob_len);    
>>>>>
>>>>> This is always targeting the same area, so it looks strange to me.
>>>>>     
>>>>>> +
>>>>>> +	/* 'oobbuf' points to the start of user area. */
>>>>>> +	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);    
>>>>>
>>>>> TBH I don't get what you do here.    
>>>>
>>>> This code works in raw mode and places OOB data from provided OOB buffer to DMA buffer.
>>>> This is because number of user bytes is increased in this patch.
>>>>  
>>>>>     
>>>>>>  }
>>>>>>  
>>>>>>  static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
>>>>>> @@ -433,7 +452,7 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>>>>  	__le64 *info;
>>>>>>  	int i, count;
>>>>>>  
>>>>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>>>>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
>>>>>>  		info = &meson_chip->info_buf[i];
>>>>>>  		*info |= oob_buf[count];
>>>>>>  		*info |= oob_buf[count + 1] << 8;
>>>>>> @@ -446,7 +465,7 @@ static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>>>>  	__le64 *info;
>>>>>>  	int i, count;
>>>>>>  
>>>>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>>>>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
>>>>>>  		info = &meson_chip->info_buf[i];
>>>>>>  		oob_buf[count] = *info;
>>>>>>  		oob_buf[count + 1] = *info >> 8;
>>>>>> @@ -638,6 +657,84 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> +static u32 meson_nfc_oob_free_bytes(struct nand_chip *nand)
>>>>>> +{
>>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>> +
>>>>>> +	return mtd->oobsize - nand->ecc.steps * (nand->ecc.bytes + 2);    
>>>>>
>>>>> This looks like a static value, just save it somewhere instead of
>>>>> recomputing it?    
>>>>
>>>> Ack
>>>>  
>>>>>     
>>>>>> +}
>>>>>> +
>>>>>> +static int meson_nfc_write_oob(struct nand_chip *nand, int page)
>>>>>> +{
>>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>> +	u32 page_size = mtd->writesize + mtd->oobsize;
>>>>>> +	u32 oob_bytes = meson_nfc_oob_free_bytes(nand);
>>>>>> +	u8 *oob_buf;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (!oob_bytes)
>>>>>> +		return 0;    
>>>>>
>>>>> Can this happen?    
>>>>
>>>> Ack, seems forget to remove it
>>>>  
>>>>>     
>>>>>> +
>>>>>> +	/* Called as OOB write helper, will send NAND_CMD_PAGEPROG. */
>>>>>> +	if (page != -1) {
>>>>>> +		ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	oob_buf = nand->oob_poi;
>>>>>> +
>>>>>> +	ret = nand_change_write_column_op(nand, page_size - oob_bytes,
>>>>>> +					  oob_buf + (mtd->oobsize - oob_bytes),
>>>>>> +					  oob_bytes, false);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	return (page != -1) ? nand_prog_page_end_op(nand) : 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int meson_nfc_read_oob(struct nand_chip *nand, int page)
>>>>>> +{
>>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>> +	u8 *oob_buf = nand->oob_poi;
>>>>>> +	u32 oob_bytes;
>>>>>> +	u32 page_size;
>>>>>> +	int ret;
>>>>>> +	int i;
>>>>>> +
>>>>>> +	/* Called as OOB read helper, send NAND_CMD_READ0. */
>>>>>> +	if (page != -1) {    
>>>>>
>>>>> I don't like this logic with the "-1", it really hides what the
>>>>> controller needs to do, if you need a helper to send a command, then
>>>>> create that helper and give it a decent name.    
>>>>
>>>> I see, so I think I need to implement this in the following way:
>>>> 1) For OOB callback it always sends NAND_CMD_READ0 (e.g. without any 'if')
>>>> 2) For read OOB with data page we don't need to send NAND_CMD_READ0. (also without any 'if')
>>>>  
>>>>>     
>>>>>> +		ret = nand_read_page_op(nand, page, 0, NULL, 0);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* Read ECC codes and user bytes. */
>>>>>> +	for (i = 0; i < nand->ecc.steps; i++) {
>>>>>> +		u32 ecc_offs = nand->ecc.size * (i + 1) +
>>>>>> +			       (nand->ecc.bytes + 2) * i;
>>>>>> +
>>>>>> +		ret = nand_change_read_column_op(nand, ecc_offs,
>>>>>> +						 oob_buf + i * (nand->ecc.bytes + 2),
>>>>>> +						 (nand->ecc.bytes + 2), false);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	oob_bytes = meson_nfc_oob_free_bytes(nand);
>>>>>> +
>>>>>> +	if (!oob_bytes)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	page_size = mtd->writesize + mtd->oobsize;
>>>>>> +
>>>>>> +	ret = nand_change_read_column_op(nand, page_size - oob_bytes,
>>>>>> +					 oob_buf + (mtd->oobsize - oob_bytes),
>>>>>> +					 oob_bytes, false);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>>  static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>  				    int page, int raw)
>>>>>>  {
>>>>>> @@ -674,6 +771,12 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>  				     NFC_CMD_SCRAMBLER_DISABLE);
>>>>>>  	}
>>>>>>  
>>>>>> +	if (!raw) {    
>>>>>
>>>>> Why this check?
>>>>>
>>>>> You should instead propagate the oob_required field and check that
>>>>> value I believe.    
>>>>
>>>>
>>>> This check is for ECC mode, because in this mode we write user bytes of OOB.
>>>> ECC bytes of OOB are written by hardware.  
>>>
>>> Just provide the buffer. The ECC engine will smash data if there was
>>> any there. Otherwise it will fill the holes. It's expected. Don't try
>>> to be smarter than you should :)
>>>   
>>>> I think I made a mistake, because
>>>> I need new callback to write OOB in raw mode - it will write both ECC and user
>>>> parts,  
>>>
>>> There is no such thing as user and ECC part at the driver level. You
>>> get a buffer, you need to write it to the flash.
>>>
>>> The user expects:
>>>
>>> | data | OOB |
>>>
>>> The controller expects something like:
>>>
>>> | data1 | OOB1 | data2 | OOB2 |
>>>
>>> So just perform the reordering between data and OOB in the DMA buffer,
>>> that is _all_.
>>>   
>>>> in current version I write only user part in raw mode.
>>>>  
>>>>>     
>>>>>> +		ret = meson_nfc_write_oob(nand, -1);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>>  	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>>>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>  	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
>>>>>> @@ -834,17 +937,10 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
>>>>>>  		memcpy(buf, meson_chip->data_buf, mtd->writesize);
>>>>>>  	}
>>>>>>  
>>>>>> -	return bitflips;
>>>>>> -}
>>>>>> -
>>>>>> -static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
>>>>>> -{
>>>>>> -	return meson_nfc_read_page_raw(nand, NULL, 1, page);
>>>>>> -}
>>>>>> +	if (oob_required && ret)    
>>>>>
>>>>> Unclear why you check ret here?  
>>>
>>> In general, if (ret) means there is an error.
>>>
>>> Please consider using:
>>>
>>> if (ret)
>>> 	goto error path;
>>>
>>> do something else;
>>>   
>>>>>     
>>>>
>>>> If read was successful, we read OOB. If not - there is no sense in it.
>>>>  
>>>>>> +		meson_nfc_read_oob(nand, -1);
>>>>>>  
>>>>>> -static int meson_nfc_read_oob(struct nand_chip *nand, int page)
>>>>>> -{
>>>>>> -	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
>>>>>> +	return bitflips;
>>>>>>  }
>>>>>>  
>>>>>>  static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
>>>>>> @@ -987,12 +1083,16 @@ static int meson_ooblayout_free(struct mtd_info *mtd, int section,
>>>>>>  				struct mtd_oob_region *oobregion)
>>>>>>  {
>>>>>>  	struct nand_chip *nand = mtd_to_nand(mtd);
>>>>>> +	u32 oob_bytes = meson_nfc_oob_free_bytes(nand);
>>>>>>  
>>>>>>  	if (section >= nand->ecc.steps)
>>>>>>  		return -ERANGE;
>>>>>>  
>>>>>> -	oobregion->offset = section * (2 + nand->ecc.bytes);    
>>>>>
>>>>> The first two bytes of OOB are reserved for the bad block markers. This
>>>>> is not related to your controller.    
>>>>
>>>> I think first two bytes (in fact there are 4 bytes at positions 0, 1, 16 and 17)
>>>> is considered by hardware as user bytes covered by ECC.  
>>>
>>> The two first bytes should not be available. They are not "ECC" bytes,
>>> they are not "free" bytes. None of these two callbacks should give
>>> access to these two bytes reserved for bad block markers.
>>>
>>> Just to be clear: "ECC bytes" as in "meson_ooblayout_ecc" do *not* mean
>>> "these are the protected bytes". They mean "these are the bytes in OOB
>>> the hardware ECC engine will use to place its own data to make the
>>> recovery process work".
>>>
>>> Thanks,
>>> Miquèl  
> 
> 
> Thanks,
> Miquèl
