Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC985607CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJUQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJUQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:50:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F158D2475E3;
        Fri, 21 Oct 2022 09:50:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b12so8111915edd.6;
        Fri, 21 Oct 2022 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw+R9Xikusyj0v7XUpo66UBCqQebEKZZe8nkfd2rnP4=;
        b=Ao635rcc4v6ANTEZfVUNii8aItSWgNLiZ9owf76yP2my6qCugJssh6e7ebj16THCMl
         hpI+m5iIrKSzZFU1SvaisJzzIFwXKDV4/gHM3z+hvda+b4vSYpADy+RB9LsjSagoP3Fc
         tsoC0zw9QpwPSiDoOF6IutJywJVIXQ082uZ4zqMGRElTzV3LW90wS04bdsh2+14iwdrS
         /FaVxbeRU5ohz/wJdyR3g1doSpqqnJHX+DLkedaa6SRCJst2sGTih9SwZdikK1UKQQSg
         qw8PHfkP8jK6oAxIbQe4KHsGAwjf3ZHD/+zU/QMKfuTIzLjYhi6ixaopvDZrPf9SADug
         xfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cw+R9Xikusyj0v7XUpo66UBCqQebEKZZe8nkfd2rnP4=;
        b=5aIxMiKjGFxJ5DPJOf+8EMuvCloof5nwvsMpCBx5kqww2QfeaFlw/AMjdycXJXi0hI
         rpIslZX+FvPGeiYHUO9Lq5t9NwuMxSMZB5/sHvjP1L3/fiEId+BPyVioFnl/EKe95UzX
         XYhX5IbiXZaHtX8nOJRE+hDoZZ8N66VQ0atWDznhXcr1N4rB1xnSu+xIh4VU3szWBYJ6
         yYRIA75/HRbsX2sAd1xK7Vob+8zhTBWA9dYbfMA/XC/dTfjMA3Q2KjqBAo6UE+8awIa9
         CB9qSXoJ+xdvl3KZ+3JbT8z+NjHKeD0N5c0fpcNjENUgo3Ow/F5qrNDlm7A2ed4uL5/h
         W49w==
X-Gm-Message-State: ACrzQf2WkMlP1ekIITEZf3NUkTNLZuHs8uvhI2y9GVX5ajQM7j4ypeLb
        ojeqfer2lUZzNNhjG5kyfn8=
X-Google-Smtp-Source: AMsMyM7zHDeLAO0XEuFmG4m/5KkaJuZHKCPLb5Pi2pHUCn9rPjFqWOK3wln6GDKxiGj8UdCBfeoHaw==
X-Received: by 2002:a17:907:2719:b0:782:b261:e9eb with SMTP id w25-20020a170907271900b00782b261e9ebmr17186574ejk.104.1666371013803;
        Fri, 21 Oct 2022 09:50:13 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b0b-4500-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b0b:4500::e63])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7d957000000b0044ef2ac2650sm13725331eds.90.2022.10.21.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:50:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/2] hwmon: (jc42) regmap conversion and resume fix
Date:   Fri, 21 Oct 2022 18:49:58 +0200
Message-Id: <20221021165000.1865615-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a follow-up to the comments I got from Guenter on v1 of my patch
from [0] titled:
  "hwmon: (jc42) Restore the min/max/critical temperatures on resume"
There Guenter suggested: "The best solution would probably be to convert
the driver to use regmap and let regmap handle the caching". That's the
goal of this series - in addition to fixing the original resume issue
(see patch #3 - which was the reason for v1 of this series).

Guenter suggested:
> Make sure that the alarm bits are not dropped after reading the
> temperature (running the 'sensors' command with alarms active should
> do)
I configured the limits to be below the case temperature on my system
(as the jc42 sensor - a ST Microelectronics STTS2004 - is part of the
DIMMs) and ran sensors three times in a row. The output is the same for
all runs:
  temp1:       +35.0°C  (low  =  +0.0°C)            ALARM (HIGH, CRIT)
                        (high = +25.0°C, hyst = +25.0°C)
                        (crit = +30.0°C, hyst = +30.0°C)
My conclusion is that the alarm bit is not dropped after reading the
temperature.


Changes sinc v2 at [1]:
- squashed patches #1, #2 and #4 into the new patch #1 (without any
  other changes to content in jc42.c)
- patch #3 has no changes other than it's numbering (see previous
  change)
- dropped RFC prefix

Changes since v1 at [0]:
- marked as RFC
- added patches for regmap (patch #1) and regcache (patch #2) conversion
- patch #3 has been updated to use regcache for restoring the register
  values during system resume (this was originally patch 1/1)
- added another patch to remove caching of the temperature register


[0] https://lore.kernel.org/linux-hwmon/20221019214108.220319-1-martin.blumenstingl@googlemail.com/
[1] https://lore.kernel.org/linux-hwmon/20221020210320.1624617-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  hwmon: (jc42) Convert register access and caching to regmap/regcache
  hwmon: (jc42) Restore the min/max/critical temperatures on resume

 drivers/hwmon/Kconfig |   1 +
 drivers/hwmon/jc42.c  | 224 +++++++++++++++++++++++-------------------
 2 files changed, 125 insertions(+), 100 deletions(-)

-- 
2.38.1

