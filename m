Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A436F2961
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjD3PfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3PfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 11:35:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB719A6;
        Sun, 30 Apr 2023 08:35:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso15465351fa.0;
        Sun, 30 Apr 2023 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682868916; x=1685460916;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ZsFoZX2gI1MlEhPRWk4v2TPDpNZTyJdaXiY+J/jwtQ=;
        b=XiCfF+J+ln5UU8cEjv9JPcK4vuF11pXkZNspKxuI1dZCBABQcSjC8A4sKqf+IWWZhU
         2zL5NQg1OG8+t1w5C03GKFHX9NdJ05qHSpxN1x+kXtLtnYGwcx4rlQU0lkhKjmGiLMXM
         7a5HN7dirpAtHnwWK9m0F9zt1aC7dDH8iTzgKLAnKJbK5xs+JRwFGuKEmdBkvNnPQKJb
         M5zu8lNQScKZBIkeOpVJjbFptiT3C0CyNGg0VWhza9Hu2M0Fqt2K2RYmwjevm/Qbam3X
         GUZV3KCQVjth44n7q8S+AlZTURQZiV+Q7xwndg/5UgCHbG70VVpne+PR03KnFNkKo6YO
         ES2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682868916; x=1685460916;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZsFoZX2gI1MlEhPRWk4v2TPDpNZTyJdaXiY+J/jwtQ=;
        b=UyCw9pkMJqKcm2R78BfV9+ULA0yR4gqSGBGpWCw5iCCFDCR+c5nhmJe2XuogtfOv7G
         cetWWSZwzHgWaZFFpQVm3/1jKSZUyePLwikhxgFZbGLMsRxRKwaIIElWaff+FaajshCA
         4K9eOsal68pO4PW0g9VtSBJ80jziQ+Pet00BPspCOpg2OBnmIe3WgAgMAEFAdxC+35GS
         P/f8JMCXx1SuXVON5uoI5jHLFDeKgxdWIGJl6QvvRqmbnXBtGmsLiCFepm1NBsTBNTke
         1o8Aokb+2IrzpwstvIz6+XIO5Nf9C9vO/L+wh5ukzQvggRIhhKyWQW1wqM+mjebjU65w
         D40Q==
X-Gm-Message-State: AC+VfDzslnFIlAjwUUycrtzu6PBbZsNepJsaBPzbbWprLjl3uW8iqrjd
        ycq55fg6E/e9tY2HoNnhSpNEA50LvgteGqu4cRPuyscW8TY=
X-Google-Smtp-Source: ACHHUZ4yh7IfKnRp+4eHLpFQSKiuHxs2nEBBpGJHL093qA04q3PrpDLUoBlCgSRXKa4qGoWpKvnA8g7YuytTuohZzY8=
X-Received: by 2002:a2e:3609:0:b0:2a8:ab4c:3599 with SMTP id
 d9-20020a2e3609000000b002a8ab4c3599mr3458558lja.35.1682868916039; Sun, 30 Apr
 2023 08:35:16 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 30 Apr 2023 10:35:04 -0500
Message-ID: <CAH2r5mtWYqepZSYBvSbC5AHiJv70ETtNobBbSH1Oc2K=2qO6UA@mail.gmail.com>
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
457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc-smb3-client-fixes-part1

for you to fetch changes up to 9be11a69315e26363a4de8930bc50d0901a96775:

  cifs: update internal module version number for cifs.ko (2023-04-28
22:50:42 -0500)

----------------------------------------------------------------
11 smb3 client fixes, mostly cleanup
- deferred close fixe for an important case when cached file should be
closed immediately)
- two fixes for missing locks
- eight minor cleanup

Am still working on testing some additional patches, and also
expecting a set of fixes from Paulo and Bharath later in the week.
----------------------------------------------------------------
Bharath SM (2):
      SMB3: Add missing locks to protect deferred close file list
      SMB3: Close deferred file handles in case of handle lease break

Steve French (5):
      cifs: missing lock when updating session status
      SMB3.1.1: add new tree connect ShareFlags
      smb3: make query_on_disk_id open context consistent and move to
common code
      smb3: move some common open context structs to smbfs_common
      cifs: update internal module version number for cifs.ko

Volker Lendecke (4):
      cifs: Simplify SMB2_open_init()
      cifs: Simplify SMB2_open_init()
      cifs: Simplify SMB2_open_init()
      cifs: Avoid a cast in add_lease_context()

 fs/cifs/cifsfs.h          |   4 ++--
 fs/cifs/connect.c         |   8 ++++++--
 fs/cifs/file.c            |  16 ++++++++++++++++
 fs/cifs/misc.c            |   8 +++++++-
 fs/cifs/smb2pdu.c         | 115
++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------
 fs/cifs/smb2pdu.h         |  20 --------------------
 fs/ksmbd/smb2pdu.h        |  33 ---------------------------------
 fs/smbfs_common/smb2pdu.h |  56
++++++++++++++++++++++++++++++++++++++++++++++++--------
 8 files changed, 109 insertions(+), 151 deletions(-)


-- 
Thanks,

Steve
