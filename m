Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3886B57CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 03:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCKCXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 21:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCKCXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 21:23:41 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297FC11CD75;
        Fri, 10 Mar 2023 18:23:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id n2so9015032lfb.12;
        Fri, 10 Mar 2023 18:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678501417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6D0xGz1yRgOqNxWPNQKfR3PLp4ljt7A3malbHARYKc=;
        b=fc1dwEqXyBWxW5fhadWQv814GFXDvw1ZFlPLAGaAsp+0yIY4/fcU5d8m2CQRSY6u7B
         tR0jIXDZSMND/3Nj1H7XWGZsk0xf04LX6VU8z/w7nEW48GTMzhnEn9VKSKYFk1Kes5dg
         cJ5fM5sFVUahy0xZCYp54JiOnmlRHAqwsh7u0OAJd/wKB5to0NG+hIWKk0ulVLEQNX2+
         0QYksx2t0hkIxgvOq/dSx+NJv8KGn0wMNwLDo6dVb5i281YkwyeA2phZZddQERxOUQEq
         Bjgk/wq44wcmGVEHZjWIdux1Iv8DVzfqhmsY0sH6MkG+HMMd9T8wSiyKXIudrGn0vr/m
         828g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678501417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6D0xGz1yRgOqNxWPNQKfR3PLp4ljt7A3malbHARYKc=;
        b=AcAEOon17/751LzE8lC2AKRFeBnVbqqoGRldmXJW4PHV0dG20MZick+FYdLACtRCqm
         KOozFZ5WVhFydZ4LZJgRDRwDeQCENRmjz5kH7CEfza4ejt7wVs/dDNRzTucSE0GYMIlT
         h/M8i/qYvzlRzg6F9XUAbUwNwMR7zjYAGskm/J093kBc7QDKZ3IsPmVFs9UJ4TPCkarz
         uDiojMkH6pSZsCblXazbaEeTn+xEl6gcO9VUd31oD7pT4GEWDFi8TNyccb/DtQ10+0dD
         9fI0Id7G5nAQ6rn5j4h1E4iOeGWByVb0jfoiZIv9UgnG6uDeG4q+xNMVf6hQBl5wMO+8
         15CQ==
X-Gm-Message-State: AO0yUKVr85A/oHffKbljtIaxy838KKEwxMA6pScAOSrWV0twRiFoOsy5
        79d7/qW7Dox5xdxC0EG6WkA=
X-Google-Smtp-Source: AK7set8HfjlwLcBDN909n1kCoiZ5KvSabHSjCrIGn1HLXNDleAUeSEK8NkKp248NXwp501KM76T99g==
X-Received: by 2002:ac2:4886:0:b0:4dd:9fd8:3a36 with SMTP id x6-20020ac24886000000b004dd9fd83a36mr8148159lfc.1.1678501417193;
        Fri, 10 Mar 2023 18:23:37 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id l14-20020ac24a8e000000b004db45ae3aa8sm159966lfp.50.2023.03.10.18.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 18:23:36 -0800 (PST)
Date:   Sat, 11 Mar 2023 05:23:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jack Chen <zenghuchen@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>
Subject: Re: [PATCH] spi: dw: remove delay between write and read
Message-ID: <20230311022334.he6ev6tswfc2xcwo@mobilestation>
References: <20230310153151.293608-1-zenghuchen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310153151.293608-1-zenghuchen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack

On Fri, Mar 10, 2023 at 10:31:51AM -0500, Jack Chen wrote:
> Delay between write and read in polling mode is not necessary in dw spi
> driver. It was added assuming that dw spi controller need the delay to
> send data from tx fifo to spi devices. But it is not needed because
> following reasons:
> 1) dw spi datasheet claims transfer begins when first data word is
>    present in the transmit FIFO and a slave is enabled. So at least we
>    do not need the full fifo-size-transfer time delay.
> 2) in practice, due to spi devices implementation, spi full-duplex
>    (write and read real data) is always split into two transfers.

In practice the delay is specifically added to minimize the dummy
loops in the poll-based transfer. It's calculated based on the number
of bytes pushed to the Tx FIFO and the SPI-bus clock rate (that's why
the spi_transfer.effective_speed_hz field is initialized in the
driver). So after all of them are transferred we get to start reading
data from the Rx FIFO. Until then the kernel thread is supposed to
sleep giving up the CPU for another tasks.

> Delay between spi transfers may be needed. But this can be introduced by
> using a more formal helper function "spi_transfer_delay_exec", in which
> the delay time is passed by users through spi_ioc_transfer.

This is wrong. spi_transfer.delay is supposed to be executed after the
whole transfer is completed. You suggest to to do that in between some
random data chunks pushed and pulled from the controller FIFO.
Moreover that delay is already performed by the SPI-core:
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L1570

-Serge(y)

> 
> Signed-off-by: Jack Chen <zenghuchen@google.com>
> ---
>  drivers/spi/spi-dw-core.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index c3bfb6c84cab..7c10fb353567 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -379,9 +379,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
>  
>  /*
>   * The iterative procedure of the poll-based transfer is simple: write as much
> - * as possible to the Tx FIFO, wait until the pending to receive data is ready
> - * to be read, read it from the Rx FIFO and check whether the performed
> - * procedure has been successful.
> + * as possible to the Tx FIFO, then read from the Rx FIFO and check whether the
> + * performed procedure has been successful.
> + *
> + * Delay is introduced in the end of each transfer before (optionally) changing
> + * the chipselect status, then starting the next transfer or completing the
> + * list of @spi_message.
>   *
>   * Note this method the same way as the IRQ-based transfer won't work well for
>   * the SPI devices connected to the controller with native CS due to the
> @@ -390,21 +393,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
>  static int dw_spi_poll_transfer(struct dw_spi *dws,
>  				struct spi_transfer *transfer)
>  {
> -	struct spi_delay delay;
> -	u16 nbits;
>  	int ret;
>  
> -	delay.unit = SPI_DELAY_UNIT_SCK;
> -	nbits = dws->n_bytes * BITS_PER_BYTE;
> -
>  	do {
>  		dw_writer(dws);
> -
> -		delay.value = nbits * (dws->rx_len - dws->tx_len);
> -		spi_delay_exec(&delay, transfer);
> -
>  		dw_reader(dws);
> -
> +		spi_transfer_delay_exec(transfer);
>  		ret = dw_spi_check_status(dws, true);
>  		if (ret)
>  			return ret;
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
