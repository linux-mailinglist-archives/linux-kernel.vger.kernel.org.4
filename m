Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B267DC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjA0DK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjA0DK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:10:26 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E631C32D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:10:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id ay1so2330776pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=8GrwvJWq6bUQfPzE3tLioqxkHbVhxKE+p+lkDXa7nrk=;
        b=Gpnt4jjbHzEczIxRvByRNQNIUtK8Twt38YA5SIwqHU5PohD+cs/JuD0Q4PRTRMYVB/
         ewYnXpThn/eUHG/Lc+U0xoGnTjKtSYvFTV9ZEucw7iZQa0DQ+vaSq70vzpp2PFu6OCW6
         NiRjI9dT5jF482iGF6qBZUnDDYh+HhXX5rEIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GrwvJWq6bUQfPzE3tLioqxkHbVhxKE+p+lkDXa7nrk=;
        b=xSd58bkftUsgtAJDpx23OCLHJJfUeXl4XoUU5zim5V8sqOdK6tNmKYx8szU49BAmkH
         T8ufhDhaXhfOdcSbWNs7z0Etg6kOpcAhjOF6eWy8w3Oz+8hIlrbxYTRpZ7G2mvja4HVX
         RJNvx1fhrtEHhOOS2C9I9Iqg79G/fhiXA12Vyw1ORNzx4GurQvDPGiP3SXjeKPJngEXO
         gnpquYmBps2bsMF7zJd/BjxzltajSv6WWCgGzHtmz0X8fdaWvf+rhOfm1diFogVILBJW
         4iQPkfqA3aeBoT5QVev7wq9zwZ2e9xFed4DJIwGJSFPjPSaBxFvKU+33Mc/99yXC6VXF
         g9nA==
X-Gm-Message-State: AFqh2koqcTsPTXw7qyz1aJm3LgqKx/ZaIF23p/Rm/2jm0Enz12NdpLZG
        jp2a9y6ChsaWK1rThRyQPoeRd3NpRJssebmQpd3ARf28dAaYIfKTbtyPKOVarHzTydNCgfd/yg7
        2TGgs9cy4oI4q3P8BhZHvGkKftgfYAW7l9TYEY7DUIoeZX+seTzPqWg7nMJq2UV2PVbTZrN/y+F
        BptgDwToUBTOI=
X-Google-Smtp-Source: AMrXdXsbpsv7AhejQYbX21h0+j8gpQphDW1/eDkQeylyCX9HmU8wTIKlLW+wJdzi7bnBjKpQ4oUBhA==
X-Received: by 2002:aa7:8611:0:b0:582:df2e:595d with SMTP id p17-20020aa78611000000b00582df2e595dmr36462203pfn.4.1674789024445;
        Thu, 26 Jan 2023 19:10:24 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id b17-20020aa78ed1000000b00580e3917af7sm1521348pfr.117.2023.01.26.19.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 19:10:23 -0800 (PST)
Subject: Re: [PATCH v2 08/14] spi: bcm63xx-hsspi: Handle cs_change correctly
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Kursad Oney <kursad.oney@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-9-william.zhang@broadcom.com>
 <CAOiHx=mQJXAkSsXkgGzpJUCzwxD1nC-Hbw3WX3OfRmp7cfFiww@mail.gmail.com>
 <CAMm8Nh0Lh+oUXZGCTBC-zQPQeg9-1dPUyoq34BP2ZP_vJqWX-A@mail.gmail.com>
 <CAOiHx=nZBot4xuZ4aG6-4Ch18wNOK0Ud2+z7B2W7+YEc+U3DHg@mail.gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <f208f86e-06dd-5d46-071d-501968c773bc@broadcom.com>
Date:   Thu, 26 Jan 2023 19:10:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=nZBot4xuZ4aG6-4Ch18wNOK0Ud2+z7B2W7+YEc+U3DHg@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e873d205f3363409"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e873d205f3363409
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/26/2023 09:33 AM, Jonas Gorski wrote:
> Hi Kursad,
> 
> On Thu, 26 Jan 2023 at 17:22, Kursad Oney <kursad.oney@broadcom.com> wrote:
>>>
>>> While there, you might also want to check the cs_off value(s) as well.
>>
>> Can you explain this please?
> 
> I'm talking about the transfer property cs_off:
> 
> " @cs_off: performs the transfer with chipselect off."
> 
> See how it is handled in the generic spi_transfer_one_message():
> 
>          spi_set_cs(msg->spi, !xfer->cs_off, false);
>          ...
>          list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>                  ...
>                  if (xfer->cs_change) {
>                          if (list_is_last(&xfer->transfer_list,
>                                           &msg->transfers)) {
>                                  keep_cs = true;
>                          } else {
>                                  if (!xfer->cs_off)
>                                          spi_set_cs(msg->spi, false, false);
>                                  _spi_transfer_cs_change_delay(msg, xfer);
>                                  if (!list_next_entry(xfer,
> transfer_list)->cs_off)
>                                          spi_set_cs(msg->spi, true, false);
>                          }
>                  } else if (!list_is_last(&xfer->transfer_list,
> &msg->transfers) &&
>                             xfer->cs_off != list_next_entry(xfer,
> transfer_list)->cs_off) {
>                          spi_set_cs(msg->spi, xfer->cs_off, false);
>                  }
>                  ...
>        }
> 
> if we fix the cs_change handling, we might as well bring it up to state.
> 
We can blindly port this logic over but this cs_off stuff (from the 
spi.h comment @cs_off: performs the transfer with chipselect off) sounds 
weird.  What kind of device do transfer when cs is off? I don't have any 
device like this to test.

> In theory I would suggest to switch to implementing the set_cs() /
> transfer_one() so you could let the core take care of all of that, but
> that wouldn't work with dynamically switching to prepend mode. Might
> be something for v1.1 though.
> 
That is good idea and I can certainly try that.

> 
> Regards
> Jonas
> 

--000000000000e873d205f3363409
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII0Syt/4wKGIwpf6W99XvQer8GxJ
KTzW+QTTV8Ce0qt9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEyNzAzMTAyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQC2Uy3cBxOlz73NOzJ1svJfVfcxj0ZqtHD1GRfALuNH2omG
4nd7DyVq3iEjxczlnEzULY0Ekq9cAa32CtvqpwQ5bF7zzu4q/afsSEU+4Gz+S7TBcTf8J5rcs4+B
+mC8h8UvfJbHfKi8L/WViOwlOPx+o7ufqWJ52V33i4PjTB6xkln/Pw5yG4QAtLMqi9aYDbQNBad+
r5G6pwLSvR7PNmJAbqPr4YqiFy0lrPH99+CwSP1VNlB7FcGeEJIMMfdvkrQSV/YZSTlrZhXl27vy
+UsEgegxV4i7IUNn35UxWOrDWzkqMDXMVpjVvRmIfFFRkXiV/FThxu/I0nYBBG13OAc8
--000000000000e873d205f3363409--
