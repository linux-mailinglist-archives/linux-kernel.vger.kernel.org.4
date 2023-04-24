Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FF6ECB71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDXLiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDXLiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:38:52 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A23A8C;
        Mon, 24 Apr 2023 04:38:50 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so74187505e9.1;
        Mon, 24 Apr 2023 04:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682336329; x=1684928329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eglyz+j/occX8WNkEpcLNlY9OWqv/i1uyY+qtuXKrx0=;
        b=h1oc6OkSzXaUIiu8xVLaoIH/i5VQBCmXcQ3cLNvvdXasTBCJo8bwrQR6con5vXUJco
         9WBW1obzz6gy3S/jjTzNtm9NlAvxU8KUljaCl8XijtgznI55E6Wq8fVVQJMQQ8XYvXkU
         j9XGZ73PTdXoqHPPT4CiujN9ZHCNwxapF8WcD9LSr6B8MbyHJGjnSPyRravILLdIypQY
         hxMfe1qe1LMBhY+UOOtRTrhDnbw8fefehWEuXbo18oTj8uNkyT5NDxO+WeTuulbT2E29
         Gbrd3Hc405ZNQPJwWUfqc471MvlDNmnfJGLULe4ZtQrUXwtpTiugUnKbXc9VEc8vg3I/
         b2og==
X-Gm-Message-State: AAQBX9cWNefnz+qarmb/1pDl2wIgHW/UPCtp8BdLNgI50CYQUnkE+uV+
        IWhiq0Ih9Y/y25OlTEKEkeU=
X-Google-Smtp-Source: AKy350bIiGtYQ95Um7VGjxvEpP0Bu+W7VgYMq+aOVIHhgROIjVQNbR2DGGAa6ASUxZR2oIKOoxEPVA==
X-Received: by 2002:a5d:414c:0:b0:2fa:d00d:cab8 with SMTP id c12-20020a5d414c000000b002fad00dcab8mr9478626wrq.18.1682336328944;
        Mon, 24 Apr 2023 04:38:48 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id e18-20020adffc52000000b002efacde3fc7sm10570820wrs.35.2023.04.24.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:38:48 -0700 (PDT)
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
Subject: [PATCH v4] of: fdt: Scan /memreserve/ last
Date:   Mon, 24 Apr 2023 12:38:46 +0100
Message-Id: <20230424113846.46382-1-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the scanning /memreserve/ and /reserved-memory node order to fix
Kernel panic on Khadas Vim3 Board.

If /memreserve/ goes first, the memory is reserved, but nomap can't be
applied to the region. So the memory won't be used by Linux, but it is
still present in the linear map as normal memory, which allows
speculation. Legitimate access to adjacent pages will cause the CPU
to end up prefetching into them leading to Kernel panic.

So /reserved-memory node should go first, as it has a more updated
description of the memory regions and can apply flags, like nomap.

Signed-off-by: Lucas Tanure <tanure@linux.com>i
---
Previous Threads:
#regzbot link: https://lore.kernel.org/linux-arm-kernel/40ca11f84b7cdbfb9ad2ddd480cb204a@agner.ch/#regzbot
#regzbot link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com/

V1: https://lore.kernel.org/all/20230406151429.524591-1-tanure@linux.com/
v2: https://lore.kernel.org/all/20230410120017.41664-1-tanure@linux.com/
v3: https://lore.kernel.org/linux-mm/20230412224620.8909-1-tanure@linux.com/T/

Change from V3:
 - Drop cover letter
 - Add more information into the patch

Change from V2:
 - Remove region overlap and reserved checks

Change from V1:
 - Instead of allowing to mark nomap a region already reserved, give
precedence to /reserved-memory node scan.
---
 drivers/of/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d14735a81301..bf502ba8da95 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -635,6 +635,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	if (!initial_boot_params)
 		return;
 
+	fdt_scan_reserved_mem();
+	fdt_reserve_elfcorehdr();
+
 	/* Process header /memreserve/ fields */
 	for (n = 0; ; n++) {
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
@@ -643,8 +646,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		memblock_reserve(base, size);
 	}
 
-	fdt_scan_reserved_mem();
-	fdt_reserve_elfcorehdr();
 	fdt_init_reserved_mem();
 }
 
-- 
2.40.0

