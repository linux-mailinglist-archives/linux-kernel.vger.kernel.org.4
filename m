Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2278E67D3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjAZSCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAZSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:02:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8CB1298F1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:02:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6054B3;
        Thu, 26 Jan 2023 10:03:04 -0800 (PST)
Received: from [10.57.76.43] (unknown [10.57.76.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E11B33F71E;
        Thu, 26 Jan 2023 10:02:20 -0800 (PST)
Message-ID: <7ec6bd88-7f18-7eca-fa92-cfea9a25a395@arm.com>
Date:   Thu, 26 Jan 2023 18:02:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] Coresight: tpda/tpdm: remove incorrect __exit annotation
To:     Arnd Bergmann <arnd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230126163530.3495413-1-arnd@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230126163530.3495413-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 26/01/2023 16:35, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> 'remove' callbacks get called whenever a device is unbound from
> the driver, which can get triggered from user space.
> 
> Putting it into the __exit section means that the function gets
> dropped in for built-in drivers, as pointed out by this build
> warning:

> 
> `tpda_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tpda.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tpda.o
> `tpdm_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tpdm.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tpdm.o
> 

Thanks for the fix, I will queue this. Btw, I did try to
reproduce it locally, but couldn't trigger the warnings,
even with

CONFIG_WERROR=y

and all CORESIGHT configs builtin. I see other drivers doing the
same outside coresight too. Just curious to know why is this
any different. Is it specific to "bus" driver (e.g. AMBA) ?

Suzuki


> Fixes: 5b7916625c01 ("Coresight: Add TPDA link driver")
> Fixes: b3c71626a933 ("Coresight: Add coresight TPDM source driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 2 +-
>   drivers/hwtracing/coresight/coresight-tpdm.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 19c25c9f6157..382d648529e7 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -174,7 +174,7 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>   	return 0;
>   }
>   
> -static void __exit tpda_remove(struct amba_device *adev)
> +static void tpda_remove(struct amba_device *adev)
>   {
>   	struct tpda_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 349a82bb3270..9479a5e8c672 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -223,7 +223,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   	return 0;
>   }
>   
> -static void __exit tpdm_remove(struct amba_device *adev)
> +static void tpdm_remove(struct amba_device *adev)
>   {
>   	struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>   

