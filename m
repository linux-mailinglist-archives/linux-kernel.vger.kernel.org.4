Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E04716A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjE3Q6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjE3Q6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:58:03 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B999D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:58:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75afa109e60so284956085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685465880; x=1688057880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfTlpnHMOZxiUbtco4W6+o8TVl366P2iW1YkCqnywqM=;
        b=et75hUF5CzN09+7+lYsKWiwcpYpgYpqNWUrxaRJKeBRZuVVNrnlHG7LHGGXyGQJ6b7
         7vhL8HK+w1YvCyqT+QS0LOKpCmPyqqprPjDz5aBVV+2FKygIvUKrWS2fEzi6G898Nqy6
         Le8EpFfWZBtZ5pG7zIFLpfeZGj4Q/tS2dEois=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465880; x=1688057880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfTlpnHMOZxiUbtco4W6+o8TVl366P2iW1YkCqnywqM=;
        b=Pddj4xBC67HTG3vzHWPtoyHr/YSRYgWEDaYU5wa/1MzeITWbQGh6oDv4l/07kZRGyQ
         kCttkT56hY3itkkVCfx9i68WAav+PdFJy0QAGgHEROqmJ38euV8gHt+WD78MbAqdG2bK
         PuIomckvgyJXFKAGZbWo6CYmXyQbPDbU+ntP1NQCpKG9w2yvAhdA4T1JphKSf/Ah5JFb
         YLnyTkrdA5vMfVUpCyQ9vMoEzuE5qNUTD49PP8pzw+cZfBWoqoOn/UOK0tIkgd85lY5p
         9uiOR51HiQAEw3De746ZC5n8PWfNv9GiIUOUTZi2CdZvIKvSQcfOhQho+59Exb0dAmrJ
         OMNw==
X-Gm-Message-State: AC+VfDzuS+E31q5QxB+7XKpRxlAmcmWryODVlMjUWtcMZ/cSv8UvngAZ
        kNQpnY6Xd/bk8CPn26tPm+jYdHDyb+CVn+us+RI=
X-Google-Smtp-Source: ACHHUZ44bCLZ3Fmcr86zlXAs0Kw7Z7WR6BeAtf1i4gFh7eoAEy2UB6J1ZnEG9+DRmT5ql7cjz6+4tg==
X-Received: by 2002:a05:620a:3196:b0:75b:23a1:8e35 with SMTP id bi22-20020a05620a319600b0075b23a18e35mr3190678qkb.6.1685465880546;
        Tue, 30 May 2023 09:58:00 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id m11-20020ae9e70b000000b0075cecc90e95sm1426843qka.90.2023.05.30.09.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 09:58:00 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso8211cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:58:00 -0700 (PDT)
X-Received: by 2002:a92:c24e:0:b0:338:3b6a:4719 with SMTP id
 k14-20020a92c24e000000b003383b6a4719mr165620ilo.17.1685465557498; Tue, 30 May
 2023 09:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230523193017.4109557-1-dianders@chromium.org>
 <20230523122802.1.Id68e30343bb1e11470582a9078b086176cfec46b@changeid> <10457cab-f9b0-c38b-9f11-36853b71c7e8@linaro.org>
In-Reply-To: <10457cab-f9b0-c38b-9f11-36853b71c7e8@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 May 2023 09:52:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJhVaFNcLZ_wA=vnYCVVxjq1NFxdV794C0mmxpqvPL6g@mail.gmail.com>
Message-ID: <CAD=FV=XJhVaFNcLZ_wA=vnYCVVxjq1NFxdV794C0mmxpqvPL6g@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: HID: i2c-hid: Add "panel" property to
 i2c-hid backed panels
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, hsinyi@google.com,
        devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 30, 2023 at 8:34=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/05/2023 21:27, Douglas Anderson wrote:
> > As talked about in the patch ("drm/panel: Add a way for other devices
> > to follow panel state"), touchscreens that are connected to panels are
> > generally expected to be power sequenced together with the panel
> > they're attached to. Today, nothing provides information allowing you
> > to find out that a touchscreen is connected to a panel. Let's add a
> > phandle for this.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  Documentation/devicetree/bindings/input/elan,ekth6915.yaml  | 6 ++++++
> >  Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 6 ++++++
> >  Documentation/devicetree/bindings/input/hid-over-i2c.yaml   | 6 ++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml=
 b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > index 05e6f2df604c..d55b03bd3ec4 100644
> > --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > @@ -24,6 +24,12 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  panel:
> > +    description: If this is a touchscreen, the panel it's connected to=
. This
>
> Hm, can there be different setup? Touchscreen without panel? What would
> it be then?

For a touchscreen that's a discrete device (not sharing logic / power
rails with the panel) you'd just leave off the panel node like we've
always done. Assuming folks like this series in general, I'll try to
improve the wording for v2.


> Why only these touchscreens? This looks generic, so maybe in
> touchscreen.yaml?

Ah, that makes sense. I guess we need to add an include of that file
from the elan and goodix bindings. The hid-over-i2c.yaml already has
it, though. I'm not 100% sure the existing "hid-over-i2c" driver in
Linux actually calls the function to parse all those properties, but I
guess that's a Linux problem and not a DT bindings problem. ;-)

-Doug
