Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF7606718
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJTReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJTRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1C1E3EF2;
        Thu, 20 Oct 2022 10:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EB1261CCD;
        Thu, 20 Oct 2022 17:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2001C4347C;
        Thu, 20 Oct 2022 17:33:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dzynx+96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666287232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MhbDUQYtMRdQrM9m9jLwLVDz+Gb6Bbj2nyRKt6zUEQc=;
        b=Dzynx+96fZREa0hAeZjjUXdgKZMQmCXwQ9tM4rOerUDP4vWNiR8vfkQJ/pSiJzFvxa9W7E
        arerSeUhOSDZ+AOuDOnv8088NEDIwN+FXc/5i5QHTIE7vzWg78xLaXzb9IOWtOxVGUe0vA
        zb6hON1j6wAraRWXIrMqvfN8BFXB2ps=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ecf041e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 17:33:52 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id h25so10222491uao.13;
        Thu, 20 Oct 2022 10:33:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf22axImLLj8FiZyM1EBrnzQLWdGkjYtA62Adnsl+mPA0mdPgHfG
        ou3saEQRXtA24FgF/BSenQqcolUaoPec1pPdm0M=
X-Google-Smtp-Source: AMsMyM4zYz12V9544h8LhTytD/IFgrSGb0tWCQfEAgKjFqICkj7B+FJW+E1Nf1M9ctX+OKU+3Nhz8OnHAYz0dtBAKH8=
X-Received: by 2002:a67:ec47:0:b0:3a9:682c:bc5c with SMTP id
 z7-20020a67ec47000000b003a9682cbc5cmr7756711vso.70.1666287230932; Thu, 20 Oct
 2022 10:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com> <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
In-Reply-To: <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Oct 2022 11:33:39 -0600
X-Gmail-Original-Message-ID: <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
Message-ID: <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Oct 20, 2022 at 11:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Can we please try to collect these all in one place?
>
> I see that Andrew picked up the original one for -mm, but I think it
> would be better if we had one specific place for all of this (one
> branch) to collect it all.

Sure. Andrew can drop it from -mm, and I'll collect everything in:

https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=unsigned-char&r

And I'll ask Stephen to add that branch to -next.

> I'm actually trying to do a "make allyesconfig" build on x86-64 with
> both signed and unsigned char, and trying to see if I can script
> something sane to show differences.
>
> Doing the build is easy, but the differences end up being huge just
> due to silly constants (ie the whole "one small difference ends up
> changing layout, which then causes hundreds of megs of diff just due
> to hex constants in the disassembly changing".

If you can get a copy of IDA Pro, diaphora is quite nice:
https://github.com/joxeankoret/diaphora

Or sometimes with objdump, I've had more success by keeping debug
symbols, and then trimming offsets from jmps.

Jason
