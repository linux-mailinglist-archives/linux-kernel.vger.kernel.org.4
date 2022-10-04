Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026F5F4519
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJDOEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:04:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78D5D0C5;
        Tue,  4 Oct 2022 07:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2EECB81A93;
        Tue,  4 Oct 2022 14:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B20C433D6;
        Tue,  4 Oct 2022 14:04:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K46wjlS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664892239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8Id8SmAbYgSzlRRtwgUO/TtxBOviRpHBZddWECEq2I=;
        b=K46wjlS/l4KOKURP2/0mX7GNXXR/Z94jbhpvE0ZlPrwO9ZB4ssnLEUe8ON7WIdBNK9x+08
        8F/jSDg7zLOIh/HSX0i4nMlfiA1qhdPWHIvnrmB6ING00EaPbqZ8nCsMz5Jo6QxoD6PR43
        0mvgoAkOZmNqGZK8Rbmr7M6hZu0vZq8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id df5e732b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 4 Oct 2022 14:03:59 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a2so8988929ejx.10;
        Tue, 04 Oct 2022 07:03:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf2JtsC8nj0fuAAAXIyAB6t1dYU5UKA/Hc793RaAyZhYsub5tQhB
        vHQQkGWLkI+//Uv7cwrj0LefpYkkynYUM3W9Huk=
X-Google-Smtp-Source: AMsMyM4joupZEHi7vuP/nbi8LX5jsPLs+j4kLhNEf7ea5moim3iP4hpm2Xq8rRUKIRMwHVxRk/mN75sEZ+d0WlDUNyM=
X-Received: by 2002:a17:907:72c6:b0:78c:b48c:5136 with SMTP id
 du6-20020a17090772c600b0078cb48c5136mr5437335ejc.359.1664892233100; Tue, 04
 Oct 2022 07:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjwvBc3VQMNtUVUrMBVoMPSPu26OuatZ_+1gZ2m-PmmRA@mail.gmail.com>
 <20221004135301.1420873-1-Jason@zx2c4.com> <CAKXUXMyvk6WJr2M09+=D43QocX_igoaU0-qMN-MCwQk++O=vwA@mail.gmail.com>
In-Reply-To: <CAKXUXMyvk6WJr2M09+=D43QocX_igoaU0-qMN-MCwQk++O=vwA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 4 Oct 2022 16:03:40 +0200
X-Gmail-Original-Message-ID: <CAHmME9oSAMesW_5rQ0LM7u-yHCtKgn6THZCOEZ9DHKaSAri7dQ@mail.gmail.com>
Message-ID: <CAHmME9oSAMesW_5rQ0LM7u-yHCtKgn6THZCOEZ9DHKaSAri7dQ@mail.gmail.com>
Subject: Re: [PATCH] alpha: remove osf_{readv,writev}
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 4:02 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Tue, Oct 4, 2022 at 3:53 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > As of 987f20a9dcce ("a.out: Remove the a.out implementation"),
> > sys_osf_{readv,writev} is now the same as sys_{readv,writev}. So remove
> > the osf indirection, and point the syscall table directly at the generic
> > functions, as is done on other platforms.
> >
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Only compiled and QEMU-booted with no userspace, but seems simple
> > enough?
> >
>
> This patch looks exactly the same as the patch I sent a few hours ago:

Whoops, my bad for not searching first.

Jason
