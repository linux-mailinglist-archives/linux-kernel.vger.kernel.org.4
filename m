Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D5561EDE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiKGI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:56:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BBF15836;
        Mon,  7 Nov 2022 00:56:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B85FB80E59;
        Mon,  7 Nov 2022 08:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FF3C433D6;
        Mon,  7 Nov 2022 08:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811395;
        bh=mRQqDDo7h2WtOH56vRgwnhYTYbCXcOsZBM0uKXEWQ+Y=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=HIRQu2IRF9Jddq2VZbtwVA7irRrBf0ivmSk6B0iqHD9LnZkrTxqOhB9w7cDYRxxeG
         UEjoq8H95pL9q8mW9zfyeAxwF3Qf0HezTTcaC744Z2i7FPBKs+w2nS9uPlwfdMopN2
         XjpVI1Xf0cFru/UxK8Aeetl1LPAy9wdw9xSxg1HwZzqgvdzPdDEFgIZcFYjnwEFj7X
         R/2yQvK+mNv9SG5Tw0g7lfkwr2jc6/V/Xq0+I4Wmaw58YknBNYf0rkSBOlbNPQKnJZ
         SXDONxBn2MnRMiyAcm6x56dl+NrEKlioY0X/NdogX6+pFsvT6Q7JkCIDiYaNv8rlZn
         pOinaR69fud9w==
Message-ID: <e4e4c4f0-782b-9f89-d7a2-859c7759ca66@kernel.org>
Date:   Mon, 7 Nov 2022 10:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Coverity: gpmc_is_valid_waitpin(): Control flow issues
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
To:     coverity-bot <keescook@chromium.org>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
References: <202211041233.4D45359E7@keescook>
 <7cdf3d14-3f1b-7cd4-e8b9-e94b5359bf82@kernel.org>
In-Reply-To: <7cdf3d14-3f1b-7cd4-e8b9-e94b5359bf82@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 10:53, Roger Quadros wrote:
> Hi Benedikt,
> 
> On 04/11/2022 21:33, coverity-bot wrote:
>> Hello!
>>
>> This is an experimental semi-automated report about issues detected by
>> Coverity from a scan of next-20221104 as part of the linux-next scan project:
>> https://scan.coverity.com/projects/linux-next-weekly-scan
>>
>> You're getting this email because you were associated with the identified
>> lines of code (noted below) that were touched by commits:
>>
>>   Wed Nov 2 10:02:39 2022 -0400
>>     89aed3cd5cb9 ("memory: omap-gpmc: wait pin additions")
>>
>> Coverity reported the following:
>>
>> *** CID 1527139:  Control flow issues  (NO_EFFECT)
>> drivers/memory/omap-gpmc.c:1048 in gpmc_is_valid_waitpin()
>> 1042     	spin_unlock(&gpmc_mem_lock);
>> 1043     }
>> 1044     EXPORT_SYMBOL(gpmc_cs_free);
>> 1045
>> 1046     static bool gpmc_is_valid_waitpin(u32 waitpin)
> 
> We will need to change this waitpin argument to int.
> In addition we will also need to change
> struct gpmc_waitpin->pin and struct gpmc_setting->wait_pin
> to int as in the code we are relying on GPMC_WAITPIN_INVALID logic which is -1.

Another alternative with less churn is to leave them as u32
but make GPMC_WAITPIN_INVALID set to a large positive number.

> 
>> 1047     {
>> vvv     CID 1527139:  Control flow issues  (NO_EFFECT)
>> vvv     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "waitpin >= 0U".
>> 1048     	return waitpin >= 0 && waitpin < gpmc_nr_waitpins;
>> 1049     }
>> 1050
>> 1051     static int gpmc_alloc_waitpin(struct gpmc_device *gpmc,
>> 1052     			      struct gpmc_settings *p)
>> 1053     {
>>
>> If this is a false positive, please let us know so we can mark it as
>> such, or teach the Coverity rules to be smarter. If not, please make
>> sure fixes get into linux-next. :) For patches fixing this, please
>> include these lines (but double-check the "Fixes" first):
>>
>> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
>> Addresses-Coverity-ID: 1527139 ("Control flow issues")
>> Fixes: 89aed3cd5cb9 ("memory: omap-gpmc: wait pin additions")
>>
>> Thanks for your attention!
>>
> 

cheers,
-roger
