Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603B75F038F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiI3E0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiI3E0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:26:45 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB43BC52;
        Thu, 29 Sep 2022 21:26:43 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-131de9fddbaso3111697fac.5;
        Thu, 29 Sep 2022 21:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=+XewqCSuPIyUjSwEXa/rZlF6iD2dRJaDHfpm+NaJsFs=;
        b=UQmWV2cB0HSmOmRV1RteCFaujrPm/Xv81oTVyRT90b7iMuHAsLvHhcOOkaR6r1HqJu
         Oh56ZJD0+rcr69stBO8K6vOud4EVg8P/fVq4xm6HmNU/ofpeRPRxkeb5FPM5dEHrL+aw
         0bWjWRmO93vgDqPK85lUZkgc0VuK8F9J6SZXsvN6B7B2H+0i2kuwV6Nj+74updyJ7wef
         eEyZd9MdR8dCbnatIrPCJawNxwetb7aOObQoaHITnhElbl2AMmX2INqHoZjAgoPeJdgX
         HJyT48RksrlrF2KIl72r/ngttCo6ek6ZjMHkc8io+IzwoBr0oEmyuc9rhlcw2ZljvDZu
         RXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+XewqCSuPIyUjSwEXa/rZlF6iD2dRJaDHfpm+NaJsFs=;
        b=PN/f/QoIQXVGtlBUqYDJOn+GJ9mYUoS6MkilEjIJAn1C1At1q1Sd3bro3jredLRRaR
         dD7npZfmUXxA9pFUX4DQ+pKVcQtN8Hv12EPtIU+FS8uZQFUVl8fRkfs30zydEPQpBax9
         Z/YaazxBw8xiV46lC/RJLNUY6kEwtV0SAgo/Yn7Fzug3Tt/zozKL4JhNc9DFqYSqTEHP
         uF/rRoFf/R2r3fi8XxIU/L65g4Afe59Yirx3Sq0a2w9mXcc4f8QtDc52sDCWFDxVs6zI
         QpWJyXKEs0eY+4kozXNoa9MI/0hJ6yydMFFmzRZbJWOHKfGNtMEL8FVuR1yoa6PAouwt
         YOoQ==
X-Gm-Message-State: ACrzQf3MyiXaWSWGRffNgI1HU7uXO48nT16je0bJLsjcACOtoQR71g9y
        qZyQ5XewqDAABSf/LaFx4ocDHEeyDc/S3Ede1ds=
X-Google-Smtp-Source: AMsMyM7oTe6QJlQAPqe1+H5Aqg1qjXQKaLZYGX4J7zEiNdbupzm1DkORack4Xj4RAgMEajFmqr83UtM3819J6KH26X8=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr3875011oam.218.1664512002888; Thu, 29
 Sep 2022 21:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net> <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
In-Reply-To: <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 29 Sep 2022 21:26:31 -0700
Message-ID: <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Ian Rogers <irogers@google.com>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 29, 2022 at 8:49 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Sep 29, 2022 at 3:10 PM Slade Watkins <srw@sladewatkins.net> wrot=
e:
> >
> > Hey Nick,
> >
> > > On Sep 29, 2022, at 5:54 PM, Nick Desaulniers <ndesaulniers@google.co=
m> wrote:
> > >
> > > I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
> > > Is this a known issue, or am I holding it wrong?
> >
> > Hm=E2=80=A6 I also remember this. I have a Zen 2 based system that I ca=
n do testing on, so I will do so when I=E2=80=99m able.
> >
> > If I discover something of note, I=E2=80=99ll get back to you.
> >
> > Cheers,
> > -srw
> >
>
> LBR isn't yet supported for Zen but is coming:
> https://lore.kernel.org/lkml/166155216401.401.5809694678609694438.tip-bot=
2@tip-bot2/
> I'd recommend frame-pointers.
>
> +Ravi who may be able to say if there are any issues with the precise
> sampling on AMD.

Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
since it has no task context.  Ravi is working on it..

Thanks,
Namhyung
