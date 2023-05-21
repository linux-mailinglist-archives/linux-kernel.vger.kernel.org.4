Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1670AD04
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjEUIha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 04:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjEUI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 04:28:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516D124
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 01:28:18 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DFF9B3F4A8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684657696;
        bh=7LprU92WxJEFR19aNB0l9iIcuodaVl/7HZinT6/rqlw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Uk9LOJueZDpFM0P5m5KGTx731/UqZ2rCEO8AsOtF/OHKoJOcawND1Z38XCP7Wib2l
         jLUE0tGOZ7EiNohL7jt4DWv8dal/MLPzq8aSYobFK8ntiqtsLSzOduweB0xOOrl2X/
         GAdgJoCqzibnH5iLBfj7QPS6ZU2O5X0RnwwPqYRsQPYMADtGJG+luTHnRJhRtH/jdk
         fsESszTaGOs5NZ/RN3022ZVmJ7/7OUOu8PrQ/nPBwpF4QF4jOHLGz64L1IeMaMHfSD
         BDsn/oS919ghCGvzSjfT59OIJ50e94etPeZ9zc7TRB3Sb3wbzMpSitPwoWHLt9eo47
         +/VsM5BLLBBvw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-510f6e39f5aso3147383a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 01:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684657696; x=1687249696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LprU92WxJEFR19aNB0l9iIcuodaVl/7HZinT6/rqlw=;
        b=Ec+Qyed99kJ9FRZ7iLxV/yZjSOcd0f7Fbkd9ZmTCKtfCeDEyQHdYB4sI9AF5XGaQAR
         8mRuDGnaMu1Jvu8UHiBwIrrpkRffCQq7XUR0k7i8YDowzqnFNnV+iqRDzrYLE5uZ7xvn
         Kk9fQo2gKXQLoc1vfYNWJyjcbayvVEeWGCyXT4ln6nqfOJmLDspiDru0FueTtiioOpiv
         OJhYbZx4+6rvLkjXNIXVoBwoMtH6TKfAO6BKa0iaFgnYXIKlIWJwjEjZur2zroZPXrkZ
         vJm0FVOpPaJDzquYugUI6OFFIfDkn82hlSt7FPu3V6KwgIEsIhov4qDW/zovz1KtMOPN
         yoLQ==
X-Gm-Message-State: AC+VfDwAMiqJS+WH7mw1pZ+q0BAU79nM5LOON8UwqD/MMtwOR7nSyo4T
        +XaHT4nnMewXOxsSZFzjdXLi8mIHx1Oz2pF05P5QV/CkgU1IvY5SbRcvOPzNSIoblxqY2jfO7gG
        l+G8N8iJ1Wf8WG6lSLPBR9kYVS0xVdJ0w1LkE3CyGTA==
X-Received: by 2002:a05:6402:348e:b0:510:f14d:78eb with SMTP id v14-20020a056402348e00b00510f14d78ebmr7695893edc.18.1684657696504;
        Sun, 21 May 2023 01:28:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YiaVtDTOUKe5lAcQsfGZKVUN/gNqPTMRLhLjXgvA+r+jmeFCsJnN9P9LYtx64f3J7Oir7/Q==
X-Received: by 2002:a05:6402:348e:b0:510:f14d:78eb with SMTP id v14-20020a056402348e00b00510f14d78ebmr7695887edc.18.1684657696256;
        Sun, 21 May 2023 01:28:16 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-10-127-160.retail.telecomitalia.it. [87.10.127.160])
        by smtp.gmail.com with ESMTPSA id z17-20020aa7cf91000000b004c2158e87e6sm1656646edx.97.2023.05.21.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 01:28:16 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] overlayfs: debugging check for valid superblock
Date:   Sun, 21 May 2023 10:28:10 +0200
Message-Id: <20230521082813.17025-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OVL_FS() is used to get a struct ovl_fs from a sturct super_block, but
we don't have any check to determine if the superblock is valid or not.

This can lead to unexpected behaviors or bugs that are pretty hard to
track down.

Add an explicit WARN_ON_ONCE() check to OVL_FS() to make sure it's
always used with a valid overlayfs superblock.

To avoid enabling this additional pendatic check everywhere, introduce
the new config option CONFIG_OVERLAY_FS_DEBUG, that can be used in the
future also for other additional debugging checks.

Maybe a nicer solution could be to return an error from OVL_FS() when
it's used with an invalid superblock and propagate the error in the rest
of overlayfs code, but for now having at least the possibility to
trigger a warning can help to catch potential bugs in advance.

Changelog (v2 -> v3):
 - do not hide is_ovl_fs_sb() under CONFIG_OVERLAY_FS_DEBUG
 - split consistent use of OVL_FS() and superblock validation in two
   separate patches

Changelog (v1 -> v2):
 - replace BUG_ON() with WARN_ON_ONCE()
 - introduce CONFIG_OVERLAY_FS_DEBUG

Andrea Righi (3):
      ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
      ovl: make consistent use of OVL_FS()
      ovl: validate superblock in OVL_FS()

 fs/overlayfs/Kconfig     |  9 +++++++++
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/export.c    | 10 +++++-----
 fs/overlayfs/inode.c     |  8 ++++----
 fs/overlayfs/namei.c     |  2 +-
 fs/overlayfs/ovl_entry.h | 14 ++++++++++++++
 fs/overlayfs/super.c     | 12 ++++++------
 fs/overlayfs/util.c      | 18 +++++++++---------
 8 files changed, 49 insertions(+), 26 deletions(-)

