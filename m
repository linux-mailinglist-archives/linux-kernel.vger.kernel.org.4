Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E606553CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiLWTVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiLWTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:21:10 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96CA15FF6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:21:07 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so3725869qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FNOI+4YsCoriXa+jAbkfl0PAV9y45Z4GDfwb84r0IxM=;
        b=EH3VOEn4KiBrDh9Eayqn7WPIGvMVTZEKsGw8EeIXGaR8IgpGLa8b+Wg+EtzOmefIpy
         TD0Cy5trn/PiNHqEeLrPjGMuhZWsOq/6H3UwaWaYwrZuD4mmyKZu0QQhLUZlT1xU0LEV
         MCUBlGeOhcO4JUQ50ADbHYl2i6Q6zGCtWe66Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNOI+4YsCoriXa+jAbkfl0PAV9y45Z4GDfwb84r0IxM=;
        b=hSqf4w23wN0TQdwOTwT+bcEaTG/r+180Cn3kyWf65AgEOvePU/gsXvLO/vcj+TRD4O
         OKJspMGAuHEKS/DwWCPiwSvAytmS3Z2VqYjKbaNryxeV0fqIlm1FkJ+IP0FIk2tWoMIJ
         wzp51V3Wn4g8xVVZRaW1sI3LTAtVrUuFX4Z/0O41PZuNjBGMxa87K4tX2D/bkBGgXyaY
         3zIz0XgtlSSe+KWBEENLurFT9NELIzMc5le3WVTVFKYY31gyBUtssSUe2xdEqd8cMxUe
         TC7mnKnwFEMFEx/2IXwv1BPc02U/uQwP2AfHyFKOmy/tM0slp7zNXxbw4riMoC4Rxqbm
         5SEA==
X-Gm-Message-State: AFqh2kqxlMOFl/U5l+LyNfvFBgKx6dQ3JyzGvXK3ZjIDRKO5Xbflv8og
        x4ssn3sJZudPdzPlXyL3xP4kwd46aGozID7u
X-Google-Smtp-Source: AMrXdXu0Y3ktkSUOWsLwpW7tY2xfe+4Z8TFqpIsMztgTa4c4/Kfq0Ttf+aYYHfv+z29fx6fwf1ppiQ==
X-Received: by 2002:a0c:fe64:0:b0:51e:e977:8b80 with SMTP id b4-20020a0cfe64000000b0051ee9778b80mr13043362qvv.29.1671823266798;
        Fri, 23 Dec 2022 11:21:06 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id q27-20020a37f71b000000b006cec8001bf4sm2693302qkj.26.2022.12.23.11.21.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 11:21:06 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id i2so1982509qvq.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:21:06 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr458369qvv.130.1671823265794; Fri, 23 Dec
 2022 11:21:05 -0800 (PST)
MIME-Version: 1.0
References: <87y1qy2yit.wl-tiwai@suse.de>
In-Reply-To: <87y1qy2yit.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Dec 2022 11:20:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgB054c1hX=2xco+S38cJQVZrj8ukSShLkM359THFQ2+Q@mail.gmail.com>
Message-ID: <CAHk-=wgB054c1hX=2xco+S38cJQVZrj8ukSShLkM359THFQ2+Q@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 6.2-rc1 (#2)
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 2:41 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> A few more updates for 6.2 since the last PR: most of changes are
> about ASoC device-specific fixes.
>
> - Lots of ASoC Intel AVS extensions and refactoring

Hmm. This doesn't exactly seem to be fixes.

It does seem to have been in linux-next, so I don't hate it, but I'm
not super-happy about the timing of this all.

I really was hoping that the last few days of the merge window had
been for actual fixes rather than for new development.

                  Linus
