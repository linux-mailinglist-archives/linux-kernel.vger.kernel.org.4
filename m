Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD5648448
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLIO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLIOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:55:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98780A27
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:55:08 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fc4so12006203ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGS8p58llTH0j/JtmBIf8IcqQNNb3dOfgpZWMO+4qxc=;
        b=ZKM+8vmyIyGnqJGMg1PLrEyjzHURIQ49nrR+4Cjb2tDfhRzSNwsUBEQ3CDMpzbTWlK
         wKbONKbccHcx7tdtrRxI5jqvo+xhjD+v6FvDo2UjxteCxErRQ8jOMzBOaQkbcMIJvv39
         wPgwsSPiQ+Ng/npOz16yJBEtmbjEy8VV+fP6aW9bqBRCwzBpOHK4zWUmd1AeFlqG26W4
         5ZYMibLNHHIudvWomfOP0bxVYcHEieLRIlFflAwXX/V/d5gmZ+Kvk3dyz0dTQo1rpCsd
         KCaqDixfrYloL6JFEoI9btVVm7ggxh3H4TGOiPkp+r4FjxgD+eGf5J6O9HXV1XMPDAj1
         pUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGS8p58llTH0j/JtmBIf8IcqQNNb3dOfgpZWMO+4qxc=;
        b=WQq/Fp00CWNaDhgS6SfHofZOB89adhLsNLQjNzY6VHSu1Q3MAwdyXTYXQp662PWhwO
         cAqKYg5Agfbx2PVUnlsnf6329m8mVq4K0Xpb1nVsXvI/kKW9Xm59TnNhLD5Qnt9L+cxI
         0U7vnuQD2e3wmxoTfrEVvEBvn+QEUJA5NiBlWjEWSFoh63b3mquwH4hc+sRQsf0Ko8Ja
         DQDGLkpM/Pww66OoD8e8fWgHtZxzfBsxpc6Fv8kbT2/A7Bsy2+kCG0EKLQvQ1+84YMaR
         Ihr3vBbe636dV+mAeDrX+5AdGxjR0hGGSc6IJ4O+4NOoyrNdywNJ7G4fQIiBINVelXRb
         wr1A==
X-Gm-Message-State: ANoB5plD01U1eMQdLPbKLs6sm09lhuXcwlxdjmbuTWzTKqMZ09bdA+TV
        Tmv1q2R9VNBs6a7i++DZbot4eg==
X-Google-Smtp-Source: AA0mqf7K+mE1v7tZQxx275XaT1evbeQtA2Yf7MlJpotalKJ4eJCBxIJUmePOtFfIcVRJx6XFbXGQGA==
X-Received: by 2002:a17:906:30d3:b0:78d:f454:ba10 with SMTP id b19-20020a17090630d300b0078df454ba10mr5517836ejb.15.1670597706776;
        Fri, 09 Dec 2022 06:55:06 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b0046b1d63cfc1sm716856edq.88.2022.12.09.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:55:06 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/3] DRBD file structure reorganization
Date:   Fri,  9 Dec 2022 15:55:01 +0100
Message-Id: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make our lives easier when sending future, more complex patches,
we want to align the file structure as best as possible with what we
have in the out-of-tree module.

Christoph Böhmwalder (3):
  drbd: split off drbd_buildtag into separate file
  drbd: drop API_VERSION define
  drbd: split off drbd_config into separate file

 drivers/block/drbd/Makefile        |  2 +-
 drivers/block/drbd/drbd_buildtag.c | 22 ++++++++++++++++++++++
 drivers/block/drbd/drbd_debugfs.c  |  2 +-
 drivers/block/drbd/drbd_int.h      |  1 +
 drivers/block/drbd/drbd_main.c     | 20 +-------------------
 drivers/block/drbd/drbd_proc.c     |  2 +-
 include/linux/drbd.h               |  7 -------
 include/linux/drbd_config.h        | 16 ++++++++++++++++
 include/linux/drbd_genl_api.h      |  2 +-
 9 files changed, 44 insertions(+), 30 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_buildtag.c
 create mode 100644 include/linux/drbd_config.h


base-commit: f596da3efaf4130ff61cd029558845808df9bf99
-- 
2.38.1

