Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9086D0103
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjC3KU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjC3KUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:20:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE17DA4;
        Thu, 30 Mar 2023 03:20:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l7so16779092pjg.5;
        Thu, 30 Mar 2023 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680171622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzeT2+6D1T6rgkfSZiDiZzDR0t3EEp4P5XvtUA+hmiE=;
        b=QDc6FfC5YwebP52JHx9BRtO24zMjNrTcVaqvW3qYO0SK2XCPwC3R4MaJ/6mbHv7H+V
         QMwJj6qsT4X/ZQpabtG9rdOcKjb5gkbv6eWgiVQehFcLn6kK0Z99QsP2KeZuYcjTMZvf
         PvyedTM84rXk6wV1Y/PG9FWbo0xV9k/nN65DOMQLba/VvvfahavtxDpKAYzNWblD67lK
         1HNubC5LvN2SBOCXEKkSAdZUdAItyt77PE9wV0nVfDmJXN5Il2rzInWp0dA53+SK2fap
         Ijiblj9GPyPiNXDBuD8YE/w/ApcJe+79WEZyNNY03xUOv1JBaLF6GadSK/wP57x/7vJ1
         aYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzeT2+6D1T6rgkfSZiDiZzDR0t3EEp4P5XvtUA+hmiE=;
        b=SMcX21ItwhrdKjrpSueOrycMDjKbSa/W8Ks3E8AtmqC1hyJxItcKz9jLidPg626eOT
         3zcXf4ttVKFBW1Fv5jNnu0bqgzoo53ZowucReJt6bhAd0Y7h5XT/nBZMXSNsSWc6aV2b
         6yEeGQt8DqbC3iSnnJ8GIvMRRIHT1vzjJVl4UE9KEJPq7U95HnYNAv5cqHYwuWmrtOa1
         SZtBQpPTUAkFyqe8cjD8IVD3A7bTC110aJk33J01A+/UfH7mpBOHflBpeppsn3yvE45E
         GgDoOnFMUZxR0XCjbOM4cOI1vy9SANifxJ4vdUUrw8tcxZmle4SsNc6PjffKdhSu8Foh
         2h8w==
X-Gm-Message-State: AAQBX9dMfy/0PpAAKC7kovv4rte1Z5wB/7MTOaSPQoXqxAae8qGcmhiQ
        Ay/ndqZ+vW5oX+j7nSG4Vmk9BXclm0QIOw==
X-Google-Smtp-Source: AKy350Yv0cypxbGBwqh/pPR6IiX2tEXNMFYDqR/TkZwwIx3MHOEpGPNCR7xKWeQ8rnOKSbxfbf0a7w==
X-Received: by 2002:a17:90a:190f:b0:233:c301:32b3 with SMTP id 15-20020a17090a190f00b00233c30132b3mr24582386pjg.3.1680171622637;
        Thu, 30 Mar 2023 03:20:22 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090abb8800b002376d85844dsm2860416pjr.51.2023.03.30.03.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:20:22 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 0/2] Move Loongson1 restart handler to watchdog driver
Date:   Thu, 30 Mar 2023 18:20:11 +0800
Message-Id: <20230330102013.545588-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Loongson1 restart handler to watchdog driver
and update the Makefile accordingly.

Keguang Zhang (2):
  MIPS: Loongson32: Remove reset.c
  watchdog: loongson1_wdt: Implement restart handler

 .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
 arch/mips/loongson32/common/Makefile          |  2 +-
 arch/mips/loongson32/common/reset.c           | 51 -------------------
 drivers/watchdog/loongson1_wdt.c              | 19 ++++++-
 4 files changed, 19 insertions(+), 68 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
 delete mode 100644 arch/mips/loongson32/common/reset.c


base-commit: cf3be7e82b129ed34f811f116f2b113f6299d449
-- 
2.34.1

