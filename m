Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF67670FBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjEXQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjEXQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB112B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684946340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIRDFYHmrI2ea9PgJ9cG2BzagPncv2WifE6ykqY/z1c=;
        b=JYylOJb+NzvsPb3go+eofLvRUsLwcMr6QMlGTwp3VirHN/L/4sKl9a9qYhnmC/cR4+GW3d
        WgZ+rzV2h5FhAmPtIqtdJOvefiLDq8bJMcp/9FetIiZ55k+xnl16pB8pwk1zJnzq32Gafw
        R3IUsKP3/2ZQEZff8cdkFFfF9WrdBBE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-R5DiWxxhPrqwcO8Vk1YSmw-1; Wed, 24 May 2023 12:38:58 -0400
X-MC-Unique: R5DiWxxhPrqwcO8Vk1YSmw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ae735bd214so4176835ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946338; x=1687538338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIRDFYHmrI2ea9PgJ9cG2BzagPncv2WifE6ykqY/z1c=;
        b=f0TVwJdLPplitrK0BxmL0vosIww3R90oVbdRSzbyZ6en87Np2beXSrZI0QrT5UIKli
         Nurdg/LnH5DatydDIWVBR50gn05SAvl2ikfgvwRFVn+WTm8Cjd8OBFgJWWhVanMR6SfQ
         RQeWUMBibl6uLmw/eTYYGc0w9XxbGBZWpdIppHSZwBCc3FytjkMM2HZ/xTvNA0ckMw75
         7w/dz/6HLabU0UMSqzcNav4fQPImMT+zZrdem6fS37W1vI2WR2ohH8RlDoNzHWBBlp7+
         cZkpMYJw1sCG5zURtTJNGvhuRfOMm2wVQlKw9LgsqHToQybuRWVaxub/tAMMFnvULjnr
         PVLg==
X-Gm-Message-State: AC+VfDzQZoqcBE9/PuYIBb1mzhLXK3fjZAKXppWRGuH9/5wsV7yAWpVN
        sjEO/yX1bJjzSJKDMiJyM74Qj/SWDamiTqw6UbxtiibE4DQHoThJ8gjk3Vnc/6i8EBw2L2+FoPL
        uIbmocGplrFMFufpFjKdOvu5G853jhhj6JPb+9CTC
X-Received: by 2002:a17:903:428a:b0:1ac:4a41:d38d with SMTP id ju10-20020a170903428a00b001ac4a41d38dmr15831022plb.51.1684946337866;
        Wed, 24 May 2023 09:38:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QhwNbEG7dVnvKUcvcrF5VXTCpluYFQoMIGO7odXS8eF4N7acYVvSWWvlkVR9tfx1GsK6DpUi0zEDdnwhFY7c=
X-Received: by 2002:a17:903:428a:b0:1ac:4a41:d38d with SMTP id
 ju10-20020a170903428a00b001ac4a41d38dmr15830993plb.51.1684946337555; Wed, 24
 May 2023 09:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230216150701.3654894-1-dhowells@redhat.com> <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
In-Reply-To: <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 24 May 2023 12:38:21 -0400
Message-ID: <CALF+zO=Y8dMsJ79RYp1e7n9B5_0=segpqW9_tetBqPhFiQcZxA@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v6 0/2] mm, netfs, fscache: Stop read
 optimisation when folio removed from pagecache
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 3:29=E2=80=AFPM David Wysochanski <dwysocha@redhat.=
com> wrote:
>
> On Thu, Feb 16, 2023 at 10:07=E2=80=AFAM David Howells <dhowells@redhat.c=
om> wrote:
> >
> > Hi Willy,
> >
> > Is this okay by you?  You said you wanted to look at the remaining uses=
 of
> > page_has_private(), of which there are then three after these patches, =
not
> > counting folio_has_private():
> >
> >         arch/s390/kernel/uv.c:          if (page_has_private(page))
> >         mm/khugepaged.c:                    1 + page_mapcount(page) + p=
age_has_private(page)) {
> >         mm/migrate_device.c:            extra +=3D 1 + page_has_private=
(page);
> >
> > --
> > I've split the folio_has_private()/filemap_release_folio() call pair
> > merging into its own patch, separate from the actual bugfix and pulled =
out
> > the folio_needs_release() function into mm/internal.h and made
> > filemap_release_folio() use it.  I've also got rid of the bit clearance=
s
> > from the network filesystem evict_inode functions as they doesn't seem =
to
> > be necessary.
> >
> > Note that the last vestiges of try_to_release_page() got swept away, so=
 I
> > rebased and dealt with that.  One comment remained, which is removed by=
 the
> > first patch.
> >
> > David
> >
> > Changes:
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > ver #6)
> >  - Drop the third patch which removes a duplicate check in vmscan().
> >
> > ver #5)
> >  - Rebased on linus/master.  try_to_release_page() has now been entirel=
y
> >    replaced by filemap_release_folio(), barring one comment.
> >  - Cleaned up some pairs in ext4.
> >
> > ver #4)
> >  - Split has_private/release call pairs into own patch.
> >  - Moved folio_needs_release() to mm/internal.h and removed open-coded
> >    version from filemap_release_folio().
> >  - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
> >  - Added experimental patch to reduce shrink_folio_list().
> >
> > ver #3)
> >  - Fixed mapping_clear_release_always() to use clear_bit() not set_bit(=
).
> >  - Moved a '&&' to the correct line.
> >
> > ver #2)
> >  - Rewrote entirely according to Willy's suggestion[1].
> >
> > Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ =
[1]
> > Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178=
.stgit@warthog.procyon.org.uk/ # v1
> > Link: https://lore.kernel.org/r/166844174069.1124521.108905063609741699=
94.stgit@warthog.procyon.org.uk/ # v2
> > Link: https://lore.kernel.org/r/166869495238.3720468.487815140908514676=
4.stgit@warthog.procyon.org.uk/ # v3
> > Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.=
uk/ # v3 also
> > Link: https://lore.kernel.org/r/166924370539.1772793.137306983607718213=
17.stgit@warthog.procyon.org.uk/ # v4
> > Link: https://lore.kernel.org/r/167172131368.2334525.856980892568773193=
7.stgit@warthog.procyon.org.uk/ # v5
> > ---
> > %(shortlog)s
> > %(diffstat)s
> >
> > David Howells (2):
> >   mm: Merge folio_has_private()/filemap_release_folio() call pairs
> >   mm, netfs, fscache: Stop read optimisation when folio removed from
> >     pagecache
> >
> >  fs/9p/cache.c           |  2 ++
> >  fs/afs/internal.h       |  2 ++
> >  fs/cachefiles/namei.c   |  2 ++
> >  fs/ceph/cache.c         |  2 ++
> >  fs/cifs/fscache.c       |  2 ++
> >  fs/ext4/move_extent.c   | 12 ++++--------
> >  fs/splice.c             |  3 +--
> >  include/linux/pagemap.h | 16 ++++++++++++++++
> >  mm/filemap.c            |  2 ++
> >  mm/huge_memory.c        |  3 +--
> >  mm/internal.h           | 11 +++++++++++
> >  mm/khugepaged.c         |  3 +--
> >  mm/memory-failure.c     |  8 +++-----
> >  mm/migrate.c            |  3 +--
> >  mm/truncate.c           |  6 ++----
> >  mm/vmscan.c             |  8 ++++----
> >  16 files changed, 56 insertions(+), 29 deletions(-)
> >
> > --
> > Linux-cachefs mailing list
> > Linux-cachefs@redhat.com
> > https://listman.redhat.com/mailman/listinfo/linux-cachefs
> >
>
> Willy, and David,
>
> Can this series move forward?
> This just got mentioned again [1] after Chris tested the NFS netfs
> patches that were merged in 6.4-rc1
>
> [1] https://lore.kernel.org/linux-nfs/CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWK=
nUQs4r8fkW=3D6RW9g@mail.gmail.com/

Sorry about the timing on the original email as I forgot it lined up
with LSF/MM.

FYI, I tested with 6.4-rc1 plus these two patches, then I added the NFS
hunk needed (see below).  All my tests pass now[1], and it makes sense
from all the ftraces I've seen on test runs that fail (cachefiles_prep_read
trace event would show "DOWN no-data" even after data was written
previously).

This small NFS hunk needs added to patch #2 in this series:

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 8c35d88a84b1..d4a20748b14f 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -180,6 +180,10 @@ void nfs_fscache_init_inode(struct inode *inode)
                                               &auxdata,      /* aux_data *=
/
                                               sizeof(auxdata),
                                               i_size_read(inode));
+
+       if (netfs_inode(inode)->cache)
+               mapping_set_release_always(inode->i_mapping);
+
 }

 /*

[1] https://lore.kernel.org/linux-nfs/CALF+zOn_qX4tcT2ucq4jD3G-1ERqZkL6Cw7h=
x75OnQF0ivqSeA@mail.gmail.com/

