Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC59D7031F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbjEOP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjEOP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FBB269E;
        Mon, 15 May 2023 08:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F4118626B0;
        Mon, 15 May 2023 15:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A757CC433EF;
        Mon, 15 May 2023 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684166194;
        bh=gu+ydarCRlEs2VjQSr0Soe43GhQ1R5KtJVWUwjvAws8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jz9bzODQ973EzPkNR+kvX2P3hHKtRBVp/oAQm1vcbVqXCPrDe7bBX9YlJWt5stq1l
         vWYzHl8znPYDrQdegSnByza0XLSGF+tyriUfXONfLjgSvECt8GE/tXYBrJzGFmr3Uu
         Sn3KmACh88rI7O9K0cAt4nPgFkIsOr39fDxoWyOKZGPgrKnlnvR/hetLMzwE8qM6Gm
         D27bIVc3H0DxKLrKGnNDxoHdSUOYJSkj+SF3+rRf3i+tod8PwudxLhXiXg7TBaWqb/
         rSKc+dI2dXztOHLXhuUmZ42P8+Nhu6QV0MEPLMEueUsHbh0mxnEM3q1BgyK9ObONix
         l9N1Rnsd2n6fA==
Date:   Mon, 15 May 2023 09:00:26 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "regulator: qcom-rpmh: Revert "regulator:
 qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS""
Message-ID: <20230515160026.ynqsgu4wvsqxnj2h@ripper>
References: <20230515145323.1693044-1-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515145323.1693044-1-amit.pundir@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 08:23:23PM +0530, Amit Pundir wrote:
> This reverts commit ad44ac082fdff7ee57fe125432f7d9d7cb610a23.
> 
> This patch restores the synchronous probing for
> qcom-rpmh-regulator because asynchronous probing broke
> Dragonboard 845c (SDM845) running AOSP. UFSHC fail to
> initialize properly and DB845c fails to boot regardless
> of "rootwait" bootarg being present or not
> https://bugs.linaro.org/show_bug.cgi?id=5975.
> 

Looking at the first attachment, I would suggest that UFS fails because
it's not able to get hold of its regulators, just as any other device
with supplies would.

The typical cause for rpmh timeouts is that you're no longer able to
talk to the rpmh. Could you please attempt to trace the system and see
what's happening in parallel that would cause such issue.

Also note that such issues often also results in UFS timeouts, which
results in the familiar UFS debug dumps.


In the second log, the system crashes 51 seconds after rpmh probes,
around the time where other sync_state is happening. This too would seem
related to missing resource votes, but I would expect being a separate
issue.

PS. this is a patch in the regulator code, but I don't see Mark in the
recipients list...

Regards,
Bjorn

> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index b0a58c62b1e2..30659922b0aa 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -1517,7 +1517,7 @@ MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
>  static struct platform_driver rpmh_regulator_driver = {
>  	.driver = {
>  		.name = "qcom-rpmh-regulator",
> -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  		.of_match_table	= of_match_ptr(rpmh_regulator_match_table),
>  	},
>  	.probe = rpmh_regulator_probe,
> -- 
> 2.25.1
> 
