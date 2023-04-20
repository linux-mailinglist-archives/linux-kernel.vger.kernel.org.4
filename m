Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7C6E9A94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjDTRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDTRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:20:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199D212C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:55 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f6a796bd0so50511987b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011254; x=1684603254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASlcFMe+UBtl/yEkw/ihBI+w8rG6+336g8ZGmASVmQA=;
        b=oLYnKsa+zmdsdAjUhAZbqpTPLifO76Qds1i7eH1ypoY+sMN2ibpi5d2RAWiKfnRUle
         WDnyzqKhsDWWcprHmwz1Fge/OdTh17JU9VDskKSFqPpun2XBlqG3NsoEH1KPCgKrANr+
         By5RsWHE/BWE4aYH67xncnQj6KmKVbzHClrXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011254; x=1684603254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASlcFMe+UBtl/yEkw/ihBI+w8rG6+336g8ZGmASVmQA=;
        b=NRuNwOhQno/SDMdvIVA4odXmPH8vHiot+b9uZHlHFjDIuabBjzEYus+Gl0JJnHeVEx
         HysgaZEjxMOlmseREFuVKvokVNR8hFPeJql4vN75zUZDItNKrDhY0/ItAfCbJrK+BQmI
         vs093pcN6BhH8TzYzUMcSWSXulpUWqfEpNRMo+uUV2fsAVGY3/IwwepuVViUttdkOxha
         ViEKzx201PZXq5aOxtPBi1R9boOb1zDabH8dq8XrCc/ZiphmQIIe3BBe4sFLTwJURr/F
         smkFfS8Dv15m9W8zsniPDhX/xwxbQt4eaqAiND2Xzz7kc7zyhu9rtL1xKXnr/p/qZMAL
         A1gA==
X-Gm-Message-State: AAQBX9eMszyxMB+5jkwtcH0QGo0oCPpVxLcncFTNgP9Wf/uh+VwKbjhi
        /1K9o8AMzcN0d/cKvp+hKV7hghFNqo5AmcYVX8c=
X-Google-Smtp-Source: AKy350b/C6nksJHuoTGKq7iNcnZvmay7GN9ABvjEeKNT1b/P433zBiYal3uLxPu/spq7mzgdpKDxMA==
X-Received: by 2002:a81:7207:0:b0:552:96d2:c70 with SMTP id n7-20020a817207000000b0055296d20c70mr1158039ywc.42.1682011254447;
        Thu, 20 Apr 2023 10:20:54 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u186-20020a8160c3000000b0054f69ac5220sm437098ywb.133.2023.04.20.10.20.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:20:51 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id n17so2787545ybq.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:20:51 -0700 (PDT)
X-Received: by 2002:a25:c807:0:b0:b95:2315:a2c4 with SMTP id
 y7-20020a25c807000000b00b952315a2c4mr1169128ybf.0.1682011250803; Thu, 20 Apr
 2023 10:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-4-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-4-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 10:20:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxbLsaxJc7YKH+beaPFTxq7x_jS_oQQ+KHXXQ=LgX3ag@mail.gmail.com>
Message-ID: <CAD=FV=XxbLsaxJc7YKH+beaPFTxq7x_jS_oQQ+KHXXQ=LgX3ag@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
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
> v2 -> v3:
> - modified commit message
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
