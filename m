Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCB6ADF3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCGMzW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 07:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCGMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:55:14 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334307E7B8;
        Tue,  7 Mar 2023 04:54:47 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id ec29so20977901edb.6;
        Tue, 07 Mar 2023 04:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fdy9txgHkVnb0gJq1Nn55ZKwFjS5YdEn+Po646l2Zho=;
        b=NFzechaHlrZxpIk2p2O96twEiC6ARPDejZNaz6Ch6HD8+tJTVqx0fzNUJEOy/ON9gd
         MNPfdWvk8jT2z5/g4x5mOGW/UCvrOCxQM4NI7DSkEkdg6DKh0pUjO6E2i30w63j+Nwkw
         YUPMa1WI6hOGMtT3K4QIJNbGVviyCPrynKTkUCYzYPy8QFCDBrKw/oBCyftSMBHxsikk
         Y30aDmMfe9xG6KD4EYLq6CjvGWL2u+PqXMJviOw5s/jXJXonGt6w+KCIQFIw0OpTs6R2
         pc0rJriNwZzxw1rgjNlNBIIrMVoGo4yPGGvu95Awi1lYKKukXTeRJe3uaLQ7yphEYjy6
         yElQ==
X-Gm-Message-State: AO0yUKVhTQyBzc1uBTCDd7ueY/f+wp4HJLAuwIrHHdmMtlG83NaPdAoB
        8jcOcbAMiTvACb0wGTOn6rlgIKQG6XXFRK6161DSHqTeCvk=
X-Google-Smtp-Source: AK7set+YZY8jaCXbWSyqKj9VkWntOcBFPP1HyiH/uTbADcJoW3fzHIiDs71WAoDG4iY0gXXLzQ0/mrpWnETTLWRMMYk=
X-Received: by 2002:a50:9b56:0:b0:4ae:e5db:abfb with SMTP id
 a22-20020a509b56000000b004aee5dbabfbmr7963114edj.3.1678193685649; Tue, 07 Mar
 2023 04:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20230223044550.339811-1-luoxueqin@kylinos.cn> <CAJZ5v0jyz_dpKW1GhWN=yYpR9-7WG33GbZ65aoGv+B+R9vEpEw@mail.gmail.com>
 <5b22ef4c-d0a6-5f28-7f71-e4de67d97b87@kylinos.cn>
In-Reply-To: <5b22ef4c-d0a6-5f28-7f71-e4de67d97b87@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 13:54:34 +0100
Message-ID: <CAJZ5v0jCKWh3=Oxq03hY1Ggp13hLnYuUM=JsmWY36KysPV4uPw@mail.gmail.com>
Subject: Re: [PATCH -next] PM: tools: add "CPU killed" timeline on arm64 platform
To:     luoxueqin <luoxueqin@kylinos.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        todd.e.brandt@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 3:27 AM luoxueqin <luoxueqin@kylinos.cn> wrote:
>
> 在 2023/2/24 02:11, Rafael J. Wysocki 写道:
> > On Thu, Feb 23, 2023 at 5:46 AM Xueqin Luo <luoxueqin@kylinos.cn> wrote:
> >>
> >> On the arm64 platform, the core log of cpu offline is as follows:
> >
> > Please spell CPU in capitals.
>
> Thanks for pointing out my mistake.
>
> >
> >> [  100.431501] CPU1: shutdown
> >> [  100.454820] psci: CPU1 killed (polled 20 ms)
> >> [  100.459266] CPU2: shutdown
> >> [  100.482575] psci: CPU2 killed (polled 20 ms)
> >> [  100.486057] CPU3: shutdown
> >> [  100.513974] psci: CPU3 killed (polled 28 ms)
> >> [  100.518068] CPU4: shutdown
> >> [  100.541481] psci: CPU4 killed (polled 24 ms)
> >>
> >> 'smpboot: CPU (?P<cpu>[0-9]*) is now offline' cannot be applied
> >> to the arm64 platform, which caused the loss of the suspend
> >> machine stage in S3.
> >
> > I'm not exactly sure what you mean by "loss of the suspend machine stage in S3".
>
> I made a mistake in saying "loss of the suspend machine stage in S3",
> please allow me to correct it. Because the original program only
> recognized the "CPU up" action on the arm64 platform, in output.html,
> "CPU up" was classified as the "suspend machine" stage. Adding this code
> can put "CPU killed" and "CPU up" in the correct position.

It is still somewhat unclear to be honest.

What does "the original program" above mean?  sleepgraph.py before the patch?

And IIUC the goal of the patch is to prevent sleepgraph from
mistakenly treating the "CPU up" message as part of the suspend flow
(because it should be regarded as part of the resume flow).

If my understanding above is correct, please update the patch
changelog accordingly and resubmit the patch.
