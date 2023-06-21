Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17624738F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjFUSrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFUSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:47:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE19B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:47:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31121494630so7186358f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687373218; x=1689965218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYo99lmmTewHzSLHz5rZ/owoeDw2oYPDOJzFHz9WxPs=;
        b=nCRuccDv25kfuyULNBKdSpL9aM+m2Mn7rhrWi+z+JBCQNZYAvOtmrgdh1IHBAFN/kR
         RVk9NUIC4+oBheflOcP0mNjY9Du9hIcLRu70BrSuydrkWehrJVwPP5ivFHLQu4NlT/cL
         gpQii0X9o0ivswTFxI9eRss4/FgeeltDKxTAsnXU9bMnx2q0rqhrgCIiZe8YD81nmBu9
         W6Y8ubOK2we44UmxQE73QOdF9DZxc0W4hC03Agc2rTUkd/8vd7LcFRzpXaNsZmD8te2i
         XT5ZaXtvAtssEMF81KCurh48P6nrIOL3SIoxKZ+cjIClzDsIquSylRdt/jR+VFziAIsi
         1qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687373218; x=1689965218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYo99lmmTewHzSLHz5rZ/owoeDw2oYPDOJzFHz9WxPs=;
        b=DKK00uwul9F15tWuWDo8BO/s6XNvOe5L+4Vun54Tl2ocvm8wI2NzvlixIcIlWsKq40
         zPnXaRyhvRvEHFV27NTWUljhWTJR/iYTumzWeD6/vwkV/FxCINwu3CW4x2BAyv3NJ8R6
         /jD9lrPV+ba0he1V+XMwxCWRfi/KPlqxidFpqG84xiuowoMrIhcDZ1WSTyaocO+S7Gsx
         F+7cQjzVB3tK3GHLbWDaKM1FDzS6eF2hfQG7UNYhxh8oFZqA1OfqDH0jAyYo69C5249i
         99698sFoLu9BLE9r+WEobEImFzboFSzZCuwlkVjG0O/JaeJOrq23h88O2CCwi1TI+u4Q
         hitA==
X-Gm-Message-State: AC+VfDyfkQUs3y8J45SeRdsypmD3HgF3BQh5C7bW02dUQOMQ0C2wlw72
        m4Q1n0KIwZvhjEhEzKRWVCM=
X-Google-Smtp-Source: ACHHUZ608OrPrCRicmKNuMNldpASeZXTDjZECtB94U+gfRTro8UWQpAH2WmLLZkHAY2xvsLLAvWW6Q==
X-Received: by 2002:a1c:721a:0:b0:3f9:c1b:83cb with SMTP id n26-20020a1c721a000000b003f90c1b83cbmr9271747wmc.38.1687373218293;
        Wed, 21 Jun 2023 11:46:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:5d4c:afae:7fa:7038])
        by smtp.gmail.com with ESMTPSA id n20-20020a1c7214000000b003f8d85b481esm16736774wmc.21.2023.06.21.11.46.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Jun 2023 11:46:57 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, eperi1024@gmail.com,
        hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH v2 0/5] Fix some checkpatch issues
Date:   Wed, 21 Jun 2023 20:46:35 +0200
Message-Id: <20230621184635.25064-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches to fix some trivial checkpatch issues. Not all
issues have been fixed. I intend to submit another series to fix more stuff.

Testing:
* Build the kernel with `CONFIG_RTL8723BS=m`
* Boot the kernel with busybox in initramfs
* Load the module
-> No errors or warnings

---
v2: Move blank line change from commit 2 to commit 4

Franziska Naepelt (5):
  staging: rtl8723bs: Fix indentation issues
  staging: rtl8723bs: Fix space issues
  staging: rtl8723bs: Fix block comment issue
  staging: rtl8723bs: Fix blank line issues
  staging: rtl8723bs: Fix alignment open parenthesis

 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 224 +++++++-----------
 1 file changed, 92 insertions(+), 132 deletions(-)


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
--
2.39.2 (Apple Git-143)

