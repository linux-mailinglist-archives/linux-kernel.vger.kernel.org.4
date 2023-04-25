Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F236EE363
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjDYNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjDYNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:45:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB02146C8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:45:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-959a3e2dc72so477828566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682430331; x=1685022331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vvGrNptYZRi7xQ7+JJCpqEOje87cPoMWG8Zptna2m4A=;
        b=EeB6xq/YH3AkAtURNR67x52RNeUgiCTEZRLPAYRxr+VY0h7Y9U6VLW8HybsEUzDA63
         4h9ufPDC2R41r0CbWzGx+LZ7zNkFkFitOaXRQ6hRiAxjZLjBbKH2ELP5NNP5LGLDID0+
         PjyrKifRV/6HStMYUN+ssbswKR8s1+YyFhhb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430331; x=1685022331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvGrNptYZRi7xQ7+JJCpqEOje87cPoMWG8Zptna2m4A=;
        b=jRWA0mdYSw+H/fwFC8ff+xmaYHgq5IKxYqr+FpixsYSP11WgFA3JSNnA2Z+vjGjG8Z
         fDtrtHtIHs9WoV4Z2Nm/24CZurzkV84AUVPUccAsl8qkJTxIHM/2fOiek3pKCbhibSsI
         klgRLAbgT7+sxi5VBxq5fn/37mB9Zv8Ua5PYncS8KQYSk/fUsi3hf5XVPfHFPDcmM8Uq
         VMxYa6Cffi3UOhdxC6zvL1Tj22wwBxZL+rCEKDfpZltFrFh45QiUruyexwCHPGupCt5L
         +w6q2vmWeCyb3OwxmdXs0tIaaQAOeyur0qCG+MutEATC9Q0DvtoOSXkflHYXf4tDbYvs
         6BuA==
X-Gm-Message-State: AAQBX9cWdA9Q/RqpobmNfHhKHntGCeWSyub8UuMXxlWf5ynkDJ3SmfGn
        VlpXALks/hNnowvAssoePPteCw==
X-Google-Smtp-Source: AKy350Ze96qfhykAyDc+5d3Rn5tKWwOIXWgOW7uoHjWHqUSYwA+lCrAyVmKAB2qo+RdC+u8ZAsE5dQ==
X-Received: by 2002:a17:906:9bea:b0:94e:e082:15b9 with SMTP id de42-20020a1709069bea00b0094ee08215b9mr12207814ejc.77.1682430331219;
        Tue, 25 Apr 2023 06:45:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906048a00b0094eeea5c649sm6806822eja.114.2023.04.25.06.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:45:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/3] spi: spi-imx: fix use of more than four chip selects
Date:   Tue, 25 Apr 2023 15:45:24 +0200
Message-Id: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current spi-imx driver completely fails when used with more than
four (gpio) chip-selects, since the chip select number is used
unconditionally as shift amount when updating the control and
configuration registers, so the code ends up modifying random bits
outside the intended fields.

This fixes it by making use of the unused_native_cs variable filled in
by the spi core, and use that as the "channel number" for all gpiod
chip selects.

In the presumably common case where all chip selects are gpios, this
means we end up using channel 0 exclusively, so the optimization where
the config register is left alone if it is unchanged (see
184434fcd617) might become less effective, if the workload consists of
different slaves with differing spi modes being accessed one after the
other. It would be nice if one could make use of the unused native
chip selects in a round-robin manner, but for that the core would have
to tell us not just unused_native_cs, but the whole ~native_cs_mask
from spi_get_gpio_descs(). Maybe a simpler fix, if there is anything
to fix, is to make the new mx51_ecspi_channel() do

	if (!spi->cs_gpiod || spi->controller->num_chipselect <= 4)


Rasmus Villemoes (3):
  spi: spi-imx: use "controller" variable consistently in
    spi_imx_probe()
  spi: spi-imx: set max_native_cs for imx51/imx53/imx6 variants
  spi: spi-imx: fix use of more than four chipselects

 drivers/spi/spi-imx.c | 56 +++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

-- 
2.37.2

