Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F36E021C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLWqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLWqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:46:30 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E446A4D;
        Wed, 12 Apr 2023 15:46:30 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id bm45so3147368oib.4;
        Wed, 12 Apr 2023 15:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681339589; x=1683931589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pne7zvLmG7QcEYfgoOlm61Hw/xE8wOJKTFUuUUTpcYQ=;
        b=RXOQwJJWcRpH8miHMRdP6GJz5mH4Ht/uKe6pxNh+ykS0ZgLZETG2G2PWulSHBPYGbY
         336z4DHHodBNJHeJBfyfN1B7SmLUMa3vLKTOthrxHEu0zAjsOgmhUXQy9VqwEbogm1h3
         IaBCLO0w4r/SoyZ6OP/1FSIMddjPHVg6IHU9Gmov53kAHgf11uTQBaZnvE4VMKchp1ee
         mcXPwZi8BtBHCOcRc8DwdBOcfKrzwzywMIhk4ABlIysO8iF9OmBssc/lVT4JHyFhNeBO
         +BfiJutDrc7U/d/MJ+i8r2qekdbEt7UQGzAHHuohPLE2++7mZ75+V9GDgNHgJXIoSNVj
         1aLQ==
X-Gm-Message-State: AAQBX9d5j7wZvMTvD5RlJGrc4R6TqJW3gHzNh7JViRx5GN50shdwxmK0
        kQbL1MPER0wYDe1WH3pS660=
X-Google-Smtp-Source: AKy350Ys8E8JJq8xGCw4fHFXNKDuO1baUBk2ZioJngMRNu3jNQILo68Yl8tpyTKllxhZsNjoU/Jx5g==
X-Received: by 2002:a05:6808:106:b0:387:77f1:21 with SMTP id b6-20020a056808010600b0038777f10021mr104823oie.48.1681339589345;
        Wed, 12 Apr 2023 15:46:29 -0700 (PDT)
Received: from archfamilia.lan ([181.219.149.7])
        by smtp.gmail.com with ESMTPSA id cg9-20020a056808328900b0038beb8c1289sm50012oib.15.2023.04.12.15.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:46:28 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        stefan@agner.ch, Lucas Tanure <tanure@linux.com>
Subject: [PATCH v3 0/1] Fix Random Kernel panic from when fail to reserve memory
Date:   Wed, 12 Apr 2023 18:46:19 -0400
Message-Id: <20230412224620.8909-1-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to fix an issue where the kernel panics randomly on my Vim3
board. The problem happens when the ARM Trusted Firmware memory is not
removed from the available ram.

This happens because my u-boot provides /memreserve/, but it doesn't flag
it as nomap. And the kernel scan of /reserved-memory node can't map as
nomap as the region is already reserved.

The idea now is to scan /memreserve/ after /reserved-memory node, and
/memreserve/ will skip regions already reserved by /reserved-memory node.

Previous Threads:
#regzbot link: https://lore.kernel.org/linux-arm-kernel/40ca11f84b7cdbfb9ad2ddd480cb204a@agner.ch/#regzbot
#regzbot link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com/

V1: https://lore.kernel.org/all/20230406151429.524591-1-tanure@linux.com/
v2: https://lore.kernel.org/all/20230410120017.41664-1-tanure@linux.com/

Change from V2:
 - Remove region overlap and reserved checks

Change from V1:
 - Instead of allowing to mark nomap a region already reserved, give
precedence to /reserved-memory node scan.

Lucas Tanure (1):
  of: fdt: Scan /memreserve/ last

 drivers/of/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.40.0

