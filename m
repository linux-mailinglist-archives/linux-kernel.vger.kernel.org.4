Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE26EB239
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjDUTWm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjDUTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:22:39 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819D1FD8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:22:38 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-2f4b604e234so278196f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104956; x=1684696956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUembD9ev3Hoip74sAiYeM3z91MrB5ebVpCIuBe3k1A=;
        b=CCOHaBG6n+OMkF1jGW5+geGHxz3BrEfcEouiOuAsm1nhmHeg6SrNR2IOZliqytOkzb
         gbEm8PCMWF5nkDT3F7lyct2Cy51JKd2BvWfvQZJIstn2HTHoSd5/Sw/xQ9IcNYT9m05c
         E+CDSn3XNn2YW/hct1LLeVoqfIKs75PKH8RiGPWcsMH5Eq3NvhdpQ7cZ3AV53yS6hOmx
         JUqI0rdCs9yVN8UmfOpImQnvTWekiCz3qHP18d7sGXgF185KadzwxWtkyDYQD1DhJ3Ut
         pJUEX6nvt0W98aTjA6AzNTYN7iW+5Jh1nCuOd6YE2LL2GksWthISpMVtwiemUTqt8DMD
         SgXA==
X-Gm-Message-State: AAQBX9c2ND/xOzSHv5pyweEmfwfwBANQ9PsylTQpBioHcrFuYYWCd/MU
        ahhG4yuazz1WAz9MvkVGtb43fKsh7Y7N239Rw70=
X-Google-Smtp-Source: AKy350ZLRWzS3+IhEK7gF+tkQSEr74SBX+E6ZwQNQWvti8OT6KYpmTdjdT8KGejrQ/YPsC7dEfuj5qnDe6WR/A1kTio=
X-Received: by 2002:adf:f1ca:0:b0:2f8:15d8:e627 with SMTP id
 z10-20020adff1ca000000b002f815d8e627mr4020345wro.7.1682104956428; Fri, 21 Apr
 2023 12:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
 <CAJZ5v0j_MwW6JaqTRNhmz=LcW8==GZ0X-=W0+z0tOsGQyDd0Dw@mail.gmail.com> <b51f571a-d6b2-1908-d94a-bc0b2a751905@leemhuis.info>
In-Reply-To: <b51f571a-d6b2-1908-d94a-bc0b2a751905@leemhuis.info>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Apr 2023 21:22:24 +0200
Message-ID: <CAJZ5v0j+VieZvQUXtyEJg47oggji2zgcJ6W9Mnge9Xz867QTJQ@mail.gmail.com>
Subject: Re: the wake-on-lan regression from 6.2 (was: Re: Linux regressions
 report for mainline [2023-04-16])
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 3:49 PM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 17.04.23 13:38, Rafael J. Wysocki wrote:
> > On Sun, Apr 16, 2023 at 10:49 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> On Sun, Apr 16, 2023 at 10:59 AM Regzbot (on behalf of Thorsten
> >> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>
> >>> Wake-on-lan (WOL) apparently is broken for a huge number of users since
> >>> 6.2 was released[1]. This is known for 8 weeks now and about 4 weeks ago
> >>> it was bisected to commit 5c62d5aab87 ("ACPICA: Events: Support fixed
> >>> PCIe wake event") we immediately could have reverted. The developer that
> >>> looked into this was even willing to do the revert late March, but then
> >>> got discouraged by a maintainer [2]. But well, a fix was apparently[3]
> >>> finally posted for review last week (to the acpica-devel list); with a
> >>> bit of luck your might get it next week. Still a bit sad that 6.2 is
> >>> broken for so long now, as Greg wants to see it fixed in mainline first.
> >>>
> >>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217069
> >>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=217069#c50
> >>> [3] https://lore.kernel.org/all/754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn/
> >>
> >> I find that bugzilla discussion very confusing, it's not clear what
> >> the status of the patch actually is.
> >>
> >> And the sane lkml thread just says "the patch is under review" without
> >> actually saying *where* said patch is, or where the review is.
> >>
> >> It sounds like it got perhaps into some internal ACPCICA queue? None
> >> of those links are very clear on any of this.
> >>
> >> Rafael?
> >
> > There is a pull request for ACPICA that corresponds to this (IIUC),
> > https://github.com/acpica/acpica/pull/866
>
> Rafael, what happened to this?

It will get fixed, most likely by reverting the offending commit and
most likely during the 6.4 merge window.

Note that ACPICA is involved, so the analogous revert needs to be
submitted there and I'm traveling right now.

Thanks!
