Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2646349FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiKVW0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiKVW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:26:21 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B87A376
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:26:19 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id xbiZoVuRqzQOKxbiZoPBam; Tue, 22 Nov 2022 23:26:18 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Nov 2022 23:26:18 +0100
X-ME-IP: 86.243.100.34
Message-ID: <a3c848f9-d825-f9ff-eb6e-a3575d9871ff@wanadoo.fr>
Date:   Tue, 22 Nov 2022 23:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] crypto: amlogic - Save a few bytes of memory
Content-Language: fr, en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <c797dc5e9248498918916a6eeedaa25de2196e8c.1669154149.git.christophe.jaillet@wanadoo.fr>
 <CAFBinCAEwYaEvmGjen_LPO52BcyUFD2EKtzzzfZ1rMuVuihEqA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAFBinCAEwYaEvmGjen_LPO52BcyUFD2EKtzzzfZ1rMuVuihEqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/11/2022 à 23:02, Martin Blumenstingl a écrit :
> On Tue, Nov 22, 2022 at 10:57 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> There is no real point in allocating dedicated memory for the irqs array.
>> MAXFLOW is only 2, so it is easier to allocated the needed space
>> directly within the 'meson_dev' structure.
>>
>> This saves some memory allocation and avoids an indirection when using the
>> irqs array.
> ..and it even fixes a missing devm_kcalloc error check
> 
> Personally I prefer this approach over a patch that was sent earlier today: [0]

Funny.
A file untouched for about 18 months and 2 patches around the same line, 
... the same day!

> Corentin, Christophe, what do you think?

Obviously, mine is better :)

More seriously, I think it is mostly a mater of taste and that both are 
fine. Neither one will make a real difference IRL.

I guess that memory allocation failure in probe are unlikely and saving 
64 bytes (40 for devm_ + 2 x 4 = 48, rounded to 64 bytes) won't make any 
real difference.

Up to you.

CJ
> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://lore.kernel.org/linux-crypto/0df30bbf-3b7e-ed20-e316-41192bf3cc2b@linaro.org/T/#m6a45b44206c282f106d379b01d19027823c5d79b
> 

