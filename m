Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80456D7F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbjDEOWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbjDEOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:22:10 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232956A78;
        Wed,  5 Apr 2023 07:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=RlSya1VZO04tbvTr32DVbhwmJW8HiaJeC6eL8lHWHWA=; b=SHzPG1uuWOCDVVbEFqxYLqaf2q
        DT/spNbKS5KtXNR+u/3y3kcIBA1fcsZQ/94xb/BnKmUWQwec5gyvXMAUCZf/x0TFK0ubNMHmTqWXj
        dX2v41o+zkjbhtYakbhJf2A3hg0HaQPxt0Wy6NIF0g5nM9lTvfWxEM8DJAnCp6VciczbJEG7xA1OL
        0xoK4h/8Y3xhZkfCkl5ZmHq1oeT5hb94LpaVA6lOT8MnqUt+FMhw52mEdvCkLZEWvirMFTxH+4cSH
        1JVpjfgJ9JJjCU14ov8+b21R4FcM9/zJgyIJEmh/dq8mYKPaAeDKOPW7vddqiWAS3Cmwsv8ZGoKyB
        drYGeOrA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pk40U-0004Lw-Or; Wed, 05 Apr 2023 16:21:02 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pk40U-000DiZ-DL; Wed, 05 Apr 2023 16:21:02 +0200
Message-ID: <ee6a428b-905c-82ac-48fd-0b440d90e014@metafoo.de>
Date:   Wed, 5 Apr 2023 07:21:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] iio: dac: mcp4922: get and enable vdd regulator
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
 <20230405140114.99011-3-frattaroli.nicolas@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230405140114.99011-3-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26866/Wed Apr  5 09:23:41 2023)
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 07:01, Nicolas Frattaroli wrote:
> [...]
> +	state->vdd_reg = devm_regulator_get(&spi->dev, "vdd");
> +	if (IS_ERR(state->vdd_reg)) {
> +		ret = dev_err_probe(&spi->dev, PTR_ERR(state->vdd_reg),
> +				    "vdd regulator not specified\n");
> +		goto error_disable_vref_reg;
> +	}
> +	ret = regulator_enable(state->vdd_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable vdd regulator: %d\n",
> +			ret);
> +		goto error_disable_vref_reg;
> +	}
The two above can be combined into `devm_regulator_get_enable()`. This 
will also take care of automatically disabling the regulator on the 
error path and on remove.
> +
>   	spi_set_drvdata(spi, indio_dev);
>   	id = spi_get_device_id(spi);
>   	indio_dev->info = &mcp4922_info;
> [...]


