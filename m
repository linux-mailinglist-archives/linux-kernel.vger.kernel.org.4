Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B356E9636
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjDTNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDTNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:47:40 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3E3A86;
        Thu, 20 Apr 2023 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=wQ76rbsj87dJylzlZ6ZEzCin2KuP+RmRwobL0Htj8Wo=; b=ifAGo/6tGAxv+/wl5x/GoOOafq
        g8M/AD55WXDDk0PZfNlAmDvXN6rUIpEv3PbAq26Y8HTDWCfa2yZ0p/VSxcxY2IrpjzSgMS5VfOqz5
        mvMMx5RXIbQyg9N3I5RTarZqg+085plynvM4GzDSpewvRE/q1WNe6Kv1IeDwjK4c5XNvrueuiacHI
        wghtynBifX8V5qn6Dzdxk3W3UhiJ4MhgX47CgXD6E3a+HBRNJbmKnVV8vhAY9hA8IdqGxC1uKLN3r
        qa6f3DPH2u+gpGl7vzu9jrnSXC0VK9Yn3/m6uCr/WmGsWQbyBhjXPzw4c0i1LCG0h7rXcUmIq8F88
        i0viJ5hA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1ppUdM-0002nT-6X; Thu, 20 Apr 2023 15:47:36 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ppUdL-000U3R-NG; Thu, 20 Apr 2023 15:47:35 +0200
Message-ID: <85e214c8-b639-5197-70a1-7279f9418f66@metafoo.de>
Date:   Thu, 20 Apr 2023 06:47:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] iio: potentiometer: Add support for the Renesas X9250
 potentiometers
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230420121320.252884-1-herve.codina@bootlin.com>
 <20230420121320.252884-3-herve.codina@bootlin.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230420121320.252884-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26882/Thu Apr 20 09:26:46 2023)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 05:13, Herve Codina wrote:
> The Renesas X9250 integrates four digitally controlled potentiometers.
> On each potentiometer, the X9250T has a 100 kOhms total resistance and
> the X9250U has a 50 kOhms total resistance.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Hi,

Looks perfect! Just one small comment.

> +static int x9250_write8(struct x9250 *x9250, u8 cmd, u8 val)
> +{
> +	struct spi_transfer xfer = {
> +		.tx_buf = &x9250->spi_tx_buf,
> +		.len = 3,
> +	};
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(x9250->spi_tx_buf) < 3);
> +
> +	mutex_lock(&x9250->lock);
> +
> +	x9250->spi_tx_buf[0] = 0x50;
The 0x50 shows up as a magic constant in multiple places, a define for 
it would be nice.
> +	x9250->spi_tx_buf[1] = cmd;
> +	x9250->spi_tx_buf[2] = val;
> +
> +	ret = spi_sync_transfer(x9250->spi, &xfer, 1);
> +
> +	mutex_unlock(&x9250->lock);
> +
> +	return ret;
> +}
