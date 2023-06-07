Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1972730C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFGXel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFGXei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:34:38 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAFC10F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:34:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33e4e59da95so8126545ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686180874; x=1688772874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKEziAGkCW2jO8QMx9VTvzfLmO/bLdAIdfdMBgrtF0Q=;
        b=F6wdPzX5FUDEq0AnubAA0X0oRetMIiPWDnCmAd7XJ7qbkBXIQqOUAfDYB/XoT80xhV
         3geAQrbCc6Er52EjNMUsfbQc3ILUnH0//avnz8c5O+0MdNWqhWcsMkG8UX69MmVNxvFJ
         vkkbkVW1pnxPONFY6dZLVQpGAhXMjj2z4mswI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180874; x=1688772874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKEziAGkCW2jO8QMx9VTvzfLmO/bLdAIdfdMBgrtF0Q=;
        b=VM8KqsJo6cPyv3/F1x51QDw5gIU1AbOKh+MUej92IuMUL8pjTC6hp2vKQ0AZ7XguZS
         4Mppm6hOjRGn6NVp/Kms+YmP/IH0YCSNBZ0FMBG/TB9ZYFDIcOwkxJ045vIUykblHO39
         8NOPbymHRQzQksPcL6p4efOmYjjbzjQSpiF2SroEvyS89kiMwCBm0rMe6VV1ht6iMJlf
         G7Db/tVEaLPx1OZxbP4f2porFBj+q5TwdNjU+lIa9LTlRk2TKIYd2R/zAtnCwwADt6E5
         7QWXcL32l5voX7f4yK5tD/vrwMn4ps50QrmXFYAhKGokIDOreHHWbW1/R11hWIvrlhg8
         P6Ag==
X-Gm-Message-State: AC+VfDzFHilV0rmxsmrV5JU8VSENy/AlDnRdQKHKMNBtg/HwbSubFwI7
        eWo2o7doksjVytTTHV7aY+DQZsUjoP5+jHsW+HE=
X-Google-Smtp-Source: ACHHUZ7UNtcaTqWnuhbWeU2nC3lN3aUZAdNam1+BatrWY1RK/E1yK6Bp1zS5VFAab6CYeppzT6UehA==
X-Received: by 2002:a92:d410:0:b0:33b:38a3:cf57 with SMTP id q16-20020a92d410000000b0033b38a3cf57mr10120609ilm.4.1686180874286;
        Wed, 07 Jun 2023 16:34:34 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id g17-20020a05663811d100b004161fafff97sm3646596jas.136.2023.06.07.16.34.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:34:33 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so56345ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:34:33 -0700 (PDT)
X-Received: by 2002:a92:c26d:0:b0:338:9f6a:d54a with SMTP id
 h13-20020a92c26d000000b003389f6ad54amr93121ild.24.1686180872621; Wed, 07 Jun
 2023 16:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-2-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-2-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:34:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4Sp=ZE4DWob-W0NzRm00K7wOWxyyCCaHUHNPPinsjhg@mail.gmail.com>
Message-ID: <CAD=FV=X4Sp=ZE4DWob-W0NzRm00K7wOWxyyCCaHUHNPPinsjhg@mail.gmail.com>
Subject: Re: [PATCH 1/7] watchdog/hardlockup: Sort hardlockup detector related
 config values a logical way
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
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

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> There are four possible variants of hardlockup detectors:
>
>   + buddy: available when SMP is set.
>
>   + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.
>
>   + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.
>
>   + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
>         and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> Only one hardlockup detector can be compiled in. The selection is done
> using quite complex dependencies between several CONFIG variables.
> The following patches will try to make it more straightforward.
>
> As a first step, reorder the definitions of the various CONFIG variables.
> The logical order is:
>
>    1. HAVE_* variables define available variants. They are typically
>       defined in the arch/ config files.
>
>    2. HARDLOCKUP_DETECTOR y/n variable defines whether the hardlockup
>       detector is enabled at all.
>
>    3. HARDLOCKUP_DETECTOR_PREFER_BUDDY y/n variable defines whether
>       the buddy detector should be preferred over the perf one.
>       Note that the arch specific variants are always preferred when
>       available.
>
>    4. HARDLOCKUP_DETECTOR_PERF/BUDDY variables define whether the given
>       detector is enabled in the end.
>
>    5. HAVE_HARDLOCKUP_DETECTOR_NON_ARCH and HARDLOCKUP_DETECTOR_NON_ARCH
>       are temporary variables that are going to be removed in
>       a followup patch.
>
> The patch just shuffles the definitions. It should not change the existin=
g
> behavior.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/Kconfig.debug | 112 +++++++++++++++++++++++-----------------------
>  1 file changed, 56 insertions(+), 56 deletions(-)

I don't really have any strong opinions, so I'm fine with this. In
general I think the ordering I picked tried to match the existing
"style" which generally tried to list configs and then select them
below. To me the existing style makes more sense when thinking about
writing C code without having to put a pile of prototypes at the top
of your file: you define things higher in the file and reference them
below. For instance, the old style (before any of my patches) had:

config SOFTLOCKUP_DETECTOR:
  ... blah blah blah ...

config HARDLOCKUP_DETECTOR_PERF:
  select SOFTLOCKUP_DETECTOR

config HARDLOCKUP_DETECTOR:
  ... blah blah blah ...
  select LOCKUP_DETECTOR
  select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF

Your new style seems to be the opposite of that.

-Doug
