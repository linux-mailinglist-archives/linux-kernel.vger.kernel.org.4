Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B972B49B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjFKWaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 18:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFKWaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 18:30:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633B183;
        Sun, 11 Jun 2023 15:30:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30adc51b65cso3368862f8f.0;
        Sun, 11 Jun 2023 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686522614; x=1689114614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGQ3uMO4HQ81bLURr48D1zlOOxw70oBhSmoq5dRLdaY=;
        b=ZSzf39O4PBvDAhNij9DpH0Ss5skhWCx0koKZvQZkXGI08Z2wsKylmm0V602n33ODAz
         HOyJ8CFkCHzfWbLTilczWbd6hHOGqzIHpDCytpSNPtsVDPbAopWJE98x13/i9LPrRZWT
         e0Kh19UaHvn04UiTw4kU7s6RfydWP9pCehzoE3DtjucJwpg4dtOEp6yIEIusg4MqQdqC
         t/Duimvos5jLorPoSIQg0EmPPbgRXrx0OW5JiteOdjt7Xj3s6i0XbimBCfFZ3Xi/2eVM
         r9B8o9up6KBXR/KUZ/9+Ei17WkrINqGZ31TBQ4x960YUY9yCrG2eGKFqqBUErIr8n1w1
         oEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686522614; x=1689114614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGQ3uMO4HQ81bLURr48D1zlOOxw70oBhSmoq5dRLdaY=;
        b=C1lsAB4EKc/r0UU9WAkALEfJizz060sFvc28yvGGeytmEIrQNoJD7sUx5IvjQBdNcb
         s2LKbZLG1+srZIzSd8kBBGatt0FMnUSxDILTzcpmNnLipjgQkBKB/bbNWPvIq49tLOjd
         t9tnM0hRPfPHgiLv0THnm+nwQUOd56trjdBAo6jSN1zAuHaTzdfGOVWKh2AToZs9o1rn
         Vh/QhaDlna/vlzDuht249OfCxSgV7yWKIKtovFlBtfQJcOwtjbp33neWVXjAVBGN+Jf1
         IGHKLwkHmEsHywKi0VKsLV6cqGKzk0ftREPlAL79dwYukOnhTx1Lpz1CzKquxoxoqReJ
         bC4g==
X-Gm-Message-State: AC+VfDzpK5TlzKRuo/PXfRIGL+Om1Mc933ibEZeTW9NerucgjEqepdct
        AQZBWyuos2HxIi6kwojDBiOJmnB8UuU=
X-Google-Smtp-Source: ACHHUZ70CvfZry/OJqllZxhM0FlLdsdHiPAVm58CkilPbuTkNh2yhPbBZmyz/UmW6Sd3jVBVRnlYdg==
X-Received: by 2002:a05:6000:46:b0:30a:f36e:72a3 with SMTP id k6-20020a056000004600b0030af36e72a3mr4157767wrx.0.1686522613661;
        Sun, 11 Jun 2023 15:30:13 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id a7-20020a05600c224700b003f60a9ccd34sm9509479wmm.37.2023.06.11.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 15:30:13 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] leds: trigger: netdev: add additional modes
Date:   Sun, 11 Jun 2023 16:47:57 +0200
Message-Id: <20230611144759.6096-1-ansuelsmth@gmail.com>
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

Changes v3:
- Add Andrew review tag
- Use SPEED_UNKNOWN to init link_speed
- Fix using HALF_DUPLEX as duplex init and use DUPLEX_UNKNOWN instead
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

