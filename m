Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB26A733F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCASQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCASQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:16:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6630457F1;
        Wed,  1 Mar 2023 10:16:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5274061460;
        Wed,  1 Mar 2023 18:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A3C433D2;
        Wed,  1 Mar 2023 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677694596;
        bh=MbNmv1qlx44l2UReHXBKDyqdtXbH1552C0xoBvoenxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aE/Z3aMl+W2YJ0hmOSa7j3h51QCSpwmZG197Kjaahd4LbjVZAc12oMw9E2t1r89OE
         3F8g0VXfkBKu7V8L7hZNwHnHX2LuPR/gy+x3JWHD0bur+zSJGbot0vHZnlZLJZDrS3
         VZrkDyE2NMrPM1zn9mtbXF8IjBT+96OGfOl0bXIVRqqm3qncEe8EaP2WoeQ2WgETLA
         A/uaV80sKgznSw1ZjI2mK5Hb7XpYPw8VjFHVbHn/p2ysBzvHs352kh93+BU6c9C4pX
         D18mk2f3R9srsxdNLOvLZFMOYrtqeDha8DY5+u4dGGKmHgJdL+6I+g9GhQc/u3W5Gx
         vHlarjEXvDCew==
Date:   Wed, 1 Mar 2023 11:16:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: remove bogus do_div()
Message-ID: <Y/+WghSbz3l6uipn@dev-arch.thelio-3990X>
References: <20230214132052.1556699-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214132052.1556699-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Feb 14, 2023 at 02:20:42PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The argument to do_div() is a 32-bit integer, and it was read from a
> 32-bit register so there is no point in doing a 64-bit division on it.
> 
> On 32-bit arm, do_div() causes a compile-time warning here:
> 
> include/asm-generic/div64.h:238:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   238 |   __rem = __div64_32(&(n), __base); \
>       |                      ^~~~
>       |                      |
>       |                      unsigned int *
> drivers/power/supply/qcom_battmgr.c:1130:4: note: in expansion of macro 'do_div'
>  1130 |    do_div(battmgr->status.percent, 100);
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/power/supply/qcom_battmgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index ec31f887184f..de77df97b3a4 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1126,8 +1126,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>  			battmgr->info.charge_type = le32_to_cpu(resp->intval.value);
>  			break;
>  		case BATT_CAPACITY:
> -			battmgr->status.percent = le32_to_cpu(resp->intval.value);
> -			do_div(battmgr->status.percent, 100);
> +			battmgr->status.percent = le32_to_cpu(resp->intval.value) / 100;
>  			break;
>  		case BATT_VOLT_OCV:
>  			battmgr->status.voltage_ocv = le32_to_cpu(resp->intval.value);
> -- 
> 2.39.1
> 

Would you be able to take this patch directly? It seems obviously
correctTM, has an ack from Sebastian [1], and without it, 32-bit
allmodconfig builds are broken [2] (the other warning in that log has a
fix on the way to you soon).

[1]: https://lore.kernel.org/20230214220210.cpviycsmcppylkgj@mercury.elektranox.org/
[2]: https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2MPmxwvmQ7FdpiMhdQN2ZJhcoUP/build.log

Cheers,
Nathan
