Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEB706AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjEQOVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjEQOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:20:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D62696
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:20:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so738074a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684333254; x=1686925254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVbyxkleaOeqg6x7EeLWzwlHXoN22FqfQL6T24R3rHU=;
        b=JwKiMTj2ld2/EHyOOXs0nrGZ4xqAnVoejr6abI4OYcak3aBe18Rupk2empr2xwj/iX
         AALbx/I8CVbYaxj4tYN2mpdM/rBh6H6A7h5PDEjVzk8jmSMyJ8+PfLlklA138Zk/sTwT
         jK63e8sqiw2Q5QLp4dKPvtWL4Pa12DH8TSOgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333254; x=1686925254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVbyxkleaOeqg6x7EeLWzwlHXoN22FqfQL6T24R3rHU=;
        b=elJ6HGnIG7PpgM5eV84ZVUbdyy04MFMIilmbY9Hxn6igehO4sIvOlb0OpvDmiRJm8U
         jM/GD73mNizT5PBOkIqZEZk4XlDZNjuP1GbvcxHh4nbJqrCGKUP9JyCxJJ1b9WwA6d9a
         3lOkn7lkhoAkL8wNklea3f/gCKxeXMkRhyHZamjtcMzh8Jk/74ntlbArztKEA/Vxqryb
         bEVN8wsdQoQc/aJxQ8AsDJXD/FhDWk1YG6QWOpk0Piyw31/lVtYfgW9HmRcedI7aQQMa
         TwTxnTzn/Uc+edXYp+0tb1LHM4s1/f87xGcBnYRBYYRf0y5kpyu5AgHGUl0/GZGbLpn7
         zSrw==
X-Gm-Message-State: AC+VfDzw9M3gGDlwZXcDo6/Oo5qMnGj4vgVNbrwrd9BbqMKC5Z/OE+V8
        5zGWkWWOpZksnqvW+9JsGECELLqs2FvbSIpqB64=
X-Google-Smtp-Source: ACHHUZ5athSLBu8tPuPiqHS+GR8xnqGhy4N397vnDK2Ln9UhXZZirH2/XCK1F8Ebh3/GOfO5wGoT7g==
X-Received: by 2002:a17:90a:31c1:b0:24e:1f06:4d32 with SMTP id j1-20020a17090a31c100b0024e1f064d32mr42484685pjf.2.1684333254521;
        Wed, 17 May 2023 07:20:54 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001ac591b0500sm10901075plg.134.2023.05.17.07.20.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:20:53 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ae3f74c98bso141405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:20:53 -0700 (PDT)
X-Received: by 2002:a17:902:ea06:b0:1aa:ea22:8043 with SMTP id
 s6-20020a170902ea0600b001aaea228043mr299829plg.7.1684333252521; Wed, 17 May
 2023 07:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com> <1684325894-30252-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1684325894-30252-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 07:20:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wi9d0W5pRs9gGGDtjPPNfC5L0wL9YCpfDtFKyQyCONPg@mail.gmail.com>
Message-ID: <CAD=FV=Wi9d0W5pRs9gGGDtjPPNfC5L0wL9YCpfDtFKyQyCONPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside
 driver, use framework instead
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 17, 2023 at 5:18=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The spi geni driver in SE DMA mode, unlike GSI DMA, is not making use of
> DMA mapping functionality available in the framework.
> The driver does mapping internally which makes dma buffer fields availabl=
e
> in spi_transfer struct superfluous while requiring additional members in
> spi_geni_master struct.
>
> Conform to the design by having framework handle map/unmap and do only
> DMA transfer in the driver; this also simplifies code a bit.
>
> Fixes: e5f0dfa78ac7 ("spi: spi-geni-qcom: Add support for SE DMA mode")

I'm not 100% sure I'd tag it as a fix. It's certainly a cleanup that
was asked for when thuat patch was landed, but technically it doesn't
fix any known problems. In any case, I'll leave it to Mark to decide
if he's happy with the fixes tag and to remove it if he sees fit. IMO
no need to re-post the patch either way.


> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v1 -> v2:
> - pass dma address to new geni interfaces instead of pointer
> - set max_dma_len as per HPG
> - remove expendable local variables
> ---
>  drivers/spi/spi-geni-qcom.c | 103 +++++++++++++++++++++-----------------=
------
>  1 file changed, 50 insertions(+), 53 deletions(-)

Mark and Bjorn will have to coordinate how they want to land this,
since normally patch #1 would go through the Qualcomm tree and patch
#2 through the SPI tree. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
