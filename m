Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E00716A37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjE3Q6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjE3Q6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:58:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82698
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:58:16 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38c35975545so3180761b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685465894; x=1688057894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQLTtDtW2MQvZzbg1+YtroMwuASMRT+NGV7h3iEinfc=;
        b=jKXOLdmMGDtcuMnS0qzDKS4DqEurX+SoZtJ3H1yf0l6aQMdvReO4ODlE4ao1iQ1Ahc
         Ey4z8uk9iBlbNnn5/qLiK8PRmKnJiFfjnvrEzGq1kumQ3cuTGdWI+FB90ofY07NuJYqj
         uweY7TVrJ7OrjBo3OVNl30ZzLxzwvTg1ciz1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465894; x=1688057894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQLTtDtW2MQvZzbg1+YtroMwuASMRT+NGV7h3iEinfc=;
        b=FuPr6338QZop9MBy16Zums2Xy7z7+K/YV7hyVP7m9LFZJu7uNsvuV1r/j2UDzppdFN
         tI+244WuhojKkMnsrSX46tSUtlaw9MK7jJk1dvVxWGn0ckSvfj9btob/OsbuLlfuB7Cj
         xuvEHJvkFW4R5YmqRKdVZ253Tmm1XztHhtkPozM2fV18AuCpEUZ/2r3npQcYDfGNLUTg
         cTTQccW2WqGd1ix3+aHmwj/Rc2DsC+Hr04gQT6yHu8zC6TQSzR/ti07Oib9DYgDsvk8u
         BTZKa+zXHq5B5n9amWpYf+fF+4i+VcKTR4nDTZuW9Sg1hKGqOXulPWlWAEViiJk8gYdm
         Ru5g==
X-Gm-Message-State: AC+VfDwhnC3A3NP6+vW/v5i8j8whLUFcXhEEFHeOW7gMUOuTWRem08xO
        gXSAuNxMpxF7oL+en14js36qLofA7VZeC/hni1I=
X-Google-Smtp-Source: ACHHUZ6ONdSrXEYWu2Nryj9cFYHOm6Jl6cY/1wVNFzG8yexuQM2gLeRWN5/G9/yFaLh5GLS3HYgnSA==
X-Received: by 2002:a05:6808:1b0b:b0:396:3b9d:7ee0 with SMTP id bx11-20020a0568081b0b00b003963b9d7ee0mr1717367oib.41.1685465894530;
        Tue, 30 May 2023 09:58:14 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id n7-20020a02a187000000b00418a5e0e93esm825374jah.162.2023.05.30.09.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 09:58:14 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33baee0235cso3225ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:58:14 -0700 (PDT)
X-Received: by 2002:a05:6e02:b24:b0:338:9f6a:d546 with SMTP id
 e4-20020a056e020b2400b003389f6ad546mr181095ilu.20.1685465893122; Tue, 30 May
 2023 09:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
 <20230520050649.2494497-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=Wm_SK0V6WJUkuvu8yFfiP60JBuOdw9cy=0Ck2Jbn-X2A@mail.gmail.com> <bd19f71b-59ee-80e7-9ff1-1cc26ecc49a7@kernel.org>
In-Reply-To: <bd19f71b-59ee-80e7-9ff1-1cc26ecc49a7@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 May 2023 09:58:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WaVXUr8=4MrZQgA7t=yUBDt-iMvOFSeWhsKZ8XHJAREA@mail.gmail.com>
Message-ID: <CAD=FV=WaVXUr8=4MrZQgA7t=yUBDt-iMvOFSeWhsKZ8XHJAREA@mail.gmail.com>
Subject: Re: [v2 2/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
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

On Tue, May 30, 2023 at 4:56=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 22/05/2023 17:33, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, May 19, 2023 at 10:07=E2=80=AFPM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> >>
> >> Add an ilitek touch screen chip ili9882t.
> >>
> >> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> >> ---
> >>  .../devicetree/bindings/input/elan,ekth6915.yaml         | 9 +++++++-=
-
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > I'm curious about the DT maintainers opinion here. Should this be a
> > new bindings file, or should it be together in the elan file. If
> > nothing else, I think the secondary voltage rail name is wrong. I took
> > a quick peek at a datasheet I found and I don't even see a 3.3V rail
> > going to the ili9882t. That makes it weird to reuse "vcc33-supply" for
> > a second supply...
>
> It's easier if they are CCed...

Crud. I just assumed and didn't check the CC list. Cong: can you
resend and make sure you're CCing the people that get_maintainers
points at. One way to find that would be:

./scripts/get_maintainer.pl -f
Documentation/devicetree/bindings/input/elan,ekth6915.yaml
