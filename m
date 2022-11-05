Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30D61DDDB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKETqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKETqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:46:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168921005E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:46:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b2so21080181eja.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq/APDJ1/i7tYioV5hUAkwvhILl5RMdNbxu0oP9Zowo=;
        b=S//juSlij40GbQm+UzMkx9pe4GilcX0yFl9N8MOVXy0tTuq4qH2Q1AG+0Ie8iKWUxS
         VBJWP+7nUAyZRKG6bNBFd9rgF5V90RsuevlhyKBBYUcxmeG/3rT9Y7H/O64Y+hgxyH4u
         n0Gfcet4L1YqOnm0Ie4M/tJ1K6AnrRR6rsAG6b2iMBAGeaTlXaWaOjRFaMproAB0Rfkd
         yGHFsshpwiinpJ4o7KUgcbNG5CFqJ5BLf0YlGlSHIBpMrzQn5wf9a9wKO2r1ja7bsx9V
         lnUb+VLJBFx+3IspDy467Ow5BA9AleexHDEPQYO3ODQFZ9XZmz9OZ89zqweESyIfBWOh
         K44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq/APDJ1/i7tYioV5hUAkwvhILl5RMdNbxu0oP9Zowo=;
        b=NM6aY8LqOaD6vUOwYJhd3FK85Z5RlSYn8lPrjdchWU5aSrzCsJqdKG3br/G4QWNmNA
         8Cy1Jt7Pmbik+sXVFnqr08pyt431P8dXtqG3APF2aWvXxwpzLRdCLqq8utUnlLl3T+IR
         PFgGwfNkA57zQ55P29LKP/tSo9gTFNuEZjmGz/g0pi0jxv7aBf1LDq9A8sfx41aJQ8bq
         LIj/Sy2wnrhstE1JiopmO9JKpU1y31zzm6usM5u2gaDic6+NvuGftb37koFOI9W/NXBx
         IZWHsHgILmAdLUzCZ7Q/Kt0ZfNc168l0ctJv/zhc5lbdCoBAzDalXZrn8LYfD4XbQs2h
         1kXg==
X-Gm-Message-State: ACrzQf3sDA4v7rsyBhYt+Vx4mqyZHGBmB4qj5TAhmpTRb1/qlXayiCPK
        iWnTwGfi1k4MMgWuAX6puTQ=
X-Google-Smtp-Source: AMsMyM7CA8//3SyAUldovN5OAm+KAnq+khm0KTenfTZP8RCbkkZJqClOrzFwOhDtIRpW7gkIliGmfg==
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id wg2-20020a17090705c200b0077edef765d8mr41276589ejb.487.1667677608563;
        Sat, 05 Nov 2022 12:46:48 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b00463c367024bsm1557754edu.63.2022.11.05.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 12:46:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/2] bus: sunxi-rsb: Support atomic transfers
Date:   Sat, 05 Nov 2022 20:46:47 +0100
Message-ID: <4779430.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20221105191954.14360-3-samuel@sholland.org>
References: <20221105191954.14360-1-samuel@sholland.org> <20221105191954.14360-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 05. november 2022 ob 20:19:53 CET je Samuel Holland napisal(a):
> When communicating with a PMIC during system poweroff (pm_power_off()),
> IRQs are disabled and we are in a RCU read-side critical section, so we
> cannot use wait_for_completion_io_timeout(). Instead, poll the status
> register for transfer completion.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/bus/sunxi-rsb.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 17343cd75338..0f0e498d4379 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -267,6 +267,9 @@ EXPORT_SYMBOL_GPL(sunxi_rsb_driver_register);
>  /* common code that starts a transfer */
>  static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  {
> +	bool timeout;
> +	u32 status;
> +
>  	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
>  		dev_dbg(rsb->dev, "RSB transfer still in progress\n");
>  		return -EBUSY;
> @@ -279,8 +282,16 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
>  	       rsb->regs + RSB_CTRL);
> 
> -	if (!wait_for_completion_io_timeout(&rsb->complete,
> -					    
msecs_to_jiffies(100))) {
> +	if (irqs_disabled()) {
> +		timeout = readl_poll_timeout_atomic(rsb->regs + 
RSB_INTS,
> +						    status, 
status, 10, 100000);

It would be good to check only for RSB_INTS_LOAD_BSY, RSB_INTS_TRANS_ERR and 
RSB_INTS_TRANS_OVER flags and clear them afterwards. That way we avoid problems 
if this path is used outside power off case.

Best regards,
Jernej

> +	} else {
> +		timeout = !wait_for_completion_io_timeout(&rsb-
>complete,
> +							  
msecs_to_jiffies(100));
> +		status = rsb->status;
> +	}
> +
> +	if (timeout) {
>  		dev_dbg(rsb->dev, "RSB timeout\n");
> 
>  		/* abort the transfer */
> @@ -292,18 +303,18 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  		return -ETIMEDOUT;
>  	}
> 
> -	if (rsb->status & RSB_INTS_LOAD_BSY) {
> +	if (status & RSB_INTS_LOAD_BSY) {
>  		dev_dbg(rsb->dev, "RSB busy\n");
>  		return -EBUSY;
>  	}
> 
> -	if (rsb->status & RSB_INTS_TRANS_ERR) {
> -		if (rsb->status & RSB_INTS_TRANS_ERR_ACK) {
> +	if (status & RSB_INTS_TRANS_ERR) {
> +		if (status & RSB_INTS_TRANS_ERR_ACK) {
>  			dev_dbg(rsb->dev, "RSB slave nack\n");
>  			return -EINVAL;
>  		}
> 
> -		if (rsb->status & RSB_INTS_TRANS_ERR_DATA) {
> +		if (status & RSB_INTS_TRANS_ERR_DATA) {
>  			dev_dbg(rsb->dev, "RSB transfer data 
error\n");
>  			return -EIO;
>  		}




