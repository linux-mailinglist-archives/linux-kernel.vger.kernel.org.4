Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158F686999
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBAPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjBAPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:40 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80966F9A;
        Wed,  1 Feb 2023 07:08:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so52321762ejc.4;
        Wed, 01 Feb 2023 07:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pABkIPEJt6MoyylGFJAHZZENAjuXb4nf+T4EKn1y11s=;
        b=SOK73YQZubMhghohQV90vbAYkAM73kxY1IoUUZCdl8UDURvt3B/zO+zLMJE3iPls5L
         sjWY0rSKLcBqsjiwTOcYUpzSIlLTTz6Vp/Any5npwfmEO75quKMuC6Dm+D4PI+wJZ6Bo
         7Yv/x3z5JiEEEyE+k+MMUY7L6BxdSxf+8kysaBsjKLnEB23lwbkwiOVmrrbPv8BQKQZB
         Lre06gis1VlQZ+3T9osVO1WL+azGvSmULrRxYKRANhR68bjQmh7G1qRGil8FPvm7viF5
         mLtltBHzzLEtCp4kk50lq1TS4aUoDLeo8DB5xIsOCkHTY+uCPoDRnij3EEcmynovwazl
         6+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pABkIPEJt6MoyylGFJAHZZENAjuXb4nf+T4EKn1y11s=;
        b=Ohu14G+3qVZ8imIBm3JKMA0Qyx9+5ZJ4Xz8XO0Uh02icYuYlMEvmEhZNSlr4Qc+45S
         ERZzNfBQm5SEdTJv0cDQQp8JUJTohCG9Gjnonz1j1tcmb23V0hVDye566FHiXy0YszyT
         mXm+9+0Kmh7fbAm2lwkayNSrzXX9csDorpoWtZOiGt5DRChkPjnq/CePN90oLfLSRdSi
         0oNp/FjgaN9c/pI99G6SC2VQs0wDHLWvdHPQyNo1iQ7vwkes7enko0IkaiKCYjAmQjXI
         DXXrakrC1xn6EsoO39cRn/dR9b1ra9bjT0i/yatF2RuAj1SvVPDoy4j7DCFt0mYDqqfK
         3Msg==
X-Gm-Message-State: AO0yUKU89sRFWl7IdB/uwmf2IexS21bFBC/1OXBAR3CaHmhaARjYbzMK
        /cTB9OfIjIlYyC+JNrxeOdvtYyV0P2RITw==
X-Google-Smtp-Source: AK7set9gHfQ6Ygqqxl6kew/lDLI+qp5r7xenPQ/N1Godc+kXUx4j+Eehpr69IakicO4C1CMTEo1SXQ==
X-Received: by 2002:a17:906:d9dd:b0:87b:a8ae:3703 with SMTP id qk29-20020a170906d9dd00b0087ba8ae3703mr2610334ejb.63.1675264097743;
        Wed, 01 Feb 2023 07:08:17 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:17 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: [PATCH 00/13] Rename k[v]free_rcu() single argument to k[v]free_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:06 +0100
Message-Id: <20230201150815.409582-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.

1.
The problem is that, recently we have run into a precedent when
a user intended to give a second argument to kfree_rcu() API but
forgot to do it in a code so a call became as a single argument
of kfree_rcu() API.

2.
Such mistyping can lead to hidden bags where sleeping is forbidden.

3.
_mightsleep() prefix gives much more information for which contexts
it can be used for.

Uladzislau Rezki (Sony) (13):
  rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()
  drbd: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
  misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
  tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
  lib/test_vmalloc.c: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
  net/sysctl: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
  RDMA/rxe: Rename kfree_rcu() to kfree_rcu_mightsleep()
  net/mlx5: Rename kfree_rcu() to kfree_rcu_mightsleep()
  ext4/super: Rename kfree_rcu() to kfree_rcu_mightsleep()
  ipvs: Rename kfree_rcu() to kfree_rcu_mightsleep()
  rcuscale: Rename kfree_rcu() to kfree_rcu_mightsleep()
  doc: Update whatisRCU.rst
  rcu/kvfree: Eliminate k[v]free_rcu() single argument macro

 Documentation/RCU/whatisRCU.rst               |  6 ++--
 drivers/block/drbd/drbd_nl.c                  |  6 ++--
 drivers/block/drbd/drbd_receiver.c            |  4 +--
 drivers/block/drbd/drbd_state.c               |  2 +-
 drivers/infiniband/sw/rxe/rxe_pool.c          |  2 +-
 drivers/misc/vmw_vmci/vmci_context.c          |  2 +-
 drivers/misc/vmw_vmci/vmci_event.c            |  2 +-
 .../mellanox/mlx5/core/en/tc/int_port.c       |  2 +-
 .../mellanox/mlx5/core/en_accel/macsec.c      |  4 +--
 fs/ext4/super.c                               |  2 +-
 include/linux/rcupdate.h                      | 28 ++++++-------------
 kernel/rcu/rcuscale.c                         |  2 +-
 kernel/trace/trace_osnoise.c                  |  2 +-
 kernel/trace/trace_probe.c                    |  2 +-
 lib/test_vmalloc.c                            |  2 +-
 net/core/sysctl_net_core.c                    |  4 +--
 net/netfilter/ipvs/ip_vs_est.c                |  2 +-
 17 files changed, 32 insertions(+), 42 deletions(-)

-- 
2.30.2

