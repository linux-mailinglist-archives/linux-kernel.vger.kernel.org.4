Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B990C6E9C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjDTTjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjDTTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:39:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579662137
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:39:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so1306346a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682019577; x=1684611577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HILdVpnxn60sz/1+sruxM2PcPSxjEhfqFGF21BfXJgw=;
        b=Z0Lfl9rFznZK4+XC+YnJ7OGtVVP93xBVIgp8L5wPabiyMHayvEMcGTYqR1eg349HZ8
         m/QouQ721ax/Eo9Xrn038i8idFWh6bm/Q1FKDYnjfWbxh+J4nB015gI0zdPunVznSNzb
         LhsuFG6RmoMIpiTDav3CJhrMXYmFkjdfKh0ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019577; x=1684611577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HILdVpnxn60sz/1+sruxM2PcPSxjEhfqFGF21BfXJgw=;
        b=PN+EA1qIjtWNfvAeVrILof2H0NrmhVdFklW1uKl+0hULRgLUtvqemotASL1JYos5vK
         7OZ4mw+HsE8keaXADJ+WewjqdkcRMGXaTsDg6rmVOQsvcHbrzIwDQDw+2OPR4BytB1P5
         X0dBjXryZtcR5e8ASZJXsftKSF8yplHrA+CEZNtpatqp+KYgyc03DWkXTuRrA7qXftkj
         kF3eeX3nv6xJGoXN3ipb0YO4eKnN5xbeWaaZeY3J1p6rMfhZZUXU6wVBsJce4ZqLUQHz
         KsKxgqCo8jJewyBJJzvjGwZGKg0tJGPaP7dNoc4ga4VplJXqfZ8nqutTmAtVr2re5Z3N
         9rzw==
X-Gm-Message-State: AAQBX9ffWBLNHmy7zlDuQjXgIFipJWk14OJtaXuYUNrY2KrOZVgiZaLh
        KLK+kD94oe8j+MTaKozTO6l8547P7c69de2zmrnqWQ==
X-Google-Smtp-Source: AKy350afi4aFBxyMtQOgWwHow6Ol4+6IZk/DK+Ze5VtVGEwVOIFz/BORiM7ijJ6CpHltbMwULSBNFg==
X-Received: by 2002:a17:907:1c86:b0:94f:81c:725e with SMTP id nb6-20020a1709071c8600b0094f081c725emr38080ejc.59.1682019577092;
        Thu, 20 Apr 2023 12:39:37 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709061e8600b0094776b4ef04sm1115577ejj.10.2023.04.20.12.39.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 12:39:36 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso1314916a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:39:36 -0700 (PDT)
X-Received: by 2002:aa7:cc98:0:b0:506:b120:8df2 with SMTP id
 p24-20020aa7cc98000000b00506b1208df2mr2667877edt.12.1682019575666; Thu, 20
 Apr 2023 12:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
 <20230418182036.GS19619@suse.cz> <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
 <20230420190239.GX19619@suse.cz>
In-Reply-To: <20230420190239.GX19619@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Apr 2023 12:39:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwWaoeL-PGSWbfAHipORoiiQN0CJEehQyTt8NB+WRKgg@mail.gmail.com>
Message-ID: <CAHk-=wgwWaoeL-PGSWbfAHipORoiiQN0CJEehQyTt8NB+WRKgg@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-04-16]
To:     dsterba@suse.cz
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rafael Wysocki <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 12:02=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> No, the main concern is if discard works without destroying data,

I actually ended up googling it, and I'm a lot less worried now,
because at least according to my limited searching it seems like
Windows enables trim by default at least since Win10.

Of course, I also found some conflicting statements claiming that USB
drives aren't considered SSDs, so who knows. But it does seem like
probably new hardware ends up getting tested for trim, and the bad
situation is likely really limited to only the bad old days.

So together with Fedora having apparently enabled timed auto-trimming
for some time, I guess I will just have to believe that the world has
turned into a less dark and scary place than I thought it was.

Knock wood.

            Linus
