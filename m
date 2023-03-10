Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35BE6B4D96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjCJQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCJQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841F4AFC9;
        Fri, 10 Mar 2023 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466851; x=1710002851;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=uM8X+xkB2Qx3TghdZiraBg6UISWTlnbj55qdDaDCDOM=;
  b=RUvPeLq6S6kBLs7C5Bu3Sj2WuwoioWI9ALsxHLkh7NzRqPDa04wmhAXx
   fZKWPxdm5LrCjJFVdassxz7NIE+57+5Jg7ZVEo90VNloSXsidZW427Ujg
   jlcWf+O9N/gZKmgmz3mmDhV1PG0iROObPyUHeMN9h46qRG6/KL89Bq8AO
   0U5h12t/YTC92EPO+xtW7kZnbRDr/A8AleqDyxVFoXgUTD957pYqoopNB
   HJTcpz8qgKqfiCkYr+2c7VZIH9mkfLixaylwRbqX1OssftrrCHYi+qUYb
   VahtQ4G+tEVGdpZmMK0BFAWw0dzKLibGt/HYeBxCi9flEaQD6+SfUK9yV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621149"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621149"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="677874312"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="677874312"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2023 08:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5AA7D46E; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] pktcdvd: Use put_unaligned_be16() and get_unaligned_be16()
Date:   Fri, 10 Mar 2023 18:45:47 +0200
Message-Id: <20230310164549.22133-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the driver code slightly better to understand.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 2c5441303e55..340e953e3888 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -70,6 +70,8 @@
 #include <linux/nospec.h>
 #include <linux/uaccess.h>
 
+#include <asm/unaligned.h>
+
 #define DRIVER_NAME	"pktcdvd"
 
 #define MAX_SPEED 0xffff
@@ -825,10 +827,8 @@ static noinline_for_stack int pkt_set_speed(struct pktcdvd_device *pd,
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
 	cgc.sshdr = &sshdr;
 	cgc.cmd[0] = GPCMD_SET_SPEED;
-	cgc.cmd[2] = (read_speed >> 8) & 0xff;
-	cgc.cmd[3] = read_speed & 0xff;
-	cgc.cmd[4] = (write_speed >> 8) & 0xff;
-	cgc.cmd[5] = write_speed & 0xff;
+	put_unaligned_be16(read_speed, &cgc.cmd[2]);
+	put_unaligned_be16(write_speed, &cgc.cmd[4]);
 
 	ret = pkt_generic_packet(pd, &cgc);
 	if (ret)
@@ -1526,8 +1526,7 @@ static int pkt_mode_sense(struct pktcdvd_device *pd, struct packet_command *cgc,
 
 	cgc->cmd[0] = GPCMD_MODE_SENSE_10;
 	cgc->cmd[2] = page_code | (page_control << 6);
-	cgc->cmd[7] = cgc->buflen >> 8;
-	cgc->cmd[8] = cgc->buflen & 0xff;
+	put_unaligned_be16(cgc->buflen, &cgc->cmd[7]);
 	cgc->data_direction = CGC_DATA_READ;
 	return pkt_generic_packet(pd, cgc);
 }
@@ -1538,8 +1537,7 @@ static int pkt_mode_select(struct pktcdvd_device *pd, struct packet_command *cgc
 	memset(cgc->buffer, 0, 2);
 	cgc->cmd[0] = GPCMD_MODE_SELECT_10;
 	cgc->cmd[1] = 0x10;		/* PF */
-	cgc->cmd[7] = cgc->buflen >> 8;
-	cgc->cmd[8] = cgc->buflen & 0xff;
+	put_unaligned_be16(cgc->buflen, &cgc->cmd[7]);
 	cgc->data_direction = CGC_DATA_WRITE;
 	return pkt_generic_packet(pd, cgc);
 }
@@ -1580,8 +1578,7 @@ static int pkt_get_track_info(struct pktcdvd_device *pd, __u16 track, __u8 type,
 	init_cdrom_command(&cgc, ti, 8, CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_TRACK_RZONE_INFO;
 	cgc.cmd[1] = type & 3;
-	cgc.cmd[4] = (track & 0xff00) >> 8;
-	cgc.cmd[5] = track & 0xff;
+	put_unaligned_be16(track, &cgc.cmd[4]);
 	cgc.cmd[8] = 8;
 	cgc.quiet = 1;
 
@@ -1662,8 +1659,8 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 		return ret;
 	}
 
-	size = 2 + ((buffer[0] << 8) | (buffer[1] & 0xff));
-	pd->mode_offset = (buffer[6] << 8) | (buffer[7] & 0xff);
+	size = 2 + get_unaligned_be16(&buffer[0]);
+	pd->mode_offset = get_unaligned_be16(&buffer[6]);
 	if (size > sizeof(buffer))
 		size = sizeof(buffer);
 
@@ -1820,7 +1817,7 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
 	cgc.cmd[8] = 8;
 	ret = pkt_generic_packet(pd, &cgc);
-	pd->mmc3_profile = ret ? 0xffff : buf[6] << 8 | buf[7];
+	pd->mmc3_profile = ret ? 0xffff : get_unaligned_be16(&buf[6]);
 
 	memset(&di, 0, sizeof(disc_information));
 	memset(&ti, 0, sizeof(track_information));
@@ -1933,7 +1930,7 @@ static noinline_for_stack int pkt_write_caching(struct pktcdvd_device *pd,
 
 	buf[pd->mode_offset + 10] |= (!!set << 2);
 
-	cgc.buflen = cgc.cmd[8] = 2 + ((buf[0] << 8) | (buf[1] & 0xff));
+	cgc.buflen = cgc.cmd[8] = 2 + get_unaligned_be16(&buf[0]);
 	ret = pkt_mode_select(pd, &cgc);
 	if (ret) {
 		dev_err(ddev, "write caching control failed\n");
@@ -1988,12 +1985,12 @@ static noinline_for_stack int pkt_get_max_speed(struct pktcdvd_device *pd,
 		 * Speed Performance Descriptor Block", use the information
 		 * in the first block. (contains the highest speed)
 		 */
-		int num_spdb = (cap_buf[30] << 8) + cap_buf[31];
+		int num_spdb = get_unaligned_be16(&cap_buf[30]);
 		if (num_spdb > 0)
 			offset = 34;
 	}
 
-	*write_speed = (cap_buf[offset] << 8) | cap_buf[offset + 1];
+	*write_speed = get_unaligned_be16(&cap_buf[offset]);
 	return 0;
 }
 
@@ -2038,7 +2035,7 @@ static noinline_for_stack int pkt_media_speed(struct pktcdvd_device *pd,
 		pkt_dump_sense(pd, &cgc);
 		return ret;
 	}
-	size = ((unsigned int) buf[0]<<8) + buf[1] + 2;
+	size = 2 + get_unaligned_be16(&buf[0]);
 	if (size > sizeof(buf))
 		size = sizeof(buf);
 
-- 
2.39.1

