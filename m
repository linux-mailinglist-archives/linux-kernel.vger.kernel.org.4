Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE127380B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjFUJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjFUJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9875B19B3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:23:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31121494630so6561104f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339436; x=1689931436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhbmVt/bR7PxLH5MDA0JQvpls/C44+Igd7TpWMy2Ddg=;
        b=E9519/hup4CMAG38i+j/WCtV5DI1Kh5Z2SC19XjwuKZvTXNn0+2iqh7XEWTEQrhH1c
         VUkySYLxCcuzudOK5wkZnpBjwTN2NtQ1P/XGst7w3gw777jYCTu4ct31uEQfkm4h6cbx
         r4Q3NKdB7EyXoWfzLfrJJTglVgmxbwgmWYC+JgZhExD1DIBU0l7QDfYubFjjT+mEadJ7
         cD9YHjU81kcR04Oy2M/NrR3plx/1i22ssTKsiUCzWEN6yXEOow5RdtKWN9y0/yO1STEB
         4qHtjQiieQ0gBfcm+73qQOmkRtiv/uLLw1qfofJxkVBg6VpJX9WHuccF6GN2UArE0/Mu
         6bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339436; x=1689931436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhbmVt/bR7PxLH5MDA0JQvpls/C44+Igd7TpWMy2Ddg=;
        b=fzaUpliEEjFGGLPkE4ALqPX0G2wWcuip0OAgy7+fwSY25WyymIKv/2usays3FU9H5y
         yk4GlfQB4dri4pxus7tIjFQpBocyaVrbJAphBvUJ2Go4ec4ocjduC6xVMYBmogtfEeKN
         3nKcNUTcuH128nVPee/U+Da0Tk68ovWULO/Vu9vlJWP/26tf9DwWuTGy0uy3DurMw1hb
         +B90ESHLfY7wJ3l7vHW5VyZOUcXNgIFEVZVf5b76fMdvmwsn94s4NaRNo0bZVQQ+5LWp
         5Qgl7DAykI9Ax6YydAvIA+2kPkKSZq9sQy3Obgw+3Td9OfilQnV0R1XqGMtAPLTxE77K
         4Dmw==
X-Gm-Message-State: AC+VfDwu7BJ2A1FbdR6FdmBz/3p3v//3NbWK2qBoyyQT0m5mVSVxCgLi
        24eIXHg1JbVFFLzXvPTA3gO7Aw==
X-Google-Smtp-Source: ACHHUZ64i4VroYQxlvRXhJe9FYH5d+yXc5wuFWWIfL3KpYkieBJG4/VRQB6oiFSVmTJi7H0hCivanw==
X-Received: by 2002:a5d:6643:0:b0:311:1711:d897 with SMTP id f3-20020a5d6643000000b003111711d897mr13892428wrw.17.1687339435867;
        Wed, 21 Jun 2023 02:23:55 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:55 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 00/12] can: m_can: Optimizations for m_can/tcan part 2
Date:   Wed, 21 Jun 2023 11:23:38 +0200
Message-Id: <20230621092350.3130866-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Simon and everyone,

thanks again for taking the time for review.

This version has the fixes for the issues you pointed out in v3.
It is tested on tcan455x but I don't have hardware with mcan on the SoC
myself so any testing is appreciated.

The series implements many small and bigger throughput improvements and
adds rx/tx coalescing at the end.

Based on v6.4-rc1. Also available at
https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.4?ref_type=heads

Best,
Markus

Changes in v4:
- Create and use struct m_can_fifo_element in m_can_tx_handler
- Fix memcpy_and_pad to copy the full buffer
- Fixed a few checkpatch warnings
- Change putidx to be unsigned
- Print hard_xmit error only once when TX FIFO is full

Changes in v3:
- Remove parenthesis in error messages
- Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
  header and data in one transaction'.
- Replace spin_lock with spin_lock_irqsave. I got a report of a
  interrupt that was calling start_xmit just after the netqueue was
  woken up before the locked region was exited. spin_lock_irqsave should
  fix this. I attached the full stack at the end of the mail if someone
  wants to know.
- Rebased to v6.3-rc1.
- Removed tcan4x5x patches from this series.

Changes in v2:
- Rebased on v6.2-rc5
- Fixed missing/broken accounting for non peripheral m_can devices.

previous versions:
v1 - https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
v2 - https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
v3 - https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/

Markus Schneider-Pargmann (12):
  can: m_can: Write transmit header and data in one transaction
  can: m_can: Implement receive coalescing
  can: m_can: Implement transmit coalescing
  can: m_can: Add rx coalescing ethtool support
  can: m_can: Add tx coalescing ethtool support
  can: m_can: Use u32 for putidx
  can: m_can: Cache tx putidx
  can: m_can: Use the workqueue as queue
  can: m_can: Introduce a tx_fifo_in_flight counter
  can: m_can: Use tx_fifo_in_flight for netif_queue control
  can: m_can: Implement BQL
  can: m_can: Implement transmit submission coalescing

 drivers/net/can/m_can/m_can.c | 516 +++++++++++++++++++++++++---------
 drivers/net/can/m_can/m_can.h |  35 ++-
 2 files changed, 418 insertions(+), 133 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1

