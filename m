Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD93747ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGEAug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:50:33 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822910D5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:50:32 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c4e4c258ba9so3859620276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 17:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1688518232; x=1691110232;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=+v9IDPZWjJ4VWAyg2+HlN6MMs3iQJ76LtXDfbdbC71E=;
        b=NvrSbUooMBSpU0XfJ9pxDJm6K1EBEMCcvAcHN4onIria85k7lwhSmBompycBo4NZ+A
         hJtf0DQZ2OgyUhSKD3XtYl6f/3PUtcumCkV1Zt4PqlzRtCbKC5zVfkUJjZO6CcrT1usT
         LTVxkAELqHAWy1jBhvvb52JFpbiW1/48gpDvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688518232; x=1691110232;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+v9IDPZWjJ4VWAyg2+HlN6MMs3iQJ76LtXDfbdbC71E=;
        b=LPInCy0DIDJ+7Hk6Mho7iGyz3/ccTfR1qWLWD45nFImtlGEZc3Q+vk/caxaVlEoi5b
         jt4Ay1Md9es2d2Jcv0iWG3m0jfGy1fhw7G9s2FiW9NOUEvd3LpfmfnqHKt7uvr6qYJbS
         8TFg3Fzs6Uxt9rkuxDUdXWTSkN91uCa0SjhaCYkksVMjmqJJGCpFyAkMDf+N9jDQ1nD7
         nroRPkmGwGCT9GvU6sy8rLOjJ7foIOW5PYnJrdXRouL4YkaUHRDALYO0C8hx4U4w3EJG
         NFDlBe3l8jAXsIx88wlI4cPo/UiMsv18i+DDfxZ8cvQeFPZTf/ax71esV+bIZ+FzKv1u
         YsSw==
X-Gm-Message-State: ABy/qLYWoDmFu91jIglHFRn3nayAtQNUs7sLJ7/3NBe3e31ba3gNHcNn
        RRnav55yHs2qy1es5X6IINRr4w==
X-Google-Smtp-Source: APBJJlGAc60/2YEs/wXzZRs6nCS/lBtVnqS5iKEir74yVGwdsJUOt8Z6sDCnz1eou+jBwNCC3IMoeQ==
X-Received: by 2002:a05:6902:28c:b0:c37:f855:cff4 with SMTP id v12-20020a056902028c00b00c37f855cff4mr12465761ybh.63.1688518231690;
        Tue, 04 Jul 2023 17:50:31 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id et11-20020a056214176b00b0063596878aaasm12235385qvb.18.2023.07.04.17.50.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jul 2023 17:50:30 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] mtd: rawnand: brcmnand: Fix mtd oobsize
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
 <20230627193738.19596-6-william.zhang@broadcom.com>
 <20230704173047.395e445e@xps-13>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <c09a72df-c49f-75e9-e95e-4e19fe10a278@broadcom.com>
Date:   Tue, 4 Jul 2023 17:50:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20230704173047.395e445e@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006b22c905ffb2c913"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006b22c905ffb2c913
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 07/04/2023 08:30 AM, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:38 -0700:
> 
>> brcmnand controller can only access the flash spare area up to certain
>> bytes based on the ECC level. It can be less than the actual flash spare
>> area size. For example, for many NAND chip supporting ECC BCH-8, it has
>> 226 bytes spare area. But controller can only uses 218 bytes. So brcmand
>> driver overrides the mtd oobsize with the controller's accessible spare
>> area size. When the nand base driver utilizes the nand_device object, it
>> resets the oobsize back to the actual flash spare aprea size from
>> nand_memory_organization structure and controller may not able to access
>> all the oob area as mtd advises.
>>
>> This change fixes the issue by overriding the oobsize in the
>> nand_memory_organization structure to the controller's accessible spare
>> area size.
> 
> I am clearly not a big fan of this solution. memorg should be and
> remain a read only object. Can you please find another solution?
> 
I was debating on this too but I don't see option because there is no 
other hooks after nanddev_init to set the mtd->oobsize as far as I can 
see and I see there were similar fixes for other controller drivers 
after the nand device object init was committed, for example:
Fixes: 629a442cad5f ("mtd: rawnand: Fill memorg during detection")

I will think through this again but I am open to any suggestion.

>>
>> Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> index 407bf79cbaf4..39c7f547db1f 100644
>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> @@ -2647,6 +2647,8 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
>>   	struct nand_chip *chip = &host->chip;
>>   	const struct nand_ecc_props *requirements =
>>   		nanddev_get_ecc_requirements(&chip->base);
>> +	struct nand_memory_organization *memorg =
>> +		nanddev_get_memorg(&chip->base);
>>   	struct brcmnand_controller *ctrl = host->ctrl;
>>   	struct brcmnand_cfg *cfg = &host->hwcfg;
>>   	char msg[128];
>> @@ -2668,10 +2670,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
>>   	if (cfg->spare_area_size > ctrl->max_oob)
>>   		cfg->spare_area_size = ctrl->max_oob;
>>   	/*
>> -	 * Set oobsize to be consistent with controller's spare_area_size, as
>> -	 * the rest is inaccessible.
>> +	 * Set mtd and memorg oobsize to be consistent with controller's
>> +	 * spare_area_size, as the rest is inaccessible.
>>   	 */
>>   	mtd->oobsize = cfg->spare_area_size * (mtd->writesize >> FC_SHIFT);
>> +	memorg->oobsize = mtd->oobsize;
>>   
>>   	cfg->device_size = mtd->size;
>>   	cfg->block_size = mtd->erasesize;
> 
> 
> Thanks,
> Miquèl
> 

--0000000000006b22c905ffb2c913
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG+qrrktL4FJ2PMSZq9CDI/E0HJM
vY2omOg1CZDy6jmVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDcwNTAwNTAzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBCRjFlpA0b4QD6Z31cikJvWfh4LaNJ0e1iPRjmCDlA4uUy
dgvfgfzkpNJ8spXUGurCE8HNncWT8re91XkVUmm+V8aWFOdxIAGyYkW1IFIb9GTHVhecBMiNdfcA
WYtBhXGm+UXhmUe6t+AXS22XeCQFD5Vl8w73mIskQkuoQDUxP617zd60hhWsSyMm0/sG7ehrZc8Y
ny9E3+ysWNlgsMibP+tI2eMtcuPKB/0H5rUCFsSkVpntyirratb7B0AilzE5CPdiFXtE6Yvee0Xs
dgmoMGiEUxajbljp+UINsfSW8UvsgTbeztRtgrMetTicqDFvK61r/LXI6OC0hbgP9F84
--0000000000006b22c905ffb2c913--
