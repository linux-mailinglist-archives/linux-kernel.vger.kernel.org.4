Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F228E6C653F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjCWKh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:37:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D922A30
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:33:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so84360003edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679567636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJvlB1/rh6Hpalkxu3jTJ8YoiluXE/8fG50CDYwqDlk=;
        b=dY2ajohMVM50QDWHUF+mXYO/Q1Rvu6+pYqOPiqwaLuDkiT0XFZYNbzcXI/TnCP+h8h
         Q2BuboB7rl4qoEDW2fvdgg33RByQdIdesDz+yCFgm0rxGKEoGetkbvFAri5qPAc/djWY
         cgIlRbbZ8SEHLO2pImvyZq8KfchZCMaMS7PtAAOS4X6uWpyBNWBdFpRv3Po6XRbwY7dm
         yjrF0y/Ny90KyY5WSPa0GifJu7putX2CpQhnPtayTB9+3U1c7fXOKk0xL/VQXMdRXUkY
         teQzB6JoepuhWKd0r4AvQKXj9ENqm9Np8HbEcT981YdrkdGFxRZChHyKSpT3GZW5OUKc
         hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJvlB1/rh6Hpalkxu3jTJ8YoiluXE/8fG50CDYwqDlk=;
        b=AmZpnTJIERJJWVqREQhGW2NSeH7MxQtKaV4WdXqiUUHiSyx+keib3rAJyC0GlNJEhj
         EnK56duZhKXxl8ewEujDUrmxoPtwnK0xgN20A0jzg/Qcnhf/kNoYxolHqYgkwpC73no5
         WnbJJx7qpD3i0ZjXGDk0xJAzPBaHEFhHw46012IsP8Dm+I65j+6tWSQSmk6Nr6Tl6UjM
         /GkZM1NsO+qAJyOl3i0tUuLAwZZRFsYTFGUDRNlCpqbGhBGpp0ocr1UdI3kPLm46+Mzh
         02c5708CMF1BPrUsTU6LhZQn9T7X1oaf47ktwWZwtOXcz793G5+ewJI2sUsArv4ld6yp
         HkQQ==
X-Gm-Message-State: AO0yUKWRWyBRFd1Y+Tw6D2YrPrkr/UoigoT9350x/uHeNZW2yQwb9o/Y
        AiWt+ElbOCbJiC940iI1myw2DHHjMV691Q==
X-Google-Smtp-Source: AK7set+/xZooQyOwxULME6tptP/L1+jeMfX6gGC4sTTj3x9xNdhJXVLOl7gAHyuOmsJweblxRUuq+w==
X-Received: by 2002:a17:906:c413:b0:8b1:7de3:cfb4 with SMTP id u19-20020a170906c41300b008b17de3cfb4mr10010320ejz.4.1679567636710;
        Thu, 23 Mar 2023 03:33:56 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709060c0f00b00928e0ea53e5sm8432687ejf.84.2023.03.23.03.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:33:56 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v2 0/3] sched/psi: Allow unprivileged PSI polling
Date:   Thu, 23 Mar 2023 11:33:47 +0100
Message-Id: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSI offers 2 mechanisms to get information about a specific resource
pressure. One is reading from /proc/pressure/<resource>, which gives
average pressures aggregated every 2s. The other is creating a pollable
fd for a specific resource and cgroup.

The trigger creation requires CAP_SYS_RESOURCE, and gives the
possibility to pick specific time window and threshold, spawing an RT
thread to aggregate the data.

Systemd would like to provide containers the option to monitor pressure
on their own cgroup and sub-cgroups. For example, if systemd launches a
container that itself then launches services, the container should have
the ability to poll() for pressure in individual services. But neither
the container nor the services are privileged.

The series is implemented in 3 steps in order to reduce the noise of
the change.

V2:
- removed renaming patch (previous 2/4) and applied suggested solution
- changed update_triggers side effect removal as suggested in review
- rebased core patch on other V2 changes

Domenico Cerasuolo (3):
  sched/psi: rearrange polling code in preparation
  sched/psi: extract update_triggers side effect
  sched/psi: allow unprivileged polling of N*2s period

 Documentation/accounting/psi.rst |   4 +
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |  11 +-
 kernel/cgroup/cgroup.c           |   2 +-
 kernel/sched/psi.c               | 315 ++++++++++++++++---------------
 5 files changed, 181 insertions(+), 153 deletions(-)

-- 
2.34.1

