Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF35D6EAF51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjDUQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjDUQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:37:50 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22915465
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:37:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-74ab718c344so653062885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682095049; x=1684687049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxiZElG3FNnEQroNi7gmZ1hDLL3MfyJcrVlb79fLJZ4=;
        b=hwEmvYmLMkOuKWbA7csM8H+xx32ZNQpBTaTDDUphuLwKlAzi+pb7Hv3xekrNruFPFo
         ZMtvnJB2S4tbOvKiyXtNyWntoXoEFuU4YOAB0OjZsiuGr/xXoskcUY3lPLH2StkH9unP
         OPXvwLbwa1bSzGfIiOLTGsy0vg0TySd+0n9fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095049; x=1684687049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxiZElG3FNnEQroNi7gmZ1hDLL3MfyJcrVlb79fLJZ4=;
        b=XTyc+CqFFr6i6ExjOJDw2T9+ZSNdBcuZEax/5e35FHhjXeYVbnmBDqNkcvgfw+P+RI
         bfP9QLrP4/nG8/s61U5SOgO1PbN1LfgvRek/y9vnIQoZttuj7NIMwoGPLiNF5+A7iKsJ
         RXkwGvewP9G8qurZNreeBbANMuK0x7sPBNcaXnworZYF868GtM3T+Wx53dRt/kWn7yNb
         yKwD4ajN3ipdsiqnJrQyQgX00JiJEJHwtnU5PaLZQYT1nV/D9gwODg+n3Fm3wLBTiXHE
         ppGzA2stUiyxYXmh6Iu6uBnP7d2nVRQApkJsvXg1hfmItIYRqDlcqrfhC8OZUsrFtNnt
         uOeA==
X-Gm-Message-State: AAQBX9dIrNQ4Kj8IH/4gm2g7aHZWlkRvTfSMYvC0KFlibKD6ypFff6+N
        SfPU5/AnmuMhHuqKTZaCpaz4GGJRks5lfRFf7e0=
X-Google-Smtp-Source: AKy350Yb6zNe756rzrKktMACRub2WVxpjZy5ODwpniqYPuc75QHwSdWgltGB2MC8mJjPsNmDHjQJzQ==
X-Received: by 2002:a05:6214:2b0e:b0:5e9:48da:9938 with SMTP id jx14-20020a0562142b0e00b005e948da9938mr12203870qvb.11.1682095049035;
        Fri, 21 Apr 2023 09:37:29 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id bp10-20020a05620a458a00b0074e0951c7e7sm1443961qkb.28.2023.04.21.09.37.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:37:27 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1174251cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:37:27 -0700 (PDT)
X-Received: by 2002:ac8:7d45:0:b0:3ef:4319:c6c5 with SMTP id
 h5-20020ac87d45000000b003ef4319c6c5mr294065qtb.19.1682095046699; Fri, 21 Apr
 2023 09:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com>
 <20230201-innolux-g070ace-v2-1-2371e251dd40@skidata.com> <CAD=FV=XJCtqep+92h3gLfs4o2TwvL4MORjc9ydTSpZiZ0dsR0w@mail.gmail.com>
 <fb93e95f-181f-917d-9216-a81dec1a2959@linaro.org>
In-Reply-To: <fb93e95f-181f-917d-9216-a81dec1a2959@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Apr 2023 09:37:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vs8UEfBZ56fYb3i1cmFbCSPrbgaedXB4+UvDTOyhzCzw@mail.gmail.com>
Message-ID: <CAD=FV=Vs8UEfBZ56fYb3i1cmFbCSPrbgaedXB4+UvDTOyhzCzw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: display: simple: add support
 for InnoLux G070ACE-L01
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     richard.leitner@linux.dev,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Richard Leitner <richard.leitner@skidata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 21, 2023 at 9:26=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/04/2023 18:15, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Mar 13, 2023 at 12:51=E2=80=AFAM <richard.leitner@linux.dev> wr=
ote:
> >>
> >> From: Richard Leitner <richard.leitner@skidata.com>
> >>
> >> Add Innolux G070ACE-L01 7" WVGA (800x480) TFT LCD panel compatible
> >> string.
> >>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> >
> > nit: as I understand it, ordering of tags is usually supposed to be
> > chronological. You signed off on this patch before Krzysztof acked it,
> > so the SoB should be above. I'll fix that when applying.
>
> Some people agree with this... but b4 disagrees, so I would say the
> tools should implement the right process and right decisions. We should
> not be correcting the tools' output, unless the tools are not correct -
> then fix the tools.

Ah, interesting. I checked and as far as I could tell Richard had
manually added the tag when sending v2, so I didn't assume it as a
tool-added tag. I'm happy to let "b4" be the canonical thing that says
what the order should be.

OK, so I just tried this and I'm confused. I ran:

b4 am -P_ 20230201-innolux-g070ace-v2-2-2371e251dd40@skidata.com

...and when I check the patch that b4 spits out my "Reviewed-by" tag
is _after_ the "Signed-off-by" tag, just like I asked for.

Just in case Acked-by was somehow different than Reviewed-by, I went
back to the original version where you added the Acked-by:

 b4 am -P_ 20221118075856.401373-1-richard.leitner@linux.dev

...and, again, it matches the order that I thought was right. In other
words, the patch file generated says:

> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

My "b4" is from Dec 1 of last year, so maybe something changed? Let's
update! OK, I synced b4 and now I'm at v0.12.2 from Match 10 (MARIO
day!). The behavior is unchanged.

Did I get something wrong in the above?
