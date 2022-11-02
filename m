Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51626615BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKBFbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiKBFba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:31:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA7266A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:31:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h193so6621691pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Uhhi8iG3JhPMCXLvwtLoUGRfn2nByYcmLb85IgK3n0=;
        b=2gEPNh8HGtbQcEhGFpzmgIfZdoM28gwiSbPfaWMhmz7QIktWqW7733RPi09KI1Xh9e
         pxGmZia+JRCptRyWv8OH5VlVhydWua06dAtf3xGL80oiY6rB6m7OSiGKIFnU6UDbsp/B
         VLbqc7uqgn7lUEILAjImBgrGUJTdMSpNHrjZxnSF5plbHgvpJgE5dpGD7F2Rz3leguYa
         E3QoAR1i/B+BAFL0iCv6Ba/08QM5p49gY6o8Rp/gEgMPyiZMsorzsQk2n8bzYBk0YNgg
         udhY4Jeukk4PjsdbKIh3fmEosq196M9kZtni5dAUTdOjKUlIcP/PvKjSnSe/KCqDfB74
         psIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Uhhi8iG3JhPMCXLvwtLoUGRfn2nByYcmLb85IgK3n0=;
        b=itjrPoPvxsIYM27JWJ3eHVProUZg0fCSidmCnMj0xI5qVA/kLcRmY64cUEAdbcAN1P
         SVH7MP9Tfh9cAD99bAYZcvSWvA5DHx2Xozg7lGy9qbNTDR6tOkNr98cYNpLph/eOTZOP
         oUM2tlw1ak1hEmmPSc4/jqG5GtD7N++BREukvW3U713ledoF5IKY62ByedkC2nNHLYSP
         xOgIuyp93W3/Hd/TYLEZYu9EUItGWUMBS0TJaPNvzI1+wqFtZiIqAXZrjhF7KypGLOrf
         0K6KfvOW1915usN6aFA1k/7g/wFAJ1tqncQ7NAeCbmms+QkJwYLxXfDM2VU8aiHphZIa
         Kx2w==
X-Gm-Message-State: ACrzQf2q/rAjJogk3buN1eYz5xNMi8rY8c8P6VD7Xz5m+YSIAWCwrdzF
        Y1dO2ihV4wn+vFcX3/PRlsUuBttgzlJeig==
X-Google-Smtp-Source: AMsMyM6HTj0QStfkW8lklz0PVaHYZKyRMEZzPx361AAY3kDT1T+OjZrU4aJTuGFEmVm6yDnuIAsMqQ==
X-Received: by 2002:a63:66c3:0:b0:470:8fd:7bae with SMTP id a186-20020a6366c3000000b0047008fd7baemr1329430pgc.277.1667367088973;
        Tue, 01 Nov 2022 22:31:28 -0700 (PDT)
Received: from ubuntu18.mioffice.cn ([2408:8607:1b00:7:9e7b:efff:fe41:a22a])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b00186b69157ecsm7276367plg.202.2022.11.01.22.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 22:31:28 -0700 (PDT)
From:   Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: [RESEND PATCH 0/4] Implement File-Based optimization functionality
Date:   Wed,  2 Nov 2022 13:30:54 +0800
Message-Id: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijiaming3 <lijiaming3@xiaomi.com>

Stoage devices have a long lifespan. Device performance over its
lifespan is not constant and may deteriorate over time. To remedy
this, JEDEC came up with the UFS File-Based-Optimization (FBO)
extension (JC-64.1-22-67). The FBO feature improves this performance
regression via physical defragmentation of the LBA ranges that are
associated with specific files.

This feature expects the following host-device dialog:
1) The host let the device know of lba range(s) of interest. Those
   ranges are typically associated with a specific file. One can
   obtain it from the iNode of the file and some offset calculations.
2) The host ask the device for the current physical fragmentation
   level of this file.
3) Should it requires, the host instruct the device to perform
   defragmentation.
4) Upon successful termination of the defragmentation phase, the host
   may ask for the new fragmentation level of the file.

lijiaming3 (4):
  scsi:ufs:remove sanity check
  scsi:ufs:add File-Based Optimization descriptor
  scsi:ufs:add FBO module
  scsi:ufs:add fbo functionality

 Documentation/ABI/testing/sysfs-driver-ufs | 129 +++++
 drivers/ufs/core/Kconfig                   |  12 +
 drivers/ufs/core/Makefile                  |   1 +
 drivers/ufs/core/ufs-sysfs.c               |  26 ++
 drivers/ufs/core/ufsfbo.c                  | 519 +++++++++++++++++++++
 drivers/ufs/core/ufsfbo.h                  |  23 +
 drivers/ufs/core/ufshcd.c                  |  15 +-
 include/ufs/ufs.h                          |  16 +
 include/ufs/ufshcd.h                       |   1 +
 9 files changed, 734 insertions(+), 8 deletions(-)
 create mode 100644 drivers/ufs/core/ufsfbo.c
 create mode 100644 drivers/ufs/core/ufsfbo.h

-- 
2.38.1

