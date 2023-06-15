Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D986473161F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbjFOLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbjFOLGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF42976;
        Thu, 15 Jun 2023 04:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC8FE6299E;
        Thu, 15 Jun 2023 11:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BACC433CC;
        Thu, 15 Jun 2023 11:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686827166;
        bh=EzK3/0FxLXQ2Eumtuqysipl2SLIHr3Bh2lrMfgp6YLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAtmhWqF87jqZR2KtFKIaiSpAGyaj3lFjS9H2d4R9h5cMKLunUn3539SymxFyASg/
         hWRytr/+MS15+g3QoNcBhGCu6oYNhJbYyz54E0kZ0TcNbSdzTNpFEb741Qgkqv/LT7
         iNu7Ex3VrqjKuWIy8SBRgXsh/BJZtCjnjGkdKuSyA8yPbg4LVBL3JN+O7W/+kz0IqS
         GRHYbTy2eMOoRIbRoTeUErLy5rJvluCKHW6MryUam8sys9/CteN/4Bf0MRj+EFkwil
         11ea2kRKQtTO2+RDewKxh31jmKudEGkqGhiZkzMp7VBrCTSxRJZeUh/U/6QCmXYsIj
         FybNqIV4rEiLQ==
Date:   Thu, 15 Jun 2023 12:06:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from
 dma_request_chan()
Message-ID: <5383f9ba-0659-4642-9e58-0e33a2df6b53@sirena.org.uk>
References: <20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v1-1-6da9bf2db4a4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NUz4BNeQxYNXFVmx"
Content-Disposition: inline
In-Reply-To: <20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v1-1-6da9bf2db4a4@linaro.org>
X-Cookie: You are false data.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NUz4BNeQxYNXFVmx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2023 at 11:23:17AM +0200, Neil Armstrong wrote:

>  			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
>  			break;
> -		}
> +		} else if (ret == -EPROBE_DEFER)
> +			goto out_pm;
>  		/*
>  		 * in case of failure to get gpi dma channel, we can still do the

Both sides of an if statement should have braces if one side does.

--NUz4BNeQxYNXFVmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSK8JcACgkQJNaLcl1U
h9BZjgf/WCjAWC4bGBYIoMu7kx+lAtJrQh7G4Ejt1KOhX8EHlPrIMDcYq8ASiSjk
Q+fHrQrZhSBTJxKPiMmOJzKpKO2GjUZ2dmmEXIl9P+rRWT6JHe6pkl2VO6zJUOTn
6K4iDIUtvzkp5V/geONAdcy25HqK742sZmTBfrHNNwwV83PRkg2DEedAZ+CfcNxz
i94+FdLlXT+/wa/sr+tceW205yI2op+pn4xbCEOok7HjAuFeH3edzcugy49Vo1a1
KW8VQwkjqp4qKSwq21ZXxXgdYos9YPHuw5dqINRSYneuuWANoCJ7m21FJz//OfbY
eAYl9skY+YIQ+9v4sCtqdS3E5/CrZg==
=oZO4
-----END PGP SIGNATURE-----

--NUz4BNeQxYNXFVmx--
