Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46C6E34D4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDPDwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDPDwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 23:52:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE9271C;
        Sat, 15 Apr 2023 20:52:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x34so9579095ljq.1;
        Sat, 15 Apr 2023 20:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681617152; x=1684209152;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QhssxvX2XIQX5gXBmeauZ98Mdf5jdlgnzZaIKoOePvc=;
        b=Bje5M0UV6fkAVYcil5mvFqAeWkPMJgiFF66bOr/yLUlG/yuuDTiInMh1a3EduDmzXw
         U9kfuY2JVc/P0pRDqTPgw+GHUPVw3xojpVPYJ3veWomONCtpVqphxfICXaHKnNcwc+BH
         x0+OEObmj6k4WWH03N2mjJ95AcSCvo/CIuGQvn3sKkSGEWOM3hI5erCoLGObFhRzn6qf
         XtRU5wFnOuOCb8PdzEoEh6eO/uhVDtSEJ+aA1YBEHx+YyRtqaLLJO45nwfKyYJZirIha
         zrN7RqkIM58pVoiAysY7/IqU2R44RlYfb5nYZnqbyH+TZ/zYy6OKgQDTOpdqHbb9fceu
         uipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681617152; x=1684209152;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhssxvX2XIQX5gXBmeauZ98Mdf5jdlgnzZaIKoOePvc=;
        b=JRReH4JH3DSgmzqp5lJORuTpw3i4lzGiZqpqyz6os8wsnoJZRQiAhh1t03Z1Jq+TbA
         gxV9XeJr2m72isYub9ASJtNcAc9tfHAdpkIfLRC1Qh74W993S4RgU8TSAuDBCXUO3omy
         3LSbADoynFlqIxmLC+vimUko98T2fF8DaOrUws5r7sdUffY+qaFD9cVHs6DljtqX3tKm
         Q1GGNjfG2gjGvlMxL/z3cOWnEy0qSoimn4A0Nqqb8/cHx9hAgorP1XJZ1hnu+VkQzfCa
         ENyqZNWopafq/JeUzNSt+i8lfoO6ho7Y5PWUDY/d1Zh/qpTQmhyJ1WoYn28TEoe7H0kK
         ogVQ==
X-Gm-Message-State: AAQBX9emVpNgf6Jnp8PQvRIMU1wN16doi4gVCsI0UN2POcLeU+hw9rsh
        1CB8dEkGg9t2BBGEemDjD2N4VFrdOJFbDkxMIOkr3k5dzQY=
X-Google-Smtp-Source: AKy350bh1X7xFKWCTrihOOrhWm8fQ027nIW30/WTNM88fg4Z69ZPIbcPimJEXqGPvRY2ztrkf0qLboE6/fTp+jPHPoI=
X-Received: by 2002:a2e:a0d2:0:b0:2a8:bbd9:1a07 with SMTP id
 f18-20020a2ea0d2000000b002a8bbd91a07mr632315ljm.2.1681617151564; Sat, 15 Apr
 2023 20:52:31 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 15 Apr 2023 22:52:20 -0500
Message-ID: <CAH2r5mumQ=wg8H4d+vYGZZGPz1cbK5+LOeCoBxo+VbYta05QBA@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.3-rc6-ksmbd-server-fix

for you to fetch changes up to e7067a446264a7514fa1cfaa4052cdb6803bc6a2:

  ksmbd: avoid out of bounds access in decode_preauth_ctxt()
(2023-04-13 14:17:32 -0500)

----------------------------------------------------------------
smb311 server preauth integrity negotiate context parsing fix
(check for out of bounds access)

----------------------------------------------------------------
David Disseldorp (1):
      ksmbd: avoid out of bounds access in decode_preauth_ctxt()

--Please pull the following changes since commit
09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.3-rc6-ksmbd-server-fix

for you to fetch changes up to e7067a446264a7514fa1cfaa4052cdb6803bc6a2:

  ksmbd: avoid out of bounds access in decode_preauth_ctxt()
(2023-04-13 14:17:32 -0500)

----------------------------------------------------------------
smb311 server preauth integrity negotiate context parsing fix
(check for out of bounds access)

----------------------------------------------------------------
David Disseldorp (1):
      ksmbd: avoid out of bounds access in decode_preauth_ctxt()

 fs/ksmbd/smb2pdu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

Thanks,

Steve
