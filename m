Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C156FC8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjEIO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjEIO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:26:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0643AB1
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:26:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-757756e2eefso137300685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683642373; x=1686234373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap1sxPFyCXYHlrPI9PqKEsUisI28MkyI1OG4pKfon1Y=;
        b=ZhrNogG7vc5h+0aTkiemp5tq4yOwBvHRRxAxFillFlD1qWK8b+B+2jXwwfGlzF14p4
         IBzjcbBeObUJAL2iRpm0I110rtYtMRsuqmcNQIqGwAbmhU24uBapB79EctlPFIkPGki2
         1xKxQTNSIKjUtFoJc+QpeqfHCEET57MxxZv4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683642373; x=1686234373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap1sxPFyCXYHlrPI9PqKEsUisI28MkyI1OG4pKfon1Y=;
        b=N/3RtKHJqmWpTiir7dCIUhduAAgonlv6aE1cYMS9oDcFj4bFDF8TeotWO7E1E17jhM
         d6saIeCYLfp80xvjqmO8LIt0otTVVpxKc4fBdl7EEdtd0fJBfQ+hh91tZjGQv+o+Ckpe
         PWQL8dyCznTPRhjqyLq5NFFFhTa58LTOWkoxyrBWAqPaGQoYN1aKNpvy+pjI5ipGFpv+
         wI3YJX05/jb8YIzWgouE2cdVRaQv/LlRs4GTYRZB/1+TxDjbQlQfOL7STRSPyud0KAdc
         ooRPFMZOllqy3poTxu/RmJ7iLboZdNkHm8qWBOVT5ua9myOZKJcTsTfHeuhPUtLHK+J+
         q8vA==
X-Gm-Message-State: AC+VfDy2dX21aa0wFWnkSmXs/DCVeUNwdWwLaMPXSYnvpDwCexTkvlVI
        aSzTYYUC0kmez3uRP/zp26XcT9Ui4V7nBsqgjjU=
X-Google-Smtp-Source: ACHHUZ5Lw9wl9hg7pwI3pw0YLsmD39XJYkBiedSw8XR3OIQNy9+1BRJ3ToI0Om+JT41+AObPj/z60A==
X-Received: by 2002:a05:6214:c83:b0:5ef:a5b5:5b99 with SMTP id r3-20020a0562140c8300b005efa5b55b99mr18889599qvr.0.1683642373148;
        Tue, 09 May 2023 07:26:13 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id g1-20020a37e201000000b0074e2da97de4sm3295320qki.33.2023.05.09.07.26.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 07:26:12 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3f38824a025so199191cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 07:26:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1890:b0:3ef:330c:8f9e with SMTP id
 v16-20020a05622a189000b003ef330c8f9emr396501qtc.10.1683642371893; Tue, 09 May
 2023 07:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 May 2023 07:25:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UNvsSP=ELt557e5MQ_vfeFgSYahNcR8Pykw+Kxxnd97g@mail.gmail.com>
Message-ID: <CAD=FV=UNvsSP=ELt557e5MQ_vfeFgSYahNcR8Pykw+Kxxnd97g@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Select FIFO mode for chip select
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 9, 2023 at 3:01=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Spi geni driver switches between FIFO and DMA modes based on xfer length.
> FIFO mode relies on M_CMD_DONE_EN interrupt for completion while DMA mode
> relies on XX_DMA_DONE.
> During dynamic switching, if FIFO mode is chosen, FIFO related interrupts
> are enabled and DMA related interrupts are disabled. And viceversa.
> Chip select shares M_CMD_DONE_EN interrupt with FIFO to check completion.
> Now, if a chip select operation is preceded by a DMA xfer, M_CMD_DONE_EN
> interrupt would have been disabled and hence it will never receive one
> resulting in timeout.
>
> For chip select, in addition to setting the xfer mode to FIFO,
> select_mode() to FIFO so that required interrupts are enabled.
>
> Fixes: e5f0dfa78ac7 ("spi: spi-geni-qcom: Add support for SE DMA mode")
> Suggested-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
