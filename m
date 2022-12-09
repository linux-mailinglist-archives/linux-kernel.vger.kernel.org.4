Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B656648593
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiLIPa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLIPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DA87CBE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670599761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sVPp+RXXIuwbJ/P+sgTaSUNvxWcy+w6cewpJQQsBYQM=;
        b=IBsZ/TmpTqrKh1fWpZMcpiYAAy++L/tjM/N/rsuhl0XtK5s7dq/3wCGdpzE/WZzUOgcw70
        mrYbY8ck6a1LJpbk2k8k5skh11Woso+VVAj2efxEltPVvB3Wo+s1YqwAh3tOfbqVswVG89
        6FCA82pnKA8jDoLUjXuii2jnToE1lj0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-vQq-wMM0Oki7KYwAf1ocsw-1; Fri, 09 Dec 2022 10:29:20 -0500
X-MC-Unique: vQq-wMM0Oki7KYwAf1ocsw-1
Received: by mail-vs1-f70.google.com with SMTP id d126-20020a671d84000000b003ad555428e8so1340437vsd.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVPp+RXXIuwbJ/P+sgTaSUNvxWcy+w6cewpJQQsBYQM=;
        b=yO2szOWWoZ3+UizEINRXc7m4kDFNsaylJML1cQ++/KfaLawbBnnkeiTz5Apkkkd6Ly
         lMr4TF0BmVTaUcmr7yFyU4DDR4UMoJ6z6alwwj2tYr321IqRoUbCRhYvj+652EX0Cash
         5ds/n2wW5AFu33i38sCHAOp5nP9AntMG2WJqGE7cWD/nplbTMxErYvUfaVtihFCh4sST
         HYcB9jN5AGFHExaW9PAtbLCF9Da1g/znqHTg+GAxF2+z8esJ6Br9aLa0zEiqcIlZe9SU
         LzaVhMrj71S5izxghrIXYtK7JQwozwyVmvXt1EgeEBWd1mSV6Q7sorq4VMrthTL04ZQY
         HgYg==
X-Gm-Message-State: ANoB5pnz7dOIfM36eV3aL+dBMwdHXzHIVBD1rq9mueIHtIe8pwpp0Cf8
        6g0BJDa9TIGP/LyXdGtqhrBGQ6dhsDnzesVGHuzqjjrv5bEnPLvMcoezQYBGdx4afOHQ3+nU1vf
        pLXZIrZ4D7h12NIbbc9aFUsI=
X-Received: by 2002:a05:6102:f99:b0:3b3:1e2:c5f2 with SMTP id e25-20020a0561020f9900b003b301e2c5f2mr3544212vsv.31.1670599759601;
        Fri, 09 Dec 2022 07:29:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6FrbPYIIxuCxO4nQrzK56aiDCnSJWtvhAQan70ptTMMQsJ/4gG2VIbKs5PYDJtkupv71q1PQ==
X-Received: by 2002:a05:6102:f99:b0:3b3:1e2:c5f2 with SMTP id e25-20020a0561020f9900b003b301e2c5f2mr3544188vsv.31.1670599759371;
        Fri, 09 Dec 2022 07:29:19 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm29484qkb.77.2022.12.09.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:29:18 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] clk: socfpga: use of_clk_add_hw_provider and improve error handling
Date:   Fri,  9 Dec 2022 16:29:07 +0100
Message-Id: <20221209152913.1335068-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set improves error handling and replaces the deprecated
of_clk_add_provider() function with of_clk_add_hw_provider() in the
Intel SoC-FPGA family clock drivers.

The patch set is based on top of the patch: "Fix memory leak in
socfpga_gate_init()" to avoid a conflict.

https://lore.kernel.org/all/20221123031622.63171-1-xiujianfeng@huawei.com/

Marco Pagani (6):
  clk: socfpga: use of_clk_add_hw_provider and improve error handling
  clk: socfpga: arria10: use of_clk_add_hw_provider and improve error
    handling
  clk: socfpga: use of_clk_add_hw_provider and improve error handling
  clk: socfpga: arria10: use of_clk_add_hw_provider and improve error
    handling
  clk: socfpga: use of_clk_add_hw_provider and improve error handling
  clk: socfpga: arria10: use of_clk_add_hw_provider and improve error
    handling

 drivers/clk/socfpga/clk-gate-a10.c   | 26 +++++++++++++++------
 drivers/clk/socfpga/clk-gate.c       | 35 +++++++++++++++++-----------
 drivers/clk/socfpga/clk-periph-a10.c | 22 ++++++++++-------
 drivers/clk/socfpga/clk-periph.c     | 26 ++++++++++++++++-----
 drivers/clk/socfpga/clk-pll-a10.c    | 30 +++++++++++++++++-------
 drivers/clk/socfpga/clk-pll.c        | 32 +++++++++++++++++--------
 6 files changed, 118 insertions(+), 53 deletions(-)

-- 
2.38.1

