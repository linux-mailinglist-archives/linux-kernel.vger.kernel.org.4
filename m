Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38DD6E2E58
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 03:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDOB5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 21:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOB5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 21:57:18 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B64692;
        Fri, 14 Apr 2023 18:57:15 -0700 (PDT)
Received: from [IPV6:2408:824e:f23:41b0:7819:c897:bdb2:2a7c] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33F1tl6O019421-33F1tl6P019421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 15 Apr 2023 09:55:48 +0800
Message-ID: <470c192a-8170-6ea9-eb14-aa678555a789@hust.edu.cn>
Date:   Sat, 15 Apr 2023 09:55:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in
 'imx8mm_clocks_probe'
To:     Dan Carpenter <error27@gmail.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abelvesa@kernel.org>, Bai Ping <ping.bai@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhou Shide <u201911681@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hao Luo <m202171776@hust.edu.cn>
References: <20230413032439.1706448-1-u201911681@hust.edu.cn>
 <25b06794ffb595229019640e10f256fd.sboyd@kernel.org>
 <c37446f6-bfd6-456d-80aa-542fb2139929@kili.mountain>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <c37446f6-bfd6-456d-80aa-542fb2139929@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/15 00:38, Dan Carpenter wrote:
> On Thu, Apr 13, 2023 at 12:06:59PM -0700, Stephen Boyd wrote:
>> Quoting Zhou Shide (2023-04-12 20:24:39)
>>> The function imx8mm_clocks_probe() has two main issues:
>>> - The of_iomap() function may cause a memory leak.
>>> - Memory allocated for 'clk_hw_data' may not be freed properly
>>> in some paths.
>>>
>>> To fix these issues, this commit replaces the use of of_iomap()
>>> with devm_of_iomap() and replaces kzalloc() with devm_kzalloc().
>>> This ensures that all memory is properly managed and automatically
>>> freed when the device is removed.
>>>
>>> In addition, when devm_of_iomap() allocates memory with an error,
>>> it will first jump to label "unregister_hws" and
>>> then return PTR_ ERR(base).
>>>
>>> Fixes: 9c71f9ea35d7 ("clk: imx: imx8mm: Switch to clk_hw based API")
>>> Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
>>> Signed-off-by: Zhou Shide <u201911681@hust.edu.cn>
>>> ---
>>> The issue is discovered by static analysis, and the patch is not tested yet.
>> And you're not coordinating with each other?
>>
> This is a university program.  The patches are reviewed by his professor
> and teaching assistants etc.  I've been reviewing some of these patches
> as well because of they're using Smatch.

Thanks for your explanation, Dan. We are from Huazhong University of 
Science and Technology.

Some undergraduate and graduatestudents who are interested in Linux 
Kernel are guided by me [1] and Dan to contribute into our kernel community.

We found Smatch is really great in finding kernel issues and these 
issues are suitable for undergraduate students. Therefore, I contacted 
Dan to do a favor for patch interview. And our internal review are 
publicly hosted in a google group [2].

Please let me know if you have any questions.

[1] https://mudongliang.github.io/about/

[2] https://groups.google.com/g/hust-os-kernel-patches

>
> regards,
> dan carpenter
>
