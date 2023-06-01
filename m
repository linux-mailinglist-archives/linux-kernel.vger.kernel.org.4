Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7A71F1FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjFASh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFASh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:37:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009CBC0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:37:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso1971501a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1685644675; x=1688236675;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qqdsf/NXxY4GbHVEXdJ1H8ytpmjG3apzq5eGadtcFSU=;
        b=JmFCdN/IN3h2YNsqZBdY7qkxXp0eWQa89wWSENLIo/qJ+cWSIgTOrX9PBQTLiLBJ9L
         PL4K55dzb18GJis2v12VBT3kv92ga8OtQ2PTGRyyw8aAK7SBXCbk9Ljc2162QCRzSVSp
         wznRaa+3Tsxz6hsb3Tp5HSt0IawXcglUbHYu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644675; x=1688236675;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqdsf/NXxY4GbHVEXdJ1H8ytpmjG3apzq5eGadtcFSU=;
        b=b7CVWqI5v3UaPFCDIWVXgCtaFH0EEK9ewdDjQrEoYBmz5e5Klw5AqdhYFxSH+kW3uI
         g7kNKqrm7I+5sPAxFsDI6EytXFWZk9rNJUKF0TTxDQ8mDYO2d9BRdD3PDhS4IozvFJDK
         iaRohy80nKyPy0sZe6+aYDoJcsfn2l1VK2hJ3mFDnxIOHJUf3E61859hzQ/oe2wkGLRP
         bktnDMF+TPgDgPGAR5YIIBbsEGILmSa+CdahQPUU1o2HzfusRiavnNbuWf/Pp0FTeHdA
         WcDsk3NuJCGLsgptYTYz8KRm5fwgTRju+SMp7riHs5IcRuZTHZ3co4OTEBnK8TxgViNf
         rLGA==
X-Gm-Message-State: AC+VfDyAO03x9lFWMFVdNyRnvEnRPAfkmp+44apxk/1Nk2eds9/2cFSP
        BYZmPwq1UKlY06BizxXdnIxGyg==
X-Google-Smtp-Source: ACHHUZ5lKLaSg4I1gVbBY7T4rgmFWIpaQYKHin7hvbFyc9J+ny/waQvtApuMS4nk/I3WudlPLUHbPA==
X-Received: by 2002:a17:90a:f98c:b0:256:3191:640f with SMTP id cq12-20020a17090af98c00b002563191640fmr179081pjb.4.1685644675413;
        Thu, 01 Jun 2023 11:37:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id fh2-20020a17090b034200b0024e3bce323asm1720075pjb.26.2023.06.01.11.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 11:37:54 -0700 (PDT)
Message-ID: <e3065103-d38c-1b80-5b61-71e8ba017e71@broadcom.com>
Date:   Thu, 1 Jun 2023 11:37:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next] ethtool: ioctl: improve error checking for
 set_wol
To:     Justin Chen <justin.chen@broadcom.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Andrew Lunn <andrew@lunn.ch>
References: <1685566429-2869-1-git-send-email-justin.chen@broadcom.com>
 <ZHi/aT6vxpdOryD8@corigine.com>
 <e7e49753-3ad6-9e03-44ff-945e66fca9a3@broadcom.com>
 <eda87740-669c-a6e1-9c71-a9a92d3b173a@broadcom.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <eda87740-669c-a6e1-9c71-a9a92d3b173a@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001db66a05fd15bc3c"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001db66a05fd15bc3c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/1/23 11:27, Justin Chen wrote:
> 
> 
> On 6/1/23 9:22 AM, Justin Chen wrote:
>>
>>
>> On 6/1/2023 8:55 AM, Simon Horman wrote:
>>> + Daniil Tatianin <d-tatianin@yandex-team.ru>, Andrew Lunn 
>>> <andrew@lunn.ch>
>>>    as per ./scripts/get_maintainer.pl --git-min-percent 25 
>>> net/ethtool/ioctl.c
>>>
>>> On Wed, May 31, 2023 at 01:53:49PM -0700, Justin Chen wrote:
>>>> The netlink version of set_wol checks for not supported wolopts and 
>>>> avoids
>>>> setting wol when the correct wolopt is already set. If we do the 
>>>> same with
>>>> the ioctl version then we can remove these checks from the driver 
>>>> layer.
>>>
>>> Hi Justin,
>>>
>>> Are you planning follow-up patches for the driver layer?
>>>
>>
>> I was planning to for the Broadcom drivers since those I can test. But 
>> I could do it across the board if that is preferred.
>>
>>>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>>>> ---
>>>>   net/ethtool/ioctl.c | 14 ++++++++++++--
>>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>>>> index 6bb778e10461..80f456f83db0 100644
>>>> --- a/net/ethtool/ioctl.c
>>>> +++ b/net/ethtool/ioctl.c
>>>> @@ -1436,15 +1436,25 @@ static int ethtool_get_wol(struct net_device 
>>>> *dev, char __user *useraddr)
>>>>   static int ethtool_set_wol(struct net_device *dev, char __user 
>>>> *useraddr)
>>>>   {
>>>> -    struct ethtool_wolinfo wol;
>>>> +    struct ethtool_wolinfo wol, cur_wol;
>>>>       int ret;
>>>> -    if (!dev->ethtool_ops->set_wol)
>>>> +    if (!dev->ethtool_ops->get_wol || !dev->ethtool_ops->set_wol)
>>>>           return -EOPNOTSUPP;
>>>
>>> Are there cases where (in-tree) drivers provide set_wol byt not get_wol?
>>> If so, does this break their set_wol support?
>>>
>>
>> My original thought was to match netlink set wol behavior. So drivers 
>> that do that won't work with netlink set_wol right now. I'll skim 
>> around to see if any drivers do this. But I would reckon this should 
>> be a driver fix.
>>
>> Thanks,
>> Justin
>>
> 
> I see a driver at drivers/net/phy/microchip.c. But this is a phy driver 
> set_wol hook.

That part of the driver appears to be dead code. It attempts to pretend 
to support Wake-on-LAN, but it does not do any specific programming of 
wake-up filters, nor does it implement get_wol. It also does not make 
use of the recently introduced PHY_ALWAYS_CALL_SUSPEND flag.

When it is time to determine whether to suspend the PHY or not, 
eventually phy_suspend() will call phy_ethtool_get_wol(). Since no 
get_wol is implemented, the wol.wolopts will remain zero, therefore we 
will just suspend the PHY.

I suspect this was added to work around MAC drivers that may forcefully 
try to suspend the PHY, but that should not even be possible these days.

I would just remove that logic from microchip.c entirely.
-- 
Florian


--0000000000001db66a05fd15bc3c
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILYTQ4j1LEqoMnlI
AXS5tIh+8iY1w6Zaeyi/2em4EFv8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDYwMTE4Mzc1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA0RTCOloXIWdSSzCLG1gnjddHzUHcm37hg
H9GSd39XouPhoJ+0TJreSsu7WZzoTagQxQNnUKWBYEdMdz8atl4Reb+4PIKi3NBO8Gikmwg2yOVk
naquSg9beEI55PwDUjDdPiMmGhMkyi6HyI5NtKrJuPUTcDaPM0dOrwbXpJwDSrbEu2X2V8PzCpPm
U93DchcJOpsv9iMCBH36vEFsanJD5JWFe2TFOCxqow82Mx0rbW1HYU4ntNmjSLshFBuU0c70aUdx
te3GNdMQdoafBvQVo6v5rDeeXqfBc+luePJQF2P4P8COzj2CY9Bf8qeZuyy1Mk4azPClpRGSrGiv
O2X/
--0000000000001db66a05fd15bc3c--
