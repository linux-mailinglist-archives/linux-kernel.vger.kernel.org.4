Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422686FB046
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjEHMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjEHMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:39:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C073A2A6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:39:08 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so24722760276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683549548; x=1686141548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uROyBrg4Rj4m8VfCLH63bHghL03rmG36CD/tTQoIjDc=;
        b=TpEzbfix6RIrR/JlLG63lTb15z44oEkRjGofFW29A0MN7BOInaRnSkqHTvYVhkKQgb
         3TWhd0n+6n1bF2K6Z6DD8ohTKKfVNNm31T9EAKdcuN2lwLBuciqdjlXcxMwIQY4LSsk+
         wbitVqddA81Ndh1TbwZFpfntDp4mSuJaJrCfX8lr3b5TRc02JpN3wusASiQ20/kEC/gz
         f7AWqfnKUv472FVV4Ut3FlWjDNy/g8XSEefAra4Ju5G7DoX0RiICWefNpfJxKeu8umE+
         Y66B2DiKKT26LRJFh3AeeeNf2QUVcc8d/DXOcHH129HXPfpTlZ8LPxkgxmtr0oXpw3ve
         yBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683549548; x=1686141548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uROyBrg4Rj4m8VfCLH63bHghL03rmG36CD/tTQoIjDc=;
        b=Rl2DEQHyisCGBE6LfrLbcbFwlf4CTiyb4QSFcEzBaZvVsSrGG3Qdu32Q4wthwIlz77
         ss+G3/Uff8ciPwHVEYEKB6FW3LPXGOL4gGTYMaHj1CviOIZQ5TQplLAgryiWDcoi6sD5
         fD1l/itLcqaCRZWBkqJr+ktoH0CtSvYvQ9vttjQQYpNjllCzr3s/zgyyiy/iQcvgxTOH
         ICd5NMZwKUzp9hc1jVk31F22xxoGOamjNvLVSDA9fvUEfLpS6hnrYQV93z2ON0tBkaf6
         vKBt1Yu+EJ/ngNgSrS5y52hBtoEOPcpErN+DDDA/JnKof+Mcavs5cvbFeMyOahM6igPx
         gyXA==
X-Gm-Message-State: AC+VfDwVMC6VWNN0TPQzF3H6IxZNRRL67tROGCMDLWGueaKmKQc7mOWn
        ZgLetfu5o7kzKsvczibyd12t1eZS4sxl5Ae6jmjV4A==
X-Google-Smtp-Source: ACHHUZ5jBvl+0pVUDygH87dIQI5+wsNCOfP5FbE3+s/fQidEE1nNvoYXgM3WWx2UgSOufKK3tCw/bOlQcyUE+7oE8b8=
X-Received: by 2002:a25:4ac9:0:b0:ba1:6bad:9270 with SMTP id
 x192-20020a254ac9000000b00ba16bad9270mr12863241yba.27.1683549548166; Mon, 08
 May 2023 05:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230508043641.23807-1-yejunyan@hust.edu.cn> <430d0357-d10e-db3d-bc82-722b022b519b@wanadoo.fr>
In-Reply-To: <430d0357-d10e-db3d-bc82-722b022b519b@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 14:38:57 +0200
Message-ID: <CACRpkdbPzGumK=wAvOr99TQZB4hTjxvymPCvj_3qU1XSPKkpOA@mail.gmail.com>
Subject: Re: [PATCH v3] pci: controller: pci-ftpci100: Release the clock resources
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Junyan Ye <yejunyan@hust.edu.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 8:59=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> completely unrelated to your patch, but this comments state "optional".
> The code below seems to make both clocks mandatory.
>
> Moreover, a few lines later, we have:
>      if (!IS_ERR(p->bus_clk)) {
> which seems to say that bus_clk is optional.
>
> This was introduced by 2eeb02b28579.
>
> Just a guess, but either the comment should be updated, or the code
> modified.

It's fine to make the clocks mandatory, because all Gemini
systems provide these clocks.

But that is good to mention in the commit message as well.

Yours,
Linus Walleij
