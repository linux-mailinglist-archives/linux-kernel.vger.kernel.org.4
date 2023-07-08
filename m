Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8B74BE6B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGHQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748051BD;
        Sat,  8 Jul 2023 09:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 090D460BBB;
        Sat,  8 Jul 2023 16:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ECFC433C7;
        Sat,  8 Jul 2023 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688833284;
        bh=REI8mm0g3Ln4d1mUrUIddDRs8mEfYtqHZnt5LA4GD2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ew2f/I6+MIkf55capRaAfx52XTSQNvXPRfj8ddTasB9avsaHAqOqN9l8A4wpsRWQ5
         WKoGyzne+ggKIO7J6Kkm+wAKAfphdJUX9WKy+VQLGOKTMnSI0NsgQTPAXfQMnG6GJx
         A8sj9Bmv408Hvk3DRdMKHHY22dWo/RIehyNBNfvZ6uCEenVunTQqHOnJ3EK+f21fVQ
         dwp7K8TNrAK5UuElf0Q4y5Ys0uXGwObZlBvKqXTSnRTYG0wpFH/mWuDNkBgHF3vFmm
         3QehyzixKaupBimpo1/rFOo8YhP0oCDrEW+axOKWmlt/NUahN6FnMw3CB/QUbqSDnN
         MGO3MvxGZAKOw==
Date:   Sat, 8 Jul 2023 17:21:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: bd27008: Support BD27010 RGB
Message-ID: <20230708172116.42220c23@jic23-huawei>
In-Reply-To: <f6e2c7dae4de9978c53c46d9b2fade03033ce08e.1688723839.git.mazziesaccount@gmail.com>
References: <cover.1688723839.git.mazziesaccount@gmail.com>
        <f6e2c7dae4de9978c53c46d9b2fade03033ce08e.1688723839.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One trivial request for a comment.

Otherwise (subject to jetlag - which snuck up on me during this review)
this looks fine to me..
Will be a few weeks though until the precursor series does the
round trip via upstream to get into the branch I'd want to apply this
on.

Jonathan


>  
> +static int bu27010_get_gain_sel(struct bu27008_data *data, int *sel)
> +{
> +	int ret, tmp;
> +
> +	/*
> +	 * We always "lock" the gain selectors for all channels to prevent
> +	 * unsupported configs. It does not matter which channel is used
> +	 * we can just return selector from any of them.
> +	 */
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, sel);
> +	if (ret)
> +		return ret;
> +
> +	*sel = FIELD_GET(BU27010_MASK_DATA0_GAIN, *sel);
> +
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	*sel |= FIELD_GET(BU27010_MASK_RGBC_GAIN, tmp) << fls(BU27010_MASK_DATA0_GAIN);

Odd enough to perhaps warrant a comment on the maths.

> +
> +	return ret;
> +}
> +

