Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032661EDA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiKGIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKGIx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:53:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3C5F6C;
        Mon,  7 Nov 2022 00:53:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0C5460F49;
        Mon,  7 Nov 2022 08:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5760AC433C1;
        Mon,  7 Nov 2022 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811237;
        bh=MkGqyvrlKZCyXWKRmtTmz66/zHNHcStkTmoWNHfjow0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m3uI7jARqaZ3dTske6Q8K75F79f36XLSAdpj4g0a4dY6EN4VBldLunb4bhEhYkU7k
         VzoqAZMgr/xVZBpCCtq2e2TJEiYmxNpDxgC1dDq/X5peXL6YKRn0t7U0Vb7Y9iPFf0
         ubWO1kzNSfbPGXo0hfjnUegDhstaltL6sqVYRixhsbKePiObtc76/ppoBIn8HQbDoA
         6NX7AMUatoyB2fXlTWz4pXkUepETr+MaiDMqbjcuJgly8viRFNQYWpGrRNlRyDig+r
         YFFbTFQBYrSPbg+2iRWZF/HZaNjwTp2Vmn5Qx7QITRzEaOmkKrN8aUuryYgmZgg4Ms
         XeazdZG51CWpw==
Message-ID: <7cdf3d14-3f1b-7cd4-e8b9-e94b5359bf82@kernel.org>
Date:   Mon, 7 Nov 2022 10:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Coverity: gpmc_is_valid_waitpin(): Control flow issues
Content-Language: en-US
To:     coverity-bot <keescook@chromium.org>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
References: <202211041233.4D45359E7@keescook>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <202211041233.4D45359E7@keescook>
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

Hi Benedikt,

On 04/11/2022 21:33, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221104 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Wed Nov 2 10:02:39 2022 -0400
>     89aed3cd5cb9 ("memory: omap-gpmc: wait pin additions")
> 
> Coverity reported the following:
> 
> *** CID 1527139:  Control flow issues  (NO_EFFECT)
> drivers/memory/omap-gpmc.c:1048 in gpmc_is_valid_waitpin()
> 1042     	spin_unlock(&gpmc_mem_lock);
> 1043     }
> 1044     EXPORT_SYMBOL(gpmc_cs_free);
> 1045
> 1046     static bool gpmc_is_valid_waitpin(u32 waitpin)

We will need to change this waitpin argument to int.
In addition we will also need to change
struct gpmc_waitpin->pin and struct gpmc_setting->wait_pin
to int as in the code we are relying on GPMC_WAITPIN_INVALID logic which is -1.

> 1047     {
> vvv     CID 1527139:  Control flow issues  (NO_EFFECT)
> vvv     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "waitpin >= 0U".
> 1048     	return waitpin >= 0 && waitpin < gpmc_nr_waitpins;
> 1049     }
> 1050
> 1051     static int gpmc_alloc_waitpin(struct gpmc_device *gpmc,
> 1052     			      struct gpmc_settings *p)
> 1053     {
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527139 ("Control flow issues")
> Fixes: 89aed3cd5cb9 ("memory: omap-gpmc: wait pin additions")
> 
> Thanks for your attention!
> 

cheers,
-roger
