Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3C72AB9D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjFJNJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJNJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:09:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129EA1FF3;
        Sat, 10 Jun 2023 06:09:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso20392495e9.3;
        Sat, 10 Jun 2023 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686402571; x=1688994571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xugpaacz8xlZmp470kqjJMAuO6t5TJ0n3OkhP9A2rXo=;
        b=IjD2RvyTPrk5wWIfX6SnjXz3VS52TYEBN+J40X913z1qVvfqBnQjnx0c6aWfG1LN5/
         05/ZveHHLbO+CzHPaeB6ZIyexMIaGs/1upAvkTy2+Lo9rJe2G2bAdhPdAXNWiF3xdSRl
         oWQBzxcF5bPWXHgkZDcwKn1EMsaWQBx6D1Jt7ejMth5U/2Z/q9wDk+5dBwZnHJYnGgI+
         JTyGuisSgzOCxagg81tm6ivfaLSPSBCNi8eX6ACgs6lgAM91+g9JIKwCr/1IwIqS7QtP
         qTiCn+KaJJmRZU7JeWQZ6Hs/t0T6EhYaT+wWtJZwnPiVqFtt5h8G75/M/QGY6i3gu/Jp
         8BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686402571; x=1688994571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xugpaacz8xlZmp470kqjJMAuO6t5TJ0n3OkhP9A2rXo=;
        b=DVtYbN0JbOqoAquJSVRypb/lQUFhEyIkryPqrCbMiwchAMSsZ354DUH/L7MW/kPxIU
         gxdCCpotMq1CzrWzRgoLEdmPYi/i+2OkmJd1TTc523ySJCyM2UqVkhGpVjl5IuAHpLpm
         Fe1AnhCZg4kbQtprylNKiH73wfVbUIEUb6r6VerRNL+1DXvEFhEUq6r0fU5xqUug9t6i
         x4DcCBCJmyUff8+//rCwWLmYvNAOVc0jzVYh9tivhROUEqbJteOc5iUwUyQNjITV6XGR
         NHA7cf5cuzcxNOX8kRqViQEOHUgAuT2u+V7pEb6igo72bQAaagvJjyLRaW7TfSjSC7Xu
         3ISA==
X-Gm-Message-State: AC+VfDyqTYtQKRycj/q9csHeaxvKB/k+FqZY/lI2YKUXKzMS4IbDSNY3
        708qfasISKU99m6DNGU8708=
X-Google-Smtp-Source: ACHHUZ46uERpJWiX9xm25h48KxxjJ1bOIB53vUsC2O8ggEHBxYwb60XL0uRT2zXJVUw/V4CBFaX5WQ==
X-Received: by 2002:a7b:cc96:0:b0:3f7:eadb:9413 with SMTP id p22-20020a7bcc96000000b003f7eadb9413mr2679156wma.33.1686402571044;
        Sat, 10 Jun 2023 06:09:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id x15-20020a5d650f000000b0030adfa48e1esm7075632wru.29.2023.06.10.06.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 06:09:30 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] leds: trigger: netdev: add additional modes
Date:   Sat, 10 Jun 2023 06:16:14 +0200
Message-Id: <20230610041616.21141-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continue of [1]. It was decided to take a more gradual
approach to implement LEDs support for switch and phy starting with
basic support and then implementing the hw control part when we have all
the prereq done.

This should be the final part for the netdev trigger.

We collect some info around and we found a good set of modes that are
common in almost all the PHY and Switch.

These modes are:
- Modes for dedicated link speed(10, 100, 1000 mbps). Additional mode
  can be added later following this example.
- Modes for half and full duplex.

The original idea was to add hw control only modes.
While the concept makes sense in practice it would results in lots of 
additional code and extra check to make sure we are setting correct modes.

With the suggestion from Andrew it was pointed out that using the ethtool
APIs we can actually get the current link speed and duplex and this
effectively removed the problem of having hw control only modes since we
can fallback to software.

Since these modes are supported by software, we can skip providing an
user for this in the LED driver to support hw control for these new modes
(that will come right after this is merged) and prevent this to be another
multi subsystem series.

For link speed and duplex we use ethtool APIs.

To call ethtool APIs, rtnl lock is needed but this can be skipped on
handling netdev events as the lock is already held.

[1] https://lore.kernel.org/lkml/20230216013230.22978-1-ansuelsmth@gmail.com/

Changes v2:
- Drop ACTIVITY patch as it can be handled internally in the LED driver
- Reduce duplicate code and move the link state to a dedicated helper

Christian Marangi (2):
  leds: trigger: netdev: add additional specific link speed mode
  leds: trigger: netdev: add additional specific link duplex mode

 drivers/leds/trigger/ledtrig-netdev.c | 103 +++++++++++++++++++++++---
 include/linux/leds.h                  |   5 ++
 2 files changed, 98 insertions(+), 10 deletions(-)

-- 
2.40.1

