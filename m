Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4C69B8C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBRIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:37:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D8211E8B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:37:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h10-20020a17090aa88a00b002349a303ca5so221153pjq.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676709429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5y3CQ6Oq+NfQo1eeOF8aNBjdr4Zb7+nGSXVSp36G9Qw=;
        b=sNovteBqQkq61dNwF6w22jxJ76HGJV3xHb44e42MzxrYLhxd7gZdvb4bEwmcr40GlS
         ja78UXoxl7q1OJCqLekl2H4WW5Va9R3od1KYJ9dnq8NDRtcizTlgAJXpLm/fADByKUgs
         XYtk/mqgb5ZKQj5sfDoHHCJorAlDRVq/F1dQdlHdGK/QZwVCHH6SHx/zD6nLkMZDr8FJ
         nZZC8+qi8lF4tuyNzPA2UXxp5OgU7VwSeyd5dmrjxxkP3VNqOveG0e+vHI+s3C5Pt38g
         nC5FZxEVr0OCweDXJ333X95GZ0clNXYQcVNKsZsB6EW5LMYatvmGhO/GQ4kz413isGhR
         Lsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676709429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y3CQ6Oq+NfQo1eeOF8aNBjdr4Zb7+nGSXVSp36G9Qw=;
        b=tTzQR6adfH2LsPnnm6eYAHd9lfu9JtCD8EzPV52QBIweAyE8tIQcAE1Cv4fXUDn7+5
         G4236Xj5jvxOFhygHLpWJjVXiC4ehMGFGYpIxSkOdtn4Q42ZNzoDkAySXihKNFUE6QD1
         BKZNrT+eISOAh/c31SWETI3OvgdyDdG1rkJkD5sDBh2kli9W2xD71RzFmK+dBEpQa0fK
         ULqsOVkPOa/ROSf8ygNUhKqZtzV8sySBBu8vmDqH8J6jA3KjNQ2rdXWryIO6nrExR2DN
         r1SPwFhDQRjRMhqqWqB8qGFT2BEktK3wolKarXEyMzbjchxNKGCvDXf38mjNFACwBA73
         gqqw==
X-Gm-Message-State: AO0yUKXO4Q2lUaypdHw4fC4jHh43hr+9H6OBjj2bZts/AbbXKEcYJqYQ
        4pPLqnSkTFekgtNNCDPWi/A9DBcnhrEh25hZkeF8oA==
X-Google-Smtp-Source: AK7set8gS/8OKapjffNjvbE0Jha0PoYLPBetwuwaNyX10F6ejjlCq+jnfxfHrpkSx5UNkVHWMpROhrz8U6tY6F0OOnc=
X-Received: by 2002:a17:903:328e:b0:19b:c39:3ba5 with SMTP id
 jh14-20020a170903328e00b0019b0c393ba5mr978943plb.29.1676709428256; Sat, 18
 Feb 2023 00:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20230218083252.2044423-1-saravanak@google.com>
In-Reply-To: <20230218083252.2044423-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 18 Feb 2023 00:36:31 -0800
Message-ID: <CAGETcx8iFzHVpwvZ8y+Asq1b6rtfc_-5-FYsvZKWhVPvFm5UsA@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 12:32 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Hi Mark/Liam,
>
> This series is just an RFC to see if you agree with where this is going.
> Please point out bugs, but don't bother with a proper code review.
>
> The high level idea is to not reimplement what driver core can already
> handle for us and use it to do some of the work. Instead of trying to
> resolve supplies from all different code paths and bits and pieces of
> the tree, we just build it from the root to the leaves by using deferred
> probing to sequence things in the right order.
>
> The last patch is the main one. Rest of them are just setting up for it.
>
> I believe there's room for further simplification but this is what I
> could whip up as a quick first draft that shows the high level idea.
> I'll probably need some help with getting a better understanding of why
> things are done in a specific order in regulator_register() before I
> could attempt simplifying things further.
>
> Ideally, regulator_register() would just have DT parsing, init data
> struct sanity checks and adding the regulator device and then we move
> everything else to into the probe function that's guaranteed to run only
> after the supply has been resolved/ready to resolve.
>
> fw_devlink/device links should further optimize the flow and also allow
> us to simplify some of the guarantees and address some of the existing
> FIXMEs. But this patch series is NOT dependent on fw_devlink or device
> links.
>
> Any thoughts on where this is going?
>
> I've tested this on one hardware I have and it works and nothing is
> broken. But the regulator tree in my hardware isn't that complicated or
> deep. The regulators are also added mostly in the right order (due to
> existing fw_devlink). So if you agree with the idea, the next step is to
> ask people to give it a test.
>
> Also, it's based on driver-core-next since that's what I had synced up
> and had a working baseline. I'll rebase it on the regulator tree when I
> go from RFC -> PATCH.
>
> Thanks,
> Saravana
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Luca Weiss <luca.weiss@fairphone.com>

Christian, I was meaning to add you but I forgot. I'll add you to
future versions.

-Saravana

>
> Saravana Kannan (4):
>   regulator: core: Add regulator devices to bus instead of class
>   regulator: core: Add sysfs class backward compatibility
>   regulator: core: Probe regulator devices
>   regulator: core: Move regulator supply resolving to the probe function
>
>  drivers/regulator/core.c         | 102 +++++++++++++++++++------------
>  drivers/regulator/internal.h     |   2 +-
>  drivers/regulator/of_regulator.c |   2 +-
>  3 files changed, 64 insertions(+), 42 deletions(-)
>
> --
> 2.39.2.637.g21b0678d19-goog
>
