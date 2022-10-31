Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A93613F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJaUlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:41:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A0C39
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:41:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso93253wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDALKiQaAtB2jAxk2CnRzIDIR9zGhRZtbrNUSutqOsI=;
        b=X9KYByiRwSLA1bfDYGIPPimVKFju/hAN6iERJie2Wr+uf/RmiqOm7YVN7VXjprd8Ah
         AofwnNqbG0oeCshGlwchvhVcrZPQOj+BlANHEGSsRhKuizcxCaAcBo4iKL87ty75C/Hc
         5hIjCovqVNMhKYcDU2N9QxWquCNU9jcC70rMcw2JuoD5dYA4GAsGo5UbqEPQRafJubc8
         mTB9UvanisPW9+NdoEnjPQsXmLHYRXqzvyCpE372emTAUE+qEtTLiyhGj1d9jHUDbFIq
         ufKujAZG1ToS3pd3i9jf1sKI3GRDQhjNiFtSb3BolPytbwsV5NsShpQzQGol/4YaidTx
         ZJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDALKiQaAtB2jAxk2CnRzIDIR9zGhRZtbrNUSutqOsI=;
        b=Q72CiZBscns4lU46yd7/YcXWpivndvsOTkY7ArJ3QMf9PJSkZEF0JFoY+QuLIFNnUH
         3kQphzN6sNFnGTBw4GqbpJ0m/v+BbwHBXO5GCkMdYVPmSAmKKr5m8GNL8XINNiHk43UB
         EmsERiW14WElGTc/cOUgCdWesW6gbESgIu3k0AdnIokuvB/ERqKMGC+Bj31mKTWufF1n
         aN2vlfvTiYMviO5/8fHfUhTF7oUrC5N4ZyofUSMjlSD4KUF+KEsYbrLQESmiFK87qcbG
         bGWN5NV1FAwpCH+j3GixgSS0nqKc9ZotzweNKMP/ul2/U5y8XElruuVOQZITJrc4k7Pe
         Oo1w==
X-Gm-Message-State: ACrzQf2UbGcT3U89xZqBoXVjijbCVprKXX+wlyeZuV++FkXpOaVSHHtr
        89uCYfi3IG6Q2VsOyO2O5XonCgbwe+jEVnJB
X-Google-Smtp-Source: AMsMyM5wRsMMdcUV8SY1uomHd+9SfZ4aQuXYhYc4BVX0MIvhqI3+uwEGWD+U+oF/5cgBmJr21BpxFA==
X-Received: by 2002:a05:600c:3d9a:b0:3cf:4969:850f with SMTP id bi26-20020a05600c3d9a00b003cf4969850fmr9448829wmb.130.1667248897250;
        Mon, 31 Oct 2022 13:41:37 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d6a8c000000b002364c77bcacsm8012939wru.38.2022.10.31.13.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:41:36 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 0/2] mfd: max597x: Add support for max597x
Date:   Mon, 31 Oct 2022 21:41:27 +0100
Message-Id: <20221031204129.1434059-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.

Changes in V3:
- Address code review comment
Changes in V2:
- Update depends in Kconfig.

Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add bindings for MAX5970 and MAX5978

Patrick Rudolph (1):
  mfd: max597x: Add support for MAX5970 and MAX5978

 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max597x.c                         |  87 ++++++++++
 include/linux/mfd/max597x.h                   | 102 +++++++++++
 5 files changed, 366 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 6b780408be034213edfb5946889882cb29f8f159
-- 
2.37.3

