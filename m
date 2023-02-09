Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53563690D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjBIPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjBIPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:35:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A564664
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675956906; x=1707492906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DBmQQVUz0xBm9mAUPi6p/C1WlTafVt50h5IaYJ0eVDA=;
  b=KgLntQYyAzzQ+ky5kZKZJxBjd+kRa3+1tGIelntXZnkWpcC9hkci0raC
   mgFnMUm5eYfRqugJrJ6ajiyDypf2gCTqWAn+oUAIiQWArnKpY2i8Vp93z
   UPoUQnR00zL1UWoLqdXIJ7aUSjLg8gNH0Gsv0xaLbaebuPV4pK/25ryq0
   /XGOzPnwrXIMNr6safyena24PkjwVl7KZb56YlzPsG9WR2tXRvVIAKo8J
   PRCzSkEI40kN2/jaWF4dUaLeViTp9HP/tLRIuVD+j79GNhWq0lrpHIEjb
   uhKb+8JLhFlu/Z8ZiHbeH+jALKSRr80jxjwkf9GDfVBWlKUYYoiCeuge1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309782438"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="309782438"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:35:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776528833"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="776528833"
Received: from fpastor-mobl4.amr.corp.intel.com (HELO [10.212.74.130]) ([10.212.74.130])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:35:04 -0800
Message-ID: <dbec6aab-6456-72b3-39b6-3490dfdf083c@linux.intel.com>
Date:   Thu, 9 Feb 2023 09:23:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] soundwire: qcom: wait for fifo to be empty before
 suspend
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
 <20230209131336.18252-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230209131336.18252-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 07:13, Srinivas Kandagatla wrote:
> Wait for Fifo to be empty before going to suspend or before bank
> switch happens. Just to make sure that all the reads/writes are done.

For the suspend case that seems like a valid approach, but for bank
switch don't we already have a bus->msg_lock mutex that will prevent the
bank switch command from being sent before the other commands are handled?

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index b2363839624c..465b2a2ef0d5 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -325,6 +325,32 @@ static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *swrm)
>  	return 0;
>  }
>  
> +static bool swrm_wait_for_wr_fifo_done(struct qcom_swrm_ctrl *swrm)
> +{
> +	u32 fifo_outstanding_cmds, value;
> +	int fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
> +
> +	/* Check for fifo overflow during write */
> +	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +	fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
> +
> +	if (fifo_outstanding_cmds) {
> +		while (fifo_retry_count) {
> +			usleep_range(500, 510);
> +			swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +			fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
> +			fifo_retry_count--;
> +			if (fifo_outstanding_cmds == 0)
> +				return true;
> +		}
> +	} else {
> +		return true;
> +	}
> +
> +
> +	return false;
> +}
> +
>  static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
>  				     u8 dev_addr, u16 reg_addr)
>  {
> @@ -356,6 +382,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
>  		usleep_range(150, 155);
>  
>  	if (cmd_id == SWR_BROADCAST_CMD_ID) {
> +		swrm_wait_for_wr_fifo_done(swrm);
>  		/*
>  		 * sleep for 10ms for MSM soundwire variant to allow broadcast
>  		 * command to complete.
> @@ -1122,6 +1149,7 @@ static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
>  {
>  	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>  
> +	swrm_wait_for_wr_fifo_done(ctrl);
>  	sdw_release_stream(ctrl->sruntime[dai->id]);
>  	ctrl->sruntime[dai->id] = NULL;
>  	pm_runtime_mark_last_busy(ctrl->dev);
> @@ -1558,6 +1586,7 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
>  	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
>  	int ret;
>  
> +	swrm_wait_for_wr_fifo_done(ctrl);
>  	if (!ctrl->clock_stop_not_supported) {
>  		/* Mask bus clash interrupt */
>  		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
