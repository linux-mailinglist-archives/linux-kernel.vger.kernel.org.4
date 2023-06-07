Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A9725A93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbjFGJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbjFGJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:33:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7CB210B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:33:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so795851a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686130392; x=1688722392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyGRpP0Ps5sjOMvaXnWUCGumxVowNckbi73GKWcFw6Y=;
        b=skpB9Y28QJwaQ1oYzJ9dVjFJKCA5DWClhZLKEJn6e1toC5Nx1srQ+9svYbYwTRrDb7
         ym++/0S/g1UVOZvvhkcclhkrid52UBT/tvztyrUXS3HccpXPYeacBNJAurlzjc+0Krng
         vzVjjr67NCt+irsu+0Vyr62LdB4WKJ6Ii+DtPKOexemRiWwARUiyaw2Hr+z0CoEqTUw/
         Q9VIOrX0nS+DYa6flie0KSv/peTtvfTjGt7GFVnNukS38IEuEiSamloosqnwhUWvXdxO
         cGdzZD69sAWSQDaYH57BZ623NlMpf8kKujiFnifqv4ib+meqNERAExTBxelLOv1dAKGD
         8+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130392; x=1688722392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyGRpP0Ps5sjOMvaXnWUCGumxVowNckbi73GKWcFw6Y=;
        b=Vjh7TfW5bNOfW9h6xHsPZvgC8pQL2oTsatyyIyMxZvKyC60BF06OlI0/n+0eH2MzVN
         G2ip5zBKHMWN9i/PxhtaBDjKdGrJiF3sOpZHAETMGPGrepmHxLzYoOWzw8+EdJ/gKcwg
         RGs8luQpSdCFzoUVdFyzOSG4Uw/0Gkc/Gh2l/A8CG9mvkPZ2/ns5dBF3Q7RvJXhwIGHE
         139z92L/W95IKfiRT1U9HcpOtVZSDanapz90xfGAfZ+6b61iD+XZt4z2cRdUknvKn/Vc
         4tu/umLJdLrhmawpLIxbdTS3bq6MbcxygNFfdk3M/mMUvX97qm7Xcy6SScJqHDCIfp8w
         4t4w==
X-Gm-Message-State: AC+VfDyvA3S0iWtbDgNWYdos8QTy6Q69LtzGRED6EQ1MtNsuOGtBkCCy
        bbe6Ty78MCJnEsVntxqN2SmXC+HuSvlzqVR78dym5COwYJt2c7KEUh8=
X-Google-Smtp-Source: ACHHUZ6lGDlQTcQi4WU8x5/VKU1RzmNWEAJ9vl+T/9bLnb1SJ0V2xFv1pEub3MIaspkYbyBUKklidsYHlys1xoP2cNs=
X-Received: by 2002:a17:907:c28:b0:967:13a3:d82c with SMTP id
 ga40-20020a1709070c2800b0096713a3d82cmr13862639ejc.26.1686130392037; Wed, 07
 Jun 2023 02:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <CAJD7tkad3cWs2CkZE2pV4kzNjn+0crmT2YYpSKU9SynQf7S24Q@mail.gmail.com> <CA+CLi1j-tQ8DJzShmBr_9feaSWJLvteFXZ+bwafP0YK=MDVVuA@mail.gmail.com>
In-Reply-To: <CA+CLi1j-tQ8DJzShmBr_9feaSWJLvteFXZ+bwafP0YK=MDVVuA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 02:32:35 -0700
Message-ID: <CAJD7tkbsYxgutGVMjBBeBCviW4UwDwNcM8=xRRwqLxeASHCakg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] mm: zswap: move writeback LRU from zpool to zswap
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, linux-mm@kvack.org, ddstreet@ieee.org,
        sjenning@redhat.com, nphamcs@gmail.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 2:24=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Wed, Jun 7, 2023 at 11:16=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
> > <cerasuolodomenico@gmail.com> wrote:
> > >
> > > This series aims to improve the zswap reclaim mechanism by reorganizi=
ng
> > > the LRU management. In the current implementation, the LRU is maintai=
ned
> > > within each zpool driver, resulting in duplicated code across the thr=
ee
> > > drivers. The proposed change consists in moving the LRU management fr=
om
> > > the individual implementations up to the zswap layer.
> > >
> > > The primary objective of this refactoring effort is to simplify the
> > > codebase. By unifying the reclaim loop and consolidating LRU handling
> > > within zswap, we can eliminate redundant code and improve
> > > maintainability. Additionally, this change enables the reclamation of
> > > stored pages in their actual LRU order. Presently, the zpool drivers
> > > link backing pages in an LRU, causing compressed pages with different
> > > LRU positions to be written back simultaneously.
> > >
> > > The series consists of several patches. The first patch implements th=
e
> > > LRU and the reclaim loop in zswap, but it is not used yet because all
> > > three driver implementations are marked as zpool_evictable.
> > > The following three commits modify each zpool driver to be not
> > > zpool_evictable, allowing the use of the reclaim loop in zswap.
> > > As the drivers removed their shrink functions, the zpool interface is
> > > then trimmed by removing zpool_evictable, zpool_ops, and zpool_shrink=
.
> > > Finally, the code in zswap is further cleaned up by simplifying the
> > > writeback function and removing the now unnecessary zswap_header.
> > >
> > > Based on mm-stable + commit 399ab221f3ff
> > > ("mm: zswap: shrink until can accept") currently in mm-unstable.
> >
> > I tested this + commit fe1d1f7d0fb5 ("mm: zswap: support exclusive
> > loads") currently in mm-unstable, using zsmalloc and
> > CONFIG_ZSWAP_EXCLUSIVE_LOADS=3Dy. I only ran basic zswap tests with
> > manual writeback induction and made sure everything is sane. I
> > obviously hope you did more involved testing :)
> >
> > The only problem I came across is the conflict with fe1d1f7d0fb5, and
> > I suggested the fix in patch 1. With the fix, everything seems
> > correct.
> >
> > So I guess, FWIW for all the patches except 2 & 3 (for zbud and z3fold)=
:
> > Tested-by: Yosry Ahmed <yosryahmed@google.com>
>
> Thanks a lot for the effort! I'll rebase and test it again before submitt=
ing the
> new version.

Perhaps give v2 a little bit more time to give other folks a chance to
take a look as well, save yourself (and probably Andrew) the trouble
of sending a new version for every single review :)

>
> >
> > >
> > > V2:
> > > - fixed lru list init/del/del_init (Johannes)
> > > - renamed pool.lock to lru_lock and added lock ordering comment (Yosr=
y)
> > > - trimmed zsmalloc even more (Johannes | Nhat)
> > > - moved ref drop out of writeback function  (Johannes)
> > >
> > > Domenico Cerasuolo (7):
> > >   mm: zswap: add pool shrinking mechanism
> > >   mm: zswap: remove page reclaim logic from zbud
> > >   mm: zswap: remove page reclaim logic from z3fold
> > >   mm: zswap: remove page reclaim logic from zsmalloc
> > >   mm: zswap: remove shrink from zpool interface
> > >   mm: zswap: simplify writeback function
> > >   mm: zswap: remove zswap_header
> > >
> > >  include/linux/zpool.h |  19 +-
> > >  mm/z3fold.c           | 249 +-------------------------
> > >  mm/zbud.c             | 167 +-----------------
> > >  mm/zpool.c            |  48 +----
> > >  mm/zsmalloc.c         | 396 ++--------------------------------------=
--
> > >  mm/zswap.c            | 186 +++++++++++---------
> > >  6 files changed, 130 insertions(+), 935 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
