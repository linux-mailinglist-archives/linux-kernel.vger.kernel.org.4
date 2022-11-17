Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB162D9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiKQLuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiKQLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:49:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4E54B3C;
        Thu, 17 Nov 2022 03:49:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A23C6B82003;
        Thu, 17 Nov 2022 11:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB5C433D6;
        Thu, 17 Nov 2022 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685774;
        bh=vwbbKbLlsfVOCis5WYItUBnfNowseUKkUd9wdym+97k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xfg9p7NdeqvBWxIl5GO+J6vVDTAtp+iqstPTx01DKyOUeAERj3Pr662Tczj5NzNg3
         +Ssvt6DV38ZyUREj3nL+SjyWzPwbEvf+qAGVnRlYaj+QtO11mtgpDsw443uSilOHKW
         J6A6QZmGSqtpQq2KUMwHW7634SH1ql2LBJXpKl8M4RwVGFJIlTKv8NB7g+AqgGwIVj
         /YnLdunhrU15rSLuoWpih/OS4K6kWOh0BYJKJSo7Vx5fAHsewGYDu1yD1Qten7Z5cj
         ire2KX80HmjWPhbIE9sx9RJVaNH3IvbvPcx87hGoCB2zCZszy1BrS5MbfiyQkbHtzI
         PSFywd7Q1WnpA==
Date:   Thu, 17 Nov 2022 17:19:23 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     mani@kernel.org, loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, mrana@quicinc.com
Subject: Re: [PATCH v3] bus: mhi: host: Disable preemption while processing
 data events
Message-ID: <20221117114923.GD93179@thinkpad>
References: <1668479031-12853-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1668479031-12853-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:23:51AM +0800, Qiang Yu wrote:
> If data processing of an event is scheduled out because core
> is busy handling multiple irqs, this can starve the processing
> of MHI M0 state change event on another core. Fix this issue by
> disabling irq on the core processing data events.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
> v2->v3: modify the comment
> v1->v2: add comments about why we disable local irq
> 
>  drivers/bus/mhi/host/main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index f3aef77a..5dca0a0 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1027,13 +1027,20 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  
>  void mhi_ev_task(unsigned long data)
>  {
> +	unsigned long flags;

Reverse X-Mas tree order please. Move this definition to the last.

>  	struct mhi_event *mhi_event = (struct mhi_event *)data;
>  	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
>  
>  	/* process all pending events */
> -	spin_lock_bh(&mhi_event->lock);
> +	spin_lock_irqsave(&mhi_event->lock, flags);
> +	/*
> +	 * When multiple IRQs come, the tasklet will be scheduled out with event ring lock

s/come/arrive

> +	 * remaining acquired, causing M0 event process on another core gets stuck when it

s/remaining//

"causing other high priority events like M0 state transition getting stuck
while trying to acquire the same event ring lock."

> +	 * tries to acquire the same event ring lock. Thus, let's disable local IRQs here.
> +	 */

This comment should be placed above spin_lock_irqsave().

The comment "process all pending events" can be moved here.

Thanks,
Mani

> +
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
