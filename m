Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489B274D840
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGJN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGJN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA37D2;
        Mon, 10 Jul 2023 06:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9BF60FF2;
        Mon, 10 Jul 2023 13:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB0C433C8;
        Mon, 10 Jul 2023 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688997360;
        bh=Cb3zN0i3LpQdGPrnW/9rBdcgLOPCUpIjjFIxHlihHi4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dhr4ZeDvlFhsy3Uw9KN5krszlhdTd1zBWqzGJDRe0od/qNZrUnZPqLPGLGjvd+74z
         8A2LULl/yLB8WQUIAuod9dyhUI9r96GhGQPX8M/bzdUwodLyRq/Lm5GXEhiqOm/sQp
         evbNwTdLltu7J952obKxobtDTLRyhjM/oY99GIBUHY9QV68y+F5Fk94O82l5TU1Hgq
         x0hoAdnoCwprW6QPyAfmgMHbxl0qFRNVStLHKOaDbRmDSsito4qSCR6G7LxtBk4Tv7
         SBtHStPhoyB6fzeOCxG/NOPfECBOco0UDy3DYSM1YSs4nGAouRypVZ6aU04eDuSUGM
         5jdgsnFN4WvpQ==
Message-ID: <6db7b1ba-6b5b-3aef-fff7-e36a8fe5739d@kernel.org>
Date:   Mon, 10 Jul 2023 15:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/21] thermal/drivers/tegra: convert to use
 devm_request*_irq_probe()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710095926.15614-1-frank.li@vivo.com>
 <20230710095926.15614-5-frank.li@vivo.com> <ZKwEvJR5tYVsC0HM@orome>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZKwEvJR5tYVsC0HM@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 15:16, Thierry Reding wrote:
> On Mon, Jul 10, 2023 at 05:59:09PM +0800, Yangtao Li wrote:
>> There are more than 700 calls to devm_request_threaded_irq method and
>> more than 1000 calls to devm_request_irq method. Most drivers only
>> request one interrupt resource, and these error messages are basically
>> the same. If error messages are printed everywhere, more than 2000 lines
>> of code can be saved by removing the msg in the driver.
>>
>> And tglx point out that:
>>
>>   If we actually look at the call sites of
>>   devm_request_threaded_irq() then the vast majority of them print more or
>>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>>
>>      519 messages total (there are probably more)
>>
>>      352 unique messages
>>
>>      323 unique messages after lower casing
>>
>>          Those 323 are mostly just variants of the same patterns with
>>          slight modifications in formatting and information provided.
>>
>>      186 of these messages do not deliver any useful information,
>>          e.g. "no irq", "
>>
>>      The most useful one of all is: "could request wakeup irq: %d"
>>
>>   So there is certainly an argument to be made that this particular
>>   function should print a well formatted and informative error message.
>>
>>   It's not a general allocator like kmalloc(). It's specialized and in the
>>   vast majority of cases failing to request the interrupt causes the
>>   device probe to fail. So having proper and consistent information why
>>   the device cannot be used _is_ useful.
>>
>> So convert to use devm_request*_irq_probe() API, which ensure that all
>> error handling branches print error information.
>>
>> In this way, when this function fails, the upper-layer functions can
>> directly return an error code without missing debugging information.
>> Otherwise, the error message will be printed redundantly or missing.
> 
> Do we really need to keep repeating this same commit message for each
> and everyone of these commits? It's already in the cover letter and
> presumably on the patch that introduces the new helper, so surely we can
> come up with a denser version for individual subsystem patches.

Yeah, this is way too long to put in every commit doing the same but for
different drivers.

Best regards,
Krzysztof

