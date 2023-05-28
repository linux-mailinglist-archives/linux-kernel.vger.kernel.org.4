Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C771379A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 05:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjE1DnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 23:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1DnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 23:43:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0974C9
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 20:43:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so395946066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685245390; x=1687837390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cnYoGY4zHkrNuxU703iVddknKXe9mPbtZC1gHaW/ek=;
        b=LEAg5dJwr5RYiK9QTk/4BadY9q+BU7BWFCHpceV7KkMZXNXnfmezmmYOdE6ov3AUt5
         IjBTpKTu2k2HVNetpdxp+cpyJaU52y+qJifqOHsDhpN/vOocJlQjUa2QOxRAYgGbyjMo
         9IsYohe8FZ3iYoSv5QHYn9GETnRXLGMV4luhESpqH/jrJauc+UPIzRdrPEuzvc7Mrhat
         0HyazwB/Nj2OtDqp0mu2ZBWIVahGPuI+AyjsWxQ07sb22hPm8kHQPRgVQeT5d6ZE6gzc
         z3Scs8OA0xat1k7NNWcsOgbd8G/w5ekL+oEthTh/H1HNwmkJzIizNnfT2vmWZuuO8MQ9
         WayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685245390; x=1687837390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cnYoGY4zHkrNuxU703iVddknKXe9mPbtZC1gHaW/ek=;
        b=CHErsaAZUe8ipPVW+QQKnbAtwKqjvfhufdWlxh6aykPsvAw0fuGS/7YQE80h46hBga
         mI3qyXhrOFF4C7TEjBelyVUe1RcaUMK1CqaBfgawClYMEnUVWLOW66zDR/F4uZH0wIke
         XwKpFT5gTWADKwyD9ldrZBF9V2bLpAb6kIezk/f8ajjqo6oS8l7YNavBMuEc9m9vGn0C
         S6wCXESRVEG9LViy3c9Bk83VtEjl9c6lY9ikynGiTKCkCmhsf2Qk0463ao7if21iqJTL
         diHv5FXn5aRRACAsME6haxytH4cyeS1oZmTKJ56yfsu4SFiArMRWeWMde/6Z0xka352R
         tM8g==
X-Gm-Message-State: AC+VfDwZuSXNvAJou1XkCcDLB9ADkpdgK+13l3y9OQokQPRQM24kj5Tk
        T4pmj0iSRSwv/HJCWonjFKWyo6y6dkC/+SkEXB8cXXTJpRvoQRTe
X-Google-Smtp-Source: ACHHUZ5egQo8nfpfBY2RA1ImAP4eZjA1U7yguEqMmrAs3iZn7vc7Wp1gFidcvwIzfACs8WKj+qlvsDhB50t++CaRc6I=
X-Received: by 2002:a17:907:2da1:b0:973:8198:bbf7 with SMTP id
 gt33-20020a1709072da100b009738198bbf7mr8252802ejc.11.1685245389658; Sat, 27
 May 2023 20:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
In-Reply-To: <87pm6llvm6.ffs@tglx>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 28 May 2023 11:42:57 +0800
Message-ID: <CAAhV-H5ack9r4WwuC3gixx0tbwW=4h84X5yrod-1DZouWr67BA@mail.gmail.com>
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

On Sat, May 27, 2023 at 10:03=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Sat, May 27 2023 at 13:46, Huacai Chen wrote:
> > Adjust the return value semanteme of msi_domain_prepare_irqs(), which
> > allows us to modify the input nvec by overriding the msi_domain_ops::
> > msi_prepare(). This is necessary for the later patch.
> >
> > Before:
> > 0 on success, others on error.
> >
> > After:
> > =3D 0: Success;
> >> 0: The modified nvec;
> > < 0: Error code.
>
> This explains what the patch does, but provides zero justification for
> this nor any analysis why this is correct for the existing use cases.
I checked all msi_prepare() callbacks and none of them return positive
values now, so I think it is correct.

>
> That longsoon MSI domain is a PCI MSI domain. PCI/MSI has already a
> mechanism to return the actual possible number of vectors if the
> underlying space is exhausted.
>
> Why is that not sufficient for your problem at hand?
Hmm, maybe I should make things clearer. We want to do some proactive
throttling here. For example, if we have two NICs, we want both of
them to get 32 msi vectors, not one get 64 vectors, and  the other
fallback to use legacy irq.

Huacai
>
> Thanks,
>
>         tglx
