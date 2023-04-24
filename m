Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC96ED043
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjDXOZM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjDXOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:25:01 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE5114
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:25:00 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso133309466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346298; x=1684938298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iPDVN2JRvAs5aBXvDi0v6AAx42pZdYcsBFV+oN7Sro=;
        b=XJVNFdCXj3lOPxHYXi5Xu6Niaxe+MCIyC2/6+IYoZfqhRwiaFSxqg///31DAunAOWf
         hq9vu5kOeR9RiWbdwQWes9xyQyl3vm93TmJ3p98D/VGw3cADdOGuc7IIEiINLK762y7y
         VCRuRmNtnPooJKE1OTogwh2F1Mp1yc5JvVCa+B9LS2AW3cZ3/07WF3ZOa2FcigZmdZBl
         yjyje57zh0xNbCP6zrsVmHXze3c1FrTp8UET1QDvu8PIGzAiM9mCQp6XQQYo2A8gVi8c
         B7vWKyU5LWY1VUuZ16lXy4+n50IDCbGFm8dDIfNWspRp4SN/+0V4tZgirvHB7II0OCYT
         naIA==
X-Gm-Message-State: AAQBX9c9lJOkZ1uv8ufeKdt0rHR8RESRMfjz5xO6tEaphBgoXS7+M461
        YftN64vb1zXKdlA3OZYADFT+iI2O0VBuZajz9f0=
X-Google-Smtp-Source: AKy350ZCeSYhWrQ72tvK73ERvNG92qwB5cxgU2R3y8X36I//xTYq1VhY110Y7Fxl5AXYolbqZGjaI65XSXtylBSw/7k=
X-Received: by 2002:a17:906:a246:b0:94f:4ec3:f0e8 with SMTP id
 bi6-20020a170906a24600b0094f4ec3f0e8mr10421243ejb.4.1682346298426; Mon, 24
 Apr 2023 07:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
 <CAJZ5v0j_MwW6JaqTRNhmz=LcW8==GZ0X-=W0+z0tOsGQyDd0Dw@mail.gmail.com>
 <b51f571a-d6b2-1908-d94a-bc0b2a751905@leemhuis.info> <CAJZ5v0j+VieZvQUXtyEJg47oggji2zgcJ6W9Mnge9Xz867QTJQ@mail.gmail.com>
 <CAHk-=wgD98pmSK3ZyHk_d9kZ2bhgN6DuNZMAJaV0WTtbkf=RDw@mail.gmail.com>
In-Reply-To: <CAHk-=wgD98pmSK3ZyHk_d9kZ2bhgN6DuNZMAJaV0WTtbkf=RDw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Apr 2023 16:24:41 +0200
Message-ID: <CAJZ5v0jVoUQAuW6GAE1tkW616F9x_0SK21BvtcqGzhLjVx02cQ@mail.gmail.com>
Subject: Re: the wake-on-lan regression from 6.2 (was: Re: Linux regressions
 report for mainline [2023-04-16])
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
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

On Fri, Apr 21, 2023 at 10:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 21, 2023 at 12:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > It will get fixed, most likely by reverting the offending commit and
> > most likely during the 6.4 merge window.
>
> No.
>
> It's now reverted in my tree.

Thanks for taking care of this and sorry for the trouble.

I was traveling Fri - Sun and I wouldn't have been able to push the
revert myself before today.

> We're not doing *another* release with this known-broken garbage. It's
> been pending for much too long already.
>
> Known-broken commits either
>
>  (a) get a timely fix that doesn't have other questions
>
> or
>
>  (b) get reverted
>
> Not this kind of "this is broken, has been known to be broken for a
> long time, people have bisected it, and we're just sitting here
> wondering what to do".
>
> > Note that ACPICA is involved, so the analogous revert needs to be
> > submitted there and I'm traveling right now.
>
> No, we're not waiting for "it's broken in the ACPICA tree" and using
> that as an excuse to have a broken kernel.
>
> If the ACPICA tree can't get their act together in two months, that's
> their problem. It does not mean that users should need to suffer known
> issues.

OK, in the future I'll deal with problematic commits coming from
ACPICA more timely without waiting for upstream.
