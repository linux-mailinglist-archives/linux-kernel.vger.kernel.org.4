Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D3074C0F5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 06:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGIEj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 00:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGIEjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 00:39:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A5B6;
        Sat,  8 Jul 2023 21:39:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fba86f069bso5154046e87.3;
        Sat, 08 Jul 2023 21:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688877562; x=1691469562;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wKe5r1gQ6s1Ey9/fn+Twfv7UiGM4dBpxhjxuitBrABM=;
        b=CYY8hWw3F+AjKemNEUbJzoooZCZvy5OR9kdGSeTiaobLNuusIyEkL7S0081BbeMnib
         0b6bQMBqpw9I/mtHG2Okw9YRVvRYRQ2QLDVz947Kh5Nks35vWo/6Cx85RA5JyqoxaEny
         sVw+q0h/ZfTcs7TJ/0O0Kb3T2YwJuYkhWfz4ZSdg6A8oVJ6dVX1Z/UZvz3OPqP9+ek64
         ZhoUfj1+HXC+aSorm5kOXDCBA2oyH2XsAyaTmFYh4PveqagIK7sz5lnjTgrdpQXX7d2/
         eNhYZqd84wkZSKiife5j2RJ8fcSnAv57fl4Qk1muCneD3zsD+35ZKYEiLraiaPGMik1W
         xvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688877562; x=1691469562;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKe5r1gQ6s1Ey9/fn+Twfv7UiGM4dBpxhjxuitBrABM=;
        b=SZvuPtmuv6mvHQpY7o8DtLZluh9s3KeAstsAzqP9Pr1aJ1air0YOq8BFpc3ogV46Sw
         oK5JvDPLAHcxTFccwKQ0ZHN5tHpd9PcnERDUk36G00kdOwUNrttkDWkFgtBu7UsONsjt
         B0gK6jSys8/Wd8RT1m40tEXAIZ+HMMClwSJ4wwLq+q5MPDZZ1BfbhccVC3GyoOUEE+PM
         BZiOnzghw2eF+ah8rPySCIrxV3Nj4X39J4Hxm7SRlwPIsu2JAemZEiBglkpyugBFOVjy
         a9FTkvP+Lhmdw2kl0yl/8nskUqzE4oFkq0zFiRJI2IbS/AlOA7rKMq9xFLlQlBK8eizG
         IUfQ==
X-Gm-Message-State: ABy/qLYSWDuqO04KNS8JiaOsbq9xjH2OtLtvZoLS2weaedVwUJZWbH4q
        0dDAvEWblD0Q0HtofIzFSss4OJLRYuZt2H+16cKJlu3KqxY=
X-Google-Smtp-Source: APBJJlFVFpsoJvbQX1IbloX7CIMWuRW6aa4+6zIu2+kNh/iMPVwASFCofJexSC58earMPlmkTIoHUB5vp96bESes1/M=
X-Received: by 2002:a05:6512:3157:b0:4f8:7617:6445 with SMTP id
 s23-20020a056512315700b004f876176445mr6577459lfi.48.1688877561411; Sat, 08
 Jul 2023 21:39:21 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 8 Jul 2023 23:39:10 -0500
Message-ID: <CAH2r5mv9U44-ypmJam9KTWNky=8+TOPsv=cdWj3sRd6DPjhU1Q@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
a507db1d8fdc39802415e4d2ef6d1aecd67927fa:

  Merge tag '6.5-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2023-06-30 22:00:28 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc-smb3-client-fixes-part2

for you to fetch changes up to d14de8067e3f9653cdef5a094176d00f3260ab20:

  cifs: Add a laundromat thread for cached directories (2023-07-05
22:36:07 -0500)

----------------------------------------------------------------
3 smb3 client fixes;
- fix potential use after free in unmount
- minor cleanup fix
- add worker to cleanup stale directory leases

Not included in this P/R is the follow on patch to allow this timeout
to be configurable at mount (is being tested), as are a pair of fixes
for some cases where stale metadata can be incorrectly used, and a fix
for O_DIRECT is also not included (still being tested).

----------------------------------------------------------------
Colin Ian King (1):
      smb: client: remove redundant pointer 'server'

Ronnie Sahlberg (1):
      cifs: Add a laundromat thread for cached directories

Winston Wen (1):
      cifs: fix session state transition to avoid use-after-free issue

 fs/smb/client/cached_dir.c | 67
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/smb/client/cached_dir.h |  1 +
 fs/smb/client/connect.c    |  7 ++++---
 fs/smb/client/dfs.c        |  2 --
 4 files changed, 72 insertions(+), 5 deletions(-)


-- 
Thanks,

Steve
