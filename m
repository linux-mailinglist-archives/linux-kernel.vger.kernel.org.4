Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52AC65905C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiL2SZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiL2SYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DC5813F80
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F37AD7;
        Thu, 29 Dec 2022 10:25:09 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F18473F71A;
        Thu, 29 Dec 2022 10:24:25 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 17/17] firmware: arm_scmi: Add per-channel Raw injection support
Date:   Thu, 29 Dec 2022 18:22:53 +0000
Message-Id: <20221229182253.948175-18-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229182253.948175-1-cristian.marussi@arm.com>
References: <20221229182253.948175-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system configured with multiple transport channels, expose a few
additional debugfs per-channel entries to allow a user to explicitly select
which transport channel to use for the SCMI message injection.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi-raw |  43 +++++++
 drivers/firmware/arm_scmi/driver.c         |  30 ++++-
 drivers/firmware/arm_scmi/protocols.h      |   3 +
 drivers/firmware/arm_scmi/raw_mode.c       | 142 ++++++++++++++++++---
 drivers/firmware/arm_scmi/raw_mode.h       |   3 +-
 5 files changed, 201 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/ABI/testing/debugfs-scmi-raw
index 45817d465b1f..5468ec08c084 100644
--- a/Documentation/ABI/testing/debugfs-scmi-raw
+++ b/Documentation/ABI/testing/debugfs-scmi-raw
@@ -64,3 +64,46 @@ Description:	SCMI Raw stack reset facility; writing a value to this entry
 		Can be used to reset and clean the SCMI Raw stack between to
 		different test-run.
 Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw synchronous message injection/snooping facility; write
+		a complete SCMI synchronous command message (header included)
+		in little-endian binary format to have it sent to the configured
+		backend SCMI server for instance <n> through the <m> transport
+		channel.
+		Any subsequently received response can be read from this same
+		entry if it arrived on channel <m> within the configured
+		timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+		Note that these per-channel entries rooted at <..>/channels
+		exist only if the transport is configured to have more than
+		one channel.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message_async
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw asynchronous message injection/snooping facility; write
+		a complete SCMI asynchronous command message (header included)
+		in little-endian binary format to have it sent to the configured
+		backend SCMI server for instance <n> through the <m> transport
+		channel.
+		Any subsequently received response can be read from this same
+		entry if it arrived on channel <m> within the configured
+		timeout.
+		Any additional delayed response received afterwards can be read
+		from this same entry too if it arrived within the configured
+		timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+		Note that these per-channel entries rooted at <..>/channels
+		exist only if the transport is configured to have more than
+		one channel.
+Users:		Debugging, any userspace test suite
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index da60f218aed9..2d7e669d6dc4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -42,6 +42,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
+#define SCMI_MAX_CHANNELS	256
+
 static DEFINE_IDA(scmi_id);
 
 static DEFINE_IDR(scmi_protocols);
@@ -127,6 +129,8 @@ struct scmi_debug_info {
  * @handle: Instance of SCMI handle to send to clients
  * @tx_minfo: Universal Transmit Message management info
  * @rx_minfo: Universal Receive Message management info
+ * @channels: The list of configured channels.
+ * @num_chans: Number of channels described in @channels
  * @tx_idr: IDR object to map protocol id to Tx channel info pointer
  * @rx_idr: IDR object to map protocol id to Rx channel info pointer
  * @protocols: IDR for protocols' instance descriptors initialized for
@@ -162,6 +166,8 @@ struct scmi_info {
 	struct scmi_handle handle;
 	struct scmi_xfers_info tx_minfo;
 	struct scmi_xfers_info rx_minfo;
+	unsigned int channels[SCMI_MAX_CHANNELS];
+	int num_chans;
 	struct idr tx_idr;
 	struct idr rx_idr;
 	struct idr protocols;
@@ -660,6 +666,7 @@ void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
 	xfer->flags &= ~SCMI_XFER_FLAG_IS_RAW;
+	xfer->flags &= ~SCMI_XFER_FLAG_CHAN_SET;
 	return __scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
@@ -896,7 +903,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
 		xfer->hdr.seq = MSG_XTRACT_TOKEN(msg_hdr);
-		scmi_raw_message_report(info->raw, xfer, SCMI_RAW_NOTIF_QUEUE);
+		scmi_raw_message_report(info->raw, xfer, SCMI_RAW_NOTIF_QUEUE,
+					cinfo->id);
 	}
 
 	__scmi_xfer_put(minfo, xfer);
@@ -955,7 +963,9 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		 * poll loop.
 		 */
 		if (!xfer->hdr.poll_completion)
-			scmi_raw_message_report(info->raw, xfer, SCMI_RAW_REPLY_QUEUE);
+			scmi_raw_message_report(info->raw, xfer,
+						SCMI_RAW_REPLY_QUEUE,
+						cinfo->id);
 	}
 
 	scmi_xfer_command_release(info, xfer);
@@ -1078,7 +1088,8 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					handle_to_scmi_info(cinfo->handle);
 
 				scmi_raw_message_report(info->raw, xfer,
-							SCMI_RAW_REPLY_QUEUE);
+							SCMI_RAW_REPLY_QUEUE,
+							cinfo->id);
 			}
 		}
 	} else {
@@ -2339,6 +2350,12 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 		return ret;
 	}
 
+	/* Keep an alternative list of TX channel numbers */
+	if (tx) {
+		info->channels[info->num_chans] = prot_id;
+		info->num_chans++;
+	}
+
 	if (tx && is_polling_required(cinfo, info->desc)) {
 		if (is_transport_polling_capable(info->desc))
 			dev_info(&tdev->dev,
@@ -2465,6 +2482,9 @@ static void scmi_cleanup_txrx_channels(struct scmi_info *info)
 	scmi_cleanup_channels(info, &info->tx_idr);
 
 	scmi_cleanup_channels(info, &info->rx_idr);
+
+	info->num_chans = 0;
+	memset(info->channels, 0x00, sizeof(info->channels));
 }
 
 static int scmi_bus_notifier(struct notifier_block *nb,
@@ -2702,7 +2722,9 @@ static int scmi_probe(struct platform_device *pdev)
 		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) && info->dbg) {
 			info->raw = scmi_raw_mode_init(handle,
 						       info->dbg->top_dentry,
-						       info->id, info->desc,
+						       info->id, info->channels,
+						       info->num_chans,
+						       info->desc,
 						       info->tx_minfo.max_msg);
 			if (IS_ERR(info->raw)) {
 				dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index b5941beb8b03..78e1a01eb656 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -138,6 +138,9 @@ struct scmi_xfer {
 	int state;
 #define SCMI_XFER_FLAG_IS_RAW	BIT(0)
 #define SCMI_XFER_IS_RAW(x)	((x)->flags & SCMI_XFER_FLAG_IS_RAW)
+#define SCMI_XFER_FLAG_CHAN_SET	BIT(1)
+#define SCMI_XFER_IS_CHAN_SET(x)	\
+	((x)->flags & SCMI_XFER_FLAG_CHAN_SET)
 	int flags;
 	/* A lock to protect state and busy fields */
 	spinlock_t lock;
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index b2dff852e4b4..8a5967ec171f 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -37,10 +37,17 @@
  * which in turn is rooted under the corresponding underlying  SCMI instance.
  *
  * /sys/kernel/debug/scmi/
- * |-- 0
+ * `-- 0
  *     |-- atomic_threshold_us
  *     |-- instance_name
  *     |-- raw
+ *     |   |-- channels
+ *     |   |   |-- 0x10
+ *     |   |   |   |-- message
+ *     |   |   |   `-- message_async
+ *     |   |   `-- 0x13
+ *     |   |       |-- message
+ *     |   |       `-- message_async
  *     |   |-- errors
  *     |   |-- message
  *     |   |-- message_async
@@ -65,6 +72,15 @@
  *	     to be read; this is useful at test-suite start/stop to get
  *	     rid of any unread messages from the previous run.
  *
+ * with the per-channel entries rooted at /channels being present only on a
+ * system where multiple transport channels have been configured.
+ *
+ * Such per-channel entries can be used to explicitly choose a specific channel
+ * for SCMI bare message injection, in contrast with the general entries above
+ * where, instead, the selection of the proper channel to use is automatically
+ * performed based the protocol embedded in the injected message and on how the
+ * transport is configured on the system.
+ *
  * Note that other common general entries are available under transport/ to let
  * the user applications properly make up their expectations in terms of
  * timeouts and message characteristics.
@@ -140,6 +156,7 @@ struct scmi_raw_queue {
  * @desc: Pointer to the transport descriptor to use
  * @tx_max_msg: Maximum number of concurrent TX in-flight messages
  * @q: An array of Raw queue descriptors
+ * @queues_idr: An idr mapping opional additional per-channel queues
  * @free_waiters: Head of freelist for unused waiters
  * @free_mtx: A mutex to protect the waiters freelist
  * @active_waiters: Head of list for currently active and used waiters
@@ -159,6 +176,7 @@ struct scmi_raw_mode_info {
 	const struct scmi_desc *desc;
 	int tx_max_msg;
 	struct scmi_raw_queue *q[SCMI_RAW_MAX_QUEUE];
+	struct idr queues_idr;
 	struct list_head free_waiters;
 	/* Protect free_waiters list */
 	struct mutex free_mtx;
@@ -208,6 +226,8 @@ struct scmi_raw_buffer {
  * struct scmi_dbg_raw_data  - Structure holding data needed by the debugfs
  * layer
  *
+ * @chan_id: The preferred channel to use: if zero the channel is automatically
+ *	     selected based on protocol.
  * @raw: A reference to the Raw instance.
  * @tx: A message buffer used to collect TX message on write.
  * @tx_size: The effective size of the TX message.
@@ -216,6 +236,7 @@ struct scmi_raw_buffer {
  * @rx_size: The effective size of the RX message.
  */
 struct scmi_dbg_raw_data {
+	u8 chan_id;
 	struct scmi_raw_mode_info *raw;
 	struct scmi_msg tx;
 	size_t tx_size;
@@ -224,6 +245,16 @@ struct scmi_dbg_raw_data {
 	size_t rx_size;
 };
 
+static struct scmi_raw_queue *
+scmi_raw_queue_select(struct scmi_raw_mode_info *raw, unsigned int idx,
+		      unsigned int chan_id)
+{
+	if (!chan_id)
+		return raw->q[idx];
+
+	return idr_find(&raw->queues_idr, chan_id);
+}
+
 static struct scmi_raw_buffer *scmi_raw_buffer_get(struct scmi_raw_queue *q)
 {
 	unsigned long flags;
@@ -563,6 +594,8 @@ static int scmi_xfer_raw_get_init(struct scmi_raw_mode_info *raw, void *buf,
  *
  * @raw: A reference to the Raw instance.
  * @xfer: The xfer to send
+ * @chan_id: The channel ID to use, if zero the channels is automatically
+ *	     selected based on the protocol used.
  * @async: A flag stating if an asynchronous command is required.
  *
  * This function send a previously built raw xfer using an appropriate channel
@@ -576,14 +609,20 @@ static int scmi_xfer_raw_get_init(struct scmi_raw_mode_info *raw, void *buf,
  * Return: 0 on Success
  */
 static int scmi_do_xfer_raw_start(struct scmi_raw_mode_info *raw,
-				  struct scmi_xfer *xfer, bool async)
+				  struct scmi_xfer *xfer, u8 chan_id,
+				  bool async)
 {
 	int ret;
 	struct scmi_chan_info *cinfo;
 	struct scmi_xfer_raw_waiter *rw;
 	struct device *dev = raw->handle->dev;
 
-	cinfo = scmi_xfer_raw_channel_get(raw->handle, xfer->hdr.protocol_id);
+	if (!chan_id)
+		chan_id = xfer->hdr.protocol_id;
+	else
+		xfer->flags |= SCMI_XFER_FLAG_CHAN_SET;
+
+	cinfo = scmi_xfer_raw_channel_get(raw->handle, chan_id);
 	if (IS_ERR(cinfo))
 		return PTR_ERR(cinfo);
 
@@ -630,12 +669,13 @@ static int scmi_do_xfer_raw_start(struct scmi_raw_mode_info *raw,
  * @buf: A buffer containing the whole SCMI message to send (including the
  *	 header) in little-endian binary format.
  * @len: Length of the message in @buf.
+ * @chan_id: The channel ID to use.
  * @async: A flag stating if an asynchronous command is required.
  *
  * Return: 0 on Success
  */
 static int scmi_raw_message_send(struct scmi_raw_mode_info *raw,
-				 void *buf, size_t len, bool async)
+				 void *buf, size_t len, u8 chan_id, bool async)
 {
 	int ret;
 	struct scmi_xfer *xfer;
@@ -644,7 +684,7 @@ static int scmi_raw_message_send(struct scmi_raw_mode_info *raw,
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer_raw_start(raw, xfer, async);
+	ret = scmi_do_xfer_raw_start(raw, xfer, chan_id, async);
 	if (ret)
 		scmi_xfer_raw_put(raw->handle, xfer);
 
@@ -687,18 +727,23 @@ scmi_raw_message_dequeue(struct scmi_raw_queue *q, bool o_nonblock)
  * @len: Length of @buf.
  * @size: The effective size of the message copied into @buf
  * @idx: The index of the queue to pick the next queued message from.
+ * @chan_id: The channel ID to use.
  * @o_nonblock: A flag to request a non-blocking message dequeue.
  *
  * Return: 0 on Success
  */
 static int scmi_raw_message_receive(struct scmi_raw_mode_info *raw,
 				    void *buf, size_t len, size_t *size,
-				    unsigned int idx,
+				    unsigned int idx, unsigned int chan_id,
 				    bool o_nonblock)
 {
 	int ret = 0;
 	struct scmi_raw_buffer *rb;
-	struct scmi_raw_queue *q = raw->q[idx];
+	struct scmi_raw_queue *q;
+
+	q = scmi_raw_queue_select(raw, idx, chan_id);
+	if (!q)
+		return -ENODEV;
 
 	rb = scmi_raw_message_dequeue(q, o_nonblock);
 	if (IS_ERR(rb)) {
@@ -732,7 +777,7 @@ static ssize_t scmi_dbg_raw_mode_common_read(struct file *filp,
 		int ret;
 
 		ret = scmi_raw_message_receive(rd->raw, rd->rx.buf, rd->rx.len,
-					       &rd->rx_size, idx,
+					       &rd->rx_size, idx, rd->chan_id,
 					       filp->f_flags & O_NONBLOCK);
 		if (ret) {
 			rd->rx_size = 0;
@@ -782,7 +827,8 @@ static ssize_t scmi_dbg_raw_mode_common_write(struct file *filp,
 			return cnt;
 	}
 
-	ret = scmi_raw_message_send(rd->raw, rd->tx.buf, rd->tx_size, async);
+	ret = scmi_raw_message_send(rd->raw, rd->tx.buf, rd->tx_size,
+				    rd->chan_id, async);
 
 	/* Reset ppos for next message ... */
 	rd->tx_size = 0;
@@ -797,9 +843,13 @@ static __poll_t scmi_test_dbg_raw_common_poll(struct file *filp,
 {
 	unsigned long flags;
 	struct scmi_dbg_raw_data *rd = filp->private_data;
-	struct scmi_raw_queue *q = rd->raw->q[idx];
+	struct scmi_raw_queue *q;
 	__poll_t mask = 0;
 
+	q = scmi_raw_queue_select(rd->raw, idx, rd->chan_id);
+	if (!q)
+		return mask;
+
 	poll_wait(filp, &q->wq, wait);
 
 	spin_lock_irqsave(&q->msg_q_lock, flags);
@@ -833,8 +883,10 @@ static __poll_t scmi_dbg_raw_mode_message_poll(struct file *filp,
 
 static int scmi_dbg_raw_mode_open(struct inode *inode, struct file *filp)
 {
+	u8 id;
 	struct scmi_raw_mode_info *raw;
 	struct scmi_dbg_raw_data *rd;
+	const char *id_str = filp->f_path.dentry->d_parent->d_name.name;
 
 	if (!inode->i_private)
 		return -ENODEV;
@@ -859,6 +911,10 @@ static int scmi_dbg_raw_mode_open(struct inode *inode, struct file *filp)
 		return -ENOMEM;
 	}
 
+	/* Grab channel ID from debugfs entry naming if any */
+	if (!kstrtou8(id_str, 16, &id))
+		rd->chan_id = id;
+
 	rd->raw = raw;
 	filp->private_data = rd;
 
@@ -1028,7 +1084,8 @@ static int scmi_xfer_raw_worker_init(struct scmi_raw_mode_info *raw)
 	return 0;
 }
 
-static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw)
+static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
+			       unsigned int *channels, int num_chans)
 {
 	int ret, idx;
 	void *gid;
@@ -1046,6 +1103,28 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw)
 		}
 	}
 
+	if (num_chans > 1) {
+		int i;
+
+		idr_init(&raw->queues_idr);
+
+		for (i = 0; i < num_chans; i++) {
+			struct scmi_raw_queue *q;
+
+			q = scmi_raw_queue_init(raw);
+			if (!q)
+				continue;
+
+			ret = idr_alloc(&raw->queues_idr, q,
+					channels[i], channels[i] + 1,
+					GFP_KERNEL);
+			if (ret != channels[i])
+				dev_err(dev,
+					"Fail to allocate Raw queue 0x%02X\n",
+					channels[i]);
+		}
+	}
+
 	ret = scmi_xfer_raw_worker_init(raw);
 	if (ret)
 		goto err;
@@ -1067,6 +1146,8 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw)
  * @top_dentry: A reference to the top Raw debugfs dentry
  * @instance_id: The ID of the underlying SCMI platform instance represented by
  *		 this Raw instance
+ * @channels: The list of the existing channels
+ * @num_chans: The number of entries in @channels
  * @desc: Reference to the transport operations
  * @tx_max_msg: Max number of in-flight messages allowed by the transport
  *
@@ -1076,6 +1157,7 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw)
  */
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
+			 unsigned int *channels, int num_chans,
 			 const struct scmi_desc *desc, int tx_max_msg)
 {
 	int ret;
@@ -1095,7 +1177,7 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 	raw->tx_max_msg = tx_max_msg;
 	raw->id = instance_id;
 
-	ret = scmi_raw_mode_setup(raw);
+	ret = scmi_raw_mode_setup(raw, channels, num_chans);
 	if (ret) {
 		devm_kfree(dev, raw);
 		return ERR_PTR(ret);
@@ -1124,6 +1206,32 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 	debugfs_create_file("errors", 0400, raw->dentry, raw,
 			    &scmi_dbg_raw_mode_errors_fops);
 
+	/*
+	 * Expose per-channel entries if multiple channels available.
+	 * Just ignore errors while setting up these interfaces since we
+	 * have anyway already a working core Raw support.
+	 */
+	if (num_chans > 1) {
+		int i;
+		struct dentry *top_chans;
+
+		top_chans = debugfs_create_dir("channels", raw->dentry);
+
+		for (i = 0; i < num_chans; i++) {
+			char cdir[8];
+			struct dentry *chd;
+
+			snprintf(cdir, 8, "0x%02X", channels[i]);
+			chd = debugfs_create_dir(cdir, top_chans);
+
+			debugfs_create_file("message", 0600, chd, raw,
+					    &scmi_dbg_raw_mode_message_fops);
+
+			debugfs_create_file("message_async", 0600, chd, raw,
+					    &scmi_dbg_raw_mode_message_async_fops);
+		}
+	}
+
 	dev_info(dev, "SCMI RAW Mode initialized for instance %d\n", raw->id);
 
 	return raw;
@@ -1145,6 +1253,7 @@ void scmi_raw_mode_cleanup(void *r)
 
 	cancel_work_sync(&raw->waiters_work);
 	destroy_workqueue(raw->wait_wq);
+	idr_destroy(&raw->queues_idr);
 }
 
 static int scmi_xfer_raw_collect(void *msg, size_t *msg_len,
@@ -1184,6 +1293,7 @@ static int scmi_xfer_raw_collect(void *msg, size_t *msg_len,
  * @r: An opaque reference to the raw instance configuration
  * @xfer: The xfer containing the message to be reported
  * @idx: The index of the queue.
+ * @chan_id: The channel ID to use.
  *
  * If Raw mode is enabled, this is called from the SCMI core on the regular RX
  * path to save and enqueue the response/notification payload carried by this
@@ -1193,7 +1303,8 @@ static int scmi_xfer_raw_collect(void *msg, size_t *msg_len,
  * user can read back the raw message payload at its own pace (if ever) without
  * holding an xfer for too long.
  */
-void scmi_raw_message_report(void *r, struct scmi_xfer *xfer, unsigned int idx)
+void scmi_raw_message_report(void *r, struct scmi_xfer *xfer,
+			     unsigned int idx, unsigned int chan_id)
 {
 	int ret;
 	unsigned long flags;
@@ -1206,7 +1317,8 @@ void scmi_raw_message_report(void *r, struct scmi_xfer *xfer, unsigned int idx)
 		return;
 
 	dev = raw->handle->dev;
-	q = raw->q[idx];
+	q = scmi_raw_queue_select(raw, idx,
+				  SCMI_XFER_IS_CHAN_SET(xfer) ? chan_id : 0);
 
 	/*
 	 * Grab the msg_q_lock upfront to avoid a possible race between
@@ -1325,7 +1437,7 @@ void scmi_raw_error_report(void *r, struct scmi_chan_info *cinfo,
 		smp_store_mb(xfer.priv, priv);
 
 	scmi_xfer_raw_fill(raw, cinfo, &xfer, msg_hdr);
-	scmi_raw_message_report(raw, &xfer, SCMI_RAW_ERRS_QUEUE);
+	scmi_raw_message_report(raw, &xfer, SCMI_RAW_ERRS_QUEUE, 0);
 
 	kfree(xfer.rx.buf);
 }
diff --git a/drivers/firmware/arm_scmi/raw_mode.h b/drivers/firmware/arm_scmi/raw_mode.h
index 1e3d1660b0e4..ee8bc151e9f0 100644
--- a/drivers/firmware/arm_scmi/raw_mode.h
+++ b/drivers/firmware/arm_scmi/raw_mode.h
@@ -19,11 +19,12 @@ enum {
 
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
+			 unsigned int *channels, int num_chans,
 			 const struct scmi_desc *desc, int tx_max_msg);
 void scmi_raw_mode_cleanup(void *raw);
 
 void scmi_raw_message_report(void *raw, struct scmi_xfer *xfer,
-			     unsigned int idx);
+			     unsigned int idx, unsigned int chan_id);
 void scmi_raw_error_report(void *raw, struct scmi_chan_info *cinfo,
 			   u32 msg_hdr, void *priv);
 
-- 
2.34.1

