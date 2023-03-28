Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E106CCAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC1T4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC1T4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:56:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8DD1BE1;
        Tue, 28 Mar 2023 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680033382; x=1711569382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2vY4XgONi5XF8GcYrGpxr6w0NAzTD8+jQb9Xq6HrBc4=;
  b=SLxwH7fb7L0pAnzwQ5mTCDM+WZ4SFOK2f2xo72OEhd4kQlnV3Eb1kIhw
   WUFg3+iU3LoiVFwwmVw2gae2xOHlX4nvJW3f5of8zvbKgFus3ynXQZ/Tw
   ScfyQtfFFDrx6eYBGH84XkTMmVfIqmpR7l/YlvsFggzhtlj3sJxwWxb7C
   oBmLcRwoQFEhu+MgwAUQVp2I+6Ob0xjmreBd/JT21h+Nv98b95YXUjY+0
   G6ivwj9NAZyYGtiwptu/xoJLM4uF0nBqNcqSmayT3XxMpM5xNC9YRGnfT
   vZE74azw9VPzHO4q5DSQS+LbdClV4M62bepORP4QZ1nH2+fmgDm6hOHey
   A==;
X-IronPort-AV: E=Sophos;i="5.98,297,1673938800"; 
   d="scan'208";a="206741353"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2023 12:56:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 12:56:21 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 12:56:21 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/4] Atmel crypto engine fixes
Date:   Tue, 28 Mar 2023 12:56:25 -0700
Message-ID: <cover.1680019905.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

I made changes to the crypto engines to fix the errors in the crypto
manager tests. Mainly having to do with in-place tests with two 
scatter lists. These are built and tested in 6.2.7 kernel, the
devices that are used for testing is the sam9x60, sama7g5, and
sama5d27_som1_ek.

Adding support for zero-length messages for hmac-sha operations. Using
the atmel_sha_fill_padding() function to padd the empty message manualy
then disabling auto padding. This is built and tested on kernel 6.2.7
using sam9x60, sama7g5, and sama5d27_som1_ek.


Ryan Wanner (4):
  crypto: atmel-sha: Add zero length message digest support for hmac
  crypto: atmel-tdes - Detecting in-place operations with two sg lists
  crypto: atmel-aes - Detecting in-place operations two sg lists
  crypto: atmel-aes - Match cfb block size with generic implementation

 drivers/crypto/atmel-aes.c  | 16 +++++-----------
 drivers/crypto/atmel-sha.c  | 34 ++++++++++++++++++++++++++++++----
 drivers/crypto/atmel-tdes.c | 15 +++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.37.2

