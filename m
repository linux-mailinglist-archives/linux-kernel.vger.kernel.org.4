Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044896C7FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCXOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjCXOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:14:14 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1164312F27
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:14:06 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5416b0ab0ecso35193807b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679667244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Eck/bb+D3Wo7CqwBsejFq9JyEtd/ZokuSoWl55rfhk=;
        b=J19GZxr6HfIlsNMymj0Dh0QebxGKp/9XJgwS8o+6YwGHsBWA6Prhd/2XIgnJ78agYT
         lzoi2yU/ywMCpJU4G1MuiCqna7+xKwHl67yAfjtg2uPpjsI3ekpa+J2qqppvD0LreX/K
         wnuEtx/asLZz4bvorfwisAvCX1JeAXZPyE1ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679667244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Eck/bb+D3Wo7CqwBsejFq9JyEtd/ZokuSoWl55rfhk=;
        b=Dc9EBLkFudJDWuhJicE8Z/A+7MT3eFvA1ps5QD+6GED+Bv6jpJ0K0iy8QUTqX3vxw+
         lWb1nfsQmyRC5NO+tWWelSmwjyk/tazu/KkHD1rOab/z83XSqd+zHrGKfb5aIKNScEgu
         MB1RVK/dZzxTsfaEh541pdns+cwJgGhLC7QhaRTOu/1X1qP+JptFC9OrOPkCTSKGfigq
         jSPEnOCTrO9R8onvxj8hvHDLtk96xsfiEevQnl0UIb/YFOVp4sQYcGSDunLIEBil+kQ2
         TyUi18HZZ5Yq5OzrIdEepIX+CrbU16wKsb80LWmkfS+IBuse0Oexa5U9TVUd8LZtO711
         G0uA==
X-Gm-Message-State: AAQBX9cV3Qay0wP6AKpHgs5i0ZNHcSZkj198yvFOp0VtjGzrXWQPnypg
        trSXeQF+fppXcM/PtPm9JjkuK76BQ3/MTBEptIU=
X-Google-Smtp-Source: AKy350b2wYRBE8bmnmdygzIQnL7eO2TOj0BBBQb7WTBbfZ6V5DyFr1MxDqSvux8w0WwDOTQ3tjhLYg==
X-Received: by 2002:a0d:e8d7:0:b0:52e:c9f7:e3c0 with SMTP id r206-20020a0de8d7000000b0052ec9f7e3c0mr2617517ywe.42.1679667244508;
        Fri, 24 Mar 2023 07:14:04 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 137-20020a81128f000000b00545a081848bsm423811yws.27.2023.03.24.07.14.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:14:03 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536af432ee5so36080997b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:14:03 -0700 (PDT)
X-Received: by 2002:a81:b620:0:b0:541:8ce6:b9ad with SMTP id
 u32-20020a81b620000000b005418ce6b9admr1146200ywh.2.1679667243445; Fri, 24 Mar
 2023 07:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce@eucas1p1.samsung.com>
 <20230323220518.3247530-1-m.szyprowski@samsung.com> <CAD=FV=WfREMuL6Z-aseAWPKXqpkutPofrWGy4ySH-WgbTHC-fg@mail.gmail.com>
 <a45c4b18-0fbe-1e75-9b47-6c26217c97e3@samsung.com> <20230324141200.he2rpj4x6tdtre27@halaney-x13s>
In-Reply-To: <20230324141200.he2rpj4x6tdtre27@halaney-x13s>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Mar 2023 07:13:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WW01k0XQHT=L_Fvg-bT=k83bw=AqKMmQjxgTPFtoA-Wg@mail.gmail.com>
Message-ID: <CAD=FV=WW01k0XQHT=L_Fvg-bT=k83bw=AqKMmQjxgTPFtoA-Wg@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 24, 2023 at 7:12=E2=80=AFAM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Fri, Mar 24, 2023 at 12:18:53PM +0100, Marek Szyprowski wrote:
> > Hi,
> >
> > On 23.03.2023 23:08, Doug Anderson wrote:
> > > On Thu, Mar 23, 2023 at 3:05=E2=80=AFPM Marek Szyprowski
> > > <m.szyprowski@samsung.com> wrote:
> > >> Restore synchronous probing for 'qcom,pm8150-rpmh-regulators' becaus=
e
> > >> otherwise the UFSHC device is not properly initialized on QRB5165-RB=
5
> > >> board.
> > >>
> > >> Fixes: ed6962cc3e05 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for d=
rivers between 4.14 and 4.19")
> > >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > >> ---
> > >>   drivers/regulator/qcom-rpmh-regulator.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > I don't object to this patch landing temporarily, but can you provide
> > > any more details, please? On Qualcomm Chromebooks I'm not seeing any
> > > issues with RPMH regulators probing asynchronously, so I can only
> > > assume that there's a bug in the UFSHC driver that's being tickled.
> >
> > You are right. I've analyzed this case further and it turned out that i=
t
> > was my fault. In short - 'rootwait' kernel cmdline parameter was missin=
g
> > and root was specified as '/dev/sda7'.
> >
> > UFSHC driver properly retried probing after it cannot get its
> > regulators, but it happened at the same time when kernel tried to mount
> > rootfs. I was confused that this is really a regulator issue, because
> > the mentioned /dev/sda* devices were properly reported as available in
> > the system in the root mounting failure message, but adding the
> > 'rootwait' cmdline parameter fixed this problem. It would be safe to
> > revert this change. I'm really sorry for the false report and the noise=
.
> >
>
> It looks like this got applied, but reading your above message makes it
> seem like this patch is not necessary. Did I understand that correctly?
>
> If so we should see if Mark can drop / revert it?

Ah, sorry. I didn't reply with breadcrumbs. The revert is at:

https://lore.kernel.org/r/20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c88=
4ad220a35@changeid

-Doug
