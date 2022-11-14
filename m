Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF416628758
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiKNRoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiKNRoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:44:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C120372
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:44:06 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso11364725pjc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MeB9KIeorRlixL8XK3tg5BcUFWGpkh0d9PY4NprEDPs=;
        b=KYrsWy+wucAjvuhZX9uHUMtOkfqkqzRzUrLr7Pfsn3bdnEePoP2tc0zpr4I4TpVMll
         mGXbcFJ10cwho779cCkH5dM2uZKKvGNE7L3e5UFHFQQt0NRafv1cm0RJ1Nq+Qg7L505g
         RTWmoLBgMLCylQcEa6ALxEP8oE2lSkRO6p2Gf38VJwzZP6/eO7aByIG3kCcUPG7Ue5QH
         uQtdQnd289NFmlYGtwCeUURetV6F18A4D+SwnZWy7FN4D+rxHfOeOCkASjrLOnHtJZen
         lNxpJJXOkhBzB6MebcsXJiRAueQbskdUwv8SNz0pQGEoheReC3AY8WJhid8gJdKOoFQY
         CdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeB9KIeorRlixL8XK3tg5BcUFWGpkh0d9PY4NprEDPs=;
        b=pkc9NOETuvJ92FMn/2RknHIzs+7euF+2tfLO1KJliDgx7bEoWbzdJ6/75334JIjuyr
         woq02+pbmmA05i11sS/EV7Xrljg4mp3WT48SUelURQlb6nxeTioqZQWg8Wg825CrEXBX
         EXt8x1+y4lFc6N4krKNVE3VmjaN0qgEhKF8newFY7R4qgvh8OnyPzvGgbp7WHsAiBDEM
         yb+Sn4XU88aiq8/yjEJ9zLWoVTb969sVGYIMPku6fLAQ7iTbZqmuI3s0/Dn4JGZhym2q
         GI/pM2dRaCNg52eQdFYPvCYHvVdWido5XQNBwtkCkMzf/MqISvvag7kfgysN/ax6B+h1
         0ZDw==
X-Gm-Message-State: ANoB5pnad77k6AQbxW2Ifw5cn7u++mZOXjWaOzoLJukWw4wD1e4FsiH+
        50J3pytDna/1RdxWvIsCB4UzqPgvNmKNkHJFid+QDA==
X-Google-Smtp-Source: AA0mqf7+5yEM8rsOyk/T9vkrhUx7kBkYpnXVDXEL6ePoieKEPUVFRYG/0MTLadfmlZFW5VxZh4JQOCHyQyZauj5Rhsk=
X-Received: by 2002:a17:90a:4e8c:b0:213:d7cc:39cb with SMTP id
 o12-20020a17090a4e8c00b00213d7cc39cbmr14629908pjh.144.1668447845530; Mon, 14
 Nov 2022 09:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20221113152439.2821942-1-feldsherov@google.com> <20221114104653.sosohdhkxry6xkuc@quack3>
In-Reply-To: <20221114104653.sosohdhkxry6xkuc@quack3>
From:   Svyatoslav Feldsherov <feldsherov@google.com>
Date:   Mon, 14 Nov 2022 19:43:54 +0200
Message-ID: <CACgs1VBy6Mww_iOgtY7Brryi_ofbrAO1yud8zyBer59hhSAUGg@mail.gmail.com>
Subject: Re: [PATCH] fs: do not push freeing inode to b_dirty_time list
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for looking into this!

On Mon, Nov 14, 2022 at 12:46 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 13-11-22 17:24:39, Svyatoslav Feldsherov wrote:
> > After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> > already has I_DIRTY_INODE") writeiback_single_inode can push inode with
> > I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> > I_DIRTY_TIME set this can happened after deletion of inode io_list at
> > evict. Stack trace is following.
> >
> > evict
> > fat_evict_inode
> > fat_truncate_blocks
> > fat_flush_inodes
> > writeback_inode
> > sync_inode_metadata
> > writeback_single_inode
> >
> > This will lead to use after free in flusher thread.
> >
> > Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> > Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> > Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
>
> Thanks for the analysis! I was scratching my head over this syzbot report
> for a while and it didn't occur to me somebody could be calling
> writeback_single_inode() from the .evict callback.
>
> Also what contributes to the problem is that FAT calls
> sync_inode_metadata(inode, 0) so it is not marking this final flush as data
> integrity sync and so we happily leave the I_DIRTY_TIME bit set.
>
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 443f83382b9b..31c93cbdb3fe 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1718,7 +1718,7 @@ static int writeback_single_inode(struct inode *inode,
> >        */
> >       if (!(inode->i_state & I_DIRTY_ALL))
> >               inode_cgwb_move_to_attached(inode, wb);
> > -     else if (!(inode->i_state & I_SYNC_QUEUED)) {
> > +     else if (!(inode->i_state & (I_SYNC_QUEUED | I_FREEING))) {
> >               if ((inode->i_state & I_DIRTY))
> >                       redirty_tail_locked(inode, wb);
> >               else if (inode->i_state & I_DIRTY_TIME) {
>
> So even calling inode_cgwb_move_to_attached() is not safe when I_FREEING is
> already set. So I belive the I_FREEING bit check needs to be before this
> whole if block.

Agree, let me move the I_FREEING check before this if block.
The commit I am fixing didn't change this codepath, so I suspect there is an
implicit invariant which keeps inode_cgwb_move_to_attached call safe.
But I am 100% in favor of making I_FREEING check explicitly.

>
> I also think we should add some assertions into i_io_list handling
> functions to complain if I_FREEING bit is set to catch these problems
> earlier which means to be also more careful in __mark_inode_dirty(). But
> this is for a separate cleanup.
>
>                                                                 Honza

Sounds reasonable. Will look into that afterwards.

> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--
Slava
