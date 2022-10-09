Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206EB5F8C64
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJIQlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJIQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26935BC98;
        Sun,  9 Oct 2022 09:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB3F60C41;
        Sun,  9 Oct 2022 16:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D117BC433C1;
        Sun,  9 Oct 2022 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665333692;
        bh=zVR71JU/UpAI0sS5K+0vpB9MY/SnZLjg19Qy4gojgDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t1dOg6WeadbkxoyduvoN1TE/xZfxSZabyGLxzS2zpiLHeHzXvDFF7CHVDHGhgQvxu
         5N4pbD/IbE9I+NiPU0jzD7mLpbh4PURZjS31cYVrIqzxCeOTkyW3mUZdLm78BchDlk
         dazV0KS1xcCpHo4bEJUXjFWg++BAV70kga4tfCPPdDqzd+sM6+naXhZk1LsALrBsS9
         ep+3v4qHvjG39IhqqMj27UwbV0UHD14Hlx0Bkb4MRzPUgXrQdOjHB+1rlNhw1pZMq6
         EAH01FuyL3GoaNhgdTquqE4jWaVRIAnqdwD6O7wA03hIX3uGhBfny6dcienvtuJrVg
         oa8Bt2+5yLQXw==
Date:   Sun, 9 Oct 2022 17:41:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] iio: adc: add max11410 adc driver
Message-ID: <20221009174154.41569d52@jic23-huawei>
In-Reply-To: <20221003105903.229-2-Ibrahim.Tilki@analog.com>
References: <20221003105903.229-1-Ibrahim.Tilki@analog.com>
        <20221003105903.229-2-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 13:59:01 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> has 3 differential reference and 10 differential channel inputs.
> Inputs and references can be buffered internally. Inputs can also
> be amplified with internal PGA.
> 
> Device has four digital filter modes: FIR50/60, FIR50, FIR60 and SINC4.
> FIR 50Hz and 60Hz rejections can be enabled/disabled separately.
> Digital filter selection affects sampling frequency range so driver
> has to consider the configured filter when configuring sampling frequency.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
One small thing inline that I tidied up whilst applying.


> +static int max11410_configure_channel(struct max11410_state *st,
> +				      struct iio_chan_spec const *chan)
> +{
> +	struct max11410_channel_config cfg = st->channels[chan->address];
> +	unsigned int regval;
> +	int ret;
> +
> +	if (chan->differential)
> +		ret = max11410_set_input_mux(st, chan->channel, chan->channel2);
> +	else
> +		ret = max11410_set_input_mux(st, chan->channel,
> +					     MAX11410_AINN_GND);
> +
> +	if (ret)
> +		return ret;
> +
> +	regval = FIELD_PREP(MAX11410_CTRL_VREFP_BUF_BIT, cfg.buffered_vrefp) |
> +		 FIELD_PREP(MAX11410_CTRL_VREFN_BUF_BIT, cfg.buffered_vrefn) |
> +		 FIELD_PREP(MAX11410_CTRL_REFSEL_MASK, cfg.refsel) |
> +		 FIELD_PREP(MAX11410_CTRL_UNIPOLAR_BIT, !cfg.bipolar);
drivers/iio/adc/max11410.c:370:18: warning: dubious: x & !y 

I've fixed it with
... cfg.bipolar ? 0 : 1);

Shout if that's an issue (I've gotten these backwards in the past ;)

