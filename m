Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F696E9A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDTRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDTRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:20:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99437212C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:33 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u13so2742590ybu.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011232; x=1684603232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npIvl3QgC8NcszelNQAZW8/zRVotzvOXnUNhHUMiAZ8=;
        b=f8O+MfJLUfYepI0LnCRS7X8wXy691ond/69L2ib3Ax2qoRhHFXW37TPGOYKawEnUFx
         wNbnF89ECWq88Is7J83gnYEEMyaVTzw912Mjv9hyoSbDRZxpEsKS1Mcq8y4IcknR90zo
         z8fg130SJquFVJHc6V309QKT7VO0TKC8oGD6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011232; x=1684603232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npIvl3QgC8NcszelNQAZW8/zRVotzvOXnUNhHUMiAZ8=;
        b=chCD8wjyA6n9T4k/lVqZvG9QJeonDLgfsD/OjhGNJk6o9ir4GKkNDOXa1OZGI7Sfol
         JYrZvrSip7CjeIAcqIgnWuR/VxAQoh/hmcMVlDnFN9jGlUW2JW57qZw8xrxS3wa6tiiL
         C+ym269dM4gZMx5OqUXWJKVIMHoKnK0nv1vvHeFliI1aCuePMqD/KlZ8wJXGuPLz97Hf
         +H7Eat/uxCkw+L9kkWRiAmZC6JvHwlpIbBdsJVkvjN9+WYPCsX5OXZB6Irw4JkuxQoTh
         zFGAJpSYxvS4GACDC8pHGhbuIAdlieP52SSPNj0vlsvgK3sNSfCnnmgGmQyUuGerjdYT
         t0og==
X-Gm-Message-State: AAQBX9eft2p7qdCcHbeVp2t4UC7ue2VAK5yMPuzYfZ+UZ+n1u0yMV5Tq
        vEJ3XLxdXyEOKLSv7+sWUHFtNPW3UutjIcU1utk=
X-Google-Smtp-Source: AKy350b3/C+emW8FXBimDfgQ9emfeuXy1naYoRnjKPXKVnc2wpPMBYX7nR65C5La4LPCsr2E7H8bRw==
X-Received: by 2002:a25:ac85:0:b0:b95:9e75:ff0d with SMTP id x5-20020a25ac85000000b00b959e75ff0dmr1854050ybi.36.1682011232239;
        Thu, 20 Apr 2023 10:20:32 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id p13-20020a056902014d00b00b8bcaf1e660sm129248ybh.4.2023.04.20.10.20.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:20:29 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id n193so2659974ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:28 -0700 (PDT)
X-Received: by 2002:a25:cacc:0:b0:b98:6352:be17 with SMTP id
 a195-20020a25cacc000000b00b986352be17mr882764ybg.0.1682011227804; Thu, 20 Apr
 2023 10:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 10:20:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyVRxRc7WuW1vhFXWDG81cAu7g5WiC9sggGoEuQOA4Cw@mail.gmail.com>
Message-ID: <CAD=FV=WyVRxRc7WuW1vhFXWDG81cAu7g5WiC9sggGoEuQOA4Cw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
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
> As part of DMA mode support to qspi driver.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
