Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F017B714721
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjE2JfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjE2JfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:35:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C290
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:35:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so3681485a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685352914; x=1687944914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPjbc8oU5yzXAKEPCAdahT5pQnCEf8m685+aLMXba84=;
        b=A82rI9MIxDa13hT+SLtAGSaLfdtSYak/oUgdEOL0lwbVUKf7bX431ySqkZdInWLJS5
         G4y+h19iDjKBYzmKoXD+Uw/6BM2Si3lDHOvxo1GtjKWNZdFTR4dJRWDzPVXDH0wKPGsn
         oGe4k8IzG5bfCf3YMiweHD8wrEy530Wv1wQejrNaTHylrWdXj5DENilFgziL+i1lArvT
         NXiMSOS7vKwS5U9hAKoiskMz/NH2TIHbBEfLRB4ktoufripjetX/IRo/0XuHNzSKNE03
         ogtE+CSrPMN0vljmMGKmbe+UpS5gAIo/Svtx0HYc+LPogBVFXt/KLWETYUn6AzJxRA6l
         rqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685352914; x=1687944914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPjbc8oU5yzXAKEPCAdahT5pQnCEf8m685+aLMXba84=;
        b=RicXo6f72Hi5kmGWrAUuU+IOpEIzUooCqgApsNncyXhjn55GdQ39Nvz1BBAJESCy/9
         rJ28JUjDx5ftY+Z/s/qC/BtH5ZQfIMU60d7Ry/zDCx3ULuJNg6rR7+A2y6ALISQ+23ps
         D1cUZwJHMauDPnmxdanLbnsD3ketDLH10qHEJMbpXpxrxlp38JpTqAji2XpruVyhHcp6
         +fKfhPbf68ab4Q1hVDw0L7fVrt4vBi6BVTtovg0ApJ4VWmLapRUyoxvDXzsV5eGjnscE
         N+fEblaGi96ctU5yHyQm/M/I6Km9ee1CcsUO/3X97uWv7Z24SrVsZwgGmyHUCN14MZap
         ChfA==
X-Gm-Message-State: AC+VfDyuS6TCfFPZUjMjol4OrdTox+CuMvhivErKe03BAhCSFUjNzeU2
        iFKI+z9Up/CsOOPCw8jnqWEJh5FGPeCvWkkxwug=
X-Google-Smtp-Source: ACHHUZ7RlFn1gSyhR2ik+0BFFdnxCxY2mJApBnAiOvfF1Ru5pgPjFo1LHA/EHoBaNHbBEraKu6HZxMvfdPg0VYIRd0g=
X-Received: by 2002:a17:907:2ce3:b0:973:edba:df30 with SMTP id
 hz3-20020a1709072ce300b00973edbadf30mr5360162ejc.61.1685352913760; Mon, 29
 May 2023 02:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
 <CAAhV-H5ack9r4WwuC3gixx0tbwW=4h84X5yrod-1DZouWr67BA@mail.gmail.com> <87leh7lgyg.ffs@tglx>
In-Reply-To: <87leh7lgyg.ffs@tglx>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 29 May 2023 17:35:01 +0800
Message-ID: <CAAhV-H7Z=cq+xzYiNc0YDf-PbNiEJYoSFyiL=12dtnC_tWPgBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of msi_domain_prepare_irqs()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Mon, May 29, 2023 at 3:44=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, May 28 2023 at 11:42, Huacai Chen wrote:
> > On Sat, May 27, 2023 at 10:03=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >> On Sat, May 27 2023 at 13:46, Huacai Chen wrote:
> >> > After:
> >> > =3D 0: Success;
> >> >> 0: The modified nvec;
> >> > < 0: Error code.
> >>
> >> This explains what the patch does, but provides zero justification for
> >> this nor any analysis why this is correct for the existing use cases.
> > I checked all msi_prepare() callbacks and none of them return positive
> > values now, so I think it is correct.
>
> Still you failed to tell so in the changelog. It's not helpful if you
> think it is correct. The point is that you have to make clear why it
> _IS_ correct.
OK, I think I should add more information in the next version, thanks.

Huacai
>
> Thanks,
>
>         tglx
