Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043765CB47
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbjADBPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjADBP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:15:28 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500617066
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:15:27 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id g32-20020a635660000000b00478c21b8095so14687120pgm.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fIVffE7jh79Mo6odD78GNMWGDn7q/x/UbQyXfVpvLf8=;
        b=R1mYenG6bwp0GXPiA6n7F6oOHfPw4fabz24w8PTGUrU5AmV+z+/EJt23hf3KSAh6iC
         Mzfp07vdkJ6S6ThqGdmL7iLGr2nQUoiXsfWuKzbRv7xP13gsRlJ2b1mGumBZTfejphW5
         fbUfJbXpo7V0vfhtEsTlfjvpEzQMarcaH/IiWoMC49g6fO34YVVeDtIdU1vSvjfwBGSU
         +d4LIKKwdQwOgnj6/F1slv0h4JYezlvsb4aAgs5njBYeTqUUdwkfYC9n0MD/7R/GlXVw
         dz+glVBZu57and1Pf52njzYn6c8rneZ1KTvqdptIduZsdHpwWfeiHfdiC2x1yyyY5MT1
         /Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIVffE7jh79Mo6odD78GNMWGDn7q/x/UbQyXfVpvLf8=;
        b=xtTi9BV772EHxLjG0sUPEA83cjXQ6UlruEuPIC+jzL33qncwFj5WqNGKLavBsFAKJ1
         n738XLdi4MHOrX2nbt6jpQ4+dzVLl5GHAEyN5iQBfS2pCwU7eqCixpksNOzSkZc7UrkY
         WakLUeE1LlKZP24+tB9IaxlejhZIeJKhcAUQE8gsKLC+EUtI3R2w0yWxfeAuxx3Ol4L4
         0gRZynYPBBbHA7a/D2tFF6yUSSKSvznVg3A4syU1fusgx4LmLm6C0+DZjt38lcko5zUR
         OelZCrjC685jApVwWyU1fMrHhNT1LXTnf3P+m25IId/DQtRuPSqI01RrSIBVtveOlZdZ
         CKgA==
X-Gm-Message-State: AFqh2kqyFmB73NBMVyZiLW84TpHG/oDRX+vYStXhTCosGptvpY0VRiEx
        l8gcONnuW1Wo3xKuhA/yt+rOAPeW1ga992k=
X-Google-Smtp-Source: AMrXdXtcM04eoblfgC3LCrdvLPB4rbEBCe8B5GovNelS/DtjLzoOKfv/12/m6w6Vcg/zhZfl5yIv3ojJ/NWYc30=
X-Received: from robbarnes3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6451])
 (user=robbarnes job=sendgmr) by 2002:a63:2003:0:b0:48e:bdef:b6fb with SMTP id
 g3-20020a632003000000b0048ebdefb6fbmr2155284pgg.457.1672794926930; Tue, 03
 Jan 2023 17:15:26 -0800 (PST)
Date:   Wed,  4 Jan 2023 01:15:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104011524.369764-1-robbarnes@google.com>
Subject: [PATCH v3 0/2] Handle CrOS EC Panics
From:   Rob Barnes <robbarnes@google.com>
To:     groeck@chromium.org, pmalani@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org, Rob Barnes <robbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the OS ignores EC panics when they occur.
After reporting a panic, the EC will force a hard reset,
possibly after a short delay. This may cause loss of data.

These patches add a handler for CrOS EC panics. When
a panic is detected the OS will attempt to flush critical
data for debugging purposes and attempt an orderly shutdown.

Changelog since v2:
- Minor updates to commit messages

Changelog since v1:
- Updated commit messages
- Split into two patches
- Moved panic handle before mkbp loop
- Switched to dev_emerg


Rob Barnes (2):
  platform/chrome: cros_ec: Poll EC log on EC panic
  platform/chrome: cros_ec: Shutdown on EC Panic

 drivers/platform/chrome/cros_ec_debugfs.c   | 23 +++++++++++++++++++++
 drivers/platform/chrome/cros_ec_lpc.c       | 10 +++++++++
 include/linux/platform_data/cros_ec_proto.h |  9 ++++++++
 3 files changed, 42 insertions(+)

-- 
2.39.0.314.g84b9a713c41-goog

