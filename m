Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548B474E222
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjGJXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGJXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB41A195
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68F4C6120F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA4BC433C8;
        Mon, 10 Jul 2023 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689030955;
        bh=0sGKzv3RKGK/wiYx7PSfCvZ5fnL6nKylKZT/SjWbCxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XBigyWIicK3ss2h2V75TNBalCaDlB7zR8r2RMuYj9uQm4fUqcbGIB5umN0mpJH7bC
         aT2whgcTlvUsK0kf4wV6nFDEj5WV8aKqZpAZ7GZi/buq6a1u59n++MpZ5DtjPfACe+
         FIhrPDZfVuG/aMlg8H0B3/vx54XIVGkY3gLApArE3fJbcZ5Lfy3SQeUSBya0X7W2Oi
         +jrXRqTYgVmyKqAe0s7pwToJZ/pu66qr+8W6tQxVuwbnxChsoe+ItvuF3R/yQe8fW3
         8QTE/AtmIbAArXoKpykw9lU+T/9HUir2zcbmkkMHxW8Qy0dN8JNLd8SA1AzNQ6jNs8
         Wf3KI4oz9kRfg==
Message-ID: <91153e4d-d10f-75f6-64d8-7bd4ef75420e@kernel.org>
Date:   Mon, 10 Jul 2023 18:15:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] firmware: stratix10-rsu: prevent io block when sending
 RSU messages
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com
References: <20230705021846.1536829-1-kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230705021846.1536829-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/23 21:18, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Fix the issue for preventing recursive rsu mutex lock
> issue in RSU update command.

This message is a bit confusing. What "issue" is preventing a lock issue?

> 
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>   drivers/firmware/stratix10-rsu.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
> index e51c95f8d445..0a7542e9bb6f 100644
> --- a/drivers/firmware/stratix10-rsu.c
> +++ b/drivers/firmware/stratix10-rsu.c
> @@ -280,7 +280,9 @@ static int rsu_send_msg(struct stratix10_rsu_priv *priv,
>   	struct stratix10_svc_client_msg msg;
>   	int ret;
>   
> -	mutex_lock(&priv->lock);
> +	if (!mutex_trylock(&priv->lock))
> +		return -EAGAIN;
> +
>   	reinit_completion(&priv->completion);
>   	priv->client.receive_cb = callback;
>   
> @@ -525,7 +527,9 @@ static ssize_t reboot_image_store(struct device *dev,
>   
>   	ret = rsu_send_msg(priv, COMMAND_RSU_UPDATE,
>   			   address, rsu_command_callback);
> -	if (ret) {
> +	if (ret == -EAGAIN)
> +		return 0;
> +	else if (ret) {
>   		dev_err(dev, "Error, RSU update returned %i\n", ret);
>   		return ret;
>   	}
