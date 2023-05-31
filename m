Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6B718A91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEaTwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEaTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:52:35 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F1184
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:52:32 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f81396e435so31551971cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1685562751; x=1688154751;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lOwJ0vhE+Hq185L6WtJ4KhK5gBspEowLluSr4XOQl9k=;
        b=Bs+xvKrNX2qIEPJYTSmcVaCn39zTeKGtBUHCwMCnAvBmP5ez9b2uh/GAA+I0un3yJQ
         TcbteIcmoVJnE3dTU+wgu9TdN3Ca0dzrEOI/lkq2U3ddb3HUj7AyJenkMd0DOaG/gPrF
         Z+TrRd+GuiOarNCtWpQ6F6s/2lTtQCLsS1o6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562751; x=1688154751;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOwJ0vhE+Hq185L6WtJ4KhK5gBspEowLluSr4XOQl9k=;
        b=XRfNAT8DBpFq1Dug9J1xzEiw+XmQRQLWKl3ccrtYmffjIYb0bgonPOEwwvvkNazXoL
         fhBgE2jhmmjl5WPBPbvAudzQ8iSWgqG+obhBv9dMUHNA6qunbMrZA17oWjs+nUO31hPa
         P8ZIm3Zy8P3MBobPc2NnnvPejrMugwp8Lr/YsdM09oBVyahAaXxzpWv2ZjA5hlcIwoul
         nct7Kt6T2IwjS8NLn7FBuniwu5BBTv3FrpnKa0xdplIEGJ6lBwfxaZ5Vnb8cokOUDfxU
         iajTcQX/Z/8jj9SD8BOPJNBkRcAhfj0xqNK/6hfYtdvwOUfSU2iNXVfSkj+9cYj+oqh3
         JAug==
X-Gm-Message-State: AC+VfDz0e+eWv3dXibA4A2LuA2M0on3zu6pAufB7p5HKWD9j+56AFPC8
        EMLEa9WP4tqnxZPKQdkNsOW5xA==
X-Google-Smtp-Source: ACHHUZ73GvvyLOXGj3CE7YV5xqIM6paI7LAOX966VG+Gkt7H+eyB+74BX8tDGAZSrVp/a2KaeNAEZg==
X-Received: by 2002:a05:622a:24d:b0:3f4:c9b:24ca with SMTP id c13-20020a05622a024d00b003f40c9b24camr8334140qtx.53.1685562751249;
        Wed, 31 May 2023 12:52:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g3-20020ac870c3000000b003ef33e02eb9sm6378626qtp.83.2023.05.31.12.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:52:30 -0700 (PDT)
Message-ID: <0f2e3a2b-477b-cbd7-e756-4b3f4df8e045@broadcom.com>
Date:   Wed, 31 May 2023 12:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH stable 6.3 v2] arch_topology: Remove early cacheinfo error
 message if -ENOENT
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Conor Dooley <conor@kernel.org>, stable@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:GENERIC ARCHITECTURE TOPOLOGY" 
        <linux-kernel@vger.kernel.org>
References: <20230530201955.848176-1-florian.fainelli@broadcom.com>
 <20230530-basically-wildly-84415a94171d@spud>
 <72d84100-55cf-566d-8301-7147ce14b1e9@broadcom.com>
 <20230531085356.ru4fmtawyxo5cq5s@bogus>
 <7eae52f6-ca7e-5017-629e-43761d4eb5d7@broadcom.com>
 <20230531154338.x7rivfpxj2wtjpq6@bogus>
In-Reply-To: <20230531154338.x7rivfpxj2wtjpq6@bogus>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000ed87f05fd02a910"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000ed87f05fd02a910
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/31/2023 8:43 AM, Sudeep Holla wrote:
> On Wed, May 31, 2023 at 08:28:26AM -0700, Florian Fainelli wrote:
>>
>>
>> On 5/31/2023 1:53 AM, Sudeep Holla wrote:
>>> On Tue, May 30, 2023 at 03:42:45PM -0700, Florian Fainelli wrote:
>>>> Hi Conor,
>>>>
>>>> On 5/30/23 14:39, Conor Dooley wrote:
>>>>> Yo Florian,
>>>>>
>>>>> On Tue, May 30, 2023 at 01:19:55PM -0700, Florian Fainelli wrote:
>>>>>> From: Pierre Gondois <pierre.gondois@arm.com>
>>>>>>
>>>>>> commit 3522340199cc060b70f0094e3039bdb43c3f6ee1 upstream
>>>>>>
>>>>>> fetch_cache_info() tries to get the number of cache leaves/levels
>>>>>> for each CPU in order to pre-allocate memory for cacheinfo struct.
>>>>>> Allocating this memory later triggers a:
>>>>>>      'BUG: sleeping function called from invalid context'
>>>>>> in PREEMPT_RT kernels.
>>>>>>
>>>>>> If there is no cache related information available in DT or ACPI,
>>>>>> fetch_cache_info() fails and an error message is printed:
>>>>>>      'Early cacheinfo failed, ret = ...'
>>>>>>
>>>>>> Not having cache information should be a valid configuration.
>>>>>> Remove the error message if fetch_cache_info() fails with -ENOENT.
>>>>>>
>>>>>> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
>>>>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>> Link: https://lore.kernel.org/r/20230414081453.244787-4-pierre.gondois@arm.com
>>>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>>
>>>>> How come this now needs a backport? Did the rest of the series get
>>>>> backported, but not this one since it has no fixes tag?
>>>>
>>>> Humm, indeed, this has been present in v6.3.2 since I requested it to be
>>>> included. The error that I saw this morning was not -ENOENT, but -EINVAL.
>>>>
>>>> With those patches applied, no more -EINVAL:
>>>>
>>>> cacheinfo: Allow early level detection when DT/ACPI info is missing/broken
>>>> cacheinfo: Add arm64 early level initializer implementation
>>>> cacheinfo: Add arch specific early level initializer
>>>> cacheinfo: Add use_arch[|_cache]_info field/function
>>>>
>>>> I will submit those shortly unless we think they better not be in 6.3, in
>>>> which case it would be nice to silence those -EINVAL errors.
>>>
>>> I prefer this option instead of back porting all the above 4 as there are
>>> some pending fixes for the issues found in those patches. I am fine if Greg
>>> is happy with the backport, so no strong rejection from my side :).
>>
>> OK, so are you suggesting that we specific check for -EINVAL and -ENOENT
>> rather than take all of the 4 above patches,
> 
> Yes that is my preference ATM or if possible to wait until all the fixes
> are sorted for the bugs associated with above 4 commits [1] and [2].
> I have queued [1] but waiting for response/patch on [2] and hence not yet
> bothered Greg.
> 
>> if so, any preference on how to do it given the state of 6.3 stable?
> 
> I don't understand what exactly do you mean ?

Linux 6.3.y currently contains:

cacheinfo: Check sib_leaf in cache_leaves_are_shared()
cacheinfo: Check cache properties are present in DT
arch_topology: Remove early cacheinfo error message if -ENOENT

however my logs are full of:

[    0.001484] Early cacheinfo failed, ret = -22

reverting these 3 patches mentioned above does not eliminate the error.

What I am asking is if we need a targeted fix for 6.3 like this:

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c4b6198d7461..a72fcf836ed3 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -845,7 +845,7 @@ void __init init_cpu_topology(void)
                  ret = fetch_cache_info(cpu);
                  if (!ret)
                          continue;
-               else if (ret != -ENOENT)
+               else if (ret != -ENOENT && ret != -EINVAL)
                          pr_err("Early cacheinfo failed, ret = %d\n", ret);
                  return;
          }

-- 
Florian


--0000000000000ed87f05fd02a910
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOFkQQZVYp7C+aI3
2EMVwCr6O3n66X1vvzJN5BrHXAaYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDUzMTE5NTIzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDyo5WAy31jkfD0WGUkYReHDOu4kwDxjZIu
7idmZHg4sxN2rn3mrJt/SgI9jrZgzXGlB7VIZyDrDMO2lQp17IeP1uLdWgnxGIRu6bzNwPEKGNlc
jmBHC5h2Wzo67EQCGAZzow6TN3pglu8/t8YgsW0usiDujaWlDj6mnN5pTjIKxoIqDbBcZ4i44j+C
dtPJ3ksltT0rrDNYwbWtRPXt6ECzoJQL1NEUN/ffS6STlGSCZX/5lLZ0d/6pSNo2dISG8CMcqk/A
xZRCaEq7pXkiLxtfLpAPu5vYC7WAVJ78FtUGQfH8T3Xg3w8nltuphphnCSi0KyS5gn3VjVv5DH4T
Nhxm
--0000000000000ed87f05fd02a910--
