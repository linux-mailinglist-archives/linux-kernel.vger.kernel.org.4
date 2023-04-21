Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26D56EB09D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjDURfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDURfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:35:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F3D5251
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:35:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef2f81a96cso22175881cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682098518; x=1684690518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXK86wEYiVwAAffwU2RrQU5w4OvwpRlSMCsUx9Wsyw8=;
        b=dh3k5zlWzfu6th6WS5+nnxJv12bmwzJ8kcsy5CNsvsEzR1JVM6O6CyHsFBb+sFGGEb
         ieFhheJ7NCcb/qMtYTaAwQiRMA09D6tDISITrIQFyAxwL9TolUtieAOu8Cqi7yAoVj9J
         y1+SSii6oCjsVWCYFIp5IViRdYds0IZ1r65F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098518; x=1684690518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXK86wEYiVwAAffwU2RrQU5w4OvwpRlSMCsUx9Wsyw8=;
        b=WacPaqTi73/1TITpYJmx9gMj+8TJW9MurLotJ/lax/XwDVNG6j5vTQG/23rjeB5Nqb
         AZHHjLto0abQcO0HcDh895xBeMyn161HG2vpCaDoMN4I/+x+1P6niDtMiYHfhEl37PwS
         eZSAc8tUZcBr0/bS3oN2b1URNVKNriJaJpfFEwiKgFFo9yr7Wl+mtgrET+WoHSWS21Aw
         iK4Ttp3gBg3oyitDgHY0Otl9MTnbPPJB162KWnq6zR8QoRs4xNC1+hDO4YmLEgGuMfBJ
         bmYlhNxqMvhcYugHCbxc2Gwrq8wROoioNvkuxu57mvgyCT0DC+srCYgH52UnPwnx6JBf
         EX5Q==
X-Gm-Message-State: AAQBX9fF+GlihI1QK1LAfEYSy7Nr63M2kK5mQo5Rg77Fqpi8NdZldWB+
        yH6PMPOW04oO1oz2a1pxxjDh14qp+AVABqU6al0=
X-Google-Smtp-Source: AKy350ZuDm129FR3JuklKK8wYKwha2xyU+G+MIYu2nty/HXwhgF4dBJnEMfdN+XUE/5AUgtC+XVzVA==
X-Received: by 2002:ac8:7fc2:0:b0:3ef:5993:42e0 with SMTP id b2-20020ac87fc2000000b003ef599342e0mr7168745qtk.10.1682098517980;
        Fri, 21 Apr 2023 10:35:17 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8774d000000b003eae8609f64sm1473779qtu.13.2023.04.21.10.35.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:35:17 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3ef31924c64so1192311cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:35:17 -0700 (PDT)
X-Received: by 2002:ac8:588f:0:b0:3ef:26ec:f27a with SMTP id
 t15-20020ac8588f000000b003ef26ecf27amr395030qta.13.1682098516847; Fri, 21 Apr
 2023 10:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VU9Zdk2wz=90cjmuBWxaVz9w+UxzrTtW_ny-jrwVLV3w@mail.gmail.com> <7a6fe89b-5898-08d3-6c44-2cfc9d8fae7a@quicinc.com>
In-Reply-To: <7a6fe89b-5898-08d3-6c44-2cfc9d8fae7a@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Apr 2023 10:35:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_7t4H9nXy6Ku49qLqbhZ02K-_XQv_Ssgkp26s3LyDMw@mail.gmail.com>
Message-ID: <CAD=FV=U_7t4H9nXy6Ku49qLqbhZ02K-_XQv_Ssgkp26s3LyDMw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 21, 2023 at 9:58=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
> Thanks a lot for the review and inputs...
>
>
> On 4/20/2023 10:49 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Apr 20, 2023 at 6:13=E2=80=AFAM Vijaya Krishna Nivarthi
> > <quic_vnivarth@quicinc.com> wrote:
> >> @@ -137,11 +155,29 @@ enum qspi_clocks {
> >>          QSPI_NUM_CLKS
> >>   };
> >>
> >> +enum qspi_xfer_mode {
> >> +       QSPI_FIFO,
> >> +       QSPI_DMA
> >> +};
> >> +
> >> +/*
> >> + * Number of entries in sgt returned from spi framework that-
> >> + * will be supported. Can be modified as required.
> >> + * In practice, given max_dma_len is 64KB, the number of
> >> + * entries is not expected to exceed 1.
> >> + */
> >> +#define QSPI_MAX_SG 5
> > I actually wonder if this would be more nicely done just using a
> > linked list, which naturally mirrors how SGs work anyway. You'd add
> > "struct list_head" to the end of "struct qspi_cmd_desc" and just store
> > a pointer to the head in "struct qcom_qspi".
> >
> > For freeing, you can always get back the "virtual" address because
> > it's just the address of each node. You can always get back the
> > physical address because it's stored in "data_address".
> >
> Please note that in "struct qspi_cmd_desc"
>
> data_address - dma_address of data buffer returned by spi framework
>
> next_descriptor - dma_address of the next descriptor in chain
>
>
> If we were to have a linked list of descriptors that we can parse and
> free, it would require 2 more fields
>
> this_descriptor_dma - dma address of the current descriptor

Isn't that exactly the same value as "data_address"? Sure,
"data_address" is a u32 and the DMA address is 64-bits, but elsewhere
in the code you already rely on the fact that the upper bits of the
DMA address are 0 when you do:

virt_cmd_desc->data_address =3D dma_ptr


> next_descriptor_virt - virtual address of the next descriptor in chain

Right, this would be the value of the next node in the linked list,
right? So basically by adding a list_node_t you can find it easily.


> >> +static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, dma_addr_t dm=
a_ptr,
> >> +                       uint32_t n_bytes)
> >> +{
> >> +       struct qspi_cmd_desc *virt_cmd_desc, *prev;
> >> +       dma_addr_t dma_cmd_desc;
> >> +
> >> +       /* allocate for dma cmd descriptor */
> >> +       virt_cmd_desc =3D (struct qspi_cmd_desc *)dma_pool_alloc(ctrl-=
>dma_cmd_pool,
> >> +               GFP_KERNEL, &dma_cmd_desc);
> > Remove unnecessary cast; "void *" assigns fine w/out a cast.
> >
> > Add "| GFP_ZERO" and then get rid of the need to clear the "reserved"
> > and "next_descriptor" stuff below.
> >
> I needed __GFP_ZERO to prevent a compile error, used same.

Ah, sorry. Sounds good.

-Doug
