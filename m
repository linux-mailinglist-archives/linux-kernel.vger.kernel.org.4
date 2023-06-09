Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9725F729BFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbjFINvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjFINvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:51:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F0718D;
        Fri,  9 Jun 2023 06:51:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so14061725e9.2;
        Fri, 09 Jun 2023 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686318670; x=1688910670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RYV5mIt6n6y7m9u02ykJLGYfsCgH+WAjf8v0LH/JCw=;
        b=RWy6/fdZiXEIh+9mvQzLMJTt+FuaSB4Tyf1lNRC08YVDblBKYa73qF9GVyeXBrvQdN
         PLH92KRgSq01EpNdefgMa6h/HRjemxIONcxtSxHoZE/rALbPGkSOPI+40EjNQqb2sLYe
         ylnX3blFH22OyNpAVRFmGEyA9k5HMln2M/ew1lCdBuCexXFeLKB/gpCbf2qw5mdkTY6H
         L2jpLkFtd0ZV0dKinFYbvLyWV90rSk1hDrgD39ijPqz02qQoLai+yhAIJz3L1AAOKsx1
         mkTxg43YUCRtJK+tnPc62nExPoqiVmH/mqyfMrxilTKWPLYwo5o/PmU3ZBlzjHJPYjvC
         h1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686318670; x=1688910670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RYV5mIt6n6y7m9u02ykJLGYfsCgH+WAjf8v0LH/JCw=;
        b=a48Y/eVfYK+jNFqb4EJuQhF/63cUENiW79BeeeD3mRi6ekqWlvI1O3v1/4V0gKZUfw
         Qjbdp4iAXmMz82YHb0L2Da/YXCxnNzJwmCF9gAOnj9BAk6g4jviXt1/Mg/S+C4ACtKk1
         sNM210tg0tGSUVZ1LnUoEE2lwb2JLGfh7ONusGBG8Po2RQlqV+fkGQXdia3ZaWTYRWWe
         Fx+f42r+/XZGAY9e3GzaYaDVR5cug988FtnqQEyJ7z+/8OmNU197Br1prhiFdbUTWKma
         1tHAqFUHQ5CGbwLfPdLDgxUgU2y684ELjr8EXx+v6bpf/83hfnkP6zNOgRzFd46iJyfb
         Qm3A==
X-Gm-Message-State: AC+VfDzi5rlgvkQm0ByJGCr7cd/r3pxQIJi3uu0tjhJQmx2NuT4Wr0Df
        AbkU2Gh9/T+CZ4CckjeouXhaEiL/goQ=
X-Google-Smtp-Source: ACHHUZ6fGM+rUrcDUps12Y0j1/r6fLQY/J4zrSODSRDzXCz7XJkWh9AWcU5xjE+k9dTEUOb4EEA+EA==
X-Received: by 2002:a7b:c397:0:b0:3f6:688:f658 with SMTP id s23-20020a7bc397000000b003f60688f658mr1179830wmj.20.1686318669765;
        Fri, 09 Jun 2023 06:51:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm4533962wro.95.2023.06.09.06.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:51:09 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] leds: trigger: netdev: add additional modes
Date:   Fri,  9 Jun 2023 15:51:00 +0200
Message-Id: <20230609135103.14221-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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
- Mode for unified tx and rx traffic.

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

For link speed and duplex we use ethtool APIs. For the unified tx and rx
mode, we simply add extra logic to the work function we already have in
the netdev trigger.

To call ethtool APIs, rtnl lock is needed but this can be skipped on
handling netdev events as the lock is already held.

[1] https://lore.kernel.org/lkml/20230216013230.22978-1-ansuelsmth@gmail.com/
Christian Marangi (3):
  leds: trigger: netdev: add additional specific link speed mode
  leds: trigger: netdev: add additional specific link duplex mode
  leds: trigger: netdev: add additional mode for unified tx/rx traffic

 drivers/leds/trigger/ledtrig-netdev.c | 129 +++++++++++++++++++++++---
 include/linux/leds.h                  |   6 ++
 2 files changed, 124 insertions(+), 11 deletions(-)

-- 
2.40.1

