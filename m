Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2665C595
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbjACSBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbjACSAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:00:54 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262260F3;
        Tue,  3 Jan 2023 10:00:53 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id h26so4135104ila.11;
        Tue, 03 Jan 2023 10:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3U4kPXRDj8X/D/vbdLzUnOyXOpG/g/yFLv9I84Ua9eI=;
        b=msi4v/2nXdDNRcSRGQCicecr1JhkOOQF6WqW2qEUSr/7yBI+IrnyvZfU4OOYX/B3KV
         q9ySObEwNuUsFqWJhwcI1lDz6rYgTbuhqbGJ+8xUOmS0P1azFHsGvp87FDRdhDFJb3Bu
         2Aw+p5Mc0Kz8Ml7LXuVe5v6fZM7yFlCaEsGHRMj0VusIrKVjBGJbsvSysIgp8IRQ1Me9
         KHTdEvlcx0eMu8FxGeuMEZAgSFTRASMrgKt2LLepCyQB8+QOntDTgjgBs0NTXvvKxTtK
         6U4lX0YVd/vP5OMEbagRg9RySFggjvClq3Lmjg5jJln0fDbHkXcTukBp4vROAgzbSxlH
         bCKA==
X-Gm-Message-State: AFqh2kp9tCFKP+ps1qtaOPSl5dQF+NqbEcpNhP0tyxQIQqB2r5LOMPD/
        pXXC9ORScM0DxFvM4i2Wcw==
X-Google-Smtp-Source: AMrXdXtEtZENPLw4lfH/V5j5pYzOrPCUXQlZ5CnDGDRq+MDhNRSNS6L4uutheusjaF3nHuQWU136zg==
X-Received: by 2002:a92:c60e:0:b0:304:b79a:5008 with SMTP id p14-20020a92c60e000000b00304b79a5008mr32921267ilm.29.1672768853018;
        Tue, 03 Jan 2023 10:00:53 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v18-20020a92d252000000b0030c0217dde6sm7739103ilg.0.2023.01.03.10.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:00:52 -0800 (PST)
Received: (nullmailer pid 3492165 invoked by uid 1000);
        Tue, 03 Jan 2023 18:00:51 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] of: Fix handling CONFIG_CMDLINE* even without /chosen node
Date:   Tue, 03 Jan 2023 12:00:31 -0600
Message-Id: <20230103-dt-cmdline-fix-v1-0-7038e88b18b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9ttGMC/x2NSwrCQBAFrxJ6bcMkgwl6leBiPs+kYWzDjIoQc
 ncbl1W84u3UUAWNrt1OFR9p8lSD/tRRWoMuYMnGNLjBu955zi9Oj1xEwXf5MvyIOMFf4nQmi2Jo
 4FiDptUyfZdicquw7f9lvh3HD2TCtFx1AAAA
To:     Geoff Levand <geoff@infradead.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a7d550f82b445cf218b47a2c1a9c56e97ecb8c7a (of: fdt: Honor CONFIG_CMDLINE*
even without /chosen node) moved the processing of the kernel built-in command
line (CONFIG_CMDLINE) from the early_init_dt_scan_chosen routine to the
early_init_dt_scan_nodes routine.

The current powerpc startup code does not call into early_init_dt_scan_nodes, so
processing of CONFIG_CMDLINE never happens, even if CONFIG_CMDLINE_FORCE=y.
The result is an empty kernel command line, and mounting of the root file system
then fails with a kernel panic (not syncing: VFS: Unable to mount root fs).

Let's revert the above commit and redo the missing /chosen node handling 
within early_init_dt_scan_chosen().

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (2):
      Revert "of: fdt: Honor CONFIG_CMDLINE* even without /chosen node"
      of: fdt: Honor CONFIG_CMDLINE* even without /chosen node, take 2

 drivers/of/fdt.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230103-dt-cmdline-fix-e36eb7e39b75

Best regards,
-- 
Rob Herring <robh@kernel.org>
