Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E670E790
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjEWVlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjEWVlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:41:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FF5119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:41:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8696637a7so412151276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684878103; x=1687470103;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYoP+7y3H6KxflmECkTj0wmu7P4fg+DdkxFWOe2r+Gw=;
        b=fiYfRUVv6NDJ5NH3wVrtXPpRMWJsZHcc72EYpz6mfFUVqJDMQiDkSDwLuV4tuZZNmr
         KosGFPNUODdxyPJN1Vvbm4TX8BuYIaiDAxPkmc1SqOgSIG11U7rNSFHupVCZ6wK3fxSo
         BU7elBqN6D8meTOn6NGXNNEm7R3q0E/7/6nVvKkaCR8xhB7LxWjhavNXEdfEGgqRnIiY
         MfUNRvkYtfBjOxhGPlnv0lyKaF4EQr5ClEgmq85xIQW0T/Vn0f77GUhuiN4SvCmjSZtg
         roT5Rt04/ombtVEqKPDShkUvMMSJCQYGpu20Fhs/lYQzOPVmUyXz0ApyqENH6TTE3brK
         QOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878103; x=1687470103;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYoP+7y3H6KxflmECkTj0wmu7P4fg+DdkxFWOe2r+Gw=;
        b=RPtGMx1CG99XxrlbPRNenlTGCHX98+tg1y370CDW4elzDAvbA2Ui8Y/cDZzWU2/MfB
         nZn68PnlDRIvnK48C63TPqM95KfwDY048V9G4QYyCQNgA+lCAToSEg2nEhI/szrpJEMd
         IvMkp5CmOGTpL0C9PKX6nGbO8UKjajkglIWMwruSY/2OQp4wKKR3XYqdZ98SWjgN08iT
         8/XHYFR8D+MNiWTs90jqll+w79xONK8Udo54zD+nnVl67dZ5TR5KsAljs6ioF4mc8t6R
         QFCokQvPQMzE8/z3fI8d2u6sSVEhJIihUzIDEkM0j5aB1oDyV1sGrgUICfl3CUj+MCYK
         M1oQ==
X-Gm-Message-State: AC+VfDxDDNJtkjp1h0W+/PEPMiZd7PveaqoBx2KVi3oZ3EoypfA991/C
        9PBA1+GrNkE3kSBeK7Pv8S7M47sQYkLvhQ==
X-Google-Smtp-Source: ACHHUZ6rDfhPdvFJHBI17huMiHUy5WPeuPTapN6ej6oM5BcAycgGa2pPMIjNcbUEz1/tKeG7b+/AjLfxaHlMuQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:6902:3c2:b0:ba8:939b:6574 with SMTP
 id g2-20020a05690203c200b00ba8939b6574mr9212761ybs.12.1684878103088; Tue, 23
 May 2023 14:41:43 -0700 (PDT)
Date:   Tue, 23 May 2023 21:41:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523214127.4006891-1-pranavpp@google.com>
Subject: [PATCH 0/2] scsi: pm80xx: Fatal error checks
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds fatal error checks for pm8001 driver
functions pm8001_phy_control() and pm8001_lu_reset().

1. Added a fatal error check in pm8001_phy_control().

2. Added a fatal error check in pm8001_lu_reset().

Changyuan Lyu (1):
  scsi: pm80xx: Add fatal error check for pm8001_phy_control()

Igor Pylypiv (1):
  scsi: pm80xx: Add fatal error check for pm8001_lu_reset()

 drivers/scsi/pm8001/pm8001_sas.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.40.1.698.g37aff9b760-goog

