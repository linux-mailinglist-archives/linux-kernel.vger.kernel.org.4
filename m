Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027776FD2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjEIWex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEIWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:34:40 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F9B49CD;
        Tue,  9 May 2023 15:34:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64388cf3263so4642426b3a.3;
        Tue, 09 May 2023 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683671672; x=1686263672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nm/iB1zX0wTmh39nnUNXbCnFgHABdZ3zLA40vJ95ofk=;
        b=hyYJdXFW4QC3b9HxVlK89KHgNVcYjlbqzLZtwZpwWs2ktV0Rk9oq7wGAwBxCEMbnHz
         TPqEG6gc7hzUF59xTJo6X6yVHaPWM0y1BIvUOKGqd1RBwlMSBz+KZew0pAodu0D1myfg
         HiAS3ERNZtfgnKDrmATnVnYgVihDlIgkSzcNxw4EJf+mSPAU/ekbaGY+ZwzGGD0VsBuz
         b8uiVL3I16RC3A0409Sb19B6RDXZ0zEX3/91wnrbINgtkE+oCqcyKelnaLfXe3XrnqZr
         x5Asf9j2VKtHNawj5SnCfoMe3AklD7kHfaiS4pgEjG6i0lhp6TpUFVFYkqUqC5/e0LuG
         f3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671672; x=1686263672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nm/iB1zX0wTmh39nnUNXbCnFgHABdZ3zLA40vJ95ofk=;
        b=bnTlYebS+uMFBXC7g0+NL2yMgEp9EH4PQ0+UD7ItPxyiY41u6Je3HjpSH+ctNVb7oG
         RWIfXH7LP/hHlNC5VEK3RgT3QSicwa0ZZoKif05EtwMw/NXF74IVC802HG/Vcj7FPaOk
         oYO0ZO4BCrzMNg/9x3+bmpomkA20BWNig6M779v753sVAbs6BpTGGqZIh7nxLd5+WhML
         wULpfWJ50niVgsUWKsqzLDDzfX6LLByUMsLSX7o0HtAGZLkWOIcHCFAk5z7EzPe2K4vu
         b6OYuo906qqhPtziD9/MsCCfnT7ijGeKkDPr+JGyrl8rUJRzBd9U10D0tRjdNkoIMavD
         eorg==
X-Gm-Message-State: AC+VfDxd202MbLCWF71c+5MJkMy+q3HJsG9zim6u9R2K+4eZO4DIeG2s
        0XIxqN587B/fa3wpiehXUkr7NEJROIU=
X-Google-Smtp-Source: ACHHUZ5M0q2kgcwCyV5g0FRAI+Wsgqo+WR18DX2sQYSBuRUV3LPYZBi9zDZQmmfBps5eZbiN8c2MYw==
X-Received: by 2002:a05:6a00:2da8:b0:647:776c:d19c with SMTP id fb40-20020a056a002da800b00647776cd19cmr3112845pfb.13.1683671671813;
        Tue, 09 May 2023 15:34:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006438898ce82sm2317274pfn.140.2023.05.09.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:34:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 0/3] Support for Wake-on-LAN for Broadcom
Date:   Tue,  9 May 2023 15:34:00 -0700
Message-Id: <20230509223403.1852603-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Wake-on-LAN to the Broadcom PHY
driver. Specifically the BCM54210E/B50212E are capable of supporting
Wake-on-LAN using an external pin typically wired up to a system's GPIO.

These PHY operate a programmable Ethernet MAC destination address
comparator which will fire up an interrupt whenever a match is received.
Because of that, it was necessary to introduce patch #1 which allows the
PHY driver's ->suspend() routine to be called unconditionally. This is
necessary in our case because we need a hook point into the device
suspend/resume flow to enable the wake-up interrupt as late as possible.

Patch #2 adds support for the Broadcom PHY library and driver for
Wake-on-LAN proper with the WAKE_UCAST, WAKE_MCAST, WAKE_BCAST,
WAKE_MAGIC and WAKE_MAGICSECURE. Note that WAKE_FILTER is supportable,
however this will require further discussions and be submitted as a RFC
series later on.

Patch #3 updates the GENET driver to defer to the PHY for Wake-on-LAN if
the PHY supports it, thus allowing the MAC to be powered down to
conserve power.

Changes in v2:

- introduce PHY_ALWAYS_CALL_SUSPEND and only have the Broadcom PHY
  driver set this flag to minimize changes to the suspend flow to only
  drivers that need it

- corrected possibly uninitialized variable in bcm54xx_set_wakeup_irq
  (Simon)

Florian Fainelli (3):
  net: phy: Allow drivers to always call into ->suspend()
  net: phy: broadcom: Add support for Wake-on-LAN
  net: bcmgenet: Add support for PHY-based Wake-on-LAN

 .../ethernet/broadcom/genet/bcmgenet_wol.c    |  14 ++
 drivers/net/phy/bcm-phy-lib.c                 | 212 ++++++++++++++++++
 drivers/net/phy/bcm-phy-lib.h                 |   5 +
 drivers/net/phy/broadcom.c                    | 126 ++++++++++-
 drivers/net/phy/phy_device.c                  |   5 +-
 include/linux/brcmphy.h                       |  55 +++++
 include/linux/phy.h                           |   4 +
 7 files changed, 416 insertions(+), 5 deletions(-)

-- 
2.34.1

