Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872B67464E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGCVdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjGCVdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:33:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BA1A7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:33:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314319c0d3eso2419965f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1688419985; x=1691011985;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TASmMtwbIxli+7tWQRTe5fwYmq+zTlIZOGDtWB8DCS0=;
        b=l1wXjViWZSqHEh9r5oKxB8DvxzfYszlgbDyL13NyKKF90rVqdiYyFreFicbzkDYKGW
         XhtvIUToeUwUaaEeLHC/KqKUeJLGPIL6yDER4bgrR+D1lpZf0RQPozyyP1MDsBRWMFud
         h9cEkO2gnI90QEOenTMHOjFIOcFO2gqIcvLNJt1u/BPkI6ad/0BioBVWsX2MIk973y2X
         8Gdm57L23aOj6o6Ki1X/9hE/oQC5vC8nCiUQbL0moBuNPGxvqxiz8MYPOiVmK+3y8n1M
         Qu6ueixORiydHkAlks+roRcKtFpUfE0ePcKGX5Wrk9u9flpU5eoroKrg7uuiJdGzSWR1
         YCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688419985; x=1691011985;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TASmMtwbIxli+7tWQRTe5fwYmq+zTlIZOGDtWB8DCS0=;
        b=G8/tHv4sl/Ljcr6ICFOt/Z79smpOhFJleU5wb4Q92QeGvC3eZMAeh1heNRm8l0cMNf
         SWPM2WPZiOGNHTnL+1i84cmxnJpN3X1EFEmBFP6I7+sjQKU1X6LK5xzu5MPPlsA6R4Uo
         Ounn3yo03RLUBQyzEwSKaPPST3NKp5sWpycDeHMYiQ/oWBpOYAkhX3eB+TMg4spCTlh+
         m3e3YkCA/91RHv6wjjassmycLLyL3IOmjOXMgJLBaed4aDzmGoUtJeFqognK1stPD6Vo
         81EKWmAeQ1O7Owuw9evr40UeXCde7Lp5wfFliJVY7sO6q3kfXSRSBtZglldMdiNZqWCg
         v/4w==
X-Gm-Message-State: ABy/qLatyP8Uu8bPwGZ1ytV6/7/Xcz4E6bM3tE4wAWLz1o7XCG144n4x
        vMdKEhogFyyCAnjgtJHd7pqeyg==
X-Google-Smtp-Source: APBJJlGQauzJhuAE1TkruIBNvoTDpKBOgqo8SJRBTE/8BSHJTNS8sEowarihoPnaeK4kc7cjkMZiyw==
X-Received: by 2002:adf:e747:0:b0:314:2f5b:2ce with SMTP id c7-20020adfe747000000b003142f5b02cemr5724980wrn.12.1688419985132;
        Mon, 03 Jul 2023 14:33:05 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb5506e54sm14610785wmj.29.2023.07.03.14.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2023 14:33:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [External] [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CANBLGcwcvK55dZ1__wvWCtcw=XoKt=qki8g6C_QYo+TBqqJ=TA@mail.gmail.com>
Date:   Mon, 3 Jul 2023 22:32:53 +0100
Cc:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <50F3BD62-78F1-456E-A44A-0C7D9A2D4113@jrtc27.com>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
 <CANBLGcwcvK55dZ1__wvWCtcw=XoKt=qki8g6C_QYo+TBqqJ=TA@mail.gmail.com>
To:     Emil Renner Berthing <emil.renner.berthing@gmail.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jul 2023, at 19:58, Emil Renner Berthing =
<emil.renner.berthing@gmail.com> wrote:
>=20
> On Mon, 3 Jul 2023 at 15:33, =E8=BF=90=E8=BE=89=E5=B4=94 =
<cuiyunhui@bytedance.com> wrote:
>>=20
>> Hi drew,
>>=20
>> On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones =
<ajones@ventanamicro.com> wrote:
>>>=20
>>>=20
>>> (This is a reply to a non-existent cover letter.)
>>=20
>> This has been discussed many times with Ard, Please refer to :
>> =
https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cu=
iyunhui@bytedance.com/
>=20
> Hi Yunhui,
>=20
> =46rom that discussion it was mentioned that that arm supports 3 =
methods
> of booting:
>  direct + devicetree
>  EFI + devicetree
>  EFI + ACPI
> ..but not
>  direct + ACPI
>=20
> To me it isn't obvious from that or this thread, and since arm seems
> to be doing fine without the 4th option I'm curious why that's
> necessary on riscv?

If anything we should be removing option 1, because that=E2=80=99s not a
cross-OS standard (though RISC-V=E2=80=99s SBI direct booting is at =
least not
tied to the OS). Any application-class platform spec is going to
mandate EFI, because, whatever your thoughts of EFI are, that is *the*
standard. And if you=E2=80=99re willing to pick up all the complexity of =
ACPI,
what=E2=80=99s a bit of EFI (especially if you only go for a minimal one =
a la
U-Boot)?

Jess

>>> I'm not a big fan of adding yet another interface. Have you =
considered
>>> doing something like [1]?
>>>=20
>>> [1] =
https://github.com/tianocore/tianocore.github.io/wiki/UefiPayloadPkg
>=20
> Also you didn't answer this question, which I'd also like to hear a =
reply to.
>=20
> /Emil
>=20
>>> Thanks,
>>> drew
>>=20
>> Thanks,
>> Yunhui
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

