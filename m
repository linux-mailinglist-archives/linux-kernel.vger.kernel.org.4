Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32B6E9B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDTSJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDTSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:09:42 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ED1FC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:09:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k39so2825895ybj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682014180; x=1684606180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FVvbbOx6CVUuVacoumj0fiPSi4Hh5DrvtofkdN8frA=;
        b=lF7c7I3r+GelCaWzXM7PCkuXl3zGosHc4VyqsbWsx8JdG+c6qzcF7MidxK7oMGJMQX
         fz6Yf86PT9rWAOingxUPYicElbV6S0erBJ7+G9y3KqoTMjUuLnMAGhOVTU/KB03t7aUK
         u2oVtTiVMOiNhbZvAbiArXL3Glg1C5StaTEP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014180; x=1684606180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FVvbbOx6CVUuVacoumj0fiPSi4Hh5DrvtofkdN8frA=;
        b=Swl0x0InzoiI5P/uBF7R6iWP3GkPQO85vPKI1MO5iTboYcudqdD6YZniiHxV+jvymk
         fs8lgndKV4QD97q/OzYOyRbyoORqve6vzmtk3MT2pm2nNBsq+2KX5wTCbIaW5XT6DJak
         uFbaWY1slUjUdlud7lds92i1bGAsQhjo3yEkgC8z9GBFHdjVy4fGLLigK6vWUwxmMJGe
         BHj7nCBzEJCWZRTt+Iq2kY0c/qnRBtoTcW4qC3Exs8uP/zr/iCYTRzLZqbvnA1PRTUO9
         i6jyr+39rsCHzVwp5pc0mDgPqRAc0rdr7wXi0Vaekdjg1MeINxbxts/71cOEVb/9jCcA
         L9tw==
X-Gm-Message-State: AAQBX9e9LoBU8EfTLeyZhRA6XhyIS+02UueyGEzknrgbXxlkf97bXm+I
        W86dkn13LGV+1xTRE3A6Aq/5PMLRtkRIoY7XzwA=
X-Google-Smtp-Source: AKy350ZPWwAeiiRfygJLsw6VPEYR7NWkEBNoNi5SYake8CjCz91nAiKgkehQ5J4IxtjU8mWE4MzVCA==
X-Received: by 2002:a25:ae0b:0:b0:b8f:4490:3c with SMTP id a11-20020a25ae0b000000b00b8f4490003cmr1754254ybj.10.1682014179864;
        Thu, 20 Apr 2023 11:09:39 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id i83-20020a256d56000000b00b8f448e1b6csm440533ybc.1.2023.04.20.11.09.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 11:09:39 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id n203so2841487ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:09:39 -0700 (PDT)
X-Received: by 2002:a25:d895:0:b0:b98:6352:be20 with SMTP id
 p143-20020a25d895000000b00b986352be20mr750560ybg.0.1682014173924; Thu, 20 Apr
 2023 11:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 11:09:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkSQUSkY0UsU=s=PhXYRCrh-0TWM4K7FRfymTtL+MbcQ@mail.gmail.com>
Message-ID: <CAD=FV=UkSQUSkY0UsU=s=PhXYRCrh-0TWM4K7FRfymTtL+MbcQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] spi: spi-qcom-qspi: Add DMA mode support
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 20, 2023 at 6:13=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> @@ -528,6 +760,7 @@ static int qcom_qspi_probe(struct platform_device *pd=
ev)
>         master->prepare_message =3D qcom_qspi_prepare_message;
>         master->transfer_one =3D qcom_qspi_transfer_one;
>         master->handle_err =3D qcom_qspi_handle_err;
> +       master->can_dma =3D qcom_qspi_can_dma;

One extra comment: it might be worth adding something like this (untested):

if (of_property_read_bool(np, "iommus"))
  master->can_dma =3D qcom_qspi_can_dma;

That will have the dual benefit of making old device trees work (which
we're supposed to to if possible) and also making it easier to land
these changes. Without something like that then I think transfers will
fail for anyone who pulls in the SPI tree but not the Qualcomm DT
tree.
