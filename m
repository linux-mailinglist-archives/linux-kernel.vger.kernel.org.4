Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A11728683
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFHRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjFHRoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:44:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C952D56
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:44:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-777a9d7efabso44172839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686246260; x=1688838260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioc3PMTHThn4DBw80/q6Z7SBMJ2IWtRiI0d7gZlh7mA=;
        b=KaVd2qkKYKzLQlBo29pMLCEun3YzvWEJdiHcLPVSiU0Qs6Xs0ftFtL7iWs1hv+kNna
         xm780xKSbOsLM/RD2vOpsFDYRuxJJphOGATa6Q/+MdjWkzBRZWN1N/ulhcmPSd+CjaUd
         vJYDuE9/u7YEzNw+voCRI4E74kqlJvid4HnSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686246260; x=1688838260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioc3PMTHThn4DBw80/q6Z7SBMJ2IWtRiI0d7gZlh7mA=;
        b=LJvlNxax8/gh2NXezo7bD0KwDInrMabSh4kWysI5+8LA5x5j6ZEkmHeHo0ceKYpsh/
         ilfK91JQH7W7Zc2yGBAPKAaryQpj8B+8t+3J8G+HbRLmVF2HqOQ+wwJ18MqWASo+jBCz
         eJiJJZSperqN43OeNPnjTfDxfWJq+uhPKusvJDf/Q2X2nNXcfoxSwRd0DTFSS8hRk1Al
         oXGjFIycavdUlYWM/LvYbLfZuR2Z3AtcTAQg1uayZtJfkeiie9b4fmFTDQPFimwUCpAe
         UVo0sKd9V+ntCCpVTB/220Sfx2TngrTAz88MALz8j6eHn5ME37jRlH3+B8Wm4jPBXIkr
         QGKg==
X-Gm-Message-State: AC+VfDzKKrJh6buEU+pCzyL1aH/5nPWvMrBSl03bM0kT8Si3CsL6hlcr
        JsD4Kuxxp7zPbIT7xLOizNdOs8+M+qvOd2j/UO4=
X-Google-Smtp-Source: ACHHUZ5EwZts1q+a9KHz23UlcLzZGeVmpClX74bo2u1nFjw7GyK0fU4pc/mEbC5wfE77GAdWFzxbSA==
X-Received: by 2002:a5d:9544:0:b0:769:a1dc:c787 with SMTP id a4-20020a5d9544000000b00769a1dcc787mr12045344ios.13.1686246260541;
        Thu, 08 Jun 2023 10:44:20 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id v14-20020a02cbae000000b0042036f06b24sm400778jap.163.2023.06.08.10.44.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 10:44:19 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33d928a268eso151625ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:44:19 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a0c:b0:328:3a25:4f2e with SMTP id
 s12-20020a056e021a0c00b003283a254f2emr153033ild.9.1686246258975; Thu, 08 Jun
 2023 10:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <CAD=FV=U9xwxC4+wDYFMSoLWaj8vaLH_jettZ=nxEZP+1tNk=oA@mail.gmail.com>
 <d0dfdfba-7a70-7d12-2c30-ad32b3f95bb8@linaro.org> <CAMi1Hd1Upo8zV4MPtdqHgEaMQ72yK0gZgf5Z4uOaqKqhw8Hndg@mail.gmail.com>
 <55f07600-3fa5-f3c2-eb3e-e87a57244812@linaro.org> <CAMi1Hd0qRrRw3_U7kqz-8BJnwJR1RqweajBWrZWWDGmtqVMDAQ@mail.gmail.com>
In-Reply-To: <CAMi1Hd0qRrRw3_U7kqz-8BJnwJR1RqweajBWrZWWDGmtqVMDAQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Jun 2023 10:44:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+SMsr=TCJtbimq0U94gcoucMLSwA6adCKwn3y+qxLZA@mail.gmail.com>
Message-ID: <CAD=FV=W+SMsr=TCJtbimq0U94gcoucMLSwA6adCKwn3y+qxLZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        regressions <regressions@lists.linux.dev>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 8, 2023 at 10:27=E2=80=AFAM Amit Pundir <amit.pundir@linaro.org=
> wrote:
>
> On Wed, 7 Jun 2023 at 15:46, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> >
> > The problem looks like in missing consumers, missing probe dependencies
> > or something in the driver how it handles these.
>
> Missing consumers seem to be the case here, if I'm reading the
> $debugfs/regulator/regulator_summary correctly(?)
> https://www.irccloud.com/pastebin/raw/2jwn0EQw.
> lvs1 and lvs2 sysfs entries in /sys/class/regulator/ do not list any
> consumers explicitly either.

They are marked as always-on regulators, though. The lack of an
explicit consumer in device tree shouldn't really matter. I don't
think this is the source of your problem.

-Doug
