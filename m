Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5A6D3CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjDCFhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDCFhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:37:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646CE93;
        Sun,  2 Apr 2023 22:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21423B8111B;
        Mon,  3 Apr 2023 05:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768B7C433EF;
        Mon,  3 Apr 2023 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680500254;
        bh=pR7XFOX7xmKil5S7BlV92fu3hw5myWpZZtSP5P9eqII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rillFw9gIBZy/70BQv1QbuH7ejDsoL3BKOaSU8KoYj5QOqAoZlPYQAEF0J+GQUrvF
         LAwS8/IhH89Toi6RsO1BYDFKs3FNXhsd2XtjQIAvn5rJBk+MzvuB2NCfJdQ4vIuFAs
         9lsCJPR5Daf77el5syfvusAfGTO7JfR8IkzfeCjzGv5pUyjuuK6CpCa4g/nkwyFqCr
         Fx3qy82KsUoNVwjIXWhkFo81KaO3O7i0UC+WSfqJZlU2IAwfL16+HtGl66iEvL/LME
         qQHFwP38IsxzBeN11z1WD8pm0MYXJAhRSNeJxcjYWc+w52lIM2lkUpRKjXrsr+hwLb
         8wjNZ90iaNAuw==
Date:   Mon, 3 Apr 2023 11:07:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: mhi: host: Remove duplicate ee check for syserr
Message-ID: <20230403053730.GI4627@thinkpad>
References: <1674597444-24543-1-git-send-email-quic_jhugo@quicinc.com>
 <1674597444-24543-2-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1674597444-24543-2-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:57:23PM -0700, Jeffrey Hugo wrote:
> If we detect a system error via intvec, we only process the syserr if the
> current ee is different than the last observed ee.  The reason for this
> check is to prevent bhie from running multiple times, but with the single
> queue handling syserr, that is not possible.
> 
> The check can cause an issue with device recovery.  If PBL loads a bad SBL
> via BHI, but that SBL hangs before notifying the host of an ee change,
> then issuing soc_reset to crash the device and retry (after supplying a
> fixed SBL) will not recover the device as the host will observe a PBL->PBL
> transition and not process the syserr.  The device will be stuck until
> either the driver is reloaded, or the host is rebooted.  Instead, remove
> the check so that we can attempt to recover the device.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> ---
>  drivers/bus/mhi/host/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index df0fbfe..0c3a009 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -503,7 +503,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  	}
>  	write_unlock_irq(&mhi_cntrl->pm_lock);
>  
> -	if (pm_state != MHI_PM_SYS_ERR_DETECT || ee == mhi_cntrl->ee)
> +	if (pm_state != MHI_PM_SYS_ERR_DETECT)
>  		goto exit_intvec;
>  
>  	switch (ee) {
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
