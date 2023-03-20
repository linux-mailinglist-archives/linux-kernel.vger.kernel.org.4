Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC56C0CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCTJSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCTJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:18:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322617CF1;
        Mon, 20 Mar 2023 02:18:28 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1peBep-0004EZ-O8; Mon, 20 Mar 2023 10:18:23 +0100
Message-ID: <c5383d0e-d33c-d59f-3ee6-4635c1c4d334@leemhuis.info>
Date:   Mon, 20 Mar 2023 10:18:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] media: i2c: imx290: fix conditional function defintions
Content-Language: en-US, de-DE
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230207161316.293923-1-arnd@kernel.org>
 <Y+J+7lsf083k4x80@pendragon.ideasonboard.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <Y+J+7lsf083k4x80@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679303908;9226e0bf;
X-HE-SMSGID: 1peBep-0004EZ-O8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.23 17:40, Laurent Pinchart wrote:
> On Tue, Feb 07, 2023 at 05:13:12PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The runtime suspend/resume functions are only referenced from the
>> dev_pm_ops, but they use the old SET_RUNTIME_PM_OPS() helper
>> that requires a __maybe_unused annotation to avoid a warning:
>>
>> drivers/media/i2c/imx290.c:1082:12: error: unused function 'imx290_runtime_resume' [-Werror,-Wunused-function]
>> static int imx290_runtime_resume(struct device *dev)
>>            ^
>> drivers/media/i2c/imx290.c:1090:12: error: unused function 'imx290_runtime_suspend' [-Werror,-Wunused-function]
>> static int imx290_runtime_suspend(struct device *dev)
>>            ^
>>

I might be missing something (if so, please tell me), but to me it looks
 this fix for a build issue in 6.3-rc (which shows up in Guenters weekly
reports to Linus) didn't make any progress in the past few weeks. Is
there a reason why? Who actually needs to pick it up and send it towards
mainline? Manivannan Sadhasivam? Sakari Ailus?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> Convert this to the new RUNTIME_PM_OPS() helper that so this
>> is not required. To improve this further, also use the pm_ptr()
>> helper that lets the dev_pm_ops get dropped entirely when
>> CONFIG_PM is disabled.
>>
>> A related mistake happened in the of_match_ptr() macro here, which
>> like SET_RUNTIME_PM_OPS() requires the match table to be marked
>> as __maybe_unused, though I could not reproduce building this without
>> CONFIG_OF. Remove the of_match_ptr() here as there is no point in
>> dropping the match table in configurations without CONFIG_OF.
>>
>> Fixes: 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> ---
>>  drivers/media/i2c/imx290.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
>> index 49d6c8bdec41..48ae2e0adf9e 100644
>> --- a/drivers/media/i2c/imx290.c
>> +++ b/drivers/media/i2c/imx290.c
>> @@ -1098,7 +1098,7 @@ static int imx290_runtime_suspend(struct device *dev)
>>  }
>>  
>>  static const struct dev_pm_ops imx290_pm_ops = {
>> -	SET_RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
>> +	RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
>>  };
>>  
>>  /* ----------------------------------------------------------------------------
>> @@ -1362,8 +1362,8 @@ static struct i2c_driver imx290_i2c_driver = {
>>  	.remove = imx290_remove,
>>  	.driver = {
>>  		.name  = "imx290",
>> -		.pm = &imx290_pm_ops,
>> -		.of_match_table = of_match_ptr(imx290_of_match),
>> +		.pm = pm_ptr(&imx290_pm_ops),
>> +		.of_match_table = imx290_of_match,
>>  	},
>>  };
>>  
> 
