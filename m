Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6C6F93FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEFUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 16:45:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04372D401;
        Sat,  6 May 2023 13:45:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so3556992e87.2;
        Sat, 06 May 2023 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683405936; x=1685997936;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MEugINQdUm3f7YxPQfaXjELKCaf43ILlW7WiVWB4tUQ=;
        b=dTxPpfGLIposVgzaeUUbZC77KVnT6R3R+BDNv7VqRgAqvAa8ZeXi1zpe4LXk1YOLaq
         4rMfltpXSlSbXQesNAbAPRizILmhWqYm5rPoAvWnas3/rhVdtvehexlMl1cdsBZPoOl+
         SuY+3f7RfSaSOWcFfh1y92/5vhjzFUHvSA1UH5aIHOS2GSs7MeQ5cjswETcMubBpA9zd
         NmAnAuXzQX0RipVVRw8lodEk38SCYyABKdcprZ/e+2nvMCsnAav7AAoGtlwmhqkvuD+l
         QAJsFDtLU+LpL+FsyuDQl+1xcxYqckw+7aUzMzaQOt8qXG6o61YmuNB39uriGZSFfRp+
         Stmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683405936; x=1685997936;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEugINQdUm3f7YxPQfaXjELKCaf43ILlW7WiVWB4tUQ=;
        b=AGLGtkJObmDSKbdWUgMI7NldjhEkeEQaf0e3JfSSXsp5ef7N0xy11kxGS+1NzlAw7w
         fxX+FG2LToW8u4tqLqjT6JWDsaedHRlPuMiQLZn02IBi2Df2wUiN37R3yandund0oofs
         c8DKTDcfStDITC1QxMnjVRdJNAxLnhvad9I3kbVCGXlX0IOj2Fdo5fnzWZhspfptt9HE
         /NoGnPGtU8wmLKjy1tttLdI5PChqS80E4rZyfxToX8PXJ1N8mHxGBkTLnxRWyl14m7cp
         suMEszn4gfZrhmMeOuYQq0JQbP3yph6xLNKPHMRyCQd4SO/RbZOSQ209mNf/YzhvIKdz
         WdWg==
X-Gm-Message-State: AC+VfDwWlvNGz6AmNPHGTuh4NYL90HRqW9K7iLdnWgpjA2G09sVrogaW
        ryLFe/SKTm+WQfBpbX39G9hCLdgWqKbYnHen1MtscX7SN8k=
X-Google-Smtp-Source: ACHHUZ7lt3jYpv+7YL4nxgqYJ8sQ+4jw7kh2kJHRP6S03fyfRPKfy0FE5y9K5tEGnF6XmCabrol6KXbGHR6X9mGWbJA=
X-Received: by 2002:ac2:4196:0:b0:4ef:d479:a391 with SMTP id
 z22-20020ac24196000000b004efd479a391mr1404382lfh.45.1683405935774; Sat, 06
 May 2023 13:45:35 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 6 May 2023 15:45:24 -0500
Message-ID: <CAH2r5muHUgLTaYUcWWEucCmdBR=JHgEAC+oPePBgLVKpJxHYVA@mail.gmail.com>
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
26c009dffca89b0f8fe7facc41d1ccf88a66825a:

  Merge tag '6.4-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2023-05-01 10:43:44 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc-smb3-client-fixes-part2

for you to fetch changes up to 9ee04875ae73412f5071f6ec1af01788ec271e7c:

  cifs: Remove unneeded semicolon (2023-05-05 04:29:58 -0500)

----------------------------------------------------------------
9 smb3 client fixes, mostly DFS or reconnect related (six also for stable)
- Two DFS connection sharing fixes
- DFS refresh fix
- Reconnect fix
- Two potential use after free fixes
- Also print prefix patch in mount debug msg
- Two small cleanup fixes
----------------------------------------------------------------
Paulo Alcantara (7):
      cifs: protect session status check in smb2_reconnect()
      cifs: print smb3_fs_context::source when mounting
      cifs: fix potential use-after-free bugs in TCP_Server_Info::hostname
      cifs: fix potential race when tree connecting ipc
      cifs: protect access of TCP_Server_Info::{origin,leaf}_fullpath
      cifs: avoid potential races when handling multiple dfs tcons
      cifs: fix sharing of DFS connections

Steve French (1):
      SMB3.1.1: correct definition for app_instance_id create contexts

Yang Li (1):
      cifs: Remove unneeded semicolon

 fs/cifs/cifs_debug.c      |   7 +++-
 fs/cifs/cifs_debug.h      |  12 +++---
 fs/cifs/cifsfs.c          |  14 +++----
 fs/cifs/cifsglob.h        |  23 ++++++-----
 fs/cifs/cifsproto.h       |  44 ++++++++++++++++++++-
 fs/cifs/connect.c         | 141
+++++++++++++++++++++++++++++++++++++------------------------------
 fs/cifs/dfs.c             | 137
++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 fs/cifs/dfs.h             |  13 ++++++-
 fs/cifs/dfs_cache.c       | 133
+++++++++++++++++++++++++++++----------------------------------
 fs/cifs/dfs_cache.h       |   9 +++++
 fs/cifs/ioctl.c           |   2 +-
 fs/cifs/sess.c            |   7 ++--
 fs/cifs/smb2pdu.c         |  21 ++++++----
 fs/ksmbd/smb2pdu.h        |  16 --------
 fs/smbfs_common/smb2pdu.h |  20 ++++++++++
 15 files changed, 376 insertions(+), 223 deletions(-)


-- 
Thanks,

Steve
