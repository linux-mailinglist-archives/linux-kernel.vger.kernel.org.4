Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62CB730429
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbjFNPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjFNPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:50:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0449E13E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:50:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso8904445e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686757830; x=1689349830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBxZ/WkHsxnx/bLYGuhyu1gVFSm0iBsy0Y9Dj3gZZw4=;
        b=NqLQAiYotvE7r3ozEcisx0d4raaLD0UAfBtKXNxW0qLB+omclg44I9cBU1S83x60Iv
         hsm71iUUKCE9hv7hwSb3UZvWVwuhW7n8HtLbMMKB8YMrH2iWoSmoVLADH9uZmXkAHb7t
         P59zrHOLTfv8Sle3S+jxYvOVN209AQbfAVyfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757830; x=1689349830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBxZ/WkHsxnx/bLYGuhyu1gVFSm0iBsy0Y9Dj3gZZw4=;
        b=DjX995VItj5cLUKZtFj5kQYEBa0VZHlx2k9FxpZcadmPizSvan5gOso7Gr+rMApJsw
         tio1k4sEzgW8ovRf49RUAHGZhn2+I66RCwY0qzNwEfK2qEUYNUi20HDYanFU2ajb3bcR
         Nmkizv/eHOLOicEfn8HMsxrW7t7GPWJPtmkBbC42Iycm9K/cOCCltWsYlqwyyQ+YE1/q
         ub5NEZzHrhP657tZOSIfjER2/x/LAvPbIMy+F9/h7/yjCKljgB+KQr1wA1UmpaTpLI6U
         NMP3IhfMny6yOIne3aNUkOvPAVsEZmULYVCuFbmuf30Q0DVfNeOniXA5wKADMxCONqt+
         V7Aw==
X-Gm-Message-State: AC+VfDwWiCM8Zq8unrkFF6ggZA43p2dyYmfAkC/Gerdh33HvfTpieymS
        f9kGjrs0XAzNyWiOu/uVY8gsDhRCsB9G1NCDCBZRpxuO
X-Google-Smtp-Source: ACHHUZ4fWsUOzHj0+KMF6Rlwfju2VycvmjEdsJqd9aq6T7Ewmz2L7hBFg2NZuPHP4Y9XhYLs9Lv69A==
X-Received: by 2002:ac2:465b:0:b0:4f6:1805:6080 with SMTP id s27-20020ac2465b000000b004f618056080mr9693681lfo.4.1686757829976;
        Wed, 14 Jun 2023 08:50:29 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ot25-20020a170906ccd900b00965f5d778e3sm8105732ejb.120.2023.06.14.08.50.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:50:29 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f7359a3b78so134345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:50:28 -0700 (PDT)
X-Received: by 2002:a05:600c:5207:b0:3f1:9a3d:4f7f with SMTP id
 fb7-20020a05600c520700b003f19a3d4f7fmr153672wmb.1.1686757828661; Wed, 14 Jun
 2023 08:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
 <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
 <1bc79c48-7cba-476d-9a7e-5754a88fcdae@sirena.org.uk> <CAMi1Hd2BLB6H3QRLB5svRTkGoXaUeEsakNsmfCOjbDBcCEeqkA@mail.gmail.com>
 <CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com>
 <bb5c828a-b8c5-40a0-9b67-44e73abcbef0@sirena.org.uk> <CAD=FV=UXOse+yRUmZBUOkfpWXPRKBw2R-+BVzPGcuwwFV_VqQw@mail.gmail.com>
 <84110995-a99b-8b5a-cd34-8430866eb9b1@leemhuis.info>
In-Reply-To: <84110995-a99b-8b5a-cd34-8430866eb9b1@leemhuis.info>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Jun 2023 08:50:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-h4EUKHCM9UivsFHRsJPY5sAiwXV3a1hUX9DUMkkxdg@mail.gmail.com>
Message-ID: <CAD=FV=V-h4EUKHCM9UivsFHRsJPY5sAiwXV3a1hUX9DUMkkxdg@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Mark Brown <broonie@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2023 at 8:37=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> On 07.06.23 15:47, Doug Anderson wrote:
> >
> > On Wed, Jun 7, 2023 at 6:18=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:
> >>
> >> On Tue, Jun 06, 2023 at 04:29:29PM -0700, Doug Anderson wrote:
> >>
> >>> 2. Try adding some delays to some of the regulators with
> >>> "regulator-enable-ramp-delay" and/or "regulator-settling-time-us".
> >>> Without a scope, it'll be tricky to figure out exactly which
> >>> regulators might need delays, but you could at least confirm if the
> >>> "overkill" approach of having all the regulators have some delay
> >>> helps... I guess you could also try putting a big delay for "ldo26".
> >>> If that works, you could try moving it up (again using a bisect style
> >>> approach) to see where the delay matters?
> >>
> >> This is information which should be in the datasheets for the part.
> >
> > I was thinking more of something board-specific, not part specific. In
> > theory with RPMH this is also all supposed to be abstracted out into
> > the firmware code that sets up RPMH which magically takes care of
> > things like this, but it certainly could be wrong.
>
> /me waves friendly
>
> That afaics was the last mail in this thread about a regression caused
> by ad44ac082fd ("regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
> PROBE_FORCE_SYNCHRONOUS"") from Doug; Amit's attempt to patch it (
> https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.=
org/
> ) also wasn't welcomed. Just like his earlier revert attempt
> (https://lore.kernel.org/lkml/20230515145323.1693044-1-amit.pundir@linaro=
.org/
> ).
>
> Does this mean this regression won't be addressed before 6.4 is
> released? Or was there some progress and I just missed it? What should I
> tell Linus in my next report?

Of the two proposals made (the revert vs. the reordering of the dts),
the reordering of the dts seems better. It only affects the one buggy
board (rather than preventing us to move to async probe for everyone)
and it also has a chance of actually fixing something (changing the
order that regulators probe in rpmh-regulator might legitimately work
around the problem). That being said, just like the revert the dts
reordering is still just papering over the problem and is fragile /
not guaranteed to work forever.

-Doug
