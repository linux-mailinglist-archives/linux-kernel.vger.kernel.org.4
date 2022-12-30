Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781365941E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 03:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiL3CI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 21:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3CIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:08:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686E015FE9;
        Thu, 29 Dec 2022 18:08:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C51619FF;
        Fri, 30 Dec 2022 02:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D220FC433EF;
        Fri, 30 Dec 2022 02:08:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="At5O+D5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672366097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XaP7sY3uwOFXUCeCgylt4xt3/IE9Khk5QaeZ73NIu7U=;
        b=At5O+D5c28UopZfAFWpWdI9M9XpBkOruvFNzyIwXLfY4NzH/VZmyuf6WEsftDLQtGyl9IS
        GY7iscAktxO+PtHXsfsjM6nZChfOzbkgvEblj7Ep2tuFDEn4NRwkSnIfHf7+NPbq4+fl1u
        +hwynzAnpK3bQFe4EUI4Wi4uLzRrmdQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 774c63d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Dec 2022 02:08:17 +0000 (UTC)
Date:   Fri, 30 Dec 2022 03:08:14 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [linus:master] [kbuild] 3bc753c06d: xfstests.generic.454.fail
Message-ID: <Y65IDkjj9kYcoLiW@zx2c4.com>
References: <202212291509.704a11c9-oliver.sang@intel.com>
 <CAHk-=wieOBgQ-7aoihBzywKqxiO7o7hc6gd_csn69ChcxR1FuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wieOBgQ-7aoihBzywKqxiO7o7hc6gd_csn69ChcxR1FuQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 10:55:05AM -0800, Linus Torvalds wrote:
> Also, I'm surprised this hasn't been an issue earlier - 'char' has
> always been unsigned on arm (among other architectures), so if this
> test started failing now on x86-64 due to -funsigned-char, it has
> presumably been failing on arm the whole time.

That's the curious part, indeed...

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

Note that ext4 has lots of sign-specific code for hashing. Only some of
it can now be removed, since compatibility with old file systems must be
preserved. But what I mean is the code that begins in super.c:

                i = le32_to_cpu(es->s_flags);
                if (i & EXT2_FLAGS_UNSIGNED_HASH)
                        sbi->s_hash_unsigned = 3;
                else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
#ifdef __CHAR_UNSIGNED__
                        if (!sb_rdonly(sb))
                                es->s_flags |=
                                        cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
                        sbi->s_hash_unsigned = 3;
#else
                        if (!sb_rdonly(sb))
                                es->s_flags |=
                                        cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
#endif
                }

The second part of that #else can now go away. And then maybe the whole
expression can be simplified.

These actually wind up being used in namei.c:

                hinfo->hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;

, which then sets the hash version that's selected in hash.c:

        switch (hinfo->hash_version) {
        case DX_HASH_LEGACY_UNSIGNED:
                hash = dx_hack_hash_unsigned(name, len);
                break;
        case DX_HASH_LEGACY:
                hash = dx_hack_hash_signed(name, len);
                break;
        case DX_HASH_HALF_MD4_UNSIGNED:
                str2hashbuf = str2hashbuf_unsigned;
                fallthrough;
        case DX_HASH_HALF_MD4:
                p = name;
		[...]

And so on. dx_hack_hash_unsigned() and dx_hack_hash_signed() are the
same functions, except one uses `unsigned char` and the other uses
`signed char`. It's unfortunate these exist, but now it's part of the
on-disk format, so they have to stick around (along with other warts
like "halfmd4").

But at least for new file systems, things should be unified. Anyway, it
looks like for *these* hashes, the ext4 developers did consider the
signedness issue.

Sounds like maybe it was left out of ext4_xattr_hash_entry(), which does
indeed look like it's part of the on-disk representation:

static int
ext4_xattr_inode_verify_hashes(struct inode *ea_inode,
                               struct ext4_xattr_entry *entry, void *buffer,
                               size_t size)
{
        u32 hash;

        /* Verify stored hash matches calculated hash. */
        hash = ext4_xattr_inode_hash(EXT4_SB(ea_inode->i_sb), buffer, size);
        if (hash != ext4_xattr_inode_get_hash(ea_inode))
                return -EFSCORRUPTED;

        if (entry) {
                __le32 e_hash, tmp_data;

                /* Verify entry hash. */
                tmp_data = cpu_to_le32(hash);
                e_hash = ext4_xattr_hash_entry(entry->e_name, entry->e_name_len,
                                               &tmp_data, 1);
                if (e_hash != entry->e_hash)
                        return -EFSCORRUPTED;
        }
        return 0;
}

So if ext4_xattr_hash_entry() is indeed broken with respect to
heisensignness, then this stuff has always been broken, and it's
probably good that this is being unearthed...

Jason
