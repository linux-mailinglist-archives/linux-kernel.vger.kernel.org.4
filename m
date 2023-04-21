Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187696EB021
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjDURE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjDURET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:04:19 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6615467
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:03:44 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-443bd60988eso1236971e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682096622; x=1684688622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnl878ao3KfZM1Schc0iPqmLuMtCb4QrPUJTPEHHzyA=;
        b=Pty3FRa1jIUWP5Ve+3o+4753/XzXKR4XZv3WT6gT/gRjF4DRd2QKKtK0fvPe2Bv9mW
         qiPN1vuATImU9l54VIn97iblJmjIWYdamRWCtVGrrjLMl8TiEiL5JHYFzVfsPLwlYZE0
         l2lrVKGsIp5hsUcpI0rI7RuJbPiD3Ql6mVEd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682096622; x=1684688622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnl878ao3KfZM1Schc0iPqmLuMtCb4QrPUJTPEHHzyA=;
        b=S8r5Puka/LDVRRzCPkTqqNy6gfHr+p5VyfVKwLasKHNVXVgvbEkLLLi+TNLIdv9Nmy
         v1tcOsjMHxCsaZ/3mNcmgBC3pyMybnRjdwMwoealZPebDnSAtaXI8kBsnb9uz/WfXiLT
         VGRJ6Smof4+F7dGMsAIwIWwPgIFSYq5lzJ6aVtIYOb5a/lLXAjFsft8wxH7zKvmuWyK4
         G5HGO41RexaC0jORXaoWZzcEHG5hZXFP//Iw/LUxX9gZ3Wgb4MDCga27DIFXCzZ9nGWf
         Ph1s69agIvmOW5xczpcIdcZ3Qrpu8ih7J+ZDGR+UoPE4I+ZhOwFf82jpdTIRMIjsHBvc
         8VRw==
X-Gm-Message-State: AAQBX9dBF/MlMPUV2gUASj85qLLpxfWzB+KkS/z1zDMvoJxDhO30Aoh4
        bw0NbLbzwunXFv9RD0AyN4HaR3kdmaQvTn8rmos=
X-Google-Smtp-Source: AKy350Y7D6ZtbgZVPytpnHXNb2yR5jS+Tkg7RXqJxavfiTJwiprUL8ObGrbqSluNMWa3W3iJwUelkA==
X-Received: by 2002:ad4:5f87:0:b0:5f1:5f73:aed8 with SMTP id jp7-20020ad45f87000000b005f15f73aed8mr10200029qvb.20.1682095924144;
        Fri, 21 Apr 2023 09:52:04 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id x20-20020a0ce254000000b005f372f4a561sm1292758qvl.35.2023.04.21.09.52.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:52:03 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1177841cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:52:03 -0700 (PDT)
X-Received: by 2002:ac8:5811:0:b0:3ee:d8fe:6f5c with SMTP id
 g17-20020ac85811000000b003eed8fe6f5cmr361276qtg.1.1682095922914; Fri, 21 Apr
 2023 09:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com>
 <20230201-innolux-g070ace-v2-1-2371e251dd40@skidata.com> <CAD=FV=XJCtqep+92h3gLfs4o2TwvL4MORjc9ydTSpZiZ0dsR0w@mail.gmail.com>
 <fb93e95f-181f-917d-9216-a81dec1a2959@linaro.org> <CAD=FV=Vs8UEfBZ56fYb3i1cmFbCSPrbgaedXB4+UvDTOyhzCzw@mail.gmail.com>
 <184f0a80-34bc-5ebf-58bb-82a310eb91f6@linaro.org>
In-Reply-To: <184f0a80-34bc-5ebf-58bb-82a310eb91f6@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Apr 2023 09:51:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLHpddAMo7GQwj98TtDn0xw6UzgYUKyVhSDZw1acKpCg@mail.gmail.com>
Message-ID: <CAD=FV=WLHpddAMo7GQwj98TtDn0xw6UzgYUKyVhSDZw1acKpCg@mail.gmail.com>
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

On Fri, Apr 21, 2023 at 9:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/04/2023 18:37, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Apr 21, 2023 at 9:26=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 21/04/2023 18:15, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Mon, Mar 13, 2023 at 12:51=E2=80=AFAM <richard.leitner@linux.dev> =
wrote:
> >>>>
> >>>> From: Richard Leitner <richard.leitner@skidata.com>
> >>>>
> >>>> Add Innolux G070ACE-L01 7" WVGA (800x480) TFT LCD panel compatible
> >>>> string.
> >>>>
> >>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> >>>
> >>> nit: as I understand it, ordering of tags is usually supposed to be
> >>> chronological. You signed off on this patch before Krzysztof acked it=
,
> >>> so the SoB should be above. I'll fix that when applying.
> >>
> >> Some people agree with this... but b4 disagrees, so I would say the
> >> tools should implement the right process and right decisions. We shoul=
d
> >> not be correcting the tools' output, unless the tools are not correct =
-
> >> then fix the tools.
> >
> > Ah, interesting. I checked and as far as I could tell Richard had
> > manually added the tag when sending v2, so I didn't assume it as a
> > tool-added tag. I'm happy to let "b4" be the canonical thing that says
> > what the order should be.
> >
> > OK, so I just tried this and I'm confused. I ran:
> >
> > b4 am -P_ 20230201-innolux-g070ace-v2-2-2371e251dd40@skidata.com
> >
> > ...and when I check the patch that b4 spits out my "Reviewed-by" tag
> > is _after_ the "Signed-off-by" tag, just like I asked for.
> >
> > Just in case Acked-by was somehow different than Reviewed-by, I went
> > back to the original version where you added the Acked-by:
> >
> >  b4 am -P_ 20221118075856.401373-1-richard.leitner@linux.dev
> >
> > ...and, again, it matches the order that I thought was right. In other
> > words, the patch file generated says:
> >
> >> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> We talk about `b4 trailers`, because the tag is applied by the
> submitter, not by the maintainer.
>
> >
> > Did I get something wrong in the above?
>
> Your `b4 am` will of course put the tag later, because it is you who
> applies the tag.

Ah, got it. So I guess from the perspective of "b4" every time the
author modifies a patch (like adding new tags to it) then it's a new
application of Signed-off-by and thus the old Signed-off-by is removed
from the top and a new one is added below all the tags that have been
received. Thus if b4 grabs all the tags off the mailing list for
applying it ends up in a different order than if it grabs all the tags
off the mailing list for sending a new version.

OK, I can understand that perspective. I'll keep it in mind.

-Doug
