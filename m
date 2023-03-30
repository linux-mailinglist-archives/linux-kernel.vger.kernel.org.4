Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA326D060A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjC3NL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjC3NLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:11:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48A729F;
        Thu, 30 Mar 2023 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680181884; x=1711717884;
  h=from:to:cc:subject:date:message-id;
  bh=lgVVQIwI6iLlo2kEEH9j4UdpPk+a4BHv5x14ZPkjMN0=;
  b=YxSVIMJ8OdLGcoGa2vPV27c52GWH6IJivPHJPSYEH0HjfPb2jbUFO0tk
   mo4UBrYkxbdNDpUR+La70r9VqPQRrPVv99sfqNJqxoJNAolmuIiZC5vf7
   WIeb0fPSIlFng2Y+TXlqPt88caCF6FC0rjgJqje2HRuYM14dwZhJFl4o9
   Tu8ePen4MZZy2fDpiRLrj2QdN6vb6Anx6PIVjtuFdKaGTOEWDwVV6lcHW
   Xlu97r+G9iqyHC9yfXe0upH/eJWKnklNc8SH7PgcqUUyCkyn478bDaL3n
   q7LiKD8bY1ZMxliCYMwLjmJW7EqA9n4uMOz1cyCTdGLfDLtmkpPaDdVbP
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="226881513"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 21:11:23 +0800
IronPort-SDR: VqJTwR7FZvYcAr3YF1jp8fJHWfodrwzGpVVJtEQSXMhcA9NUWFbrvHdgnjKO6Hhlc71+pVARH6
 Voc7/JXOaoTSUjR1lrhSsYnsXK0/PaEvRyTT39UqjUgUxbR/VqQyVFYO93lhk/w8dMJJ1Qdo6Q
 BPe1SdLkGjM3AMhH/9evQpp0po8TGT3lHfBLC1/bqnw8uMh6IZC9jHfpXXS1DyMn8OWtAEcHoY
 M5ceWAqIpFXMtEcjJgfz0d9vnDfuP/aAdTfh4dk2J7nJUXF/D4U7aGpjrIG0Tb7z1W/4agWwQE
 b20=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 05:21:51 -0700
IronPort-SDR: +f30L4CjJfQB9hvZKMAeUD8qzXGdLAXQAQUHwxayKD/FAeMeXDI0ZHm/ncLdx9k5O5H01YREGf
 xaCrwYT8pwcKyo9FOh7dvgetSpvQ8YqDfjb61wbsdLDaQCpdw/QHnItoKfWjMtWNd37zSW9WCR
 +purt8sAzLkGsSO41AqL5Kg3mZ4CGl8KnYqKz/HOUMpRoZUxhEhmHPISLkrphQBKobQIdbHe8D
 4g2YvenvbpY81ajQ4RvqJPv6Z8lbzyD2qTfWEVcp2e58wwTlvv7bt84WOHLrra8pvRvMLRvRfH
 Rik=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.30.255])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 06:11:21 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Date:   Thu, 30 Mar 2023 16:11:09 +0300
Message-Id: <20230330131109.5722-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in UFS, each request is designated via the triplet <iid, lun, task tag>.

In UFS4.0 the Initiator ID field is 8 bits wide, comprised of the
EXT_IID and IID fields. Together with the task tag (single byte), they
limit the driver's hw queues capacity.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 35a3bd95c5e4..d529c42a682a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8468,6 +8468,10 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 	if (ret)
 		goto err;
 
+	if (WARN_ONCE(hba->nutrs * hba->nr_hw_queues > (1 << 16) - 1,
+		     "there can be at most 1<<16 inflight requests\n"))
+		goto err;
+
 	/*
 	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
 	 * Number of supported tags in MCQ mode may be larger than SDB mode.
-- 
2.17.1

