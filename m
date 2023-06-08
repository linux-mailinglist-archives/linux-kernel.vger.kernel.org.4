Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF84728794
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjFHTEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjFHTEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:04:30 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535652D40
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:04:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75d461874f4so89372085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686251068; x=1688843068;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=qHfFx6jroqQ2ueGz0JggOQZTcNbcNzUJiGr/icFcBu0=;
        b=VBvHx03jAz7NZHC4C97YzzTmAVmeHhVPyzOMVqdcA1sOgSG6fFcuGZCA8UprTf+4am
         E5/acKH+gJIvUDnpb4xxpfWJzwqumE8keVnZENZHGC9PybfL+wmWj3SRksz8lfTvwX6h
         PkDzQiC6YvbU0tdw5C/MEuQOckPQd4LRHR39s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251068; x=1688843068;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHfFx6jroqQ2ueGz0JggOQZTcNbcNzUJiGr/icFcBu0=;
        b=LaO1FUe2OTMFNm34pTyTd4GXGThOTT0f2railMuzr9boBi2b5kWYttfHzwSqdvmoVe
         3IKl1nE7Uv4ydD8t9jQ2z/e2d+ZZTx2YUHDOGCXC4rORBI9ACxrzxMTbbgus8H2mHs8f
         qs7IpMZ5+30FTalgSXbnpH/hxPoWwm6KdXCg0rAHO0cMSTU2D3pHqa5rwQddRjSrGmrN
         +jREkpUfsd4fmtPTRRTq750IeBCX2oPoolWH73ohQ15hSkrWk+ke1XigqgDbdTF7bRJL
         CyXRUiDbsmrZkGYDrjvzbMvSJTk1CJjU39AoFXBN0RO+nwotJbHAnVcbq94Vs0Ick0Fs
         pL6Q==
X-Gm-Message-State: AC+VfDwnzTOIUGnyj7rWs5WVjmW9gn2Rf0H/ezKIweuPEefX7WgZLe+E
        J+u+pspKyJCoUVmk61QFVTqY5Q==
X-Google-Smtp-Source: ACHHUZ5pICso17qZNT4RBAimbdoI0G37Qwb6m41WlFLWQBFZUkzqYHIYTYGkqT9A2V6vJenFXj+gWw==
X-Received: by 2002:a05:620a:2055:b0:75e:c64c:9653 with SMTP id d21-20020a05620a205500b0075ec64c9653mr6807345qka.60.1686251068363;
        Thu, 08 Jun 2023 12:04:28 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b007590aa4b115sm526055qkg.87.2023.06.08.12.04.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 12:04:26 -0700 (PDT)
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
 <20230607102056.5b1bfa5b@xps-13>
 <11a7132c-7f10-ee47-0a23-d444ed29d980@broadcom.com>
 <20230608081512.52fa07fb@xps-13>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <57e2977a-7046-c49d-4bf4-0486d38a0f12@broadcom.com>
Date:   Thu, 8 Jun 2023 12:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20230608081512.52fa07fb@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f41ab405fda2eb05"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f41ab405fda2eb05
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 06/07/2023 11:15 PM, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Wed, 7 Jun 2023 13:12:02 -0700:
> 
>> Hi Miquel,
>>
>> On 06/07/2023 01:20 AM, Miquel Raynal wrote:
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
>>>
>>> I strongly dislike this "is_param" boolean.
>>>
>>> When is the data in host endianness? When is it not?
>> This is little bit complicated.  We have two type data read from nand cache. One for page read and the other for parameter and onfi data read from the controller side. But it depends on how SoC integrate the nand cache to system. In broadband SoC, both page and parameter data are in host endianess but other SoCs is not the same.
>>
>> I am open to suggestion for is_param function argument but to factor out this common code in more structured way, I don't see other way around.
> 
> Alright, so this is SoC dependent, very well -> a (sub)compatible per
> SoC + platform data associated to it with the right function.
> 
Right we have per SoC compatible and can have per SoC implementation but 
I prefer to have a default implementation in the brcmnand.c because 
right now only bcmcba SoC need some different handling. The other four 
implementations are the same.

To make the code a little more readable and less complicated,  I am 
thinking to separate the brcmnand_read_data_bus into 
brcmnand_read_page_data and brcmnand_read_param_data as default in 
brcmnand.c. But bcmbca will override them. Would that be okay with you?

>>> If we think about an exec_op() conversion and drop cmdfunc(), what
>>> would be the discriminant?
>>>    
>> If we need to implement exec_op in the future,  the data is not coming from nand cache but some other low level data register which may not subject to the endianess issue.
> 
> Can't you use the same cache all the time here as well then? And avoid
> the need for this overly complex logic?
> 
Unfortunately exec_op will not use nand cache for parameter data read 
but some other low level data register. This is dictated by the controller.

>>
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

--000000000000f41ab405fda2eb05
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJEzHKT9CYKqfEnZaaeo4jZewc2U
+5qhtk/sSz93LwMJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYwODE5MDQyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBExhvpaSLaGQXIJ5o5LeCxE10nLFXVy+HGWrAqTCeKISv7
ai9VyY6fxXdVSnlYJGJepmU6GNCviEZPgOaOWosDTBBckE06tF8f926Bhmyp6CYtTtXpH1EZ2H22
N/XmcbR2hQZC+MYawfVKnHuvGk18uoj3KUeAHsoahlFohB6x6rI54c5/MhtussU2K9uZQukUQ1Mz
F1WPq++Yvnamr3YZc9bW5ZkIa0qBigzdH6sLH4XZEqhH8WUP6A2s645El0EVQI/4iil+Mt7hidpI
lUZkPLts0+2eee7eCFBN6/pSGfsHq0xepd/HFqZ/ypINiJPYxIntdZ9BnroCXsLZgKTh
--000000000000f41ab405fda2eb05--
