Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6038B70AC68
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 06:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjEUEwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 00:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUEwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 00:52:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CAB10D;
        Sat, 20 May 2023 21:52:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso37695201fa.0;
        Sat, 20 May 2023 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684644768; x=1687236768;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ssxyagVOAxt3HHQzIYOHijwAfZDoWnOE3z1Qpaea4c=;
        b=ariHR1YGrH5mOH+TZqaDROY/z1vODsvPVOY1mCkD/COYTEGrZCkC8BLDrRodoPCuAj
         C1hojbSeVXwYe/ib3pQL1wKlBcbNOFc31gapPl8Adnonh6tNwYZrm0Os6nNA3JTumull
         +SSBmiWqb2xiKkwPRc0nfcjIUSHNCpqtlqVb1GdQhj+z2bXCQHfMZL1Pa0F6/7OsmkBJ
         IGDFAltH+PgaVA0QgDu1nRmAPVeYU24nRTn04Mfyn91I9nzxbFyfbiEjJlERlwOnu+Tx
         1Xs+bv6LXQPHuTZJHjkYYwaWKsA0NoryCwVTwvdc1ohVc6+HZFBaJu+hUrN/ajVa8bef
         yzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684644768; x=1687236768;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ssxyagVOAxt3HHQzIYOHijwAfZDoWnOE3z1Qpaea4c=;
        b=KG14pC0auYxp4fi5pZNV4PO45mSwlD19cRAUtt3fRwImQn94MF9WLMoEooJiy9SILT
         3TFh9lQtliyQIqP0t9VesIIFydvmD3e0Dh70rfFIMylmzeu1uOgM8hh+RDIIG5qpYb74
         Xvz49Gfo1QWgl0xeg1boBYaKPLT90q7z6qofdMz6rAv5MK6F1IPCp7FLIvchUGdnWANt
         XRd5iWbhXO55nbgSm7CEe51ip970v5o+lIKseY5fT89tiyAE0URpxFL8zfXv8lctT02c
         sLgxOmNeUzbEA+4VuhEUO04CkeotmGZgFzCOBRvl0ZUUa5ZV7jXUMU/QsNNdwBmjMKfb
         /tEw==
X-Gm-Message-State: AC+VfDxIjGp4+Zw+ypMJo9fYSMUhqyv7JaBvMjYIRQ1wcAt25ZWTfwrY
        mV2AhdrrHruJLfjnbzxhbBnFnq8P1Uud7+tS0agucUCae8U0FILu
X-Google-Smtp-Source: ACHHUZ6n1svPwI6NcRhyCYGSqjhVAf9LGu/L62JJ6qJpa/Jo+cRDuYCXVBKiTGoQt4npa09OSoWMSCS7BCiMFJ+/HhE=
X-Received: by 2002:a2e:3213:0:b0:2af:1eee:84af with SMTP id
 y19-20020a2e3213000000b002af1eee84afmr2733099ljy.26.1684644768154; Sat, 20
 May 2023 21:52:48 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 20 May 2023 23:52:37 -0500
Message-ID: <CAH2r5msKAPYH17pZOiZ8Mv2FV96HpAQ5P0+KVXv+uG=uvb0tZw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc2-smb3-client-fixes

for you to fetch changes up to 59a556aebc43dded08535fe97d94ca3f657915e4:

  SMB3: drop reference to cfile before sending oplock break
(2023-05-17 12:04:41 -0500)

----------------------------------------------------------------
2 smb3 client fixes, both related to deferred close (also for stable)

- send close for deferred handles before not after lease break
response to avoid possible sharing violations
- check all opens on an inode (looking for deferred handles) when
lease break is returned not just the handle the lease break came in
on.

----------------------------------------------------------------
Bharath SM (2):
      SMB3: Close all deferred handles of inode in case of handle lease break
      SMB3: drop reference to cfile before sending oplock break

 fs/cifs/cifsglob.h |  4 ++--
 fs/cifs/file.c     | 26 +++++++++++++-------------
 fs/cifs/smb1ops.c  |  9 ++++-----
 fs/cifs/smb2ops.c  |  7 +++----
 4 files changed, 22 insertions(+), 24 deletions(-)

-- 
Thanks,

Steve
