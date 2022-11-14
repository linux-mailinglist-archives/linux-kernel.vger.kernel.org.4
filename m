Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204F627D34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiKNL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiKNL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:58:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D229E2316A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:56:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l14so17762444wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZzVXeLEbKgHa6xp58UZhxK35gPXXnr/yFWcfifNddw=;
        b=aIrxBLd9mh3Jks/mVTwXGWwCXJi6VCMKyER79zwl1PW7VMbBAMJFVe3xmXSq9ZGZTG
         b3LBlbweXerNfxewWGkhez5ZNi7us5k4HiSI5IO4E8Zxmj8KBPW17sOa/pwEca50L+XL
         roIp9/Umrcw7lXuCaDC9GBPdKOvQ8Ibk+4ZPQXkClXdN3jQAEB5FfOQsgmlONJNLH4Cz
         jUB9dCV+PtSdRtjrHfNtB5NKNxuchCP1bNafYNIBviv9ZJ4hU8eSls5YV5VHP9aXoUtq
         ZkIpwz1f/rJnjkOpWYynJxitAhy6cL1TX1j6hO13ns8XZt5iuXVYC2L0qVT4XFHDZbxP
         EyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZzVXeLEbKgHa6xp58UZhxK35gPXXnr/yFWcfifNddw=;
        b=PJjsCAJFhRbYhYJ1zH5TaZ9XriH89/v1yR1pF59PdtT02CBNRtipJDwDemnmcMz+Wq
         BuuAdVUd6ZEmUVR1aWQ0kfuPxJMLNHzpfNUu9NDG3hEKMb+anRZXSVrDtrxvzmQAU1VK
         Ntk5xbI8om6110ARb3HAw4npq0yO7T+YP6k4Hy8k79S2UZJmYoz1h4aSLcoCjprzTD8a
         jQ/+vBZ4cH3RylU5/5AP+W0R/rLWAg3fZG6kyFMUjtJsWuTFpCk5Dd+Ho/arnbbGOx7N
         XOzoeeF+wGfzTsSCujtHhPTeFBruAM3sszTsdbMywx6F7OrIT+FV/8ruwNUPrtnOze+u
         /luA==
X-Gm-Message-State: ANoB5plWsqVu/LLPFMwDpMdLdHHCGvbUIFu/HtbNLuAJBnStdLkZUtJu
        raZZk7eHjtO/jYJV1D2C6jk+EA==
X-Google-Smtp-Source: AA0mqf76BLqAYFKGQYMG5sSElZP2p1NEEMR0KLF0sGMAL2NYI0BNSqBr+C0009FLgl/Tokj3RlDfbQ==
X-Received: by 2002:a5d:4522:0:b0:236:5f1c:bedf with SMTP id j2-20020a5d4522000000b002365f1cbedfmr7478499wra.367.1668426978469;
        Mon, 14 Nov 2022 03:56:18 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x10-20020adff64a000000b00236883f2f5csm9520658wrp.94.2022.11.14.03.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:56:18 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     wsa@kernel.org, jdelvare@suse.de
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] i2c: smbus: add DDR support for SPD
Date:   Mon, 14 Nov 2022 11:56:06 +0000
Message-Id: <20221114115606.1967080-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my x05 laptop I got:
Memory type 0x12 not supported yet, not instantiating SPD

Adding the 0x12 case lead to a successful instantiated SPD AT24 EEPROM.
i801_smbus 0000:00:1f.3: SMBus using polling
i2c i2c-6: 2/2 memory slots populated (from DMI)
at24 6-0050: 256 byte spd EEPROM, read-only
i2c i2c-6: Successfully instantiated SPD at 0x50
at24 6-0051: 256 byte spd EEPROM, read-only

And then, I decoded it successfully via decode-dimms.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- Added memory type document link
- Added case for LPDDR

 drivers/i2c/i2c-smbus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 07c92c8495a3..c85710ed9548 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -361,9 +361,15 @@ void i2c_register_spd(struct i2c_adapter *adap)
 		return;
 	}
 
+	/*
+	 * Memory types could be found at section 7.18.2 (Memory Device — Type), table 78
+	 * https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.6.0.pdf
+	 */
 	switch (common_mem_type) {
+	case 0x12:	/* DDR */
 	case 0x13:	/* DDR2 */
 	case 0x18:	/* DDR3 */
+	case 0x1B:	/* LPDDR */
 	case 0x1C:	/* LPDDR2 */
 	case 0x1D:	/* LPDDR3 */
 		name = "spd";
-- 
2.37.4

