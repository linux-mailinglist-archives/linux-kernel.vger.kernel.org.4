Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C282670C472
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEVRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEVRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:36:54 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D16FA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:36:51 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 19Siq1SEJ0h9k19Siqvch6; Mon, 22 May 2023 19:36:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684777010;
        bh=N2xeMMt507hgLYLfEZ8Hr/iAkxhU2Bot31n27SNKL3Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CbtRPseUNMnLVW7YNBpro4cTwHUAf10/+3NYlms9nzDozd9I4w3nY0HrMVDunCe50
         n7ytgccw3z8ursUZ4gnbmIlaau/el9jLxWoMa3JAdrNHRqGGrLM2RV1vCLwJQP5G7N
         uIhwHemIzNXHY1L95+fQuiIm0rpXrbfG01s6cVKc/UUF/OiBOZzDXl414J5LadVLm5
         wbQZ/hsdQlJjpR3QyUh3X6HFdg4G52NVaG5wb278n0+ZoEIsmFgl2Z1CJiHLC4JOOq
         Ka7mqKyL22nKz3QJnnKU3Usiz4vBPfB20Nmtpxn3gxbIFh3UaCCb2Xy362H52FAgzh
         RQbUnvMieiQfA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 May 2023 19:36:50 +0200
X-ME-IP: 86.243.2.178
Message-ID: <fa7a8bc4-d1a1-3b1a-8b9e-618681d281dd@wanadoo.fr>
Date:   Mon, 22 May 2023 19:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v16 1/1] clk: npcm8xx: add clock controller
Content-Language: fr
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230521143202.155399-1-tmaimon77@gmail.com>
 <20230521143202.155399-2-tmaimon77@gmail.com>
 <0e72c35f-5d9d-45a7-5f85-3971b8029106@wanadoo.fr>
 <CAP6Zq1jOSKpzFvto1LMs=JftLK0fxrrg+73Sh34GunuLfcAfEA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAP6Zq1jOSKpzFvto1LMs=JftLK0fxrrg+73Sh34GunuLfcAfEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/05/2023 à 14:56, Tomer Maimon a écrit :
> Hi Christophe,
> 
> Thanks for your comments
> 

[...]

>>> +static struct clk_hw *
>>> +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
>>> +                      const char *name, const struct clk_parent_data *parent,
>>> +                      unsigned long flags)
>>> +{
>>> +     struct npcm8xx_clk_pll *pll;
>>> +     struct clk_init_data init = {};
>>> +     int ret;
>>> +
>>> +     pll = kzalloc(sizeof(*pll), GFP_KERNEL);
>>
>> Everything looks devm_()'ed in this driver, except this kzalloc.
>> Except the one below, there is no kfree to free this memory, and no
>> .remove() function.
> Also  clk_hw_register_divider_parent_data doesn't use devm_
> about free the pll, we use it, return at the end of the function.
> about adding remove, we had a dissection about it in V4, since the
> clock is a service driver it shouldn't be removed.
> https://patchwork.kernel.org/project/linux-watchdog/patch/20220621131424.162355-7-tmaimon77@gmail.com/

LoL.
At least, I'm consistent :).

Just to make it clear, what I mean about kfree() is not to add one here, 
but either:
    - to use devm_kzalloc() here, to avoid a leak, should loading the 
driver fails      OR
    - have some kfree() where needed (at least in the error handling 
path of the probe, if the remove function makes no point)

CJ
