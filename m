Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C246A3FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjB0K6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjB0K6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BA93FE;
        Mon, 27 Feb 2023 02:58:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r7so5729615wrz.6;
        Mon, 27 Feb 2023 02:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXZ5C7P9D/0s9CDFL6gpMuOWFVtyKmkspdci0k4HMiI=;
        b=IQZi6OJV1GYXqnOActUwI/xKfypALKlUY8g7CA2Zs2DocpaieW3D+tk0XZSlm8qpGN
         m/YNDLhI+YRJIgOH6J1a2Rw8bHsMx0rbA9gqViZQY5mFuHZIatlkD53/R/cLmLUi+rKQ
         NpG/GR2ciwXHyZy8qpI0iX+r6JGP6yhPCwjJYqEdroeZu3CcRC35xXEI5gdZJ5L8+0EQ
         aasc2VSKW2qyLt7hDJtuYYMcU5PvaSO54sc1SDZMKOmFrHHgMs3JjXJ3fCvzAngQ5Tbh
         dVpYe04MheYyJvqNWCrhq3fSmKBoU4sjetEp/PUEFg/nit53jdhn/lKWQYrnbRdneJtA
         Vicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXZ5C7P9D/0s9CDFL6gpMuOWFVtyKmkspdci0k4HMiI=;
        b=5nlNKNSi+m7YC+AFIR2zqWDZv3TmQG5llRuCIEAUasoZc4YxQBHwVG2CVc2GfAqXu3
         vyzRfn+zcPVXeTe50wkaczTr+vURDpjTsiulDig+AWLnpStr7f00JvzMLSVYQVEjkHyu
         wmPpxJr3WpzfkymLIlMtQpO2PrDif93kTke14vp2VU2ao4fTJUDpV2nuPNI8BarhG3z3
         Aq9/T8xt/MzisJFpXlBUULEi8HvvdnLrJhOP1bNEK0b7C1PLNOq6P2XStY+9TqmqPfit
         Pp/1RLIIbYs6j+TWSOtQFvtizQuSS2jNQ6vpm8kgpjzEqqWh5oK3SJJoaIVSrJqeLYqZ
         wa5g==
X-Gm-Message-State: AO0yUKUBLL3v7PwZPTFUR8wf6n8kXh8niLzLxXue9HxTkhV6bsXUfQJY
        I3/1ln2ALWEYs6ykXLfORJ3YtMUcQck=
X-Google-Smtp-Source: AK7set/yg0coYPUua9emIAvNbNrL1XODizmXr1pCt+xD4exeZZTsG8oQ359Tl4RTZPtwfVC2rRfpdQ==
X-Received: by 2002:a5d:42c3:0:b0:2c7:3c96:18d7 with SMTP id t3-20020a5d42c3000000b002c73c9618d7mr9842046wrr.20.1677495488059;
        Mon, 27 Feb 2023 02:58:08 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:07 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 00/12] mips: ralink: introduce 'soc_device' initialization
Date:   Mon, 27 Feb 2023 11:57:54 +0100
Message-Id: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This series align old SoCs ralink code with current mt7621 code refactoring
SoC related information into more readable functions as well as introducing
'soc_device' for all of them. This allows to be able to distinc SoC info
from driver code without using architecture dependent includes. 

I am also planning to extract from ralink code current clock related stuff 
into proper clk drivers at some time and be able to distinc SoC in this way
let me to mark future drivers to be easily marked for COMPILE_TEST target.

Changes have been compile tested for:
- RT2880
- RT3883
- MT7620

Changes have been properly tested in RT5350 SoC based board (ALL5003 board)
resulting in a working platform.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

Sergio Paracuellos (12):
  mips: ralink: rt305x: define RT305X_SYSC_BASE with __iomem
  mips: ralink: rt305x: soc queries and tests as functions
  mips: ralink: rt305x: introduce 'soc_device' initialization
  mips: ralink: rt3883: define RT3883_SYSC_BASE with __iomem
  mips: ralink: rt3883: soc queries and tests as functions
  mips: ralink: rt3883: introduce 'soc_device' initialization
  mips: ralink: rt288x: define RT2880_SYSC_BASE with __iomem
  mips: ralink: rt288x: soc queries and tests as functions
  mips: ralink: rt288x: introduce 'soc_device' initialization
  mips: ralink: mt7620: define MT7620_SYSC_BASE with __iomem
  mips: ralink: mt7620: soc queries and tests as functions
  mips: ralink: mt7620: introduce 'soc_device' initialization

 arch/mips/include/asm/mach-ralink/mt7620.h |   3 +-
 arch/mips/include/asm/mach-ralink/rt288x.h |   3 +-
 arch/mips/include/asm/mach-ralink/rt305x.h |   3 +-
 arch/mips/include/asm/mach-ralink/rt3883.h |   4 +-
 arch/mips/ralink/Kconfig                   |   4 +
 arch/mips/ralink/mt7620.c                  | 145 ++++++++++++++++----
 arch/mips/ralink/rt288x.c                  |  94 ++++++++++---
 arch/mips/ralink/rt305x.c                  | 147 +++++++++++++++++----
 arch/mips/ralink/rt3883.c                  |  94 ++++++++++---
 9 files changed, 410 insertions(+), 87 deletions(-)

-- 
2.25.1

