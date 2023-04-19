Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF426E7091
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjDSA5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDSA5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:57:17 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D928A250;
        Tue, 18 Apr 2023 17:57:06 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:2570:678:bb4e:e0e8] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33J0t72O020463-33J0t72P020463
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 19 Apr 2023 08:55:09 +0800
Message-ID: <918bf8b1-6da6-943b-3cbe-e15a24c9de6f@hust.edu.cn>
Date:   Wed, 19 Apr 2023 08:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in
 'imx8mm_clocks_probe'
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?5ZGo5biI5b63?= <u201911681@hust.edu.cn>
Cc:     abel vesa <abelvesa@kernel.org>, bai ping <ping.bai@nxp.com>,
        fabio estevam <festevam@gmail.com>,
        michael turquette <mturquette@baylibre.com>,
        nxp linux team <linux-imx@nxp.com>,
        peng fan <peng.fan@nxp.com>,
        pengutronix kernel team <kernel@pengutronix.de>,
        sascha hauer <s.hauer@pengutronix.de>,
        shawn guo <shawnguo@kernel.org>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hao luo <m202171776@hust.edu.cn>
References: <20230413032439.1706448-1-u201911681@hust.edu.cn>
 <25b06794ffb595229019640e10f256fd.sboyd@kernel.org>
 <5e18370b.3c8a8.1877d7fc98a.Coremail.u201911681@hust.edu.cn>
 <86398a778336846688c33a737e2a9ae2.sboyd@kernel.org>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <86398a778336846688c33a737e2a9ae2.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/19 03:57, Stephen Boyd wrote:
> Quoting 周师德 (2023-04-13 19:02:19)
>>
>>
>>> -----原始邮件-----
>>> 发件人: "Stephen Boyd" <sboyd@kernel.org>
>>> 发送时间: 2023-04-14 03:06:59 (星期五)
>>> 收件人: "Abel Vesa" <abelvesa@kernel.org>, "Bai Ping" <ping.bai@nxp.com>, "Fabio Estevam" <festevam@gmail.com>, "Michael Turquette" <mturquette@baylibre.com>, "NXP Linux Team" <linux-imx@nxp.com>, "Peng Fan" <peng.fan@nxp.com>, "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Zhou Shide" <u201911681@hust.edu.cn>
>>> 抄送: hust-os-kernel-patches@googlegroups.com, "Zhou Shide" <u201911681@hust.edu.cn>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Hao Luo" <m202171776@hust.edu.cn>
>>> 主题: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in 'imx8mm_clocks_probe'
>>>
>>> Quoting Zhou Shide (2023-04-12 20:24:39)
>>>> The function imx8mm_clocks_probe() has two main issues:
>>>> - The of_iomap() function may cause a memory leak.
>>>> - Memory allocated for 'clk_hw_data' may not be freed properly
>>>> in some paths.
>>>>
>>>> To fix these issues, this commit replaces the use of of_iomap()
>>>> with devm_of_iomap() and replaces kzalloc() with devm_kzalloc().
>>>> This ensures that all memory is properly managed and automatically
>>>> freed when the device is removed.
>>>>
>>>> In addition, when devm_of_iomap() allocates memory with an error,
>>>> it will first jump to label "unregister_hws" and
>>>> then return PTR_ ERR(base).
>>>>
>>>> Fixes: 9c71f9ea35d7 ("clk: imx: imx8mm: Switch to clk_hw based API")
>>>> Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
>>>> Signed-off-by: Zhou Shide <u201911681@hust.edu.cn>
>>>> ---
>>>> The issue is discovered by static analysis, and the patch is not tested yet.
>>> And you're not coordinating with each other?
>> What do you mean by "coordinating with each other"?
>>
> I see two patches to the same driver from the same university on the
> list. Preferably you coordinate and decide who will fix what smatch
> warnings.

Hi Stephen,

As their advisor, I coordinate and assign smatch warnings to each 
student. I double check our assignment table:

drivers/clk/imx/clk-imx8mn.c:612 imx8mn_clocks_probe() warn: 'base' from 
of_iomap() not released on lines: 612.
drivers/clk/imx/clk-imxrt1050.c:154 imxrt1050_clocks_probe() warn: 
'pll_base' from of_iomap() not released on lines: 108,154.
drivers/clk/imx/clk-imx8mm.c:619 imx8mm_clocks_probe() warn: 'base' from 
of_iomap() not released on lines: 403,619.
drivers/clk/imx/clk-imx8mq.c:611 imx8mq_clocks_probe() warn: 'base' from 
of_iomap() not released on lines: 399,611.

There are four similar warnings from your subsystem. If I understand 
correctly, two students are patching issues from different probe 
functions in the different files since we assign all issues in one file 
to one student. Maybe you mix clk-imx8mn (Hao Luo) and clk-imx8mm(Shide 
Zhou). They only differ in one char.

If I miss anything, please let me know. Next time, I will ask one 
student to fix the issues in one subsystem. This can simply the effort 
spent by other student.

Dongliang Mu

>
