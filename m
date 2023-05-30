Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF41715BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjE3Kkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjE3Kkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CEE8F;
        Tue, 30 May 2023 03:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99A996215D;
        Tue, 30 May 2023 10:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F258FC433D2;
        Tue, 30 May 2023 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685443235;
        bh=xloVzKThcmCFtR4jJFtCgd3MlQqbexb7mtuyBj6XgCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZDcAA3jfk9TRHlvDZYBrTM9tRyZ8C53g6jFuzq+X6omsPNRB2qU819S8lcs/OQhG
         kw4KI84xgR54Z4jOywVTlFIsnWUX5SVq5z1lFbI+OAGm60cG4EckoT4EPGaa/K5c8a
         1n2uAw0tlVaNfT1nNJxACA6wHQSTQPVWStl0Tr4zd8hxTgxUyj8sovlCZkYyegmM8t
         Bo7b0xiRlKl6/gN6Vgacj3M8Zzk9Q3K6tUo00p51eu3IF+XWjBDqy+E1uj6E4gVosk
         1wCZYDr4LEEbK2iE9gFWZzUlIeSDsmO5ChiCnQjc/2uRgPgPoe/jKgNXHAuXIKPear
         6m5tkA3XztITg==
Date:   Tue, 30 May 2023 16:10:20 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] bus: mhi: host: Skip MHI reset if device is in RDDM
Message-ID: <20230530104020.GF6379@thinkpad>
References: <1684390959-17836-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1684390959-17836-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 02:22:39PM +0800, Qiang Yu wrote:
> In RDDM EE, device can not process MHI reset issued by host. In case of MHI
> power off, host is issuing MHI reset and polls for it to get cleared until
> it times out. Since this timeout can not be avoided in case of RDDM, skip
> the MHI reset in this scenarios.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a6e2e3522f29 ("bus: mhi: core: Add support for PM state transitions")
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> v1->v2: use ~75 columns in commit text, add Fixes tag
> v2->v3: update Fixes tag
> v3->v4: add review tag and CC stable
> 
>  drivers/bus/mhi/host/pm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 0834590..8a4362d 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -470,6 +470,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  
>  	/* Trigger MHI RESET so that the device will not access host memory */
>  	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
> +		/* Skip MHI RESET if in RDDM state */
> +		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
> +			goto skip_mhi_reset;
> +
>  		dev_dbg(dev, "Triggering MHI Reset in device\n");
>  		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
>  
> @@ -495,6 +499,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  		}
>  	}
>  
> +skip_mhi_reset:
>  	dev_dbg(dev,
>  		 "Waiting for all pending event ring processing to complete\n");
>  	mhi_event = mhi_cntrl->mhi_event;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
