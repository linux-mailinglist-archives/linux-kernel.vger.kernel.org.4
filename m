Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AD6CA7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjC0OiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjC0OiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:38:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B3CA1;
        Mon, 27 Mar 2023 07:38:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so9069786pjz.1;
        Mon, 27 Mar 2023 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679927881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iB5VRGwqZoq2fF9ROxypLFZocQBlm0YBSqR98fBn96s=;
        b=BSndx8qIUBxBgf4/iQK3FJju6oQiaTbpSI+60AsUhWI9pyqDu6EaX6fOr0CNc7Sd0/
         6rRFip34R5hds8iokkmpN5+apLOMALQ8ZAW/GKrfj42OkiRcvIYdGcds2b7qEvoLsivA
         x6DPFSBT1R8dcGVuxmB8yoi6zwxoLnO2tfNd2e7g33/0ENn9VEoO5s5rl11SLVtumt50
         +PDHytN2qExWTdViLA0JCaJEFL1qFnJBoZ0sfrYgtGudQM/vUN/Pi5CKctxEVbJXioe3
         iWtnr5guv7jIJLBXU3PshnGR40n0tTW4Y8BnHtZlB5h4C1TGeQs0DO9OpqrKjeh21gm/
         4nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iB5VRGwqZoq2fF9ROxypLFZocQBlm0YBSqR98fBn96s=;
        b=cpK7tcAzAUxNzBda3hpXU2FVpMwiAOXbr6GDNJCDe5B2kQ0MEgvNDr7oGgTYdb8Bpt
         /FSHLwsemWyDwg2HMH7WsRaAkKucLMUjZiOem1UAS6CAqEyWT8NvrPT1aIYK5KHogWs3
         ybeqvneN5DwBtQN7BYV2F8++TrWCNjCC27R4deMN+7/ZmBTVs/3EF2l+fE4G8GmWCubd
         KXu6K9d6GRkvvwE8RIbrTfPcKElfP+5yTMlRaiT4DzCnKMxruBSxVjJcdTWziRaX7msY
         0/6agThM52gSM+WWIxP92osVjLFms58vqPQru1opqo04pXVEQpTwZZ8gg0pr7m7RfwaK
         mmrQ==
X-Gm-Message-State: AO0yUKX325I3rPAU3pfj+f0PF9313kTtxulGOsx0BMvFlf18gByIZZdz
        CJf9EWkJ4dkYlL3v406vg7YFlzwCy+w=
X-Google-Smtp-Source: AK7set9uE6XHEfmlNBLoVq/tW3pv0pVRjdR05b71V7kBRCr/6zGh5Fy+K5JwdSQ7nVBboidheh2rLg==
X-Received: by 2002:a05:6a20:1e4d:b0:da:144:92a8 with SMTP id cy13-20020a056a201e4d00b000da014492a8mr11087822pzb.37.1679927881450;
        Mon, 27 Mar 2023 07:38:01 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:b47c:3979:4a3b:2b03])
        by smtp.gmail.com with ESMTPSA id u16-20020aa78490000000b00627df85cd72sm17204404pfn.199.2023.03.27.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:38:00 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, axboe@kernel.dk
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/2] block: null_blk: make fault-injection configurable via configfs
Date:   Mon, 27 Mar 2023 23:37:31 +0900
Message-Id: <20230327143733.14599-1-akinobu.mita@gmail.com>
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

This patch set makes null_blk driver-specific fault-injection dynamically
configurable per device via configfs.

Since the null_blk driver supports configuration such as device creation
via configfs, it is natural to configure fault-injection via configfs as
well.

Currently, only the debugfs interface is provided for dynamically
configuring fault-injection, so this introduces a compatible interface via
configfs.

Akinobu Mita (2):
  fault-inject: allow configuration via configfs
  block: null_blk: make fault-injection dynamically configurable per
    device

 .../fault-injection/fault-injection.rst       |   8 +
 drivers/block/null_blk/Kconfig                |   2 +-
 drivers/block/null_blk/main.c                 |  93 +++++++--
 drivers/block/null_blk/null_blk.h             |   7 +-
 include/linux/fault-inject.h                  |  22 ++
 lib/Kconfig.debug                             |  13 +-
 lib/fault-inject.c                            | 191 ++++++++++++++++++
 7 files changed, 312 insertions(+), 24 deletions(-)

-- 
2.34.1

