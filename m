Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB3727320
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjFGXhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjFGXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:37:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180662696
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:37:26 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-777ac4344f9so161429139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181044; x=1688773044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKF2b8Vjs6mvxh6WU02Nj8q7SFKUM+Iw8gQlZJ28woQ=;
        b=EEFYaizhOn141ODmI1VcgOutDljtqbPi2/+5/KAPqLAuVJW+svDjE49OCTh8R/zdRw
         U6HbMDinhcPgIjBqtHjlmRPgzOmhuYNtOoVnV6G8WG3skZXcsD6YRvVjYVKOnsAze3mV
         X8P7l2+KW3UWD6/85EoAtYupgox3VtF9dfkBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181044; x=1688773044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKF2b8Vjs6mvxh6WU02Nj8q7SFKUM+Iw8gQlZJ28woQ=;
        b=j+yMycelIu7jBKtjimQpqRO+zYJPbmw3KMpcljFivmdjgEh1xZckgnVNhYpCCQ4SHV
         w19y0Sso9I2GPCG9lJ7GkzBpkrCFsWSP8NJlmQwH3TizHd+Ajr9qQHbYZ4y6rXDoO/CL
         iLrqhh7t1aeozj0qFaFO/k6mmsUVoHMtb6haMQqARJY5us3zxMB370hK8mqj0SWMzZe6
         4yY+5C+Di+5EBGvennQaAVtYphMgQGhe230ODXLyfTtRc0HmulzwTm6psr6u6YqP/syp
         vPjI1TluQNWPjg1yDBkxlYIGM9tbv1LsPo5uhoWGvLnBOQZQ+5kF6ho6BreJgNhF1642
         Fjmg==
X-Gm-Message-State: AC+VfDytS+XWQR4sMFVGZIuuA/HfxfmYd+jtqLWMyv6oqGSZWgo2eI4W
        7IayPgjdwyMkAPcvme+2cY0r2LeQ3rJ950PuLrs=
X-Google-Smtp-Source: ACHHUZ6VRp3wUe7Ypu2pJxWhPFVdL4AJKT56NqM43wol2ROVeVucSj5+h6RGJKLwo9qPbnXuuubHmA==
X-Received: by 2002:a6b:919:0:b0:76c:8877:861d with SMTP id t25-20020a6b0919000000b0076c8877861dmr6969937ioi.1.1686181044428;
        Wed, 07 Jun 2023 16:37:24 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id s6-20020a5eaa06000000b0077a1b6f73b9sm264853ioe.41.2023.06.07.16.37.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:23 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so26285ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:22 -0700 (PDT)
X-Received: by 2002:a92:cda5:0:b0:338:1993:1194 with SMTP id
 g5-20020a92cda5000000b0033819931194mr7952ild.2.1686181042584; Wed, 07 Jun
 2023 16:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-8-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-8-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:37:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
Message-ID: <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
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

On Wed, Jun 7, 2023 at 8:26=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> @@ -1102,6 +1103,14 @@ config HARDLOCKUP_DETECTOR_BUDDY
>         depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
>         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
>
> +config HARDLOCKUP_DETECTOR_ARCH
> +       bool
> +       depends on HARDLOCKUP_DETECTOR
> +       depends on HAVE_HARDLOCKUP_DETECTOR_ARCH
> +       help
> +         The arch-specific implementation of the hardlockup detector is
> +         available.

nit: "is available" makes it sound a bit too much like a "have"
version. Maybe "The arch-specific implementation of the hardlockup
detector will be used" or something like that?

Otherise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
