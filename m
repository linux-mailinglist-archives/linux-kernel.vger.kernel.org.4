Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B863B1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiK1TCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiK1TCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:02:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072326AD4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:01:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy37so28217087ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7TE3xTXHxdiPDqToBEWb9svQo97suw8gwZaCnVq0Pk=;
        b=aVHKrbjVR6RMBzgskzOOJX3n9se5rG6SNBpczzN6sx49SsQagI8ySWu1eWrAS82a25
         1VtP5sG0l2SyzqLy8HSg/XT6g+6M0QNhfPNKCWzt5SUpD5S6zy52Z6I+hC609fD64GI6
         jb+MdADYxZquZEKxDNUGYPaoCBRTDAWnCtKlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7TE3xTXHxdiPDqToBEWb9svQo97suw8gwZaCnVq0Pk=;
        b=kF+U7V47u8coFsKuxEd+4as6fl2x+nEJINmIzSbiAbnzAA8F/Q8K0ODs7mzyz5kuLm
         6NMNx5j9TX8MCaW6oYQrbmwY+JMOiaWShAZX6u6Yn1+qAgI2F4ubR7up5jT74LviffAC
         5O2rT5+EjvzKgnZ70lNBaDnWru+w+9uQX61nYBIOZC4jr0FIMWIPY/gQPTzgunx3bWlZ
         /oJU6BmEOsk9V/Hr0/13LDCam/MC6qN/bjL4m/PHlbgX5C5h4BPCEuGaFOESI9dPGJ0/
         KcAySe9ve8yo0KS0gi2CFy9kiwfgj/4dQXWjF2aQ0qxWr3uw8e0OL3keXVCm0bxRq6rI
         86jg==
X-Gm-Message-State: ANoB5pnBAgXDxHHTI9vklWd5dneQ6bvrGnmHwuA2lfPGsJMIQH3jKKQv
        uqdqugcTxnYmrYwLZiOAcTYvGigSRLwKzYkQ
X-Google-Smtp-Source: AA0mqf4SdKFy1vhv6Xd2vihs+INKPqeXLvZJOHLGzQNOi4hsqDunZsXH8/2pxAOUYlnHaNAEro8o/w==
X-Received: by 2002:a17:906:17c9:b0:782:fd8e:9298 with SMTP id u9-20020a17090617c900b00782fd8e9298mr28604004eje.640.1669662116894;
        Mon, 28 Nov 2022 11:01:56 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906308900b0073d83f80b05sm5343785ejv.94.2022.11.28.11.01.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:01:56 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id d1so18485272wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:01:56 -0800 (PST)
X-Received: by 2002:a5d:4950:0:b0:242:1f80:6cd9 with SMTP id
 r16-20020a5d4950000000b002421f806cd9mr681565wrs.405.1669661755148; Mon, 28
 Nov 2022 10:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20221124115712.v4.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
 <CAPao8GK93KMrtaXw7mNWOCE60zk=uCENLfBXhNRVxJXEnnaGFg@mail.gmail.com>
 <f58866c8-0164-2e59-4ff3-f9a4f9334e49@linaro.org> <CAPao8GKbdK79Z7w91x0T6JW9v6VFoeYSaXGGAuzB_=ukR9g0_w@mail.gmail.com>
 <b54cd0a4-7ee8-e8c0-ceda-18b29588d535@linaro.org> <CAD=FV=X9C8nLDrEpZE2tLtq6Brn9cd-15+1JWFOL4cPYdJs5Dg@mail.gmail.com>
 <f92ce2ed-80b5-eb26-36a4-2384a7a8510f@linaro.org>
In-Reply-To: <f92ce2ed-80b5-eb26-36a4-2384a7a8510f@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Nov 2022 10:55:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xfo713SmTpuOJYDavWCciCR0p47Qx7U+6gEN+f4FrB=w@mail.gmail.com>
Message-ID: <CAD=FV=Xfo713SmTpuOJYDavWCciCR0p47Qx7U+6gEN+f4FrB=w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Add zombie
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Gavin.Lee@ecs.com.tw,
        Darren.Chen@ecs.com.tw, Abner.Yen@ecs.com.tw, Vicy.Lee@ecs.com.tw,
        Jason.Huang@ecs.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 28, 2022 at 9:22 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/11/2022 16:56, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Nov 24, 2022 at 3:27 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/11/2022 12:20, =E6=A5=8A=E5=AE=97=E7=BF=B0 wrote:
> >>> Hi Krzysztof, Matthias,
> >>>
> >>> How to use "get_maintainers.pl"?
> >>>
> >>> I find this script in path "<MyCodebase>/kernel/v5.15/script", and ou=
tput
> >>
> >> This looks like v5.15 kernel which is heavily outdated. Please never
> >> work on such kernels when interacting with upstream. The rule is you
> >> work on either last mainline kernel (v6.1-rc6), maintainers for-next
> >> branch (you should know who is the maintainer of subsystem you submit
> >> to, get_maintainers.pl gives this information) or on moderately recent
> >> linux-next. For bigger patchsets there might be exceptions for these
> >> rules, but it's not the case here.
> >
> > Just to add context here, it's a fairly standard workflow for ChromeOS
> > kernel engineers to work in a "versioned" kernel directory but still
> > checkout and work with the upstream kernel. I'm sure it's confusing to
> > anyone not used to working with the ChromeOS source tree and build
> > system. Sorry! :( So the fact that Owen is in a directory called
> > "v5.15" doesn't mean that he's actually working with the v5.15 kernel.
> > The fact that Bjorn's address is correct in his CC list implies to me
> > that he's actually got a proper upstream kernel.
> >
> > I had previously [0] instructed Owen to send against Bjorn's tree, so
> > hopefully it's correct.
>
> If it was on Bjorn's tree, get_maintainers.pl would not produce such resu=
lt:
>
> ---
> Series-to: LKML <linux-kernel@vger.kernel.org>
> Series-cc: Douglas Anderson <dianders@chromium.org>
> Series-cc: Bob Moragues <moragues@chromium.org>
> Series-cc: Harvey <hunge@google.com>
> Series-cc: Stephen Boyd <swboyd@chromium.org>
> Series-cc: Matthias Kaehlcke <mka@chromium.org>
> Series-cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

So the above is the _manual_ set of names to add atop get_maintainers.
Patman starts with the list you've manually added (via Series-to and
Series-cc) and then automatically CCs the results of
get_maintainers.pl


> or this:
>
> ---
> owen@buildsvr-HP-ProDesk-600-G4-MT:~/chromebook_zombie_os/src/third_party=
/kernel/v5.15$
> perl scripts/get_maintainer.pl -f MAINTAINERS --email
> linux-kernel@vger.kernel.org (open list)

Wow, really? Maybe I don't have Bjorn's tree correctly checked out
either. ...or you can tell me what I'm doing wrong.

$ git checkout linux_qcom/for-next
HEAD is now at 4d2b529bce12 Merge branches 'arm64-defconfig-for-6.2',
'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2',
'drivers-for-6.2', 'dts-for-6.2' and 'arm64-fixes-for-6.1' into
for-next

$ perl scripts/get_maintainer.pl -f MAINTAINERS --email
linux-kernel@vger.kernel.org (open list)


> as Owen indicated earlier. They are either incomplete or not correct.
>
> Of course I don't know whether the base tree is the problem or usage of
> get_maintainers.pl...

I suspect it's because the only "maintainer" of the file MAINTAINERS is LKM=
L.
