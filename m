Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592B36E5BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDRIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDRIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725911713;
        Tue, 18 Apr 2023 01:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED8A62E6E;
        Tue, 18 Apr 2023 08:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817B7C433D2;
        Tue, 18 Apr 2023 08:23:27 +0000 (UTC)
Message-ID: <012f0c40-5b69-0846-adba-b67850c20a12@xs4all.nl>
Date:   Tue, 18 Apr 2023 10:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: nxp: ignore unused suspend operations
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Guoniu Zhou <guoniu.zhou@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230418071605.2971866-1-arnd@kernel.org>
 <695e9f88-5a79-7ca4-645f-047b78495a80@xs4all.nl>
 <20230418081959.GB30837@pendragon.ideasonboard.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230418081959.GB30837@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 18/04/2023 10:19, Laurent Pinchart wrote:
> On Tue, Apr 18, 2023 at 10:04:13AM +0200, Hans Verkuil wrote:
>> Hi Arnd,
>>
>> On 18/04/2023 09:15, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> gcc warns about some functions being unused when CONFIG_PM is
>>> disabled:
>>
>> ???
>>
>> The Kconfig has a:
>>
>>         depends on HAS_DMA && PM
>>
>> So how can this be compiled with CONFIG_PM not set?
>>
>> Am I missing something?
> 
> The warning appears when CONFIG_PM_SLEEP is disabled. The pm_ptr()
> change is thus not useful, but the switch to SYSTEM_SLEEP_PM_OPS() and
> RUNTIME_PM_OPS() make a difference.

Can you post a v3?

Thank you!

	Hans

> 
>>> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:328:12: error: 'mxc_isi_pm_resume' defined but not used [-Werror=unused-function]
>>>   328 | static int mxc_isi_pm_resume(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~~~~
>>> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:314:12: error: 'mxc_isi_pm_suspend' defined but not used [-Werror=unused-function]
>>>   314 | static int mxc_isi_pm_suspend(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~~~~~
>>>
>>> Use the modern SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers in place
>>> of the old SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS() ones, and add
>>> a pm_ptr() check to ensure they get dropped by the compiler.
>>>
>>> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
>>> index 238521622b75..253e77189b69 100644
>>> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
>>> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
>>> @@ -378,8 +378,8 @@ static int mxc_isi_runtime_resume(struct device *dev)
>>>  }
>>>  
>>>  static const struct dev_pm_ops mxc_isi_pm_ops = {
>>> -	SET_SYSTEM_SLEEP_PM_OPS(mxc_isi_pm_suspend, mxc_isi_pm_resume)
>>> -	SET_RUNTIME_PM_OPS(mxc_isi_runtime_suspend, mxc_isi_runtime_resume, NULL)
>>> +	SYSTEM_SLEEP_PM_OPS(mxc_isi_pm_suspend, mxc_isi_pm_resume)
>>> +	RUNTIME_PM_OPS(mxc_isi_runtime_suspend, mxc_isi_runtime_resume, NULL)
>>>  };
>>>  
>>>  /* -----------------------------------------------------------------------------
>>> @@ -528,7 +528,7 @@ static struct platform_driver mxc_isi_driver = {
>>>  	.driver = {
>>>  		.of_match_table = mxc_isi_of_match,
>>>  		.name		= MXC_ISI_DRIVER_NAME,
>>> -		.pm		= &mxc_isi_pm_ops,
>>> +		.pm		= pm_ptr(&mxc_isi_pm_ops),
>>>  	}
>>>  };
>>>  module_platform_driver(mxc_isi_driver);
> 

