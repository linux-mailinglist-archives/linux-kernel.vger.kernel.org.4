Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7487287A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjFHTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFHTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:10:13 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073D2D53
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:10:10 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-45f10f5882fso327859e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686251410; x=1688843410;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=8RmpgzePmhDGsPvVp2oYLqxsRKEwxqfRoMHMX6socbI=;
        b=KitawkKPTHPVnZXvnHZTHUd0E1i0xaaKhYpXa7yhJX9B/mL0UjSJB8X6EYmCDcxlGQ
         Vo640vQ+0+uIX7hf6lSIGCuNqo8iXFaQhzQSiMaz9jbtPACKNRPBjrqTUc80xZzMegHc
         Dh0q0GXSAD/j1V2xO276nNF0Iny6CPDKkh2U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251410; x=1688843410;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RmpgzePmhDGsPvVp2oYLqxsRKEwxqfRoMHMX6socbI=;
        b=ibXwPW4xUa1SjdUIz1sMOZ1ts/ou+mTY43ec+Wiwv6I22JoDeMn47NUMCKsGtjujK9
         yAmujp9xB8rvLWfUzy2quuSKTReKRJA5Z/OtTBiVyUR4R7UsbjDCFH+gMmrwhj8Hx0Rr
         NoDcRCQsPJwl3DvmtM9bte88c9/0EQ93wzuOSkbEISfw3Q5fmpSuu37V8UpROOLV81h1
         EDqs7zZUIkV3uIB8IvbiFOfcYPwDz0CB9ciU4EeNwQTzBwnIoNUo635VB/GqwyCJBt8s
         d/8PlRoF3kkKLPhu8K31D5tO2fSRi8GkD1eLPmFH5Qy3PCi+CH73hhMdQZUd2oDcaTVA
         sylg==
X-Gm-Message-State: AC+VfDxORR4rhAJYLtRCRRzMkm8iekvIHPEsivuepfTsm4QlS0Wew+4A
        GY8OidPfeulOPbMSjmb2YRl4lQ==
X-Google-Smtp-Source: ACHHUZ7oQGgeggYmZaV64sF5818Zeo8eELiusmi8HYW/xKlo70KBuvpRAak2Y8blpzS3yNknWnk6sg==
X-Received: by 2002:a1f:db03:0:b0:45f:ed55:4cca with SMTP id s3-20020a1fdb03000000b0045fed554ccamr547939vkg.6.1686251409848;
        Thu, 08 Jun 2023 12:10:09 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a164200b00759322a6089sm539475qko.14.2023.06.08.12.10.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 12:10:08 -0700 (PDT)
Subject: Re: [PATCH 10/12] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230606231252.94838-1-william.zhang@broadcom.com>
 <20230606231252.94838-11-william.zhang@broadcom.com>
 <20230607102232.17c4a27b@xps-13>
 <7b393f47-4053-a8c7-f32e-3881d8130d80@broadcom.com>
 <20230608081821.1de5a50b@xps-13>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <4ab08e3e-3be4-8b8b-6eb8-03a62337f46f@broadcom.com>
Date:   Thu, 8 Jun 2023 12:10:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20230608081821.1de5a50b@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004f4afa05fda300c2"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004f4afa05fda300c2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 06/07/2023 11:18 PM, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Wed, 7 Jun 2023 13:24:23 -0700:
> 
>> Hi Miquel,
>>
>> On 06/07/2023 01:22 AM, Miquel Raynal wrote:
>>> Hi William,
>>>
>>> william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:50 -0700:
>>>    
>>>> The BCMBCA broadband SoC integrates the NAND controller differently than
>>>> STB, iProc and other SoCs.  It has different endianness for NAND cache
>>>> data and ONFI parameter data.
>>>>
>>>> Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
>>>> and performance improvement using the optimized memcpy function on NAND
>>>> cache memory.
>>>>
>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>> ---
>>>>
>>>>    drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 36 +++++++++++++++++
>>>>    drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 44 ++++++++++++++-------
>>>>    drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  2 +
>>>>    3 files changed, 68 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
>>>> index 7e48b6a0bfa2..899103a62c98 100644
>>>> --- a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
>>>> +++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
>>>> @@ -26,6 +26,18 @@ enum {
>>>>    	BCMBCA_CTLRDY		= BIT(4),
>>>>    };
>>>>    >> +#if defined(CONFIG_ARM64)
>>>> +#define ALIGN_REQ		8
>>>> +#else
>>>> +#define ALIGN_REQ		4
>>>> +#endif
>>>> +
>>>> +static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  void *buffer)
>>>> +{
>>>> +	return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
>>>> +				IS_ALIGNED((uintptr_t)flash_cache, ALIGN_REQ);
>>>> +}
>>>> +
>>>>    static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
>>>>    {
>>>>    	struct bcmbca_nand_soc *priv =
>>>> @@ -56,6 +68,29 @@ static void bcmbca_nand_intc_set(struct brcmnand_soc *soc, bool en)
>>>>    	brcmnand_writel(val, mmio);
>>>>    }
>>>>    >> +static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
>>>> +				 void __iomem *flash_cache,  u32 *buffer,
>>>> +				 int fc_words, bool is_param)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	if (!is_param) {
>>>> +		/*
>>>> +		 * memcpy can do unaligned aligned access depending on source
>>>> +		 * and dest address, which is incompatible with nand cache. Fallback
>>>> +		 * to the memcpy for io version
>>>> +		 */
>>>> +		if (bcmbca_nand_is_buf_aligned(flash_cache, buffer))
>>>> +			memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
>>>> +		else
>>>> +			memcpy_fromio((void *)buffer, (void *)flash_cache, fc_words * 4);
>>>> +	} else {
>>>> +		/* Flash cache has same endian as the host for parameter pages */
>>>> +		for (i = 0; i < fc_words; i++, buffer++)
>>>> +			*buffer = __raw_readl(flash_cache + i * 4);
>>>> +	}
>>>> +}
>>>> +
>>>>    static int bcmbca_nand_probe(struct platform_device *pdev)
>>>>    {
>>>>    	struct device *dev = &pdev->dev;
>>>> @@ -75,6 +110,7 @@ static int bcmbca_nand_probe(struct platform_device *pdev)
>>>>    >>   	soc->ctlrdy_ack = bcmbca_nand_intc_ack;
>>>>    	soc->ctlrdy_set_enabled = bcmbca_nand_intc_set;
>>>> +	soc->read_data_bus = bcmbca_read_data_bus;
>>>>    >>   	return brcmnand_probe(pdev, soc);
>>>>    }
>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>> index d920e88c7f5b..656be4d73016 100644
>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>> @@ -814,6 +814,30 @@ static inline u32 edu_readl(struct brcmnand_controller *ctrl,
>>>>    	return brcmnand_readl(ctrl->edu_base + offs);
>>>>    }
>>>>    >> +static inline void brcmnand_read_data_bus(struct brcmnand_controller *ctrl,
>>>> +					   void __iomem *flash_cache, u32 *buffer,
>>>> +					   int fc_words, bool is_param)
>>>> +{
>>>> +	struct brcmnand_soc *soc = ctrl->soc;
>>>> +	int i;
>>>> +
>>>> +	if (soc->read_data_bus) {
>>>> +		soc->read_data_bus(soc, flash_cache, buffer, fc_words, is_param);
>>>> +	} else {
>>>> +		if (!is_param) {
>>>> +			for (i = 0; i < fc_words; i++, buffer++)
>>>> +				*buffer = brcmnand_read_fc(ctrl, i);
>>>> +		} else {
>>>> +			for (i = 0; i < fc_words; i++)
>>>> +				/*
>>>> +				 * Flash cache is big endian for parameter pages, at
>>>> +				 * least on STB SoCs
>>>> +				 */
>>>> +				buffer[i] = be32_to_cpu(brcmnand_read_fc(ctrl, i));
>>>> +		}
>>>> +	}
>>>
>>> Perhaps we could have a single function that is statically assigned at
>>> probe time instead of a first helper with two conditions which calls in
>>> one case another hook... This can be simplified I guess.
>>>    
>> Well this will need to be done at the SoC specific implementation level (bcm<xxx>_nand.c) and each SoC will need to have either general data bus read func with is_param option or data_bus_read_page, data_bus_read_param.
> 
> You told me in case we would use exec_op we could avoid the param
> cache. If that's true then the whole support can be simplified.
> 
Correct we may possibly unified the parameter data read but exec_op is 
long shot and we are not fully ready for that yet. It also depends on if 
the low level data register has endianess difference for the parameter 
data between difference SoCs.

So I would like to push the current implementation and we can explore 
the exec_op option late which will be a much big and complete different 
implementation.

>>   Not sure how much this can be simplified... Or we have default
>> implementation in brcmnand.c but then there is one condition check
>> too. Page read is done at 512 bytes burst. One or two conditions
>> check outside of the per 512 bytes read loop does not sounds too bad
>> if performance is concern.
> 
> It is unreadable. That is my main concern.
> 
>>
>>>> +}
>>>> +
>>>>    static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
>>>>    {
>>>>    >> @@ -1811,20 +1835,11 @@ static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
>>>>    			native_cmd == CMD_PARAMETER_CHANGE_COL) {
>>>>    		/* Copy flash cache word-wise */
>>>>    		u32 *flash_cache = (u32 *)ctrl->flash_cache;
>>>> -		int i;
>>>>    >>   		brcmnand_soc_data_bus_prepare(ctrl->soc, true);
>>>>    >> -		/*
>>>> -		 * Must cache the FLASH_CACHE now, since changes in
>>>> -		 * SECTOR_SIZE_1K may invalidate it
>>>> -		 */
>>>> -		for (i = 0; i < FC_WORDS; i++)
>>>> -			/*
>>>> -			 * Flash cache is big endian for parameter pages, at
>>>> -			 * least on STB SoCs
>>>> -			 */
>>>> -			flash_cache[i] = be32_to_cpu(brcmnand_read_fc(ctrl, i));
>>>> +		brcmnand_read_data_bus(ctrl, ctrl->nand_fc, flash_cache,
>>>> +				   FC_WORDS, true);
>>>>    >>   		brcmnand_soc_data_bus_unprepare(ctrl->soc, true);
>>>>    >> @@ -2137,7 +2152,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
>>>>    {
>>>>    	struct brcmnand_host *host = nand_get_controller_data(chip);
>>>>    	struct brcmnand_controller *ctrl = host->ctrl;
>>>> -	int i, j, ret = 0;
>>>> +	int i, ret = 0;
>>>>    >>   	brcmnand_clear_ecc_addr(ctrl);
>>>>    >> @@ -2150,8 +2165,9 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
>>>>    		if (likely(buf)) {
>>>>    			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
>>>>    >> -			for (j = 0; j < FC_WORDS; j++, buf++)
>>>> -				*buf = brcmnand_read_fc(ctrl, j);
>>>> +			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf,
>>>> +					FC_WORDS, false);
>>>> +			buf += FC_WORDS;
>>>>    >>   			brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
>>>>    		}
>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>>>> index f1f93d85f50d..88819bc395f8 100644
>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>>>> @@ -24,6 +24,8 @@ struct brcmnand_soc {
>>>>    	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
>>>>    	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
>>>>    				 bool is_param);
>>>> +	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flash_cache,
>>>> +				 u32 *buffer, int fc_words, bool is_param);
>>>>    	const struct brcmnand_io_ops *ops;
>>>>    };
>>>>    > >
>>> Thanks,
>>> Miquèl
>>>    
> 
> 
> Thanks,
> Miquèl
> 

--0000000000004f4afa05fda300c2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAPpPMRr2p0aZj3yX+9ZXAYrXPDy
+iY860gYUczwvvALMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYwODE5MTAxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQC6DLYmQIl0I4kCHvWJReahlVh29lQzrl9shku3rrTt3ovd
j1hsbAlHTEhxL/L9yZgXVkgt+WKBU7ayW412opgvJi8zoSwYY2MqnwkKdhY4gIwledi/yXSRV5bw
7+KkNVrywM2GmTcPdkus7SuBPtn7P210TK7SoJg4JQAyiorCeJJvIeetG5rIOR5PH5SDdSN7ZxPO
BnTqFfB2rwJUmIxoLAHszbmPSxszMTdx+82LiB+jrg9UmyrLGeF9SW10pPhZT7deqA3KV+4aCQPB
Gs5PrfAqFumBU8Jgt0qe1uQBUGNu15pjUwMZgH/Lh9AY3CXXZloAZVQ3oztYaZe27X3P
--0000000000004f4afa05fda300c2--
