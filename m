Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451615B84B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiINJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiINJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:13:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C47C1C1;
        Wed, 14 Sep 2022 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663146277;
        bh=LxrrAAF02KCR76/F/annEJIQS3JrN8qn8iNj3YoH9CU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fYN080epVgDKh9qonjYciKmUKszfVilZ9Y1YLcwqUaXjMOVZRwQzrPkvA6Ivk4Nte
         qNkybJOmuOQP52Auz0UjGj4CFCk5gE04oZIuPxdf2+62FEyLL3gn3G0oVh8CrO2lz7
         qqw+oK7RsWo+7l67TMpGcXJtPd7TuvRH8wifRYYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.164.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1p9v4A1m3P-00cRMe; Wed, 14
 Sep 2022 11:04:37 +0200
Message-ID: <3a72852c-2f28-2916-f02c-b52cb06efd7d@gmx.de>
Date:   Wed, 14 Sep 2022 11:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] parisc: Increase the usage check of kmalloc allocated
 object a
Content-Language: en-US
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Li zeming <zeming@nfschina.com>,
        James.Bottomley@hansenpartnership.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914060428.4039-1-zeming@nfschina.com>
 <f346579c-e6a3-d2bb-1c21-d914aeb9a77d@gmx.de>
 <1668528.WaZXzWfjLs@eto.sf-tec.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <1668528.WaZXzWfjLs@eto.sf-tec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LbXXBWq4HMo2OOfU43zK7i8Q+y96oVWwAVNPRwbPlXF5nSKicZi
 Ccz3hsMjSI13cGNcj86S9p9mcFBvbRLY+iGPvmOOm5q6n6y8lcrby53XrHTauGMlhX07U6Y
 YiW0Tcra07wMnNGgsnFjIDxxtPUGNwvPpz1UzAvwFLVYDUZXkwlbBfrQu7gAASvZ1Xj8r7G
 WQdk9MPfBjxfPWiXTgxDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B2ZTDYXN8k0=:nRcZtdydTws1OC1Yw2uM0/
 Fs3NtQvyxJquHiFSq3X0W0AKcgsSNG1YEyNgxGbZnUPfQF5gfE5+/Ko6MUlvzU+7SGQhPBu6c
 rJ2LzzI76wt78jKV16eTvLi+N9FIL7iV89dilDHGRgcQz4i91vMA6lNOugHemqk9bk7pClDTJ
 CW3Q5RdoBdAHMlzav7/+5zm4WUjFIjxBtd+Hf4qy+cDKeIC58xT/LLrU1HSINg7knjB+YRT2b
 ryLxbIOu2+faV4/Hpz8mQfkgNmsVds2b0RZGArTAIk9KeIu3yi171w2DTmoAMrIrX8Hwp/5LP
 8zKuH4gV3fLSydeHLsinJycPiBAjQBbro8+kuek51TYyQFxlsnJ51tZJ2rzWGszrJxVLYk5Fo
 KZrM/VK4rwq0xooBWjCOP6BbyTIww0uUZ7SXzjXmHREZ3OMNWU18ChdFmBpJDGb3ToKwxSsOl
 EoS+6DwC1P0JHnJMwaYRSRL6IuCB2LBNJgdpVvkXptXKLmh93oTvA7ejGkx2/Q0K7rh2jE1zX
 ZUlFZNGv52s92p/eemuJ8MVoOyWU5J/lPtXAvQOM0vSjQVToXMO9cV6TKU8J/zO3LQDKTL27a
 PIzaOIBcansWlaRzaHwNnY807s8VgO1JsTgewRl0tKqvEP14dW8JHPF3K3tZX15wAnu3ZHtSA
 YJnpg37AxBmFpv9NJbfFfm5AxW0s7ZGF6bCbCRawdtmWbJbVdO9J/ksV/ayZEzdiWzBSiZodz
 rTerVfEcVyOSNSVIuMRnPRZpJHZ75GD5MQiOCHf5Rcy8ijbX++UnzLRwpaSaArAhL1PlMXKt7
 FEwM7TaB0/2l9Oy6+JGnw7U9PqOo0X94OgGFYqjtyZC0jFU1GnjrVJxw7bWCDC8GkdFlVXNDM
 riRECxTMGliu43Xpc2m/qWCjGEg94XND4j+vdmV2KGXpy2XtYxeKiSwGaKS4yADN5FvRJVq4s
 7q7c4SpfTfK1V/JJ0ipT55o14ekfmqGkkRvDduyA9mR1egK9VAxPmtKXWJmOhCXwfFQU2v6rR
 6oqzCMj4fJZbWGO8JvmqTPPCkkhtW3/Xdx7MdT25Lx+bXeQ+TQRYPSjdZFK6aP4MTga1AWnPB
 EfyNp8tNQJkH/5zqxw6fILT2VbGmlz6I5T//TC22YtFPXKgovPLNp7bwwviPhmRRu3rgF32CM
 0NKvbDT6ZPb/+mYyFd/v/AbPR2
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 08:43, Rolf Eike Beer wrote:
> Am Mittwoch, 14. September 2022, 08:18:19 CEST schrieb Helge Deller:
>> On 9/14/22 08:04, Li zeming wrote:
>>> In the case of memory allocation failure, no alignment operation is
>>> required.
>>>
>>> Signed-off-by: Li zeming <zeming@nfschina.com>
>>> ---
>>>
>>>    drivers/parisc/iosapic.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
>>> index 3a8c98615634..33de438916d3 100644
>>> --- a/drivers/parisc/iosapic.c
>>> +++ b/drivers/parisc/iosapic.c
>>> @@ -229,7 +229,9 @@ static struct irt_entry *iosapic_alloc_irt(int
>>> num_entries)>
>>>    	 * 4-byte alignment on 32-bit kernels
>>>    	 */
>>>
>>>    	a =3D (unsigned long)kmalloc(sizeof(struct irt_entry) * num_entrie=
s
> + 8,
>>>    	GFP_KERNEL);>
>>> -	a =3D (a + 7UL) & ~7UL;
>>> +	if (a)
>>> +		a =3D (a + 7UL) & ~7UL;
>>> +
>>
>> As you said, the adjustment isn't required, but it's still ok.
>> So I think the additional "if" isn't necessary and so I'm not
>> applying your patch.
>>
>> Anyway, thanks for your help to try to improve the code!
>
> I was about to say the same, but from looking at the code I don't think =
what
> is in there is correct either. The comment seems outdated, because
> __assume_kmalloc_alignment, which is __alignof__(unsigned long long). Th=
is
> code is untouched for the entire git history, so maybe we can just chang=
e the
> whole thing to
>
>    return kcalloc(num_entries, sizeof(struct irt_entry))
>
> now?

Yes, your proposal is good.
Anyone want to send a patch (with a small comment that kcalloc() will retu=
rn
at least the required 8-byte alignment)?

> And these functions end up propagating an allocation error in this file =
and it
> will never reach kernel/setup.c, which seems bad.

That part I don't understand.
The return value of iosapic_alloc_irt() is checked afterwards, but you pro=
bably
meant something else?

> But I guess the only point where this really can go wrong if the PDC
> returns an absurdly large number of entries.
Helge
