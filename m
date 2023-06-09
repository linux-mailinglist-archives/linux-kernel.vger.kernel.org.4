Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B1729405
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjFIJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbjFII7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:59:25 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3030DB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:58:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9c60bc99cso12282861cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686301135; x=1688893135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ae0EhWdWYuSdNnJ1IWTbNmO0VX4QhrHcm/Crk+TcHM=;
        b=aKNV+D3WITvOGHV4ccVfqyavaU1ZyOOI781ocaNxuUr/KGXR2SPlizx0YgjziNkL59
         2SJgaW1bBq9NV4hOyXufH2QcjgIX+tiX2goFHgTHLFOkYmwlrKiDV/Lw3rrv+/ekB3Kd
         FrL/wQBsafphXm113/3zDrWRWXocELMsfnkN96IJ2daPnSKTBZM4wqmVpfJticC/3hoH
         WE9MeVOx538kcp4YIgqJnwDkLhZXH0FILQUQkiQhuqAMnUWqnXwluqDpKWtyTGMMSy9Q
         3kmFmm8ovi9YNv23+xcay1m57Mi1R7SDZ1+YXdm8qQG9BjADze7BOLW8eqJ6orWrHx1n
         b3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686301135; x=1688893135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ae0EhWdWYuSdNnJ1IWTbNmO0VX4QhrHcm/Crk+TcHM=;
        b=JmpGRQ8Ajw2vo39+TXKsRkNvpS1a0MU0+VsZ3AJIvXiQfJ7XPKxEBx6BRZlIjVtE5H
         BiEtUgFTAOkAZ1gnZ+jphOO19kwTlzxhd7EzeytkLd0KIrZjhBsMMSX8kC82lmcxoy3A
         JfujOfpWy2CzMWnPA8UsJclNXL7yRVRQCgeKxqy2o9vwqAIJ0mnBiTPIIV5pdz7GuE5O
         o2WxRnpOWAQbdgMaXIb3GaT2aECpv86aV9g2LFp5Zuy0w41mOk0G63A2jVYaecDlR647
         VpAZAMmBhzkLNptRLsBA6RM6IouxM14W5Q/7Wd4vmslS3YqAi1X2G9SP7CSxLNyV+zCI
         gfdQ==
X-Gm-Message-State: AC+VfDwwsmEuqGZZ9n4XujqrDg/yHPXnGLL1bfjHITuluCPT+//J26gj
        aY1yleetjKlZf8tNKsPWCvXa5vp+MnydNBddfykqoA==
X-Google-Smtp-Source: ACHHUZ6CesUmn134+xMuZF1GTUPeVibyKCvXiVZEsmz1NtCn+EZ+JjXuyueV/0pNvswdUa/QY+xbuAq+uhp0y1cVr8w=
X-Received: by 2002:ac8:5b4a:0:b0:3f6:b347:6153 with SMTP id
 n10-20020ac85b4a000000b003f6b3476153mr1264420qtw.6.1686301135753; Fri, 09 Jun
 2023 01:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
 <ZCclEE6Qw3on7/eO@snowbird> <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
 <CAPDyKFos3i60U0g0vJstetvLMyouiTpUP8-Jop_LMB9T-ZNU=w@mail.gmail.com>
 <ZII-vJWGb7F97S_A@V92F7Y9K0C.corp.robot.car> <2023060930-uphold-collie-3ec5@gregkh>
 <ZILRw9MBGNwH9NsG@V92F7Y9K0C.lan> <2023060922-nimbly-emblaze-bd6b@gregkh>
In-Reply-To: <2023060922-nimbly-emblaze-bd6b@gregkh>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 10:58:44 +0200
Message-ID: <CACRpkdaGDONmRNASF1UEnKHDrcNYtdHWJFMmqzP998mhc0WfAQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 9, 2023 at 10:53=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Fri, Jun 09, 2023 at 12:16:19AM -0700, Dennis Zhou wrote:

> > As a path forward I can add a command line flag as a bool to handle thi=
s
> > and that should hopefully take care of the regresion aspect to this.
>
> command line flags are horrible and should never be used.  Why can't you
> dynamically detect this type of thing and handle it that way?

If nothing else works, if this is device tree, a machine-specific quirk can=
 be
done:

if (of_machine_is_compatible("vendor,machine")) {...}

Yours,
Linus Walleij
