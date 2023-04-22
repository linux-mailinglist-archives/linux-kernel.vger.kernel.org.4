Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86086EB6E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 04:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDVCoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 22:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVCoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 22:44:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E761BDD;
        Fri, 21 Apr 2023 19:44:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so22231251fa.2;
        Fri, 21 Apr 2023 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682131441; x=1684723441;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmYMBz/pk0DU4VGRxAFjF6yuTpyNNQBkmRkwo1EeINY=;
        b=qTPJaFBm9gzL4Vm/5Trp3iFKH/6dzpEKYUwlEdLQIhkBuIJ1kc/TZemt6GAlP2mz4J
         4QMWcFW/V5bo1AV4HL+t+d/0iEA4wko9d4EWGjrFXa+F9driga6b+bvGdfHHUd3sX6Ft
         rbn4E+M4nzTOWcC9lf8jYyG1wUZFx6Ez7+546i/TVyiYYQKqBrdwhdoV8EUiy2NsOffq
         BGcWGwAFoRIWwFleQXeaxS0IN0IHrMd/wggGwopwPy5q3Opov5DayzXhLhlMcT1x3RFt
         SFGgh7smteFQ7dOC21v9XDeUTa/lyiKN7Dlr/muaTIHDURI+vE1lD61HlQzG1ySJqPmd
         ywIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682131441; x=1684723441;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmYMBz/pk0DU4VGRxAFjF6yuTpyNNQBkmRkwo1EeINY=;
        b=HN4xRvg2bgowTZ00HmDyJj1/o0nWPzxE56r8NDTjO8xPTQdG8uOBlOznVtHrxnlR9j
         BAs+UNxKSi/6QUXGbzVFiX0F3Ae5X+wO7SxKVtVty+MjJ7kXGCVKfmigBEtXbdsUwZli
         /J4zYuy9jJUFe5QKw7bMSlsMGxYFHingyVI6m4r8bBdj7BUNnLe9CLt+Pz40BvOawvLx
         4LRacahfNOsOkUYjRdhhojnRqiK08gRCNGLCF4fhz8jCfwxf7tR6it6By8po48VWB9Gj
         7XtH7rMAmg9j6KclCLCgBX2PhJGSoDWlzEYkTQBgdI34cRz38sxn8IEX5vcW1qJnklxB
         0Ltw==
X-Gm-Message-State: AAQBX9f04BiRyWNjf+Y3D2RWENB1oNTUYChx3c5hasvQ8ue9Wx/K6o47
        QAiyg6e+rfJMWYPqwa7pjmdDsmZuOgOYIeFWXic=
X-Google-Smtp-Source: AKy350Ys4Ps/1P+uCixPXp3IPEKj+hO7XXuZq5a4Ux8qkst0rDv2fzjGEw12cBtJsI+RfyL4JZ3EVRm/UoKeICmTq+U=
X-Received: by 2002:a2e:88cd:0:b0:2a8:b076:3877 with SMTP id
 a13-20020a2e88cd000000b002a8b0763877mr1001553ljk.10.1682131441387; Fri, 21
 Apr 2023 19:44:01 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 21 Apr 2023 21:43:50 -0500
Message-ID: <CAH2r5mu1-3LwONaQGR5B9XSWTupdvK9SSSk3Pm-V5bGZdFeCqQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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
6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc7-smb3-client-fixes

for you to fetch changes up to 023fc150a39ffe656da3e459ad801eb1c7fdfad9:

  cifs: Reapply lost fix from commit 30b2b2196d6e (2023-04-18 21:26:09 -0500)

----------------------------------------------------------------
Three small smb3 client fixes
- two important fixes for unbuffered read regression with the iov_iter
changes (e.g. read soon after mount in some multichannel scenarios)
- DFS prefix path fix (also for stable)
----------------------------------------------------------------
David Howells (2):
      cifs: Fix unbuffered read
      cifs: Reapply lost fix from commit 30b2b2196d6e

Paulo Alcantara (1):
      cifs: avoid dup prefix path in dfs_get_automount_devname()

 fs/cifs/cifs_dfs_ref.c |  2 --
 fs/cifs/dfs.h          | 22 ++++++++++++++++++----
 fs/cifs/file.c         |  4 ----
 fs/cifs/smb2pdu.c      | 10 ++++++----
 4 files changed, 24 insertions(+), 14 deletions(-)


-- 
Thanks,

Steve
