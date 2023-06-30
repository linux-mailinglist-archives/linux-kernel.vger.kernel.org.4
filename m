Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812D17434A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjF3GAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjF3GAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:00:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713623AA8;
        Thu, 29 Jun 2023 23:00:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so22976421fa.0;
        Thu, 29 Jun 2023 23:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688104804; x=1690696804;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJPZS8Z0hClokYUWND9TxS8zJ5yKP7ouDFYMDDtHyvI=;
        b=KZ3unI2+sEScme97dMbKkjkClWvctu7mL/XJERAYB3RKK/9b0hFLU6vXOXTKWC0zOU
         5MiXcj9Fa5kiFy69etqk78TaasYnW4RaobrdjF2A6M2be6vMivr27UEYCtzSMSvgJPBY
         PlTJDyEWuYyGtJBwRwPfDjqpfbSBk9fBWwai7xMLhbqGZUW3EO8rIBBo7e84aMEIgINj
         EjN7jnZVwlS/nyOrcpxaDeWGQk42nGhF3/XYNTaLGBZ6/whVq9pF1cwrnCFB1C3vsXP7
         8GSFwgWQi4XEiSUmhLoVqa1KAbnA6pZ2SrtA6CD+YTfBdBl3ubaKVpiJ3CBKuo6ZD1pU
         AZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688104804; x=1690696804;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJPZS8Z0hClokYUWND9TxS8zJ5yKP7ouDFYMDDtHyvI=;
        b=WmzDKaYTeiaAQU4q/GrMP2wqabJ/+1mZr8hbQfk39IHJQH5rftMb6bsBFthBwTPB0M
         nI3atRnwBSXnNmNTIQon2lgk20pgv+jeIiWAoFXOYdMvV/rnYR4kE4Id/ljvPVAcxM11
         teMk2VIJWq4jZ28Td40vT6nMl21c4UQABr976hoSRK9MAeGWDVjs4QRMvcFMfqVU1JZn
         XZIfSghO6lFy0BL4Ze1ZZ+5SSjuKtN7ntPpAf2zfR22m1WKt6Hc5qG8QtK2rv5C0zqGR
         Qvx/QJO5Eql81VNkcWADxNceDIt5ZqLaBKEYcvlm5vy+kw1hO9oj3dCY1WXm7jnogkzk
         mXHg==
X-Gm-Message-State: ABy/qLbFWkhkhGgcHxbJBph5JFuf3bAnKFToo0i2RhbkUv0GhziyP7WF
        fX+DLVjBPejcK4wVccalecW4s/9CSUB3Un+P/Us=
X-Google-Smtp-Source: APBJJlFw8Z/a9AankPqyhku4cW7FYeHt60cpCjxerGm3kaYFIs/qX0KkwS/S1oQfOVoCwcHIwUAg9nPko8OSGLhTnnw=
X-Received: by 2002:a2e:95d3:0:b0:2b6:a85e:4c3d with SMTP id
 y19-20020a2e95d3000000b002b6a85e4c3dmr1245466ljh.32.1688104803411; Thu, 29
 Jun 2023 23:00:03 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 30 Jun 2023 00:59:52 -0500
Message-ID: <CAH2r5msmdAXS+55Mk0SjyBgGtgPb4vp5z--3=DdFodPgrEoeaw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
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
6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.5-rc-ksmbd-server-fixes-part1

for you to fetch changes up to 9cedc58bdbe9fff9aacd0ca19ee5777659f28fd7:

  ksmbd: avoid field overflow warning (2023-06-28 22:58:28 -0500)

----------------------------------------------------------------
11 ksmbd server fixes
- two fixes for compounding bugs (make sure no out of bound reads with
less common combinations of commands in the compound)
- eight minor cleanup patches (e.g. simplifying return values, replace one
element array, use of kzalloc where simpler)
- fix for clang warning on possible overflow in filename conversion
----------------------------------------------------------------
Arnd Bergmann (1):
      ksmbd: avoid field overflow warning

Gustavo A. R. Silva (2):
      ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()
      ksmbd: Replace one-element array with flexible-array member

Lu Hongfei (2):
      ksmbd: Change the return value of ksmbd_vfs_query_maximal_access to void
      ksmbd: Replace the ternary conditional operator with min()

Namjae Jeon (6):
      ksmbd: remove unused ksmbd_tree_conn_share function
      ksmbd: use kzalloc() instead of __GFP_ZERO
      ksmbd: return a literal instead of 'err' in ksmbd_vfs_kern_path_locked()
      ksmbd: use kvzalloc instead of kvmalloc
      ksmbd: fix out of bounds read in smb2_sess_setup
      ksmbd: add missing compound request handing in some commands

 fs/smb/server/mgmt/tree_connect.c |  11 ----------
 fs/smb/server/mgmt/tree_connect.h |   3 ---
 fs/smb/server/smb2pdu.c           | 121
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------
 fs/smb/server/smb_common.c        |   8 ++++----
 fs/smb/server/smb_common.h        |   2 +-
 fs/smb/server/smbacl.c            |   2 +-
 fs/smb/server/transport_ipc.c     |   4 ++--
 fs/smb/server/vfs.c               |  12 ++++-------
 fs/smb/server/vfs.h               |   2 +-
 9 files changed, 88 insertions(+), 77 deletions(-)

-- 
Thanks,

Steve
