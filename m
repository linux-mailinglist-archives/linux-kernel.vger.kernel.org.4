Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30476E9A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDTRVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjDTRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:21:16 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5854EE8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:21:14 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54c12009c30so51003457b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011272; x=1684603272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78/qGEvYe/lkrFdeVXssBK2xk+jn/Iin4nBiAlABPII=;
        b=jCUBXFRMXGBa2UUZs1hfZHjy/knw5Bh75BdUqbmHZGYIC1ZMRrkBftU7nZ1ywPVyCX
         u+SAqlS4mKG2AKSOxtPNjQZ3INTrZqy6Hfuoux7iGPFFY/l2LQSprUGQXndl9nFRxS0t
         gQzllTY3qR2kAGHqS4Tx9F8e38pirUxNt2zGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011272; x=1684603272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78/qGEvYe/lkrFdeVXssBK2xk+jn/Iin4nBiAlABPII=;
        b=NRZ/bKurkkUH2/YTBy/oseNwYwWB6/BjixypJVTITD7qA1kV7Xwti50Xhghqkm0QHx
         gZm8uRu04nl2RJcW4Clj0QfphyTG6NVyLKPAn3kJAydU7fiF9d62BfsTTjyK8ghH1P+B
         B+BKr8SI39W0+KDMQ+EqyYvMe/4glt9zi1aUteLBse4mmoZXAaLkps87ZGQfAyQ9Dcuj
         fWSt3Q7beToxpqK7yvNd1Gfe2qIRj5DkVXXANnyGK2kzOdeD7cbYjb9loajgIYpFQ3nz
         m1Vy4wWehiPtpQ1hf5zSwcw6i04H7Y7F9JaDt0N9pdphHQ5nxT0uFiUWlyV4zMvDWvf8
         Ot4g==
X-Gm-Message-State: AAQBX9fRpVrkK9pvU3WsE5ZAX/hNDhAZNrO0KtWuqtfg9GA9oPGVHNCR
        A2aBV52GE3xKzwWpgcgnnzrVpvJg2uKYcHFFrO8=
X-Google-Smtp-Source: AKy350YQ28i7FLi30jgiVNnwae/8aoitV6PFtE0YVX/aACSdnCO+ewzWe/4/AcwBE/PeVDy6LxViWg==
X-Received: by 2002:a81:6c53:0:b0:54f:79a9:d3dc with SMTP id h80-20020a816c53000000b0054f79a9d3dcmr1371923ywc.26.1682011271899;
        Thu, 20 Apr 2023 10:21:11 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id e2-20020a0dc202000000b00545a08184b1sm441896ywd.65.2023.04.20.10.21.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:21:09 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id t15so2795894ybb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:21:08 -0700 (PDT)
X-Received: by 2002:a25:d895:0:b0:b98:6352:be20 with SMTP id
 p143-20020a25d895000000b00b986352be20mr684421ybg.0.1682011268498; Thu, 20 Apr
 2023 10:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-5-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-5-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 10:20:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULfbQh7JgGTNh67JjQCwcBZD3nZqWGw7-fP1W2WX0pfg@mail.gmail.com>
Message-ID: <CAD=FV=ULfbQh7JgGTNh67JjQCwcBZD3nZqWGw7-fP1W2WX0pfg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus
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
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
