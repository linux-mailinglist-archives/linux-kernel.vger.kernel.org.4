Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2554D7193FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjFAHSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFAHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:18:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B6C129;
        Thu,  1 Jun 2023 00:17:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so465943e87.3;
        Thu, 01 Jun 2023 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685603878; x=1688195878;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2dYgoP0dKtnWukHVHoIhlwiSBe9FEkEN+rmu7C7LDaM=;
        b=UouH19Ic52/Z1QTEIzPBJFntquI04luY9vhkfhksgYeAEMHm6g7KnxvaMlCw9SjIfl
         JU7JejjhO8+Ewswx245cYshTx9BRxvEvBYVx6clTMO2/gdFBtEjg/Ufn4vNlnh5+h1Z/
         8jkKz76oMcEWTa1hD9H27CLRP4X8CmG+naS6A90RaxIOje5TDtvWIV6U2TsX+dl3jLeE
         8a/Q/tHGNBXmbh0yPS+yQV2o+MnFstqQFdZdwpTqaDdQrGmHe4yHoKwK9u2RKcCoXmC1
         T2mswwdic2dfnP6vG2tEfMgFUErZnEXykJKWS51bxWZ/mmWzsNo15T7qpIdYoMq7WorH
         H8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685603878; x=1688195878;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dYgoP0dKtnWukHVHoIhlwiSBe9FEkEN+rmu7C7LDaM=;
        b=dzNxO6uqvPIlzenhq1CuyWdkGTr1QBSxwCTGee6g8Z7AJHsQdv5RhPHx4DjbwwNEMB
         ILCPws42JcMLbjJsEMhK7ODKmudQDqsoV2Mt+vYWWKEGPVYIG3KwGmhk3SbP1TaWl7H/
         RMkY6fLjwNoasIKVYI5qaFt20AY3joBqYhE5G2EcKstOF4KiJ7kWguyrMXp0M/PNUBhg
         TCX7X02XSPzIh8M71TCI7ulSs4BXMXUSh9s2kjiWJKRbcsKWS7DLt2TYHFPmuNFlbpmY
         bCBiXEr/v6V5/dKYJxu/hT8SwldjMC2evEpU0sfYSvDdtSTkyBUiLNcgAaPPNRv8QxJw
         nKvw==
X-Gm-Message-State: AC+VfDwcxj/7YmNV/HDqtLW9UIG8OWMbhe08THByNrWEE4n/Ist7fcAU
        2G/ponMeLN08wyxgXPAmp6zx90UtqTV/ksRtIxY=
X-Google-Smtp-Source: ACHHUZ4YsDXmVxroVd09wZZv0wGnsGrpz6E4BezVuqpgVn82Iup5xPvW7wUs630DRe3ijJ0F2LN6gwzSWxoSLe0mEYs=
X-Received: by 2002:a2e:3511:0:b0:2a7:a30e:d11b with SMTP id
 z17-20020a2e3511000000b002a7a30ed11bmr4257080ljz.7.1685603877335; Thu, 01 Jun
 2023 00:17:57 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 1 Jun 2023 02:17:46 -0500
Message-ID: <CAH2r5ms4QAu6Kets9riO5CN6d-4wOaGoawoyadL0EviKdf-9Bw@mail.gmail.com>
Subject: [GIT PULL] smb3 server fixes
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
0d85b27b0cc6b5cf54567c5ad913a247a71583ce:

  Merge tag '6.4-rc3-smb3-client-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2023-05-25 19:23:18 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.4-rc4-smb3-server-fixes

for you to fetch changes up to 6fe55c2799bc29624770c26f98ba7b06214f43e0:

  ksmbd: call putname after using the last component (2023-05-26 20:27:46 -0500)

----------------------------------------------------------------
Eight server fixes (most also for stable)
- Two fixes for uninitialized pointer reads (rename and link)
- Fix potential UAF in oplock break
- Two fixes for potential out of bound reads in negotiate
- Fix crediting bug
- Two fixes for xfstests (allocation size fix for test 694 and lookup
issue shown by test 464)
----------------------------------------------------------------
Kuan-Ting Chen (2):
      ksmbd: fix slab-out-of-bounds read in smb2_handle_negotiate
      ksmbd: fix multiple out-of-bounds read during context decoding

Namjae Jeon (6):
      ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
      ksmbd: fix uninitialized pointer read in smb2_create_link()
      ksmbd: fix credit count leakage
      ksmbd: fix UAF issue from opinfo->conn
      ksmbd: fix incorrect AllocationSize set in smb2_get_info
      ksmbd: call putname after using the last component

 fs/smb/server/oplock.c  | 72
+++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 fs/smb/server/smb2pdu.c | 96
++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------
 fs/smb/server/vfs.c     |  9 +++++++--
 3 files changed, 100 insertions(+), 77 deletions(-)

-- 
Thanks,

Steve
