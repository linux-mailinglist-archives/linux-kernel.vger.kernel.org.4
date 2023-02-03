Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8E68A266
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjBCTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBCTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:00:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81DDA87A8;
        Fri,  3 Feb 2023 11:00:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95228B82B9B;
        Fri,  3 Feb 2023 19:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30F7C433EF;
        Fri,  3 Feb 2023 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675450829;
        bh=/szj5rpJgfyzWSqhwuczohVv2+5Gg7eKrWSsmIaCwi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcyjhx0aWL6j1pJnwn/Dy5bONzBmai36RvvZnjMQd1mWr43Ap7j567QSH6pAA25tF
         Rt/eNpu34YErwTOzDgvN9xPyDl8VyQOgyUZjCFIikLXsHDlOA9sV8G3ayqiV/pkPxk
         y9S6f3/TzrZnBnnRIG8ibKZbztb85t+IIMQURAAfy44xAnF2IwymJmsSqv5kFidAGl
         Mgkw2YAsw9Czlo8qMQLZq9KuqhahV24/mCMkYJXNIuCT73TxNp3+owXKwO7nl9XhGS
         T2UutA47baTV+chU66IIoFp9KNzDYAqlzTJRLHSj4kWHh+HDjjlr5dt5ntrRKkmK8j
         JLWOh9hbODswg==
Date:   Fri, 3 Feb 2023 11:02:48 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware: qcom_scm: modify
 qcom_scm_set_download_mode()
Message-ID: <20230203190248.ywmb54gmdd4blv46@ripper>
References: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:47:15PM +0530, Mukesh Ojha wrote:
> Modify qcom_scm_set_download_mode() such that it can support
> multiple modes. There is no functional change with this change.
> 

As Dmitry said, you argue for added flexibility, but doesn't provide a
user of that flexibility. I will drop this patch from the queue for now.

Please include this together with the patch(es) that benefit from such
flexibility.

> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>   - Stop changing legacy scm id for dload mode.
> 
>  drivers/firmware/qcom_scm.c | 15 +++++++--------
>  include/linux/qcom_scm.h    |  5 +++++
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54..6245b97 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -400,7 +400,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>  }
>  EXPORT_SYMBOL(qcom_scm_set_remote_state);
>  
> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> +static int __qcom_scm_set_dload_mode(struct device *dev, enum qcom_download_mode mode)
>  {
>  	struct qcom_scm_desc desc = {
>  		.svc = QCOM_SCM_SVC_BOOT,
> @@ -410,12 +410,12 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> +	desc.args[1] = mode ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>  
>  	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>  }
>  
> -static void qcom_scm_set_download_mode(bool enable)
> +static void qcom_scm_set_download_mode(enum qcom_download_mode mode)
>  {
>  	bool avail;
>  	int ret = 0;
> @@ -424,10 +424,9 @@ static void qcom_scm_set_download_mode(bool enable)
>  					     QCOM_SCM_SVC_BOOT,
>  					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
>  	if (avail) {
> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> +		ret = __qcom_scm_set_dload_mode(__scm->dev, mode);
>  	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_writel(__scm->dload_mode_addr, mode);
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
> @@ -1410,7 +1409,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	 * disabled below by a clean shutdown/reboot.
>  	 */
>  	if (download_mode)
> -		qcom_scm_set_download_mode(true);
> +		qcom_scm_set_download_mode(QCOM_DOWNLOAD_FULLDUMP);
>  
>  	return 0;
>  }
> @@ -1419,7 +1418,7 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
>  {
>  	/* Clean shutdown, disable download mode to allow normal restart */
>  	if (download_mode)

PS. Wouldn't it make sense, if !download_mode to set NODUMP?

Regards,
Bjorn

> -		qcom_scm_set_download_mode(false);
> +		qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
>  }
>  
>  static const struct of_device_id qcom_scm_dt_match[] = {
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index f833564..f9bc84e 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -14,6 +14,11 @@
>  #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
>  #define QCOM_SCM_HDCP_MAX_REQ_CNT	5
>  
> +enum qcom_download_mode {
> +	QCOM_DOWNLOAD_NODUMP    = 0x00,
> +	QCOM_DOWNLOAD_FULLDUMP  = 0x10,
> +};
> +
>  struct qcom_scm_hdcp_req {
>  	u32 addr;
>  	u32 val;
> -- 
> 2.7.4
> 
