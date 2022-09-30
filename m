Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943115F163C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiI3Wlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiI3Wld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:41:33 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302218CB24
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:41:31 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id z14so2259018uam.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jbAj/8ntnql4/6wieRn1/eeqqXdYMf6K5KRrp5mOlrA=;
        b=Si3E4T5Uc2V1Hpf4WBK2jrNRCzBgPtmwL1MXLCN/e/fjDe7DTzTi4QBlRjCA3Gk/NW
         f+u0ZiSiSUH4jumQir68p8l7MIg7CRmlExkJ6yAhqMGrMpKMo5wADmC3K+A8YyGnKO2I
         X3nUEsQu1zYrRSoDBwHTrBmVb4vQ24scoR+rNk1WjYxyxHDWxsQtrTwJE1E9+5U2zH6w
         MOTxzzc0Db9DX2osY2LvLAl/4QCwTVmPNnQn2YPLyOsLXvjju/3cKiOL00s4vNtOuNSy
         vU8nlyqfCUNHjKtYYvdOAMqBKZfV/ZtIQygBA3Hb7gaeRMxHA62iwadOdGIeUQHEA2DO
         5OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jbAj/8ntnql4/6wieRn1/eeqqXdYMf6K5KRrp5mOlrA=;
        b=RCSKghA66EWKIrU2cQQ++GLYdUAlwPxsQjz6BlmvurYf+dPeHnkK9a+Q06bu2FO/6j
         MVrX8lJOlTwJ+5fN/PEv+tjDjhNOdS8evU/GIocoZx7mqPe/E5zwac8WSU0C+ccMPX5N
         4txCzitFp74E18iZMIUYsjn1Bhwu3NQ0WhsmpLZ+bPZLUovFmZYkmRsB1h4910pJf3Q0
         ivshJ2K6KG67yedgfu1bGgU41jrDe5g1kZ3UCwxrmGSu4o6bxaFDUmz8d4vTmGikV9Pr
         4p4Tkj/X8+wUNa6e6l/H6F9hsplJfRhQv19g9vJSopAlro/ISsgToGiFnoBqxIF3mX4Z
         b9dw==
X-Gm-Message-State: ACrzQf0GlyH5vC88hNvNVnXJ7Tai0HkJJCS55Rwhya2bWIggN1W2NngX
        sqGU9d+iHYqYQa/paimu0GCdvIYKdVU=
X-Google-Smtp-Source: AMsMyM6hvisu6/k1naGoQ3QaaAdKYDfMhmCHMK1gt3Ushs7BrZZdi2nInoqcgJP5UNyTCX0Muzzpfw==
X-Received: by 2002:ab0:6f52:0:b0:3d5:59aa:571c with SMTP id r18-20020ab06f52000000b003d559aa571cmr4657033uat.17.1664577690988;
        Fri, 30 Sep 2022 15:41:30 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:d13c:46d7:2f3e:5663:520a])
        by smtp.gmail.com with ESMTPSA id t12-20020ab0688c000000b0039f94d9d39fsm2445973uar.6.2022.09.30.15.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:41:30 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        "Hans J. Koch" <hjk@hansjkoch.de>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] uio: uio_dmem_genirq: Fix locking issues in irq config and handling
Date:   Fri, 30 Sep 2022 19:40:56 -0300
Message-Id: <20220930224100.816175-1-rafaelmendsr@gmail.com>
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

The goal of this series is to apply the changes from [1] to the
"uio_dmem_genirq" driver. The implementation of "uio_dmem_genirq" was
based on "uio_pdrv_genirq" and it is used in a similar manner to the
"uio_pdrv_genirq" driver with respect to interrupt configuration and
handling. At the time "uio_dmem_genirq" was introduced, both had the
same implementation of the 'uio_info' handlers irqcontrol() and
handler(). Later, [1] was only applied to "uio_pdrv_genirq", even though
both had the same issues addressed by the patch, which ended up making
them a little different.

The original motivation for this series was to fix a bug introduced by
commit [2], which can be solved by copying the implementation of the
interrupt configuration and handling from "uio_pdrv_genirq" to
"uio_dmem_genirq", thus, making their implementation similar again.

Since patch [1] solves the bug introduced in [2] and also addresses
other issues, I broke it into 3 separate changes.

[1] 34cb27528398 ("UIO: Fix concurrency issue")
https://lore.kernel.org/lkml/201306201636.00535.vitas@nppfactor.kiev.ua/
[2]  b74351287d4b ("uio: fix a sleep-in-atomic-context bug in
uio_dmem_genirq_irqcontrol()")
https://lore.kernel.org/all/20191218094405.6009-1-baijiaju1990@gmail.com/

Rafael Mendonca (3):
  uio: uio_dmem_genirq: Fix missing unlock in irq configuration
  uio: uio_dmem_genirq: Fix deadlock between irq config and handling
  uio: uio_dmem_genirq: Use non-atomic bit operations in irq config and handling

 drivers/uio/uio_dmem_genirq.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.34.1

