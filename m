Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15A714FED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjE2TsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjE2TsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:48:09 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9FD9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:48:04 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B48765FD1A;
        Mon, 29 May 2023 22:48:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685389681;
        bh=r0MF/6D3rB4N+9gPP7EKoAXBM/mm60WwREZaiRKljKY=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=jydcj2dQ6qVMwBm6o8gTGhVAlZZPSjxIqJpouwdh8hgktefDNhorL2rruGGLfdbN0
         GhwAi4stm2MW62haLXsfAFhT/wCamCopukPpqxdGa/RG9vSOiu54/i/KACKvnoSGUz
         J8fUWf6n3/dZcBxam68dnr2QS6FytpbOkh1GtmxNvE9WgEZ+85FnsFKCAlHWLytbam
         yLms6MhorFJ4dY9h8q+sPZASKskQE0hZPYdKi7mtk41JOfaQgsdOGV0sK2VLB/9I8H
         fEyE5k+tn1cHcWC2NBkkwEIkwQMRZHoGUWEOn/yNKK3EgYv5xBtykE5zoLDtwwlaHn
         XePwZNGz4aCQw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 29 May 2023 22:47:59 +0300 (MSK)
Message-ID: <b9f0a38a-0d50-23f0-4509-c38362d05f12@sberdevices.ru>
Date:   Mon, 29 May 2023 22:43:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/5] mtd: rawnand: meson: move OOB to non-protected ECC
 area
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
 <20230515094440.3552094-3-AVKrasnov@sberdevices.ru>
 <20230522173334.7aa6f917@xps-13>
 <ebbc26e3-6a1c-eead-051c-8f93beba41f3@sberdevices.ru>
 <20230526190347.6e34a2be@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230526190347.6e34a2be@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/29 07:59:00 #21367693
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

Hello Miquel! Thanks for details and explanations!

On 26.05.2023 20:03, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Tue, 23 May 2023 20:17:14 +0300:
> 
>> Hello Miquel! Thanks for detailed review!
>>
>> On 22.05.2023 18:33, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:36 +0300:
>>>
>>> The title should perhaps be "only expose unprotected user OOB bytes".
>>>   
>>>> This moves free bytes of OOB to non-protected ECC area. It is needed to
>>>> make JFFS2 works correctly with this NAND controller. Problem fires when
>>>> JFFS2 driver writes cleanmarker to some page and later it tries to write
>>>> to this page - write will be done successfully, but after that such page
>>>> becomes unreadable due to invalid ECC codes. This happens because second
>>>> write needs to update ECC codes, but it is impossible to do it correctly
>>>> without block erase. So idea of this patch is to  
>>>
>>> "... is to use the unprotected OOB area to store the cleanmarkers, so
>>> that they can be written by the filesystem without caring much about
>>> the page being empty or not: the ECC codes will not be written anyway."
>>> ?  
>>
>> Ok
>>
>>>
>>> JFFS2 is only useful on tiny NAND devices, where UBI does not fit,
>>> which are usually true SLC flashes, with the capability of writing
>>> a page with empty (0xFF) data, and still be able to write actual data
>>> to it later in a second write.  
>>
>> You mean to include text above to commit message also?
> 
> Yes, I believe this deserves to be in the commit message as well :)
> 

Ack

>>
>>>   
>>>> split accesses to OOB
>>>> free bytes and data on each page - now both of them does not depends on
>>>> each other.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>>  drivers/mtd/nand/raw/meson_nand.c | 192 ++++++++++++++++++++++++------
>>>>  1 file changed, 155 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>> index 2f4d8c84186b..8526a6b87720 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -108,6 +108,9 @@
>>>>  
>>>>  #define PER_INFO_BYTE		8
>>>>  
>>>> +#define NFC_USER_BYTES		2
>>>> +#define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
>>>> +
>>>>  struct meson_nfc_nand_chip {
>>>>  	struct list_head node;
>>>>  	struct nand_chip nand;
>>>> @@ -122,6 +125,7 @@ struct meson_nfc_nand_chip {
>>>>  	u8 *data_buf;
>>>>  	__le64 *info_buf;
>>>>  	u32 nsels;
>>>> +	u8 *oob_buf;
>>>>  	u8 sels[];
>>>>  };
>>>>  
>>>> @@ -338,7 +342,7 @@ static u8 *meson_nfc_oob_ptr(struct nand_chip *nand, int i)
>>>>  	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>  	int len;
>>>>  
>>>> -	len = nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
>>>> +	len = nand->ecc.size * (i + 1) + NFC_OOB_PER_ECC(nand) * i;  
>>>
>>> This...
>>>   
>>>>  
>>>>  	return meson_chip->data_buf + len;
>>>>  }
>>>> @@ -349,7 +353,7 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
>>>>  	int len, temp;
>>>>  
>>>>  	temp = nand->ecc.size + nand->ecc.bytes;
>>>> -	len = (temp + 2) * i;
>>>> +	len = (temp + NFC_USER_BYTES) * i;  
>>>
>>> ... and this (same below)
>>>
>>> are purely cosmetic, should be in a patch aside.
>>>   
>>
>> Ack, i'll move cosmetic updates to separate patch.
>>
>>>>  
>>>>  	return meson_chip->data_buf + len;
>>>>  }
>>>> @@ -357,29 +361,47 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
>>>>  static void meson_nfc_get_data_oob(struct nand_chip *nand,
>>>>  				   u8 *buf, u8 *oobbuf)
>>>>  {
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>  	int i, oob_len = 0;
>>>>  	u8 *dsrc, *osrc;
>>>> +	u8 *oobtail;
>>>>  
>>>> -	oob_len = nand->ecc.bytes + 2;
>>>> +	oob_len = NFC_OOB_PER_ECC(nand);
>>>>  	for (i = 0; i < nand->ecc.steps; i++) {
>>>>  		if (buf) {
>>>>  			dsrc = meson_nfc_data_ptr(nand, i);
>>>>  			memcpy(buf, dsrc, nand->ecc.size);
>>>>  			buf += nand->ecc.size;
>>>>  		}
>>>> -		osrc = meson_nfc_oob_ptr(nand, i);
>>>> -		memcpy(oobbuf, osrc, oob_len);
>>>> -		oobbuf += oob_len;
>>>> +
>>>> +		if (oobbuf) {
>>>> +			osrc = meson_nfc_oob_ptr(nand, i);
>>>> +			memcpy(oobbuf, osrc, oob_len);
>>>> +			oobbuf += oob_len;
>>>> +		}
>>>>  	}
>>>> +
>>>> +	if (!oobbuf)
>>>> +		return;  
>>>
>>> The whole "if (oobbuf)" logic is nice to have, but should as well be in
>>> a dedicated patch.  
>>
>> Sorry, You mean that this logic implements read of ECC codes? And not
>> related to OOB layout update in this patch?
> 
> You need to make cosmetic changes in a first patch (or even in several
> patches if they are not related), then in another patch you might make
> additions like a better handling of the OOB, and any change in the
> layout might come last. I just want to split the patch to make
> understandable atomic changes (also easier to review).
> 
> 1 atomic change == 1 patch
> 

Ok, I'll try to split it!

>>>   
>>>> +
>>>> +	oobtail = meson_chip->data_buf + nand->ecc.steps *
>>>> +		  (nand->ecc.size + oob_len);
>>>> +
>>>> +	/* 'oobbuf' if already shifted to the start of unused area. */  
>>>
>>> 		    is?
>>> s/unused/user/? I'm not sure I get the comment.  
>>
>> Yes, not clear comment.
>>
>>>   
>>>> +	memcpy(oobbuf, oobtail, mtd->oobsize - nand->ecc.steps * oob_len);
>>>>  }
>>>>  
>>>>  static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>>>  				   const u8 *buf, u8 *oobbuf)
>>>>  {
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>  	int i, oob_len = 0;
>>>>  	u8 *dsrc, *osrc;
>>>> +	u8 *oobtail;
>>>>  
>>>> -	oob_len = nand->ecc.bytes + 2;
>>>> +	oob_len = NFC_OOB_PER_ECC(nand);
>>>>  	for (i = 0; i < nand->ecc.steps; i++) {
>>>>  		if (buf) {
>>>>  			dsrc = meson_nfc_data_ptr(nand, i);
>>>> @@ -390,6 +412,12 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>>>  		memcpy(osrc, oobbuf, oob_len);
>>>>  		oobbuf += oob_len;
>>>>  	}
>>>> +
>>>> +	oobtail = meson_chip->data_buf + nand->ecc.steps *
>>>> +		  (nand->ecc.size + oob_len);
>>>> +
>>>> +	/* 'oobbuf' if already shifted to the start of unused area. */
>>>> +	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);
>>>>  }
>>>>  
>>>>  static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms, int cmd_read0)
>>>> @@ -436,25 +464,12 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>>  {
>>>>  	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>  	__le64 *info;
>>>> -	int i, count;
>>>> -
>>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>>> -		info = &meson_chip->info_buf[i];
>>>> -		*info |= oob_buf[count];
>>>> -		*info |= oob_buf[count + 1] << 8;
>>>> -	}
>>>> -}
>>>> -
>>>> -static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>> -{
>>>> -	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> -	__le64 *info;
>>>> -	int i, count;
>>>> +	int i;
>>>>  
>>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>>> +	for (i = 0; i < nand->ecc.steps; i++) {
>>>>  		info = &meson_chip->info_buf[i];
>>>> -		oob_buf[count] = *info;
>>>> -		oob_buf[count + 1] = *info >> 8;
>>>> +		/* Always ignore user bytes programming. */  
>>>
>>> Why?  
>>
>> I think comment message is wrong a little bit. Here "user bytes" are
>> user bytes protected by ECC (e.g. location of these bytes differs from new
>> OOB layout introduced by this patch). During page write this hardware
>> always writes these bytes along with data. But, new OOB layout always ignores
>> these 4 bytes, so set them to 0xFF always.
> 
> When performing page reads/writes, you need to take the data as it's
> been provided. You may move the data around in the buffer provided to
> the controller, so that it get the ECC data at the right location, and
> you need of course to reorganize the data when reading as well, so that
> the user sees XkiB of data + YB of OOB. That's all you need to do in
> these helpers.
> 

I think there is some misunderstanding about these "user bytes" above: there are 4
bytes which this NAND controller always writes to page in ECC mode - it was free OOB
bytes covered by ECC. Controller grabs values from DMA buffer (second DMA buffer which
doesn't contains page data) and writes it along with data and ECC codes. Idea of this
change is to always suppress this write by setting them to 0xFF (may be there is some
command option to not write it, but I don't have doc), because all of them (4 bytes)
become unavailable to reader/writer.

>>> Also, maybe I should mention the helpers:
>>> mtd_ooblayout_get_eccbytes and co
>>> They are very useful to deal with OOB bytes. Everything seems extremely
>>> hardcoded in this driver, while the user can tune read/write OOB
>>> operations.  
>>
>> Thanks for details, IIUC these helpers will work correctly with this driver.
>> What means "tune" here?
> 
> The user can provide data for the OOB part and tell the mtd layer to
> place the bytes in the ->oob_buf following different constraints:
> - the user bytes are already when they need to be (MTD_OPS_PLACE_OOB
>   and MTD_OPS_RAW)
> - the user bytes are packed at the beginning of the buffer, please move
>   them where they belong (MTD_OPS_AUTO_OOB).
> 
> So in the controller driver, what needs to be done is to make the
> switch between the "data1+data2+oob1+oob2" layout into your
> ECC controller's layout, eg "data1+oob1+data2+oob2".

I checked MTD_OPS_AUTO_OOB and MTD_OPS_PLACE_OOB by 'nandwrite' utility (it
has -a option). IIUC everything works as expected, because 'nand_fill_oob()'
performs this switch. 

> 
> Hence you should not need anything like that:
>>>> +		*info |= 0xffff;
> 
>>>>  	}
>>>>  }
>>>>  
>>>> @@ -698,18 +713,92 @@ static int meson_nfc_write_page_raw(struct nand_chip *nand, const u8 *buf,
>>>>  	return meson_nfc_write_page_sub(nand, page, 1);
>>>>  }
>>>>  
>>>> +static u32 meson_nfc_get_oob_bytes(struct nand_chip *nand)
>>>> +{
>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>> +
>>>> +	return mtd->oobsize - nand->ecc.steps * NFC_OOB_PER_ECC(nand);
>>>> +}
>>>> +
>>>> +static int __meson_nfc_write_oob(struct nand_chip *nand, int page, u8 *oob_buf)
>>>> +{
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>> +	u32 page_size = mtd->writesize + mtd->oobsize;
>>>> +	u32 oob_bytes = meson_nfc_get_oob_bytes(nand);
>>>> +	int ret;
>>>> +
>>>> +	if (!oob_bytes)
>>>> +		return 0;
>>>> +
>>>> +	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	memcpy(meson_chip->oob_buf, oob_buf + (mtd->oobsize - oob_bytes),
>>>> +	       oob_bytes);
>>>> +
>>>> +	ret = nand_change_write_column_op(nand, page_size - oob_bytes,
>>>> +					  meson_chip->oob_buf,
>>>> +					  oob_bytes, false);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	return nand_prog_page_end_op(nand);
>>>> +}
>>>> +
>>>> +static int __meson_nfc_read_oob(struct nand_chip *nand, int page,
>>>> +				u8 *oob_buf)
>>>> +{
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>> +	u32 oob_bytes;
>>>> +	u32 page_size;
>>>> +	int ret;
>>>> +
>>>> +	oob_bytes = meson_nfc_get_oob_bytes(nand);
>>>> +
>>>> +	if (!oob_bytes)
>>>> +		return 0;
>>>> +
>>>> +	ret = nand_read_page_op(nand, page, 0, NULL, 0);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	page_size = mtd->writesize + mtd->oobsize;
>>>> +
>>>> +	ret = nand_change_read_column_op(nand, page_size - oob_bytes,
>>>> +					 meson_chip->oob_buf,
>>>> +					 oob_bytes, false);
>>>> +
>>>> +	if (!ret)
>>>> +		memcpy(oob_buf + (mtd->oobsize - oob_bytes),
>>>> +		       meson_chip->oob_buf,
>>>> +		       oob_bytes);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static int meson_nfc_write_page_hwecc(struct nand_chip *nand,
>>>>  				      const u8 *buf, int oob_required, int page)
>>>>  {
>>>>  	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>  	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>  	u8 *oob_buf = nand->oob_poi;
>>>> +	int ret;
>>>>  
>>>>  	memcpy(meson_chip->data_buf, buf, mtd->writesize);
>>>>  	memset(meson_chip->info_buf, 0, nand->ecc.steps * PER_INFO_BYTE);
>>>>  	meson_nfc_set_user_byte(nand, oob_buf);
>>>>  
>>>> -	return meson_nfc_write_page_sub(nand, page, 0);
>>>> +	ret = meson_nfc_write_page_sub(nand, page, 0);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (oob_required)
>>>> +		ret = __meson_nfc_write_oob(nand, page, oob_buf);  
>>>
>>> You should provide all the data including OOB bytes in a single write
>>> call, otherwise you perform two writes on the same page, that's not
>>> what this helper is expected to do.  
>>
>> I see, so I need to check 'oob_required' here before programming page data?
> 
> Yes!
> 
>> If it is set -> place OOB data to DMA buffer and then call PAGEPROG once?
> 
> Exactly.
> 

Commented about this below, but it works good!

>>
>>>   
>>>> +
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>> @@ -783,7 +872,7 @@ static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> -	meson_nfc_get_data_oob(nand, buf, oob_buf);
>>>> +	meson_nfc_get_data_oob(nand, buf, oob_required ? oob_buf : NULL);
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -803,12 +892,12 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> -	meson_nfc_get_user_byte(nand, oob_buf);
>>>>  	ret = meson_nfc_ecc_correct(nand, &bitflips, &correct_bitmap);
>>>>  	if (ret == ECC_CHECK_RETURN_FF) {
>>>>  		if (buf)
>>>>  			memset(buf, 0xff, mtd->writesize);
>>>>  		memset(oob_buf, 0xff, mtd->oobsize);
>>>> +		return bitflips;  
>>>
>>> That is something else => other fix => other patch?  
>>
>> Idea of this 'return' is that when read fails, we return from this function
>> without reading OOB below.
> 
> It seemed like the "return bitflips" thing was new, if it's just due to
> the diff not being wide enough, then it's fine, otherwise if this is
> something new, it should be in a dedicated patch.
> 

I think i can remove it, by checking 'ret' before OOB read below. In this case
when 'ret' has failed status, OOB won't be accessed.

>>
>>>   
>>>>  	} else if (ret < 0) {
>>>>  		if ((nand->options & NAND_NEED_SCRAMBLING) || !buf) {
>>>>  			mtd->ecc_stats.failed++;
>>>> @@ -820,12 +909,14 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
>>>>  
>>>>  		for (i = 0; i < nand->ecc.steps ; i++) {
>>>>  			u8 *data = buf + i * ecc->size;
>>>> -			u8 *oob = nand->oob_poi + i * (ecc->bytes + 2);
>>>> +			u8 *oob = nand->oob_poi + i * NFC_OOB_PER_ECC(nand);
>>>>  
>>>>  			if (correct_bitmap & BIT_ULL(i))
>>>>  				continue;
>>>> +
>>>>  			ret = nand_check_erased_ecc_chunk(data,	ecc->size,
>>>> -							  oob, ecc->bytes + 2,
>>>> +							  oob,
>>>> +							  NFC_OOB_PER_ECC(nand),
>>>>  							  NULL, 0,
>>>>  							  ecc->strength);
>>>>  			if (ret < 0) {
>>>> @@ -839,17 +930,30 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
>>>>  		memcpy(buf, meson_chip->data_buf, mtd->writesize);
>>>>  	}
>>>>  
>>>> +	if (oob_required)
>>>> +		__meson_nfc_read_oob(nand, page, oob_buf);  
>>>
>>> In the standalone "read_oob" hook, you have to send a READ0 command,
>>> but not when you are in the read_page hook. It is a big waste of time.  
>>
>> IIUC approach here must be exactly the same as in write? E.g. i need to
>> send single READ0 and then fill provided OOB buffer if needed?
> 
> Yes.
> 
> For both reads and writes, the logic is:
> - there are commands which are actually time consuming: there is
>   something happening on the nand array which either reads or writes
>   data to/from the internal sram.
> - there are other commands which just change the "pointer" in the
>   internal sram.
> 
> So you can basically say "I want to write into the sram at offset X,
> then at offset Y" and when the sram has been filled you can commit the
> write and that's the operation which should happen only once. In the
> read path it's the opposite, you request a read from the NAND array into
> the sram cache, and you can then request data randomly. Of course both
> operations cannot be too random either, you need to follow the ECC
> engine pattern which must be fed with X bytes of data and then will
> produce the ECC bytes to write/compare.

Thanks for this explanation! Now for example I tried to remove CMD_READ0 command
in OOB read in case when CMD_READ0 was already sent to read page data and it
works! I used 'nand_change_read_column_op()' and IIUC its internal command
CMD_RNDOUT is one of "other command which just change the pointer in the
internal sram" from above. OOB was read successfully without extra CMD_READ0!
The same thing i've implemented for write - 'nand_change_write_column_op()'
is used to send OOB data to internal SRAM, then i call PAGE_PROG and both page
data and OOB are written successfully.

Thanks for this!
 
> 
>>
>>>   
>>>> +
>>>>  	return bitflips;
>>>>  }
>>>>  
>>>>  static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
>>>>  {
>>>> -	return meson_nfc_read_page_raw(nand, NULL, 1, page);
>>>> +	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
>>>>  }
>>>>  
>>>>  static int meson_nfc_read_oob(struct nand_chip *nand, int page)
>>>>  {
>>>> -	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
>>>> +	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
>>>> +}
>>>> +
>>>> +static int meson_nfc_write_oob_raw(struct nand_chip *nand, int page)
>>>> +{
>>>> +	return __meson_nfc_write_oob(nand, page, nand->oob_poi);
>>>> +}
>>>> +
>>>> +static int meson_nfc_write_oob(struct nand_chip *nand, int page)
>>>> +{
>>>> +	return __meson_nfc_write_oob(nand, page, nand->oob_poi);  
>>>
>>> Do we really need these indirections?  
>>
>> Right, I think I can use only one function for OOB write in both ECC and raw modes.
>>
>>>   
>>>>  }
>>>>  
>>>>  static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
>>>> @@ -982,7 +1086,7 @@ static int meson_ooblayout_ecc(struct mtd_info *mtd, int section,
>>>>  	if (section >= nand->ecc.steps)
>>>>  		return -ERANGE;
>>>>  
>>>> -	oobregion->offset =  2 + (section * (2 + nand->ecc.bytes));
>>>> +	oobregion->offset = NFC_USER_BYTES + section * NFC_OOB_PER_ECC(nand);  
>>>
>>> The () are still needed around the '*'
>>>   
>>>>  	oobregion->length = nand->ecc.bytes;
>>>>  
>>>>  	return 0;
>>>> @@ -992,12 +1096,16 @@ static int meson_ooblayout_free(struct mtd_info *mtd, int section,
>>>>  				struct mtd_oob_region *oobregion)
>>>>  {
>>>>  	struct nand_chip *nand = mtd_to_nand(mtd);
>>>> +	u32 oob_bytes = meson_nfc_get_oob_bytes(nand);
>>>>  
>>>>  	if (section >= nand->ecc.steps)
>>>>  		return -ERANGE;
>>>>  
>>>> -	oobregion->offset = section * (2 + nand->ecc.bytes);
>>>> -	oobregion->length = 2;
>>>> +	/* Split rest of OOB area (not covered by ECC engine) per each
>>>> +	 * ECC section. This will be OOB data available to user.
>>>> +	 */
>>>> +	oobregion->offset = (section + nand->ecc.steps) * NFC_OOB_PER_ECC(nand);
>>>> +	oobregion->length = oob_bytes / nand->ecc.steps;
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -1184,6 +1292,9 @@ static int meson_nand_bch_mode(struct nand_chip *nand)
>>>>  
>>>>  static void meson_nand_detach_chip(struct nand_chip *nand)
>>>>  {
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +
>>>> +	kfree(meson_chip->oob_buf);
>>>>  	meson_nfc_free_buffer(nand);
>>>>  }
>>>>  
>>>> @@ -1225,9 +1336,9 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>  	nand->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
>>>>  	nand->ecc.write_page_raw = meson_nfc_write_page_raw;
>>>>  	nand->ecc.write_page = meson_nfc_write_page_hwecc;
>>>> -	nand->ecc.write_oob_raw = nand_write_oob_std;
>>>> -	nand->ecc.write_oob = nand_write_oob_std;
>>>>  
>>>> +	nand->ecc.write_oob_raw = meson_nfc_write_oob_raw;
>>>> +	nand->ecc.write_oob = meson_nfc_write_oob;  
>>>
>>> Actually if you define the right OOB layouts, are these really needed
>>> ?? I would expect the right bytes to be picked up by the default
>>> implementation. I see nothing specific in your current implementation?  
>>
>> You mean to use 'nand_write_oob_std()'? If so, I think it won't work,
>> because it tries to write OOB data right after 'mtd->writesize', but
>> page layout for this controller is like this:
>> [       1024 bytes of data        ]
>> [ 14 bytes ECC + 2 bytes for user ] <- with new layout we don't touch these 2 bytes
>> [       1024 bytes of data        ]
>> [ 14 bytes ECC + 2 bytes for user ] <- with new layout we don't touch these 2 bytes
>> [      32 bytes of user bytes     ] <- we use there 32 bytes as free(user) bytes in OOB
> 
> Right.
> 
>>
>> So with 'mtd->writesize' of 2048 we won't get into last 32 bytes in the picture above.
>> I'm not goot in NAND/MTD area, but I think that why i need special OOB access callbacks.
> 
> Ok.
> 

Ok, so I'll keep these callbacks in the next version.

>> Also in previous patches @Liang said, that default OOB read/write functions won't work
>> on this controller and it is wrong to use them in currently merged driver.
>>
>>>   
>>>>  	nand->ecc.read_page_raw = meson_nfc_read_page_raw;
>>>>  	nand->ecc.read_page = meson_nfc_read_page_hwecc;
>>>>  	nand->ecc.read_oob_raw = meson_nfc_read_oob_raw;
>>>> @@ -1237,9 +1348,16 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>  		dev_err(nfc->dev, "16bits bus width not supported");
>>>>  		return -EINVAL;
>>>>  	}
>>>> +
>>>> +	meson_chip->oob_buf = kmalloc(nand->ecc.bytes, GFP_KERNEL);  
>>>
>>> devm_kmalloc?  
>>
>> Ack
>>
>>>   
>>>> +	if (!meson_chip->oob_buf)
>>>> +		return -ENOMEM;
>>>> +
>>>>  	ret = meson_chip_buffer_init(nand);
>>>> -	if (ret)
>>>> +	if (ret) {
>>>> +		kfree(meson_chip->oob_buf);
>>>>  		return -ENOMEM;
>>>> +	}
>>>>  
>>>>  	return ret;
>>>>  }  
>>>
>>>
>>> Thanks,
>>> Miquèl  
>>
>> Thanks, Arseniy
> 
> 
> Thanks,
> Miquèl
