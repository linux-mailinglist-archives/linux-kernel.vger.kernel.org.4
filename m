Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486E46D3325
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDAS3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:29:07 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE351BF4C;
        Sat,  1 Apr 2023 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=DHIjBw8q8o7HwiSFrp1UBh7BKrSxY4k3nqqzolvVuUU=; b=e/rJd21mkM22+PJJcC01YmpLKW
        3kU7QEWSc5VIqRFUBO3WWcIzQqelw7BppWDqTMDIXhBHOT6KdZlFRCY0ikB0MNsrZG984JiP1q10Y
        ve/9EMsB9Dl1Btjg+XpsYO7WiB3fzgxdMcv/Mvtbw7sfQbNfAtAMcG51pol7SU2kumFi4j0M31+jV
        UrDQ1pGPqt6ViBBqTo0OBrDvsAVGfczJfEnwqtN2SPU1J1LE2/Ln0n/oTbLutJjgtpNEp15bUa3CY
        4wFhIg2MV9+L6+A/W1eeXmBtM9AimvbeW45r23OzzjHL4XsmCfCWKRmtKu9fYWK2j5ShXw5hViEVR
        MOaGUmGQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pifyJ-000P2F-IU; Sat, 01 Apr 2023 20:29:03 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pifyJ-000Nvc-6P; Sat, 01 Apr 2023 20:29:03 +0200
Message-ID: <5c142a1b-c413-66b2-86d9-b8c95ed46241@metafoo.de>
Date:   Sat, 1 Apr 2023 11:29:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
Content-Language: en-US
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <ZCf085W4XL2PtQf6@arbad>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <ZCf085W4XL2PtQf6@arbad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26862/Sat Apr  1 09:22:47 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks pretty good. Jonathan already covered most of it, a few additional 
comments.

On 4/1/23 02:10, Andreas Klinger wrote:
> [...]
> +struct mpr_data {
> +	struct device		*dev;
> +	void			*client;

Any reason not to use `struct i2c_client` for the type?

> +	struct mutex		lock;
> +	s32			pmin;
> +	s32			pmax;
> +	struct gpio_desc	*gpiod_reset;
> +	int			irq;
> +	struct completion	completion;
> +	s64			channel[2] __aligned(8);
> +};
> +
> [...]
> +static int mpr_read_pressure(struct mpr_data *data, s64 *press)
> +{
> +	int ret, i;
> +	u8 wdata[] = {0xAA, 0x00, 0x00};
> +	s32 status;
> +	int nloops = 10;
> +	char buf[5];
The tx buffer is `u8`, the rx buffer is `char`. This should be consistent.
> +	s64 press_cnt;
> +	s64 outputmin = 1677722;
> +	s64 outputmax = 15099494;
> +
> +	reinit_completion(&data->completion);
> +
> +	ret = i2c_master_send(data->client, wdata, sizeof(wdata));

The i2c family of transfer functions returns the number of bytes 
transferred, this can be less than what you expect if you get an early 
NACK. Its always good to check that all the data was transferred. E.g.

if (ret >= 0 && ret != sizeof(wdata))

    ret = -EIO;

Same for the receive later on.

[...]
