Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF46BFB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCRPzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCRPzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:55:03 -0400
Received: from hyperium.qtmlabs.xyz (hyperium.qtmlabs.xyz [IPv6:2a02:c206:2066:3319::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C21E9CF;
        Sat, 18 Mar 2023 08:55:00 -0700 (PDT)
Received: from dong.kernal.eu (unknown [222.254.17.84])
        by hyperium.qtmlabs.xyz (Postfix) with ESMTPSA id 4FC72820059;
        Sat, 18 Mar 2023 16:54:58 +0100 (CET)
Received: from [172.20.10.3] (unknown [171.255.115.39])
        by dong.kernal.eu (Postfix) with ESMTPSA id 4997D44496AC;
        Sat, 18 Mar 2023 22:54:54 +0700 (+07)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=syka;
        t=1679154894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9JK4rr15uOw6b9JjKviiCer/t/jD/hPLNzsfBAMZPF0=;
        b=ce1E3Y7qyOBlK90jWJkLKvcv/QgrE+R9fprQrZMHXRYByu06BgxHNluCyRNJCfN3uPWT34
        LpbiOSR7i+cyAyFOV8JXjv5QvDKgkHaingzVze5/d14bXBFiQPfbVDmE+e9we+vtbTJB78
        hDqaAeMDJk+inOFo/G0elnfhlbtmCnaBRT4BCWR+nLNaIsgtIfyI61KE7c0j3Ro2DJhcaE
        rOGmrWQwVW3L4TQGQUul0YxJuwBhkuBEyZRma43KhbJNZWg25BiV4yUDuNqTVhY9+chzHK
        tLAYJqTZ9JmiKMg6HoTMxBaimlO05WudZuWRkVY/fhkwViDh0dmYBRLiNB5/WA==
Message-ID: <d2d0baef-c15b-3abf-338c-77de403c262c@qtmlabs.xyz>
Date:   Sat, 18 Mar 2023 22:54:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [regression] focaltech touchpad driver misbehaves due to "kbuild:
 treat char as always unsigned"
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        barry@messagefor.me.uk
References: <e20db4c4-b2a8-bc88-232f-d1213733d20c@leemhuis.info>
From:   msizanoen <msizanoen@qtmlabs.xyz>
In-Reply-To: <e20db4c4-b2a8-bc88-232f-d1213733d20c@leemhuis.info>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090208080409020500090509"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090208080409020500090509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Seems like the AlpsPS/2 driver also got hit with the exact same issue: 
https://gitlab.freedesktop.org/libinput/libinput/-/issues/871#note_1829296

I submitted a patch for that: 
https://lore.kernel.org/linux-input/20230318144206.14309-1-msizanoen@qtmlabs.xyz/

On 3/18/23 19:08, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> I noticed a regression report in bugzilla.kernel.org. Jason, apparently
> it's caused by a change of yours (3bc753c06dd0 ("kbuild: treat char as
> always unsigned")), which apparently caused a problem in
> drivers/input/mouse/focaltech.c to surface. Someone provided a patch
> already to fix it here: https://bugs.archlinux.org/task/77733?getfile=22498
>
> Back to the bug. As many (most?) kernel developer don't keep an eye on
> bugzilla, I decided to forward it by mail. Quoting from
> https://bugzilla.kernel.org/show_bug.cgi?id=217211 :
>
>> Barry 2023-03-17 13:51:10 UTC
>>
>> Created attachment 303972 [details] Kernel bisect result
>>
>> O/S: Archlinux.
>>
>> On any kernel release from 6.2 onwards I have found that the touchpad
>> doesn't respond to multi finger touches properly. The pad works fine for
>> single finger movement and single finger tap to click. If I click and
>> hold the pad button and then use another finger to move such as for text
>> selection, drag and drop, moving or resizing a window etc. Or if I try
>> to use 2 finger scrolling then the mouse pointer jumps to the top or
>> right or into the top right of the screen. All of this functionality
>> worked as expected up to kernel 6.1.19.
>>
>> I have bisected the kernel and got the attached result.
>>
>>
>> I have checked out kernel 6.2.6 and removed the `-funsigned-char` from
>> the Makefile. Kernel 6.2.6 built with the modified Makefile restores the
>> correct functionality. I believe the touchpad uses the psmouse driver so
>> maybe the new build option has broken this driver.>
>> I have bisected the kernel and got the attached result.
>>
>>
>> I have checked out kernel 6.2.6 and removed the `-funsigned-char`
>> from the Makefile. Kernel 6.2.6 built with the modified Makefile
>> restores the correct functionality. I believe the touchpad uses the
>> psmouse driver so maybe the new build option has broken this driver.
>>
>> [...]
>>
>> barry@messagefor.me.uk 2023-03-18 11:49:27 UTC
>>
>> Hi. If you check this link which is my report of the same bug on the
>> arch bug tracker there is a patch attached which fixes the issue.
>>
>> https://bugs.archlinux.org/task/77733#comment216336
> See the ticket for more details.
>
>
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
>
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>
> #regzbot introduced: 3bc753c06dd0
> https://bugzilla.kernel.org/show_bug.cgi?id=217211
> #regzbot title: kbuild/input: focaltech touchpad driver misbehaves due
> to a checke how to treat char
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
>
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>

--------------ms090208080409020500090509
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczMIIC
IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA7eaHlqHBpLbtwkJV9z8PDyJgXxPgpkOI
hkmReRwbLxpQD9xGAe72ujqGzFFh78QPgAhxKVqtGHzYeq0VJVCzhnCKRBbVX+JwIhL3ULYh
UAZrViUp952qDB6qTL5sGeJS9F69VPSR5k6pFNw7mHDTTt0voWFg2aVkG3khomzVXoieJGOi
Q4dH76paCtQbLkt59joAKz2BnwGLQ4wr09nfumJt5AKx2YxHK2XgSPslVZ4z8G00gimsfA7U
tjT/wiekY6Z0b7ksLrEcvODncHQe9VSrNRA149SE3AlkWaZM/joVei/GYfj9K5jkiReinR4m
qM353FEceLOeBhSTURpMdQ5wsXLi9DSTGBuNv4aw2Dozb/qBlkhGTvwk92mi0jAecE22Sn3A
9UfrU2p1w/uRs+TIteQ0xO0B/J2mY2caqocsS9SsriIGlQ8b0LT0o6Ob07KGtPa5/lIvMmx5
72Dv2v+vDiECByxm1Hdgjp8JtE4mdyYP6GBscJyT71NZw1zXHnFkyCbxReag9qaSR9x4CVVX
j1BDmNROCqd5NAfIXUXYTFeZ/jukQigkxXGWhEhfLBC4Ha6pwizz9fq1+wwPKcWaF9P/SZOu
BDrG30MiyCZa66G9mEtF5ZLuh4rGfKqxy4Z5Mxecuzt+MZmrSKfKGeXOeED/iuX5Z02M1o7i
MS8CAwEAAaOCAfQwggHwMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUUtiIOsifeGbt
ifN7OHCUyQICNtAwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUFBzABhiVodHRwOi8vb2NzcDA1
LmFjdGFsaXMuaXQvVkEvQVVUSC1ST09UMEUGA1UdIAQ+MDwwOgYEVR0gADAyMDAGCCsGAQUF
BwIBFiRodHRwczovL3d3dy5hY3RhbGlzLml0L2FyZWEtZG93bmxvYWQwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMIHjBgNVHR8EgdswgdgwgZaggZOggZCGgY1sZGFwOi8vbGRh
cDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVudGljYXRpb24lMjBSb290JTIw
Q0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0
L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwHQYDVR0OBBYEFL6XqaqEv4C/EFN9
CTL54S4yG893MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQsFAAOCAgEAJpvnG1kNdLMS
A+nnVfeEgIXNQsM7YRxXx6bmEt9IIrFlH1qYKeNw4NV8xtop91Rle168wghmYeCTP10FqfuK
MZsleNkI8/b3PBkZLIKOl9p2Dmz2Gc0I3WvcMbAgd/IuBtx998PJX/bBb5dMZuGV2drNmxfz
3ar6ytGYLxedfjKCD55Yv8CQcN6e9sW5OUm9TJ3kjt7Wdvd1hcw5s+7bhlND38rWFJBuzump
5xqm1NSOggOkFSlKnhSz6HUjgwBaid6Ypig9L1/TLrkmtEIpx+wpIj7WTA9JqcMMyLJ0rN6j
jpetLSGUDk3NCOpQntSy4a8+0O+SepzS/Tec1cGdSN6Ni2/A7ewQNd1Rbmb2SM2qVBlfN0e6
ZklWo9QYpNZyf0d/d3upsKabE9eNCg1S4eDnp8sJqdlaQQ7hI/UYCAgDtLIm7/J9+/S2zuwE
WtJMPcvaYIBczdjwF9uW+8NJ/Zu/JKb98971uua7OsJexPFRBzX7/PnJ2/NXcTdwudShJc/p
d9c3IRU7qw+RxRKchIczv3zEuQJMHkSSM8KM8TbOzi/0v0lU6SSyS9bpGdZZxx19Hd8Qs0cv
+R6nyt7ohttizwefkYzQ6GzwIwM9gSjH5Bf/r9Kc5/JqqpKKUGicxAGy2zKYEGB0Qo761Mcc
IyclBW9mfuNFDbTBeDEyu80xggPzMIID7wIBATCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNV
BAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFs
aXMgUy5wLkEuMSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MwIQFNDXRO3DA3l7FK9gc2BzfjANBglghkgBZQMEAgEFAKCCAi0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwMzE4MTU1NDQ4WjAvBgkqhkiG9w0BCQQx
IgQgZIq7OBKgoWFCmGsrgGdrCgTN7+JVdlXvFymymdV5pO0wbAYJKoZIhvcNAQkPMV8wXTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpwYJKwYBBAGCNxAEMYGZ
MIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUg
U2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAU0NdE7cMDeXsUr2BzYHN+MIGpBgsqhkiG
9w0BCRACCzGBmaCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNV
BAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMgUy5wLkEuMSwwKgYDVQQD
DCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMwIQFNDXRO3DA3l7FK9gc2Bz
fjANBgkqhkiG9w0BAQEFAASCAQCaTgKdaeLWLT+iDySlinwBxSc2MjuOQpTggO+LUho+UQzl
jcBFCvfh7d5b4qjfkd8IXLQTNDvDSlbw1xoWE3gSms9HTdK5ODQyeEGtZgBkyzmxSCIQ9KZ2
rIk5UzZuO35Cx35nCoG7b5O0cvb0tYZILDwS91ItHGKKriTYV+29f5o/EFy06g7/P9UcWzyS
6msU3T2ptRYIEifYF/J3UHAt/YjFl8Hmf6TXKXxLwsjQdKBclhVtHLcZcE6dJ/UZrcGs3tyy
LME++VxN1FFzKYEyXW4LN0zC7Ou4X7bva9D19I+dfpVwndyEqAsbTSiTFoeGPbtOu/HMQOAw
5jJ8MVvHAAAAAAAA
--------------ms090208080409020500090509--
