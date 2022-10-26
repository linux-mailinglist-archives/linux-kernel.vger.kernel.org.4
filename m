Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD160D8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiJZBum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiJZBuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:50:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFAA647CB;
        Tue, 25 Oct 2022 18:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FEE4B81FE5;
        Wed, 26 Oct 2022 01:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F465C433C1;
        Wed, 26 Oct 2022 01:50:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ihTYGQYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666749029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RppiKIM3FlruZlipAagRosffDnLqFThdR78mCXaAuuk=;
        b=ihTYGQYESOguenYCyeNj3/jeBkWl4DXB1wU1gMdSPBvNQGvC0XVaeZ0jAjocW5yi0vpeAp
        y3b7ho6BC6QjK9p2KfdNHSMjDkcsYRC5UpwZpxGTq6RZoLtFk+nbKR9WyGIx2XObL+MC7e
        ztuqb8tEpsSxO6dtmLeb4V8DJRLXjRU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f69bcd4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 26 Oct 2022 01:50:29 +0000 (UTC)
Date:   Wed, 26 Oct 2022 03:50:25 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <Y1iSYddi3BpP8gvf@zx2c4.com>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210201151.ECC19BC97A@keescook>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:57:12AM -0700, Kees Cook wrote:
> On Thu, Oct 20, 2022 at 10:42:25AM -0700, Linus Torvalds wrote:
> > On Thu, Oct 20, 2022 at 10:33 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > Or sometimes with objdump, I've had more success by keeping debug
> > > symbols, and then trimming offsets from jmps.
> > 
> > objdump is what I'm using, and it actually seems ok on individual object files.
> > 
> > Now I just need to script the "do all the object files" and see how
> > massive the end result is.
> 
> For the a/b build, I start with all*config, then:
> 
> # Stop painful noise
> CONFIG_KCOV=n
> CONFIG_GCOV_KERNEL=n
> CONFIG_GCC_PLUGINS=n
> CONFIG_IKHEADERS=n
> CONFIG_KASAN=n
> CONFIG_UBSAN=n
> CONFIG_KCSAN=n
> CONFIG_KMSAN=n
> # Get us source/line details
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> CONFIG_DEBUG_INFO_REDUCED=n CONFIG_DEBUG_INFO_COMPRESSED=n
> CONFIG_DEBUG_INFO_SPLIT=n
> 
> And to keep other build-time junk stabilized[1], I build with these make
> options:
> 
> KBUILD_BUILD_TIMESTAMP=1970-01-01
> KBUILD_BUILD_USER=user
> KBUILD_BUILD_HOST=host
> KBUILD_BUILD_VERSION=1

The LLVM `.ll` file thing I tried turned out to be a disaster. Too much
noise, as this is too early of a stage.

The traditional objdump comparison does work, though. It produces a good
amount of noise, but still yields a manageable amount of diffs -- 882 --
which can then be paired down more with heuristics.

I've been using this script below to compare `linux-schar/` with
`linux-uchar/`, which creates a directory `linux-schar-uchar/` filled
with color diffs that I can then flip through using
`less -R linux-schar-uchar/*.diff`. Seems to work okay, so I'll post it
here in case others are curious about looking through these.

Jason

------8<--------------------------------

#!/bin/bash

asm_diff() {
	objdump \
		--disassemble \
		--demangle \
		--no-show-raw-insn \
		--no-addresses \
		--section=.text \
		--disassembler-options=intel \
	"$1" | \
	sed \
		-e 's/[0-9a-f]\+ \(<[a-zA-Z0-9_+-]\+>\)/?? \1/g' \
		-e 's/<\([a-zA-Z0-9_-]\+\)+0x[a-f0-9]\+>/<\1>/g' \
		-e '/\/[a-zA-Z0-9._-]\+\.o:/d'
}

A=linux-schar
B=linux-uchar
C=linux-schar-uchar

rm -rf "$C"
mkdir -p "$C"

while read -r obj_a; do
	obj_b="$B/${obj_a#$A/}"
	diff_c="${obj_a#$A/}"
	diff_c="$C/${diff_c//\//--}.diff"
	[[ -f $obj_b ]] || { echo "ERROR: $obj_b is missing" >&2; exit 1; }

	echo "${obj_a#$A/}" >&2

	diff --color=always --text --unified=10 \
		<(asm_diff "$obj_a") <(asm_diff "$obj_b") > "$diff_c" && \
	rm -f "$diff_c"
done < <(exec find "$A" -name '*.o')
