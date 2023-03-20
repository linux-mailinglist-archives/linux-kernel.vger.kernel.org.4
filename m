Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA06C1449
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCTOEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCTOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:04:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF9915CB6;
        Mon, 20 Mar 2023 07:04:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e11so3582918lji.8;
        Mon, 20 Mar 2023 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679321067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsbZOQcvn79ReH0c42ptAFn4pTeCDQ4LtCfWuiMb6bE=;
        b=YnifrPOXpPE5N2DSHYuRUZnDCM3xEVk4ANWZwNTi6qPuiH/wTYtxjQS6e5IuCxGjGz
         Y1D89V1OyOw5ViuraB2MAAlMaPnZxkSVI5QgehJreW3mTUmifnKy8U+y3eEIBRXrssCH
         QKPnIv76ZAo0Y6cdCcVSEYUsCwH2/4nxibalj0fTiCKZHqELUwoJJwdY7PWhrVIrsL7W
         NUqYmt101q0vUI4UuRWjdAe4b6fTBsd3FphKTQta7mcvIbl/iJCp8D2uoJdHttLzKxYX
         m4l7J3EZgxkzymH+1EaReFELwMOlM4dzbJziwGpzZjaz8fE8k2eQN402iMJaTU0EIMtR
         ncTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsbZOQcvn79ReH0c42ptAFn4pTeCDQ4LtCfWuiMb6bE=;
        b=myLb6AwiXiDB/dl7hjJ9oohAFU+1Zvu3pYm28NdnpaBIjh/sqEfXGKcpN31ikEzHle
         fS48BejrhoOxK8rAmcboQScdpdkMr+hvEWWkSnFyDmNVruTP2ozRLyYIQ90SxtjJu6VS
         dsBTEycUck2Caf3lb17PNI2sAiR0v7gpgYMNtSpZmfgIXRla6lO8ucY9fEwlJviTiuSf
         PTSWRaRRLDYDvDWmdWNZkMTBYBcOVI4PsP5WLdrPpgRiR1MA637URvxjsJrE1Vpimc9o
         FpShYTgBrnEMq0Ybx/m9nDA2gLAV0L5QGKzem5SAWzhtoNJGsrJN9bgu5XXm8fkWMm6N
         05zg==
X-Gm-Message-State: AO0yUKU5iMVlwftkVCmUk9CaglB9m8sY4y9bZs+BSlGjOy2rbd25ZAgx
        KMoRo4MkGUhXv0G0D5/XzzI=
X-Google-Smtp-Source: AK7set+RsEPZ8ews6fbjUagjzWWITxpK57LsPa5rRpb+etKD5xFKeWE8Mwt7QCzVyr3a4aYK5gkCUw==
X-Received: by 2002:a2e:82c5:0:b0:28b:6525:e6b1 with SMTP id n5-20020a2e82c5000000b0028b6525e6b1mr3557899ljh.24.1679321067453;
        Mon, 20 Mar 2023 07:04:27 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id i21-20020a2e8095000000b0029c92214148sm556389ljg.73.2023.03.20.07.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:04:27 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:04:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <20230320140424.pfy4zf6dfwgf2xyj@mobilestation>
References: <20230320055746.2070049-1-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320055746.2070049-1-joychakr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joy.

On Mon, Mar 20, 2023 at 05:57:46AM +0000, Joy Chakraborty wrote:
> If DW Controller is capable of 32 bits per word support then SW or DMA
> controller has to write 32bit or 4byte data to the FIFO at a time.
> 
> This Patch adds support for AxSize = 4 bytes configuration from dw dma
> driver if n_bytes i.e. number of bytes per write to fifo is 4.
> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

> ---
>  drivers/spi/spi-dw-dma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index ababb910b391..7d06ecfdebe1 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -212,6 +212,8 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
>  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	else if (n_bytes == 2)
>  		return DMA_SLAVE_BUSWIDTH_2_BYTES;

> +	else if (n_bytes == 4)
> +		return DMA_SLAVE_BUSWIDTH_4_BYTES;

In case of the DFS-width being of 32-bits size n_bytes can be 4 and
theoretically _3_ (practically it's unluckily, but anyway). Here
it is:
...
if (dws->caps & DW_SPI_CAP_DFS32)
	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
...
dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
...

So what about converting the dw_spi_dma_convert_width() method to
having the switch-case statement and adding the adjacent "case 3:
case 4:" statement there?

* We could add the individual case-3 branch with DMA_SLAVE_BUSWIDTH_3_BYTES
* returned, but the DMA-engines with 3-bytes bus width capability are
* so rare. So is the case of having n_bytes == 3. Thus I guess it
* won't hurt to extend the bus up to four bytes even though there are
* only three bytes required.

Please also note. Currently the spi-dw-dma.o driver doesn't make sure
that the requested buswidth is actually supported by the DMA-engine
(see dma_slave_caps.{src,dst}_addr_widths fields semantics). It would
be nice to have some sanity check in there, but until then note DMA
may still fail even if you specify a correct buswidth.

-Serge(y)

>  
>  	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
>  }
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
