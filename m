Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538976720AD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjARPJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjARPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:09:16 -0500
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 07:09:15 PST
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D91ABFE;
        Wed, 18 Jan 2023 07:09:15 -0800 (PST)
Received: from MTA-05-3.privateemail.com (unknown [68.65.122.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id 1D0676016B;
        Wed, 18 Jan 2023 15:03:21 +0000 (UTC)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id AFEC318000A6;
        Wed, 18 Jan 2023 10:03:19 -0500 (EST)
Received: from bpappas-XPS-13-9310.ucf.edu (050-088-208-136.res.spectrum.com [50.88.208.136])
        by mta-05.privateemail.com (Postfix) with ESMTPA id 2CBC718000B8;
        Wed, 18 Jan 2023 10:03:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674054199;
        bh=yeQJ1cmPcm9jEM9x0mAr4yr+O8czbMvMc2TBJNkOxLE=;
        h=From:To:Cc:Subject:Date:From;
        b=BtEdw46To5nWS/BlkIgpenoTX1dwxmlu9pY/usU4Gir3aclWtf8dntr1W4G4Goeg0
         QtCS4yiTop3vqxhEhi0MHkyTNuf39KdyHpEtoDXA5b7zWp8UJuVE6V3yEE70lmFG7g
         Z5LoJd5uBlDqrlzPXWcqNP/PMzhGhZszGkWRuLJzufjyN8wqbco06IJQRsuPfD2PGb
         gmxxlCNsuWigUaEwzkwKp9nXXsGkduOkGd6Q1TClgMx/v3JvLM2liwhS6rwiFFfjih
         86goiBdWjkP3j86oSFyUOZMFU+ipmkdzhlBAUpkVNUytKsX6q/HfyhbZzg1zqiXAwv
         OzPtW1DfWNkyA==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH] staging: iio: frequency: ad9832: Replace macro AD9832_PHASE() with function
Date:   Wed, 18 Jan 2023 10:03:06 -0500
Message-Id: <20230118150306.16448-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the macro AD9832_PHASE() with a static function to comply with
Linux coding style standards.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
 drivers/staging/iio/frequency/ad9832.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6f9eebd6c7ee..537825534a28 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -59,7 +59,9 @@
 #define AD9832_CMD_SLEEPRESCLR	0xC
 
 #define AD9832_FREQ		BIT(11)
-#define AD9832_PHASE(x)		(((x) & 3) << 9)
+
+static unsigned short ad9832_phase(int x) { return (x & 3) << 9; }
+
 #define AD9832_SYNC		BIT(13)
 #define AD9832_SELSRC		BIT(12)
 #define AD9832_SLEEP		BIT(13)
@@ -221,8 +223,8 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			break;
 		}
 
-		st->ctrl_fp &= ~AD9832_PHASE(3);
-		st->ctrl_fp |= AD9832_PHASE(val);
+		st->ctrl_fp &= ~ad9832_phase(3);
+		st->ctrl_fp |= ad9832_phase(val);
 
 		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
 					st->ctrl_fp);
-- 
2.34.1

