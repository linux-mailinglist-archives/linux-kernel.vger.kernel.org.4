Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89723727318
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjFGXhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjFGXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:37:09 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C8B26B3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:37:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33e60900753so6396885ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181020; x=1688773020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG+ft0QEOw+l4T57sY6QqoB2Q4VLY5mgSyLH0/dKkXM=;
        b=H+m5kxNTbGoVk78FzKfZhoPIgVoNdHsnbls1bZSIkiEdIZJkrTDZMb3ZGJnSAmKkat
         mwa3mMKRCUNoanz7UTX9yxQZwY/5GTMQ5jlU5KlLzTv9zjdAQWHHcKEJ7CkvsALGymrr
         5F9Wg2tW3LK83Aru1NM2GfAx1o2WJavrGvPng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181020; x=1688773020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG+ft0QEOw+l4T57sY6QqoB2Q4VLY5mgSyLH0/dKkXM=;
        b=d8zuWytBI0tQax0D02PVt95kWqMXsMM0jcHDGIPRcR9f6SBfk843igYrg829XHcuNe
         piahGgG5wx+snu4WQyoftVZpsH9q52hQe1E6n44SlA2nH9b0p4xBIt/0Zu83zT7zV1UL
         4K4YjLpI8Wx//SxqjvJIUCCRfF32NNiI4+MIIz0NrIbPjTcWMw3hnVqUx5TcsF0xOglB
         gLQAFUIgp2s03Jy+52QZYMAlSXAnM6A07qOIyRbsRwbjtocl1QO84O6kdtA0ffaLgLeI
         JWZ7Qw7uTBraAF/eCkAPcIiiC2LWiKDTPLxLXcXHwuU+GuDSEd2h1wjdNAcajg1TMTUS
         4r1Q==
X-Gm-Message-State: AC+VfDzLhM7nfJ9QvDfkOyp8bbYkiR/OmwO6xmrq8glEpRXZEeR+r6dz
        nSlPk7V569J3z8tB9AKFg/EQyDCfV0LGgrJ0x5w=
X-Google-Smtp-Source: ACHHUZ6Q7HbgvzpOIUA+RcIn6BzfVE3/wnSUhTGB4K34gZeKsnTXJrDo+AWlrNNaKwBKsf/5K7ckHQ==
X-Received: by 2002:a92:d709:0:b0:33d:85c3:93ee with SMTP id m9-20020a92d709000000b0033d85c393eemr9295694iln.17.1686181019913;
        Wed, 07 Jun 2023 16:36:59 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id b12-20020a029a0c000000b004090c67f155sm1618219jal.91.2023.06.07.16.36.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:36:55 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33dea7d5424so26155ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:36:55 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c4c:b0:33d:8238:80c6 with SMTP id
 d12-20020a056e021c4c00b0033d823880c6mr101962ilg.9.1686181015033; Wed, 07 Jun
 2023 16:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-6-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-6-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTKR42i8hozXSfSHu07TQ7g1TJQs8dqpqGHHraZr+-vQ@mail.gmail.com>
Message-ID: <CAD=FV=VTKR42i8hozXSfSHu07TQ7g1TJQs8dqpqGHHraZr+-vQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] watchdog/sparc64: Rename HAVE_NMI_WATCHDOG to HAVE_HARDLOCKUP_WATCHDOG_SPARC64
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> The configuration variable HAVE_NMI_WATCHDOG has a generic name but
> it is selected only for SPARC64.
>
> It should _not_ be used in general because it is not integrated with
> the other hardlockup detectors. Namely, it does not support the hardlocku=
p
> specific command line parameters and systcl interface. Instead, it is
> enabled/disabled together with the softlockup detector by the global
> "watchdog" sysctl.
>
> Rename it to HAVE_HARDLOCKUP_WATCHDOG_SPARC64 to make the special
> behavior more clear.
>
> Also the variable is set only on sparc64. Move the definition
> from arch/Kconfig to arch/sparc/Kconfig.debug.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/Kconfig             | 12 ------------
>  arch/sparc/Kconfig       |  2 +-
>  arch/sparc/Kconfig.debug | 12 ++++++++++++
>  include/linux/nmi.h      |  4 ++--
>  kernel/watchdog.c        |  2 +-
>  lib/Kconfig.debug        |  5 +----
>  6 files changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
