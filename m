Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122D6D3630
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDBIXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDBIXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:23:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E995A10264
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 01:23:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iszLpCRz4xuxqiszLpYwjS; Sun, 02 Apr 2023 10:22:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Apr 2023 10:22:59 +0200
X-ME-IP: 86.243.2.178
Message-ID: <0a5fa878-b7c3-b5a3-8ffa-b3a2dcdc400d@wanadoo.fr>
Date:   Sun, 2 Apr 2023 10:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clk: Reorder fields in 'struct clk_fractional_divider'
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <d1874eb8848d5f97f87337011188640a1463a666.1676649335.git.christophe.jaillet@wanadoo.fr>
 <2e74c4c93f4bcc6a7af0c3ef5a8edd23.sboyd@kernel.org>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2e74c4c93f4bcc6a7af0c3ef5a8edd23.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/03/2023 à 20:46, Stephen Boyd a écrit :
> Quoting Christophe JAILLET (2023-02-17 07:55:55)
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index cf1adfeaf257..8cec844f5dde 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -1134,13 +1134,13 @@ struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
>>   struct clk_fractional_divider {
>>          struct clk_hw   hw;
>>          void __iomem    *reg;
>> +       u8              flags;
>>          u8              mshift;
>>          u8              mwidth;
>>          u32             mmask;
> 
> This member ...
> 
>>          u8              nshift;
>>          u8              nwidth;
>>          u32             nmask;
> 
> and this member can be calculated. Doing that would save more bytes when
> combined with this patch. Can you make this into a patch series?

Hi,

with your proposed change, there is no more need to move flags. All u8 
are grouped and the struct is optimal.

I'll send a v2, but not sure it really worth it.
When dynamically allocated, even when the struct is 56 bytes, 64 are 
still allocated.
And there are only 2 users of struct clk_fractional_divider embedded in 
another struct that will be shrinked with your change.

On the other side, having theses masks pre-computed could save a few 
cycles, at nearly no memory usage impact.

I'll let you decide if v1 or v2 is the preferred way to go.

CJ

> 
>> -       u8              flags;
>>          void            (*approximation)(struct clk_hw *hw,
>>                                  unsigned long rate, unsigned long *parent_rate,
>>                                  unsigned long *m, unsigned long *n);
> 

