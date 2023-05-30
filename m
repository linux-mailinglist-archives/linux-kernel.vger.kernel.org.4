Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5B715581
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjE3G1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjE3G1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:27:53 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD3DDC;
        Mon, 29 May 2023 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=b7rmr1U6NpOP1rc+VsCmDNiHKzP9/EyA9LTy90O+r9w=;
        b=l0nWpOUULxiYEK3NQkUQn4EL6e8tYHjOqojhWxpc91PZbplcGzSq/EwSKxzOPX
        yomRrGSZnPziXmY3gavCJx2D3025DxwVFCNCz6xVurv0VregC364c0pHKJ6Gxb/Z
        YGGaHmpMQa8725fixutlyJKt4kVe/4lq13vyxC3CJl158=
Received: from [172.20.10.4] (unknown [39.144.137.62])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wCHRKI9l3VkwIjVAw--.26122S3;
        Tue, 30 May 2023 14:27:11 +0800 (CST)
Message-ID: <5428dcc3-bcaf-2fff-59db-62d3b3b45d17@163.com>
Date:   Tue, 30 May 2023 14:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Content-Language: en-US
To:     andy.shevchenko@gmail.com, simon.guinot@sequanux.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        henning.schild@siemens.com, xingtong.wu@siemens.com
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com> <ZHSZ9cK78qc5QeZD@localhost>
 <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
 <ZHSunJyh2AU1eb0H@localhost> <ZHUmHkbM-l_pRaY3@surfacebook>
From:   "xingtong.wu" <xingtong_wu@163.com>
In-Reply-To: <ZHUmHkbM-l_pRaY3@surfacebook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHRKI9l3VkwIjVAw--.26122S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryUWF43Kw4DGFyxur48WFg_yoW8CF17pF
        W7CF42yF4kt3Z3Krn2kF4jvFyYvFZrtFs8WF1Fkr4UZry5ua48Xr4I9w45uFy3Xw4fGw4a
        yF4qg347G3ZrZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlfOrUUUUU=
X-Originating-IP: [39.144.137.62]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiOwJ-0GC5lvAeEAAAsn
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/30 06:24, andy.shevchenko@gmail.com wrote:
> Mon, May 29, 2023 at 03:54:36PM +0200, simon.guinot@sequanux.org kirjoitti:
>> On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
>>> On Mon, May 29, 2023 at 2:27 PM <simon.guinot@sequanux.org> wrote:
>>>
>>>> It would be nice if a pin number found in the device datasheet could
>>>> still be converted into a Linux GPIO number by adding the base of the
>>>> first bank.
>>>
>>> We actively discourage this kind of mapping because of reasons stated
>>> in drivers/gpio/TODO: we want dynamic number allocation to be the
>>> norm.
>>
>> Sure but it would be nice to have a dynamic base applied to a controller
>> (and not to each chip of this controller), and to respect the interval
>> between the chips (as stated in the controllers datasheets).
> 
> What you want is against the architecture. To fix this, you might change
> the architecture of the driver to have one chip for the controller, but
> it's quite questionable change. Also how can you guarantee ordering of
> the enumeration? You probably need to *disable* SMP on the boot time.
> This will still be fragile as long as GPIO chip can be unbound at run
> time. Order can be changed.
> 
> So, the patch is good and the correct way to go.
> 
> P.S. The root cause is that hardware engineers and documentation writers
> do not consider their hardware in the multi-tasking, multi-user general
> purpose operating system, such as Linux. I believe the ideal fix is to fix the
> documentation (datasheet).
> 

Hi,

Thanks for your review.

The direct reason of this patch is that when "modprobe gpio-f7188x",
it conflicts with INT34C6. I met this issue on an older kernel, but
could not remember which version exactly.

The error message is as the link below:
https://elixir.bootlin.com/linux/v6.3.2/source/drivers/gpio/gpiolib.c#L798

- XingTong Wu

