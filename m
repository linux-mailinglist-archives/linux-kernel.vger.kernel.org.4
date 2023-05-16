Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659B67052D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjEPPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjEPPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:51:34 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278FCD2C5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:50:38 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-61b58779b93so130139306d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684252195; x=1686844195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFGPzaLGza6USyFk2W1xiNgdO9q790qPd9zu8sf1g7E=;
        b=VhoLfrZsWRV5hrL7lwFw2v4CL2xcnV2+9uE7rGefaQdDK6icP0n2NK/wd8TCXF5ogu
         vNxl5ph4qvRgcYFnq2xrRSkxyX7q+oi9uVDGOYz7hfzgp6spDpP8pU/XkGa+2NMUCY15
         MJg7yRQf5bjHhA5js9+ZkSw6dDnNG1V1Ulfek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684252195; x=1686844195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFGPzaLGza6USyFk2W1xiNgdO9q790qPd9zu8sf1g7E=;
        b=Zw/mVWLDzz+FgwmeHfWGsXAFfzu9NfJrSTRTRcVtSrf08CBQZF7PfRapJS4eApYaUR
         uGyP2qX8VuMoAHruj/BWiHS7/GrZMnus7q7rdk1/jJ82iZ9+9whEMtWSIwbB+kNCnCCM
         Ui9d6TE0S4Qi7BaFpHM2q3RvpMoFMyNDmP+5XgX36TVMEjBXBSXZM7HLf98LSOxeXsWe
         YtNhvCBOoHldzTw/1jCJq3HeTVWRJ3G/SVXcAccXXicpimav4IH5CkupmsbQaL8Li6R8
         MMTwZ75XIXo8CuBIXOFMJgNAYiS5hboE/Pu42okXLegRposTZr/NShQb6fYuHnbh93oX
         mX6g==
X-Gm-Message-State: AC+VfDxahV31+Y6ElGkXYDgpgd/PdBsEgZQ9oxIkZfJHlzuNB5qKBo+x
        QzBTjOqWlfbF//3QjmEeAXC0crrxV7WMRxzDLZw=
X-Google-Smtp-Source: ACHHUZ6uLTe1JEWA+eHMUnvuZDR9xgk6qkEIbrqO1KJqLJia7Zd6Pbavp9GUttkm6i1Mj8xmgReDSw==
X-Received: by 2002:ad4:5ae5:0:b0:622:7b7f:ed45 with SMTP id c5-20020ad45ae5000000b006227b7fed45mr32226679qvh.46.1684252194799;
        Tue, 16 May 2023 08:49:54 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id eu16-20020ad44f50000000b00606750abaf9sm5716739qvb.136.2023.05.16.08.49.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:49:53 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f51ea3a062so597481cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:49:53 -0700 (PDT)
X-Received: by 2002:ac8:574a:0:b0:3ee:d8fe:6f5c with SMTP id
 10-20020ac8574a000000b003eed8fe6f5cmr279415qtx.1.1684252193280; Tue, 16 May
 2023 08:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHwB_NLBLEUiu__fE9F=j0KFssq7Lxfz8WUnbR0C6yi=zsboJw@mail.gmail.com>
 <20230509025153.1321446-1-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=Xp_OoxJH38skQswjK_AWwJ5P2OmgjnXLog9bAht0CL6A@mail.gmail.com>
In-Reply-To: <CAD=FV=Xp_OoxJH38skQswjK_AWwJ5P2OmgjnXLog9bAht0CL6A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 16 May 2023 08:49:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjLVSiT_AD=SBo2mD23rCw_3iJRC4rBPrrMHBV2CCn6w@mail.gmail.com>
Message-ID: <CAD=FV=WjLVSiT_AD=SBo2mD23rCw_3iJRC4rBPrrMHBV2CCn6w@mail.gmail.com>
Subject: Re: [v2] drm/panel: Modify innolux hj110iz panel inital code
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, hsinyi@google.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 9, 2023 at 8:42=E2=80=AFAM Doug Anderson <dianders@google.com> =
wrote:
>
> Hi,
>
> On Mon, May 8, 2023 at 7:52=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > There is a problem of screen shake on the old panel. So increase the
> > panel GOP component pull-down circuit size in hardware, and update the
> > initialization code at the same time. The new initialization code mainl=
y
> > modifles the following.
> >
> > a)adjusted for GOP timing. When Display sleep in, raise all GOP signals
> > to VGHO and then drop to GND.
> > b)Increased the Vertical back Porch and Vertical pulse width, so need t=
o
> > update vsync_end and vtotal and CLK in drm_display_mode.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> > v2: Modify commit message
> >
> >  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 397 +++++++++++-------
> >  1 file changed, 235 insertions(+), 162 deletions(-)
>
> Every time I see the opaque changes to the pile of "DCS_CMD" arrays I
> feel obliged to grumble a bit, but as I've said before I guess it's
> OK-ish...
>
> Thus, this patch seems fine to me:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Just to make sure there are no objections, I'll give this ~1 week and
> then I'll land it to drm-misc-next.

Pushed to drm-misc-next:

519ce291168a drm/panel: Modify innolux hj110iz panel initial code
