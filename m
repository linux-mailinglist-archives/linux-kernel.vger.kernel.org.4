Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171EC7086A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjERRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjERRVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:21:39 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E9DE46
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:21:37 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-332cc0efe88so17241535ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684430497; x=1687022497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqbXpFoiHjQD7jQYSc14amQV/gzsA04HYIrm5CeyaD8=;
        b=ekMi+5wZ3VgHtcirb7fZY5O59BVZUknqZvspXe5HNg7A0aDsEGhzADmrvcTx4OytMy
         BECAhIhu2YLhRQAgC8Lef2Z5VEDOxW8UtgWY5L3b+6msZFopK8yF5p3Z91eAoQdHIDIM
         L0uAUd9qe2dEwSp57UAOWzg4dOEylbCVPpnPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684430497; x=1687022497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqbXpFoiHjQD7jQYSc14amQV/gzsA04HYIrm5CeyaD8=;
        b=Wvw8GdqVjpvwOX8e2SCAPUYewsLtG+N64y4KpoR28Ir9pjtus3Lw33/uIfzJrB7Fjk
         PT9nPeiSuzWc4pVJDHUK4o2tS2Ss/7UnQLHCPNBgvZHUDWVbQ4DNy6fQTQJzKKzw3qQw
         wQrTA0eHC83d7nP9B1Ieb9Qj3zSKDj1EZ28LDFCY0/NXVka+NqIVhwBOiGoI+6mqkUnQ
         12X2gpER9i7YZ6ExI2W/AqGUxE0FfAQinfbqyMUZ0xx8QruwNs/alqPk3W/Rmq6AQ99s
         +buR7FvsM/sy8C72PqUAVtMh8jJwyy+Mp6clTBgp7MLR6uSff2jNb2mWoaqN/xGPUVXd
         BSIw==
X-Gm-Message-State: AC+VfDyu04tyPLbk6O6+CQ4UBfCnWxLv/J3WV1T6K9Ey/yFXjfSSmYp9
        JBeOmXBYpO5Wjpcd7AvFEB55oA==
X-Google-Smtp-Source: ACHHUZ4O2+48M1vpYyQl+RUD52aXhVV6fEVVKbf0HzFYylGAGDzert10nLqIgvCaFzGtK51tm+90xA==
X-Received: by 2002:a92:ca91:0:b0:331:1834:7494 with SMTP id t17-20020a92ca91000000b0033118347494mr4777652ilo.20.1684430497177;
        Thu, 18 May 2023 10:21:37 -0700 (PDT)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id v15-20020a92d24f000000b003384176a2b0sm459348ilg.22.2023.05.18.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:21:36 -0700 (PDT)
Date:   Thu, 18 May 2023 11:21:34 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] Input: libps2 - rework handling of command response
Message-ID: <ZGZenuKMicegjUsZ@google.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
 <20230511185252.386941-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511185252.386941-4-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:52:43AM -0700, Dmitry Torokhov wrote:
> It is not entirely correct that libps2 sets PS2_FLAG_CMD1 after
> the device acknowledges each byte sent to the device by the host.
> Rework the code so that PS2_FLAG_CMD1 and PS2_FLAG_CMD are set only once,
> at the beginning of PS/2 command execution.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/libps2.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index 399cda0d34f5..d09450eca9a7 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -247,14 +247,19 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
>  
>  	serio_pause_rx(ps2dev->serio);
>  
> +	/* Some mice do not ACK the "get ID" command, prepare to handle this. */
>  	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
>  	ps2dev->cmdcnt = receive;
> -	if (receive && param)
> -		for (i = 0; i < receive; i++)
> -			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
> +	if (receive) {
> +		/* Indicate that we expect response to the command. */
> +		ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
> +		if (param)
> +			for (i = 0; i < receive; i++)
> +				ps2dev->cmdbuf[(receive - 1) - i] = param[i];
> +	}
>  
>  	/*
> -	 * Some devices (Synaptics) peform the reset before
> +	 * Some devices (Synaptics) perform the reset before
>  	 * ACKing the reset command, and so it can take a long
>  	 * time before the ACK arrives.
>  	 */
> @@ -434,11 +439,8 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
>  		return true;
>  	}
>  
> -	if (!ps2dev->nak) {
> +	if (!ps2dev->nak)
>  		ps2dev->flags &= ~PS2_FLAG_NAK;
> -		if (ps2dev->cmdcnt)
> -			ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
> -	}
>  
>  	ps2dev->flags &= ~PS2_FLAG_ACK;
>  	wake_up(&ps2dev->wait);
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
