Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99946971DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjBNXeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjBNXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:34:34 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78230B2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so314997pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWHSYRIGpjE8ps+RcaVCVZkH9tWGvMw1vkVEk7LGuMM=;
        b=LtNXVUDEXaxknQvjqHq5/g14HBl+jkfezj3n+h9pk4ZaZGjb6YdXmBdgPbtfmAQXEv
         oRy0neP0lLQnQXrooDF46xyb7iUcWqp9ChGgM7h0jtStP5fcR7PAU1M30zVmIVeiw/s3
         X8B3TRd64g6dzCTF4YlRdOSsAXAJaW7opoAgH06JR4X7n/xkUh6Zvfw343zqurns0UvL
         /+EHuv+so1b83Y5y13Os7J02+bO/90WL1+BzURyDallC6qKdoagZ+PBS8mLiGd4z7KMO
         jgOcjFpzB3vKoWpGaUUdX4IJ/0rUs+wvcmoFa0vmCtjD/WBVHZ/XxqXLYgZc6a3WoVWI
         qNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWHSYRIGpjE8ps+RcaVCVZkH9tWGvMw1vkVEk7LGuMM=;
        b=UDyG5QETrLT9BBDHAsFGxja3g9mKWjNCXAmKvZvr1jJI7PDKOqSepOGr5Y5V4xUqg/
         BnZc7zeACiDmT2K0nI004rCoYO9I2z6Lv9eHA8Q538XxvJDCwspCw6r5elafQGf7ZSbF
         jDggFnbYSy8EMgmSGSE7v2J5qk0LneDjgl0jjVWWa//1xl94y6belY6M0TW0qN45ESiG
         siRXPJPJq5Sx1d1F8Jg70E2eGK8BwyalkazaLl/UrBPuenz0CE77fiBQKp/ukXJVSaad
         +61X701d8vFf59nc7P41EGbEqpEkoYqhmM5a7b1EMq5TEppwp8/tFYG+tZWE7zjmwflS
         xBHg==
X-Gm-Message-State: AO0yUKWDPTVvYBvOWqBQTbRbqj8tJos9Cc7E7+biEI16LmxdGXIzBmOQ
        RDfr8BBcWdA0whWd6bnWNqQXuwOzppiCog==
X-Google-Smtp-Source: AK7set9ini/PhcW0mk5pmZw9zd5P17+3TjkJCPXJuZHGPsFUdgqv2Il+9UBWSxianKmACsYOxcLRLg==
X-Received: by 2002:a17:902:dcc5:b0:19a:9943:17fe with SMTP id t5-20020a170902dcc500b0019a994317femr251807pll.50.1676417672925;
        Tue, 14 Feb 2023 15:34:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001963a178dfcsm9434801pln.244.2023.02.14.15.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:34:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        Sudeep Holla <sudeep.holla@arm.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 0/3] Save/restore for GICv3
Date:   Tue, 14 Feb 2023 15:34:23 -0800
Message-Id: <20230214233426.2994501-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for saving and restoring the GIC
distributor and re-distributor which was missing for platforms that
implement suspend states where the GIC loses power and therefore its
state.

The system that I have been testing this with has:

[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 288 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs

So no support for extended PPIs or SPIs, hopefully the code is correct,
or close to.

Thanks!

Florian Fainelli (3):
  irqchip/gic-v3: Use switch/case statements in gic_cpu_pm_notifier
  irqchip/gic-v3: Propagate gic_cpu_pm_init() return code
  irqchip/gic-v3: Save and restore distributor and re-distributor

 drivers/irqchip/irq-gic-v3.c       | 282 ++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h |   4 +
 2 files changed, 280 insertions(+), 6 deletions(-)

-- 
2.34.1

