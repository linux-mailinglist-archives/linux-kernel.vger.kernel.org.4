Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6798659A05
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiL3Phl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiL3PhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:37:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47451BEA3;
        Fri, 30 Dec 2022 07:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1291FCE18A9;
        Fri, 30 Dec 2022 15:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6F4C433EF;
        Fri, 30 Dec 2022 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672414586;
        bh=XE8ifSxGfXq/BFysAeNhRttsfdgdwDk0kodQg7Og6jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjMPoHfU3+7aBFL/0XLFhmvT0RSC175bUbdlNZhNo14EO1phL9KOvNtQsUJ5RLCZN
         OEGso1R4DwwVGCqBy+fTcceh64gSEccbzbYCzQLD7VHNCiXi6bpWu3jyXBIBsRnrfJ
         B2owNiM3jiQwUfi6ZW65ZeWiuCOeJQyHjALrKMsLLO9/BEMgMXIIzlSApjPt1dEW3q
         aIqvu5rhG8yJQuXHuM0Whui4kzXuJtKolZ81n6bhrQi9OHIa9rnuGhmwqPPZQr4TE1
         HNTvGGFikKIRvS3cHBR8cWW+pjqCd6p+nu94bzMLmbrwEmBPZOABToOC1Yzubj9s6d
         SRKrpUN7BMUjg==
Date:   Fri, 30 Dec 2022 16:36:19 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [linus:master] [kbuild] 3bc753c06d: xfstests.generic.454.fail
Message-ID: <20221230153619.itewmvrtoxqkugx2@wittgenstein>
References: <202212291509.704a11c9-oliver.sang@intel.com>
 <CAHk-=wieOBgQ-7aoihBzywKqxiO7o7hc6gd_csn69ChcxR1FuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wieOBgQ-7aoihBzywKqxiO7o7hc6gd_csn69ChcxR1FuQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 10:55:05AM -0800, Linus Torvalds wrote:
> On Thu, Dec 29, 2022 at 12:49 AM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> > generic/454       _check_generic_filesystem: filesystem on /dev/sda4 is inconsistent
> 
> The commentary on that test is:
> 
>   Create xattrs with multiple keys that all appear the same
>   (in unicode, anyway) but point to different values.  In theory all
>   Linux filesystems should allow this (filenames are a sequence of
>   arbitrary bytes) even if the user implications are horrifying.
> 
> and looking at the script it seems to indeed just do setfattr and
> getfattr with some unusual data (ie high bit set).
> 
> Adding Ted, since this is apparently all on ext4. I guess it could be
> the vfs layer too, but it really doesn't tend to look very much at the
> xattr data, so.. Adding Christian Brauner anyway, since he's been
> working in this area for other reasons.

The test uses the user.* xattr namespace which should be unaffected by
the xattr changes we did the last few cycles.

> 
> Ted, Christian - I cut down the report mercilessly. It's not really
> all that interesting, apart from the basic information of "xfstest
> generic/454 started failing consistently on ext4 at commit
> 3bc753c06dd0 ('kbuild: treat char as always unsigned')".
> 
> If you think you need more, see
> 
>     https://lore.kernel.org/all/202212291509.704a11c9-oliver.sang@intel.com/
> 
> Also, I'm surprised this hasn't been an issue earlier - 'char' has
> always been unsigned on arm (among other architectures), so if this
> test started failing now on x86-64 due to -funsigned-char, it has
> presumably been failing on arm the whole time.
> 
> I assume it's something that compares a 'char *name' by value, but the
> ones I looked at (eg xattr_find_entry() used strlen()/memcmp() which
> should be all good).
> 
> Oh, I think I see one potential problem in ext4:
> 
> ext4_xattr_hash_entry() is hot garbage. Lookie here:
> 
>         while (name_len--) {
>                 hash = (hash << NAME_HASH_SHIFT) ^
>                        (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
>                        *name++;
>         }
> 
> so that hash will now depend on the sign of that 'char *name' pointer.
> 
> If that hash ever has any long-term meaning (ie saved on disk or
> exposed some other way), that would be problematic.

If the xattrs aren't storable in the inode then they are stored in a
separate block. The consist of a header and after that is an array of
struct ext4_xattr_entry entries.

Each of the entries store a hash value e_hash which is a hash of the
xattr name and xattr value.

The aforementioned header contains another h_hash field which seems to
be a hash of all e_hash fields of all xattrs.

For in-inode/ea-inode xattrs a hash for xattr name and value is stored
on disk as well but there's no header. The i_atime field contains a
checksum of only the value that is stored in the inode.

IOW, the bug might also depend on how the xattrs are stored. For
example, what xattrs might be stored in the inode depends on the inode
size that is chosen when the filesystem is created. But if I'm not
mistaken, it also depends on the block size.
So if the block size chosen for x86 differs from arm that might have an
impact on how the xattrs are stored and thus make the bug more or less
likely to appear?...
