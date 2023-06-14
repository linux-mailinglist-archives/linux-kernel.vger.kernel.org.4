Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB77303E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjFNPaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjFNPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39641FDD;
        Wed, 14 Jun 2023 08:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D3460C5B;
        Wed, 14 Jun 2023 15:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEEDC433C0;
        Wed, 14 Jun 2023 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686756613;
        bh=v+krQLSQvy0RGcZLcqbIXiObIFKECGV3dMiU83A9I2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9g20ssYNKtaULjYRXWMOoLGNr8ZM6tbNo/yhpgRFFeAH8p6PmFDtGHKTP8c91vrL
         upcsrYypir8z5EQPzaglE8dDndY5hBBuZmcnwr8xvBl1m9uaaDXKTNDv9H056Ysw7I
         cimA9WSSdat3kpguG6RPXyi3h9+TwpPZLXbnNsGXj6bkmBj/LIli+fO0o7WbYl956E
         Q8pJxcHqV1BHcfOmwOL9czQ7uHZpPxMrL7ZKcGECxVdlLRiKlcf5mXG3KVe+NB236q
         g1sVSCewkPMAs1kcBDAKubnRctG5W3UhZ27ea+rO9Vm5Rl7F78rj05uVV4mKF2S7JC
         1M++kyryhcP3g==
Date:   Wed, 14 Jun 2023 08:33:35 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sarannya S <quic_sarannya@quicinc.com>
Cc:     quic_bjorande@quicinc.com, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH V7 2/3] rpmsg: glink: Add support to handle signals
 command
Message-ID: <20230614153335.w7mej6mate5tki5w@ripper>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-3-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682160127-18103-3-git-send-email-quic_sarannya@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 04:12:06PM +0530, Sarannya S wrote:
> From: Chris Lew <quic_clew@quicinc.com>
> 
> Remote peripherals send signal notifications over glink with commandID 15.
> 
> Add support to send and receive the signal command and based signals
> enable or disable flow control with remote host.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 64 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 01d2805..ff5e926 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -16,6 +16,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/workqueue.h>
>  #include <linux/mailbox_client.h>
>  
> @@ -197,9 +198,15 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops;
>  #define GLINK_CMD_TX_DATA_CONT		12
>  #define GLINK_CMD_READ_NOTIF		13
>  #define GLINK_CMD_RX_DONE_W_REUSE	14
> +#define GLINK_CMD_SIGNALS		15
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
> @@ -1014,6 +1021,58 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>  	return 0;
>  }
>  
> +/**
> + * qcom_glink_set_flow_control() - convert a signal cmd to wire format and
> + * 				   transmit
> + * @ept:	Rpmsg endpoint for channel.
> + * @enable:	True/False - enable or disable flow control
> + * @dst:	destination address of the endpoint
> + *
> + * Return: 0 on success or standard Linux error code.
> + */
> +static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
> +{
> +	struct glink_channel *channel = to_glink_channel(ept);
> +	struct qcom_glink *glink = channel->glink;
> +	struct glink_msg msg;
> +	u32 sigs = 0;
> +
> +	if (enable)
> +		sigs |= NATIVE_DTR_SIG | NATIVE_RTS_SIG;
> +
> +	msg.cmd = cpu_to_le16(GLINK_CMD_SIGNALS);
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

You don't handle this return value, so this works fine. But the other
cases of returning an error to qcom_glink_native_rx() indicates that no
further messages should be processed (e.g. because there's no sufficient
data in the FIFO).

But getting a signal on a non-existing channel is not something that's
going to be resolved until we get the next interrupt, so I think you
shouldn't propagate this error.

Which means that it would be better to make the return type void of this
function.

> +	}
> +
> +	if (!channel->ept.flow_cb)
> +		return 0;
> +
> +	if (sigs & (NATIVE_DSR_SIG | NATIVE_CTS_SIG))
> +		enable = true;

I'd find it cleaner to skip the early initialization and have a single
point of assignment of enable, like:

	enable = sigs & NATIVE_DSR_SIG || sigs & NATIVE_CTS_SIG;


And consolidate the flow_cb query/invocation to one place:
	if (channel->eptf.flow_cb)
		channel->ept.flow_cb(, enable);

Regards,
Bjorn

> +
> +	channel->ept.flow_cb(channel->ept.rpdev, channel->ept.priv, enable);
> +
> +	return 0;
> +}
> +
>  void qcom_glink_native_rx(struct qcom_glink *glink)
>  {
>  	struct glink_msg msg;
> @@ -1075,6 +1134,10 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
>  			qcom_glink_handle_intent_req_ack(glink, param1, param2);
>  			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>  			break;
> +		case GLINK_CMD_SIGNALS:
> +			qcom_glink_handle_signals(glink, param1, param2);
> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
> +			break;
>  		default:
>  			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>  			ret = -EINVAL;
> @@ -1449,6 +1512,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
>  	.sendto = qcom_glink_sendto,
>  	.trysend = qcom_glink_trysend,
>  	.trysendto = qcom_glink_trysendto,
> +	.set_flow_control = qcom_glink_set_flow_control,
>  };
>  
>  static void qcom_glink_rpdev_release(struct device *dev)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
