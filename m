Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573AE60C671
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiJYIbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiJYIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:31:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EE5246A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:30:59 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxQ6Y2WT5zpVtM;
        Tue, 25 Oct 2022 16:27:33 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:30:57 +0800
Received: from huawei.com (10.175.127.227) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 16:30:57 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <patchwork@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <miaoxie@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <yuehaibing@huawei.com>, <johnny.chenyi@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [PATCH -next] ubi: fastmap: Add fastmap control support for module parameter
Date:   Tue, 25 Oct 2022 16:52:49 +0800
Message-ID: <20221025085249.256285-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UBI driver can use the IOCTL to disable the fastmap after the
mainline 669d204469c4 ("ubi: fastmap: Add fastmap control support
for 'UBI_IOCATT' ioctl"). To destroy the fastmap on a old image,
we need to reattach the device in user space.

However, if the UBI driver build in kernel and the UBI volume is
the root partition, the UBI device cannot be reattached in user
space. To disable fastmap in this case, the UBI must provide the
kernel cmdline parameters to disable fastmap during attach.

This patch add 'enable_fm' as 5th module init parameter of mtd=xx to
control fastmap enable or not. When the value is 0, fastmap will not
create and existed fastmap will destroyed for the given ubi device.
Default value is 0.

To enable or disable fastmap during module loading, fm_autoconvert
must be set to non-zero.

+-----------------+---------------+---------------------------+
|        \        |  enable_fm=0  |  enable_fm=1              |
+-----------------+---------------+---------------------------+
|fm_autoconvert=Y |  disable fm   |  enable fm                |
+---------------------------------+---------------------------+
|fm_autoconvert=N |  disable fm   | Enable fastmap if fastmap |
|                 |               | exists on the old image   |
+-------------------------------------------------------------+

Example:
  # - Attach mtd1 to ubi1, disable fastmap, mtd2 to ubi2, enable
      fastmap.
  # modprobe ubi mtd=1,0,0,1,0 mtd=2,0,0,2,1 fm_autoconvert=1

  # - If 5th parameter is not specified, the value is 0, fastmap is
      disable
  # modprobe ubi mtd=1 fm_autoconvert=1

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216623
Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/build.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index a901f8edfa41..0393cb794a9a 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -35,7 +35,7 @@
 #define MTD_PARAM_LEN_MAX 64
 
 /* Maximum number of comma-separated items in the 'mtd=' parameter */
-#define MTD_PARAM_MAX_COUNT 4
+#define MTD_PARAM_MAX_COUNT 5
 
 /* Maximum value for the number of bad PEBs per 1024 PEBs */
 #define MAX_MTD_UBI_BEB_LIMIT 768
@@ -53,12 +53,14 @@
  * @ubi_num: UBI number
  * @vid_hdr_offs: VID header offset
  * @max_beb_per1024: maximum expected number of bad PEBs per 1024 PEBs
+ * @enable_fm: enable fastmap when value is non-zero
  */
 struct mtd_dev_param {
 	char name[MTD_PARAM_LEN_MAX];
 	int ubi_num;
 	int vid_hdr_offs;
 	int max_beb_per1024;
+	int enable_fm;
 };
 
 /* Numbers of elements set in the @mtd_dev_param array */
@@ -1248,7 +1250,7 @@ static int __init ubi_init(void)
 		mutex_lock(&ubi_devices_mutex);
 		err = ubi_attach_mtd_dev(mtd, p->ubi_num,
 					 p->vid_hdr_offs, p->max_beb_per1024,
-					 false);
+					 p->enable_fm == 0 ? true : false);
 		mutex_unlock(&ubi_devices_mutex);
 		if (err < 0) {
 			pr_err("UBI error: cannot attach mtd%d\n",
@@ -1427,7 +1429,7 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 		int err = kstrtoint(token, 10, &p->max_beb_per1024);
 
 		if (err) {
-			pr_err("UBI error: bad value for max_beb_per1024 parameter: %s",
+			pr_err("UBI error: bad value for max_beb_per1024 parameter: %s\n",
 			       token);
 			return -EINVAL;
 		}
@@ -1438,13 +1440,25 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 		int err = kstrtoint(token, 10, &p->ubi_num);
 
 		if (err) {
-			pr_err("UBI error: bad value for ubi_num parameter: %s",
+			pr_err("UBI error: bad value for ubi_num parameter: %s\n",
 			       token);
 			return -EINVAL;
 		}
 	} else
 		p->ubi_num = UBI_DEV_NUM_AUTO;
 
+	token = tokens[4];
+	if (token) {
+		int err = kstrtoint(token, 10, &p->enable_fm);
+
+		if (err) {
+			pr_err("UBI error: bad value for enable_fm parameter: %s\n",
+				token);
+			return -EINVAL;
+		}
+	} else
+		p->enable_fm = 0;
+
 	mtd_devs += 1;
 	return 0;
 }
@@ -1457,11 +1471,13 @@ MODULE_PARM_DESC(mtd, "MTD devices to attach. Parameter format: mtd=<name|num|pa
 		      "Optional \"max_beb_per1024\" parameter specifies the maximum expected bad eraseblock per 1024 eraseblocks. (default value ("
 		      __stringify(CONFIG_MTD_UBI_BEB_LIMIT) ") if 0)\n"
 		      "Optional \"ubi_num\" parameter specifies UBI device number which have to be assigned to the newly created UBI device (assigned automatically by default)\n"
+		      "Optional \"enable_fm\" parameter determines whether to enable fastmap during attach. If the value is non-zero, fastmap is enabled. Default value is 0.\n"
 		      "\n"
 		      "Example 1: mtd=/dev/mtd0 - attach MTD device /dev/mtd0.\n"
 		      "Example 2: mtd=content,1984 mtd=4 - attach MTD device with name \"content\" using VID header offset 1984, and MTD device number 4 with default VID header offset.\n"
 		      "Example 3: mtd=/dev/mtd1,0,25 - attach MTD device /dev/mtd1 using default VID header offset and reserve 25*nand_size_in_blocks/1024 erase blocks for bad block handling.\n"
 		      "Example 4: mtd=/dev/mtd1,0,0,5 - attach MTD device /dev/mtd1 to UBI 5 and using default values for the other fields.\n"
+		      "example 5: mtd=1,0,0,5 mtd=2,0,0,6,1 - attach MTD device /dev/mtd1 to UBI 5 and disable fastmap; attach MTD device /dev/mtd2 to UBI 6 and enable fastmap.(only works when fastmap is enabled and fm_autoconvert=Y).\n"
 		      "\t(e.g. if the NAND *chipset* has 4096 PEB, 100 will be reserved for this UBI device).");
 #ifdef CONFIG_MTD_UBI_FASTMAP
 module_param(fm_autoconvert, bool, 0644);
-- 
2.31.1

