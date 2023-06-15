Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73B2730E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbjFOEg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjFOEgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:36:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480A212B;
        Wed, 14 Jun 2023 21:36:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b34ac4b6e8so18128651fa.3;
        Wed, 14 Jun 2023 21:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686803781; x=1689395781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMlSSd4IHrr9XmOOrYPwJSR+ikcUyPn+0Joi1HvVvME=;
        b=Grlcv7HBpsM5PS7LrLFoSG25dRDOP2Smu6ZMidL8bk2O+wGWKnohZGSw3849H2XGxH
         hOGlTbla+g4LGpqC4fxSoo/zownDb31ngZXHqOzhcTTBxYKrOqB9QumwXTrDmw2iHK8q
         FbBipZtQkxHB9DOTVYtUNOj1AlBTHVTIKwhsL6YnBUFvHdFpAEXEJhFM66e0XvIoQmnE
         PVZNLBXwIXptcOLbncZYcgFORjVIfTQ4alDvaeCJfS/NqGVH49rL11WH7ubMQF/NRzw9
         5EwksJ+Q8ORNZnrY/jlA+baTSZwA51BhwLgJ0oMYua2xJ7IeOA+pfv1pYI0bKeoLlzRh
         U8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686803781; x=1689395781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMlSSd4IHrr9XmOOrYPwJSR+ikcUyPn+0Joi1HvVvME=;
        b=EfESkM+6B5CXlMTUIIu7H48z/R8eKgtptoIZARGuXx8RFJ6q1sFQx/Ao850KP5NqFO
         2+TKLwIVv4A3jp/9fR0uIs4b0ey8MaBxr8gY7Vv6RE3UzpawX2Q6iY1Oay12M0D3mBXb
         ANMJ8JqhkUozZCJrpPrn9RLQiSCnHhoBSvyYt9TXwDP6OHJkGyvjT7qJXymbxabcKx2c
         d05ZHzJ3yN0DPzAFz/JoH1pCJlYBA7YHL+EM9x9a97JxmbW3I7ScVlhL0JSGzh9LB/Ig
         15M2Wfgu1yfToIKbHu8f8sImmDBGxmnjtTkho/4Cz2TqX/l6qGq0EUUHwz8C8heWTfiT
         rODQ==
X-Gm-Message-State: AC+VfDxvJh75/6ayyr9uLYp6dDJbmelGfQWoisXmolA2M5Qmbe9JzyGP
        /HlR3FTo/vJ5cxGiK+5lsIuhMqwGl+qdMzRbctE6tibB5BWnPQ==
X-Google-Smtp-Source: ACHHUZ7xtGCkEd+hU3lQvDgzKIcYk78r4ONJDN6ReXJEmNYey3ohgnV/WWaAb0Z5IxIxVsY1QmKOlmsRRQYrHV17CN8=
X-Received: by 2002:a2e:3816:0:b0:2af:1ebc:1e46 with SMTP id
 f22-20020a2e3816000000b002af1ebc1e46mr8242939lja.17.1686803780888; Wed, 14
 Jun 2023 21:36:20 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 14 Jun 2023 23:36:08 -0500
Message-ID: <CAH2r5msGxr_kjUC=2GmALVuktLqhUtuVtRm6f=3fFPvAPH+OaA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc6-smb3-client-fixes

for you to fetch changes up to e4645cc2f1e2d6f268bb8dcfac40997c52432aed:

  cifs: add a warning when the in-flight count goes negative
(2023-06-14 10:15:05 -0500)

----------------------------------------------------------------
Eight smb3 client fixes
- important fix for deferred close oops (race with unmount) found with
xfstest generic/098 to some servers
- important reconnect fix
- fix problem with max_credits mount option
- two multichannel (interface related) fixes
- one trivial removal of confusing comment
- two small debugging improvements (to better spot crediting problems)

----------------------------------------------------------------
Enzo Matsumiya (1):
      smb/client: print "Unknown" instead of bogus link speed value

Shyam Prasad N (5):
      cifs: fix status checks in cifs_tree_connect
      cifs: print all credit counters in DebugData
      cifs: fix sockaddr comparison in iface_cmp
      cifs: fix max_credits implementation
      cifs: add a warning when the in-flight count goes negative

Steve French (1):
      cifs: fix lease break oops in xfstest generic/098

=E9=91=AB=E5=8D=8E (1):
      smb: remove obsolete comment

 fs/smb/client/cifs_debug.c | 58
++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/smb/client/cifsglob.h   | 37 -------------------------------------
 fs/smb/client/cifsproto.h  |  1 +
 fs/smb/client/connect.c    | 59
+++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/smb/client/dfs.c        |  9 +++++----
 fs/smb/client/file.c       |  8 ++++++--
 fs/smb/client/smb2ops.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/smb/client/smb2pdu.c    | 32 ++++++++++++++++++++++++++++----
 fs/smb/client/transport.c  |  2 +-
 9 files changed, 190 insertions(+), 56 deletions(-)


--=20
Thanks,

Steve
