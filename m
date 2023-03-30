Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852A36D02F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjC3LVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3LVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:21:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D04C0;
        Thu, 30 Mar 2023 04:21:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c4so903915pjs.4;
        Thu, 30 Mar 2023 04:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxrtZ4Pc2V4sbXHyqD0vLqMXC2ShCz7l2J+XPW6TD5o=;
        b=IpzESQup1HFCCHLA+X1sRFTro3aw2vth88AadIGDT74X5cONhM1w8ca0NFEWuSM5aY
         aT9X1UgNoogYHnVbTsWVCHfyqTmP8LRTn0dzWPddzfcm8+As2w3MICdV/ghaky7gPn3u
         kyPCLknhqYPPhbDqj15OO0QyBhpPDlh9FtTAdbBLE2FX4z9zVaJ6cvaHeyF4X0BnsMIs
         vi+PRvTqP2u5rrIrlVDsrN3Qfs0+YaXaIB/Ob47QN2XqSh0J2KFsuEGz1KVh5BJCBmWU
         alAKEV/hV5jogqtiEBghg5FaaDbStQWSZrSlpcT6KGy8FQy+dcRieJs6sbtmkYy+2QAR
         gSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxrtZ4Pc2V4sbXHyqD0vLqMXC2ShCz7l2J+XPW6TD5o=;
        b=iAy9CUgtoc708nTSmruTkW1zk4E4zKrxhsWnw0K/TVp02CBKHbF+XqfDvLy5e28jRE
         Mb8u5c9oTrvgIFHfAb+/4Ni2KJa1QX9bppzkLNtdWKrlPl5rvCRJfvCbz9EXR9AhphHn
         7AnMpKDU4ae6KCPGByPM8y7Oc0lNtQiXzbhGMZoU0kx+gCD5RUf1aQtMPVRnE5x2EAHh
         UNt2RsNBVabUyoYhYNuzynm9Z0304qIwJ6EufhUzykimLjXTINc9wTu5hktK7vPx6KK4
         D/qNaAX/LYeQt0iEtIuj5BMzb3znoEKB2ztAochDqRn3XowwNt6ibhszX5C3mevGzh81
         QxNw==
X-Gm-Message-State: AAQBX9fpiE1fj3OetZbOdazc9V7XPABmEEbb6HwVgmH07vbzh1rzt0GJ
        GO4eCQRmJRotS4a91eB9AEFP2naPHruEFA==
X-Google-Smtp-Source: AKy350ZrYUoB2maY762H8wlc5kGOT+A6+d64+RuGw1ljSL10h4noHWzoWix+QAXRP9DFyJe6KlvRjQ==
X-Received: by 2002:a17:90a:d583:b0:237:3f83:61f3 with SMTP id v3-20020a17090ad58300b002373f8361f3mr24046534pju.16.1680175260508;
        Thu, 30 Mar 2023 04:21:00 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902ee8d00b0019f11a68c42sm24444851pld.297.2023.03.30.04.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:21:00 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 0/2] Move Loongson1 restart handler to watchdog driver
Date:   Thu, 30 Mar 2023 19:20:49 +0800
Message-Id: <20230330112051.551648-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Loongson1 restart handler to watchdog driver
and update the Makefile accordingly.

Changelog
V1 -> V2: Remove the reference to regs-wdt.h

Keguang Zhang (2):
  MIPS: Loongson32: Remove reset.c
  watchdog: loongson1_wdt: Implement restart handler

 .../include/asm/mach-loongson32/loongson1.h   |  1 -
 .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
 arch/mips/loongson32/common/Makefile          |  2 +-
 arch/mips/loongson32/common/reset.c           | 51 -------------------
 drivers/watchdog/loongson1_wdt.c              | 19 ++++++-
 5 files changed, 19 insertions(+), 69 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
 delete mode 100644 arch/mips/loongson32/common/reset.c


base-commit: cf3be7e82b129ed34f811f116f2b113f6299d449
-- 
2.34.1

