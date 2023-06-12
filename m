Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58E72CF3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjFLTTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjFLTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:19:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B423B0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:19:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75d54faa03eso22223685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686597542; x=1689189542;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=bLK0Z6wcJdLdrE5mWg9KDy8duuwhqNJ88PLjSIZy0cw=;
        b=fuf8xROhKLN7FYzZj78C4/RgS4buo/xAVv44FGPnE+f/ZkGgbEh3fBVDpMiEOP3cam
         gW7NBjJaI+hTcJO/6IIBRNeK2fdRpq9wOac1RPKC4xTa2/yy008hZBQyqri4ujv4jGK2
         k7rrBdPSLbfibaIGtvJpN0vGaRKO0H3Cbsw5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686597542; x=1689189542;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLK0Z6wcJdLdrE5mWg9KDy8duuwhqNJ88PLjSIZy0cw=;
        b=M6s+gVXPODYi4E/+r5iNkPP1MRnKsPFbNZpv+n5z9TBXGvXy4kAIIGG/k62BSoS4Zo
         5K95elxQjrycj+MhcHvfiSl9xdXIL8MT57hPqMkAwwNDXu4MBNPEwkZukKVxzGkyzpO9
         68Qk0JgYxzdqlzp8JL+bGb2HI21jElXYp0oOZID9Kk+PxrE/VgS9EG6R9Jwp284f2dT2
         q+erfoWAb/kN3m+QDyeq+JHvorvPBQbTRo3L1fHQi6YKD05RxKZovcOzlsIMp+TdCX0e
         QyJeJ2oYoUwjwt0iYFF3DAPGkHY7N9DGLq260v1Qg5V6bwS9doOhX0avUqMNuy23H6E0
         SLtA==
X-Gm-Message-State: AC+VfDy1erLcVacYXBYmEmp5Em3EtbQ9xuSYFRRdtfWXYqsbzeotx/Ew
        37JuA9YcBOFXRX5oAMCka37z6w==
X-Google-Smtp-Source: ACHHUZ7wHVg85VB5aDCqc6FINLuHDpJBbpgJe577f3y5yDgx1BV7L1KCQVR2S8bzyZyT0sPjX6o+7g==
X-Received: by 2002:a05:620a:28c4:b0:760:97ef:cf5b with SMTP id l4-20020a05620a28c400b0076097efcf5bmr2523039qkp.49.1686597542116;
        Mon, 12 Jun 2023 12:19:02 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a13ca00b007606a26988dsm1435515qkl.73.2023.06.12.12.18.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2023 12:19:00 -0700 (PDT)
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
 <4ab08e3e-3be4-8b8b-6eb8-03a62337f46f@broadcom.com>
 <20230609103544.0f00f799@xps-13>
 <3d3b471b-c555-ee1c-96d6-c04d76979e76@broadcom.com>
 <20230612194908.5465bc56@xps-13> <20230612195305.4b097c46@xps-13>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <da4cb6a6-aa7d-3747-3f64-19b5582b15e8@broadcom.com>
Date:   Mon, 12 Jun 2023 12:18:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20230612195305.4b097c46@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000065831905fdf39765"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000065831905fdf39765
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 06/12/2023 10:53 AM, Miquel Raynal wrote:
> Hello again,
> 
>>>>>>>> Perhaps we could have a single function that is statically assigned at
>>>>>>>> probe time instead of a first helper with two conditions which calls in
>>>>>>>> one case another hook... This can be simplified I guess.
>>>>>>>>      >> Well this will need to be done at the SoC specific implementation level (bcm<xxx>_nand.c) and each SoC will need to have either general data bus read func with is_param option or data_bus_read_page, data_bus_read_param.
>>>>>>
>>>>>> You told me in case we would use exec_op we could avoid the param
>>>>>> cache. If that's true then the whole support can be simplified.
>>>>>>     >> Correct we may possibly unified the parameter data read but exec_op is long shot and we are not fully ready for that yet. It also depends on if the low level data register has endianess difference for the parameter data between difference SoCs.
>>>>>
>>>>> So I would like to push the current implementation and we can explore the exec_op option late which will be a much big and complete different implementation.
>>>>
>>>> I am sorry but this series is totally backwards, you're trying to guess
>>>> what comes next with the 'is_param' thing, it's exactly what we are
>>>> fighting against since 2017. There are plenty of ->exec_op()
>>>> conversions out there, I don't believe this one will be harder. You
>>>> need to convert the driver to this new API and get rid of this whole
>>>> endianness non-sense to simplify a lot the driver.
>>>>    
>>> I am not guessing anything but just factor out the existing common nand cache read logic into the single default function(or one for page read and another for parameter read as I mentioned in another thread) and allow SoC to overrides the implementation when needed.
>>
>> No, you are trying to guess what type of read the core is performing,
>> either a regular data page read or a parameter page read.
>>
>>> I agree ->exec_op can possibly get rid of the parameter page read function and is the way to go. But it won't help on the page read for endianess.
>>
>> You told me there is no endianess issue with the data pages, so why it
>> won't help on the page read?
>>
>>> It's not that I am against exec_op but I want to take one step a time
>>> and I'd like to get these fixes
>>
>> I don't see any fix here? Let me know if I am missing something but
>> right now I see a new version of the controller being supported with
>> its own constraints. If you are fixing existing code for already
>> supported platform, then make it clear and we can discuss this. But if
>> you just want to support the bcmbca flavor, then there is no risk
>> mitigation involved here, and a conversion is the right step :)
>>
> 
> I forgot to mention: the exec_op conversion is almost ready, Boris
> worked on it but he lacked the hardware so maybe you'll just need to
> revive the few patches which target your platform and do a little bit of
> debugging?
> 
> https://github.com/bbrezillon/linux/commits/nand/exec-op-conversion?after=8a3cf6fd25d5e15c6667f9e95c1fc86e4cb735e6+34&branch=nand%2Fexec-op-conversion&qualified_name=refs%2Fheads%2Fnand%2Fexec-op-conversion
> 
Yes this is the patch what our exec_op work is based on. Thanks Boris! 
The issue with patch is that performance is very slow for anything that 
rely on nand_read_page_op as the patch implementing it using the low 
level cmd and data register to transfer the data byte by byte.  I 
actually sent out email regarding this to Boris and he cc'ed you in sept 
last year. We have to use the nand parser to match the page read from 
exec_op so we can actually match and use the brcmnand_page_read fast 
path. But there are many situations that we need to match so the project 
to migrate exce_op are still work in progress just on our bcmbca chip as 
of now.  Just forward that email again to you and I appreciate it if you 
have any inputs there.  So IMHO it is just too risky and too big of 
scope to have the exec_op added to this patch series and definitively 
better to do it afterwards with a dedicated patch.

> Cheers,
> Miquèl
> 

--00000000000065831905fdf39765
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHjpJHrFpuSVUzg0KUw/8m4dC2Hz
BxTc+WQbCGekYiRWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYxMjE5MTkwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCxMwY4891HUYjMjVz1mJh+SvNmRBq3rrbRUrPBQyjA5hVK
vnyF0wgTCbcxlNSqNzGI3rSFv4MFaojdtQPF72U3cpaVTEP3ckCgDLAxDGS1Y4TvjcMD8C5Ia/1b
XDdsDk+9+6FmQYx57dZ6Jxure25/UDrvnLHFgx4aIELSq5x0nDiuMh2D6Zu6MPejBVP63+LvMo9N
1RqK9hg0zsQss+EQCmNudcSv/OuCFcBnDQ/NXbrLh5wMHEu06m7HT98agn9AXYOEve8TNq6tmZtp
d82hbaeuz3Pth69eqA9+nbM6Gy69mf2/F21fn3qf9X3O9HXXYnQiXh1Dgx8sKwh60fhd
--00000000000065831905fdf39765--
