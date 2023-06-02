Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94B71FCDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjFBI6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjFBI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:58:40 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21EC1A5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:58:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5221A5FD1C;
        Fri,  2 Jun 2023 11:58:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685696313;
        bh=abiYipTV/jxNc17GoV9ECjJl5Hlx1HubTOYRAwX0rvo=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=nQx/ELG7ta2SBY+irKdO2u0rW2+Yh+ZBcYpzWWjhnmHXn6vEewxEhyeLDRQFgv/O3
         4KjSpRv2zu4XqR74QqpRwOeUO/5KryT8dfFsVJX2kzDFHvn5ezk7HF0WWSkZbWaNCz
         +7TYO8hpgaaRKZu4M/J/gFpwNbO/aOZBhDRxVnU0Fmu3e9HBIy/lCE9RCJyMtG3ZvK
         sTfJlFvdLkCN1LhFh0X44FlDqrNOAdl1/NMG4ymbSmhP8RWrnRmiEknTuofY3oVlRF
         zbLoWIX0Z/op3Sgpl5wM5FqvY5GOudQAAJdv8XYI6h7HbvjThheLyI8j1QGSOHsClA
         6U0YhbRMSBRtg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Jun 2023 11:58:31 +0300 (MSK)
Message-ID: <8242530c-7b6b-29ce-581b-c5644a965b60@sberdevices.ru>
Date:   Fri, 2 Jun 2023 11:53:47 +0300
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
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230601103111.6840acc0@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/02 03:06:00 #21401484
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

Hello Miquel, thanks for review!

On 01.06.2023 11:31, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:46 +0300:
> 
>> This moves free bytes of OOB to non-protected ECC area. It is needed to
> 
> As we discussed, I expect this commit to just change the OOB layout to
> expose unprotected OOB bytes to the user, that is the only change this
> commit should carry. If that does not work, you should add a
> preparation patch.

Ok, but I thought, if i change only OOB layout, e.g. update 'free' callback of
mtd_ooblayout_ops, I also need to implement code which performs read/write
according new layout (it must be done in a single patch)?

Main thing is:

I guess that general confuse with this patch is that You consider
that we change only OOB layout by moving user bytes out of ECC area, but at the same
time I also increased size of OOB from 4 bytes (e.g. 2 x 2 bytes clean markers)
to 32 bytes (e.g. tail of page after data and ECC codes), so if this
assumption is correct, in the next version I won't change size of user area in
OOB, thus this patch will be reduced as some comments from this review.

> 
>> make JFFS2 works correctly with this NAND controller. Problem fires when
>> JFFS2 driver writes cleanmarker to some page and later it tries to write
>> to this page - write will be done successfully, but after that such page
>> becomes unreadable due to invalid ECC codes. This happens because second
>> write needs to update ECC codes, but it is impossible to do it correctly
>> without block erase. So idea of this patch is to use the unprotected OOB
>> area to store the cleanmarkers, so that they can be written by the
>> filesystem without caring much about the page being empty or not: the
>> ECC codes will not be written anyway.
>>
>> JFFS2 is only useful on tiny NAND devices, where UBI does not fit, which
>> are usually true SLC flashes, with the capability of writing a page with
>> empty (0xFF) data, and still be able to write actual data to it later in
>> a second write.
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  Changelog v4->v5:
>>  * Drop cosmetic changes from this patch.
>>  * Do not ignore ECC protected user bytes provided by hw. Even these
>>    bytes are out of user area of OOB, its values are still read from
>>    the provided OOB buffer and written by hardware. Same behaviour is
>>    preserved for read access - such bytes are read from DMA buffer and
>>    placed to OOB buffer.
>>  * OOB read and write become more lightweight because I removed heavy
>>    READ0 and PAGEPROG command from it (both commands are still sent
>>    when OOB access is performed using OOB callbacks). In case of page
>>    read/write OOB data is handled in the internal SRAM of the controller.
>>  * Commit message updated.
>>  * Temporary buffer for OOB read/write is removed. Seems everything
>>    works correctly without it.
>>
>>  drivers/mtd/nand/raw/meson_nand.c | 134 ++++++++++++++++++++++++++----
>>  1 file changed, 117 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 82a629025adc..e42c28be02f3 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -358,8 +358,11 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
>>  static void meson_nfc_get_data_oob(struct nand_chip *nand,
>>  				   u8 *buf, u8 *oobbuf)
>>  {
>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>  	int i, oob_len = 0;
>>  	u8 *dsrc, *osrc;
>> +	u8 *oobtail;
>>  
>>  	oob_len = nand->ecc.bytes + 2;
>>  	for (i = 0; i < nand->ecc.steps; i++) {
>> @@ -368,17 +371,27 @@ static void meson_nfc_get_data_oob(struct nand_chip *nand,
>>  			memcpy(buf, dsrc, nand->ecc.size);
>>  			buf += nand->ecc.size;
>>  		}
>> +
>>  		osrc = meson_nfc_oob_ptr(nand, i);
>>  		memcpy(oobbuf, osrc, oob_len);
>>  		oobbuf += oob_len;
>>  	}
>> +
>> +	oobtail = meson_chip->data_buf + nand->ecc.steps *
>> +		  (nand->ecc.size + oob_len);
>> +
>> +	/* 'oobbuf' points to the start of user area. */
>> +	memcpy(oobbuf, oobtail, mtd->oobsize - nand->ecc.steps * oob_len);
>>  }
>>  
>>  static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>  				   const u8 *buf, u8 *oobbuf)
>>  {
>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>  	int i, oob_len = 0;
>>  	u8 *dsrc, *osrc;
>> +	u8 *oobtail;
>>  
>>  	oob_len = nand->ecc.bytes + 2;
>>  	for (i = 0; i < nand->ecc.steps; i++) {
>> @@ -391,6 +404,12 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>  		memcpy(osrc, oobbuf, oob_len);
>>  		oobbuf += oob_len;
>>  	}
>> +
>> +	oobtail = meson_chip->data_buf + nand->ecc.steps *
>> +		  (nand->ecc.size + oob_len);
> 
> This is always targeting the same area, so it looks strange to me.
> 
>> +
>> +	/* 'oobbuf' points to the start of user area. */
>> +	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);
> 
> TBH I don't get what you do here.

This code works in raw mode and places OOB data from provided OOB buffer to DMA buffer.
This is because number of user bytes is increased in this patch.

> 
>>  }
>>  
>>  static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
>> @@ -433,7 +452,7 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>  	__le64 *info;
>>  	int i, count;
>>  
>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
>>  		info = &meson_chip->info_buf[i];
>>  		*info |= oob_buf[count];
>>  		*info |= oob_buf[count + 1] << 8;
>> @@ -446,7 +465,7 @@ static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>  	__le64 *info;
>>  	int i, count;
>>  
>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
>>  		info = &meson_chip->info_buf[i];
>>  		oob_buf[count] = *info;
>>  		oob_buf[count + 1] = *info >> 8;
>> @@ -638,6 +657,84 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>  	return 0;
>>  }
>>  
>> +static u32 meson_nfc_oob_free_bytes(struct nand_chip *nand)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +
>> +	return mtd->oobsize - nand->ecc.steps * (nand->ecc.bytes + 2);
> 
> This looks like a static value, just save it somewhere instead of
> recomputing it?

Ack

> 
>> +}
>> +
>> +static int meson_nfc_write_oob(struct nand_chip *nand, int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	u32 page_size = mtd->writesize + mtd->oobsize;
>> +	u32 oob_bytes = meson_nfc_oob_free_bytes(nand);
>> +	u8 *oob_buf;
>> +	int ret;
>> +
>> +	if (!oob_bytes)
>> +		return 0;
> 
> Can this happen?

Ack, seems forget to remove it

> 
>> +
>> +	/* Called as OOB write helper, will send NAND_CMD_PAGEPROG. */
>> +	if (page != -1) {
>> +		ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	oob_buf = nand->oob_poi;
>> +
>> +	ret = nand_change_write_column_op(nand, page_size - oob_bytes,
>> +					  oob_buf + (mtd->oobsize - oob_bytes),
>> +					  oob_bytes, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return (page != -1) ? nand_prog_page_end_op(nand) : 0;
>> +}
>> +
>> +static int meson_nfc_read_oob(struct nand_chip *nand, int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	u8 *oob_buf = nand->oob_poi;
>> +	u32 oob_bytes;
>> +	u32 page_size;
>> +	int ret;
>> +	int i;
>> +
>> +	/* Called as OOB read helper, send NAND_CMD_READ0. */
>> +	if (page != -1) {
> 
> I don't like this logic with the "-1", it really hides what the
> controller needs to do, if you need a helper to send a command, then
> create that helper and give it a decent name.

I see, so I think I need to implement this in the following way:
1) For OOB callback it always sends NAND_CMD_READ0 (e.g. without any 'if')
2) For read OOB with data page we don't need to send NAND_CMD_READ0. (also without any 'if')

> 
>> +		ret = nand_read_page_op(nand, page, 0, NULL, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Read ECC codes and user bytes. */
>> +	for (i = 0; i < nand->ecc.steps; i++) {
>> +		u32 ecc_offs = nand->ecc.size * (i + 1) +
>> +			       (nand->ecc.bytes + 2) * i;
>> +
>> +		ret = nand_change_read_column_op(nand, ecc_offs,
>> +						 oob_buf + i * (nand->ecc.bytes + 2),
>> +						 (nand->ecc.bytes + 2), false);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	oob_bytes = meson_nfc_oob_free_bytes(nand);
>> +
>> +	if (!oob_bytes)
>> +		return 0;
>> +
>> +	page_size = mtd->writesize + mtd->oobsize;
>> +
>> +	ret = nand_change_read_column_op(nand, page_size - oob_bytes,
>> +					 oob_buf + (mtd->oobsize - oob_bytes),
>> +					 oob_bytes, false);
>> +
>> +	return ret;
>> +}
>> +
>>  static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>  				    int page, int raw)
>>  {
>> @@ -674,6 +771,12 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>  				     NFC_CMD_SCRAMBLER_DISABLE);
>>  	}
>>  
>> +	if (!raw) {
> 
> Why this check?
> 
> You should instead propagate the oob_required field and check that
> value I believe.


This check is for ECC mode, because in this mode we write user bytes of OOB.
ECC bytes of OOB are written by hardware. I think I made a mistake, because
I need new callback to write OOB in raw mode - it will write both ECC and user
parts, in current version I write only user part in raw mode.

> 
>> +		ret = meson_nfc_write_oob(nand, -1);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
>> @@ -834,17 +937,10 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
>>  		memcpy(buf, meson_chip->data_buf, mtd->writesize);
>>  	}
>>  
>> -	return bitflips;
>> -}
>> -
>> -static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
>> -{
>> -	return meson_nfc_read_page_raw(nand, NULL, 1, page);
>> -}
>> +	if (oob_required && ret)
> 
> Unclear why you check ret here?
> 

If read was successful, we read OOB. If not - there is no sense in it.

>> +		meson_nfc_read_oob(nand, -1);
>>  
>> -static int meson_nfc_read_oob(struct nand_chip *nand, int page)
>> -{
>> -	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
>> +	return bitflips;
>>  }
>>  
>>  static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
>> @@ -987,12 +1083,16 @@ static int meson_ooblayout_free(struct mtd_info *mtd, int section,
>>  				struct mtd_oob_region *oobregion)
>>  {
>>  	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	u32 oob_bytes = meson_nfc_oob_free_bytes(nand);
>>  
>>  	if (section >= nand->ecc.steps)
>>  		return -ERANGE;
>>  
>> -	oobregion->offset = section * (2 + nand->ecc.bytes);
> 
> The first two bytes of OOB are reserved for the bad block markers. This
> is not related to your controller.

I think first two bytes (in fact there are 4 bytes at positions 0, 1, 16 and 17)
is considered by hardware as user bytes covered by ECC.

Thanks, Arseniy

> 
>> -	oobregion->length = 2;
>> +	/* Split rest of OOB area (not covered by ECC engine) per each
>> +	 * ECC section. This will be OOB data available to user.
>> +	 */
>> +	oobregion->offset = (section + nand->ecc.steps) * (2 + nand->ecc.bytes);
> 
> This is not possible, see above.
> 
>> +	oobregion->length = oob_bytes / nand->ecc.steps;
>>  
>>  	return 0;
>>  }
>> @@ -1220,12 +1320,12 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>  	nand->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
>>  	nand->ecc.write_page_raw = meson_nfc_write_page_raw;
>>  	nand->ecc.write_page = meson_nfc_write_page_hwecc;
>> -	nand->ecc.write_oob_raw = nand_write_oob_std;
>> -	nand->ecc.write_oob = nand_write_oob_std;
>>  
>> +	nand->ecc.write_oob_raw = meson_nfc_write_oob;
>> +	nand->ecc.write_oob = meson_nfc_write_oob;
>>  	nand->ecc.read_page_raw = meson_nfc_read_page_raw;
>>  	nand->ecc.read_page = meson_nfc_read_page_hwecc;
>> -	nand->ecc.read_oob_raw = meson_nfc_read_oob_raw;
>> +	nand->ecc.read_oob_raw = meson_nfc_read_oob;
>>  	nand->ecc.read_oob = meson_nfc_read_oob;
>>  
>>  	if (nand->options & NAND_BUSWIDTH_16) {
> 
> 
> Thanks,
> Miquèl
