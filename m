Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE270ADC1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjEULrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjEULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD1E42
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f5d651170so513423366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684669205; x=1687261205;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/44e4WS1eRtogQtrXJWHMeH6E8EOc1zsN7tTxAAvXVc=;
        b=ib4BRNOEYBNpt2R6pEHcEOY19OOsrSr77ivJpmse6FMLfQCwczSsGBMeS4OKMftfwt
         pTeeioRvNelQU+S9iDDEsID9IvgGPHVKDbx+X4RVAbvFnn2u3rHyL1YklCcTOI7UhMIv
         yvNYb+qXquJ9i4LBkRPxdzKTT2NapxicT1Cv4c7p/iEY125lqRjzokwVd/0Q+MABxtFb
         LCdd86Df6YnEQNxXuxAEzKWca6eztM5jlXJ+Cf+VIPDGocnJ1vmKKqdaL4QRZjielU3J
         HvNVfLPn+3sw+3Omu2FimY6JrIuzfdfLAAjJs2hb5pP749z7ejA/hGyolzQQUngoQqTX
         w4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684669205; x=1687261205;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/44e4WS1eRtogQtrXJWHMeH6E8EOc1zsN7tTxAAvXVc=;
        b=cFFvjEi0TR42Hd86Wl8LHCUeNZMeariYGbci5ZfEIZBnmHW2YX0LjJm4WjXJPwYLvG
         aEe5QKes3LmO8FtQwvQLqAnYKt/ph0QW3DMP7XyMTS9yuWUscAkbSoWVyNQKa2HS9x6n
         fqHsoNsy854itUn5VrMwoPFZb81em17EOG11n2yv50dOMmvzVcpQP7YavyYNGeDYLZHw
         T5VEaM9GQt3BPU4dFvVpO93m0JX0x8pu0cazHuSB9848fvrSRqWMrgPnBX/ns7b/IEMZ
         JzzINV2W8af9iFC7yeaueFuk9YrdWAAhtv/VQtt0I69m78+n/YrO7XYY7cpSDrnenDiQ
         qBxQ==
X-Gm-Message-State: AC+VfDxmd4KDfB06oqxRrU1zOHRDg3rk7kkNRXMq8muJT/5pN0Dok9Me
        gn7119o1x5vm6j0k/mFrDFvQ/0CH2aFYiA==
X-Google-Smtp-Source: ACHHUZ6xiEo+3Qh9mBfnAFoFuDt8i7edOHXckGwG9XXn0vIw5MHrFqbLvcxsuVmGQun8rvQ2VVaZPA==
X-Received: by 2002:a17:907:961c:b0:967:4bc7:38c0 with SMTP id gb28-20020a170907961c00b009674bc738c0mr7924892ejc.9.1684669204536;
        Sun, 21 May 2023 04:40:04 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b0096f7996d59csm1833911ejl.184.2023.05.21.04.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 04:40:04 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH RFC v3 0/5] regulator: dynamic voltage monitoring support
Date:   Sun, 21 May 2023 13:39:49 +0200
Message-Id: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUDamQC/32NQQrCMBREr1KyNpI2laauBMEDuBUXPz+/NkhTS
 UqwlN7dNDtBXM4Mb97CAnlLgR2LhXmKNtjRpSB3BcMe3IO4NSmzSlRS1GXLzexgsMjjMDpOQhk
 AAdiAYQnREIhrDw77DRogTOS34eWps+/subHr5czuqextmEY/Z3cs8/RbE0sueFcr3dRSkWrLU
 3haAxPscRzyVaz+4VXCUQqpEZsDafzG13X9AEdjGAIHAQAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series targets the "automatic" state handling of monitors when the
state of the monitored regulator is changed. This is e.g. necessary for
the da9063, which reaches an invalid state (!PWR_OK) if the voltage
monitor is not disabled before the regulator is disabled. The problem
could also be tackled inside of the driver's "state change ops"
(.enable(), .disable(), ...) but I thought it might be a good idea to
have a "common framework" independent of the driver's implementation.
The new approach takes Matti's feedback regarding the bd718x7 into
account.

1/5 factors out the current monitor handling, to be able to re-use it
during the state changes.
2/5 disables monitoring of disabled regulators, also something mentioned
by Matti as a "requirement" of the bd718x7 driver.
3/5 adds a new op to get the active monitors/protections of a regulator,
which should help users to add enabled protections to their device-tree.
4/5 adds new properties to let the core know on which state changes the
monitors of a regulator need to be en-/disabled.
5/5 is an example how the bd718x7 could be converted to use the new
property (untested, as no hw available).

Thanks & best regards,
Benjamin

---
Changes in v3:
- rebase to v6.4-rc2, to get voltage monitoring of da9063
- re-use the existing monitor handling
- set initial monitoring state to regulator state
- disable monitoring before disabling regulators (if protection is
  activated in dt)
- add new op to get the active protections of a regulator
- distinguish between switching to higher or lower voltage
- re-activate old monitoring state if regulator's state change fails
- convert bd718x7 monitor handling to use the state change property

Link to v2: https://lore.kernel.org/r/20230419-dynamic-vmon-v2-0-c303bcc75ebc@skidata.com

Changes in v2:
1/2:
- move from board-specific (machine.h) to driver-specific (driver.h)
- move from own struct to fields/properties in regulator_desc
- handle modes as one "unsupported modes" field
- factor out new monitors_set_state() to handle all (activated) monitors
- move re-enabling of monitor after ramp-delay
- add TODOs for error handling when the action fails (return error from
  actual action instead, return state of monitoring to pre-action).
- reword commit message
2/2:
- adapting change to the properties approach

Link to v1: https://lore.kernel.org/r/20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com

---
Benjamin Bara (5):
      regulator: move monitor handling into own function
      regulator: disable monitors when regulator is disabled
      regulator: add getter for active monitors
      regulator: add properties to handle monitoring on state change
      regulator: bd718x7: let the core handle the monitors

 drivers/regulator/bd718x7-regulator.c | 206 ++++++++++---------------------
 drivers/regulator/core.c              | 224 ++++++++++++++++++++++++++--------
 include/linux/regulator/driver.h      |  22 ++++
 3 files changed, 262 insertions(+), 190 deletions(-)
---
base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
change-id: 20230419-dynamic-vmon-e08daa0ac7ad

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

