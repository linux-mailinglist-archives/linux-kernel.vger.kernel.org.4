Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457027411D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjF1M53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjF1Mzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:55:52 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826252D50
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:55:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so2376053276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolution.nl; s=google; t=1687956950; x=1690548950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iD2tw9vOS0lrg1X3bxbq4vEfHnMlyogsPaJF24ZAxuQ=;
        b=N4Irq8s4HBNojI+j2hpkXGl+oGiD99Um86UUBubKU4eOKisksyBfE/7+dUh2CtYldZ
         uIyzpzqp5Gr2ExG1DTdKJcceq7VIc4IJu4iBbU4QOwbRVR4p08q2YDV6J9qRAh10wSfP
         RBMGlnvmQ774h0SKFEFqNzt7Ia2ujE4Ho0Tko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687956950; x=1690548950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD2tw9vOS0lrg1X3bxbq4vEfHnMlyogsPaJF24ZAxuQ=;
        b=ZOHfBlgDjdQa17LDDXNYfvdl+lYB+AwZx2fvPPTBaLWBtcYTsKzztON095JxRKhH2z
         GqrbNgZKgZB+c1PWe/3r9LJzScdgHQ1tkXrNAFrXKj9Bk+nSRmksbsOX7e9QP+VhKqpU
         4Impt9NEVqs/E3VT2BzvWo0wkGTxzfpE/84k1KS8vwD8CnwVhLmrxYgTIGLwTilDg2+Q
         D+vlLFdsGjdJGV/f9Ucmc3tg7CUbu44+PZHQfimv5IZXltAqmfTCINblkbbd2rbweAri
         AiTinlFNI/jh56G18+f/G2v1oyUtx2tORgIv1lTU7IVF2pPrHenGM4vNLATLKMiLOb4Y
         rF3A==
X-Gm-Message-State: AC+VfDzn+YbF5Ze0JLCdsEGRMs9cg7YKvsle9agqqpziDZiviz7qCWuk
        QBwrVw5G8YZ4TntM9ZautSDEsvhe/htErUJ7fbmhcUF943x/7PdcYsUl76IDRVZ+eNAsnGkSp2j
        rzg2DpFUt3tKPXLSP/RaWfxFwbvM5rRhP4w==
X-Google-Smtp-Source: ACHHUZ7PMRGajU5y5LS+ndBWZH/f28/boOqs3KXglygkyhG0rDT6SxPSfaSiQdfYhe79w0JA297k49uHTfAAr08Yrus=
X-Received: by 2002:a25:dcd1:0:b0:c15:2fed:3b43 with SMTP id
 y200-20020a25dcd1000000b00c152fed3b43mr13463079ybe.9.1687956950771; Wed, 28
 Jun 2023 05:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3BuKAVzXWNNiYDceNCpBqBmKyEykKA3rX=cfTyz+gWaJcnkA@mail.gmail.com>
 <d1227506-e9b0-4f75-a63b-e25e0c621c48@sirena.org.uk>
In-Reply-To: <d1227506-e9b0-4f75-a63b-e25e0c621c48@sirena.org.uk>
From:   Stefan Moring <stefan.moring@technolution.nl>
Date:   Wed, 28 Jun 2023 14:55:40 +0200
Message-ID: <CAB3BuKA95i0NQ7xtQv9jmB_xAv1YG+XEuFAxHNeCMnpLwz3pQA@mail.gmail.com>
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer length
To:     Mark Brown <broonie@kernel.org>
Cc:     shawnguo@kernel.org,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, "festevam@gmail.com" <festevam@gmail.com>,
        linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-techno-validated: techno-validated
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My bad, I resend it using git send-email.

Op wo 28 jun 2023 om 13:54 schreef Mark Brown <broonie@kernel.org>:
>
> On Wed, Jun 28, 2023 at 10:41:27AM +0200, Stefan Moring wrote:
>
> >   ctrl |= (spi_imx->slave_burst * 8 - 1)
> >   << MX51_ECSPI_CTRL_BL_OFFSET;
> > - else
> > - ctrl |= (spi_imx->bits_per_word - 1)
> > - << MX51_ECSPI_CTRL_BL_OFFSET;
> > + else {
> > + if (spi_imx->count >= 512)
> > + ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
>
> Your patch is completely mangled and so can't be applied - please check
> your setup for sending things.
