Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47B5BC34D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiISHCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiISHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D71CB0C;
        Mon, 19 Sep 2022 00:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC2B61122;
        Mon, 19 Sep 2022 07:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46387C433C1;
        Mon, 19 Sep 2022 07:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663570962;
        bh=r7rE3QztujfpGUrKJbtq/eo8EOPVd2kk3QtrqlMwkLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaRQxufDDaOlWRgNKR9T5RMjCg8WwLQXD114nYKmW5vAeKW0RqlIQI1yMwFxD+qn1
         GnR4BgXNco/ml8Rv4H/2p79ph8h2ENGScxCYaJA7zze+7WFpwhN1SndZBgwxbb1OGB
         NsUmm2WFlvlbnYYGoogKVSvtTizAnqM3/5BR1+LLmrUyk0jdk91cuL/L3ZNRIPgMgj
         UbRcwm1lGnK8JlzmapBN0vkUgdzBzzPOXwZGndiuwymzS/hmHrK6HFV3fRh8VdfgMr
         LK9w1ZiSLYnk7rdEWFXPgyeQlD2VXYl85MczzivsQmVz8RAIX4/809yBQ9EvE1lo23
         rCXcO4xCtsxeg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaAnm-0004zd-Cd; Mon, 19 Sep 2022 09:02:46 +0200
Date:   Mon, 19 Sep 2022 09:02:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: applespi - avoid wasting some memory
Message-ID: <YygUFr5cSpZhYKOA@hovoldconsulting.com>
References: <0db94f84920663f3bd45a73e2ae73950627a377f.1663506472.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db94f84920663f3bd45a73e2ae73950627a377f.1663506472.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 03:08:17PM +0200, Christophe JAILLET wrote:
> When the 'struct applespi_data' structure is allocated at the beginning of
> applespi_probe(), 2504 bytes are allocated.
> 
> Because of the way memory is allocated, it ends to a 4096 bytes allocation.
> So, about 1500 bytes are wasted.
> 
> Later in this function, when 'tx_buffer', 'tx_status', 'rx_buffer' and
> 'msg_buf' are allocated, 256, 4, 256 and 512 bytes are requested (~1 ko).
> A devm_ memory allocation has a small overhead of 40 bytes. So, for the
> same reason as above, it ends to allocate 512, 64, 512 and 1024 (~2 ko).
> 
> All that said, defining these 4 arrays as part of 'struct applespi_data'
> saves 2 ko of runtime memory.
> 
> 3504 bytes are now requested, and 4096 really allocated. All these 4
> arrays fit in the 'wasted' memory of the first allocation.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>  drivers/input/keyboard/applespi.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index fab5473ae5da..bee4ccfa2b05 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -373,11 +373,11 @@ struct applespi_data {
>  	struct input_dev		*keyboard_input_dev;
>  	struct input_dev		*touchpad_input_dev;
>  
> -	u8				*tx_buffer;
> -	u8				*tx_status;
> -	u8				*rx_buffer;
> +	u8				tx_buffer[APPLESPI_PACKET_SIZE];
> +	u8				tx_status[APPLESPI_STATUS_SIZE];
> +	u8				rx_buffer[APPLESPI_PACKET_SIZE];
>  
> -	u8				*msg_buf;
> +	u8				msg_buf[MAX_PKTS_PER_MSG * APPLESPI_PACKET_SIZE];
>  	unsigned int			saved_msg_len;
>  
>  	struct applespi_tp_info		tp_info;

This kind of change is generally broken in case DMA can be involved.

Allocating the transfer buffers separately makes sure that alignment
requirements are met and avoids hard-to-debug memory corruption issues.

Johan
