Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0F74D9E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjGJPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGJPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:30:33 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759AF4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:30:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-440b9d60606so1730619137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689003031; x=1691595031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvU5h65WN0FBFb0gMGeN1WEYPfLF1+fchHSNH5xDF6U=;
        b=IUkwlL1GhwmYUT5e8LLJ8KQT2IR2NVgIYlVvP01xDkXb0w4GOPCdmcvT5cvWfjg87N
         UwR+alGTpqEoomBFMODYkp6gXvFPk0R+W/AHR6MYQaiWUECuu3A6r3Z6NHpmPprSumSZ
         sjdAciYkznKjhnKkEyNmCoPoeJibTsIrqyMV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689003031; x=1691595031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvU5h65WN0FBFb0gMGeN1WEYPfLF1+fchHSNH5xDF6U=;
        b=KhWU5Tnt3fENvHHFLKnYAJzE1RM/PlWqtyM1rEJnuQRY+Q0lZhjQ20wS8gkJyCM4w+
         zMm0yPZv+2pS+Zp3hFwIsBY/s3sAw92QxVA19Oa7ej+289wAvREZo0srzuI6tTCw8WjG
         V3mxPvjI+fR2BogjfVbCj9ME/ZDpSOR/EpBAmq3iUW6VlV45q8mvSxE3VWuxt9CUcqcV
         6p65aWiwpYb/F16lgO+11JamcFqzYO+JpRkA1n9g9rdWjiVGA77AJGgSPeaaTHGfar5Z
         HZtej0KQ/PanjVosejX5Xa3J5uNnZpRU8LfK8QuAEsRDUPrhwoq88wCdCaPhiJleYQg1
         tgLA==
X-Gm-Message-State: ABy/qLbXxUfwnOjjW0pDESX0ViDlzQMGLi7h7RKboLSZCCLbvgvamkmT
        9i0gqhlWF+Ug3o9Y43iUnMD949ddTRxluLg2hHc=
X-Google-Smtp-Source: APBJJlGoUP42anWhoV6O0DV0t0L+xyyuvNa5nqFolfUmtnbZ55dn7hcsaFTlmohHD3KO3oFSaW3+aA==
X-Received: by 2002:a67:ec05:0:b0:443:9873:6546 with SMTP id d5-20020a67ec05000000b0044398736546mr6084665vso.34.1689003030912;
        Mon, 10 Jul 2023 08:30:30 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id w1-20020a9f38c1000000b00789a6c15851sm1193159uaf.13.2023.07.10.08.30.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:30:30 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-440b9d60606so1730598137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:30:30 -0700 (PDT)
X-Received: by 2002:a05:6102:24b:b0:443:67bd:d2f5 with SMTP id
 a11-20020a056102024b00b0044367bdd2f5mr6345190vsq.24.1689003029889; Mon, 10
 Jul 2023 08:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org> <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
In-Reply-To: <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 10 Jul 2023 09:30:19 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
Message-ID: <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, kramasub@chromium.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 9, 2023 at 8:43=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 7/9/23 18:15, Mario Limonciello wrote:
> > On 7/9/23 18:46, Randy Dunlap wrote:
> >>
> >>
> >> On 7/7/23 18:17, Raul E Rangel wrote:
> >>> Right now we are proxying the `console=3DXXX` command line args to th=
e
> >>> param_setup_earlycon. This is done because the following are
> >>> equivalent:
> >>>
> >>>      console=3Duart[8250],mmio,<addr>[,options]
> >>>      earlycon=3Duart[8250],mmio,<addr>[,options]
> >>>
> >>> In addition, when `earlycon=3D` or just `earlycon` is specified on th=
e
> >>> command line, we look at the SPCR table or the DT to extract the devi=
ce
> >>> options.
> >>>
> >>> When `console=3D` is specified on the command line, it's intention is=
 to
> >>> disable the console. Right now since we are proxying the `console=3D`
> >>
> >> How do you figure this (its intention is to disable the console)?
> >

https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html
says the following:
console=3D
    { null | "" }
            Use to disable console output, i.e., to have kernel
            console messages discarded.
            This must be the only console=3D parameter used on the
            kernel command line.

        earlycon=3D       [KNL] Output early console device and options.

            When used with no options, the early console is
            determined by stdout-path property in device tree's
            chosen node or the ACPI SPCR table if supported by
            the platform.

The reason this bug showed up is that ChromeOS has set `console=3D` for a
very long time:
https://chromium.googlesource.com/chromiumos/platform/crosutils/+/main/buil=
d_kernel_image.sh#282
I'm not sure on the exact history, but AFAIK, we don't have the ttyX device=
s.

Coreboot recently added support for the ACPI SPCR table which in
combination with the
`console=3D` arg, we are now seeing earlycon enabled when it shouldn't be.

> > I read that as "it's intention is to disable the default console (tty0)=
".
>
> Yes, that "default" word should be there IMO.
>
> Does this patch affect behavior if someone uses
>         console=3Dtty0
> i.e., the default?
>

No, it shouldn't. This change makes it so that the
param_setup_earlycon function gets
skipped if there is no value.
See https://chromium.googlesource.com/chromiumos/third_party/kernel/+/v6.1/=
drivers/tty/serial/earlycon.c#223

> >
> > IE if I add console=3DttyS0,115200,n8 to my kernel command line then I =
don't get the output on tty0 anymore.  If I want it on both then I do
> >
> > console=3DttyS0,115200,n8 console=3Dtty0.
> >
> >>
> >>> flag to the earlycon handler, we enable the earlycon_acpi_spcr_enable
> >>> variable when an SPCR table is present. This means that we
> >>> inadvertently enable the earlycon.
> >>>
> >>> This change makes it so we only proxy the console=3D command if it's
> >>> value is not empty. This way we can correctly handle both cases.
> >>>
> >>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >>> ---
> >>>
> >>>   init/main.c | 3 +--
> >>>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/init/main.c b/init/main.c
> >>> index aa21add5f7c54..f72bf644910c1 100644
> >>> --- a/init/main.c
> >>> +++ b/init/main.c
> >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *param, cha=
r *val,
> >>>       for (p =3D __setup_start; p < __setup_end; p++) {
> >>>           if ((p->early && parameq(param, p->str)) ||
> >>>               (strcmp(param, "console") =3D=3D 0 &&
> >>> -             strcmp(p->str, "earlycon") =3D=3D 0)
> >>> -        ) {
> >>> +             strcmp(p->str, "earlycon") =3D=3D 0 && val && val[0])) =
{
> >>>               if (p->setup_func(val) !=3D 0)
> >>>                   pr_warn("Malformed early option '%s'\n", param);
> >>>           }
> >>
> >
>
> --
> ~Randy
