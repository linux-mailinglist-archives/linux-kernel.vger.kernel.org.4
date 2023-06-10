Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFF872ADD5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjFJRks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFJRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:40:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D63598
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:40:44 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 82ZrqmMZ9zQvw82ZrqHy0w; Sat, 10 Jun 2023 19:40:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686418842;
        bh=i1Sh8dJjTFlCaTk9M3h35/JWQH6oYT76I7m3djZfolw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VEA3tNb/PUSL7zOwIQfair02JRzCzphQr3ge3mSPNAXlnkyjmc3JiBpettCO1unys
         AhAtPtMCmVDtVVyFveeukhuEuVWEwq614efks87/peyhJa2uqshmN6UJMf3oIXlLuU
         rrM4nHW6p0PBiyaqYHg3PNEptPqP/sYcAD5LA+AOKFF4EU0HyEEkEFpEl3fXDfA0mh
         orueoPfm0tfDv1dmMeSMNQVxnsV37x+odbYL7M+ueFZ29THL5jiTCIDcAOc91yni1Z
         ECkPDFvKvjvo+vqeI2SNcwF9QUO8a/cbsUp6AhtUZV+BAZPxAN1q3jZhAIXCwAI20V
         obvtCJ3JyWOyw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Jun 2023 19:40:42 +0200
X-ME-IP: 86.243.2.178
Message-ID: <dd58a6a5-c65c-ea3b-6ed7-dcbcfc2263bc@wanadoo.fr>
Date:   Sat, 10 Jun 2023 19:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Content-Language: fr, en-US
To:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
 <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
 <20230610145429.uvmxxgxc5tc6x5b5@intel.intel>
 <eb935f16-1f89-0be9-86c9-24e8a88c2d8b@linaro.org>
 <20230610171015.vf7emd5crpr7n4mg@intel.intel>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230610171015.vf7emd5crpr7n4mg@intel.intel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/06/2023 à 19:10, Andi Shyti a écrit :
> On Sat, Jun 10, 2023 at 06:23:58PM +0200, Krzysztof Kozlowski wrote:
>> On 10/06/2023 16:54, Andi Shyti wrote:
>>> On Sat, Jun 10, 2023 at 04:07:51PM +0200, Christophe JAILLET wrote:
>>>> Le 10/06/2023 à 12:26, Andi Shyti a écrit :
>>>>>> @@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>>>>>>    			continue;
>>>>>>    		rate = clk_get_rate(clk);
>>>>>> -		if (!rate)
>>>>>> +		if (!rate) {
>>>>>> +			clk_put(clk);
>>>>>>    			continue;
>>>>>
>>>>> could you also print an error here?
>>>>>
>>>>
>>>> Is:
>>>> 	dev_err(ourport->port.dev,
>>>> 		"Failed to get clock rate for %s.\n", clkname);
>>
>> Why do we need it? Most of other users of clk_get_rate() don't print.
> 
> that's not a reason not to print it.
> 
>> Probably because such condition is highly unlikely if not impossible.
> 
> still... that's not a reason not to print it.
> 
> All errors are unlikely and if it's unlikely, why there is no
> unlikely(!rate)? Which doesn't improve the reason not to print
> it.
> 
> The more unlikely, the lauder you need to be:
> 
> WARN_ON(!rate)... maybe too much!
> BUG_ON(!rate)... way too much!
> 
> But these are inversely proportional to the likeliness of the
> error.
> 
>> This makes simple function unnecessarily bigger...
> 
> and... that's not a reason not to print it :)
> 
> If it's needed, it's needed. If we are considering the error,
> then we need to treat it as an error.
> 
> In any case, I'm not strong with it, indeed, I r-b it anyway. I
> personally prefer and suggested printing the error. Up to
> Christophe.

git grep -A5 clk_get_rate | grep dev_err | wc -l
173
git grep clk_get_rate | wc -l
1464

(+ Krzysztof's argumentation)

So lets go for v1.

Can v1 be taken as is?
(knowing that I don't really care about the new 3/3 related to abs())

Or should I send a v3 to ease the process?

CJ


> 
> Thanks,
> Andi
> 

