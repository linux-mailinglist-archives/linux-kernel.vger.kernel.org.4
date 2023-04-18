Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F26E6C85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDRTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDRTBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:01:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D187A80
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552d922f0faso55364177b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681844507; x=1684436507;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AAeeT3p1vaSWYTnW7BRdrG3feIz/DGLDWlUjJoHLVqg=;
        b=OwcDT7LOzlCFAeu0xRaCl7iUIBd5PDxPpFkmbfuqYKYvBTruGDFXFp3O7cfM3AFN0u
         y5tqel0Qb/FfiyxXiUCJCM7vp9+2nTofXH3eCB0bjBxrKaNRfKYsKIakhNcS1CyAI6Id
         HugV8UdOjVW8CwD4QuOkKLUkdfhdM/bk6RZoeBOBHb0zhKekacXL1LREoUip2WvdCokp
         KEPA4SecxTOWXfNVprmQYD04fK+rfDv+RcV0uXpu7jQ5DBnKW7ywivcPjcQE5MpShmLt
         KkFvYQs+22HIFvBj2ukr/uHMcvoxadq97exOY+QyT9Zj/oH7DCCXXNCg058YV3N58dp4
         vVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844507; x=1684436507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAeeT3p1vaSWYTnW7BRdrG3feIz/DGLDWlUjJoHLVqg=;
        b=BVvb76uF/20PGKeguMuferXtdwGwWypaedjzegBmEKZK0wRczdsYUgOAvqbYDcG/qH
         +Rkmpuv6UNJ5ASmnKfGBie5lXIqrvWMEsgoa7uvHEU3pDouFyWVS5advZnMpGZ96BIo3
         Cb2fYEkICOcgrjJvIWHfnJw0jSUJbdOYl+n3jtPeJxd0RwC118bSbFhRwkDodgmiryMQ
         TIjSbpM8Iff3Qhaneh0gS0CLgwKkUPTEHsdqlyEcXbMZsPwgd7fu4Q8uNcZUsfCpKKOd
         KeYql0CQrH4bgNGh1lg83oQNrxMevV4mgq4jR138c9Q0ALribB38TSl6Rn6A4VSZSNHo
         MtaQ==
X-Gm-Message-State: AAQBX9dyGWqFhf5ctFfoelvP4Se97btMQomMzIJTA5a6Y5FDNVoG5HBz
        6OiziCdLh/KqU50BfowHSiFhKwMaw1dCAg==
X-Google-Smtp-Source: AKy350YNTdOC+Qu0ZZDEZvRCkBI3kINVlltGg8N+eFVa3z4O61YIZE3/G2hVitPqSZuFWz5SqN3328lLORQqDQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a0d:ec43:0:b0:541:8285:b25 with SMTP id
 r3-20020a0dec43000000b0054182850b25mr467702ywn.10.1681844507277; Tue, 18 Apr
 2023 12:01:47 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:00:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418190101.696345-1-pranavpp@google.com>
Subject: [PATCH 0/6] scsi: pm80xx: Enhanced debug logs for HW events
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances debug logs for pm80xx HW events, and provides
a minor fix in the case of a hard reset. The log enhancement involves
changing the log severity level to enable logging for HW events
which consequently help debug disk discovery issues.

1. Changed log severity level from MSG to EVENT for HW events.
Enhanced the HW event logs by adding the phyid.

2. Enabled INIT logging.

3. Log portid along with the PHY_UP event.

4. Print phyid and portid sent as part of device registration
request.

5. Log port state during HW events.

6. Update phy_state and phy_attached to correct values after
a hard reset.

Akshat Jain (5):
  scsi: pm80xx: Enable init logging
  scsi: pm80xx: Print port_id in hardware events
  scsi: pm80xx: Log phyid and portid device register request
  scsi: pm80xx: Log port state during HW event
  scsi: pm80xx: Log some HW events by default

Changyuan Lyu (1):
  scsi: pm80xx: Update PHY state after hard reset

 drivers/scsi/pm8001/pm8001_init.c |   3 +-
 drivers/scsi/pm8001/pm8001_sas.h  |   1 +
 drivers/scsi/pm8001/pm80xx_hwi.c  | 126 +++++++++++++++++++-----------
 3 files changed, 85 insertions(+), 45 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

