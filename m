Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8EB62D0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiKQBkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKQBkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:40:15 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E387060372;
        Wed, 16 Nov 2022 17:40:12 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCMzv2yR2z4xVnD;
        Thu, 17 Nov 2022 09:40:11 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH1e2Rg080452;
        Thu, 17 Nov 2022 09:40:02 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Thu, 17 Nov 2022 09:40:03 +0800 (CST)
Date:   Thu, 17 Nov 2022 09:40:03 +0800 (CST)
X-Zmail-TransId: 2afb637590f33ab1ddfc
X-Mailer: Zmail v1.0
Message-ID: <202211170940036248332@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <jejb@linux.ibm.com>
Cc:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjc2k6IHNjc2lfZGVidWc6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH1e2Rg080452
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 637590FB.000 by FangMail milter!
X-FangMail-Envelope: 1668649211/4NCMzv2yR2z4xVnD/637590FB.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637590FB.000/4NCMzv2yR2z4xVnD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>
Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 drivers/scsi/scsi_debug.c | 78 +++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a86db97..7bd4d2a7 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6075,7 +6075,7 @@ static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)

 static ssize_t delay_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_jdelay);
+       return sysfs_emit(buf, "%d\n", sdebug_jdelay);
 }
 /* Returns -EBUSY if jdelay is being changed and commands are queued. The unit
  * of delay is jiffies.
@@ -6115,7 +6115,7 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,

 static ssize_t ndelay_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_ndelay);
+       return sysfs_emit(buf, "%d\n", sdebug_ndelay);
 }
 /* Returns -EBUSY if ndelay is being changed and commands are queued */
 /* If > 0 and accepted then sdebug_jdelay is set to JDELAY_OVERRIDDEN */
@@ -6156,7 +6156,7 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,

 static ssize_t opts_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "0x%x\n", sdebug_opts);
+       return sysfs_emit(buf, "0x%x\n", sdebug_opts);
 }

 static ssize_t opts_store(struct device_driver *ddp, const char *buf,
@@ -6186,7 +6186,7 @@ static ssize_t opts_store(struct device_driver *ddp, const char *buf,

 static ssize_t ptype_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_ptype);
+       return sysfs_emit(buf, "%d\n", sdebug_ptype);
 }
 static ssize_t ptype_store(struct device_driver *ddp, const char *buf,
                           size_t count)
@@ -6209,7 +6209,7 @@ static ssize_t ptype_store(struct device_driver *ddp, const char *buf,

 static ssize_t dsense_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_dsense);
+       return sysfs_emit(buf, "%d\n", sdebug_dsense);
 }
 static ssize_t dsense_store(struct device_driver *ddp, const char *buf,
                            size_t count)
@@ -6226,7 +6226,7 @@ static ssize_t dsense_store(struct device_driver *ddp, const char *buf,

 static ssize_t fake_rw_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_fake_rw);
+       return sysfs_emit(buf, "%d\n", sdebug_fake_rw);
 }
 static ssize_t fake_rw_store(struct device_driver *ddp, const char *buf,
                             size_t count)
@@ -6274,7 +6274,7 @@ static ssize_t fake_rw_store(struct device_driver *ddp, const char *buf,

 static ssize_t no_lun_0_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_no_lun_0);
+       return sysfs_emit(buf, "%d\n", sdebug_no_lun_0);
 }
 static ssize_t no_lun_0_store(struct device_driver *ddp, const char *buf,
                              size_t count)
@@ -6291,7 +6291,7 @@ static ssize_t no_lun_0_store(struct device_driver *ddp, const char *buf,

 static ssize_t num_tgts_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_num_tgts);
+       return sysfs_emit(buf, "%d\n", sdebug_num_tgts);
 }
 static ssize_t num_tgts_store(struct device_driver *ddp, const char *buf,
                              size_t count)
@@ -6309,13 +6309,13 @@ static ssize_t num_tgts_store(struct device_driver *ddp, const char *buf,

 static ssize_t dev_size_mb_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_dev_size_mb);
+       return sysfs_emit(buf, "%d\n", sdebug_dev_size_mb);
 }
 static DRIVER_ATTR_RO(dev_size_mb);

 static ssize_t per_host_store_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_per_host_store);
+       return sysfs_emit(buf, "%d\n", sdebug_per_host_store);
 }

 static ssize_t per_host_store_store(struct device_driver *ddp, const char *buf,
@@ -6333,13 +6333,13 @@ static ssize_t per_host_store_store(struct device_driver *ddp, const char *buf,

 static ssize_t num_parts_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_num_parts);
+       return sysfs_emit(buf, "%d\n", sdebug_num_parts);
 }
 static DRIVER_ATTR_RO(num_parts);

 static ssize_t every_nth_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_every_nth);
+       return sysfs_emit(buf, "%d\n", sdebug_every_nth);
 }
 static ssize_t every_nth_store(struct device_driver *ddp, const char *buf,
                               size_t count)
@@ -6371,7 +6371,7 @@ static ssize_t every_nth_store(struct device_driver *ddp, const char *buf,

 static ssize_t lun_format_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", (int)sdebug_lun_am);
+       return sysfs_emit(buf, "%d\n", (int)sdebug_lun_am);
 }
 static ssize_t lun_format_store(struct device_driver *ddp, const char *buf,
                                size_t count)
@@ -6408,7 +6408,7 @@ static ssize_t lun_format_store(struct device_driver *ddp, const char *buf,

 static ssize_t max_luns_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_max_luns);
+       return sysfs_emit(buf, "%d\n", sdebug_max_luns);
 }
 static ssize_t max_luns_store(struct device_driver *ddp, const char *buf,
                              size_t count)
@@ -6447,7 +6447,7 @@ static ssize_t max_luns_store(struct device_driver *ddp, const char *buf,

 static ssize_t max_queue_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_max_queue);
+       return sysfs_emit(buf, "%d\n", sdebug_max_queue);
 }
 /* N.B. max_queue can be changed while there are queued commands. In flight
  * commands beyond the new max_queue will be completed. */
@@ -6484,12 +6484,12 @@ static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,

 static ssize_t host_max_queue_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_host_max_queue);
+       return sysfs_emit(buf, "%d\n", sdebug_host_max_queue);
 }

 static ssize_t no_rwlock_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_no_rwlock);
+       return sysfs_emit(buf, "%d\n", sdebug_no_rwlock);
 }

 static ssize_t no_rwlock_store(struct device_driver *ddp, const char *buf, size_t count)
@@ -6512,19 +6512,19 @@ static ssize_t no_rwlock_store(struct device_driver *ddp, const char *buf, size_

 static ssize_t no_uld_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_no_uld);
+       return sysfs_emit(buf, "%d\n", sdebug_no_uld);
 }
 static DRIVER_ATTR_RO(no_uld);

 static ssize_t scsi_level_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_scsi_level);
+       return sysfs_emit(buf, "%d\n", sdebug_scsi_level);
 }
 static DRIVER_ATTR_RO(scsi_level);

 static ssize_t virtual_gb_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_virtual_gb);
+       return sysfs_emit(buf, "%d\n", sdebug_virtual_gb);
 }
 static ssize_t virtual_gb_store(struct device_driver *ddp, const char *buf,
                                size_t count)
@@ -6564,7 +6564,7 @@ static ssize_t virtual_gb_store(struct device_driver *ddp, const char *buf,
 static ssize_t add_host_show(struct device_driver *ddp, char *buf)
 {
        /* absolute number of hosts currently active is what is shown */
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_num_hosts);
+       return sysfs_emit(buf, "%d\n", sdebug_num_hosts);
 }

 static ssize_t add_host_store(struct device_driver *ddp, const char *buf,
@@ -6607,7 +6607,7 @@ static ssize_t add_host_store(struct device_driver *ddp, const char *buf,

 static ssize_t vpd_use_hostno_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_vpd_use_hostno);
+       return sysfs_emit(buf, "%d\n", sdebug_vpd_use_hostno);
 }
 static ssize_t vpd_use_hostno_store(struct device_driver *ddp, const char *buf,
                                    size_t count)
@@ -6624,7 +6624,7 @@ static ssize_t vpd_use_hostno_store(struct device_driver *ddp, const char *buf,

 static ssize_t statistics_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", (int)sdebug_statistics);
+       return sysfs_emit(buf, "%d\n", (int)sdebug_statistics);
 }
 static ssize_t statistics_store(struct device_driver *ddp, const char *buf,
                                size_t count)
@@ -6646,37 +6646,37 @@ static ssize_t statistics_store(struct device_driver *ddp, const char *buf,

 static ssize_t sector_size_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%u\n", sdebug_sector_size);
+       return sysfs_emit(buf, "%u\n", sdebug_sector_size);
 }
 static DRIVER_ATTR_RO(sector_size);

 static ssize_t submit_queues_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", submit_queues);
+       return sysfs_emit(buf, "%d\n", submit_queues);
 }
 static DRIVER_ATTR_RO(submit_queues);

 static ssize_t dix_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_dix);
+       return sysfs_emit(buf, "%d\n", sdebug_dix);
 }
 static DRIVER_ATTR_RO(dix);

 static ssize_t dif_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_dif);
+       return sysfs_emit(buf, "%d\n", sdebug_dif);
 }
 static DRIVER_ATTR_RO(dif);

 static ssize_t guard_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%u\n", sdebug_guard);
+       return sysfs_emit(buf, "%u\n", sdebug_guard);
 }
 static DRIVER_ATTR_RO(guard);

 static ssize_t ato_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_ato);
+       return sysfs_emit(buf, "%d\n", sdebug_ato);
 }
 static DRIVER_ATTR_RO(ato);

@@ -6685,8 +6685,7 @@ static ssize_t map_show(struct device_driver *ddp, char *buf)
        ssize_t count = 0;

        if (!scsi_debug_lbp())
-               return scnprintf(buf, PAGE_SIZE, "0-%u\n",
-                                sdebug_store_sectors);
+               return sysfs_emit(buf, "0-%u\n", sdebug_store_sectors);

        if (sdebug_fake_rw == 0 && !xa_empty(per_store_ap)) {
                struct sdeb_store_info *sip = xa_load(per_store_ap, 0);
@@ -6704,7 +6703,7 @@ static ssize_t map_show(struct device_driver *ddp, char *buf)

 static ssize_t random_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_random);
+       return sysfs_emit(buf, "%d\n", sdebug_random);
 }

 static ssize_t random_store(struct device_driver *ddp, const char *buf,
@@ -6722,7 +6721,7 @@ static ssize_t random_store(struct device_driver *ddp, const char *buf,

 static ssize_t removable_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_removable ? 1 : 0);
+       return sysfs_emit(buf, "%d\n", sdebug_removable ? 1 : 0);
 }
 static ssize_t removable_store(struct device_driver *ddp, const char *buf,
                               size_t count)
@@ -6739,7 +6738,7 @@ static ssize_t removable_store(struct device_driver *ddp, const char *buf,

 static ssize_t host_lock_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", !!sdebug_host_lock);
+       return sysfs_emit(buf, "%d\n", !!sdebug_host_lock);
 }
 /* N.B. sdebug_host_lock does nothing, kept for backward compatibility */
 static ssize_t host_lock_store(struct device_driver *ddp, const char *buf,
@@ -6757,7 +6756,7 @@ static ssize_t host_lock_store(struct device_driver *ddp, const char *buf,

 static ssize_t strict_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", !!sdebug_strict);
+       return sysfs_emit(buf, "%d\n", !!sdebug_strict);
 }
 static ssize_t strict_store(struct device_driver *ddp, const char *buf,
                            size_t count)
@@ -6774,13 +6773,13 @@ static ssize_t strict_store(struct device_driver *ddp, const char *buf,

 static ssize_t uuid_ctl_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", !!sdebug_uuid_ctl);
+       return sysfs_emit(buf, "%d\n", !!sdebug_uuid_ctl);
 }
 static DRIVER_ATTR_RO(uuid_ctl);

 static ssize_t cdb_len_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_cdb_len);
+       return sysfs_emit(buf, "%d\n", sdebug_cdb_len);
 }
 static ssize_t cdb_len_store(struct device_driver *ddp, const char *buf,
                             size_t count)
@@ -6831,14 +6830,13 @@ static int sdeb_zbc_model_str(const char *cp)

 static ssize_t zbc_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%s\n",
-                        zbc_model_strs_a[sdeb_zbc_model]);
+       return sysfs_emit(buf, "%s\n", zbc_model_strs_a[sdeb_zbc_model]);
 }
 static DRIVER_ATTR_RO(zbc);

 static ssize_t tur_ms_to_ready_show(struct device_driver *ddp, char *buf)
 {
-       return scnprintf(buf, PAGE_SIZE, "%d\n", sdeb_tur_ms_to_ready);
+       return sysfs_emit(buf, "%d\n", sdeb_tur_ms_to_ready);
 }
 static DRIVER_ATTR_RO(tur_ms_to_ready);

--
1.8.3.1
