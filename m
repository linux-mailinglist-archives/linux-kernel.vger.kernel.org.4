Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBC61E370
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKFQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKFQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:32:27 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B6EA1B0;
        Sun,  6 Nov 2022 08:32:24 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4N50JK4fNRz9scS;
        Sun,  6 Nov 2022 17:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1667752337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OccA8rWskEjO8SKrGg5kJEkiqge1IiOm2jciYGaQByI=;
        b=YvMtjwM1f2FABAvFqs0+IxAliPfdS7ub4rJi4nibuTBFtcMT3FTy73ArCyCvci+NMm9jEM
        3VFyvCcBLfIMcxgENeFFCZShMv79iYRhKAJWNElNSHgDQAyK9VseBHdx3Xw6/v2I36Mn8o
        oegPV8rVOygrJw7m0K7JRFvi2hAjG2uep2EYMkClYVJScqiDrB26WqXYBHFZpxy4t3htb+
        OZW/GMCILISFi/pjzFutEWlW/wIGdw85dOki5Jp/pU2wQZqbMF7Tbeddy2k/7wSzC2OGBQ
        8Bw2DVtR2b7S/FmgphvcYK+kjOdnAkd3zZKwioikjDz5+O9yqmd87zdOnYsjFQ==
Message-ID: <84838ebd-f2da-9249-02fc-b959faa64c76@sylv.io>
Date:   Sun, 6 Nov 2022 17:32:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "hwmon: (pmbus) Add regulator supply into macro"
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>,
        naresh.solanki@9elements.com
References: <20221104234622.2444747-1-linux@roeck-us.net>
Content-Language: en-US
From:   Marcello Sylverster Bauer <sylv@sylv.io>
In-Reply-To: <20221104234622.2444747-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/22 00:46, Guenter Roeck wrote:
> This reverts commit 54cc3dbfc10dc3db7cb1cf49aee4477a8398fbde.
>
> Zev Weiss reports that the reverted patch may cause a regulator
> undercount. Here is his report:
>
> ... having regulator-dummy set as a supply on my PMBus regulators
> (instead of having them as their own top-level regulators without
> an upstream supply) leads to enable-count underflow errors when
> disabling them:
>
>      # echo 0 > /sys/bus/platform/devices/efuse01/state
>      [  906.094477] regulator-dummy: Underflow of regulator enable count
>      [  906.100563] Failed to disable vout: -EINVAL
>      [  136.992676] reg-userspace-consumer efuse01: Failed to configure state: -22
>
> Zev reports that reverting the patch fixes the problem. So let's do that
> for now.
>
> Fixes: 54cc3dbfc10d ("hwmon: (pmbus) Add regulator supply into macro")
> Cc: Marcello Sylvester Bauer <sylv@sylv.io>
> Reported-by: Zev Weiss <zev@bewilderbeest.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>   drivers/hwmon/pmbus/pmbus.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 7daaf0caf4d3..10fb17879f8e 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -467,7 +467,6 @@ extern const struct regulator_ops pmbus_regulator_ops;
>   #define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step)  \
>   	[_id] = {						\
>   		.name = (_name # _id),				\
> -		.supply_name = "vin",				\
>   		.id = (_id),					\
>   		.of_match = of_match_ptr(_name # _id),		\
>   		.regulators_node = of_match_ptr("regulators"),	\
