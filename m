Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0360965909A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiL2Szb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiL2Sz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:55:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9113F91
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:55:25 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j16so15650349qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xV2T7Ezr7Tu9usVmsoEJDL7ttiEd8vTPNlCNm/CjYXw=;
        b=Q8HGzhiP2ohA79pqC6Uy+jj5SeJtp8cWeQ++imJzVTvC0X7BH8zjPfQTyKq8UYKaK9
         1AC0vSgoFmGjyhDwqsUYuyR+M+DxG50cnO99tmHxSZf7+2kV4e7QwsWLvOtElB4S0MiR
         HyZtfODh6bFwebfqF/nLXlLMHXXZZGqY4HgxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xV2T7Ezr7Tu9usVmsoEJDL7ttiEd8vTPNlCNm/CjYXw=;
        b=XyqFIBH4JwbbqQdQUm//XHC/rJ8cRV4X2EaaUnElUCd79iuGz3IoKmn4FAtqvJSYBK
         pW8Hz3gFcD0agk77MmxTkDQcy06vXrk+3+nx24dBV9zs2ho/c1bREYzl4Z7utj4YKkII
         IvI3WUI+fKEf4ky/k5xlW81PivbUOlBA/X9zs36HVTeYismq6aAvP+BqoWzNgBI83OJp
         CLHAq6ux6tIRlqoSGEya91rpOQ5tCD4MRv8qHcDCZa8NjnGKnvFMcqjXzqXT90F6zF+X
         DsT7Yi8+g3vK3slpKerP9IX/4N0rzodBkDYDFtBVG41nLlh2Buzxw584MgchhXzsqHoH
         SNbg==
X-Gm-Message-State: AFqh2koSE5QFaUz3fq2h1fD7eRvd5zl7Wg4qsb2Ur5bfEgF+84cBvvuK
        D7BrVyfr5DkPFv4ot58p6hpIt6dgzWmgNb3O
X-Google-Smtp-Source: AMrXdXtJ8lV2VoHrXDyBnlEWUJxMSVUPKkSTvh1R9/tOEQ8olqhHZ02ke9An/vygB1qaZeYV7gITkA==
X-Received: by 2002:ac8:424c:0:b0:3a7:ff5f:cc54 with SMTP id r12-20020ac8424c000000b003a7ff5fcc54mr40785010qtm.67.1672340124008;
        Thu, 29 Dec 2022 10:55:24 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b006fc40dafaa2sm13599025qkj.8.2022.12.29.10.55.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 10:55:22 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id x11so15608617qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:55:22 -0800 (PST)
X-Received: by 2002:ac8:67da:0:b0:3a5:122:fb79 with SMTP id
 r26-20020ac867da000000b003a50122fb79mr787348qtp.452.1672340121841; Thu, 29
 Dec 2022 10:55:21 -0800 (PST)
MIME-Version: 1.0
References: <202212291509.704a11c9-oliver.sang@intel.com>
In-Reply-To: <202212291509.704a11c9-oliver.sang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Dec 2022 10:55:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieOBgQ-7aoihBzywKqxiO7o7hc6gd_csn69ChcxR1FuQ@mail.gmail.com>
Message-ID: <CAHk-=wieOBgQ-7aoihBzywKqxiO7o7hc6gd_csn69ChcxR1FuQ@mail.gmail.com>
Subject: Re: [linus:master] [kbuild] 3bc753c06d: xfstests.generic.454.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>
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

On Thu, Dec 29, 2022 at 12:49 AM kernel test robot
<oliver.sang@intel.com> wrote:
>
> generic/454       _check_generic_filesystem: filesystem on /dev/sda4 is inconsistent

The commentary on that test is:

  Create xattrs with multiple keys that all appear the same
  (in unicode, anyway) but point to different values.  In theory all
  Linux filesystems should allow this (filenames are a sequence of
  arbitrary bytes) even if the user implications are horrifying.

and looking at the script it seems to indeed just do setfattr and
getfattr with some unusual data (ie high bit set).

Adding Ted, since this is apparently all on ext4. I guess it could be
the vfs layer too, but it really doesn't tend to look very much at the
xattr data, so.. Adding Christian Brauner anyway, since he's been
working in this area for other reasons.

Ted, Christian - I cut down the report mercilessly. It's not really
all that interesting, apart from the basic information of "xfstest
generic/454 started failing consistently on ext4 at commit
3bc753c06dd0 ('kbuild: treat char as always unsigned')".

If you think you need more, see

    https://lore.kernel.org/all/202212291509.704a11c9-oliver.sang@intel.com/

Also, I'm surprised this hasn't been an issue earlier - 'char' has
always been unsigned on arm (among other architectures), so if this
test started failing now on x86-64 due to -funsigned-char, it has
presumably been failing on arm the whole time.

I assume it's something that compares a 'char *name' by value, but the
ones I looked at (eg xattr_find_entry() used strlen()/memcmp() which
should be all good).

Oh, I think I see one potential problem in ext4:

ext4_xattr_hash_entry() is hot garbage. Lookie here:

        while (name_len--) {
                hash = (hash << NAME_HASH_SHIFT) ^
                       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
                       *name++;
        }

so that hash will now depend on the sign of that 'char *name' pointer.

If that hash ever has any long-term meaning (ie saved on disk or
exposed some other way), that would be problematic.

Of course, if it's just an ephemeral thing only used on that one
machine, then it isn't a problem - having different hashes on
different machines (and different boots) is a non-issue. But
considering that it then does

        return cpu_to_le32(hash);

at the end does seem to imply to me that it all really *tries* to be
architecture-neutral, and has just failed horrendously.

Because that does look like code that might get confused by the sign of a char.

There might be other cases, I only looked very quickly for these kinds
of problems.

          Linus
