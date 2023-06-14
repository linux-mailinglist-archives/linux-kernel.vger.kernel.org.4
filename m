Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E173008F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbjFNNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbjFNNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:49:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B81FF7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:49:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5185f195f05so4153662a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686750591; x=1689342591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FILJiyQHr5q7+MBxGqKh2YR7IQjtgWRJYztSUT5XOE4=;
        b=JKND40dTetSmvfX4bWRAib77G5F/txnMDmpCKOXxTxP7jVFpmBaS9mTJ9xpmzeBaZ2
         nfAolQOAgP79n4Q+9gDVn+CWht0W0foOB4Cfm2aTNJJiP2JEKCuMQ/FWs8oXXov+IzVu
         r5YJZoCVYRKY/CqOP9SNv+0H5NhN+f3P099HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750591; x=1689342591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FILJiyQHr5q7+MBxGqKh2YR7IQjtgWRJYztSUT5XOE4=;
        b=O/2BjJvgKsaIq0PUjqav0e8/8pQGZgVEYUszuYJihqIkc1g+osQrbwYyuh3gZsyFjq
         AuOhguoEmf82RUh3xruE3cWPTeoDIx5+/vlB8cvNtURzqnpmuguNiT1Eb7eeK8CZeH+i
         7DGkCVx5vNKJTwaK9tgJ2rjr4l34BEdwC5fVZmBt26d2YXwQbOFUYPrfr08Ub+Kt7oDq
         uz/8EF5jS0XG1iwLNkZN/wONgE9EPye90Mb3vM3oYdQQQ2RxNfpo5g6Y4pmFa1/4R5xR
         tBJX4nHx6djOrx+WViuoIZ6st0oRpH3tjR3mBY0PxCbu2YCgWWoIXYEuxb5xjLf0jA9w
         Wctw==
X-Gm-Message-State: AC+VfDwycXv6wdnp6ZX44a5qntWNHDSs0VGj12J8L/bPkaAkqh22aRnH
        7MyCxnYb0QbrAvu/26ZXcKshHCEv/IdvguwBJl5yxfSg
X-Google-Smtp-Source: ACHHUZ6fgW0UZgfSVfMToYo3twSczZte5stw72iRjT5cAYkjRZ21nNTLOHle5JBPt12JVQp3WLYWyA==
X-Received: by 2002:a50:fe98:0:b0:514:9b60:ea65 with SMTP id d24-20020a50fe98000000b005149b60ea65mr5199533edt.16.1686750591172;
        Wed, 14 Jun 2023 06:49:51 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7c988000000b005167bb5fc3csm7744500edt.38.2023.06.14.06.49.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:49:50 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso11389a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:49:50 -0700 (PDT)
X-Received: by 2002:a50:f61e:0:b0:514:92e4:ab9f with SMTP id
 c30-20020a50f61e000000b0051492e4ab9fmr85010edn.7.1686750590163; Wed, 14 Jun
 2023 06:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <1686742087-30731-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1686742087-30731-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Jun 2023 06:49:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URVjgZtZ1Dyc521KTdAN1GJ700vAAJgUtvSA5UkhnTig@mail.gmail.com>
Message-ID: <CAD=FV=URVjgZtZ1Dyc521KTdAN1GJ700vAAJgUtvSA5UkhnTig@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: geni-se: Do not bother about enable/disable
 of interrupts in secondary sequencer
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2023 at 4:28=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The select_fifo/dma_mode() functions in geni driver enable/disable
> interrupts (secondary included) conditionally for non-uart modes, while
> uart is supposed to manage this internally.
> However, only uart uses secondary IRQs while spi, i2c do not care about
> these at all making their enablement (or disablement) totally unnecessary
> for these protos.
> Similarly, select_gpi_mode() also does disable s_irq and its useless agai=
n.
>
> Drop enabling/disabling secondary IRQs.
> This doesn't solve any observed problem but only gets rid of code pieces
> that are not required.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v1 -> v2:
> - apply similar changes to select_gpi_mode()
> - modified commit message accordingly
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
