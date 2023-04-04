Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC566D6B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjDDSRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjDDSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA9310D1;
        Tue,  4 Apr 2023 11:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B41F63836;
        Tue,  4 Apr 2023 18:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F83EC433EF;
        Tue,  4 Apr 2023 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680632235;
        bh=vecS1rMZwna2jwd0r4is1sU1FGqAK45eMK1pf6rma2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5YgiPUjRdkDNfKFybm84mcNTEYwvACfjLNgiCxWqnR1yi8J9AqW5xzssUQDcVOfx
         a/QMi5iooEOgxTPoVTH1YeDPcjouaJ68r6QNiGFjGX/ZyNR/lJ68Cc2sir/k1C6CrI
         YUT/FYGBun4FCR29ObWT2D8xg30rbQz8bspTaDNuMg8cN63pe/FJKDoTWxJo4+JDd7
         dik1Co50BM1tYOkI0NGPfrZUy9Sn+ve3x3VWuek2jk4LqrtIDfS59LZv+XT3GvuqgK
         qF+2RhAf0EWC7Za4Me67yL/PDXuZYc4dyclaTMzWCPoSAJxSFzppoPaZXuCiNtrBMf
         AhTEue0YsMNCw==
Date:   Tue, 4 Apr 2023 19:17:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
Message-ID: <d784dab7-a1a6-4db7-aa13-e39e9904f342@sirena.org.uk>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kDrRpbySrwTW+T6a"
Content-Disposition: inline
In-Reply-To: <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kDrRpbySrwTW+T6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 11:33:20PM +0530, Vijaya Krishna Nivarthi wrote:

A few quick review comments, mostly coding style though.

> +struct qspi_cmd_desc {
> +	uint32_t data_address;
> +	uint32_t next_descriptor;
> +	uint32_t direction:1;
> +	uint32_t multi_io_mode:3;
> +	uint32_t reserved1:4;
> +	uint32_t fragment:1;
> +	uint32_t reserved2:7;
> +	uint32_t length:16;
> +	//------------------------//

What does this mean?

> +	uint8_t *bounce_src;
> +	uint8_t *bounce_dst;
> +	uint32_t bounce_length;
> +};

> +
> +#define QSPI_MAX_NUM_DESC 5
>  struct qspi_xfer {

Missing blank line after the define...

> +	for (ii = 0; ii < sgt->nents; ii++)
> +		sg_total_len += sg_dma_len(sgt->sgl + ii);

Why are we calling the iterator ii here?

> +	if (ctrl->xfer.dir == QSPI_READ)
> +		byte_ptr = (uint8_t *)xfer->rx_buf;
> +	else
> +		byte_ptr = (uint8_t *)xfer->tx_buf;

If we need to cast to or from void * there's some sort of problem.

> +/* Switch to DMA if transfer length exceeds this */
> +#define QSPI_MAX_BYTES_FIFO 64
> +#define NO_TX_DATA_DELAY_FOR_DMA 1
> +#define DMA_CONDITIONAL (xfer->len > QSPI_MAX_BYTES_FIFO)
> +

DMA_CONDITIONAL absolutely should not be a define, this just makes
things harder to read.  Just have everything call can_dma() when needed.

> +#if NO_TX_DATA_DELAY_FOR_DMA
> +		mstr_cfg &= ~(TX_DATA_OE_DELAY_MSK | TX_DATA_DELAY_MSK);
> +#endif

Why would we add extra delays if we don't need them, might someone set
this and if so when?

> +	if (ctrl->xfer_mode == QSPI_FIFO) {

> +	} else if (ctrl->xfer_mode == QSPI_DMA) {

>  	}

This should be a switch statement.

--kDrRpbySrwTW+T6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsaaMACgkQJNaLcl1U
h9BZfQf9E/FbfM9Y8h2lD6huqt78OFAf4jE1tjFt0kIcwXUTKo8u2VXaJ8sshPn5
rIlF+ebk/XkQ1XkEyxP/oaCj8W5Jnut1nIjMAkjKrwjN/vrHN8O/HO5C9A0SXq3p
uxefYwl9dgHK15YL+GpqD+syqm1KglJKE57uJGcV/FMD3UraYXrxBU0LH+nHCkR8
fK7tGA0V6YyMazCSXCP9gmd5FL/kdriaX+arH/WErKhxFeLsd4aiqwNSXsV0S9My
xbWwJd55w0umfou96GNxqblH5CCyQSFjBdhu34EKXTr3nNnX3a5WT25tE+xWfcAf
EUqHBrMNpvUHv9xGonWDnEicW50ylA==
=qQMD
-----END PGP SIGNATURE-----

--kDrRpbySrwTW+T6a--
