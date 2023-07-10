Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFED274D744
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGJNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGJNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:19:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93960E2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:19:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7836164a08aso230149839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688995155; x=1691587155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xH3ktNM7F7ZJDvorWduQlndd7zU/N+WvOi1vVNgDJPc=;
        b=S6GR5b/fh22V6DUc+eaJm9KLbB9KJMjM+u8GweiC1T3ZW0QB6YtSeT+FPF7ZSm9LCe
         m5yUVrQ4bhDBxq4V8g5VbmldqewYrPZpOqAfaA8eaRCStf2f+gTkak3LtHoTao7XGQKf
         3N5IZZiZoCgr+ZtIMgA8UBwY8SJ2n1E5atMB/0sMFjU/f10sxS2y/MMmrp2T/xllmUPO
         geHIHSkholSDE3H7nWiLQsjS2+l9cjMN8KkbX1/v0JCmSsE+KcB7egGNDsCrJscfPk4o
         bOUyQvJqXv++Q9DcPt+a3ZhKNPcUgUc+ygZbMz5qx33IcHG+lh44JOLBGcpACT7/cWtc
         b4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995155; x=1691587155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xH3ktNM7F7ZJDvorWduQlndd7zU/N+WvOi1vVNgDJPc=;
        b=MkJeN1/F0QhRDgM4zVecPsmvSNNc/eFUVQ4W5/Mcnew/RIpwUE9Ii4PRZ83qlQI8Ar
         8vJU11dvbwrguhtWSYjxYbTTKkK145wyDCeWBQKqwpHAJ/JYGCbdy2K8KD126jG7Haf8
         pGFMqkRl5k3EVNTPxxwmCclRPoO52QFyFZAwCxbQvbuRTeZts+gm/X0zDvkRkdTjFpaN
         alWtY/9NBo2YWuXARggXwfc8VX+fL4l22Yil2kGuIBHTSQtlyxqnT5fWNMCul5tlcKE2
         P/IMrbro6DZNx95+K+azqEdGK/CgMklqaZBDyN7wOdAABVPmIOvclpy+9ROeBB4JgJ0j
         WDQA==
X-Gm-Message-State: ABy/qLb3qjjSxfRo4IncYX8LdBx3UGHQaq0l+ZN/KCXNkchjynfnd3M6
        Acq8vhmtIQj4Nwemqeuv8V9RaA==
X-Google-Smtp-Source: APBJJlFzb6oEXourW8KpAWTa+6yNySEnTYuIn7caQrPawjxY38DirN6YNvXeeEQRwP2GfqotSORIfg==
X-Received: by 2002:a6b:601a:0:b0:783:572c:9caa with SMTP id r26-20020a6b601a000000b00783572c9caamr11941055iog.0.1688995154884;
        Mon, 10 Jul 2023 06:19:14 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id q14-20020a5d9f0e000000b0077a1b6f73b9sm3643242iot.41.2023.07.10.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:19:14 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/2] Misc RISC-V timer driver improvements
Date:   Mon, 10 Jul 2023 18:49:00 +0530
Message-Id: <20230710131902.1459180-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does two improvements to the RISC-V timer driver:
1) Keep timer interrupt enable state in-sync with interrupt subsystem
2) Increase rating of clock event device when Sstc is available

These patches can also be found in the riscv_timer_imp_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (2):
  clocksource: timer-riscv: Don't enable/disable timer interrupt
  clocksource: timer-riscv: Increase rating of clock_event_device for
    Sstc

 drivers/clocksource/timer-riscv.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.34.1

