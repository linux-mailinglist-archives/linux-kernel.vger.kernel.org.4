Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C970B72AFF6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjFKB7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 21:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFKB7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 21:59:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D087CD9;
        Sat, 10 Jun 2023 18:59:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1afe57bdfso35244661fa.0;
        Sat, 10 Jun 2023 18:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686448757; x=1689040757;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LYs5rPa9oP57vlaop+owTExqq9+WAq3Isnwpx5mzptM=;
        b=HW0T0k3XyB/TIhFtLRhqSaarGDJoXGHAAgFtPMcBHbX7mvZTEufbs6azhF0h9s7Uss
         uuWsjOeMEaYoTDBuiAtUyPsMg4PigUKVoDolYpGWM+eZB9jnjOVas7Xoah331Xh4tcuH
         0+W5BiDS9wbYzilMO+Gb7yehs+0k55hTMSLqnO7WNh1yqPn5yZYQKdVBO3D0nd6mEe+c
         hLB02V2VKyevA/cV/se2m706JIdTZN1WJaXqXTYmN5ReARxhV0JtqzBRXjtjBc6a9pv/
         HnFoSdhXK/4Bmdxq9L0VRyMMam1sPY6gbDwlPjBpQ5QaRh89bPw6Xq78zRBNKRragbpn
         SSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686448757; x=1689040757;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYs5rPa9oP57vlaop+owTExqq9+WAq3Isnwpx5mzptM=;
        b=T3D6zMc0IsM2fSdc0kviumLdOXW8zv/mlBa7w1PiYHX16x6eq8UGZfE696sjz9KBfH
         1ZYCSGoCrA4p56cMwDsvAIcvRq0LhbFeF21SXtmdpgnvv2G03tvDCWS100jaVuVSd438
         jUEOzgFNlx7h7aJ2kAgghL0PCloatyu9q6pkY4920Ru/o26boSfzE3COtiNSwgzWAMMx
         nh2dI41N4XqsjvVisaICLSdRtEOsTXHM+N08Qnqk1a7+usnelV9aUIqovZplZjeYLFEc
         EpDUIAKpo/b+wRHkYA93TEsdKPrzmTpNXmMXLokGY28Bk/no4mSRWqrjwTg8NNtuJiP4
         LgGQ==
X-Gm-Message-State: AC+VfDyTyxO/4WfLIUs0C4NQmgCPiGvtMMdUrqyYzMKycw41jjeidKVe
        8pbacbIH1uE8uwylNmCyUmm5LpzNbBYlF92q0KPnfGUvrTaqKA==
X-Google-Smtp-Source: ACHHUZ5rWtll5ZRcBCEkIjsZYMx/SS+KmkNfmQkBVuC5FyWlRJQNE592UCLssDqUCOoc8iTizKA4GV2ZwMo4gIp1Sqk=
X-Received: by 2002:ac2:4985:0:b0:4f3:a485:919a with SMTP id
 f5-20020ac24985000000b004f3a485919amr2188425lfl.57.1686448756747; Sat, 10 Jun
 2023 18:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 10 Jun 2023 20:59:05 -0500
Message-ID: <CAH2r5msURVv3pndri8KF4iL74L8PJjMO6Rd7sWDuLanpmmRffg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
8828003759391029fc45c15ac346622cdae19b6d:

  Merge tag '6.4-rc4-smb3-server-fixes' of git://git.samba.org/ksmbd
(2023-06-01 08:27:34 -0400)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.4-rc5-smb3-server-fixes

for you to fetch changes up to 1c1bcf2d3ea061613119b534f57507c377df20f9:

  ksmbd: validate smb request protocol id (2023-06-02 12:30:57 -0500)

----------------------------------------------------------------
Five smb3 server fixes, all also for stable
- Fix four slab out of bounds warnings: improve checks for protocol id,
   and for small packet length, and for create context parsing,
   and for negotiate context parsing
- Fix for incorrect dereferencing POSIX ACLs
----------------------------------------------------------------
Namjae Jeon (5):
      ksmbd: fix out-of-bound read in deassemble_neg_contexts()
      ksmbd: fix out-of-bound read in parse_lease_state()
      ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
      ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
      ksmbd: validate smb request protocol id

 fs/smb/server/connection.c | 17 +++++++++++++++--
 fs/smb/server/oplock.c     | 66
++++++++++++++++++++++++------------------------------------------
 fs/smb/server/smb2pdu.c    | 13 ++++++-------
 fs/smb/server/smb_common.c | 14 +++++++++++++-
 fs/smb/server/smbacl.c     |  4 ++--
 fs/smb/server/vfs.c        |  4 ++--
 6 files changed, 62 insertions(+), 56 deletions(-)

-- 
Thanks,

Steve
