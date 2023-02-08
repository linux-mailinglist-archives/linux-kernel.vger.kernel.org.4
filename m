Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C668F8E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjBHUeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:34:18 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973B41B71
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:34:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr8so307193ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x3UTKNVAFg81+ROQdV5mrZhJY+4YOTyh1X8nO1nYb4g=;
        b=alUC6pc48SQEnhJO+rTZzq2elD/xe+Gw1eMwEHzIonnzHo6Kw0Gi9hkBdJ1x6RSQ5M
         obgdmvbS5+9Ej1+BsAbozaheeyHNm4tTsndla3yjzWDI+MOVlDi0oWHsg5HeZIyFKWtl
         OVBxe0IiMHydk3kuXKkDO3x0Xsp73+p1ORTwXBeuKebhfAJVAJI+/oxJqOlghbMJBpFn
         hJWF+E6xiDLR+kmVwwhUGihGbF8pauLkMBAN827fxh3wQfEASYbu596wHw+tPQITr7BA
         chVugFHdmZ41iE1kMbYafWENRBsJIVCPzdAub2gE4V/LL+OYjUsSfyGH+TTQeooJTOLx
         J+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3UTKNVAFg81+ROQdV5mrZhJY+4YOTyh1X8nO1nYb4g=;
        b=azLfgpCBLZVqanIzP8roDtMh4lTfWimpD9ub2Shxu4GUgt4T2DHt0ZI7Daa0wPoCaZ
         vRtHc5w4ob/R1HP8FC+EZHDUkoe1RAcrP9usrj+SJYBBHgX15pFom6UC04t9vGDFN9O6
         eWoDBWHgAT9zvPGR6U2TMrIeSVCQCVktzKRguiBqHSvFb4Wokk7HsbJPvcqU+J94KKWT
         A1GckJCcFnMz46UhdhprAB6snL9wqU7XsV42Xq1kP6pZFJ0MsV093XfEN0w1gr3geHi5
         YTCdSQS7aBInmu8OIGo0oZ7ZiYgojqFgWTWSnTq5mUSK/GZB3Uwm3oCRoNtSUVihYdhz
         zAqQ==
X-Gm-Message-State: AO0yUKWQ+rzn9C1YZKaAFubU31e5u09E8PJ7XKbDVs3MHT4s3QYgm7oD
        1KzRK+trHywPoFDYomSExE8UhXLLSscxjtiyr4qwjQ==
X-Google-Smtp-Source: AK7set8aN8ctARJY3EvHdGouhuwjddqw9SrrC/PuRU22EMZKiuTqRZX7+gxn8KRIqKK3msj0InP2naeZlBKd7AJTE0w=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr2078814ejc.220.1675888455272; Wed, 08
 Feb 2023 12:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20230207025259.2522793-1-mcgrof@kernel.org> <20230207025259.2522793-3-mcgrof@kernel.org>
 <Y+HNL9RoP48tquGd@casper.infradead.org> <Y+PHPfiVS6EiTVl1@bombadil.infradead.org>
 <Y+PfqulG2wt0Y+Vr@casper.infradead.org>
In-Reply-To: <Y+PfqulG2wt0Y+Vr@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Feb 2023 12:33:37 -0800
Message-ID: <CAJD7tkZnaphPCrOTMjb0uM7HHqwJESaauNZ6Q58+QP1290Zd4A@mail.gmail.com>
Subject: Re: [RFC 2/2] shmem: add support to ignore swap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 9:45 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Feb 08, 2023 at 08:01:01AM -0800, Luis Chamberlain wrote:
> > On Tue, Feb 07, 2023 at 04:01:51AM +0000, Matthew Wilcox wrote:
> > > On Mon, Feb 06, 2023 at 06:52:59PM -0800, Luis Chamberlain wrote:
> > > > @@ -1334,11 +1336,15 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
> > > >   struct shmem_inode_info *info;
> > > >   struct address_space *mapping = folio->mapping;
> > > >   struct inode *inode = mapping->host;
> > > > + struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> > > >   swp_entry_t swap;
> > > >   pgoff_t index;
> > > >
> > > >   BUG_ON(!folio_test_locked(folio));
> > > >
> > > > + if (wbc->for_reclaim && unlikely(sbinfo->noswap))
> > > > +         return AOP_WRITEPAGE_ACTIVATE;
> > >
> > > Not sure this is the best way to handle this.  We'll still incur the
> > > oevrhead of tracking shmem pages on the LRU, only to fail to write them
> > > out when the VM thinks we should get rid of them.  We'd be better off
> > > not putting them on the LRU in the first place.
> >
> > Ah, makes sense, so in effect then if we do that then on reclaim
> > we should be able to even WARN_ON(sbinfo->noswap) assuming we did
> > everthing right.
> >
> > Hrm, we have invalidate_mapping_pages(mapping, 0, -1) but that seems a bit
> > too late how about d_mark_dontcache() on shmem_get_inode() instead?
>
> I was thinking that the two calls to folio_add_lru() in mm/shmem.c
> should be conditional on sbinfo->noswap.
>

Wouldn't this cause the folio to not show up in any lru lists, even
the unevictable one, which may be a strange discrepancy?

Perhaps we can do something like shmem_lock(), which calls
mapping_set_unevictable(), which will make folio_evictable() return
true and the LRUs code will take care of the rest?
