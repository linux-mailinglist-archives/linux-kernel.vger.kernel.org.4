Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DE46A0B92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjBWOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBWOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:10:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E37515CA;
        Thu, 23 Feb 2023 06:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B86AB81A34;
        Thu, 23 Feb 2023 14:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47368C433EF;
        Thu, 23 Feb 2023 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677161446;
        bh=B3fi6u9Yr+llZ7+cJ5cdu34+B3kewfCJwPz2SOBukwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcdV60dnkTtcvOnX7wJAnwakRUpwqtnjnevt9d8SflBHqMW/MsmrKg+B3vUsmfhu4
         4MZeusnsj1C+eNAITkarzxfxWzirETDsP4YQ7ciznZxJiSw6niRr+9O1EgSnSXBKLD
         02RZDGVpADDmFU8HBHF+AOe43u8FHv9AKKjzLEc+NCjNcjY2Q/3T7tQuZcRYOL4RDa
         OGvRTrvd9Mqp0T2ynR6xaxx+98pGxakk/8Vi2yuU2GKczD1dbHA1BNvjvvalWXiUdY
         r+a6oF3e1G5raVlRy146rvnIjvoN+kcw2CupKq7Aiv28dOD0bvx/854PojHy6TX+kg
         4NoC7SKJKNHpQ==
Date:   Thu, 23 Feb 2023 06:14:13 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Message-ID: <20230223141413.rpghqzilw3jy5hhx@ripper>
References: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
 <1676990381-18184-3-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676990381-18184-3-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:09:39PM +0530, Mukesh Ojha wrote:
> CrashDump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the DLOAD bit as
> the other bits have their own significance.
> 
> Originally-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom_scm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 51eb853..c376ba8 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -419,6 +419,7 @@ static void qcom_scm_set_download_mode(bool enable)
>  {
>  	bool avail;
>  	int ret = 0;
> +	u32 dload_addr_val;
>  
>  	avail = __qcom_scm_is_call_available(__scm->dev,
>  					     QCOM_SCM_SVC_BOOT,
> @@ -426,8 +427,16 @@ static void qcom_scm_set_download_mode(bool enable)
>  	if (avail) {
>  		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_readl(__scm->dload_mode_addr, &dload_addr_val);
> +		if (ret) {
> +			dev_err(__scm->dev,
> +				"failed to read dload mode address value: %d\n", ret);
> +			return;
> +		}
> +
> +		ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
> +				dload_addr_val | QCOM_SCM_BOOT_SET_DLOAD_MODE :

I prefer to avoid using the ternary operator inside writel, in
particular since you in the next patch mask out the DLOAD_MASK here as
well...

Please make this:

readl();
dload_addr_val  &= ~MASK;
if (enable)
	dload_addr_val |= DLOAD_MODE;
writel();


Also, this is the only "value" we're working on in this function, so
"u32 val" should be sufficient.

Thanks,
Bjorn

> +				dload_addr_val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
> -- 
> 2.7.4
> 
