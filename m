Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F736EB2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjDUT7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDUT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:59:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63D30FA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:59:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-74e3899037cso56776985a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682107154; x=1684699154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBre5fsrHS4I/dOXAuC6wKXt3u1wPU7nSBfX39Vpgro=;
        b=WyBMVazC7FFbr6gvmFYdXtlHQkZM7xc1K8EJ2AOElz55Sv+Piq5e8I3M+P2T5y4Ne0
         /3r9oqHZuvz9mc9SE+QHUKLTtHti824CVwP0muv5o3ZPsK2kV+s5Q11ioIlMcwSRkKaA
         A/Id9X2ekIcMiRUJFF3lLVs1m3Q/rThOzNM+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682107154; x=1684699154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBre5fsrHS4I/dOXAuC6wKXt3u1wPU7nSBfX39Vpgro=;
        b=S1M+tgVSjoew0oqn5f4r7eU0VBjfd2AtM7r37cWTn5zp+Tj+Y72zOZxm6JicPZ7afI
         i8X3Pgj/tR1pFDhrB/xHvu0yfuU826xNgyavGBrLLHikfaGY/XS4+fHHwgkE524WFK0A
         a/3u6QWFb1tnMh3ZiO4TegKx7gJclc4IQPuC7GlUOFSb7zF54ii7h5NLhcoE1YPsgo+x
         sKJ7omaagfZYJTCK1uq1B4drSe0fXZqbtpbpkOWFNhfuwr65Awhm7UvRN8yO/yzJh0h2
         AuuxOxYPXHFpWzPU5qGkhCE3SqYt4gcKJXEQL6q27kNxyAWarK5IJztbT6PgoU11r/JA
         9YzA==
X-Gm-Message-State: AAQBX9elgOebO/duDWJFSQjVDA6xATVRR7XzxnccRpk10dgDvRWQNykR
        YwFZ1AC1linqsoA9XDtQQpzTVjxWhzKlAddUnGI=
X-Google-Smtp-Source: AKy350avftCpsTrvsmn53B+y68SEuOjZiWSF8/iQkOx4/DxTl8ENhf2X+OQmQU44j2skWrC8qjlqSw==
X-Received: by 2002:ad4:5f87:0:b0:5f1:5f73:aed8 with SMTP id jp7-20020ad45f87000000b005f15f73aed8mr11230721qvb.20.1682107154520;
        Fri, 21 Apr 2023 12:59:14 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id d18-20020a0ce452000000b005eb3a61bc29sm1377730qvm.66.2023.04.21.12.59.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 12:59:11 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1229741cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:59:10 -0700 (PDT)
X-Received: by 2002:a05:622a:5ca:b0:3ef:330c:8f9e with SMTP id
 d10-20020a05622a05ca00b003ef330c8f9emr64749qtb.10.1682107150378; Fri, 21 Apr
 2023 12:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VU9Zdk2wz=90cjmuBWxaVz9w+UxzrTtW_ny-jrwVLV3w@mail.gmail.com>
 <7a6fe89b-5898-08d3-6c44-2cfc9d8fae7a@quicinc.com> <CAD=FV=U_7t4H9nXy6Ku49qLqbhZ02K-_XQv_Ssgkp26s3LyDMw@mail.gmail.com>
 <166aa490-f217-7dd8-0152-1d216deb2805@quicinc.com>
In-Reply-To: <166aa490-f217-7dd8-0152-1d216deb2805@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Apr 2023 12:58:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wt2VWSkSq2FzbtXBrkS06hwizkKMjkgwgKFqAHmcmyNQ@mail.gmail.com>
Message-ID: <CAD=FV=Wt2VWSkSq2FzbtXBrkS06hwizkKMjkgwgKFqAHmcmyNQ@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:21=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> >> If we were to have a linked list of descriptors that we can parse and
> >> free, it would require 2 more fields
> >>
> >> this_descriptor_dma - dma address of the current descriptor
> > Isn't that exactly the same value as "data_address"? Sure,
> > "data_address" is a u32 and the DMA address is 64-bits, but elsewhere
> > in the code you already rely on the fact that the upper bits of the
> > DMA address are 0 when you do:
>
>
> No; data_address is the dma_address mapped to the xfer buffer.
>
> This is provided by spi framework and retrieved from sgl.
>
> "this_descriptor" would be the dma_address of the current cmd_descriptor.
>
> this is returned from dma_pool_alloc()
>
> this would be required for freeing.

Oh! Of course, that's right. So you are correct, you'd need to add
"this_descriptor_dma", but not the virtual address since that would be
the same as the address of the structure via the list_node_t. I guess
I won't insist on using a linked list even though it seems more
elegant to me. In the very least it should fall back to PIO if the
array isn't enough and if we need to change it later we always can.

-Doug
