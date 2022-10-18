Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395246025CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJRHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJRHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:33:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11FD647C0;
        Tue, 18 Oct 2022 00:33:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so13261118pjl.0;
        Tue, 18 Oct 2022 00:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=eQSVen1p2Y5GfCyu3w9CAFa9H/zR1rYZVHO/SrmOkRMLuetRJUqdeAH+DFXAsye+jZ
         vNN7cLon6QNedGvhV0XM+gEayfzPjHsXWeVWiBmnO5ZuMs5giwDWKZ86ddf+qUuOsLB3
         MNxTQH8mtGZNI9GfeVGV0PwYJFxQq1wLhrC0svZU5exoBz5Xs0zrGWT7VclpBl2K1lE9
         r4o4Cig6qwCMNRjuDtBEBkpEsRUDgy1mdpSZKmCnRMB+msDl/aLel8EmBsVYq6ZvIWW5
         f3J9AeoxDjxVdU4R3BUyMAhFjNWQDyGC1qmWLprda963XYXrIoZLO+11Nlie5cBio+AA
         mCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=Z263AL7Vh2e251ap3k1LJ5v5CP1oC5aVptZeTJJ/JdkGLciH0+CtfGKd/hsRzRvz/3
         EIdU9lWBcvZtU3cav9ZL6jcDrCexsodAlVwwWEBCcXcF0McksiFP68bRlMILpJULhVYE
         NqF0XKt6BaEmKd60wJr2W1apnZNL0ahLw3DfDz18E64VkBjzUCG2UYM86nMl2RB+UcKd
         lDGo836zlaFMUY2yqiRR9s/tNZdk3rtfqxM/rC8U+MvyKATmLFS8CeVjlOmt4TutQlkj
         TCIwhY3CN0ANOyVpY9XCpJl38QGYKgt0l6O4oVGLohiGjLldzd6zg2tPoJWhO0rH9nBg
         WfSg==
X-Gm-Message-State: ACrzQf2HNSF3JW+Ki5GouNMINL0nuX9kqzABwfIhymxoez4FyNkNHF+k
        z1BMZoT7B6ZGad+W3Hn4jAk=
X-Google-Smtp-Source: AMsMyM5ymQfvsJkKieokFR3ManmwtxeTxbHN8TuFfwchzLGVDWoftGl3FvKwQJsJ/cHY0uL9Cc3V6w==
X-Received: by 2002:a17:902:7081:b0:178:6154:9d79 with SMTP id z1-20020a170902708100b0017861549d79mr1725816plk.79.1666078390591;
        Tue, 18 Oct 2022 00:33:10 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s1-20020a170902ea0100b001769206a766sm7853260plg.307.2022.10.18.00.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:33:09 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v11 0/2] Add thermal control driver for Sunplus SoC
Date:   Tue, 18 Oct 2022 15:32:50 +0800
Message-Id: <cover.1665990345.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for thermal driver for Sunplus SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus
  dt-bindings: thermal: Add Sunplus schema

 .../bindings/thermal/sunplus,sp7021-thermal.yaml   |  43 +++++++
 MAINTAINERS                                        |   7 ++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 130 +++++++++++++++++++++
 5 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

