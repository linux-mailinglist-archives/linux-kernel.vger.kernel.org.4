Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD26D341A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjDAVdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:33:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C47FDF;
        Sat,  1 Apr 2023 14:33:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e9so11336766ljq.4;
        Sat, 01 Apr 2023 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384790;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5VegHT0J88UW3h2u7j2HGa/Un6298+OaL4En3w2TQk=;
        b=TDb7GsuEUv/YOdA+RukCA0z6/DAceAV83ELAyW9fsLccMrZZ2xTq5TfU6Pdcah3BY7
         Kl1qTlSN8HkYMCIpo6eZ3iibmc76ulOBmut/3zDdnWjX1hxyvH9OeigMSi96gBgAQxny
         ngSp6GX3Cj3MJnD50JH41tW10JRLg6RLimZMT1H/ZqKNy30lqIoMp/5SMLVlQ3DXmnQa
         LHE3PYdSEC9vJ9O2as2ncwvI8ITAeMwSwxotyo1yqlty2k3gkI9BL1Bn5wIT6QO4IKRe
         sfTFMJ27S/ctq3RViarg9wbuEnM4VeyiQws68iKMvNcpyJbbVduQoXgv/M+uvDzAILNe
         jVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384790;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5VegHT0J88UW3h2u7j2HGa/Un6298+OaL4En3w2TQk=;
        b=gkKmkYSZDQrH3Cf9kD/2oy7gGLtP9U11qTd1qdfpGDF/1+J0yJS5fmTU5a8D6LImRD
         26j07iyLvf5rEFG3rZGB0y5Dz02n3cz/9Xo5zQ/rN1vWkJawGFAO+lKidnbSFfOXl1Xr
         gUfhLBLTP7OG8QD4VLI9JPPvJPFFcbk63mkMXmtdn0w4q5F8HuA7RYF8uREr6GW3AvQk
         9D1PEVMNUXZNOJxBKGIuAV+4kQFP3Tpge7KMDbTj/FxllCU+r2NrD7gmjgc9tPSlKeAW
         Kr0fBTLNP8LOtEJ1r5um+w7UnN34NPHFwxCdLtMrGs+mkhc3n+6XJHcEA0reAB2HJlWa
         LI4g==
X-Gm-Message-State: AAQBX9cotaBenY772cc7ZwO/RyfFSbg9CrEgmHTgFNNaoa5j+2qJsbYf
        j7KtIUEReCEj3CT+7057CJ2kRKWXzYAmXTq49Vvg+wnqYzE=
X-Google-Smtp-Source: AKy350Z0DObfW5Q9yg5lOg7UHJ3kSY1lVs7ja3tjTpjZxsiJyEgj1DcwbhQgK/uPYzn3zwyY+nsgy/kASUt41qCEeaU=
X-Received: by 2002:a2e:9c0f:0:b0:299:ac5e:376e with SMTP id
 s15-20020a2e9c0f000000b00299ac5e376emr9619921lji.2.1680384789340; Sat, 01 Apr
 2023 14:33:09 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 1 Apr 2023 16:32:58 -0500
Message-ID: <CAH2r5mtvRF98xs3FCjc+WcfdR2wNVLNTqn=h+rYvtkj22T2f4w@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc4-smb3-client-fixes

for you to fetch changes up to e03677100707f849f01d8faf07ee58b4e56cdbf1:

  cifs: get rid of dead check in smb2_reconnect() (2023-03-30 17:56:30 -0500)

----------------------------------------------------------------
Four cifs/smb3 client (reconnect and DFS related) fixes, including two
for stable:
- DFS oops fix
- DFS reconnect recursion fix
- An SMB1 parallel reconnect fix
- Trivial dead code removal in smb2_reconnect

This P/R does not include the important deferred close lease break fix
(additional changes were needed for that).
----------------------------------------------------------------
David Disseldorp (1):
      cifs: fix DFS traversal oops without CONFIG_CIFS_DFS_UPCALL

Paulo Alcantara (3):
      cifs: avoid races in parallel reconnects in smb1
      cifs: prevent infinite recursion in CIFSGetDFSRefer()
      cifs: get rid of dead check in smb2_reconnect()

 fs/cifs/cifsfs.h  |  5 ++++-
 fs/cifs/cifssmb.c | 30 ++++++++++++++++++++++--------
 fs/cifs/smb2pdu.c |  1 -
 3 files changed, 26 insertions(+), 10 deletions(-)


-- 
Thanks,

Steve
