Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61E6CA254
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjC0L1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjC0L1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:27:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B544684
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B4FFB810DC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A81C433D2;
        Mon, 27 Mar 2023 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679916418;
        bh=AA9PB0i43UEXirMyagzIG+tyedd7MXwYR2/xrRobVAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/Qnd73zbnm3lFU9+b0sx8BxpXM3GmR+e4/TXolcOieW3b0sVF/hS1y9LIZ1+XTZ+
         bo2Ydn7TGlrwtZhgTD227V6nW4rpF5hPWRn+Nl1OqxBW3UL8Ylg74Q375H6lxy1Tj/
         w9SKAoW6XX+LcECu0JNz8ZTfgShzWF4I2++U1ZTSe1qZRIgngzHSoZohbhimtf7WpB
         KialyK+slDIVQREyPr8natKc9hoDj0TsgfkDM5IYheW6tauBHfud/JN0PNcOxpO/4N
         eTLndk5Uv6qpNCAb2P9Uc8pN7n98GblaNL6KFFqjMWRY7P3+2W32ZOG0fE29gKLyAC
         J7wtJiixvSFxg==
Date:   Mon, 27 Mar 2023 12:26:53 +0100
From:   Will Deacon <will@kernel.org>
To:     void0red <void0red@gmail.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/smmuv3: add a check of devm_add_action in
 smmu_pmu_setup_msi
Message-ID: <20230327112652.GA30874@willie-the-truck>
References: <20230227032557.894274-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227032557.894274-1-void0red@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:25:57AM +0800, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> devm_add_action may fails, add a warning when it happens.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 25a269d43..307bac904 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -724,7 +724,11 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
>  	pmu->irq = msi_get_virq(dev, 0);
>  
>  	/* Add callback to free MSIs on teardown */
> -	devm_add_action(dev, smmu_pmu_free_msis, dev);
> +	ret = devm_add_action(dev, smmu_pmu_free_msis, dev);
> +	if (ret) {
> +		dev_warn(dev, "failed to add callback to free MSIs on teardown\n");
> +		return;
> +	}

I appreciate that you're following the existing error handling in this
function, but I don't think this message is especially helpful. We'd be
better off propagating the error and failing the probe in this case, I
reckon.

Will
