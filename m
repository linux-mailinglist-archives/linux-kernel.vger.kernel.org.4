Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB6660660
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjAFSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjAFSaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:30:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F47CBC8;
        Fri,  6 Jan 2023 10:29:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i15so3394970edf.2;
        Fri, 06 Jan 2023 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wopE+x9a0him1Mw4JPXWlOM8415jwSkKsRI4QcOIgfQ=;
        b=Pmo7CeOBYh1Ra/LnMUptEEVDz/j7tKutnHWptp0q1YOT7kCi2RKEHgyD7Cp252X2cv
         c9np2fE5ZvU1gfXXmrIhw1dO4QUscfiYBeoghTUFh5/g+bunph+F3ZobWNtckVDRMxQZ
         BjPl7oxIdc89b0o8Av1BMjROn0pNTrS2jQTonzjMVJotf5rPqaFIZDS3gMy3FoyeLOcd
         MkzJNJWydrKKINGZeg9ycDUvumfnrKaTeuU5mjvo4ETPME/OpWk2loNvzlcXPgL6qSCL
         hjt148/sTyOrcOdNHpCwHDBXIwpG5eCtXenrfMe5Jr+5WShcynbQMBIcFCMq1HBfOZCa
         NLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wopE+x9a0him1Mw4JPXWlOM8415jwSkKsRI4QcOIgfQ=;
        b=MLKmpV9ohzaq99S2KAD+EB7/S6GdaQaTKymHbWpDuj0MKv5JAvz13YJuf24dZIfdht
         h2wr5To2M+7xCuvUujTM5uF4d1SObmo2Z+ZYClNT3Zyt53nyvSuWLTj36mturoxzgGY/
         0yrhvy7KORERKMjQFJsbL7jvkZxacNQw7fy0+97tLVOP67pLRPfG2tizoq2ex4GLJ8iA
         YZvmH1Tdq95//VEgIUsbtOnaddH2biqQpRyqZjbwA65TrwVeii56dOskCUvqisHETium
         nLTutHMbTE4lLTgw0rVWVY2l7iNhQ1EQzTfiSMNFuwDkkeexwtGnOQmsJX0FRqfxvi9l
         fD3Q==
X-Gm-Message-State: AFqh2koF32FR8Sx6Vwkujd4D0jSJm4OgFYP1jLjp8/P+V5wTGBlal/+q
        5OlWARMqYdgUEM13nqEtrdk=
X-Google-Smtp-Source: AMrXdXu8Q9C9SS5nyVJOG72LSUdDWJmA0k94T5O5KeLOjVVD7mN1MNO5lncbECfZsVBYcjX11MjnzQ==
X-Received: by 2002:aa7:c69a:0:b0:46d:e3f8:4ed4 with SMTP id n26-20020aa7c69a000000b0046de3f84ed4mr49018857edq.21.1673029798032;
        Fri, 06 Jan 2023 10:29:58 -0800 (PST)
Received: from zambezi.redhat.com (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b0080b3299ebddsm641612ejo.13.2023.01.06.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:29:57 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.2-rc3
Date:   Fri,  6 Jan 2023 19:29:51 +0100
Message-Id: <20230106182951.92281-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc3

for you to fetch changes up to 8e1858710d9a71d88acd922f2e95d1eddb90eea0:

  ceph: avoid use-after-free in ceph_fl_release_lock() (2023-01-02 12:27:25 +0100)

----------------------------------------------------------------
Two file locking fixes from Xiubo.

----------------------------------------------------------------
Xiubo Li (2):
      ceph: switch to vfs_inode_has_locks() to fix file lock bug
      ceph: avoid use-after-free in ceph_fl_release_lock()

 fs/ceph/caps.c     |  2 +-
 fs/ceph/locks.c    | 24 ++++++++++++++++++------
 fs/ceph/super.h    |  1 -
 include/linux/fs.h |  3 +++
 4 files changed, 22 insertions(+), 8 deletions(-)
