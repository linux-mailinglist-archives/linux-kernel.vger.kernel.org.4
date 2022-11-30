Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9027A63CF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiK3GxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiK3GxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:53:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA715490A4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E60B81A67
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6236C433C1;
        Wed, 30 Nov 2022 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669791187;
        bh=EggWEo4gY6wAJqsf5Ch9n9RvX5agJx+Zh7mWiG7SLJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c63HYoQRP63HhfGAXFRzhBRh8b1o5y/5YpPAoO/UJiaFzGS9C1io8veZgzNaX45yp
         aHnt1wyQgabIe9eWSPtISiptkBfOiVPTGkalu1XlbFgDjWkzNd/9qmO6KTRHOO8iqR
         gA06wh8UpWhM2mbBil8Wt5dEl0faGPQrsA6IxrOFMGHDzvgtm63zR/G4J35pi/pc0m
         vA729xWGhY5rseO03g1KMyeO2hpyh50nalG20MPeyV136KL2StSk2II5cIGk5+RhtB
         ntU1WE90oLayO3gLSN34cel8jEXftvaCt4UdsSdckl+XqatOvsKQmOIdSBRT0QDL4R
         6eXxY45Ke8Q6A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p0Gxw-0005Vd-B4; Wed, 30 Nov 2022 07:53:09 +0100
Date:   Wed, 30 Nov 2022 07:53:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware/psci: demote suspend-mode warning to info
 level
Message-ID: <Y4b91JYeuToJ25LD@hovoldconsulting.com>
References: <20221026135445.8004-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026135445.8004-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 03:54:45PM +0200, Johan Hovold wrote:
> On some Qualcomm platforms, like SC8280XP, the attempt to set PC mode
> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> is now logged at warning level:
> 
> 	psci: failed to set PC mode: -3
> 
> As there is nothing users can do about the firmware behaving this way,
> demote the warning to info level and clearly mark it as a firmware bug:
> 
> 	psci: [Firmware Bug]: failed to set PC mode: -3
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/firmware/psci/psci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..f8fa32f0a130 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -165,7 +165,8 @@ int psci_set_osi_mode(bool enable)
>  
>  	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>  	if (err < 0)
> -		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> +		pr_info(FW_BUG "failed to set %s mode: %d\n",
> +				enable ? "OSI" : "PC", err);
>  	return psci_to_linux_errno(err);
>  }

Mark and Lorenzo, I noticed this one hasn't been picked up yet. Is that
something you will do or is Arnd supposed to take it?

Johan
