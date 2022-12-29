Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79281658EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL2QAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiL2QAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:00:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0A307
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:00:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay40so13453586wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52wkDyJgM41odNR1mvIEESkHB4XxW72pzCULKOBODro=;
        b=i/Q3rBBJia8cr7Iez0q1cdFjoD02/5KDg2mON9GRfrpaHmtxfIu5nkhdgcN/3eh9g3
         PZpR2vAgobXjM89Pw2G4Jcq6DyJOMao33UjY9Yka1qz7MwrqwiLRBfxv9SumFhlZ/g/S
         IR6+3j1W3cRQXmPl18OCJFRHrlz5fucbLtDmv6B0Z1GqLUZytAqVANAle9Jh0fWmlb/o
         Vdrarrj47hY4Jd892VytWiFj83bVo/UENcTFhtjxnglMH5wtFHQlbSuL8hC9G0EjQ8He
         P3dcpJppwpQ5LQikz8pTmotXo7rmWiAyhVCF5FvCcuNVMG4FoMw0Jiq4n1znwkJ2QPBz
         pYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52wkDyJgM41odNR1mvIEESkHB4XxW72pzCULKOBODro=;
        b=c66VC79FZhKdeatASg1ZuqRM1XeXGvfRVmcYeVYaJlqWsrCN8UziZwGb/ztcTnDwSk
         l9Kvib3PM0MXT9M3yMJrXOjIfRyvJKjz2iw7Tui3HSGg+jOeyTqWY0Xf4SVbPKO4zh/F
         vjDPoSwAyx2BT2/EZF+42CgPvx9MJGU1QNqa5s6HbWt7I4vuQ8r//JXaBFDalC+ugn17
         cK30CqBgFq5jNOYr+1kRuONMAktnRjZqhPAG58zaqe+mrpeBvBbGM4iGlTRlHo7ZtLz2
         Pfxc5T+gZz4ndIxgWZh4zsDcH8356gYq0vP8Y0G+z72PHaDNeIxbYJb7RboVIqygr5zb
         rb6w==
X-Gm-Message-State: AFqh2krHsWRumFwxnw4dz9JKa5DS6gCKXDi50DUJuLzGTrTnEXy2O/86
        gfe0MMKQH0qL7KRKnVMy29kNnQ==
X-Google-Smtp-Source: AMrXdXvpOF8OS6NlkW8dM8zAEkBFNsqRXtQ8eA7KDv8Tv9wsNCW6oL8Fh6qR/gcZAf/rXhSHL2oXbA==
X-Received: by 2002:a05:600c:34ca:b0:3d6:80b5:f948 with SMTP id d10-20020a05600c34ca00b003d680b5f948mr20626555wmq.39.1672329648876;
        Thu, 29 Dec 2022 08:00:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003cfa3a12660sm42511593wmq.1.2022.12.29.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:00:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/2] i2c: fortify the subsystem against user-space induced deadlocks
Date:   Thu, 29 Dec 2022 17:00:43 +0100
Message-Id: <20221229160045.535778-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Several subsystems in the kernel that export device files to user-space
suffer from a bug where keeping an open file descriptor associated with
this device file, unbinding the device from its driver and then calling
any of the supported system calls on that file descriptor will result in
either a crash or - as is the case with i2c - a deadlock.

This behavior has been blamed on extensive usage of device resource
management interfaces but it seems that devres has nothing to do with it,
the problem would be the same whether using devres or freeing resources
in .remove() that should survive the driver detach.

Many subsystems already deal with this by implementing some kind of flags
in the character device data together with locking preventing the
user-space from dropping the subsystem data from under the open device.

In i2c the deadlock comes from the fact that the function unregistering
the adapter waits for a completion which will not be passed until all
references to the character device are dropped.

The first patch in this series is just a tweak of return values of the
notifier callback. The second addresses the deadlock problem in a way
similar to how we fixed this issue in the GPIO subystem. Details are in
the commit message.

v1 -> v2:
- keep the device release callback and use it to free the IDR number
- rebase on top of v6.2-rc1

Bartosz Golaszewski (2):
  i2c: dev: fix notifier return values
  i2c: dev: don't allow user-space to deadlock the kernel

 drivers/i2c/i2c-core-base.c |  26 ++-------
 drivers/i2c/i2c-dev.c       | 112 +++++++++++++++++++++++++++++-------
 include/linux/i2c.h         |   2 -
 3 files changed, 96 insertions(+), 44 deletions(-)

-- 
2.37.2

