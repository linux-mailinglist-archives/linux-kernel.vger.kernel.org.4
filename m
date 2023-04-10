Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748FC6DC679
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDJMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDJMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:00:27 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7625430D6;
        Mon, 10 Apr 2023 05:00:26 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-183f4efa98aso11732134fac.2;
        Mon, 10 Apr 2023 05:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681128025; x=1683720025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwzRQ43MPzZ+0En/PxCReyprlGKQZaWmp43PqnWxhn8=;
        b=3W38PlwCpiVwpELKmN9c+pH1Wc+BIb2XMtuTqZZYUH3NqKWVRJCofPeqHy9Kn/CZI9
         8lok8Kk2EWCOmWx17HqrrFvFXnk+UEt/W75rrFle8AoaiN88EHaVlbkMQhYLc1ZVjptx
         gkcObZt/SPBrTkTNR+uL3DHuspZCRyhaxglDPiBdudDRWopjincwMo3NDuCM7rNovBHJ
         Igfnol9wT7FuFJo+2YGSIy+8rud8vySo/DtbsFbJA14Udpiq9sFCMeC1f1TkL/NjGCVU
         kztivhX5ogOy8Kn0F6HSTt8MPsukxk24utNzVgzfUL53f3oFa7zwbAj1MblOUk406ecX
         DT9g==
X-Gm-Message-State: AAQBX9e+A5tZucc8JrX1yA855DdaIdILo7AOR0PyyxidRuZw8octRO8p
        EYYiAGdabReqySVo/uqMmlQ=
X-Google-Smtp-Source: AKy350bn7Zy6Zd8wgM/7uCU7v1NyBl3VX26fotCHAfNXRGwWijIajnJqHa+1xWIXpql08YO37l89iQ==
X-Received: by 2002:a05:6870:ac29:b0:184:222:6655 with SMTP id kw41-20020a056870ac2900b0018402226655mr4551329oab.4.1681128024258;
        Mon, 10 Apr 2023 05:00:24 -0700 (PDT)
Received: from archfamilia.lan ([181.219.149.7])
        by smtp.gmail.com with ESMTPSA id j4-20020a9d7384000000b0069f9203967bsm4141884otk.76.2023.04.10.05.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 05:00:23 -0700 (PDT)
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
Subject: [PATCH v2 0/1] Fix Random Kernel panic from when fail to reserve memory
Date:   Mon, 10 Apr 2023 08:00:16 -0400
Message-Id: <20230410120017.41664-1-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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

V1 Patch series: https://lore.kernel.org/all/20230406151429.524591-1-tanure@linux.com/

Previous Threads:
#regzbot link: https://lore.kernel.org/linux-arm-kernel/40ca11f84b7cdbfb9ad2ddd480cb204a@agner.ch/#regzbot
#regzbot link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com/

Change from V1:
 - Instead of allowing to mark nomap a region already reserved, give
precedence to /reserved-memory node scan.

Lucas Tanure (1):
  of: fdt: Scan /memreserve/ last

 drivers/of/fdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.40.0

