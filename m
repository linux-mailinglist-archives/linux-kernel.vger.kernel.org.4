Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E66D1550
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCaBr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCaBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:47:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC6E12CF4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:46:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j11so26984255lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680227204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzUFcUZYAgXJaL+peWiLAxW27PqyVrGiLd3CEntMJcI=;
        b=DwURgHSaGuk5chgT296uFEmpi0z7WW08Mh6CM8jJnMW+qc7FB01OoHRsIkm4EIFayk
         eFHOsW9Uv3+B/PQth4O/8vlMBpgKOjWyxuVpu1SuZY25dlrEYh1eBF1wPPft4zPE/phf
         ExyMZo5TaJwvKfS0RgJocWzrlFt800fCZRIGgo9tvVJjaD++way20A4XqfNOPaNww2hT
         qUVpDh66AiXTlunIa4l1peKeSKcQilSL4BKRJNpbtaMIMWWv7QMDtS2dgtrjEGtvh7CS
         MJ6mf34v+uufODN/tFtWMaf7hApU6oqXte3ZlCQBbbzcCOnBOppDemR2xkju16Y3s+ea
         twYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680227204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzUFcUZYAgXJaL+peWiLAxW27PqyVrGiLd3CEntMJcI=;
        b=hIkotWNiCCn7cDdAPUi90knfLyVLi5p5G3M3gMf53pbMvCrya6yFuBSoLdfXbgIBPQ
         HbPTK3BMECDvpK6I1nWPriwhs7PxGJ/tO/U20V8io+6znGqJ1GSslMdIXcIOuF7O6wDq
         1xR+AH7yyVJMIk8UeDZQ+1gsqpWJpm903qWfRnL0Q1xc9zQGiHt8VJo70GfmLl67q46U
         mKIleRI3v2mu8lndlWGSEyu2R6I7mVMDnH4aICxsc6Mu+QH/H9fri7TCu7p78vRID2j6
         QvY7HLFc7uaB9yqGNmlOa9dg2R4Fgslpp9gxW1TOaWOHoi1Ohxo4wSISXZg0HkLvL2N4
         CeTw==
X-Gm-Message-State: AAQBX9eLMGyDCWHGa9WmdKz2JZTMU9ciYuCGq2oAVfEPIQHnsM+L9dW3
        qUTy2CBCIDAsXJUQ8f9/fje7WzYtmEIxpC6ZlrhR4g==
X-Google-Smtp-Source: AKy350acsPBv20eV+u3HvPYOhccTDn0ARk5feDJYKeFqLB+4OdDnt+vsFwe6J5FVfZODTNLEVsFreS2LwVrGv3Op15s=
X-Received: by 2002:ac2:4884:0:b0:4e8:426d:123f with SMTP id
 x4-20020ac24884000000b004e8426d123fmr7589065lfc.11.1680227204379; Thu, 30 Mar
 2023 18:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230330084250.32600-1-quic_mkshah@quicinc.com>
 <20230330084250.32600-2-quic_mkshah@quicinc.com> <20230330093431.xn5wwiwqbne5owf7@bogus>
 <CAPDyKFpUmkF=pOwXNrva1k2R+RFBB39-Y4kA0Fve+-3NGbtDag@mail.gmail.com> <20230330131334.idb25zf4tdf3zqn3@bogus>
In-Reply-To: <20230330131334.idb25zf4tdf3zqn3@bogus>
From:   Wing Li <wingers@google.com>
Date:   Thu, 30 Mar 2023 18:46:33 -0700
Message-ID: <CADut4F0oh7kzv0GvuUV0CJnS_YxELoEzuZ_=tDKyKO86baCJNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: psci: Move enabling OSI mode after power
 domains creation
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org,
        dianders@chromium.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jwerner@chromium.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding some clarifications.

On Thu, Mar 30, 2023 at 6:13=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Mar 30, 2023 at 02:06:19PM +0200, Ulf Hansson wrote:
> > On Thu, 30 Mar 2023 at 11:34, Sudeep Holla <sudeep.holla@arm.com> wrote=
:
> > >
> > > On Thu, Mar 30, 2023 at 02:12:49PM +0530, Maulik Shah wrote:
> > > > A switch from OSI to PC mode is only possible if all CPUs other tha=
n the
> > > > calling one are OFF, either through a call to CPU_OFF or not yet bo=
oted.
> > > >
> > >
> > > As per the spec, all cores are in one of the following states:
> > >  - Running
> > >  - OFF, either through a call to CPU_OFF or not yet booted
> > >  - Suspended, through a call to CPU_DEFAULT_SUSPEND
> > >
> > > Better to provide full information.

The spec quoted above only applies when switching from
platform-coordinated mode to OS-initiated mode.

For switching from OS-initiated to platform-coordinated, which is the
case Maulik is referring to, section 5.20.2 of the spec specifies:
"A switch from OS-initiated mode to platform-coordinated mode is only
possible if all cores other than the calling one are OFF, either
through a call to CPU_OFF or not yet booted."

> > >
> > > > Currently OSI mode is enabled before power domains are created. In =
cases
> > > > where CPUidle states are not using hierarchical CPU topology the ba=
il out
> > > > path tries to switch back to PC mode which gets denied by firmware =
since
> > > > other CPUs are online at this point and creates inconsistent state =
as
> > > > firmware is in OSI mode and Linux in PC mode.
> > > >
> > >
> > > OK what is the issue if the other cores are online ? As long as they =
are
> > > running, it is allowed in the spec, so your statement is incorrect.

The issue here is that the kernel prematurely enabled OSI mode based
on the condition that OSI mode is supported by the firmware, and is
unable to switch back to PC mode in the bail out path if hierarchical
CPU topology isn't used because the other CPUs at this point are now
online.

> > >
> > > Is CPUidle enabled before setting the OSI mode. I see only that can c=
ause
> > > issue as we don't use CPU_DEFAULT_SUSPEND. If idle is not yet enabled=
, it
> > > shouldn't be a problem.
> >
> > Sudeep, you may very well be correct here. Nevertheless, it looks like
> > the current public TF-A implementation doesn't work exactly like this,
> > as it reports an error in Maulik's case. We should fix it too, I
> > think.
> >
> > Although, to me it doesn't really matter as I think $subject patch
> > makes sense anyway. It's always nice to simplify code when it's
> > possible.
> >
>
> Agreed, I don't have any objection to the change. The wording the message
> worried me and wanted to check if there are any other issues because of t=
his.
> As such it doesn't look like there are but the commit message needs to be
> updated as it gives a different impression/understanding.

I think the commit message is accurate and we can keep it as is.

Best regards,
Wing

>
> --
> Regards,
> Sudeep
