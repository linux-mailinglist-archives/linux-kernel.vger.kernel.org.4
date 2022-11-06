Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469D161E04C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 06:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiKFFHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFFHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:07:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827ADDEAE;
        Sat,  5 Nov 2022 22:07:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d3so11718208ljl.1;
        Sat, 05 Nov 2022 22:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FD7cFXaNxreHZW/S/IEPAaDO1vDMzt9q8nyoz0dU69U=;
        b=jPm9opIhg0S1ilPGsAvRrk0KML6qSvoVW5z+yJlnipA+AXOdidF0V24962I3lDsIlR
         X7Cwb7O9/750qXZvuQ+mtdYP7Z7il/5HyGV/yujNbW/rmt+i7LFZl8EOquGkpXMiQCVp
         ENCHnyThe4UEs6gsg51m+nW8PSW6VyDkUBYLMsUxuRgQb1TieZXyH3snTe8jso2nxIJc
         7FVZ/qWxdkjxntQLjV2Rl678tS5Z5bwIz4Shuadc+7HgZJ7jI1Pf/Vcbp5Ehu2rS/L2b
         EvYIeNVN/WCa85I4Vu8TGA2FR6DZbq5yfQSVQB/puczGE3RGVifdstOKjCw/DM3t5OmP
         cfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FD7cFXaNxreHZW/S/IEPAaDO1vDMzt9q8nyoz0dU69U=;
        b=gcHiOcbxOH62tg6O4xH+lTZiodNkQzmz2iyp1uY/ZNHph4a/qaeqs6W8jlSb5EcKIi
         nx0FXPpAr2iuncKmYpIfxHW3eOgSU/fYgDWDd+h27KxCmFO4VOAcewE6tSLpl2aNHATH
         3GByO9SV5cl3DQYgImERE1zijYV2j1BqczHf1MI3GXB/onGjVJeWtVEdbmmtU3OPurLQ
         6AVhXIMHChBNRh8r9Y6qIeErpBNK7IV+ByAat0zeLtoHnfyGTfitbMAU0z9ObxvhU0nC
         m7pd7N8lgCg5QnOPi9+Si3ZzSxWdOr9i/9/nfPvkPZ0lrZ/KkJJ6U54iS8FqKJbxvNZD
         GAGQ==
X-Gm-Message-State: ACrzQf3ZIpdKnmOE6odb+Cf0eUPq5gS1sCQV9i9gT8PD9/t8SAevQWo9
        RUQs9C3+ODIgRuKWHuyIVgYsXnZiE+u4rw3+mXI=
X-Google-Smtp-Source: AMsMyM7eCUET6KyY6J1jtgBrwEFIaPGB9yMh1ig/q3XvD3C0xvwLjBB3DFtd0u7BAjDT/w1phqlXlehlU78knCm5pG4=
X-Received: by 2002:a2e:ab0d:0:b0:26e:8a39:4cae with SMTP id
 ce13-20020a2eab0d000000b0026e8a394caemr16268501ljb.138.1667711269196; Sat, 05
 Nov 2022 22:07:49 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 6 Nov 2022 00:07:38 -0500
Message-ID: <CAH2r5msckOPtJzUmpzRZAQCQG96nRWDFd=b3An_oiZpU=kwLBQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        ChenXiaoSong <chenxiaosong2@huawei.com>
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
30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc4-smb3-fixes

for you to fetch changes up to 542228db2f28fdf775b301f2843e1fe486e7c797:

  cifs: fix use-after-free on the link name (2022-11-04 23:36:54 -0500)

----------------------------------------------------------------
3 cifs/smb3 fixes,
- one for symlink handling race (fixes a bug spotted with KASAN)
- two fix multichannel issues with iterating channels instead of using
the primary channel. The
more important one fixes a bug when leases are disabled (ie using
oplocks instead) that was
spotted with xfstest generic/013 timing out

----------------------------------------------------------------
ChenXiaoSong (1):
      cifs: fix use-after-free on the link name

Shyam Prasad N (2):
      cifs: always iterate smb sessions using primary channel
      cifs: avoid unnecessary iteration of tcp sessions

 fs/cifs/cifsfs.c        | 26 +++++++++++++++++++++++++-
 fs/cifs/inode.c         |  5 -----
 fs/cifs/misc.c          |  6 +++++-
 fs/cifs/smb2misc.c      | 81
+++++++++++++++++++++++++++++++++++++++++++++------------------------------------
 fs/cifs/smb2ops.c       | 30 ++++++++++++++++++------------
 fs/cifs/smb2transport.c | 19 ++++++++++++-------
 6 files changed, 105 insertions(+), 62 deletions(-)


-- 
Thanks,

Steve
