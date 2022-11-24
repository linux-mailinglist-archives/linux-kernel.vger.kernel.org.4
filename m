Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8E6371A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKXE5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKXE5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:57:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BF410046
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:57:47 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b4so640533pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPlwUNcv4Dplvh3fEfrO40YMYkUc7XawQh7JimisJjE=;
        b=NBOCpe8Rzc+E27R754CDSyf6DIbW+o78QsHtuC/eHZYj81jKsAVZWrXZZWlVopzy5n
         2U89qwvZh5PleKd2Qotgp+6QTyjYPenLmBVBaujw1exFWhP5AZfm3KwgTPpGp6TUIr+I
         O6ke1yZiR7ar5WD1HrpGGqv0xG8AeXe9vkbjFebLQNeQbENC1PCDS1IK3YU/5rJ4i9hG
         vMkA3eTDpxGkjZmkg2q5x/M+bnu9Asa6UC9zB6CSbsBff77MVWPWAR3ql+cVcd7Fh3wO
         q6SZvU9CZZS7eEC0JML0fEODM4oU03Z0XC6XFouEYWd9+6ca7LEf51gva918yY+L3HKE
         bFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPlwUNcv4Dplvh3fEfrO40YMYkUc7XawQh7JimisJjE=;
        b=c214oxGnR3qaLlzgV4HTTWAlFH4Cf/rmgHWOP4tGrbd/cOUuA8L2NWeYukKXRbG6Y9
         SfN0HJ5Xx1DtSTvk89aT2D+YUUwHkfhQhqC440OZ73Qs0jFtbZewq48ZgDxFK10jRvii
         vAxiUvRv82q3+yiymDFqAX7hZiWhZ/857RCjt0d9RruTteUeFaTeU8prlJbc3ZDOsFwU
         tkUj7k9/N/T0i6Ixxdifpb0QnKmdTQt+tepTyLJ1sWZi6f2bhaiV/MyyQoDnQFWK4Ey4
         wWwr/zjg4a4/OKxIlJcq4uf7ZiuGscSggPLnWPkgwdDzGctB93vbzwmp/mapS/9+BLGp
         291g==
X-Gm-Message-State: ANoB5pkHE68ud1PPMORGoSpPhahOXoCI9TuFExRjQfBduERJdSxikGgr
        kw/WEX+/Z27IivbXqFlxJghqtw==
X-Google-Smtp-Source: AA0mqf76WrgsB2cg75zm5R0XIKlk5DaFEEo6/NzuGVFrpmGhUVNepyLh5g05/llP99EutH0qToVESQ==
X-Received: by 2002:a63:fb04:0:b0:476:7faf:e0bf with SMTP id o4-20020a63fb04000000b004767fafe0bfmr10224951pgh.80.1669265867387;
        Wed, 23 Nov 2022 20:57:47 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b001869efb722csm73843plg.215.2022.11.23.20.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 20:57:47 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:27:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "xiaowu.ding" <xiaowu.ding@jaguarmicro.com>
Cc:     Tushar.Khandelwal@arm.com, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver:mhuv2:Fix data mode rx startup problem
Message-ID: <20221124045745.yycyoxw2drk4rw6k@vireshk-i7>
References: <20221124032701.2163-1-xiaowu.ding@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124032701.2163-1-xiaowu.ding@jaguarmicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-22, 11:27, xiaowu.ding wrote:
> From: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
> 
> When using the arm mhuv2 data transfer mode , sometimes the sender can
> not send data anymore ,and sender will blocking because of receiver did not
> clear the stat_clear.
> 
> The test scene:
> A is sender(poll mode) ; B is receiver (interrupt mode)
> When A send msg to B ,but B did not have register the mailbox . The B will
> miss the message ,and will not clear the stat_clear. So the sender A will
>  be send blocking status and can not send again anymore.
> 
> So the patch just clear the stat_clear within the rx startup function. Just
> Drop the last message before receiver will not be ready for receiver .
> 
> Signed-off-by: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
> ---
>  drivers/mailbox/arm_mhuv2.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
> index a47aef8df52f..7aef458f0b18 100644
> --- a/drivers/mailbox/arm_mhuv2.c
> +++ b/drivers/mailbox/arm_mhuv2.c
> @@ -327,6 +327,14 @@ static int mhuv2_data_transfer_rx_startup(struct mhuv2 *mhu,
>  {
>  	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
>  	int i = priv->ch_wn_idx + priv->windows - 1;
> +	const int windows = priv->windows;
> +	int j, idx;
> +
> +	/* clear the rx stat_clear */
> +	for (j = 0; j < windows; j++) {
> +		idx = priv->ch_wn_idx + j;
> +		writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[idx].stat_clear);
> +	}

Since this is already done in mhuv2_data_transfer_read_data(), I am not sure why
it is required again.

>  
>  	/*
>  	 * The protocol mandates that all but the last status register must be

-- 
viresh
