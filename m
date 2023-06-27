Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8EB740690
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjF0WoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF0WoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:44:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794BB211E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:44:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51dd0205b2cso23177a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687905843; x=1690497843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62ZMa8IP6rzchtKNliU3xgtrtztxTiRDLodjcE3oYKw=;
        b=B+n6JzSC5idXgfE44FSmmDdBudiS0zYbWvLaq9xowdVCDRYQVO1zmi6gXhHFp+hj+D
         08DdaZK00cxAVDCyXIfHti50mYI8PWry8G4FCuyJPG7NEDveZEH4V/OIfFP36mBGCwrG
         oIl7Hk+jg+7Z/V0uZ7d8C8s8SrmGg1HRRplF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687905843; x=1690497843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62ZMa8IP6rzchtKNliU3xgtrtztxTiRDLodjcE3oYKw=;
        b=MPFGgoI5tnGjnD+aaImIUyGqFzD2IewUOEZ6MucX8qwy+gk/QqqoK6ovbw9/2b+Qai
         RXzGEkRyvv1PP7YV+joJpWDxE6TDCCsx4oJ+X9TFGp4ZBvDPLKDmtfhskp1nWigKDYQe
         IBVQiHjh314jz8a5LEDxqW4CJ47qekntbKccpGeEhjp1YE2ln91C19wausoMNBhFmlzk
         UJmnkO4JAAVKDnMN6roJ7ZiXrYOqkw79ut86o9P9f6Czrmr+lkC3ZBWH+p/vensmlhhM
         iN59Nrmd7E1sUtlGuvPXdvN/bZDY8WRBgDLuR6uDHzWr3hm9U+BKgIF3o/G7/078A9Bi
         JdUg==
X-Gm-Message-State: AC+VfDzFMHvRyBb5drIVDRoQ1AWa+APAKE3rDIcOsElBrxdD/MZRVbSR
        iLW87HGIPl04zpBtoVRsrCgJ1DB/nTP7bXSkM0PM/6xe
X-Google-Smtp-Source: ACHHUZ7RPhS4+1MK2WYfcFtSwTO6VgOnlV9aY3yjfxumQtziPhkIez7NiV6PsHU55PIlMiWc0aFeMA==
X-Received: by 2002:a05:6402:34c7:b0:4fc:97d9:18ec with SMTP id w7-20020a05640234c700b004fc97d918ecmr32994129edc.21.1687905842923;
        Tue, 27 Jun 2023 15:44:02 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id h9-20020a50ed89000000b0051d888df7f8sm3975793edr.56.2023.06.27.15.44.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 15:44:02 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so649612a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:44:01 -0700 (PDT)
X-Received: by 2002:a05:6402:1614:b0:51d:927e:316f with SMTP id
 f20-20020a056402161400b0051d927e316fmr8347079edv.19.1687905841740; Tue, 27
 Jun 2023 15:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <1982e4b4-3858-d456-6c90-92782b95726a@linux.intel.com> <CAHk-=wiQEj1cP7tnQ6Uw1jjFYnZmMdNgodga3b+rw98vBBvENg@mail.gmail.com>
In-Reply-To: <CAHk-=wiQEj1cP7tnQ6Uw1jjFYnZmMdNgodga3b+rw98vBBvENg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 15:43:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMw2VE8afWp4p6RyJKCvnkhNXx4XUByUOHUWKiAo=WLQ@mail.gmail.com>
Message-ID: <CAHk-=wgMw2VE8afWp4p6RyJKCvnkhNXx4XUByUOHUWKiAo=WLQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 15:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't know what the rules are - and some of the functions you test
> seem actively buggy (ie not handling alignment right etc).

Oh. And you *only* test the 40-byte case. That seems a bit bogus.

If I change the packet size from 40 to 1500, I get

  02: 185.1 / 186.4 cycles (8b414316) Upcoming linux kernel version
  04: 184.9 / 186.5 cycles (8b414316) Specialized to size 40
  06: 107.3 / 117.2 cycles (8b414316) New version
  22: 185.6 / 186.5 cycles (8b414316) Odd-alignment handling removed

which seems unexpectedly bad for the other versions.

But those other functions have that 64-byte unrolling, rather than the
"two 40-byte loops", so maybe it is real, and my version is actually
just that good.

Or maybe it's a sign that my version is some seriously buggy crap, and
it just looks good on the benchmark because it does the wrong thing.

Whatever. Back to the merge window again.

              Linus
