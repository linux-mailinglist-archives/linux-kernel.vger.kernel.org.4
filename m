Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56C6B1DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCIIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCIITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:19:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D579BE0629;
        Thu,  9 Mar 2023 00:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678349749; i=deller@gmx.de;
        bh=teLoVnBgle2kcDdO1/HLQJT15FQM+Xa5PD++pn9A3bw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SRXX+jNqYVBejRVBE3x9EybvKmHGjC0Q98fkdJST7mNpLHd8LYK/tP2dKvc175Qo5
         1KNP1lu35FEUer9W0iwnSeFWzvWwFXc2x3jBZ4Jr1Zj0b209K/pvPCdv3+K8S4BY5Z
         hGhJQyMYZ+jwY6ITOiYTWAYUVVCVZs210TnWUO1sXntxfoLxvhWUI18yDJB68lSqqL
         Zryc88m2/ceIdTOxx0UGHgTCGbBuOJCzkXZdwhEfTfFCaOXIQj+IVJj4uGevdIjTmd
         /64rltq9msRRbg74bdvgx5/BfC0lCstb6KfWgSfiOGT9MnRm1ZY7QumPnyVaqW8Lq5
         1vZVtgk3PbY4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.49]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1pwmn83RfG-00MeUj; Thu, 09
 Mar 2023 09:15:48 +0100
Message-ID: <92a9d8d4-17e8-6906-7640-e7b82787f74a@gmx.de>
Date:   Thu, 9 Mar 2023 09:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] fbdev: tgafb: Fix potential divide by zero
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        harperchen <harperchen1110@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, javierm@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, tzimmermann@suse.de
References: <20230307130856.2295182-1-harperchen1110@gmail.com>
 <123a52d8-baf0-e32b-3262-1e8619b1c3ad@gmx.de> <87cz5ibbsb.fsf@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <87cz5ibbsb.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qzXzx/qRVT7OJmz28j5n5zzXi6tmhEmtkTsP0w96viefW4iBo4A
 bq6AU9UI1DA2+j9HrcV/An+J9kDVyHiZ5c4EQnL4Q2ODh0rSSFq9/tBoooW/1oY0VnOhCZC
 M2ta26K4vDFo2fyMOqn5PSaEj8PLVDwrjls+8cFY628F2kj/211dQCWp9qJ42NkipHkbO18
 jIAFDHotkk7gi+qEb+oQw==
UI-OutboundReport: notjunk:1;M01:P0:2VHdQPL2u6I=;Zz0nv2YwIpMpg2VExAg0Ek0dLaG
 X1yKox28FcOEv429jj6audC1B9abgYLOfP8Q9hN0yyr+zUdHSnv0kFMC0PwjytiQ8QUEWHGEt
 X4DfcW+wjOji86N0hW5uYUtcRcMoOundn2J2Reec2wYjAYm0DdEJzbRQ992sXN6sW+QtpV2aZ
 LMpPOAOsvhSq/XPmdLbAOYo5B7b9KK4bxW2MTilAhhZN0078HmhRNw+oZWIfZB6kYDUr4XGQH
 kj7RXYQmQfSe7hIixl6FdwnYOv3nf6Lt8gHfZn1+BMACEeTDgnNsBsMEoSzcSh4OggVUKQGqk
 y6TS1s9W1tW8Td4wEfNPCdt0d1808RPKYUs6J54pS8meiIVkSdXrxEuMp0FNwwNA11NyVHuMA
 EenUNgRW2uhUNrWQsvDWc3qDT+Swn6KpefIO5XgX9RDb0KmzDaTWC91cTxTNyXq76Quqjo6xq
 FECxyQTAIIcBKqY184bdUTuvcnaYVODq5SC72gmCepAoUI9Qi68V05B5wxJGqP+OTGf53XJq1
 sP7Vze+oo7ONaXMm5qIimf1UAkTei8y7LkY7VhC8abcBsQamt04Ybb6krQR5MVT3LmY8eX924
 Ecig3vqP0HQyeGnPzWXDtFT5nV+ffPR6yfKPVa7ZfC2uKgUZANfzeniTMgFHm1jcutsMMlr8W
 tQIpsbYs4qSIqyMDLBo9SwVffcogJ8qrdNQEE541U0VWvh0jDUFdmd24gMFe8rLkVoQ+5eihM
 PhHiaCoNdfXy8uB/GgPaVutqUdt21OU074TlsN31IosmH/hN6ookrUdEprhspeErZXs7ZFnIN
 3D8OTSDjAxPso2aDEqSV0bV3D0TrYbqDn8H2WCqTvitf8XGCI6900/Mh5QczLi6aK0Z2o3UIS
 2cYQLxl4VRL2hQ1E4fQEuArXOgbDWaaUrbfpIdUcZRlbpA0jIGOWjxVr28CyKWxcb96HZlxdX
 CKdozg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/23 08:53, Jani Nikula wrote:
> On Wed, 08 Mar 2023, Helge Deller <deller@gmx.de> wrote:
>> On 3/7/23 14:08, harperchen wrote:
>>> fb_set_var would by called when user invokes ioctl with cmd
>>> FBIOPUT_VSCREENINFO. User-provided data would finally reach
>>> tgafb_check_var. In case var->pixclock is assigned to zero,
>>> divide by zero would occur when checking whether reciprocal
>>> of var->pixclock is too high.
>>>
>>> Similar crashes have happened in other fbdev drivers. There
>>> is no check and modification on var->pixclock along the call
>>> chain to tgafb_check_var. We believe it could also be triggered
>>> in driver tgafb from user site.
>>>
>>> Signed-off-by: harperchen <harperchen1110@gmail.com>
>>
>> Could you provide a real name?
>> Otherwise applied to fbdev git tree.
>
> See commit d4563201f33a ("Documentation: simplify and clarify DCO
> contribution example language").

Nice. Thanks for that link!
Btw, I did applied that patch yesterday to my tree with just the nickname,
but of course I do prefer real names which is why I asked.

Helge
