Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4174467D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 06:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGAEU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAEU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 00:20:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C0392;
        Fri, 30 Jun 2023 21:20:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso42214471fa.1;
        Fri, 30 Jun 2023 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688185251; x=1690777251;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ieZ7PQ+YkTc9/Zj7UCyMjkFHQlmorMSyXgXBxXnuMPk=;
        b=blmrfK0Qx/EUplhD4I0U86LtZfpxqmoo0wD6e3Q9oFekdw69lz8VwUdgrr3/kkxgE5
         lkwAJzh7/3kcGpzJ64XKbL5Ss83HqfttYRQni/P6Yerm7WhRKvafpFegoaC1WlSyx4kW
         PCFeuxYm01gA6k5kHOB6mhqPdFqpOxjrYMDSulLCJHBYJuQLp6K8OdtwDsl7dyC4y/zd
         dN+QdEoIegCDk5/JRZ1bXhwdtXxtrm+w3X+xXPoNDy8fsWkwFvjqOjA1NytdT+Ta0eEe
         S+H4UxZB+wGXEJgZPjki2I+OkXEJibKSlplvbEdsR45/RgNdic/QB2wOBn9BHx0BL6Qj
         YZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688185251; x=1690777251;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieZ7PQ+YkTc9/Zj7UCyMjkFHQlmorMSyXgXBxXnuMPk=;
        b=ECsWJeGzq0PRj7S991s+6IuidRu4ASxqyE+kz91hdw+H/CU+QukW4+5RVmaGmFZwQn
         RFCp2zFV6nQgIsTZXWyhMrSLvF+plIhI2aLVQq5f1t436aysH2GR9yqfH5c98IMg99Bg
         UU7soKJ4y2/6+4ppT6ZSOVOhDLXYq1HvH3EnxFzrIZF/+m1di9ky8LqU01F72syqFals
         6SzaRQ/5dDWN7Fla19NfrmL5ohuq4J3jE1CUGU4Kj+yjA5AmXBFdYcQNSHV7Ee2Dx9Yx
         lTCWVI9/PgwJKHVC0MRWsZO5v6CkCFMR44EUE2t0mL+kXkB4hfyGUra6R6zggUnhL/+a
         JVXA==
X-Gm-Message-State: ABy/qLZGEFJ6VjWzvrUQTDIxbT80+1fj0c74oWD/MiF2pRxOaW1r0top
        8TgV7PKzHjyCQ+6lfsB2Vpw2jbXHtqTbHHtJHE0uPD0xPmg=
X-Google-Smtp-Source: APBJJlGepU7JBelz7HwaKv5dFs2t8L+wRGlY13MUsWjRA2b2Gmy5iRNl3IEGiY3ukpfIieb8t17ozOU7856bciJRfss=
X-Received: by 2002:a2e:80d0:0:b0:2b6:9f4a:fce2 with SMTP id
 r16-20020a2e80d0000000b002b69f4afce2mr2947442ljg.7.1688185250637; Fri, 30 Jun
 2023 21:20:50 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 30 Jun 2023 23:20:39 -0500
Message-ID: <CAH2r5msFa0AjapQV_+bPf+upCNnCxppVgqkcDQP9GTh8o5bgdw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc-smb3-client-fixes-part1

for you to fetch changes up to 61986a58bc6abbb1aea26e52bd269f49e5bacf19:

  cifs: new dynamic tracepoint to track ses not found errors
(2023-06-29 09:58:09 -0500)

----------------------------------------------------------------
 20 cifs/smb3 fixes, 8 for stable
- Deferred close fix
- Debugging improvements: display missing mount option, dump rc on
invalidate inode failures, print client_guid in DebugData, log session
id when matching session not found in reconnect, new dynamic
tracepoint for session not found
- Mount fixes including: potential null dereference, and possible
memory leak and path name parsing when double slashes
- Fix potential use after free in compounding
- Two crediting (flow control) fixes: fix for crediting leak (stress
scenario with excess lease credits) and better locking around updating
credits
- Three cleanups from issues pointed out by the kernel test robot
- Session state check improvements (including for potential use after free)
- DFS fixes: Fix for getattr on link when DFS disabled, fix for DFS
mounts to same share with different prefix paths, DFS mount error
checking improvement

This does not include some caching fixes/improvements and reconnect
fixes that are still being reviewed/tested.
----------------------------------------------------------------
Bharath SM (1):
      SMB3: Do not send lease break acknowledgment if all file handles
have been closed

Paulo Alcantara (9):
      smb: client: fix warning in cifs_match_super()
      smb: client: fix warning in cifs_smb3_do_mount()
      smb: client: fix warning in CIFSFindFirst()
      smb: client: fix warning in CIFSFindNext()
      smb: client: fix warning in generic_ip_connect()
      smb: client: fix broken file attrs with nodfs mounts
      smb: client: fix parsing of source mount option
      smb: client: fix shared DFS root mounts with different prefixes
      smb: client: improve DFS mount check

Shyam Prasad N (6):
      cifs: print nosharesock value while dumping mount options
      cifs: prevent use-after-free by freeing the cfile later
      cifs: do all necessary checks for credits within or before locking
      cifs: print client_guid in DebugData
      cifs: log session id when a matching ses is not found
      cifs: new dynamic tracepoint to track ses not found errors

Steve French (2):
      cifs: print more detail when invalidate_inode_mapping fails
      smb3: do not reserve too many oplock credits

Winston Wen (2):
      cifs: fix session state check in reconnect to avoid use-after-free issue
      cifs: fix session state check in smb2_find_smb_ses

 fs/smb/client/cifs_debug.c    |  17 ++++---
 fs/smb/client/cifs_dfs_ref.c  |  20 +++++---
 fs/smb/client/cifsfs.c        |  30 +++++-------
 fs/smb/client/cifsglob.h      |  10 ++--
 fs/smb/client/cifsproto.h     |   4 +-
 fs/smb/client/cifssmb.c       | 211
++++++++++++++++++++++++++++++++++++--------------------------------------------
 fs/smb/client/connect.c       |  92 ++++++++++++++++++++---------------
 fs/smb/client/dfs.c           |  96 ++++++++++--------------------------
 fs/smb/client/dfs.h           |  19 ++++----
 fs/smb/client/dfs_cache.c     |   8 +--
 fs/smb/client/file.c          |  25 +++++-----
 fs/smb/client/fs_context.c    |  59 +++++++++++++++++++----
 fs/smb/client/inode.c         |   4 +-
 fs/smb/client/misc.c          |  55 +++++++++++++++------
 fs/smb/client/smb2inode.c     |   9 ++--
 fs/smb/client/smb2ops.c       |  31 +++++++-----
 fs/smb/client/smb2pdu.c       |   6 +++
 fs/smb/client/smb2transport.c |  12 ++++-
 fs/smb/client/trace.h         |  20 ++++++++
 fs/smb/client/transport.c     |  20 ++++----
 20 files changed, 403 insertions(+), 345 deletions(-)


-- 
Thanks,

Steve
