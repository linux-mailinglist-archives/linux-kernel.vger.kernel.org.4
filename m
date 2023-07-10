Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4974CF86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjGJILD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGJILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:11:01 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04AEBB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:11:00 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4435fa903f2so932091137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688976660; x=1691568660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8C1tc/aFpE761mbwN0rABrPd3h3QC2pJRWDlmS2JEw=;
        b=dM41Kiv1XY5eTHvmQ7UmF0OakT00Rk48rxqsDWltTM1TUeFR5ld5r5lxJKCmh4qYSS
         6FNdMQkOAbadTRA/WO6pynyoOiIx1qPJZOr1BjtNHkL7gwq6j+tTv2syGxzqMjTyKV4f
         GldaHspBAAT8s8GfeYEPJHzgHJToRq2SEhGUMVMeVUEBy2JUOnTEFJUrGCvK7NPZfGe9
         1B6Vc8iELJxiWtkFsONmGfAOEBHEFM1QDovmom2SzBGoFCli81xw1yfpS/skxvwuC7pz
         xfQf8l0JxGtFzMktfjb7HNaXJ251aoF17Bvls/WoVO5Q5ZQQW0qpDp9X1h1o49NU00e3
         j34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688976660; x=1691568660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8C1tc/aFpE761mbwN0rABrPd3h3QC2pJRWDlmS2JEw=;
        b=dygQllhuxoNEgnzUD2L6YeQpWBDkbXmHfLoG2Ifpt16UDfH+6dwjFs5mXb+rmrCgee
         dinM6EOg9Zyx1CUsjleGvLYYm3mZVWbnKj5+RB1jtsvgTzSZshSxOgBd9L5MIwxMN30Y
         /tREJaZhKWHn64J0zVtO5hYCl8L/AgYBi4zdZQXNPNnNOhJ74u7K25Ffx4gA7saJqudZ
         kQhDHmef9AimtGb6XRKQmZ33m4w2bVYnc4tn+hx+IFS20OIUCuMrKyI81VPmR31XCSXo
         957aArn+evOtHvTZnRORbEPF+P9s1A+ZJoeeyRbVe7aoBFooxuzH1UAx6s4S8W1ge8G0
         HX7A==
X-Gm-Message-State: ABy/qLYVB9vCnA23wYrQz0u+QgOLOI2l9AswEq8QP+/Q1CShuX0qiJo/
        KnqYhhBbnQDmoRRomYXFAqOe3eJiJhAifuUS1PnOng==
X-Google-Smtp-Source: APBJJlF2wa/Pw4J9O2dwdTkSj48KHn1ru31SX8fnzAlZkt5a4bQ6LfrGYdfen/ffGqC4d1lEz1wuqdjf3l6Z7IcKsrk=
X-Received: by 2002:a67:fd4c:0:b0:445:bd5:5293 with SMTP id
 g12-20020a67fd4c000000b004450bd55293mr3365097vsr.30.1688976659785; Mon, 10
 Jul 2023 01:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230622121141.218623-1-brgl@bgdev.pl>
In-Reply-To: <20230622121141.218623-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Jul 2023 10:10:49 +0200
Message-ID: <CAMRc=MdegR2e7sFC+PQAy5WcQ3avb5Sz5VV0xCxAHqP2ZBJzCg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] arm64: defconfig: enable the SerDes PHY for
 Qualcomm DWMAC
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 2:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Enable the SGMII/SerDes PHY driver. This module is required to enable
> ethernet on sa8775p platforms.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Resending separately as driver updates have now been picked up into the
> maintainer tree.
>
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0777bcae9104..63f54d02c994 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1380,6 +1380,7 @@ CONFIG_PHY_QCOM_USB_HS=3Dm
>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=3Dm
>  CONFIG_PHY_QCOM_USB_HS_28NM=3Dm
>  CONFIG_PHY_QCOM_USB_SS=3Dm
> +CONFIG_PHY_QCOM_SGMII_ETH=3Dm
>  CONFIG_PHY_R8A779F0_ETHERNET_SERDES=3Dy
>  CONFIG_PHY_RCAR_GEN3_PCIE=3Dy
>  CONFIG_PHY_RCAR_GEN3_USB2=3Dy
> --
> 2.39.2
>

Gentle ping now that the merge window is over.

Bart
