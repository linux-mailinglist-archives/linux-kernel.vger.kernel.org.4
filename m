Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6274A462
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGFT0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGFT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:26:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A1F1BE9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:26:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e34ad47eeso1079003a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688671570; x=1691263570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwiJDSaQJG4lpB+RWHzg/aQo8bzBN6e2ZdzlXuST6zU=;
        b=I46+KFW7OEboHnlAREa6XAM6C6bxDJFGnR4lUtJu6MoMpPhcMUaYLNeVdNfKlSqHnX
         0aKT8S3D0y7ysuZQeuoQSAA6Yxvo2AG7gWr1baGFzhNY5/tACO2vjFe8nw6vA2juV7lR
         MBx0kabtFf7WuM41nFQE+ZQhTTQXwylRoQ/24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688671570; x=1691263570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwiJDSaQJG4lpB+RWHzg/aQo8bzBN6e2ZdzlXuST6zU=;
        b=Q3HggYM+KkWVsz0XmhQrP/r8FHqZx4SkohbvlQH1EfP+5QKXvStwM9RCIbjkqSzfvd
         pkB+5hy7987C2zArkfWdn146jma2MJWxKC2q164CfVTUgkguCSlGHeRjVe9u80ekoctr
         Py1MgoeOAo0F+U93hLHAVRicXHD3bFY1x/j3GG2GZj15NWeLQwjltfYzLlDWV/NqpVfX
         lbjCT+bsSRUJ2Mi1cF0TWU8CMEtAKLNkrXffXfpjqSE8HdjfoJDWe2fZz/swIppSSVHi
         E8FXr+nXuDxtiVy8/Le1dNkbwMMc9exVXTGwSfq3eD4+idTaOxtJ65rvaRW/etsmWdGe
         pPMA==
X-Gm-Message-State: ABy/qLZxbzv9SM6TuvZDYJcTRKFRZOlBXNwvwrgAKWmvg4kBMtPE8kVV
        j2bi0YilWhVBzr2rJrSePYm1lHCwxgOJRz01DvASPvny
X-Google-Smtp-Source: APBJJlHOTEpNnjLRFoWWT4XOHHFvYaX+7HTewbTn4vABbnTslaPnd1QFe8Z+TVaiN+BbnqypjKvBAw==
X-Received: by 2002:a05:6402:10c8:b0:51d:f3a6:5eef with SMTP id p8-20020a05640210c800b0051df3a65eefmr2329871edu.36.1688671569972;
        Thu, 06 Jul 2023 12:26:09 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id d24-20020a05640208d800b0051de1a0af8fsm1102715edz.35.2023.07.06.12.26.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 12:26:09 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so2114a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:26:09 -0700 (PDT)
X-Received: by 2002:a50:d0d2:0:b0:51a:1d77:e69d with SMTP id
 g18-20020a50d0d2000000b0051a1d77e69dmr11060edf.3.1688671569035; Thu, 06 Jul
 2023 12:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com>
 <CAD=FV=UcFn7Wq_Ock6RCT0mPhgjpJwF7dJjcbwcoESW9nni62Q@mail.gmail.com> <CACRpkdb_6n+CKUHYu5nAtCEKK_VwO2hGUUCHny56oSYt_vTfLw@mail.gmail.com>
In-Reply-To: <CACRpkdb_6n+CKUHYu5nAtCEKK_VwO2hGUUCHny56oSYt_vTfLw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jul 2023 12:25:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WwRiAzfV0Unk8ipnWJkTiDYraJHAwH+Oq5Q0=4TJ6ESA@mail.gmail.com>
Message-ID: <CAD=FV=WwRiAzfV0Unk8ipnWJkTiDYraJHAwH+Oq5Q0=4TJ6ESA@mail.gmail.com>
Subject: Re: [v2] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        sam@ravnborg.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hsinyi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 4, 2023 at 12:39=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Fri, Jun 30, 2023 at 2:42=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
>
> > ...this means that it lands in drm-misc-next-fixes, so I've pushed it t=
here.
> >
> > 59bba51ec2a5 drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
>
> I guess that means we need to merge drm-misc-next-fixes back to the
> drm-misc-next branch so that I can rebase my series breaking out the
> ili9882t driver to its own file?

It looks like this fix is on its way to the main DRM tree:

https://lore.kernel.org/r/20230706112203.GA30555@linux-uq9g

Presumably if we wait a few days things will sort themselves out. If
something needs to happen sooner then we'll have to get the drm-misc
maintainers involved. Probably at this point it makes sense to wait?

-Doug
