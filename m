Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A0713BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 20:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjE1Sr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjE1SrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A25FC4;
        Sun, 28 May 2023 11:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD54E6133B;
        Sun, 28 May 2023 18:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94A6C433D2;
        Sun, 28 May 2023 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685299643;
        bh=Cv2t53KSYI7vZBM7q0XFrlPcpwsLI3EyWAaUegWhtMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P1Lzc5KKQNEEaWuYXClbGPbLBR9C6RDNP/bTfodTgSWbKlD44Yzx9Ks1BpokfG3Be
         CZ1BkYn+vlEaqGdu9Ei4l5qV2zQVzzDuRkImoc5CznY+cJpUGprZhzzpzTZXFM2EXc
         uqKkWbYrrQmlPoSnlzhDsyFibvofElQmXRvUjN33yTGS1UTSiCCXzQKtKuz3jWSjz3
         sb78CnKzSw5ooQlA8mxDUvXTO2LlxXXlarU5lPt8ja/AvMd2rWYCh+YaO7U5GU+9Ki
         Oc8XszgSAcMAzc7+zX+GvUG7eETuw14Qb04BkIXC4oL9FVWpBkIQCb5iNWZZ8aDzOR
         VLdEfPDh83Q5Q==
Date:   Sun, 28 May 2023 20:03:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 6/7] iio: light: vcnl4000: Add oversampling_ratio for
 4040/4200
Message-ID: <20230528200342.21982605@jic23-huawei>
In-Reply-To: <20230522142621.1680563-7-astrid.rost@axis.com>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
        <20230522142621.1680563-7-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 16:26:20 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add the proximity multi pulse (PS_MPS) as oversampling_ratio.
> Instead of one single pulse per every defined time frame,
> one can program 2, 4, or even 8 pulses. This leads to a
> longer IRED on-time for each proximity measurement value, which
> also results in a higher detection range.
> 
> Add read/write attribute for proximity oversampling-ratio and read
> attribute for available oversampling-ratio.
> This is supported for vcnl4040 and vcnl4200.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>

I applied the series and did a build test which showed me...

> @@ -1648,6 +1729,9 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
Guessing a rebase went wrong?

I thought about just fixing this up by dropping the duplication, but given
I'm not 100% sure nothing else was affected, I'll leave it to you to fix up
and check for any other related issues for a v5. 

Jonathan

>  		.ext_info = vcnl4000_ext_info,
>  		.event_spec = vcnl4040_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),

