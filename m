Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4625C746321
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjGCS6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjGCS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:58:28 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F99790;
        Mon,  3 Jul 2023 11:58:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c581c758ad8so944585276.1;
        Mon, 03 Jul 2023 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688410696; x=1691002696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdI/aR6tDnny9jl70GO2VaZWhjHcoPI5SvZ3goGqWe0=;
        b=QnHxICIrzDP76D9hf4nrvbTsxoz1OcQQIUlQgEs6FCOrdQio9sHxHfdcZHUuaqYKY5
         KencCpjDBUlgIDBiYvtW88dWsN9sOPduo0cUhLFWR3LyhyGsqkW2+f3GjFbDq9m12UAZ
         Isb+Gx4LWLtikSyJ8SjvovAFD1ZLBUWrHU4gJ7OqWCyOIQ5Gik34njEg7pAYGKqunfWq
         tdY4MFzXobsGG+SBfSmtqe5DFQTAfVo1SDSka0bTTF0/+4bjGMvr5AcpuMUuVWC8S5vf
         uwsfq2us2K3oAMj2Nq0/Qp9EHU9IG/taxq6tew4BcUMTiaLEMrObheFdiGxsxbLeHIsr
         51tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688410696; x=1691002696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdI/aR6tDnny9jl70GO2VaZWhjHcoPI5SvZ3goGqWe0=;
        b=Ts/n3CGnsi/mRNdjO6AjP6g0ghy0Tr/w1bQRafUGuXci4E0dgs4hWweIAUXR8MmwYA
         l6gMnTldfAHdDNv6sWm60jd9qtdHuh/mk6Xhryk0PjlwNYqq8SG8SqeJMveIfSyFwpU9
         bnb/zURAcw+Fj4DVtCKc6v3fWn3jQxYa9nVKqK6uFtSLgG9OezJg+ulRGCa5IOu613pj
         aTtp6LNbxo7NOrRfcjNyJnI+R/KUPUg8jaNfQHnF6Ky4m6UNV/CKlZWQ6UlKzM8KlJkz
         vGJA0K0bEDOCqYfC7Y8WutyeCorRT0/2WLj6rQIGvhym11ShBFaTueURSVOh8via6rJc
         Ha1Q==
X-Gm-Message-State: ABy/qLYA6M8QsfFg17fNaTfGwpOJpAFlA01i3vU05rm+WV+lLIqIlS/o
        ONnItgAykzdlWXVYu6nL4MkNfleZRcDvPAxxu0M=
X-Google-Smtp-Source: APBJJlGX+HQAUgcwh5aUbevyBV7Auco1dx/c0vI2lwouiMuJpkFdnAyw13cNFf+KlvG50Qc45KCcJyggHhnzFoKfJPU=
X-Received: by 2002:a25:320c:0:b0:c2b:cc71:d870 with SMTP id
 y12-20020a25320c000000b00c2bcc71d870mr9565258yby.57.1688410695987; Mon, 03
 Jul 2023 11:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
In-Reply-To: <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Mon, 3 Jul 2023 20:58:04 +0200
Message-ID: <CANBLGcwcvK55dZ1__wvWCtcw=XoKt=qki8g6C_QYo+TBqqJ=TA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
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

On Mon, 3 Jul 2023 at 15:33, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedan=
ce.com> wrote:
>
> Hi drew,
>
> On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
> >
> >
> > (This is a reply to a non-existent cover letter.)
>
> This has been discussed many times with Ard, Please refer to :
> https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-c=
uiyunhui@bytedance.com/

Hi Yunhui,

From that discussion it was mentioned that that arm supports 3 methods
of booting:
  direct + devicetree
  EFI + devicetree
  EFI + ACPI
..but not
  direct + ACPI

To me it isn't obvious from that or this thread, and since arm seems
to be doing fine without the 4th option I'm curious why that's
necessary on riscv?

> > I'm not a big fan of adding yet another interface. Have you considered
> > doing something like [1]?
> >
> > [1] https://github.com/tianocore/tianocore.github.io/wiki/UefiPayloadPk=
g

Also you didn't answer this question, which I'd also like to hear a reply t=
o.

/Emil

> > Thanks,
> > drew
>
> Thanks,
> Yunhui
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
