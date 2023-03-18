Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE526BF751
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 02:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCRB5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 21:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCRB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 21:57:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751D14A1F4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 18:57:16 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdkZF03kRznXgF;
        Sat, 18 Mar 2023 09:54:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 18 Mar
 2023 09:57:13 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 3/5] ubi: Add six fault injection type for testing
Date:   Sat, 18 Mar 2023 09:56:19 +0800
Message-ID: <20230318015621.1408243-4-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
References: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds six fault injection type for testing to cover the
abnormal path of the UBI driver.

Inject the following faults when the UBI reads the LEB:
 +----------------------------+-----------------------------------+
 |    Interface name          |       emulate behavior            |
 +----------------------------+-----------------------------------+
 |  emulate_eccerr            | ECC error                         |
 +----------------------------+-----------------------------------+
 |  emulate_read_failure      | read failure                      |
 |----------------------------+-----------------------------------+
 |  emulate_io_ff             | read content as all FF            |
 |----------------------------+-----------------------------------+
 |  emulate_io_ff_bitflips    | content FF with MTD err reported  |
 +----------------------------+-----------------------------------+
 |  emulate_bad_hdr           | bad leb header                    |
 |----------------------------+-----------------------------------+
 |  emulate_bad_hdr_ebadmsg   | bad header with ECC err           |
 +----------------------------+-----------------------------------+

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c |  30 ++++++++++
 drivers/mtd/ubi/debug.h | 123 +++++++++++++++++++++++++++++++++++-----
 drivers/mtd/ubi/io.c    |  91 +++++++++++++++++++++++++----
 drivers/mtd/ubi/ubi.h   |  31 ++++++----
 4 files changed, 240 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 9c92bd59b639..0c58cbabe9fc 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -13,10 +13,16 @@
 #include <linux/fault-inject.h>
 
 #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
+static DECLARE_FAULT_ATTR(fault_eccerr_attr);
 static DECLARE_FAULT_ATTR(fault_bitflips_attr);
+static DECLARE_FAULT_ATTR(fault_read_failure_attr);
 static DECLARE_FAULT_ATTR(fault_write_failure_attr);
 static DECLARE_FAULT_ATTR(fault_erase_failure_attr);
 static DECLARE_FAULT_ATTR(fault_power_cut_attr);
+static DECLARE_FAULT_ATTR(fault_io_ff_attr);
+static DECLARE_FAULT_ATTR(fault_io_ff_bitflips_attr);
+static DECLARE_FAULT_ATTR(fault_bad_hdr_attr);
+static DECLARE_FAULT_ATTR(fault_bad_hdr_ebadmsg_attr);
 
 #define FAIL_ACTION(name, fault_attr)			\
 bool should_fail_##name(void)				\
@@ -24,10 +30,16 @@ bool should_fail_##name(void)				\
 	return should_fail(&fault_attr, 1);		\
 }
 
+FAIL_ACTION(eccerr,		fault_eccerr_attr)
 FAIL_ACTION(bitflips,		fault_bitflips_attr)
+FAIL_ACTION(read_failure,	fault_read_failure_attr)
 FAIL_ACTION(write_failure,	fault_write_failure_attr)
 FAIL_ACTION(erase_failure,	fault_erase_failure_attr)
 FAIL_ACTION(power_cut,		fault_power_cut_attr)
+FAIL_ACTION(io_ff,		fault_io_ff_attr)
+FAIL_ACTION(io_ff_bitflips,	fault_io_ff_bitflips_attr)
+FAIL_ACTION(bad_hdr,		fault_bad_hdr_attr)
+FAIL_ACTION(bad_hdr_ebadmsg,	fault_bad_hdr_ebadmsg_attr)
 #endif
 
 
@@ -245,9 +257,15 @@ static void dfs_create_fault_entry(struct dentry *parent)
 		return;
 	}
 
+	fault_create_debugfs_attr("emulate_eccerr", dir,
+				  &fault_eccerr_attr);
+
 	fault_create_debugfs_attr("emulate_bitflips", dir,
 				  &fault_bitflips_attr);
 
+	fault_create_debugfs_attr("emulate_read_failure", dir,
+				  &fault_read_failure_attr);
+
 	fault_create_debugfs_attr("emulate_write_failure", dir,
 				  &fault_write_failure_attr);
 
@@ -256,6 +274,18 @@ static void dfs_create_fault_entry(struct dentry *parent)
 
 	fault_create_debugfs_attr("emulate_power_cut", dir,
 				  &fault_power_cut_attr);
+
+	fault_create_debugfs_attr("emulate_io_ff", dir,
+				  &fault_io_ff_attr);
+
+	fault_create_debugfs_attr("emulate_io_ff_bitflips", dir,
+				  &fault_io_ff_bitflips_attr);
+
+	fault_create_debugfs_attr("emulate_bad_hdr", dir,
+				  &fault_bad_hdr_attr);
+
+	fault_create_debugfs_attr("emulate_bad_hdr_ebadmsg", dir,
+				  &fault_bad_hdr_ebadmsg_attr);
 }
 #endif
 
diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
index 2486fcab4205..8272c2b93dd4 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -13,13 +13,34 @@
  * precisely control the type and process of fault injection.
  */
 /* Emulate bit-flips */
-#define MASK_BITFLIPS		(1 << 0)
-/* Emulates -EIO during write/erase */
-#define MASK_WRITE_FAILURE	(1 << 1)
-#define MASK_ERASE_FAILURE	(1 << 2)
+#define MASK_BITFLIPS			(1 << 0)
+/* Emulate ecc error */
+#define MASK_ECCERR			(1 << 1)
+/* Emulates -EIO during data read */
+#define MASK_READ_FAILURE		(1 << 2)
+#define MASK_READ_FAILURE_EC		(1 << 3)
+#define MASK_READ_FAILURE_VID		(1 << 4)
+/* Emulates -EIO during data write */
+#define MASK_WRITE_FAILURE		(1 << 5)
+/* Emulates -EIO during erase a PEB*/
+#define MASK_ERASE_FAILURE		(1 << 6)
 /* Emulate a power cut when writing EC/VID header */
-#define MASK_POWER_CUT_EC	(1 << 3)
-#define MASK_POWER_CUT_VID	(1 << 4)
+#define MASK_POWER_CUT_EC		(1 << 7)
+#define MASK_POWER_CUT_VID		(1 << 8)
+/* Emulate a power cut when writing data*/
+#define MASK_POWER_CUT_DATA		(1 << 9)
+/* Return UBI_IO_FF when reading EC/VID header */
+#define MASK_IO_FF_EC			(1 << 10)
+#define MASK_IO_FF_VID			(1 << 11)
+/* Return UBI_IO_FF_BITFLIPS when reading EC/VID header */
+#define MASK_IO_FF_BITFLIPS_EC		(1 << 12)
+#define MASK_IO_FF_BITFLIPS_VID		(1 << 13)
+/* Return UBI_IO_BAD_HDR when reading EC/VID header */
+#define MASK_BAD_HDR_EC			(1 << 14)
+#define MASK_BAD_HDR_VID		(1 << 15)
+/* Return UBI_IO_BAD_HDR_EBADMSG when reading EC/VID header */
+#define MASK_BAD_HDR_EBADMSG_EC		(1 << 16)
+#define MASK_BAD_HDR_EBADMSG_VID	(1 << 17)
 
 void ubi_dump_flash(struct ubi_device *ubi, int pnum, int offset, int len);
 void ubi_dump_ec_hdr(const struct ubi_ec_hdr *ec_hdr);
@@ -79,10 +100,16 @@ static inline int ubi_dbg_is_bgt_disabled(const struct ubi_device *ubi)
 
 #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
 
+extern bool should_fail_eccerr(void);
 extern bool should_fail_bitflips(void);
+extern bool should_fail_read_failure(void);
 extern bool should_fail_write_failure(void);
 extern bool should_fail_erase_failure(void);
 extern bool should_fail_power_cut(void);
+extern bool should_fail_io_ff(void);
+extern bool should_fail_io_ff_bitflips(void);
+extern bool should_fail_bad_hdr(void);
+extern bool should_fail_bad_hdr_ebadmsg(void);
 
 /**
  * ubi_dbg_is_bitflip - if it is time to emulate a bit-flip.
@@ -97,6 +124,34 @@ static inline bool ubi_dbg_is_bitflip(const struct ubi_device *ubi)
 	return false;
 }
 
+/**
+ * ubi_dbg_is_eccerr - if it is time to emulate ECC error.
+ * @ubi: UBI device description object
+ *
+ * Returns true if a ECC error should be emulated, otherwise returns false.
+ */
+static inline bool ubi_dbg_is_eccerr(const struct ubi_device *ubi)
+{
+	if (ubi->dbg.emulate_failures & MASK_ECCERR)
+		return should_fail_eccerr();
+	return false;
+}
+
+/**
+ * ubi_dbg_is_read_failure - if it is time to emulate a read failure.
+ * @ubi: UBI device description object
+ *
+ * Returns true if a read failure should be emulated, otherwise returns
+ * false.
+ */
+static inline bool ubi_dbg_is_read_failure(const struct ubi_device *ubi,
+					   unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_read_failure();
+	return false;
+}
+
 /**
  * ubi_dbg_is_write_failure - if it is time to emulate a write failure.
  * @ubi: UBI device description object
@@ -139,28 +194,70 @@ static inline bool ubi_dbg_power_cut(const struct ubi_device *ubi,
 	return false;
 }
 
-#else /* CONFIG_MTD_UBI_FAULT_INJECTION */
-
-static inline bool ubi_dbg_is_bitflip(const struct ubi_device *ubi)
+/**
+ * ubi_dbg_is_ff - if it is time to emulate that read region is only 0xFF.
+ * @ubi: UBI device description object
+ *
+ * Returns true if read region should be emulated 0xFF, otherwise
+ * returns false.
+ */
+static inline bool ubi_dbg_is_ff(const struct ubi_device *ubi,
+				 unsigned int caller)
 {
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_io_ff();
 	return false;
 }
 
-static inline bool ubi_dbg_is_write_failure(const struct ubi_device *ubi)
+/**
+ * ubi_dbg_is_ff_bitflips - if it is time to emulate that read region is only 0xFF
+ * with error reported by the MTD driver
+ *
+ * @ubi: UBI device description object
+ *
+ * Returns true if read region should be emulated 0xFF and error
+ * reported by the MTD driver, otherwise returns false.
+ */
+static inline bool ubi_dbg_is_ff_bitflips(const struct ubi_device *ubi,
+					  unsigned int caller)
 {
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_io_ff_bitflips();
 	return false;
 }
 
-static inline bool ubi_dbg_is_erase_failure(const struct ubi_device *ubi)
+/**
+ * ubi_dbg_is_bad_hdr - if it is time to emulate a bad header
+ * @ubi: UBI device description object
+ *
+ * Returns true if a bad header error should be emulated, otherwise
+ * returns false.
+ */
+static inline bool ubi_dbg_is_bad_hdr(const struct ubi_device *ubi,
+				      unsigned int caller)
 {
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_bad_hdr();
 	return false;
 }
 
-static inline bool ubi_dbg_power_cut(const struct ubi_device *ubi,
-				     unsigned int caller)
+/**
+ * ubi_dbg_is_bad_hdr_ebadmsg - if it is time to emulate a bad header with
+ * ECC error.
+ *
+ * @ubi: UBI device description object
+ *
+ * Returns true if a bad header with ECC error should be emulated, otherwise
+ * returns false.
+ */
+static inline bool ubi_dbg_is_bad_hdr_ebadmsg(const struct ubi_device *ubi,
+					      unsigned int caller)
 {
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_bad_hdr_ebadmsg();
 	return false;
 }
+
 #endif
 
 static inline int ubi_dbg_chk_io(const struct ubi_device *ubi)
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 906ad0811d52..e64914c3cc8d 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -192,11 +192,24 @@ int ubi_io_read(const struct ubi_device *ubi, void *buf, int pnum, int offset,
 		}
 	} else {
 		ubi_assert(len == read);
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
+		if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE)) {
+			ubi_warn(ubi, "cannot read %d bytes from PEB %d:%d (emulated)",
+				 len, pnum, offset);
+			return -EIO;
+		}
+
+		if (ubi_dbg_is_eccerr(ubi)) {
+			ubi_warn(ubi, "ECC error (emulated) while reading %d bytes from PEB %d:%d, read %zd bytes",
+				 len, pnum, offset, read);
+			return -EBADMSG;
+		}
 
 		if (ubi_dbg_is_bitflip(ubi)) {
 			dbg_gen("bit-flip (emulated)");
 			err = UBI_IO_BITFLIPS;
 		}
+#endif
 	}
 
 	return err;
@@ -259,14 +272,14 @@ int ubi_io_write(struct ubi_device *ubi, const void *buf, int pnum, int offset,
 		if (err)
 			return err;
 	}
-
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
 	if (ubi_dbg_is_write_failure(ubi)) {
 		ubi_err(ubi, "cannot write %d bytes to PEB %d:%d (emulated)",
 			len, pnum, offset);
 		dump_stack();
 		return -EIO;
 	}
-
+#endif
 	addr = (loff_t)pnum * ubi->peb_size + offset;
 	err = mtd_write(ubi->mtd, addr, len, &written, buf);
 	if (err) {
@@ -339,12 +352,12 @@ static int do_sync_erase(struct ubi_device *ubi, int pnum)
 	err = ubi_self_check_all_ff(ubi, pnum, 0, ubi->peb_size);
 	if (err)
 		return err;
-
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
 	if (ubi_dbg_is_erase_failure(ubi)) {
 		ubi_err(ubi, "cannot erase PEB %d (emulated)", pnum);
 		return -EIO;
 	}
-
+#endif
 	return 0;
 }
 
@@ -782,7 +795,36 @@ int ubi_io_read_ec_hdr(struct ubi_device *ubi, int pnum,
 	 * If there was %-EBADMSG, but the header CRC is still OK, report about
 	 * a bit-flip to force scrubbing on this PEB.
 	 */
-	return read_err ? UBI_IO_BITFLIPS : 0;
+	if (read_err)
+		return UBI_IO_BITFLIPS;
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
+	if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE_EC)) {
+		ubi_warn(ubi, "cannot read EC header from PEB %d(emulated)",
+			 pnum);
+		return -EIO;
+	}
+
+	if (ubi_dbg_is_ff(ubi, MASK_IO_FF_EC)) {
+		ubi_warn(ubi, "bit-all-ff (emulated)");
+		return UBI_IO_FF;
+	}
+
+	if (ubi_dbg_is_ff_bitflips(ubi, MASK_IO_FF_BITFLIPS_EC)) {
+		ubi_warn(ubi, "bit-all-ff with error reported by MTD driver (emulated)");
+		return UBI_IO_FF_BITFLIPS;
+	}
+
+	if (ubi_dbg_is_bad_hdr(ubi, MASK_BAD_HDR_EC)) {
+		ubi_warn(ubi, "bad_hdr (emulated)");
+		return UBI_IO_BAD_HDR;
+	}
+
+	if (ubi_dbg_is_bad_hdr_ebadmsg(ubi, MASK_BAD_HDR_EBADMSG_EC)) {
+		ubi_warn(ubi, "bad_hdr with ECC error (emulated)");
+		return UBI_IO_BAD_HDR_EBADMSG;
+	}
+#endif
+	return 0;
 }
 
 /**
@@ -820,13 +862,13 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int pnum,
 	err = self_check_ec_hdr(ubi, pnum, ec_hdr);
 	if (err)
 		return err;
-
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
 	if (ubi_dbg_power_cut(ubi, MASK_POWER_CUT_EC)) {
 		ubi_warn(ubi, "XXXXX emulating a power cut when writing EC header XXXXX");
 		ubi_ro_mode(ubi);
 		return -EROFS;
 	}
-
+#endif
 	err = ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
 	return err;
 }
@@ -1032,7 +1074,36 @@ int ubi_io_read_vid_hdr(struct ubi_device *ubi, int pnum,
 		return -EINVAL;
 	}
 
-	return read_err ? UBI_IO_BITFLIPS : 0;
+	if (read_err)
+		return UBI_IO_BITFLIPS;
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
+	if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE_VID)) {
+		ubi_warn(ubi, "cannot read VID header from PEB %d(emulated)",
+			 pnum);
+		return -EIO;
+	}
+
+	if (ubi_dbg_is_ff(ubi, MASK_IO_FF_VID)) {
+		ubi_warn(ubi, "bit-all-ff (emulated)\n");
+		return UBI_IO_FF;
+	}
+
+	if (ubi_dbg_is_ff_bitflips(ubi, MASK_IO_FF_BITFLIPS_VID)) {
+		ubi_warn(ubi, "bit-all-ff with error reported by MTD driver (emulated)\n");
+		return UBI_IO_FF_BITFLIPS;
+	}
+
+	if (ubi_dbg_is_bad_hdr(ubi, MASK_BAD_HDR_VID)) {
+		ubi_warn(ubi, "bad_hdr (emulated)\n");
+		return UBI_IO_BAD_HDR;
+	}
+
+	if (ubi_dbg_is_bad_hdr_ebadmsg(ubi, MASK_BAD_HDR_EBADMSG_VID)) {
+		ubi_warn(ubi, "bad_hdr with ECC error (emulated)\n");
+		return UBI_IO_BAD_HDR_EBADMSG;
+	}
+#endif
+	return 0;
 }
 
 /**
@@ -1073,13 +1144,13 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
 	err = self_check_vid_hdr(ubi, pnum, vid_hdr);
 	if (err)
 		return err;
-
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
 	if (ubi_dbg_power_cut(ubi, MASK_POWER_CUT_VID)) {
 		ubi_warn(ubi, "XXXXX emulating a power cut when writing VID header XXXXX");
 		ubi_ro_mode(ubi);
 		return -EROFS;
 	}
-
+#endif
 	err = ubi_io_write(ubi, p, pnum, ubi->vid_hdr_aloffset,
 			   ubi->vid_hdr_alsize);
 	return err;
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index e20e9a6f9c05..7ff55a74b313 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -1107,18 +1107,6 @@ static inline int ubi_io_read_data(const struct ubi_device *ubi, void *buf,
 	return ubi_io_read(ubi, buf, pnum, offset + ubi->leb_start, len);
 }
 
-/*
- * This function is equivalent to 'ubi_io_write()', but @offset is relative to
- * the beginning of the logical eraseblock, not to the beginning of the
- * physical eraseblock.
- */
-static inline int ubi_io_write_data(struct ubi_device *ubi, const void *buf,
-				    int pnum, int offset, int len)
-{
-	ubi_assert(offset >= 0);
-	return ubi_io_write(ubi, buf, pnum, offset + ubi->leb_start, len);
-}
-
 /**
  * ubi_ro_mode - switch to read-only mode.
  * @ubi: UBI device description object
@@ -1132,6 +1120,25 @@ static inline void ubi_ro_mode(struct ubi_device *ubi)
 	}
 }
 
+/*
+ * This function is equivalent to 'ubi_io_write()', but @offset is relative to
+ * the beginning of the logical eraseblock, not to the beginning of the
+ * physical eraseblock.
+ */
+static inline int ubi_io_write_data(struct ubi_device *ubi, const void *buf,
+				    int pnum, int offset, int len)
+{
+	ubi_assert(offset >= 0);
+#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
+	if (ubi_dbg_power_cut(ubi, MASK_POWER_CUT_DATA)) {
+		ubi_warn(ubi, "XXXXX emulating a power cut when writing data XXXXX");
+		ubi_ro_mode(ubi);
+		return -EROFS;
+	}
+#endif
+	return ubi_io_write(ubi, buf, pnum, offset + ubi->leb_start, len);
+}
+
 /**
  * vol_id2idx - get table index by volume ID.
  * @ubi: UBI device description object
-- 
2.31.1

