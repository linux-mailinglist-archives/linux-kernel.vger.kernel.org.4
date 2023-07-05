Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB89F7481D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGEKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGEKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:17:25 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA9C180
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:17:24 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 20f0bf1a-1b1d-11ee-a9de-005056bdf889;
        Wed, 05 Jul 2023 13:17:22 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 5 Jul 2023 13:17:21 +0300
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1 1/2] spi: amlogic-spifc-a1: implement adjust_op_size()
Message-ID: <ZKVDMV95gZN4oQjx@surfacebook>
References: <20230703094518.53755-1-mmkurbanov@sberdevices.ru>
 <20230703094518.53755-2-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703094518.53755-2-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 03, 2023 at 12:45:17PM +0300, Martin Kurbanov kirjoitti:
> This enhancement eliminates the need for a loop in the
> amlogic_spifc_a1_exec_op() function and allows the SPI core to
> dynamically divide transactions into appropriately sized chunks.

...

> +	if (!data_size) {

Why not positive check?

> +		ret = amlogic_spifc_a1_request(spifc, false);
> +	} else {
> +		u32 mode = ilog2(op->data.buswidth);
>  
>  		writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
>  
>  		if (op->data.dir == SPI_MEM_DATA_IN)
> -			ret = amlogic_spifc_a1_read(spifc,
> -						    op->data.buf.in + off,
> -						    block_size, dmode);
> +			ret = amlogic_spifc_a1_read(spifc, op->data.buf.in,
> +						    data_size, mode);
>  		else
> -			ret = amlogic_spifc_a1_write(spifc,
> -						     op->data.buf.out + off,
> -						     block_size, dmode);
> -
> -		nbytes -= block_size;
> -		off += block_size;
> -	} while (nbytes != 0 && !ret);
> +			ret = amlogic_spifc_a1_write(spifc, op->data.buf.out,
> +						     data_size, mode);
> +	}

...

> +static int amlogic_spifc_a1_adjust_op_size(struct spi_mem *mem,
> +					   struct spi_mem_op *op)
> +{
> +	op->data.nbytes = min_t(u32, op->data.nbytes, SPIFC_A1_BUFFER_SIZE);

I would rather use min() for strict type checking.
In this case it will require to have U/u suffix in the SPIFC_A1_BUFFER_SIZE
definition.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


