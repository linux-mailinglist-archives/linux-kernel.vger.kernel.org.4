Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7461F1C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiKGLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiKGLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:22:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63322183B9;
        Mon,  7 Nov 2022 03:22:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD4A460FD8;
        Mon,  7 Nov 2022 11:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA1C433C1;
        Mon,  7 Nov 2022 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667820175;
        bh=yUKZRtowNMMbVtTq5rXqMDPbXb2eaKZkJ8OtKwKaqY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVIz9iZwbx1D1kS7/XKaNX8EVf5/TIRnYJDlbh8dWbof4KT5/xb79iMi9dMWCu0kE
         q/kfoU6uOSe/7IaF077huJ47i0IIwTqYp82F/jeTlJ7C5W0O6ejGpEsFvRhHXsNkfw
         Caff0Ts5H3gJOtklaH2yB9YTlPD7b3CS14mhuw4/3EDTm/vaZaSUrAtPJWVbdUOmYL
         Ba457wQCA96L7z9UFe6f496PJErZ0A/L+tdZmeTbSjl5clmXEZdLOxTvMMuUom8B9i
         HDtqXGZ2wDPi4r5Mju2oyZCVBfQ4SqNaGPAvXRRKaEqEqMM9DiaQjmChS1B0Ux/zKJ
         i2iojShGSt9mg==
Date:   Mon, 7 Nov 2022 16:52:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     mani@kernel.org, loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, mrana@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Disable preemption while processing data
 events
Message-ID: <20221107112243.GA2220@thinkpad>
References: <1667462111-55496-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1667462111-55496-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:55:11PM +0800, Qiang Yu wrote:
> If data processing of an event is scheduled out because core
> is busy handling multiple irqs, this can starves the processing

s/starves/starve

> of MHI M0 state change event on another core. Fix this issue by
> disabling irq on the core processing data events.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/bus/mhi/host/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index f3aef77a..b58698d 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1027,13 +1027,14 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  
>  void mhi_ev_task(unsigned long data)
>  {
> +	unsigned long flags;
>  	struct mhi_event *mhi_event = (struct mhi_event *)data;
>  	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
>  
>  	/* process all pending events */
> -	spin_lock_bh(&mhi_event->lock);
> +	spin_lock_irqsave(&mhi_event->lock, flags);

Please add a comment stating why we are disabling local IRQs here. This will
help in understanding the code better.

Thanks,
Mani

>  	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
> -	spin_unlock_bh(&mhi_event->lock);
> +	spin_unlock_irqrestore(&mhi_event->lock, flags);
>  }
>  
>  void mhi_ctrl_ev_task(unsigned long data)
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
