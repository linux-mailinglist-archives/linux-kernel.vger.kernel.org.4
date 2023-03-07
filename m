Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7D6ADA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCGJ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCGJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:27:13 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847EF53717
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:27:12 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id f23so11695890vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678181231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6O4zV+wYZ6GyzPQY6V2bUaFgM1LKFhXGuewMvfDT80=;
        b=H2Ti7FHW+XohgRdhghefx+zObvs6AR32eg8DMi/YKatcYQ4us8hC5AJ8FUxugv/9IM
         9Su2oTgQ4KnbRLrVBDXmeL1Jr9Z/4Y7bJlnOuSG50DBUt2ZdLBI4SvjiUcoKluFEdq5Q
         LX45ksfKK62r0uRdJkZ4DKyyJg/TDkVORPnkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6O4zV+wYZ6GyzPQY6V2bUaFgM1LKFhXGuewMvfDT80=;
        b=0F/uhSf5OuIAAKzvuNgvjBDYva3lJLwMU7UZh94XS0zhJPMCNvXkyBAQL04ITCo+Kg
         juE3iN55v+hNibEyDxdk9uUpmqYt6WML/VYcks3LwouCunMjvn8HpUtSeO/MpiEHEOtu
         eK3iyHdFeOeAxZrEp4vyT4P5hCYQ1YJJNLjHPM1HrJrvrZFxZ1PCIDqW7xbYvFSpag7d
         gUs3sTK5YB2exAK5xG9/VcKtiartAPv+stwkcNOWvi9DgnGUXoCBLsbq+UFW8n/a9ptj
         puHFZt78PkINaycPZLOAsqo5CWAb/zlGedjQosPflSewp1kbw4JPytOKOuNMpYYDo5NS
         04CQ==
X-Gm-Message-State: AO0yUKXhhT9rsjjayWJDdym8AnsMnGxa/UtmgWO6tthQmH6p4n7WCSAk
        JZPsaj7uqCriX1cVN7+Uil2EOGuK+9yVDOTNdppseQ==
X-Google-Smtp-Source: AK7set/ZOW9YeJyWIGClae8/5JYGzkBBuuPzV7Pj8Xj2wGsnc5D4R6oFPYvzHcnhhOA+BAFliMjNDeI+1/R1tjtEifs=
X-Received: by 2002:a67:db97:0:b0:412:2ed6:d79b with SMTP id
 f23-20020a67db97000000b004122ed6d79bmr9219504vsk.3.1678181231626; Tue, 07 Mar
 2023 01:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <b4fc6bd8-e300-0f40-4216-8b99589c21cc@gmail.com> <895abaa2-5fd3-9928-4e53-86ce160fbad8@collabora.com>
 <CAGXv+5EPVhH-O+ZdoLeW4OZVcEtS824oracmu3jHTa8k-tEU0A@mail.gmail.com> <e5302c3e-f985-b020-5f8c-fba876768eaf@gmail.com>
In-Reply-To: <e5302c3e-f985-b020-5f8c-fba876768eaf@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:27:00 +0800
Message-ID: <CAGXv+5FR5unBbdp0MDZY1TtSMoTtxzi2F4tO=3qZsh=3b3Ru9w@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 7:28=E2=80=AFPM Matthias Brugger <matthias.bgg@gmail=
.com> wrote:
> On 02/03/2023 11:11, Chen-Yu Tsai wrote:
> > On Thu, Mar 2, 2023 at 6:10=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 02/03/23 10:36, Matthias Brugger ha scritto:
> >>> Series looks good but from my understanding has a dependency on:
> >>> [PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support
> >>> (https://lore.kernel.org/linux-mediatek/20230228102610.707605-1-angel=
ogioacchino.delregno@collabora.com/)
> >>>
> >>> Did I get that right?
> >>>
> >>
> >> Yes you got it right - without the mentioned series, this one will do =
nothing
> >> at all (and will also fail binding checks, as the bindings are introdu=
ced in
> >> that other series).
> >
> > Please also let me test them on MT8183 and MT8186 before merging them.
> >
>
> Of course, I'll wait for your tested-by tags then.
> Thanks for testing!

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183, MT8186, MT8192 and MT8195 Chromebooks.

BTW, Angelo, I see that Panfrost keeps the GPU regulator enabled, but
the power domains, and thus the SRAM regulator, get powered off when
the GPU is not in use. There doesn't seem to be any damaging effects,
but I worry about idle power consumption.

ChenYu
