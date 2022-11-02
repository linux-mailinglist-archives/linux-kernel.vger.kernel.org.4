Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED9B615A28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiKBDZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiKBDZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CB25C74;
        Tue,  1 Nov 2022 20:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56DDF617BA;
        Wed,  2 Nov 2022 03:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66F1C433C1;
        Wed,  2 Nov 2022 03:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667359542;
        bh=uhR/DlRpSUjcRtpD0jN5O4vx7jpsbts14UNcdGd4dSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RyE9etbXlfHDucYzKBP7VKyEKsTQ1Qs3vM00Nt1oiJmNgs8IEzwK3GH4T1k39BSTS
         +5J+0c+qIyEjrKCq0xnRSb3pUWXeyYSn0Hof/XvRhU0LalrIYpFpmCy0kPJw8ULC31
         P2UNdS9NS0LaPCFtXaLJTlzD2pDbQfyd5IIaJh8WenvIsK5mKKMI3AY1iU1njBIy/t
         nesjgy+AM4efdKIismZjwMghrjZ7h0LG7kDpavEcuU6sf8CcLLewssevJ2vZXyHpNt
         xRPDJiyUNQ3gN1nsMU+TIN/1jCUJo217swssNIq0NaHNaSF0K4TYyYXEP8hedHCBRe
         DdWKnuo8Payww==
Date:   Tue, 1 Nov 2022 22:25:39 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH V3 2/3] rpmsg: glink: Add support to handle signals
 command
Message-ID: <20221102032539.bxth6fcuxpbyxzii@builder.lan>
References: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
 <1663133102-10671-3-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663133102-10671-3-git-send-email-quic_deesin@quicinc.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:55:01AM +0530, Deepak Kumar Singh wrote:
> Remote peripherals send signal notifications over glink with commandID 15.
> 
> Add support to send and receive the signal command and based signals
> enable or disable flow control with remote host.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 63 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 115c0a1..01ee82a 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -17,6 +17,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/workqueue.h>
>  #include <linux/mailbox_client.h>
>  
> @@ -203,9 +204,15 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops;
>  #define RPM_CMD_TX_DATA_CONT		12
>  #define RPM_CMD_READ_NOTIF		13
>  #define RPM_CMD_RX_DONE_W_REUSE		14
> +#define RPM_CMD_SIGNALS			15
>  
>  #define GLINK_FEATURE_INTENTLESS	BIT(1)
>  
> +#define NATIVE_DTR_SIG			NATIVE_DSR_SIG
> +#define NATIVE_DSR_SIG			BIT(31)
> +#define NATIVE_RTS_SIG			NATIVE_CTS_SIG
> +#define NATIVE_CTS_SIG			BIT(30)
> +
>  static void qcom_glink_rx_done_work(struct work_struct *work);
>  
>  static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
> @@ -1001,6 +1008,57 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>  	return 0;
>  }
>  
> +/**
> + * qcom_glink_set_flow_control() - convert a signal cmd to wire format and
> + * 				   transmit
> + * @ept:	Rpmsg endpoint for channel.
> + * @enable:	True/False - enable or disable flow control
> + *
> + * Return: 0 on success or standard Linux error code.
> + */
> +static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> +{
> +	struct glink_channel *channel = to_glink_channel(ept);
> +	struct qcom_glink *glink = channel->glink;
> +	struct glink_msg msg;
> +	u32 sigs;

sigs needs to be zero-initialized.

> +
> +	if (enable)
> +		sigs |= NATIVE_DTR_SIG | NATIVE_RTS_SIG;
> +
> +	msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
> +	msg.param1 = cpu_to_le16(channel->lcid);
> +	msg.param2 = cpu_to_le32(sigs);
> +
> +	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
> +}
> +
> +static int qcom_glink_handle_signals(struct qcom_glink *glink,
> +				     unsigned int rcid, unsigned int sigs)
> +{
> +	struct glink_channel *channel;
> +	unsigned long flags;
> +	bool enable = false;
> +
> +	spin_lock_irqsave(&glink->idr_lock, flags);
> +	channel = idr_find(&glink->rcids, rcid);
> +	spin_unlock_irqrestore(&glink->idr_lock, flags);
> +	if (!channel) {
> +		dev_err(glink->dev, "signal for non-existing channel\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!channel->ept.flow_cb)
> +		return 0;
> +
> +	if (sigs & (NATIVE_DSR_SIG | NATIVE_CTS_SIG))
> +		enable = true;
> +		

There are two stray tabs on this line.

Regards,
Bjorn

> +	channel->ept.flow_cb(channel->ept.rpdev, channel->ept.priv, enable);
> +
> +	return 0;
> +}
> +
>  static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>  {
>  	struct qcom_glink *glink = data;
> @@ -1065,6 +1123,10 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>  			qcom_glink_handle_intent_req_ack(glink, param1, param2);
>  			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>  			break;
> +		case RPM_CMD_SIGNALS:
> +			qcom_glink_handle_signals(glink, param1, param2);
> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
> +			break;
>  		default:
>  			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>  			ret = -EINVAL;
> @@ -1440,6 +1502,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
>  	.sendto = qcom_glink_sendto,
>  	.trysend = qcom_glink_trysend,
>  	.trysendto = qcom_glink_trysendto,
> +	.set_flow_control = qcom_glink_set_flow_control,
>  };
>  
>  static void qcom_glink_rpdev_release(struct device *dev)
> -- 
> 2.7.4
> 
