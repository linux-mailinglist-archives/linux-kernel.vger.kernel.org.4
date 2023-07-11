Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8342274E7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGKH1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjGKH1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:27:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5CF9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:26:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso55082745e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689060417; x=1691652417;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ADbPO0cfR4g593jKsVT2jVxZ9Mioa2lxar2bSYbOLIE=;
        b=hZOL2w6YahG6Oe+83BmyGnw9dh81Wixl9VF7GhIF0jxj3Bcms+ln/raIc2BJvS0VPy
         dWS2vCx2ld7gGyQKSJDzUthbMh+S9cQz9wS8hQB3xaigGaz6W1daCt6ey6YlIu7gBmML
         RqQfHnCcK2WXuRENAO/uMiomthxYWM4/RdpIohbsQ5XDb6FM+JJja5hVn75cT7Ucvu7Y
         lFcpSYhQdyGZKZ6LbVl1yWkR7DxBvVx0FAPOOIIdmpnyIyG3/Abft8SRpcoPoAZB9JIJ
         MppOf/3AqdJZ+hA6jO0khxQFlj7j+fzEnaguDRVvpfeSbpxt1Lqajl4CmmeLzdP9sJ1Z
         m7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060417; x=1691652417;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADbPO0cfR4g593jKsVT2jVxZ9Mioa2lxar2bSYbOLIE=;
        b=cY0wkEcVloWR6M8P7ihrdoqFdJZKJdgHZe6wyJ6129dFGXxaJJApVzm1Wi5wscAzHN
         FcboWRWDm/3J39nf7CjvkpB7+JgA8+xGPW6z5lUq7PGKenZQazmvx0LlJMl9tZca2oMi
         D7ABQQQY9UkFNKTQB1OottPkFoRRp0TNFALYS6gLInS5lahWnlU1dUbW8DqZTtrGrPor
         +cUMDIpy0J6H2Vnt0Y9g89qNO93xQYvM9zfTMDfuur8vmDJr2JurqIbWfSakDNH5PsaP
         FmFnJJS91YAjpuKq3FbvjTanqHlAQactNBHiIlpbW5bpfU7YliAdlNoU15Sic3PB7s2U
         5lwg==
X-Gm-Message-State: ABy/qLbvuFCPIBvSwICsCboeAQUUHiSRdVlQ0XKo+/jmelbG0NWNr+/R
        fd2PEZ2KQogW5eLNOCXVP0Ensg==
X-Google-Smtp-Source: APBJJlFG7xP3kWlIhAjztkagQDMNNRwQQCBCM6HY7T4sw6w4iXF2O6xSpJHcGRvKu0zLgI2eKeSszQ==
X-Received: by 2002:a05:600c:244:b0:3fb:b1af:a455 with SMTP id 4-20020a05600c024400b003fbb1afa455mr12472486wmj.5.1689060416993;
        Tue, 11 Jul 2023 00:26:56 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb0:4a33:b29e:11b3:752b])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c228d00b003fbe4cecc3bsm12129242wmf.16.2023.07.11.00.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:26:56 -0700 (PDT)
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
 <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] spi: amlogic-spifc-a1: add support for max_speed_hz
Date:   Tue, 11 Jul 2023 09:25:31 +0200
In-reply-to: <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
Message-ID: <1jlefm6h8g.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 06 Jul 2023 at 14:03, Martin Kurbanov <mmkurbanov@sberdevices.ru> wrote:

> This patch sets the clock rate (spi_transfer->max_speed_hz) from the
> amlogic_spifc_a1_exec_op().
>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  drivers/spi/spi-amlogic-spifc-a1.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
> index a92e4fc23396..605e9e40455c 100644
> --- a/drivers/spi/spi-amlogic-spifc-a1.c
> +++ b/drivers/spi/spi-amlogic-spifc-a1.c
> @@ -107,6 +107,7 @@ struct amlogic_spifc_a1 {
>  	struct clk *clk;
>  	struct device *dev;
>  	void __iomem *base;
> +	u32 curr_speed_hz;
>  };
>  
>  static int amlogic_spifc_a1_request(struct amlogic_spifc_a1 *spifc, bool read)
> @@ -235,6 +236,21 @@ static int amlogic_spifc_a1_write(struct amlogic_spifc_a1 *spifc,
>  	return amlogic_spifc_a1_request(spifc, false);
>  }
>  
> +static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32 freq)
> +{
> +	int ret;
> +
> +	if (freq == spifc->curr_speed_hz)
> +		return 0;
> +
> +	ret = clk_set_rate(spifc->clk, freq);
> +	if (ret)
> +		return ret;
> +
> +	spifc->curr_speed_hz = freq;

There is no guarantee that clk_set_rate() has set the rate you have
requested, at least not precisely. You should call clk_get_rate() here.

> +	return 0;
> +}
> +
>  static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
>  				    const struct spi_mem_op *op)
>  {
> @@ -243,6 +259,10 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
>  	size_t data_size = op->data.nbytes;
>  	int ret;
>  
> +	ret = amlogic_spifc_a1_set_freq(spifc, mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
>  	amlogic_spifc_a1_user_init(spifc);
>  	amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));

