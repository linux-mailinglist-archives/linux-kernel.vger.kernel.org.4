Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D89694EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjBMSKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjBMSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:10:29 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACA9033
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:10:13 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5B7A580BA5;
        Mon, 13 Feb 2023 19:10:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676311810;
        bh=iIrxBxhy7Mzx+oWZv3jB2ZryjuRvr5ofMEOdP6OGJqU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RJkqnKZjilek142laNcnJ9fy/rHh5bnC+8ehIs9e9pzWL8elDkRnZDCO8EUMuA0wy
         Rr4Z6/kUKLLM4b+G/rv9X90lmZcYgwYr4YZHL03rNjO90XucdN7psu97M3nEEMSWYm
         pT38+731pGnJtl5DGLgbjnObwXZjAR6sjliFvjjf+RFq/7D83mVmx9uuEcOQYVXIhL
         /P/WZHJdiLocByHeI6V9x/ny0E8ousUhRMWTlK/VKZQ7zHisdhyVf1obrF/z4+ouhb
         JGHUho6RDizUv3bkMZkLB6v7qNeLKM2jLAj41/PtXLzluWWcMQj8y+c0SYkU9oZY7n
         SUToI0HEYhTEA==
Message-ID: <ae011239-5eab-29dc-4b90-87182b0d3a1b@denx.de>
Date:   Mon, 13 Feb 2023 19:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/6] Revert "regulator: pca9450: Add SD_VSEL GPIO for
 LDO5"
Content-Language: en-US
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Frieder Schrempf <frieder@fris.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-4-frieder@fris.de>
 <ee7d0f98-3ae9-7e66-785e-65c9e11a7232@denx.de>
 <4a334087-9c72-2d86-e1d6-5d08ed5adc45@kontron.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <4a334087-9c72-2d86-e1d6-5d08ed5adc45@kontron.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 17:23, Frieder Schrempf wrote:
> On 13.02.23 17:16, Marek Vasut wrote:
>> On 2/13/23 16:58, Frieder Schrempf wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> This reverts commit 8c67a11bae889f51fe5054364c3c789dfae3ad73.
>>>
>>> It turns out that all boards using the PCA9450 actually have the
>>> SD_VSEL input conencted to the VSELECT signal of the SoCs SD/MMC
>>
>> 'connected' , typo .
> 
> Thanks!
> 
>> btw would it make sense to squash 3..5 patches into a single patch ?
> 
> Hm, don't know. I think the changes are easier to understand with the
> current separation between "revert", "core changes" and "pca9450 changes".

OK, I don't mind either way.
