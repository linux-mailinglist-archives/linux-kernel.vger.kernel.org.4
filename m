Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC8719AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjFALW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjFALWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:22:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1834139
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:22:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f8115ca685so5702701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685618570; x=1688210570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUmhHU1fbhyU+RUYWStGTJNMxjAzPmJ//EgW00C5mZw=;
        b=eZ9To0SI50DTVI2dAf2RP1StKYs+cyEqUpAF2574fnqGhgB2TAaZ0gBa8bYXdn/j0x
         FuBa8X6m1Y1EYf3bzxSBu2csTyMGZkE9/fuq0cSSE1h5sqzqaZhxg4bU1VFvtPSzv9lW
         5QLOOoGgY2C/+BRg+CxZVUgRFDUMQ2vepXR8quVdyenHux1FM0wWOKni7MlZMsghXV69
         FUODS4sK/uZiVM1aOfjh7UXurbvyBjLO3yR32V+j2o7vSqQ5w39O3/jGmJebHAl220wl
         l2YbU4dB3dhyKQsqpA//vOIfL9sewdZswWZOJLPoyEsCk6buDMIeXHjvUR1hnxPzY0TO
         4ZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685618570; x=1688210570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUmhHU1fbhyU+RUYWStGTJNMxjAzPmJ//EgW00C5mZw=;
        b=jkA+sKbuVtNJHV95yZcx6CO102Tvsg6yMdlzO/XuKSi1zoQbQwRIu87foGGNWh0eoY
         CGlMOAJ9bPb508sdkgkbNzoEPbf6X/ESCWAqP03rrqp3YSoq96BkGpYTfTwalJl7gcUg
         1jGZWpTRsf1OodOSSuyKiZbI57m03hs/lSrgnlXPUfWTfPwF5Ycp8VTqcx9qhcrN8v6H
         4n9ksCwnFXOl7nmYcBIMYKyOB9KNpfYEb3DRE1MqwEaIf5pdfxfRFgAJbLb8iv8x10y8
         Un2I4EgbZy6jOOMZNs72iJZiyRq1LG3neI4w7GTYEfk/vo7U/sTpsbAmZ1kbtMULTjZO
         frmg==
X-Gm-Message-State: AC+VfDzKogOwdStDzeRPdHLaOaeqDjrP+cWK5FpjFz9e8B3mTL1KMh+T
        4OMJxqfSoQcquivAM6a/7VvKw9MqToJL5OnH5DYAnA==
X-Google-Smtp-Source: ACHHUZ672XhBtqgSSO+77bYpfA5o+5/XdJD5UDVXzB2ag05nisa3IUi07jZC+Cq76E6sC0H/aS/YY93daCCv9WmxO/Y=
X-Received: by 2002:a05:622a:182a:b0:3f6:b055:81ff with SMTP id
 t42-20020a05622a182a00b003f6b05581ffmr9265467qtc.50.1685618569842; Thu, 01
 Jun 2023 04:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com> <20230530122112.1314458-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20230530122112.1314458-5-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Jun 2023 13:22:49 +0200
Message-ID: <CACRpkdb-jk50gO_Y-7NKQfLjPOH6ZwL37YsQJoJNfoqS+N8NVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pinctrl: cs42l43: Add support for the cs42l43
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 2:21=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
>
> Add a basic pinctrl driver which supports driver strength for the
> various pins, gpios, and pinmux for the 2 multi-function pins.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

This version looks acceptable to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess it will be merged with the rest.

Yours,
Linus Walleij
