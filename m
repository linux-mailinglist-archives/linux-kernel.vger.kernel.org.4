Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1450724A78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbjFFRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbjFFRmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F57E47;
        Tue,  6 Jun 2023 10:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09FE260BC8;
        Tue,  6 Jun 2023 17:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027BBC433A1;
        Tue,  6 Jun 2023 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686073354;
        bh=W/KDPZOxJk5tdqnBucNrlj7mWSLSVWai/QXp3tQYGig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwFIFNzwVrzuqnOfqFLrRiZ8nu8sF/hLe423ENSXT4SfXSjaRLta76CHHj9BBsY+G
         hTpgBZCLcw6OOt7cHdxIxuqz3sVaMRykM5mvFwQYSfYlwdpbLApnZR5PuXxPMq6SFn
         jS77FMll5OAVcQrIpvh6ffkxg7rPofdXfLpTKDWY=
Date:   Tue, 6 Jun 2023 19:42:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        bkumar@qti.qualcomm.com, fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v1] misc: fastrpc: Collect driver-remote processor
 transaction logs
Message-ID: <2023060608-junction-conclude-f607@gregkh>
References: <1686070555-11154-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686070555-11154-1-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:25:55PM +0530, Ekansh Gupta wrote:
> Add changes to collect driver-remote processor rpmsg transaction
> logs. These logs will carry payload information for the rpmsg message
> instance. These logs are channel specific and are collected in
> channel context structure.
> 
> These rpmsg transaction logs can help in improving debugability as
> all requests from processes are getting captured in channel context
> structure.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..6447cee 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -104,6 +104,9 @@
>  
>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>  
> +/* Length of glink transaction history to store */
> +#define GLINK_MSG_HISTORY_LEN	(128)
> +
>  static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>  						"sdsp", "cdsp"};
>  struct fastrpc_phy_page {
> @@ -181,6 +184,28 @@ struct fastrpc_invoke_rsp {
>  	int retval;		/* invoke return value */
>  };
>  
> +struct fastrpc_tx_msg {
> +	struct fastrpc_msg msg;	/* Msg sent to remote subsystem */
> +	int rpmsg_send_err;	/* rpmsg error */
> +	s64 ns;			/* Timestamp (in ns) of msg */
> +};
> +
> +struct fastrpc_rx_msg {
> +	struct fastrpc_invoke_rsp rsp;	/* Response from remote subsystem */
> +	s64 ns;		/* Timestamp (in ns) of response */
> +};
> +
> +struct fastrpc_rpmsg_log {
> +	u32 tx_index;	/* Current index of 'tx_msgs' array */
> +	u32 rx_index;	/* Current index of 'rx_msgs' array */
> +	/* Rolling history of messages sent to remote subsystem */
> +	struct fastrpc_tx_msg tx_msgs[GLINK_MSG_HISTORY_LEN];
> +	/* Rolling history of responses from remote subsystem */
> +	struct fastrpc_rx_msg rx_msgs[GLINK_MSG_HISTORY_LEN];
> +	spinlock_t tx_lock;
> +	spinlock_t rx_lock;

Why roll your own ring-buffer logic instead of using one of the many
offerings that the kernel already provides for you?

thanks,

greg k-h
