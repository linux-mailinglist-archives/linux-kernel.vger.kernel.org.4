Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B0B6631BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjAIUoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjAIUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:43:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0974ECB8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:43:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s8so2561825plk.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=EgIp64wR5rCqasADNvQH+AVw8h1xGfwjU6s44y76QJM=;
        b=UhaZZZ3nFggV2QuaA/bx2AQwDz3tF1zsmJt1+d3wqjlcrUTlnAj0glsHDa04RAYVJM
         raZAwYhThHhCKWW1c5Dx7FJB2D/SwL0rg6AuWeZeb+C51KzWYdJw/R3OxyLf+74Lk5lM
         /2FJOocqVibc2f7khaeMQqkEF1+MhCr3U4KA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgIp64wR5rCqasADNvQH+AVw8h1xGfwjU6s44y76QJM=;
        b=1GJeOGdsQG1WjRv0lYh3sUmqQxTk4eksQ+86VJR5HQwt7SJ5JxVDxQmTrzfyK2EYm6
         iyIwq1X97karunzDf1vQE1NhkKB5yMqXuS2wT+GAjDDX2auZPkOA37M15UDqPY6sAjAk
         la7uQocJ6VT/vf2NlSKJcVjRcMR4Dg6hAhfRqtSXVCtD8yZlytM3jdTeAKZ0JT+QI+Qg
         pXNlvftNWqvyfY/0qiB0NuRzx7SgOFoEtO0v9yuXUF+JB4VBcltQazI9Hi56EEYq1o6p
         F8VwnJ5W0xKvH8bh0IeATzb3SK/lKzJNxFga1lEVFu4wYVzia+mt0Cb9gSlaFqzucctK
         lLNg==
X-Gm-Message-State: AFqh2koWDN3K2p7DJnzh8ZGZSQktmb+Rub4+ir2/VyLn/OjC2ySSsu+c
        YaH2Yu/JTjuMgnMWKqzG3n3HtsUCVUAUFl+Chp6QEGsoPLfkaAU2BLTckQqcQAeBsqJbKC1avIB
        k3buXZ+P6x4/El9h0GQ9H3ddjcCqwaHSG0CJscUiGi6JfdDFUXc+VAXmSKbaNMOptrdR1Lt8IoS
        Dy2Uee5DnjWXo=
X-Google-Smtp-Source: AMrXdXvws7J1qmSfAhQIhRJk4KTFCG246r2YS9mc7sz4wfRXUaQS4wjyi4fvwDHKglC9cxwUqXTOpA==
X-Received: by 2002:a17:902:f70c:b0:188:6b9c:d17d with SMTP id h12-20020a170902f70c00b001886b9cd17dmr86838478plo.16.1673297035026;
        Mon, 09 Jan 2023 12:43:55 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b0017d97d13b18sm6566604pln.65.2023.01.09.12.43.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2023 12:43:54 -0800 (PST)
Subject: Re: [PATCH 11/16] spi: bcm63xx-hsspi: Add prepend feature support
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-12-william.zhang@broadcom.com>
 <Y7iaEOBP4TRBoDYy@sirena.org.uk>
 <88534207-6b1c-75c1-26a1-be88a19eeecb@broadcom.com>
 <Y7xrhjhhY3g5DE25@sirena.org.uk>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <04b740e0-09d1-8c39-4f0e-8f61a74eeb58@broadcom.com>
Date:   Mon, 9 Jan 2023 12:43:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <Y7xrhjhhY3g5DE25@sirena.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000067f12205f1dad346"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000067f12205f1dad346
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/09/2023 11:31 AM, Mark Brown wrote:
> On Fri, Jan 06, 2023 at 07:52:35PM -0800, William Zhang wrote:
>> On 01/06/2023 02:00 PM, Mark Brown wrote:
>>> On Fri, Jan 06, 2023 at 12:08:03PM -0800, William Zhang wrote:
> 
>>>> Multiple transfers within a SPI message may be combined into one
>>>> transfer to the controller using its prepend feature. A SPI message is
>>>> prependable only if the following are all true:
>>>>     * One or more half duplex write transfer
>>>>     * Optional full duplex read/write at the end
>>>>     * No delay and cs_change between transfers
> 
>>> There is nothing driver specific here, this should be implemented in the
>>> core - we have existing logic to rewrite messages to match driver
>>> constraints, this could be added there possibly with flags to allow
>>> drivers to disable or enable the merging if they've got special
>>> requirements.
> 
>> My understanding of combining the spi transfer in the core level does not
>> quite work out to our controller.  For example, for a spi message with three
>> transfers, tx, tx and rx. We can possibly combine them in single duplex
>> tx/rx transfer in the core. But this will be treated as duplex transaction
>> in our controller level which require tx and rx data happens at the same
>> time. Obviously this won't work when rx depends on tx happening first. We
> 
> I'm saying that if this logic is useful then implement in the core
> rather than in the driver.
> 
>> can not differentiate this combined duplex transfer from the true duplex
>> transfer unless there is some flag to indicate that. Also there is limit of
>> max tx length as the prepend buffer so maybe another parameter.  And another
>> reason to be done in the driver level is this prepend mode has dependency on
>> dummy cs workaround which is driver level parameter currently.  I am not
>> sure how practical and useful this is to factor them out to the core level?
> 
> If this relies on software control of the chip select (which is what I
> *think* your dummy CS workaround thing is about, the other patch about
> that is really hard to understand) then I'm confused about what the
> advantage is?
Dummy CS workaround is implemented by Jonas when he first upstream the 
driver. It does not work on all the board designs so prepend mode is 
introduced. I have some detail explanation on this in [PATCH 10/16] spi: 
bcm63xx-hsspi: Make dummy cs workaround as an option.

The controller only work in one mode and that's why driver code has some 
dependency between these two modes. The advantage of the premode is it 
works on all hw design however it does not support all types mem_ops 
operation. That is why you see the patch 14 to disable the dual io mem 
op. But dummy cs workaround can support this and in case there is such 
pattern from non mem op spi transaction, dummy cs workaround can be used 
as long as it does not have the board design limitation.   So neither 
one is perfect but hopefully with both options available, we can cover 
all the cases.

You mentioned there is some existing logic to rewrite messages to match 
driver constraints in the core driver.  I didn't see it when I did a 
quick search on spi.c. I will take a deep look into the file. But if you 
can point me where this logic is so I can be sure that I am looking at 
the right place and will double check if this can be done or not in the 
core level.  Thanks!


> 

--00000000000067f12205f1dad346
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOZeyI1hHATA7iPHqNDCrVE6v1qm
ddUIE5inDTu2svHeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEwOTIwNDM1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQASf4IteL1rCWanDrKof2wXNLGRjN2mjQd7AlKqQjL6B/f3
iZoteBHn3oGFuo5rTibZFqoQZ3ja05Jnv7xm1eXiC1RHXgNhzkIfedbuehZrs+QdF264Es5pKKpv
GRbWTvLrlm74B22Vj6Qf47IVIGDJ/vBIct1WsABVGtk91U+rqGPFFV814v2L2v8ykN9LaNumIDEP
sw/3ITE7PPb15SkHY7RtGz26EQvtl6e1zsJawlbFDGbjMv9mQhW0Q57pUqlqV6pNFHR4A/bhGOR0
ZJJr2ukKWpFFS1DPtOGU81b+8HVdzBAHoMgD0Fnv9nnUFBzo7n1G5t7iGRp6e6KdR3Jy
--00000000000067f12205f1dad346--
