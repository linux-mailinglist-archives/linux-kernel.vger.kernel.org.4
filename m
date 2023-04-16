Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426106E3A92
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDPRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDPRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:33:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2AA3A80
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:33:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy21so15436552ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681666417; x=1684258417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0zjlBWrp8mSKGtJRwYtBg2SQIzPO5B3r0sq3wAU/qE=;
        b=g1MD+qYi16eZw6jxHApEFjkbNo956Jcxfz2P9c/kau3fAu/rTglWtMgVp49hBcRqIu
         3EGl/jOu+kTKjKayiKek25wcP7heFIuG7O1ErXo67cSsGTVmfEJINK6BKoof0ViTQueW
         SE7hZm/xsV7LzO80FhgL+NBteCKDPDBlDWqnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666417; x=1684258417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0zjlBWrp8mSKGtJRwYtBg2SQIzPO5B3r0sq3wAU/qE=;
        b=C8bMLRjUKHgN7ubv3FSEGS8gYaY4MyFrES/n5gQM1C8IseeOI7WsOSSBqDmhm+fO3+
         wBy9irT0DZorI72FgXP6A1sESCadZrH+S8sQF8x5iiwFPI4OsIf2jg/y2snl5J3Uhg2n
         EAwko5h1K24AFEXdya9oiYVnPrs3bl1/ejklRibWjHSlLnBt8V5gzIVg5umggPCJ1vH/
         LZB4uLQ3TosG0Ih9H1LmgX8Vt7GpwyR1dPGmJ5ueIgVmBZ7dcE2iRNcTs8oaigToF999
         rRGz1uFWuqtzDGLWkWOHLX8DArEmrO4ULenIFIdUrOAeGe+8yfPVdLuxN6/eVfPncrP6
         PFeQ==
X-Gm-Message-State: AAQBX9c3HNoyxDV0R1f1kXIwF57fcIGoNycaXVo7GrRzelcnAJJBnphc
        bvzGDW7I6/mOqY3eHGOU/Y8hlRIpz4gYIFRaQSAHcQ==
X-Google-Smtp-Source: AKy350Y9Rlmzb9wqgKFUGbIW+s2zccWTyhL9mMF5ugjVijkS8JEzAmffIFDitSQ704Z2pTuPx/ugOQ==
X-Received: by 2002:a17:906:4714:b0:94e:fdec:67e2 with SMTP id y20-20020a170906471400b0094efdec67e2mr4782354ejq.77.1681666417329;
        Sun, 16 Apr 2023 10:33:37 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b0050687f06aacsm2839387eds.12.2023.04.16.10.33.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 10:33:36 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id ud9so58204848ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:33:36 -0700 (PDT)
X-Received: by 2002:a17:907:2718:b0:94b:28ff:9e89 with SMTP id
 w24-20020a170907271800b0094b28ff9e89mr1914743ejk.15.1681666416204; Sun, 16
 Apr 2023 10:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
In-Reply-To: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Apr 2023 10:33:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
Message-ID: <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 5:29=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> - Drop __init annotation from two rtc functions which get called after
>   boot is done, in order to prevent a crash

.. ahh, and our automation to catch these things didn't find it,
because they are only accessed from x86_wallclock_init(), which is
also __init.

So it all looked superficially good, except for the "oh, we saved them
into a data structure that _isn't_ init".

It would require automation much smarter than the one we have to catch
that kind of thing.

             Linus
