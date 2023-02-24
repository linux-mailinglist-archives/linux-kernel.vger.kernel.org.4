Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBB6A149F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBXBeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBXBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:34:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5536FD8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:33:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o12so49593122edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymzGFsmWya6beQpPK0i2hFaBLxyxKs7ybs+4Ujx9o08=;
        b=NsTxMu91loRThYoVGXFnM1XQ6n7iZETYV2DEh33EWoE15bp7NJWrtEXVpY0Rgsg7Sp
         LnJ2qOiHjWOr23v7VHuhjP9/UNu+4HIaRK604xjFVXvMp6MZw3aDF9OlbfLeAoPOzaxW
         03/jDGV57fRr3MShW//nWjDkbPz7ix5RXbCaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymzGFsmWya6beQpPK0i2hFaBLxyxKs7ybs+4Ujx9o08=;
        b=vWDP9VqbiDtUiisvpC2a7iVtUpbknPUFb3Fy6wJVDhJuffTbx9Y3Vahbx8RZXWDeoh
         wvF/xh5Hpapfu06U+xboSDq110lZeBJPRcyag+4FfmFGdcEgjkOCkUCVArwoGuPpD8ib
         vidYxjOh2f51gMtFFKkE2WC2CmnZwb2WMoo4m8CqvrX1gVdZH/FZqT0fNZbZOBrovIM3
         lYaY++URlsHYWwupzfYFDtO9lvYhovMt5wFiqVxsNVndAU7w9/Fii28uXEzIgcb9KTzW
         c68sYr7wTB4E3jHDtxviJEFVSOptsB8bBbRbJfHRjCpYU2FsHNHs5DTmuT3ykmT7EuwE
         cnAA==
X-Gm-Message-State: AO0yUKUrHJPn84BlcXoYoRQato4yuRwkMuLhAoeahLEO96ImorktSenm
        8GfmKtvHIkAJST7kyyFDpCx+0AD8/KGs880JM4Zfyw==
X-Google-Smtp-Source: AK7set/Zz3xo1c0My6YPbwGFBvMpcArRE9R9XEglkUK/C32mP6N/HRDkT/E9sNH43brBtIUiaTnlcg==
X-Received: by 2002:a17:906:ce24:b0:8bf:e95c:467b with SMTP id sd4-20020a170906ce2400b008bfe95c467bmr19427766ejb.63.1677202435735;
        Thu, 23 Feb 2023 17:33:55 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090651c500b008e3bf17fb2asm3298113ejk.19.2023.02.23.17.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 17:33:55 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id cq23so48890474edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:33:54 -0800 (PST)
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr10458388ejk.0.1677202434537; Thu, 23
 Feb 2023 17:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
In-Reply-To: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2023 17:33:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
Message-ID: <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Vishal Moola <vishal.moola@gmail.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 1:52 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> Linus, please merge this cycle's MM updates.

Ok, finally got around to this one, and I am not thrilled about it.

A few notes:

 - my fs/udf/inode.c is "minimal". Ugly, ugly, I think
udf_adinicb_writepage() should just be made to actually deal with
folios inherently, but I did *NOT* do that, and just did

        struct page *page =3D &folio->page;

   at the top, and left it at that. I'm not proud of it, but I hope
Jan might want to do this properly.

   That conflict wasn't mentioned, and now I wonder if the UDF changes
were in -next at all?

 - the fs/cifs/file.c conflict was a nightmare.

   Yes, I saw David Howells resolution suggestion. I think that one
was buggy. It would wait for a page under writeback, and then go on to
the *next* one without writing it back. I don't thin kthat was right.

   That said, I'm not at all convinced my version is right either. I
can't test it, and that means I probably messed up. It looked sane to
me when I did it, and it builds cleanly, but I honestly doubt myself.

   I think that code should probably use xas_for_each_marked(), but
instead I kept the old model, added a loop like DavidH did, and then
munged the end result until I thought it was palatable.

   NOTE! Don't even try to look at the conflict diff. It makes no
sense at all. But somebody (I'd hope all of DavidH, SteveF and Willy)
should really take a look at my end result.

 - gcc 12.2.1 quite reasonable complains about some of the new MM code:

    mm/migrate.c: In function =E2=80=98__migrate_folio_extract=E2=80=99:
    mm/migrate.c:1050:20: note: randstruct: casting between randomized
structure pointer types (ssa): =E2=80=98struct anon_vma=E2=80=99 and =E2=80=
=98struct
address_space=E2=80=99

     1050 |         *anon_vmap =3D (void *)dst->mapping;
          |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~

   and while this doesn't cause a build failure ("note" is different
from "warning"), I do think something needs to be done. Gcc is right.
This code seems to *work* simply because it's intentionally
mis-casting pointers, but I think it needs to be seriously looked at
and something done to make gcc happy (and a *LARGE* comment about it).

That last note is not some merge result, it's purely about the new MM code.

Anyway, the merge is done and pushed out, I just am not very confident
about the end result at all. That cifs thing really needs somebody
competent looking at it.

I think I went through three different iterations of my resolution
before I was happy with my approach, and "happy" may end up being more
about having exhausted my will to live, than about the end result
actually being any good.

I saw some noise about ext4 being a nightmare too, but I haven't
gotten that pull request yet.

I'll tackle the non-MM pull next, but I'm taking a break first.
Alcohol may have to be involved.

               Linus
