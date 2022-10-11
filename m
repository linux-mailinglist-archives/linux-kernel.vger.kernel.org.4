Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04A55FB6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiJKPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiJKPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:20:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC3103256;
        Tue, 11 Oct 2022 08:11:57 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q18so4523518ils.12;
        Tue, 11 Oct 2022 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPE6YdNFJsCUZV13UErdIMhOkN77t2xv9mCekbIvVC4=;
        b=KMbLMUFn2VG2LYiJ9W+PH/gy7unQGvh0Sk2YyWuHznrOzChG0yaQ9ttfckmaSQSsw6
         ESisG+fDNFzIrQL9GcFN94565ygmXQWMZvr5oOaOJfQjJtV3Ve/hgFT41XY8vXdHyD0Q
         lnF5TatTcRdAExFlGHvy10ELWeJV6HYQ2uT5RQgg7w+mUgwNhMSuiI7UkOq7HL8blqI9
         U3c+Bhcx45li1nGx1zT4KgVbZEEY0YeiHbmbVfbCTarBAuNCg7iX2+cOfiwvj1sERKzI
         WTL6zvcrzfY3CJ2DCasLRpReWcqG7o3FKda0u6fibVWSQAF4trBqSayRgN1dUuDJ6bre
         nuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPE6YdNFJsCUZV13UErdIMhOkN77t2xv9mCekbIvVC4=;
        b=zQLIwdG7egDeKGcEse7ylJgaRDa8lusCusiJjWlxc9190pikcXQaOI3Edru47Hi6/z
         N88CySm/st6YtzHUdsGP6e0DuZdmtYWLLhxb7yyCmmmGi5afuqCDbRr6ykwOT4gMFomO
         WqMl0/+hmV9I6srPh3gycJ3KW7WDPIaabb8KUt2HNP7DnPt1O5mXr+v9n1A7kRO3AJsB
         bsw6l1ecZD4+/GaknmLJ1e2/LC4aalnqcxH2yrZvn0N8HR8Xa4MdkqsGEhyuV6dQkj0f
         CfY1y2StBBzsLfuwoFwT2Abb7Renx1fpU4lfsFQGcD8hHyhulgu0P/nU2eUX+aRd+OwV
         CIrA==
X-Gm-Message-State: ACrzQf0q23GO/2+IqAs5Ru6LrSRPEvTnfSVB8p37QDEqqS+CAcTTT3iQ
        MlnYn4MXXczMZAIBTjfeZkNDc7Z7cg==
X-Google-Smtp-Source: AMsMyM4EE7sMIFNWaZrnrcHXc6jDmk7iKy/pADzdJbni79SBqoGzipTTmyPoVFvvSVWAR1svCbQ4XQ==
X-Received: by 2002:a63:fd09:0:b0:464:4ec8:89b3 with SMTP id d9-20020a63fd09000000b004644ec889b3mr3689583pgh.175.1665500498032;
        Tue, 11 Oct 2022 08:01:38 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id b5-20020a1709027e0500b001754064ac31sm8746695plm.280.2022.10.11.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:01:37 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH v3 0/2] Add support control UP board CPLD onboard LEDS
Date:   Tue, 11 Oct 2022 23:00:58 +0800
Message-Id: <20221011150100.10195-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <http://www.upboard.com> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.
PATCH v3 fixed the auto build test ERROR on ARCH=arm64 or ARCH=mips.

chengwei (2):
  mfd: Add support for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig             |  11 +
 drivers/leds/Makefile            |   1 +
 drivers/leds/leds-upboard.c      |  78 +++++
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 482 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  49 ++++
 7 files changed, 634 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

