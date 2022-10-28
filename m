Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD3611846
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiJ1Qy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJ1QyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0E224A97;
        Fri, 28 Oct 2022 09:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B075623A9;
        Fri, 28 Oct 2022 16:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD04EC433B5;
        Fri, 28 Oct 2022 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976051;
        bh=CagHt1YKwrFPw9NQtg1cErC7qHaLnYF/pJpMHFrobgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZCvVBy+vDkYlZMf/7/EGEMNXjyy3syl32922bEgQN1M1C36tEVngOnb1IlPUKXaY
         wSHlRtWrfGlshaalXeNuf9OC1wFi91GF/zFU8FRIIteQwV4XBD8vvDnUdDRZCdBr8Z
         UluKjSLTSKuB8OA2wNwxNwaSEDwO6iZALGwhE/z3DxBY7cgJBIwCDojZ7A32ChZPm2
         1uj+y0rIstBtFf3KBnLeIoxLOljEtHgTP6eP4zlIL9ZUIgHHzAX+BMJ2Riqn8SMFr+
         HBlQqwfiL2UeHMVKCe9JZBueFJtrk48+E43D/o+CetvRJwTvVTEGSP+gQ5bAhXJNCH
         RIBOi4AOUoGYQ==
Date:   Fri, 28 Oct 2022 22:24:01 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     mani@kernel.org, loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, mrana@quicinc.com
Subject: Re: [PATCH v2] bus: mhi: host: Fix race between channel preparation
 and M0 event
Message-ID: <20221028165401.GA13880@thinkpad>
References: <1665889532-13634-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1665889532-13634-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 11:05:32AM +0800, Qiang Yu wrote:
> There is a race condition where mhi_prepare_channel() updates the
> read and write pointers as the base address and in parallel, if
> an M0 transition occurs, the tasklet goes ahead and rings
> doorbells for all channels with a delta in TRE rings assuming
> they are already enabled. This causes a null pointer access. Fix
> it by adding a channel enabled check before ringing channel
> doorbells.
> 
> Fixes: a6e2e3522f29 "bus: mhi: core: Add support for PM state transitions"
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Can you also CC stable list for backporting?

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> v1->v2: add Fixes tags
> 
>  drivers/bus/mhi/host/pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 4a42186..0834590 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -301,7 +301,8 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
>  		read_lock_irq(&mhi_chan->lock);
>  
>  		/* Only ring DB if ring is not empty */
> -		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
> +		if (tre_ring->base && tre_ring->wp  != tre_ring->rp &&
> +		    mhi_chan->ch_state == MHI_CH_STATE_ENABLED)
>  			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
>  		read_unlock_irq(&mhi_chan->lock);
>  	}
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
