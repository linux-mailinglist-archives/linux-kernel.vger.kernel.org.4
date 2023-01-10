Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C812A6637C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbjAJDNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjAJDNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:13:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A1518B28;
        Mon,  9 Jan 2023 19:13:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f34so16176243lfv.10;
        Mon, 09 Jan 2023 19:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HnMTuoVSdPIicU22a4q7uL8yldhdi0gvxQx9EQust7o=;
        b=KSK3JrYFJpPVBaQE290LRY7v0ICRLW07pfjWh16SSBQCKOsb+4DSI4Ufb/Vif1uqnm
         Ft7pwW0fyKEoucgYVMulFR7A/NNI7WPaH1LhZdFv5SN/Zd/vzKlwd9w3bv4TdnXunfRJ
         RBunWrYBCDhr3rwdWxJ4F1xkRZpH7wOHmZ3tqNzJ+9CPtfl0drSrScS/8RjojD3qFuvR
         jI9we76hgbVI4mil7bq31ZVAhsCouOgFpEyqVI3BX5aTJX6OsdQhh/XEAeQsBJghtNFw
         yYjush2i8+jC02emq8esS89YK3x3+SgOArusZglrmz+zSwxbQoG+CfGPygT16BOaV0RQ
         ev6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnMTuoVSdPIicU22a4q7uL8yldhdi0gvxQx9EQust7o=;
        b=hQJ429X4OzKxjxAOcCdkPf+gSkk7hrcZkaufIiVHlB13e9LTB2nuMV1rTtSwm+HrPu
         1elDNigdyV1IaU8+Y1t4jURupWBGosv0S+BZrMeCqCezH1cJ33pgr4B7ocGqaXiMx+lE
         wYx9EqRTeuVvyAJ50Y/fF8OSNM/aWpQQ/mie8TAhAhWViPdrWt1GkEtcotHcrM3TfATw
         UG4UvQC9IGdKljb9gM+W7dmufCIZiam9XIj298h7+WnjMRARUHi07UU85GPCEYlB8NJ4
         Sb+SpcE3O5ec5phPIHNb6xg+LLnHhdTQbOJbnpuBnP7QDHdoOpqoa467McgNo8/urXzy
         jZPw==
X-Gm-Message-State: AFqh2kpFKuMtYCihln/SvkeZlenzAaNQlBFnwSTbadwTXudHYLlIZS3H
        IiMZNTMF+tVDikwSPid/jNohcE7Ld4n17WBFVYI=
X-Google-Smtp-Source: AMrXdXvh64jPkUrk5BMgmzXPIQy67skV3Xdwbj+P7Fm+cAL4M4fk+3YgRdD6ldG3+4XykiZgcF1LKeEUpUcNCqbRuRM=
X-Received: by 2002:ac2:42ce:0:b0:4cc:5e97:d35b with SMTP id
 n14-20020ac242ce000000b004cc5e97d35bmr685433lfl.403.1673320400640; Mon, 09
 Jan 2023 19:13:20 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 9 Jan 2023 21:13:09 -0600
Message-ID: <CAH2r5msyEy20e=FBx6wPWWc3kXzNR4b+zHshSqidRdFKVf_7Jg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.2-rc3-ksmbd-server-fixes

for you to fetch changes up to 83dcedd5540d4ac61376ddff5362f7d9f866a6ec:

  ksmbd: fix infinite loop in ksmbd_conn_handler_loop() (2023-01-01
22:49:24 -0600)

----------------------------------------------------------------
3 ksmbd server fixes, 2 important ones for stable
- fix possible infinite loop in socket handler
- fix possible panic in ntlmv2 authentication
- fix error handling on tree connect
----------------------------------------------------------------
Marios Makassikis (1):
      ksmbd: send proper error response in smb2_tree_connect()

Namjae Jeon (1):
      ksmbd: fix infinite loop in ksmbd_conn_handler_loop()

William Liu (1):
      ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
ksmbd_decode_ntlmssp_auth_blob

 fs/ksmbd/auth.c          | 3 ++-
 fs/ksmbd/connection.c    | 7 +++++--
 fs/ksmbd/smb2pdu.c       | 7 +++++--
 fs/ksmbd/transport_tcp.c | 5 ++++-
 4 files changed, 16 insertions(+), 6 deletions(-)

-- 
Thanks,

Steve
