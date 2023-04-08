Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936926DBDFB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 01:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDHXef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDHXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 19:34:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09910768D;
        Sat,  8 Apr 2023 16:34:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a44so27994288ljr.10;
        Sat, 08 Apr 2023 16:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680996871; x=1683588871;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t3q101RNhdJsALsceC8/OEHmUPOJn3vT90Q/y7zR1os=;
        b=Y/yiwFCBPlwv/1TStkkPjt4lArieje2G1DwRls+sdNr6hSyshrM7K2BadQiYckcc57
         ilA3yQDhZeZyntIUKfC7Pym/hBk71Ccf/SuDIjjiJ9NwXoHeXlOIOLuSxKb/Ej5GFi9k
         WhaQesowpl2aKGSL31RJ4Ll3mUW26dpKcHdNT4heZnHLsvXUXUw8paVLbMl+nqEyjfOT
         t43+pdzBHODhyHr7tmgz328VvsS4ZBJkPVT07w7lqgFFHGR826+Ejs72kUfPUsYp6sHS
         X0jXl5GPeWOb37QQtYZh7v7qQfAS1b/fixief1OC+xAQAcrHL9rmwAUF7CpJhUr91aK4
         6i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680996871; x=1683588871;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3q101RNhdJsALsceC8/OEHmUPOJn3vT90Q/y7zR1os=;
        b=uCipqaJKq0BQfDhvX26DMxcUZfJkveEcz26O+0/3LkM7SYranoobMEZQsr5GRkCz6g
         5Dp6mBGVoWC6N5nCKpl1LNr5ZskRgSQB+HuYwGyFOh+S4Lmtc4Arv10clUTfzdmtjg1h
         XD/8Mde0nuvh1mVc7RZblcu4b4um/rldCiTZO23AJSCirLFRsAVVz7ou6wTF+hDY/nEY
         mf1d4yOnkvqHGuwAFMUAYmPNcLbaDy158Ua4arUgqsb/gaY1s2vfZ7b7Vv8/2p/IWdAI
         sXd4lp1D1KxSqprreJhcwJxDyajn6Rp+hwQtdOufoZezP7o3IWpNc2m1gflownGmFSeS
         i7KQ==
X-Gm-Message-State: AAQBX9f8EiAZauUAudTa6Gp5PX9uGFC5j1F9roZ7D6j0x/0iSGPKDuAv
        gZI4Cejlh1tpUbGz5DZbFe762iba6UnyxVkU3tnMuEOVvxc=
X-Google-Smtp-Source: AKy350YeqoK1bzR/Z54R4n3xfeHxN6Q3lU3BVHJCJ+rAkR7CEnzkosSaJp01F+wpZ9gAGOQACNRtdUx9LmdXVN6f/fQ=
X-Received: by 2002:a2e:959a:0:b0:2a7:5fe2:1c90 with SMTP id
 w26-20020a2e959a000000b002a75fe21c90mr1294902ljh.2.1680996871224; Sat, 08 Apr
 2023 16:34:31 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 8 Apr 2023 18:34:20 -0500
Message-ID: <CAH2r5mtknshEDr33kiExGDqrMhqVR+Et82vigWEBkD128U4v8g@mail.gmail.com>
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

Please pull The following changes since commit
7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc5-smb3-cifs-client-fixes

for you to fetch changes up to 4f5d5b33fc400911d6e1f49095522b361d9cbe13:

  cifs: double lock in cifs_reconnect_tcon() (2023-04-06 22:45:41 -0500)

----------------------------------------------------------------
two small cifs/smb3 client fixes, one for stable
- double lock fix for a cifs/smb1 reconnect path
- DFS prefixpath fix for reconnect when server moved
----------------------------------------------------------------
Dan Carpenter (1):
      cifs: double lock in cifs_reconnect_tcon()

Thiago Rafael Becker (1):
      cifs: sanitize paths in cifs_update_super_prepath.

 fs/cifs/cifssmb.c    |  2 +-
 fs/cifs/fs_context.c | 13 +++++++------
 fs/cifs/fs_context.h |  3 +++
 fs/cifs/misc.c       |  2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)



-- 
Thanks,

Steve
