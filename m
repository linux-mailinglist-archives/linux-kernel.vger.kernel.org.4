Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C72E724CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbjFFTP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbjFFTOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:14:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A810FF;
        Tue,  6 Jun 2023 12:14:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977d55ac17bso489087666b.3;
        Tue, 06 Jun 2023 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686078881; x=1688670881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SJEaV8T/sYYCwdM8Gx2yuajVAOxeMIbe0SRp4ADBgM=;
        b=omnYlGR/GNyTd0IiUcIrv5Z0/d4ZIfPzPgWmMjdUi3mIjPrO+pvqdgaV6U8U6RitAj
         rk+PvSopMXP0QgDe33krTiaSElPbAAo0k/POIhOu7UJ0euj68r0VrhkI5guMWb7Nwat0
         ymhfPYOTydjhu4tNBC/w4z3nX/D8kZJ/Lj1SIazbquP34Pu9CFqPDq4gCtnN6uEO8L8q
         F1cLUKhfb9KOYLPUTZrohGwxRuli1wD0nqOITn3ZRRrfwzGBmFBqjCfHuKp0D/6+wkLM
         +f2WWf/guPHFWHTyRwBTwKNPaVSRRPAKWv1PKpylHl864JdMgnw9ktb2YRgrWJqiVjPg
         bHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078881; x=1688670881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SJEaV8T/sYYCwdM8Gx2yuajVAOxeMIbe0SRp4ADBgM=;
        b=YsFab1UmmPrx/ALXkz9yG0MjUMRQxFE+XTFkqJ4mr8f7eYjxdQCh+iBvrEVLk3WjHn
         4ysRWYEnWqPP+DJlNX/Z6GjAyYdfasS17LjeS0OUVimI3WJfp8XxEBZFYzFRrd7QVsIt
         QhJoxgTzqZehgPpDb3YPe0HWKqIgpQBmTpNSLk46im9d5QhWAjbQHsoBIXckkiGAz94T
         Gkgsru+7/YJ1+Q2nVBouRdio97yF4Nn7sUw9YN/+LonZcK+fUV0+LPV9IqtfDp1VWF7A
         EOFOX0KuwyoGnkaPJ1QTD3ZSfFzVSHwwnslZ8Y38GyncCms32R5bRD8K7NwdKFmtEa09
         VBKQ==
X-Gm-Message-State: AC+VfDx0IaxGDyCBbY5zb4I4fwVkULsecnOS4ZeyFl/dWLmNZF7YnfCY
        x1zmqb0QsrA8SLSRafxG7UpxvqQRqi2u8nnZ7zI=
X-Google-Smtp-Source: ACHHUZ4VYL03ivVNoI46To2Gjh7laENXTsosnF2kr0WLbdADTsBChuCXHWGzOLkkOrIgSRFMhq4NALegpRF94Ir9Z0A=
X-Received: by 2002:a17:907:9721:b0:94e:2db:533e with SMTP id
 jg33-20020a170907972100b0094e02db533emr3738942ejc.49.1686078880474; Tue, 06
 Jun 2023 12:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230606165357.42417-1-gnstark@sberdevices.ru>
In-Reply-To: <20230606165357.42417-1-gnstark@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 6 Jun 2023 21:14:29 +0200
Message-ID: <CAFBinCBzrXpfzNb9COVHg13uCmXTBhnS6YLVyFR=YCkj9v-ypg@mail.gmail.com>
Subject: Re: [PATCH v3] meson saradc: fix clock divider mask length
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you George!

On Tue, Jun 6, 2023 at 6:54=E2=80=AFPM George Stark <gnstark@sberdevices.ru=
> wrote:
>
> According to datasheets of supported meson SOCs length of ADC_CLK_DIV
> field is 6 bits long. Although all supported SOCs have the register
> with that field documented later SOCs use external clock rather than
> ADC internal clock so this patch affects only meson8 family (S8* SOCs)
>
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Aml=
ogic Meson SoCs")
> Signed-off-by: George Stark <GNStark@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
