Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EC6A6D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCANsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCANsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:48:10 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B1ACA32;
        Wed,  1 Mar 2023 05:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iXxQGSxv4hSb0jR/Gu5QY74yz6G5/W/SnN5dKKpvlGk=; b=AgYILYsVpk2HPSQXJRfhwhBacb
        d29RWYsFztUHNOx/RZE7My2WcL7cQ+qR4kRkumYGL+V4SAADM7pH5qSIrLg+XZyiViLuOvaL73G1V
        0AGWw5y9IKKmZaT4FyydObOyYN/tughaxOcpUlaHy94HYeZVPC15tu7SrVjRhDv/okrcZfzycJc6R
        RDcngSNWzhHt8cjMeo1+HKDA6U8XLje74+qudrcFD0iTl+wEAEJ779SzbndB5PFqozvgSmDoyhnaM
        +gnchBmWPzuZFZ0AltAP5iy+Biq/KnDb24pNiHvUTdfKMPMNVpyvPFD+Ab0vY0vE/8sCOyIFTNkvp
        rII3OZig==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pXMoQ-00Dvjx-K0; Wed, 01 Mar 2023 15:48:06 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: tegra: bpmp: Fix error paths in debugfs
Date:   Wed,  1 Mar 2023 15:47:55 +0200
Message-Id: <20230301134756.999169-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Some error paths in mrq_debug_read and bpmp_debug_show would overwrite
the return error code with a subsequent call to mrq_debug_close.

Change the code to only change the error code if there was no prior
error.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 3ca2b5d9e66f..6dfe3d34109e 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -193,7 +193,7 @@ static int mrq_debug_read(struct tegra_bpmp *bpmp, const char *name,
 		},
 	};
 	u32 fd = 0, len = 0;
-	int remaining, err;
+	int remaining, err, close_err;
 
 	mutex_lock(&bpmp_debug_lock);
 	err = mrq_debug_open(bpmp, name, &fd, &len, 0);
@@ -231,7 +231,9 @@ static int mrq_debug_read(struct tegra_bpmp *bpmp, const char *name,
 	*nbytes = len;
 
 close:
-	err = mrq_debug_close(bpmp, fd);
+	close_err = mrq_debug_close(bpmp, fd);
+	if (!err)
+		err = close_err;
 out:
 	mutex_unlock(&bpmp_debug_lock);
 	return err;
@@ -319,7 +321,7 @@ static int bpmp_debug_show(struct seq_file *m, void *p)
 		},
 	};
 	u32 fd = 0, len = 0;
-	int remaining, err;
+	int remaining, err, close_err;
 
 	filename = get_filename(bpmp, file, fnamebuf, sizeof(fnamebuf));
 	if (!filename)
@@ -353,7 +355,9 @@ static int bpmp_debug_show(struct seq_file *m, void *p)
 	}
 
 close:
-	err = mrq_debug_close(bpmp, fd);
+	close_err = mrq_debug_close(bpmp, fd);
+	if (!err)
+		err = close_err;
 out:
 	mutex_unlock(&bpmp_debug_lock);
 	return err;
-- 
2.39.2

