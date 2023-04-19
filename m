Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD176E729E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 07:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjDSF2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 01:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDSF2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 01:28:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C659E8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:28:11 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id p0MRpZaTeV6zQp0MSpuMmN; Wed, 19 Apr 2023 07:28:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681882089;
        bh=jC61ievN8K0lZul4ppyD2rNmFatQL2HAWgkWwqbudT8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TNshuw7F7d0G7Paxh6aHXOd6LSAqwbWrBaZePemtxzGdjyuWE40w23q+dyxZWNAFT
         IMgiYRkp30RpW2ME6YXV9mno+wtjdYC/TD0vOZgAv/x5PsvWYvguzVWccLP+EJL4V+
         wfS5fnGA1rwmLzmpR77uJU4JzByxFGmRZKNG5P0Z2rtigu+iZv7U9onUWUTVzTXgZY
         /ab7ij2IhImZVKq1p5pRPHkIGZUUOTsqWvKng8djZrWwO8NUVmdrMFZRL6uMwRvpP9
         XOn/IaJYqsc4FITkpSAPFThgEpUzdaRfy+KQh/kBWefttthUH+mTYXZTh3XyFynBoW
         EYDLKZjulzleA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 19 Apr 2023 07:28:09 +0200
X-ME-IP: 86.243.2.178
Message-ID: <5f749397-d701-a83c-757b-cad38f74735f@wanadoo.fr>
Date:   Wed, 19 Apr 2023 07:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] video: fbdev: mmp: Fix deferred clk handling in
 mmphw_probe()
To:     Dan Carpenter <error27@gmail.com>
Cc:     Helge Deller <deller@gmx.de>, Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <685f452cacc74f4983aaff2bc28a02a95e8aa8b7.1681414375.git.christophe.jaillet@wanadoo.fr>
 <67353089-4966-424c-99c2-8524818f0e37@kili.mountain>
 <a7c75eb0-857c-4755-aa23-0a4a96a6d2ca@kili.mountain>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <a7c75eb0-857c-4755-aa23-0a4a96a6d2ca@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/04/2023 à 06:59, Dan Carpenter a écrit :
> On Sat, Apr 15, 2023 at 04:09:03PM +0300, Dan Carpenter wrote:
>> On Thu, Apr 13, 2023 at 09:33:17PM +0200, Christophe JAILLET wrote:
>>> When dev_err_probe() is called, 'ret' holds the value of the previous
>>> successful devm_request_irq() call.
>>> 'ret' should be assigned with a meaningful value before being used in
>>> dev_err_probe().
>>>
>>> While at it, use and return "PTR_ERR(ctrl->clk)" instead of a hard-coded
>>> "-ENOENT" so that -EPROBE_DEFER is handled and propagated correctly.
>>>
>>> Fixes: 81b63420564d ("video: fbdev: mmp: Make use of the helper function dev_err_probe()")
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>
>> Presumably you already wrote a Coccinelle script for this but I've added
>> it to Smatch as well.

No I haven't.
I've spotted it while looking at some devm_clk_get_optional() candidate 
with grep.

	git grep -A5 devm_clk_get | grep -B5 ENOENT

Not perfect, but sometimes this kind of approach can find interesting 
things coccinelle would miss.

As an example, the bitmap_alloc patch on sh4 was found this way, with grep.



So nice to have it in smatch, ;-)

CJ

> 
> Here is this warning:
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c:518 mmphw_probe() warn: passing zero to 'dev_err_probe'
> 
> Other warnings.  All five are interesting.
> drivers/power/supply/rt9467-charger.c:1026 rt9467_request_interrupt() warn: passing zero to 'dev_err_probe'
> drivers/pci/controller/dwc/pcie-bt1.c:601 bt1_pcie_add_port() warn: passing zero to 'dev_err_probe'
> drivers/spi/spi-sprd-adi.c:570 sprd_adi_probe() warn: passing zero to 'dev_err_probe'
> drivers/soc/qcom/icc-bwmon.c:776 bwmon_probe() warn: passing zero to 'dev_err_probe'
> drivers/soc/qcom/icc-bwmon.c:781 bwmon_probe() warn: passing zero to 'dev_err_probe'
> 
> regards,
> dan carpenter
> 
> 

