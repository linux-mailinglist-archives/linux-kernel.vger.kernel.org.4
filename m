Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E670A6DFF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDLUUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDLUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:20:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F43E5586
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:20:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 194-20020a6301cb000000b00513c951ff2bso11573102pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681330821;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujCaDLBItu3AornBPOFx08s7+tbJaJQvcSS7Yz2BLk0=;
        b=h2Ev0qfgWsZaYCrVdXb7HjYx6ZyzltjaGlGafduz487+2WybmGS2YgCc8B8YedEnt5
         7BAe/Uj2X9sVi7FVIdYR66Ch0kys6yacFY7HuOgvsKrW5BpADv0tMVJtAbimnKQwo55X
         0rNAe7zl1/lD8X3u2a/v8LASLkZeMSzDK6fpPlmScAbkJBio+WTjHQb08ZL2gqk4kkGg
         asbyVAHfA3cV+3WPpmgsA1gI27CSWOc/FvavlgIxEyhO1AlFeYNfn5EQSRlzOaAHqkOn
         FLJH5nXKpnmn0yveOyv3mRP9ShrSbdTd4y3hH4PzZ5pSIl/AwcEvtL/OnrblpJByVPRW
         W7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujCaDLBItu3AornBPOFx08s7+tbJaJQvcSS7Yz2BLk0=;
        b=WHJePTBYHUR8YVurvSmrXHbWZIrvCmvRnKkxSZNc+MSqydcCPYVBDTm7SX1qt9VA4V
         uJGUXYdA2uOcHFDzeT2Yu7iE8CTCESViMOfOcSPxuuwZJwEM2YazPVd0S7Bxp3Eg3FLG
         oY+ls1QsLInGsypwpV3qtQFEQT89h4k7AjrOwF02E2iYhiAV88pwafzGtbp35U/UsssM
         CckV9W4a9Rdg4tVQJIAFh1mAdq5RBSUfNyqlMAp51IIUPtFETT7wOCNeY9Q/7+TzAcCQ
         Qf7sWwxF9unPGegCBudK6IpuiYP9nMyTSAXkTqJnLiFYawMrGrIK0FJUBcrQrmfigabc
         fwDA==
X-Gm-Message-State: AAQBX9daA5/K+5XlCnDB0/SMad24OTiMqyBQ2r9AwKtNPpe/B4KyD5kd
        sE0tCDnICyNSOAo+YGDqJxbJ6geNJD0oSA==
X-Google-Smtp-Source: AKy350Ym3aS97Tdn26Xki7p+EyaZA4V7sdiCrk9Vj2Gu98VLd7hbWoIjqChCTvUuFe34A/vWCiwi2f5Yqzslig==
X-Received: from rohitner.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:413])
 (user=rohitner job=sendgmr) by 2002:a17:90a:de13:b0:23d:4ab8:b1a3 with SMTP
 id m19-20020a17090ade1300b0023d4ab8b1a3mr4937214pjv.1.1681330820969; Wed, 12
 Apr 2023 13:20:20 -0700 (PDT)
Date:   Wed, 12 Apr 2023 13:20:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412202009.3750955-1-rohitner@google.com>
Subject: [PATCH v2 0/1] SPI loopback testing framework updates
From:   Rohit Ner <rohitner@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, joychakr@google.com,
        Rohit Ner <rohitner@google.com>
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

---
V1 Changes : Add module param for iteration length
---
V1->V2 Changes : Fix patch format
---


Rohit Ner (1):
  spi: spi-loopback-test: Add module param for iteration length

 drivers/spi/spi-loopback-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.40.0.577.gac1e443424-goog

