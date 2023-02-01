Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064567C378
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjAZDVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjAZDVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:21:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517C66ECA;
        Wed, 25 Jan 2023 19:21:18 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q38BHh017806;
        Thu, 26 Jan 2023 03:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Mkm2O7W+v5timDUM+9z8KlTFvuk0CA/1cSxQdJg+F20=;
 b=Nz9819HCvKmB3XvO1kkO5SB6/QCBDpXPgP/w04CivgNq+dsWSIlyJM9H4wxajAP2e4Fe
 478SOWTzKGQZDfqVA4tUgeiBqsLDYakfTFnO4Z94ryhkaltYtbZuEOv65fAcu0LJTPqW
 KaSo90PaqlR29IFlOHnUEQHDXyggOM4h8Gug4TCvxwaM6j56610DIyOzehx6lN2kf2pO
 qQ/SjTKgs3b1Uc8Prf9DeG/xqvw1Mca8TBAdQ/3LRHhM6TtoVbNwpZPI7GfkuNTh76MS
 eNzQpfpKl6MAjiHur3lq6dvE8JMHgJQzqEUS9910t8zYt3Buzhlnq5bA9OzUhqR5euYD fw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb6jc9bs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30Q3ElDM008323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:47 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:47 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH v2 16/22] sound: usb: Introduce QC USB SND offloading support
Date:   Wed, 25 Jan 2023 19:14:18 -0800
Message-ID: <20230126031424.14582-17-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9htL2P6yek8cy5EfqwJqzRaC6XLQlJ2x
X-Proofpoint-GUID: 9htL2P6yek8cy5EfqwJqzRaC6XLQlJ2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_14,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several Qualcomm SoCs have a dedicated audio DSP, which has the ability to
support USB sound devices.  This vendor driver will implement the required
handshaking with the DSP, in order to pass along required resources that
will be utilized by the DSP's USB SW.  The communication channel used for
this handshaking will be using the QMI protocol.  Required resources
include:
- Allocated secondary event ring address
- EP transfer ring address
- Interrupter number

The above information will allow for the audio DSP to execute USB transfers
over the USB bus.  It will also be able to support devices that have an
implicit feedback and sync endpoint as well.  Offloading these data
transfers will allow the main/applications processor to enter lower CPU
power modes, and sustain a longer duration in those modes.

Audio offloading is initiated with the following sequence:
1. Userspace configures to route audio playback to USB backend and starts
playback on the platform soundcard.
2. The Q6DSP AFE will communicate to the audio DSP to start the USB AFE
port.
3. This results in a QMI packet with a STREAM enable command.
4. The QC audio offload driver will fetch the required resources, and pass
this information as part of the QMI response to the STREAM enable command.
5. Once the QMI response is received the audio DSP will start queuing data
on the USB bus.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/Kconfig                  |   14 +
 sound/usb/Makefile                 |    2 +-
 sound/usb/qcom/Makefile            |    2 +
 sound/usb/qcom/qc_audio_offload.c  | 1775 ++++++++++++++++++++++++++++
 sound/usb/qcom/usb_audio_qmi_v01.c |  892 ++++++++++++++
 sound/usb/qcom/usb_audio_qmi_v01.h |  162 +++
 6 files changed, 2846 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/qcom/Makefile
 create mode 100644 sound/usb/qcom/qc_audio_offload.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 059242f15d75..18d65a0d905a 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -165,6 +165,20 @@ config SND_BCD2000
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-bcd2000.
 
+config QC_USB_AUDIO_OFFLOAD
+	tristate "Qualcomm Audio Offload driver"
+	select SND_PCM
+	help
+	  Say Y here to enable the Qualcomm USB audio offloading feature
+
+	  This module sets up the required QMI stream enable/disable
+	  responses to requests generated by the audio DSP.  It passes the
+	  USB transfer resource references, so that the audio DSP can issue
+	  USB transfers to the host controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called qc-audio-offload.
+
 source "sound/usb/line6/Kconfig"
 
 endif	# SND_USB
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 9ccb21a4ff8a..2243ae333ec9 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -33,5 +33,5 @@ obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
 
-obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/
+obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/ qcom/
 obj-$(CONFIG_SND_USB_LINE6)	+= line6/
diff --git a/sound/usb/qcom/Makefile b/sound/usb/qcom/Makefile
new file mode 100644
index 000000000000..d27d39beb8ce
--- /dev/null
+++ b/sound/usb/qcom/Makefile
@@ -0,0 +1,2 @@
+snd-usb-audio-qmi-objs := usb_audio_qmi_v01.o qc_audio_offload.o
+obj-$(CONFIG_QC_USB_AUDIO_OFFLOAD) += snd-usb-audio-qmi.o
\ No newline at end of file
diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
new file mode 100644
index 000000000000..c1254d5f680d
--- /dev/null
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -0,0 +1,1775 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/ctype.h>
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/init.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/xhci-intr.h>
+#include <linux/usb/quirks.h>
+#include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
+#include <linux/usb/audio-v3.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+#include <sound/q6usboffload.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/info.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+
+#include <sound/soc.h>
+#include <sound/soc-usb.h>
+#include "../usbaudio.h"
+#include "../card.h"
+#include "../midi.h"
+#include "../mixer.h"
+#include "../proc.h"
+#include "../quirks.h"
+#include "../endpoint.h"
+#include "../helper.h"
+#include "../pcm.h"
+#include "../format.h"
+#include "../power.h"
+#include "../stream.h"
+#include "../media.h"
+#include "usb_audio_qmi_v01.h"
+
+/* Stream disable request timeout during USB device disconnect */
+#define DEV_RELEASE_WAIT_TIMEOUT 10000 /* in ms */
+
+/* Data interval calculation parameters */
+#define BUS_INTERVAL_FULL_SPEED 1000 /* in us */
+#define BUS_INTERVAL_HIGHSPEED_AND_ABOVE 125 /* in us */
+#define MAX_BINTERVAL_ISOC_EP 16
+
+#define SND_PCM_CARD_NUM_MASK 0xffff0000
+#define SND_PCM_DEV_NUM_MASK 0xff00
+#define SND_PCM_STREAM_DIRECTION 0xff
+
+/* iommu resource parameters and management */
+#define PREPEND_SID_TO_IOVA(iova, sid) ((u64)(((u64)(iova)) | \
+					(((u64)sid) << 32)))
+#define IOVA_BASE 0x1000
+#define IOVA_XFER_RING_BASE (IOVA_BASE + PAGE_SIZE * (SNDRV_CARDS + 1))
+#define IOVA_XFER_BUF_BASE (IOVA_XFER_RING_BASE + PAGE_SIZE * SNDRV_CARDS * 32)
+#define IOVA_XFER_RING_MAX (IOVA_XFER_BUF_BASE - PAGE_SIZE)
+#define IOVA_XFER_BUF_MAX (0xfffff000 - PAGE_SIZE)
+
+#define MAX_XFER_BUFF_LEN (24 * PAGE_SIZE)
+
+struct iova_info {
+	struct list_head list;
+	unsigned long start_iova;
+	size_t size;
+	bool in_use;
+};
+
+struct intf_info {
+	unsigned long data_xfer_ring_va;
+	size_t data_xfer_ring_size;
+	unsigned long sync_xfer_ring_va;
+	size_t sync_xfer_ring_size;
+	unsigned long xfer_buf_va;
+	size_t xfer_buf_size;
+	phys_addr_t xfer_buf_pa;
+	unsigned int data_ep_pipe;
+	unsigned int sync_ep_pipe;
+	u8 *xfer_buf;
+	u8 intf_num;
+	u8 pcm_card_num;
+	u8 pcm_dev_num;
+	u8 direction;
+	bool in_use;
+};
+
+struct uaudio_qmi_dev {
+	struct device *dev;
+	u32 sid;
+	u32 intr_num;
+	struct xhci_interrupter *ir;
+	struct xhci_ring *sec_ring;
+	struct iommu_domain *domain;
+
+	/* list to keep track of available iova */
+	struct list_head xfer_ring_list;
+	size_t xfer_ring_iova_size;
+	unsigned long curr_xfer_ring_iova;
+	struct list_head xfer_buf_list;
+	size_t xfer_buf_iova_size;
+	unsigned long curr_xfer_buf_iova;
+
+	/* bit fields representing pcm card enabled */
+	unsigned long card_slot;
+	/* indicate event ring mapped or not */
+	bool er_mapped;
+	/* reference count to number of possible consumers */
+	atomic_t qdev_in_use;
+	/* idx to last udev card number plugged in */
+	unsigned int last_card_num;
+};
+
+struct uaudio_dev {
+	struct usb_device *udev;
+	/* audio control interface */
+	struct usb_host_interface *ctrl_intf;
+	unsigned int card_num;
+	unsigned int usb_core_id;
+	atomic_t in_use;
+	struct kref kref;
+	wait_queue_head_t disconnect_wq;
+
+	/* interface specific */
+	int num_intf;
+	struct intf_info *info;
+	struct snd_usb_audio *chip;
+};
+
+static struct uaudio_dev uadev[SNDRV_CARDS];
+static struct uaudio_qmi_dev *uaudio_qdev;
+static struct uaudio_qmi_svc *uaudio_svc;
+static DEFINE_MUTEX(qdev_mutex);
+
+struct uaudio_qmi_svc {
+	struct qmi_handle *uaudio_svc_hdl;
+	struct work_struct qmi_disconnect_work;
+	struct workqueue_struct *uaudio_wq;
+	struct sockaddr_qrtr client_sq;
+	bool client_connected;
+};
+
+enum mem_type {
+	MEM_EVENT_RING,
+	MEM_XFER_RING,
+	MEM_XFER_BUF,
+};
+
+/* Supported audio formats */
+enum usb_qmi_audio_format {
+	USB_QMI_PCM_FORMAT_S8 = 0,
+	USB_QMI_PCM_FORMAT_U8,
+	USB_QMI_PCM_FORMAT_S16_LE,
+	USB_QMI_PCM_FORMAT_S16_BE,
+	USB_QMI_PCM_FORMAT_U16_LE,
+	USB_QMI_PCM_FORMAT_U16_BE,
+	USB_QMI_PCM_FORMAT_S24_LE,
+	USB_QMI_PCM_FORMAT_S24_BE,
+	USB_QMI_PCM_FORMAT_U24_LE,
+	USB_QMI_PCM_FORMAT_U24_BE,
+	USB_QMI_PCM_FORMAT_S24_3LE,
+	USB_QMI_PCM_FORMAT_S24_3BE,
+	USB_QMI_PCM_FORMAT_U24_3LE,
+	USB_QMI_PCM_FORMAT_U24_3BE,
+	USB_QMI_PCM_FORMAT_S32_LE,
+	USB_QMI_PCM_FORMAT_S32_BE,
+	USB_QMI_PCM_FORMAT_U32_LE,
+	USB_QMI_PCM_FORMAT_U32_BE,
+};
+
+static void uaudio_iommu_unmap(enum mem_type mtype, unsigned long va,
+	size_t iova_size, size_t mapped_iova_size);
+static void uaudio_dev_cleanup(struct uaudio_dev *dev);
+static void disable_audio_stream(struct snd_usb_substream *subs);
+static struct snd_usb_substream *find_substream(unsigned int card_num,
+	unsigned int pcm_idx, unsigned int direction);
+
+/* QMI service disconnect handlers */
+static void qmi_disconnect_work(struct work_struct *w)
+{
+	struct intf_info *info;
+	int idx, if_idx;
+	struct snd_usb_substream *subs;
+	struct snd_usb_audio *chip;
+
+	/* find all active intf for set alt 0 and cleanup usb audio dev */
+	for (idx = 0; idx < SNDRV_CARDS; idx++) {
+		if (!atomic_read(&uadev[idx].in_use))
+			continue;
+
+		chip = uadev[idx].chip;
+		for (if_idx = 0; if_idx < uadev[idx].num_intf; if_idx++) {
+			if (!uadev[idx].info || !uadev[idx].info[if_idx].in_use)
+				continue;
+			info = &uadev[idx].info[if_idx];
+			subs = find_substream(info->pcm_card_num,
+						info->pcm_dev_num,
+						info->direction);
+			if (!subs || !chip || atomic_read(&chip->shutdown)) {
+				dev_err(&subs->dev->dev,
+					"no sub for c#%u dev#%u dir%u\n",
+					info->pcm_card_num,
+					info->pcm_dev_num,
+					info->direction);
+				continue;
+			}
+			disable_audio_stream(subs);
+		}
+		atomic_set(&uadev[idx].in_use, 0);
+		mutex_lock(&chip->mutex);
+		uaudio_dev_cleanup(&uadev[idx]);
+		mutex_unlock(&chip->mutex);
+	}
+}
+
+/**
+ * qmi_bye_cb() - qmi bye message callback
+ * @handle: QMI handle
+ * @node: id of the dying node
+ *
+ * This callback is invoked when the QMI bye control message is received
+ * from the QMI client.  Handle the message accordingly by ensuring that
+ * the USB offload path is disabled and cleaned up.  At this point, ADSP
+ * is not utilizing the USB bus.
+ *
+ */
+static void qmi_bye_cb(struct qmi_handle *handle, unsigned int node)
+{
+	struct uaudio_qmi_svc *svc = uaudio_svc;
+
+	if (svc->uaudio_svc_hdl != handle)
+		return;
+
+	if (svc->client_connected && svc->client_sq.sq_node == node) {
+		queue_work(svc->uaudio_wq, &svc->qmi_disconnect_work);
+		svc->client_sq.sq_node = 0;
+		svc->client_sq.sq_port = 0;
+		svc->client_sq.sq_family = 0;
+		svc->client_connected = false;
+	}
+}
+
+/**
+ * qmi_svc_disconnect_cb() - qmi client disconnected
+ * @handle: QMI handle
+ * @node: id of the dying node
+ * @port: port of the dying client
+ *
+ * Invoked when the remote QMI client is disconnected.  Handle this event
+ * the same way as when the QMI bye message is received.  This will ensure
+ * the USB offloading path is disabled and cleaned up.
+ *
+ */
+static void qmi_svc_disconnect_cb(struct qmi_handle *handle,
+				  unsigned int node, unsigned int port)
+{
+	struct uaudio_qmi_svc *svc;
+
+	if (uaudio_svc == NULL)
+		return;
+
+	svc = uaudio_svc;
+	if (svc->uaudio_svc_hdl != handle)
+		return;
+
+	if (svc->client_connected && svc->client_sq.sq_node == node &&
+			svc->client_sq.sq_port == port) {
+		queue_work(svc->uaudio_wq, &svc->qmi_disconnect_work);
+		svc->client_sq.sq_node = 0;
+		svc->client_sq.sq_port = 0;
+		svc->client_sq.sq_family = 0;
+		svc->client_connected = false;
+	}
+}
+
+/* QMI client callback handlers from QMI interface */
+static struct qmi_ops uaudio_svc_ops_options = {
+	.bye = qmi_bye_cb,
+	.del_client = qmi_svc_disconnect_cb,
+};
+
+static enum usb_audio_device_speed_enum_v01
+get_speed_info(enum usb_device_speed udev_speed)
+{
+	switch (udev_speed) {
+	case USB_SPEED_LOW:
+		return USB_AUDIO_DEVICE_SPEED_LOW_V01;
+	case USB_SPEED_FULL:
+		return USB_AUDIO_DEVICE_SPEED_FULL_V01;
+	case USB_SPEED_HIGH:
+		return USB_AUDIO_DEVICE_SPEED_HIGH_V01;
+	case USB_SPEED_SUPER:
+		return USB_AUDIO_DEVICE_SPEED_SUPER_V01;
+	case USB_SPEED_SUPER_PLUS:
+		return USB_AUDIO_DEVICE_SPEED_SUPER_PLUS_V01;
+	default:
+		return USB_AUDIO_DEVICE_SPEED_INVALID_V01;
+	}
+}
+
+/* Offloading IOMMU management */
+static unsigned long uaudio_get_iova(unsigned long *curr_iova,
+	size_t *curr_iova_size, struct list_head *head, size_t size)
+{
+	struct iova_info *info, *new_info = NULL;
+	struct list_head *curr_head;
+	unsigned long va = 0;
+	size_t tmp_size = size;
+	bool found = false;
+
+	if (size % PAGE_SIZE) {
+		dev_err(uaudio_qdev->dev, "size %zu is not page size multiple\n",
+			size);
+		goto done;
+	}
+
+	if (size > *curr_iova_size) {
+		dev_err(uaudio_qdev->dev, "size %zu > curr size %zu\n",
+			size, *curr_iova_size);
+		goto done;
+	}
+	if (*curr_iova_size == 0) {
+		dev_err(uaudio_qdev->dev, "iova mapping is full\n");
+		goto done;
+	}
+
+	list_for_each_entry(info, head, list) {
+		/* exact size iova_info */
+		if (!info->in_use && info->size == size) {
+			info->in_use = true;
+			va = info->start_iova;
+			*curr_iova_size -= size;
+			found = true;
+			dev_dbg(uaudio_qdev->dev, "exact size: %zu found\n", size);
+			goto done;
+		} else if (!info->in_use && tmp_size >= info->size) {
+			if (!new_info)
+				new_info = info;
+			dev_dbg(uaudio_qdev->dev, "partial size: %zu found\n",
+					info->size);
+			tmp_size -= info->size;
+			if (tmp_size)
+				continue;
+
+			va = new_info->start_iova;
+			for (curr_head = &new_info->list; curr_head !=
+			&info->list; curr_head = curr_head->next) {
+				new_info = list_entry(curr_head, struct
+						iova_info, list);
+				new_info->in_use = true;
+			}
+			info->in_use = true;
+			*curr_iova_size -= size;
+			found = true;
+			goto done;
+		} else {
+			/* iova region in use */
+			new_info = NULL;
+			tmp_size = size;
+		}
+	}
+
+	info = kzalloc(sizeof(struct iova_info), GFP_KERNEL);
+	if (!info) {
+		va = 0;
+		goto done;
+	}
+
+	va = info->start_iova = *curr_iova;
+	info->size = size;
+	info->in_use = true;
+	*curr_iova += size;
+	*curr_iova_size -= size;
+	found = true;
+	list_add_tail(&info->list, head);
+
+done:
+	if (!found)
+		dev_err(uaudio_qdev->dev, "unable to find %zu size iova\n",
+			size);
+	else
+		dev_dbg(uaudio_qdev->dev,
+			"va:0x%08lx curr_iova:0x%08lx curr_iova_size:%zu\n",
+			va, *curr_iova, *curr_iova_size);
+
+	return va;
+}
+
+/**
+ * uaudio_iommu_map() - maps iommu memory for adsp
+ * @mtype: ring type
+ * @dma_coherent: dma coherent
+ * @pa: physical address for ring/buffer
+ * @size: size of memory region
+ * @sgt: sg table for memory region
+ *
+ * Maps the XHCI related resources to a memory region that is assigned to be
+ * used by the adsp.  This will be mapped to the domain, which is created by
+ * the ASoC USB backend driver.
+ *
+ */
+static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
+		phys_addr_t pa, size_t size, struct sg_table *sgt)
+{
+	unsigned long va_sg, va = 0;
+	bool map = true;
+	int i, ret;
+	size_t sg_len, total_len = 0;
+	struct scatterlist *sg;
+	phys_addr_t pa_sg;
+	int prot = IOMMU_READ | IOMMU_WRITE;
+
+	if (dma_coherent)
+		prot |= IOMMU_CACHE;
+
+	switch (mtype) {
+	case MEM_EVENT_RING:
+		va = IOVA_BASE;
+		/* er already mapped */
+		if (uaudio_qdev->er_mapped)
+			map = false;
+		break;
+	case MEM_XFER_RING:
+		va = uaudio_get_iova(&uaudio_qdev->curr_xfer_ring_iova,
+		&uaudio_qdev->xfer_ring_iova_size, &uaudio_qdev->xfer_ring_list,
+		size);
+		break;
+	case MEM_XFER_BUF:
+		va = uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
+		&uaudio_qdev->xfer_buf_iova_size, &uaudio_qdev->xfer_buf_list,
+		size);
+		break;
+	default:
+		dev_err(uaudio_qdev->dev, "unknown mem type %d\n", mtype);
+	}
+
+	if (!va || !map)
+		goto done;
+
+	if (!sgt)
+		goto skip_sgt_map;
+
+	va_sg = va;
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		sg_len = PAGE_ALIGN(sg->offset + sg->length);
+		pa_sg = page_to_phys(sg_page(sg));
+		ret = iommu_map(uaudio_qdev->domain, va_sg, pa_sg, sg_len,
+								prot);
+		if (ret) {
+			dev_err(uaudio_qdev->dev, "mapping failed ret%d\n", ret);
+			dev_err(uaudio_qdev->dev,
+				"type:%d, pa:%pa iova:0x%08lx sg_len:%zu\n",
+				mtype, &pa_sg, va_sg, sg_len);
+			uaudio_iommu_unmap(MEM_XFER_BUF, va, size, total_len);
+			va = 0;
+			goto done;
+		}
+		dev_dbg(uaudio_qdev->dev,
+			"type:%d map pa:%pa to iova:0x%08lx len:%zu offset:%u\n",
+			mtype, &pa_sg, va_sg, sg_len, sg->offset);
+		va_sg += sg_len;
+		total_len += sg_len;
+	}
+
+	if (size != total_len) {
+		dev_err(uaudio_qdev->dev, "iova size %zu != mapped iova size %zu\n",
+			size, total_len);
+		uaudio_iommu_unmap(MEM_XFER_BUF, va, size, total_len);
+		va = 0;
+	}
+	return va;
+
+skip_sgt_map:
+	dev_dbg(uaudio_qdev->dev, "type:%d map pa:%pa to iova:0x%08lx size:%zu\n",
+		mtype, &pa, va, size);
+
+	ret = iommu_map(uaudio_qdev->domain, va, pa, size, prot);
+	if (ret)
+		dev_err(uaudio_qdev->dev,
+			"failed to map pa:%pa iova:0x%lx type:%d ret:%d\n",
+			&pa, va, mtype, ret);
+done:
+	return va;
+}
+
+static void uaudio_put_iova(unsigned long va, size_t size, struct list_head
+	*head, size_t *curr_iova_size)
+{
+	struct iova_info *info;
+	size_t tmp_size = size;
+	bool found = false;
+
+	list_for_each_entry(info, head, list) {
+		if (info->start_iova == va) {
+			if (!info->in_use) {
+				dev_err(uaudio_qdev->dev, "va %lu is not in use\n",
+					va);
+				return;
+			}
+			found = true;
+			info->in_use = false;
+			if (info->size == size)
+				goto done;
+		}
+
+		if (found && tmp_size >= info->size) {
+			info->in_use = false;
+			tmp_size -= info->size;
+			if (!tmp_size)
+				goto done;
+		}
+	}
+
+	if (!found) {
+		dev_err(uaudio_qdev->dev, "unable to find the va %lu\n", va);
+		return;
+	}
+done:
+	*curr_iova_size += size;
+	dev_dbg(uaudio_qdev->dev, "curr_iova_size %zu\n", *curr_iova_size);
+}
+
+/**
+ * uaudio_iommu_unmap() - unmaps iommu memory for adsp
+ * @mtype: ring type
+ * @va: virtual address to unmap
+ * @iova_size: region size
+ * @mapped_iova_size: mapped region size
+ *
+ * Unmaps the memory region that was previously assigned to the adsp.
+ *
+ */
+static void uaudio_iommu_unmap(enum mem_type mtype, unsigned long va,
+	size_t iova_size, size_t mapped_iova_size)
+{
+	size_t umap_size;
+	bool unmap = true;
+
+	if (!va || !iova_size)
+		return;
+
+	switch (mtype) {
+	case MEM_EVENT_RING:
+		if (uaudio_qdev->er_mapped)
+			uaudio_qdev->er_mapped = false;
+		else
+			unmap = false;
+		break;
+
+	case MEM_XFER_RING:
+		uaudio_put_iova(va, iova_size, &uaudio_qdev->xfer_ring_list,
+		&uaudio_qdev->xfer_ring_iova_size);
+		break;
+	case MEM_XFER_BUF:
+		uaudio_put_iova(va, iova_size, &uaudio_qdev->xfer_buf_list,
+		&uaudio_qdev->xfer_buf_iova_size);
+		break;
+	default:
+		dev_err(uaudio_qdev->dev, "unknown mem type %d\n", mtype);
+		unmap = false;
+	}
+
+	if (!unmap || !mapped_iova_size)
+		return;
+
+	dev_dbg(uaudio_qdev->dev, "type %d: unmap iova 0x%08lx size %zu\n",
+		mtype, va, mapped_iova_size);
+
+	umap_size = iommu_unmap(uaudio_qdev->domain, va, mapped_iova_size);
+	if (umap_size != mapped_iova_size)
+		dev_err(uaudio_qdev->dev,
+			"unmapped size %zu for iova 0x%08lx of mapped size %zu\n",
+			umap_size, va, mapped_iova_size);
+}
+
+/* looks up alias, if any, for controller DT node and returns the index */
+static int usb_get_controller_id(struct usb_device *udev)
+{
+	if (udev->bus->sysdev && udev->bus->sysdev->of_node)
+		return of_alias_get_id(udev->bus->sysdev->of_node, "usb");
+
+	return -ENODEV;
+}
+
+/**
+ * uaudio_dev_intf_cleanup() - cleanup transfer resources
+ * @udev: usb device
+ * @info: usb offloading interface
+ *
+ * Cleans up the transfer ring related resources which are assigned per
+ * endpoint from XHCI.  This is invoked when the USB endpoints are no
+ * longer in use by the adsp.
+ *
+ */
+static void uaudio_dev_intf_cleanup(struct usb_device *udev,
+	struct intf_info *info)
+{
+	uaudio_iommu_unmap(MEM_XFER_RING, info->data_xfer_ring_va,
+		info->data_xfer_ring_size, info->data_xfer_ring_size);
+	info->data_xfer_ring_va = 0;
+	info->data_xfer_ring_size = 0;
+
+	uaudio_iommu_unmap(MEM_XFER_RING, info->sync_xfer_ring_va,
+		info->sync_xfer_ring_size, info->sync_xfer_ring_size);
+	info->sync_xfer_ring_va = 0;
+	info->sync_xfer_ring_size = 0;
+
+	uaudio_iommu_unmap(MEM_XFER_BUF, info->xfer_buf_va,
+		info->xfer_buf_size, info->xfer_buf_size);
+	info->xfer_buf_va = 0;
+
+	usb_free_coherent(udev, info->xfer_buf_size,
+		info->xfer_buf, info->xfer_buf_pa);
+	info->xfer_buf_size = 0;
+	info->xfer_buf = NULL;
+	info->xfer_buf_pa = 0;
+
+	info->in_use = false;
+}
+
+/**
+ * uaudio_event_ring_cleanup_free() - cleanup secondary event ring
+ * @dev: usb offload device
+ *
+ * Cleans up the secondary event ring that was requested.  This will
+ * occur when the adsp is no longer transferring data on the USB bus
+ * across all endpoints.
+ *
+ */
+static void uaudio_event_ring_cleanup_free(struct uaudio_dev *dev)
+{
+	struct usb_hcd *hcd = bus_to_hcd(dev->udev->bus);
+
+	clear_bit(dev->card_num, &uaudio_qdev->card_slot);
+	/* all audio devices are disconnected */
+	if (!uaudio_qdev->card_slot) {
+		uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
+			PAGE_SIZE);
+		xhci_remove_secondary_interrupter(hcd, uaudio_qdev->ir);
+		uaudio_qdev->ir = NULL;
+	}
+}
+
+/* kref release callback when all streams are disabled */
+static void uaudio_dev_release(struct kref *kref)
+{
+	struct uaudio_dev *dev = container_of(kref, struct uaudio_dev, kref);
+
+	uaudio_event_ring_cleanup_free(dev);
+	atomic_set(&dev->in_use, 0);
+	wake_up(&dev->disconnect_wq);
+}
+
+static struct snd_usb_substream *find_substream(unsigned int card_num,
+	unsigned int pcm_idx, unsigned int direction)
+{
+	struct snd_usb_stream *as;
+	struct snd_usb_substream *subs = NULL;
+	struct snd_usb_audio *chip;
+
+	chip = uadev[card_num].chip;
+	if (!chip || atomic_read(&chip->shutdown))
+		goto done;
+
+	if (pcm_idx >= chip->pcm_devs)
+		goto done;
+
+	if (direction > SNDRV_PCM_STREAM_CAPTURE)
+		goto done;
+
+	list_for_each_entry(as, &chip->pcm_list, list) {
+		if (as->pcm_index == pcm_idx) {
+			subs = &as->substream[direction];
+			goto done;
+		}
+	}
+
+done:
+	return subs;
+}
+
+static int info_idx_from_ifnum(int card_num, int intf_num, bool enable)
+{
+	int i;
+
+	/*
+	 * default index 0 is used when info is allocated upon
+	 * first enable audio stream req for a pcm device
+	 */
+	if (enable && !uadev[card_num].info)
+		return 0;
+
+	for (i = 0; i < uadev[card_num].num_intf; i++) {
+		if (enable && !uadev[card_num].info[i].in_use)
+			return i;
+		else if (!enable &&
+				uadev[card_num].info[i].intf_num == intf_num)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int get_data_interval_from_si(struct snd_usb_substream *subs,
+	u32 service_interval)
+{
+	unsigned int bus_intval, bus_intval_mult, binterval;
+
+	if (subs->dev->speed >= USB_SPEED_HIGH)
+		bus_intval = BUS_INTERVAL_HIGHSPEED_AND_ABOVE;
+	else
+		bus_intval = BUS_INTERVAL_FULL_SPEED;
+
+	if (service_interval % bus_intval)
+		return -EINVAL;
+
+	bus_intval_mult = service_interval / bus_intval;
+	binterval = ffs(bus_intval_mult);
+	if (!binterval || binterval > MAX_BINTERVAL_ISOC_EP)
+		return -EINVAL;
+
+	/* check if another bit is set then bail out */
+	bus_intval_mult = bus_intval_mult >> binterval;
+	if (bus_intval_mult)
+		return -EINVAL;
+
+	return (binterval - 1);
+}
+
+/* maps audio format received over QMI to asound.h based pcm format */
+static snd_pcm_format_t map_pcm_format(enum usb_qmi_audio_format fmt_received)
+{
+	switch (fmt_received) {
+	case USB_QMI_PCM_FORMAT_S8:
+		return SNDRV_PCM_FORMAT_S8;
+	case USB_QMI_PCM_FORMAT_U8:
+		return SNDRV_PCM_FORMAT_U8;
+	case USB_QMI_PCM_FORMAT_S16_LE:
+		return SNDRV_PCM_FORMAT_S16_LE;
+	case USB_QMI_PCM_FORMAT_S16_BE:
+		return SNDRV_PCM_FORMAT_S16_BE;
+	case USB_QMI_PCM_FORMAT_U16_LE:
+		return SNDRV_PCM_FORMAT_U16_LE;
+	case USB_QMI_PCM_FORMAT_U16_BE:
+		return SNDRV_PCM_FORMAT_U16_BE;
+	case USB_QMI_PCM_FORMAT_S24_LE:
+		return SNDRV_PCM_FORMAT_S24_LE;
+	case USB_QMI_PCM_FORMAT_S24_BE:
+		return SNDRV_PCM_FORMAT_S24_BE;
+	case USB_QMI_PCM_FORMAT_U24_LE:
+		return SNDRV_PCM_FORMAT_U24_LE;
+	case USB_QMI_PCM_FORMAT_U24_BE:
+		return SNDRV_PCM_FORMAT_U24_BE;
+	case USB_QMI_PCM_FORMAT_S24_3LE:
+		return SNDRV_PCM_FORMAT_S24_3LE;
+	case USB_QMI_PCM_FORMAT_S24_3BE:
+		return SNDRV_PCM_FORMAT_S24_3BE;
+	case USB_QMI_PCM_FORMAT_U24_3LE:
+		return SNDRV_PCM_FORMAT_U24_3LE;
+	case USB_QMI_PCM_FORMAT_U24_3BE:
+		return SNDRV_PCM_FORMAT_U24_3BE;
+	case USB_QMI_PCM_FORMAT_S32_LE:
+		return SNDRV_PCM_FORMAT_S32_LE;
+	case USB_QMI_PCM_FORMAT_S32_BE:
+		return SNDRV_PCM_FORMAT_S32_BE;
+	case USB_QMI_PCM_FORMAT_U32_LE:
+		return SNDRV_PCM_FORMAT_U32_LE;
+	case USB_QMI_PCM_FORMAT_U32_BE:
+		return SNDRV_PCM_FORMAT_U32_BE;
+	default:
+		/*
+		 * We expect the caller to do input validation so we should
+		 * never hit this. But we do have to return a proper
+		 * snd_pcm_format_t value due to the __bitwise attribute; so
+		 * just return the equivalent of 0 in case of bad input.
+		 */
+		return SNDRV_PCM_FORMAT_S8;
+	}
+}
+
+/**
+ * disable_audio_stream() - disable usb snd endpoints
+ * @subs: usb substream
+ *
+ * Closes the USB SND endpoints associated with the current audio stream
+ * used.  This will decrement the USB SND endpoint opened reference count.
+ *
+ */
+static void disable_audio_stream(struct snd_usb_substream *subs)
+{
+	struct snd_usb_audio *chip = subs->stream->chip;
+
+	if (subs->data_endpoint || subs->sync_endpoint) {
+		close_endpoints(chip, subs);
+
+		mutex_lock(&chip->mutex);
+		subs->cur_audiofmt = NULL;
+		mutex_unlock(&chip->mutex);
+	}
+
+	snd_usb_autosuspend(chip);
+}
+
+/**
+ * enable_audio_stream() - enable usb snd endpoints
+ * @subs: usb substream
+ * @pcm_format: pcm format requested
+ * @channels: number of channels
+ * @cur_rate: sample rate
+ * @datainterval: interval
+ *
+ * Opens all USB SND endpoints used for the data interface.  This will increment
+ * the USB SND endpoint's opened count.  Requests to keep the interface resumed
+ * until the audio stream is stopped.  Will issue the USB set interface control
+ * message to enable the data interface.
+ *
+ */
+static int enable_audio_stream(struct snd_usb_substream *subs,
+				snd_pcm_format_t pcm_format,
+				unsigned int channels, unsigned int cur_rate,
+				int datainterval)
+{
+	struct snd_usb_audio *chip = subs->stream->chip;
+	struct snd_pcm_hw_params params;
+	const struct audioformat *fmt;
+	int ret;
+
+	_snd_pcm_hw_params_any(&params);
+	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_FORMAT,
+			(__force int) pcm_format, 0);
+	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_CHANNELS,
+			channels, 0);
+	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_RATE,
+			cur_rate, 0);
+
+	pm_runtime_barrier(&chip->intf[0]->dev);
+	snd_usb_autoresume(chip);
+
+	fmt = find_format(&subs->fmt_list, pcm_format, cur_rate,
+			channels, datainterval, subs);
+	if (!fmt) {
+		dev_err(uaudio_qdev->dev,
+			"cannot find format: format = %#x, rate = %d, ch = %d\n",
+			pcm_format, cur_rate, channels);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&chip->shutdown)) {
+		dev_err(uaudio_qdev->dev, "chip already shutdown\n");
+		ret = -ENODEV;
+	} else {
+		if (subs->data_endpoint)
+			close_endpoints(chip, subs);
+
+		subs->data_endpoint = snd_usb_endpoint_open(chip, fmt,
+				&params, false);
+		if (!subs->data_endpoint) {
+			dev_err(uaudio_qdev->dev, "failed to open data endpoint\n");
+			return -EINVAL;
+		}
+
+		if (fmt->sync_ep) {
+			subs->sync_endpoint = snd_usb_endpoint_open(chip,
+					fmt, &params, true);
+			if (!subs->sync_endpoint) {
+				dev_err(uaudio_qdev->dev,
+					"failed to open sync endpoint\n");
+				return -EINVAL;
+			}
+
+			subs->data_endpoint->sync_source = subs->sync_endpoint;
+		}
+
+		mutex_lock(&chip->mutex);
+		subs->cur_audiofmt = fmt;
+		mutex_unlock(&chip->mutex);
+
+		if (subs->sync_endpoint) {
+			ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = snd_usb_endpoint_prepare(chip, subs->data_endpoint);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(uaudio_qdev->dev,
+			"selected %s iface:%d altsetting:%d datainterval:%dus\n",
+			subs->direction ? "capture" : "playback",
+			fmt->iface, fmt->altsetting,
+			(1 << fmt->datainterval) *
+			(subs->dev->speed >= USB_SPEED_HIGH ?
+			BUS_INTERVAL_HIGHSPEED_AND_ABOVE :
+			BUS_INTERVAL_FULL_SPEED));
+	}
+
+	return 0;
+}
+
+/**
+ * prepare_qmi_response() - prepare stream enable response
+ * @subs: usb substream
+ * @req_msg: QMI request message
+ * @resp: QMI response buffer
+ * @info_idx: usb interface array index
+ *
+ * Prepares the QMI response for a USB QMI stream enable request.  Will parse
+ * out the parameters within the stream enable request, in order to match
+ * requested audio profile to the ones exposed by the USB device connected.
+ *
+ * In addition, will fetch the XHCI transfer resources needed for the handoff to
+ * happen.  This includes, transfer ring and buffer addresses and secondary event
+ * ring address.  These parameters will be communicated as part of the USB QMI
+ * stream enable response.
+ *
+ */
+static int prepare_qmi_response(struct snd_usb_substream *subs,
+		struct qmi_uaudio_stream_req_msg_v01 *req_msg,
+		struct qmi_uaudio_stream_resp_msg_v01 *resp, int info_idx)
+{
+	struct usb_interface *iface;
+	struct usb_host_interface *alts;
+	struct usb_interface_descriptor *altsd;
+	struct usb_interface_assoc_descriptor *assoc;
+	struct usb_host_endpoint *ep;
+	struct uac_format_type_i_continuous_descriptor *fmt;
+	struct uac_format_type_i_discrete_descriptor *fmt_v1;
+	struct uac_format_type_i_ext_descriptor *fmt_v2;
+	struct uac1_as_header_descriptor *as;
+	struct xhci_interrupter *ir;
+	struct usb_hcd *hcd;
+	int ret;
+	int protocol, card_num, pcm_dev_num;
+	void *hdr_ptr;
+	u8 *xfer_buf;
+	unsigned int data_ep_pipe = 0, sync_ep_pipe = 0;
+	u32 len, mult, remainder, xfer_buf_len;
+	unsigned long va, tr_data_va = 0, tr_sync_va = 0;
+	phys_addr_t xhci_pa, xfer_buf_pa, tr_data_pa = 0, tr_sync_pa = 0;
+	dma_addr_t dma;
+	struct sg_table sgt;
+	bool dma_coherent;
+
+	iface = usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
+	if (!iface) {
+		dev_err(uaudio_qdev->dev, "interface # %d does not exist\n",
+			subs->cur_audiofmt->iface);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	assoc = iface->intf_assoc;
+	pcm_dev_num = (req_msg->usb_token & SND_PCM_DEV_NUM_MASK) >> 8;
+	xfer_buf_len = req_msg->xfer_buff_size;
+	card_num = uaudio_qdev->last_card_num;
+
+	alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
+	altsd = get_iface_desc(alts);
+	protocol = altsd->bInterfaceProtocol;
+
+	/* get format type */
+	if (protocol != UAC_VERSION_3) {
+		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
+				UAC_FORMAT_TYPE);
+		if (!fmt) {
+			dev_err(uaudio_qdev->dev,
+				"%u:%d : no UAC_FORMAT_TYPE desc\n",
+				subs->cur_audiofmt->iface,
+				subs->cur_audiofmt->altset_idx);
+			ret = -ENODEV;
+			goto err;
+		}
+	}
+
+	if (!uadev[card_num].ctrl_intf) {
+		dev_err(uaudio_qdev->dev, "audio ctrl intf info not cached\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (protocol != UAC_VERSION_3) {
+		hdr_ptr = snd_usb_find_csint_desc(uadev[card_num].ctrl_intf->extra,
+				uadev[card_num].ctrl_intf->extralen, NULL,
+				UAC_HEADER);
+		if (!hdr_ptr) {
+			dev_err(uaudio_qdev->dev, "no UAC_HEADER desc\n");
+			ret = -ENODEV;
+			goto err;
+		}
+	}
+
+	if (protocol == UAC_VERSION_1) {
+		struct uac1_ac_header_descriptor *uac1_hdr = hdr_ptr;
+
+		as = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
+			UAC_AS_GENERAL);
+		if (!as) {
+			dev_err(uaudio_qdev->dev,
+				"%u:%d : no UAC_AS_GENERAL desc\n",
+				subs->cur_audiofmt->iface,
+				subs->cur_audiofmt->altset_idx);
+			ret = -ENODEV;
+			goto err;
+		}
+		resp->data_path_delay = as->bDelay;
+		resp->data_path_delay_valid = 1;
+		fmt_v1 = (struct uac_format_type_i_discrete_descriptor *)fmt;
+		resp->usb_audio_subslot_size = fmt_v1->bSubframeSize;
+		resp->usb_audio_subslot_size_valid = 1;
+
+		resp->usb_audio_spec_revision = le16_to_cpu(uac1_hdr->bcdADC);
+		resp->usb_audio_spec_revision_valid = 1;
+	} else if (protocol == UAC_VERSION_2) {
+		struct uac2_ac_header_descriptor *uac2_hdr = hdr_ptr;
+
+		fmt_v2 = (struct uac_format_type_i_ext_descriptor *)fmt;
+		resp->usb_audio_subslot_size = fmt_v2->bSubslotSize;
+		resp->usb_audio_subslot_size_valid = 1;
+
+		resp->usb_audio_spec_revision = le16_to_cpu(uac2_hdr->bcdADC);
+		resp->usb_audio_spec_revision_valid = 1;
+	} else if (protocol == UAC_VERSION_3) {
+		if (assoc->bFunctionSubClass ==
+					UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0) {
+			dev_err(uaudio_qdev->dev, "full adc is not supported\n");
+			ret = -EINVAL;
+		}
+
+		switch (le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize)) {
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16:
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16: {
+			resp->usb_audio_subslot_size = 0x2;
+			break;
+		}
+
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24:
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24: {
+			resp->usb_audio_subslot_size = 0x3;
+			break;
+		}
+
+		default:
+			dev_err(uaudio_qdev->dev,
+				"%d: %u: Invalid wMaxPacketSize\n",
+				subs->cur_audiofmt->iface,
+				subs->cur_audiofmt->altset_idx);
+			ret = -EINVAL;
+			goto err;
+		}
+		resp->usb_audio_subslot_size_valid = 1;
+	} else {
+		dev_err(uaudio_qdev->dev, "unknown protocol version %x\n",
+			protocol);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	resp->slot_id = subs->dev->slot_id;
+	resp->slot_id_valid = 1;
+
+	memcpy(&resp->std_as_opr_intf_desc, &alts->desc, sizeof(alts->desc));
+	resp->std_as_opr_intf_desc_valid = 1;
+
+	ep = usb_pipe_endpoint(subs->dev, subs->data_endpoint->pipe);
+	if (!ep) {
+		dev_err(uaudio_qdev->dev, "data ep # %d context is null\n",
+			subs->data_endpoint->ep_num);
+		ret = -ENODEV;
+		goto err;
+	}
+	data_ep_pipe = subs->data_endpoint->pipe;
+	memcpy(&resp->std_as_data_ep_desc, &ep->desc, sizeof(ep->desc));
+	resp->std_as_data_ep_desc_valid = 1;
+
+	tr_data_pa = xhci_get_xfer_resource(subs->dev, ep, &dma);
+	if (!tr_data_pa) {
+		dev_err(uaudio_qdev->dev, "failed to get data ep ring address\n");
+		ret = -ENODEV;
+		goto err;
+	}
+	resp->xhci_mem_info.tr_data.pa = dma;
+
+	if (subs->sync_endpoint) {
+		ep = usb_pipe_endpoint(subs->dev, subs->sync_endpoint->pipe);
+		if (!ep) {
+			dev_err(uaudio_qdev->dev, "implicit fb on data ep\n");
+			goto skip_sync_ep;
+		}
+		sync_ep_pipe = subs->sync_endpoint->pipe;
+		memcpy(&resp->std_as_sync_ep_desc, &ep->desc, sizeof(ep->desc));
+		resp->std_as_sync_ep_desc_valid = 1;
+
+		tr_sync_pa = xhci_get_xfer_resource(subs->dev, ep, &dma);
+		if (!tr_sync_pa) {
+			dev_err(uaudio_qdev->dev,
+				"failed to get sync ep ring address\n");
+			ret = -ENODEV;
+			goto err;
+		}
+		resp->xhci_mem_info.tr_sync.pa = dma;
+	}
+
+skip_sync_ep:
+	resp->interrupter_num_valid = 1;
+	resp->controller_num_valid = 0;
+	ret = usb_get_controller_id(subs->dev);
+	if (ret >= 0) {
+		resp->controller_num = ret;
+		resp->controller_num_valid = 1;
+	}
+	/* map xhci data structures PA memory to iova */
+	dma_coherent = dev_is_dma_coherent(subs->dev->bus->sysdev);
+
+	/* event ring */
+	hcd = bus_to_hcd(subs->dev->bus);
+	ir = xhci_create_secondary_interrupter(hcd, uaudio_qdev->intr_num);
+	if (!ir) {
+		dev_err(uaudio_qdev->dev, "failed to fetch interrupter\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	xhci_pa = xhci_get_ir_resource(subs->dev, ir);
+	if (!xhci_pa) {
+		dev_err(uaudio_qdev->dev,
+			"failed to get sec event ring address\n");
+		ret = -ENODEV;
+		goto free_sec_ring;
+	}
+
+	uaudio_qdev->ir = ir;
+	resp->interrupter_num = ir->intr_num;
+
+	va = uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, xhci_pa, PAGE_SIZE,
+			NULL);
+	if (!va) {
+		ret = -ENOMEM;
+		goto free_sec_ring;
+	}
+
+	resp->xhci_mem_info.evt_ring.va = PREPEND_SID_TO_IOVA(va,
+						uaudio_qdev->sid);
+	resp->xhci_mem_info.evt_ring.pa = ir->event_ring->first_seg->dma;
+	resp->xhci_mem_info.evt_ring.size = PAGE_SIZE;
+	uaudio_qdev->er_mapped = true;
+
+	resp->speed_info = get_speed_info(subs->dev->speed);
+	if (resp->speed_info == USB_AUDIO_DEVICE_SPEED_INVALID_V01) {
+		ret = -ENODEV;
+		goto unmap_er;
+	}
+
+	resp->speed_info_valid = 1;
+
+	/* data transfer ring */
+	va = uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_data_pa,
+			PAGE_SIZE, NULL);
+	if (!va) {
+		ret = -ENOMEM;
+		goto unmap_er;
+	}
+
+	tr_data_va = va;
+	resp->xhci_mem_info.tr_data.va = PREPEND_SID_TO_IOVA(va,
+						uaudio_qdev->sid);
+	resp->xhci_mem_info.tr_data.size = PAGE_SIZE;
+
+	/* sync transfer ring */
+	if (!resp->xhci_mem_info.tr_sync.pa)
+		goto skip_sync;
+
+	xhci_pa = resp->xhci_mem_info.tr_sync.pa;
+	va = uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_sync_pa,
+			PAGE_SIZE, NULL);
+	if (!va) {
+		ret = -ENOMEM;
+		goto unmap_data;
+	}
+
+	tr_sync_va = va;
+	resp->xhci_mem_info.tr_sync.va = PREPEND_SID_TO_IOVA(va,
+						uaudio_qdev->sid);
+	resp->xhci_mem_info.tr_sync.size = PAGE_SIZE;
+
+skip_sync:
+	/* xfer buffer, multiple of 4K only */
+	if (!xfer_buf_len)
+		xfer_buf_len = PAGE_SIZE;
+
+	mult = xfer_buf_len / PAGE_SIZE;
+	remainder = xfer_buf_len % PAGE_SIZE;
+	len = mult * PAGE_SIZE;
+	len += remainder ? PAGE_SIZE : 0;
+
+	if (len > MAX_XFER_BUFF_LEN) {
+		dev_err(uaudio_qdev->dev,
+			"req buf len %d > max buf len %lu, setting %lu\n",
+			len, MAX_XFER_BUFF_LEN, MAX_XFER_BUFF_LEN);
+		len = MAX_XFER_BUFF_LEN;
+	}
+
+	xfer_buf = usb_alloc_coherent(subs->dev, len, GFP_KERNEL, &xfer_buf_pa);
+	if (!xfer_buf) {
+		ret = -ENOMEM;
+		goto unmap_sync;
+	}
+
+	dma_get_sgtable(subs->dev->bus->sysdev, &sgt, xfer_buf, xfer_buf_pa,
+			len);
+	va = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent, xfer_buf_pa, len,
+			&sgt);
+	if (!va) {
+		ret = -ENOMEM;
+		goto unmap_sync;
+	}
+
+	resp->xhci_mem_info.xfer_buff.pa = xfer_buf_pa;
+	resp->xhci_mem_info.xfer_buff.size = len;
+
+	resp->xhci_mem_info.xfer_buff.va = PREPEND_SID_TO_IOVA(va,
+						uaudio_qdev->sid);
+
+	resp->xhci_mem_info_valid = 1;
+
+	sg_free_table(&sgt);
+
+	if (!atomic_read(&uadev[card_num].in_use)) {
+		kref_init(&uadev[card_num].kref);
+		init_waitqueue_head(&uadev[card_num].disconnect_wq);
+		uadev[card_num].num_intf =
+			subs->dev->config->desc.bNumInterfaces;
+		uadev[card_num].info = kcalloc(uadev[card_num].num_intf,
+			sizeof(struct intf_info), GFP_KERNEL);
+		if (!uadev[card_num].info) {
+			ret = -ENOMEM;
+			goto unmap_sync;
+		}
+		uadev[card_num].udev = subs->dev;
+		atomic_set(&uadev[card_num].in_use, 1);
+	} else {
+		kref_get(&uadev[card_num].kref);
+	}
+
+	uadev[card_num].card_num = card_num;
+	uadev[card_num].usb_core_id = resp->controller_num;
+
+	/* cache intf specific info to use it for unmap and free xfer buf */
+	uadev[card_num].info[info_idx].data_xfer_ring_va = tr_data_va;
+	uadev[card_num].info[info_idx].data_xfer_ring_size = PAGE_SIZE;
+	uadev[card_num].info[info_idx].sync_xfer_ring_va = tr_sync_va;
+	uadev[card_num].info[info_idx].sync_xfer_ring_size = PAGE_SIZE;
+	uadev[card_num].info[info_idx].xfer_buf_va = va;
+	uadev[card_num].info[info_idx].xfer_buf_pa = xfer_buf_pa;
+	uadev[card_num].info[info_idx].xfer_buf_size = len;
+	uadev[card_num].info[info_idx].data_ep_pipe = data_ep_pipe;
+	uadev[card_num].info[info_idx].sync_ep_pipe = sync_ep_pipe;
+	uadev[card_num].info[info_idx].xfer_buf = xfer_buf;
+	uadev[card_num].info[info_idx].pcm_card_num = card_num;
+	uadev[card_num].info[info_idx].pcm_dev_num = pcm_dev_num;
+	uadev[card_num].info[info_idx].direction = subs->direction;
+	uadev[card_num].info[info_idx].intf_num = subs->cur_audiofmt->iface;
+	uadev[card_num].info[info_idx].in_use = true;
+
+	set_bit(card_num, &uaudio_qdev->card_slot);
+
+	return 0;
+
+unmap_sync:
+	usb_free_coherent(subs->dev, len, xfer_buf, xfer_buf_pa);
+	uaudio_iommu_unmap(MEM_XFER_RING, tr_sync_va, PAGE_SIZE, PAGE_SIZE);
+unmap_data:
+	uaudio_iommu_unmap(MEM_XFER_RING, tr_data_va, PAGE_SIZE, PAGE_SIZE);
+unmap_er:
+	uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE, PAGE_SIZE);
+free_sec_ring:
+	xhci_remove_secondary_interrupter(hcd, uaudio_qdev->ir);
+err:
+	return ret;
+}
+
+/**
+ * handle_uaudio_stream_req() - handle stream enable/disable request
+ * @handle: QMI client handle
+ * @sq: qrtr socket
+ * @txn: QMI transaction context
+ * @decoded_msg: decoded QMI message
+ *
+ * Main handler for the QMI stream enable/disable requests.  This executes the
+ * corresponding enable/disable stream apis, respectively.
+ *
+ */
+static void handle_uaudio_stream_req(struct qmi_handle *handle,
+			struct sockaddr_qrtr *sq,
+			struct qmi_txn *txn,
+			const void *decoded_msg)
+{
+	struct qmi_uaudio_stream_req_msg_v01 *req_msg;
+	struct qmi_uaudio_stream_resp_msg_v01 resp = {{0}, 0};
+	struct snd_usb_substream *subs;
+	struct snd_usb_audio *chip = NULL;
+	struct uaudio_qmi_svc *svc = uaudio_svc;
+	struct intf_info *info;
+	struct usb_host_endpoint *ep;
+	u8 pcm_card_num, pcm_dev_num, direction;
+	int info_idx = -EINVAL, datainterval = -EINVAL, ret = 0;
+
+	if (!svc->client_connected) {
+		svc->client_sq = *sq;
+		svc->client_connected = true;
+	}
+
+	req_msg = (struct qmi_uaudio_stream_req_msg_v01 *)decoded_msg;
+	if (!req_msg->audio_format_valid || !req_msg->bit_rate_valid ||
+	    !req_msg->number_of_ch_valid || !req_msg->xfer_buff_size_valid) {
+		ret = -EINVAL;
+		goto response;
+	}
+
+	mutex_lock(&qdev_mutex);
+	if (!uaudio_qdev) {
+		mutex_unlock(&qdev_mutex);
+		ret = -EINVAL;
+		goto response;
+	}
+
+	direction = (req_msg->usb_token & SND_PCM_STREAM_DIRECTION);
+	pcm_dev_num = (req_msg->usb_token & SND_PCM_DEV_NUM_MASK) >> 8;
+	pcm_card_num = req_msg->enable ? uaudio_qdev->last_card_num :
+				ffs(uaudio_qdev->card_slot) - 1;
+	mutex_unlock(&qdev_mutex);
+	if (pcm_card_num >= SNDRV_CARDS) {
+		ret = -EINVAL;
+		goto response;
+	}
+
+	if (req_msg->audio_format > USB_QMI_PCM_FORMAT_U32_BE) {
+		ret = -EINVAL;
+		goto response;
+	}
+
+	subs = find_substream(pcm_card_num, pcm_dev_num, direction);
+	chip = uadev[pcm_card_num].chip;
+	if (!subs || !chip || atomic_read(&chip->shutdown)) {
+		ret = -ENODEV;
+		goto response;
+	}
+
+	info_idx = info_idx_from_ifnum(pcm_card_num, subs->cur_audiofmt ?
+			subs->cur_audiofmt->iface : -1, req_msg->enable);
+	if (atomic_read(&chip->shutdown) || !subs->stream || !subs->stream->pcm
+			|| !subs->stream->chip) {
+		ret = -ENODEV;
+		goto response;
+	}
+
+	if (req_msg->enable) {
+		if (info_idx < 0 || chip->system_suspend) {
+			ret = -EBUSY;
+			goto response;
+		}
+	}
+
+	if (req_msg->service_interval_valid) {
+		ret = get_data_interval_from_si(subs,
+						req_msg->service_interval);
+		if (ret == -EINVAL)
+			goto response;
+
+		datainterval = ret;
+	}
+
+	uadev[pcm_card_num].ctrl_intf = chip->ctrl_intf;
+
+	if (req_msg->enable) {
+		ret = enable_audio_stream(subs,
+				map_pcm_format(req_msg->audio_format),
+				req_msg->number_of_ch, req_msg->bit_rate,
+				datainterval);
+
+		if (!ret)
+			ret = prepare_qmi_response(subs, req_msg, &resp,
+					info_idx);
+	} else {
+		info = &uadev[pcm_card_num].info[info_idx];
+		if (info->data_ep_pipe) {
+			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
+						info->data_ep_pipe);
+			if (ep)
+				xhci_stop_endpoint(uadev[pcm_card_num].udev,
+						ep);
+			info->data_ep_pipe = 0;
+		}
+
+		if (info->sync_ep_pipe) {
+			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
+						info->sync_ep_pipe);
+			if (ep)
+				xhci_stop_endpoint(uadev[pcm_card_num].udev,
+						ep);
+			info->sync_ep_pipe = 0;
+		}
+
+		disable_audio_stream(subs);
+	}
+
+response:
+	if (!req_msg->enable && ret != -EINVAL && ret != -ENODEV) {
+		mutex_lock(&chip->mutex);
+		if (info_idx >= 0) {
+			info = &uadev[pcm_card_num].info[info_idx];
+			uaudio_dev_intf_cleanup(
+					uadev[pcm_card_num].udev,
+					info);
+		}
+		if (atomic_read(&uadev[pcm_card_num].in_use))
+			kref_put(&uadev[pcm_card_num].kref,
+					uaudio_dev_release);
+		mutex_unlock(&chip->mutex);
+	}
+
+	resp.usb_token = req_msg->usb_token;
+	resp.usb_token_valid = 1;
+	resp.internal_status = ret;
+	resp.internal_status_valid = 1;
+	resp.status = ret ? USB_AUDIO_STREAM_REQ_FAILURE_V01 : ret;
+	resp.status_valid = 1;
+	ret = qmi_send_response(svc->uaudio_svc_hdl, sq, txn,
+			QMI_UAUDIO_STREAM_RESP_V01,
+			QMI_UAUDIO_STREAM_RESP_MSG_V01_MAX_MSG_LEN,
+			qmi_uaudio_stream_resp_msg_v01_ei, &resp);
+}
+
+static struct qmi_msg_handler uaudio_stream_req_handlers = {
+	.type = QMI_REQUEST,
+	.msg_id = QMI_UAUDIO_STREAM_REQ_V01,
+	.ei = qmi_uaudio_stream_req_msg_v01_ei,
+	.decoded_size = QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN,
+	.fn = handle_uaudio_stream_req,
+};
+
+/* returns usb hcd sysdev */
+static struct device *usb_get_usb_backend(struct usb_device *udev)
+{
+	if (udev->bus->sysdev && udev->bus->sysdev->of_node)
+		return udev->bus->sysdev;
+
+	return NULL;
+}
+
+/**
+ * qc_usb_audio_offload_init_qmi_dev() - initializes qmi dev
+ *
+ * Initializes the USB qdev, which is used to carry information pertaining to
+ * the offloading resources.  This device is freed only when there are no longer
+ * any offloading candidates. (i.e, when all audio devices are disconnected)
+ *
+ */
+static int qc_usb_audio_offload_init_qmi_dev(struct usb_device *udev)
+{
+	struct q6usb_offload *data;
+
+	uaudio_qdev = kzalloc(sizeof(struct uaudio_qmi_dev),
+		GFP_KERNEL);
+	if (!uaudio_qdev)
+		return -ENOMEM;
+
+	/* initialize xfer ring and xfer buf iova list */
+	INIT_LIST_HEAD(&uaudio_qdev->xfer_ring_list);
+	uaudio_qdev->curr_xfer_ring_iova = IOVA_XFER_RING_BASE;
+	uaudio_qdev->xfer_ring_iova_size =
+			IOVA_XFER_RING_MAX - IOVA_XFER_RING_BASE;
+
+	INIT_LIST_HEAD(&uaudio_qdev->xfer_buf_list);
+	uaudio_qdev->curr_xfer_buf_iova = IOVA_XFER_BUF_BASE;
+	uaudio_qdev->xfer_buf_iova_size =
+		IOVA_XFER_BUF_MAX - IOVA_XFER_BUF_BASE;
+
+	data = snd_soc_usb_get_priv_data(usb_get_usb_backend(udev));
+	if (data) {
+		uaudio_qdev->domain = data->domain;
+		uaudio_qdev->sid = data->sid;
+		uaudio_qdev->intr_num = data->intr_num;
+		uaudio_qdev->dev = data->dev;
+	}
+
+	return 0;
+}
+
+/**
+ * qc_usb_audio_offload_probe() - platform op connect handler
+ * @intf: USB interface
+ * @chip: USB SND device
+ *
+ * Platform connect handler when a USB SND device is detected. Will
+ * notify SOC USB about the connection to enable the USB ASoC backend
+ * and populate internal USB chip array.
+ *
+ */
+static void qc_usb_audio_offload_probe(struct usb_interface *intf,
+					struct snd_usb_audio *chip)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	mutex_lock(&chip->mutex);
+	if (!uaudio_qdev)
+		qc_usb_audio_offload_init_qmi_dev(udev);
+
+	atomic_inc(&uaudio_qdev->qdev_in_use);
+	uadev[chip->card->number].chip = chip;
+	uaudio_qdev->last_card_num = chip->card->number;
+
+	snd_soc_usb_connect(usb_get_usb_backend(udev), chip->index);
+	mutex_unlock(&chip->mutex);
+}
+
+static void uaudio_dev_cleanup(struct uaudio_dev *dev)
+{
+	int if_idx;
+
+	if (!dev->udev)
+		return;
+
+	/* free xfer buffer and unmap xfer ring and buf per interface */
+	for (if_idx = 0; if_idx < dev->num_intf; if_idx++) {
+		if (!dev->info[if_idx].in_use)
+			continue;
+		uaudio_dev_intf_cleanup(dev->udev, &dev->info[if_idx]);
+		dev_dbg(uaudio_qdev->dev, "release resources: intf# %d card# %d\n",
+			dev->info[if_idx].intf_num, dev->card_num);
+	}
+
+	dev->num_intf = 0;
+
+	/* free interface info */
+	kfree(dev->info);
+	dev->info = NULL;
+	uaudio_event_ring_cleanup_free(dev);
+	dev->udev = NULL;
+}
+
+/**
+ * qc_usb_audio_cleanup_qmi_dev() - release qmi device
+ *
+ * Frees the USB qdev.  Only occurs when there are no longer any potential
+ * devices that can utilize USB audio offloading.
+ *
+ */
+static void qc_usb_audio_cleanup_qmi_dev(void)
+{
+	kfree(uaudio_qdev);
+	uaudio_qdev = NULL;
+}
+
+/**
+ * qc_usb_audio_offload_disconnect() - platform op disconnect handler
+ * @intf: USB interface
+ *
+ * Platform disconnect handler.  Will ensure that any pending stream is
+ * halted by issuing a QMI disconnect indication packet to the adsp.
+ *
+ */
+static void qc_usb_audio_offload_disconnect(struct usb_interface *intf)
+{
+	struct snd_usb_audio *chip = usb_get_intfdata(intf);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct qmi_uaudio_stream_ind_msg_v01 disconnect_ind = {0};
+	struct uaudio_qmi_svc *svc = uaudio_svc;
+	struct uaudio_dev *dev;
+	int card_num;
+	int ret;
+
+	if (!chip)
+		return;
+
+	card_num = chip->card->number;
+	if (card_num >= SNDRV_CARDS)
+		return;
+
+
+	mutex_lock(&chip->mutex);
+	dev = &uadev[card_num];
+
+	/* clean up */
+	if (!dev->udev)
+		goto done;
+
+	if (atomic_read(&dev->in_use)) {
+		mutex_unlock(&chip->mutex);
+		dev_dbg(uaudio_qdev->dev, "sending qmi indication disconnect\n");
+		disconnect_ind.dev_event = USB_AUDIO_DEV_DISCONNECT_V01;
+		disconnect_ind.slot_id = dev->udev->slot_id;
+		disconnect_ind.controller_num = dev->usb_core_id;
+		disconnect_ind.controller_num_valid = 1;
+		ret = qmi_send_indication(svc->uaudio_svc_hdl, &svc->client_sq,
+				QMI_UAUDIO_STREAM_IND_V01,
+				QMI_UAUDIO_STREAM_IND_MSG_V01_MAX_MSG_LEN,
+				qmi_uaudio_stream_ind_msg_v01_ei,
+				&disconnect_ind);
+		if (ret < 0)
+			dev_err(uaudio_qdev->dev,
+				"qmi send failed with err: %d\n", ret);
+
+		ret = wait_event_interruptible_timeout(dev->disconnect_wq,
+				!atomic_read(&dev->in_use),
+				msecs_to_jiffies(DEV_RELEASE_WAIT_TIMEOUT));
+		if (!ret) {
+			dev_err(uaudio_qdev->dev,
+				"timeout while waiting for dev_release\n");
+			atomic_set(&dev->in_use, 0);
+		} else if (ret < 0) {
+			dev_err(uaudio_qdev->dev, "failed with ret %d\n", ret);
+			atomic_set(&dev->in_use, 0);
+		}
+		mutex_lock(&chip->mutex);
+	}
+
+	uaudio_dev_cleanup(dev);
+done:
+	uadev[card_num].chip = NULL;
+	mutex_unlock(&chip->mutex);
+
+	atomic_dec(&uaudio_qdev->qdev_in_use);
+	if (!atomic_read(&uaudio_qdev->qdev_in_use)) {
+		snd_soc_usb_disconnect(usb_get_usb_backend(udev));
+		mutex_lock(&qdev_mutex);
+		qc_usb_audio_cleanup_qmi_dev();
+		mutex_unlock(&qdev_mutex);
+	}
+}
+
+/**
+ * qc_usb_audio_offload_suspend() - USB offload PM suspend handler
+ * @intf: USB interface
+ * @message: suspend type
+ *
+ * PM suspend handler to ensure that the USB offloading driver is able to stop
+ * any pending traffic, so that the bus can be suspended.
+ *
+ */
+static void qc_usb_audio_offload_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct snd_usb_audio *chip = usb_get_intfdata(intf);
+	struct qmi_uaudio_stream_ind_msg_v01 disconnect_ind = {0};
+	struct uaudio_qmi_svc *svc = uaudio_svc;
+	struct uaudio_dev *dev;
+	int card_num;
+	int ret;
+
+	if (!chip)
+		return;
+
+	card_num = chip->card->number;
+	if (card_num >= SNDRV_CARDS)
+		return;
+
+
+	mutex_lock(&chip->mutex);
+	dev = &uadev[card_num];
+
+	if (atomic_read(&dev->in_use)) {
+		mutex_unlock(&chip->mutex);
+		dev_dbg(uaudio_qdev->dev, "sending qmi indication suspend\n");
+		disconnect_ind.dev_event = USB_AUDIO_DEV_DISCONNECT_V01;
+		disconnect_ind.slot_id = dev->udev->slot_id;
+		disconnect_ind.controller_num = dev->usb_core_id;
+		disconnect_ind.controller_num_valid = 1;
+		ret = qmi_send_indication(svc->uaudio_svc_hdl, &svc->client_sq,
+				QMI_UAUDIO_STREAM_IND_V01,
+				QMI_UAUDIO_STREAM_IND_MSG_V01_MAX_MSG_LEN,
+				qmi_uaudio_stream_ind_msg_v01_ei,
+				&disconnect_ind);
+		if (ret < 0)
+			dev_err(uaudio_qdev->dev,
+				"qmi send failed with err: %d\n", ret);
+
+		ret = wait_event_interruptible_timeout(dev->disconnect_wq,
+				!atomic_read(&dev->in_use),
+				msecs_to_jiffies(DEV_RELEASE_WAIT_TIMEOUT));
+		if (!ret) {
+			dev_err(uaudio_qdev->dev,
+				"timeout while waiting for dev_release\n");
+			atomic_set(&dev->in_use, 0);
+		} else if (ret < 0) {
+			dev_err(uaudio_qdev->dev, "failed with ret %d\n", ret);
+			atomic_set(&dev->in_use, 0);
+		}
+		mutex_lock(&chip->mutex);
+	}
+	mutex_unlock(&chip->mutex);
+}
+
+static struct snd_usb_platform_ops offload_ops = {
+	.connect_cb = qc_usb_audio_offload_probe,
+	.disconnect_cb = qc_usb_audio_offload_disconnect,
+	.suspend_cb = qc_usb_audio_offload_suspend,
+};
+
+static int __init qc_usb_audio_offload_init(void)
+{
+	struct uaudio_qmi_svc *svc;
+	int ret;
+
+	ret = snd_usb_register_platform_ops(&offload_ops);
+	if (ret < 0)
+		return ret;
+
+	svc = kzalloc(sizeof(struct uaudio_qmi_svc), GFP_KERNEL);
+	if (!svc) {
+		ret = -ENOMEM;
+		goto unreg_ops;
+	}
+
+	svc->uaudio_wq = create_singlethread_workqueue("uaudio_svc");
+	if (!svc->uaudio_wq) {
+		ret = -ENOMEM;
+		goto free_svc;
+	}
+
+	svc->uaudio_svc_hdl = kzalloc(sizeof(struct qmi_handle), GFP_KERNEL);
+	if (!svc->uaudio_svc_hdl) {
+		ret = -ENOMEM;
+		goto free_wq;
+	}
+
+	ret = qmi_handle_init(svc->uaudio_svc_hdl,
+				QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN,
+				&uaudio_svc_ops_options,
+				&uaudio_stream_req_handlers);
+	ret = qmi_add_server(svc->uaudio_svc_hdl, UAUDIO_STREAM_SERVICE_ID_V01,
+					UAUDIO_STREAM_SERVICE_VERS_V01, 0);
+
+	INIT_WORK(&svc->qmi_disconnect_work, qmi_disconnect_work);
+	uaudio_svc = svc;
+
+	return 0;
+
+free_wq:
+	destroy_workqueue(svc->uaudio_wq);
+free_svc:
+	kfree(svc);
+unreg_ops:
+	snd_usb_unregister_platform_ops();
+
+	return ret;
+}
+
+static void __exit qc_usb_audio_offload_exit(void)
+{
+	struct uaudio_qmi_svc *svc = uaudio_svc;
+
+	qmi_handle_release(svc->uaudio_svc_hdl);
+	flush_workqueue(svc->uaudio_wq);
+	destroy_workqueue(svc->uaudio_wq);
+	kfree(svc);
+	uaudio_svc = NULL;
+	snd_usb_unregister_platform_ops();
+}
+
+module_init(qc_usb_audio_offload_init);
+module_exit(qc_usb_audio_offload_exit);
+
+MODULE_DESCRIPTION("QC USB Audio Offloading");
+MODULE_LICENSE("GPL");
diff --git a/sound/usb/qcom/usb_audio_qmi_v01.c b/sound/usb/qcom/usb_audio_qmi_v01.c
new file mode 100644
index 000000000000..95ae434f0a41
--- /dev/null
+++ b/sound/usb/qcom/usb_audio_qmi_v01.c
@@ -0,0 +1,892 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/soc/qcom/qmi.h>
+
+#include "usb_audio_qmi_v01.h"
+
+static struct qmi_elem_info mem_info_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_8_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u64),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct mem_info_v01, va),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_8_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u64),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct mem_info_v01, pa),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct mem_info_v01, size),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info apps_mem_info_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, evt_ring),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, tr_data),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, tr_sync),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, xfer_buff),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, dcba),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info usb_endpoint_descriptor_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bLength),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bDescriptorType),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bEndpointAddress),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bmAttributes),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_2_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						wMaxPacketSize),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bInterval),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bRefresh),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bSynchAddress),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info usb_interface_descriptor_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bLength),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bDescriptorType),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceNumber),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bAlternateSetting),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bNumEndpoints),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceClass),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceSubClass),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceProtocol),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						iInterface),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info qmi_uaudio_stream_req_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x01,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						enable),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						usb_token),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						audio_format_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						audio_format),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						number_of_ch_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						number_of_ch),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						bit_rate_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						bit_rate),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						xfer_buff_size_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						xfer_buff_size),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						service_interval_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						service_interval),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info qmi_uaudio_stream_resp_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					resp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					status_valid),
+	},
+	{
+		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len	= 1,
+		.elem_size	= sizeof(enum usb_audio_stream_status_enum_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					status),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					internal_status_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					internal_status),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					slot_id_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					slot_id),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_token_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_token),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_opr_intf_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_interface_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_opr_intf_desc),
+		.ei_array	= usb_interface_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_data_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_data_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_sync_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_sync_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_spec_revision_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_2_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_spec_revision),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					data_path_delay_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					data_path_delay),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_subslot_size_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_subslot_size),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1A,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					xhci_mem_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct apps_mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1A,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					xhci_mem_info),
+		.ei_array	= apps_mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1B,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					interrupter_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1B,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					interrupter_num),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1C,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					speed_info_valid),
+	},
+	{
+		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len	= 1,
+		.elem_size	= sizeof(enum usb_audio_device_speed_enum_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1C,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					speed_info),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1D,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					controller_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1D,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					controller_num),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info qmi_uaudio_stream_ind_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len	= 1,
+		.elem_size	= sizeof(
+				enum usb_audio_device_indication_enum_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x01,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						dev_event),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						slot_id),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_token_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_token),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_opr_intf_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_interface_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_opr_intf_desc),
+		.ei_array	= usb_interface_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_data_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_data_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_sync_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_sync_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_spec_revision_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_2_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_spec_revision),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						data_path_delay_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						data_path_delay),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_subslot_size_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_subslot_size),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						xhci_mem_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct apps_mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						xhci_mem_info),
+		.ei_array	= apps_mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						interrupter_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						interrupter_num),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						controller_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						controller_num),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
diff --git a/sound/usb/qcom/usb_audio_qmi_v01.h b/sound/usb/qcom/usb_audio_qmi_v01.h
new file mode 100644
index 000000000000..4e9b5f0bcddf
--- /dev/null
+++ b/sound/usb/qcom/usb_audio_qmi_v01.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef USB_QMI_V01_H
+#define USB_QMI_V01_H
+
+#define UAUDIO_STREAM_SERVICE_ID_V01 0x41D
+#define UAUDIO_STREAM_SERVICE_VERS_V01 0x01
+
+#define QMI_UAUDIO_STREAM_RESP_V01 0x0001
+#define QMI_UAUDIO_STREAM_REQ_V01 0x0001
+#define QMI_UAUDIO_STREAM_IND_V01 0x0001
+
+
+struct mem_info_v01 {
+	u64 va;
+	u64 pa;
+	u32 size;
+};
+
+struct apps_mem_info_v01 {
+	struct mem_info_v01 evt_ring;
+	struct mem_info_v01 tr_data;
+	struct mem_info_v01 tr_sync;
+	struct mem_info_v01 xfer_buff;
+	struct mem_info_v01 dcba;
+};
+
+struct usb_endpoint_descriptor_v01 {
+	u8 bLength;
+	u8 bDescriptorType;
+	u8 bEndpointAddress;
+	u8 bmAttributes;
+	u16 wMaxPacketSize;
+	u8 bInterval;
+	u8 bRefresh;
+	u8 bSynchAddress;
+};
+
+struct usb_interface_descriptor_v01 {
+	u8 bLength;
+	u8 bDescriptorType;
+	u8 bInterfaceNumber;
+	u8 bAlternateSetting;
+	u8 bNumEndpoints;
+	u8 bInterfaceClass;
+	u8 bInterfaceSubClass;
+	u8 bInterfaceProtocol;
+	u8 iInterface;
+};
+
+enum usb_audio_stream_status_enum_v01 {
+	USB_AUDIO_STREAM_STATUS_ENUM_MIN_VAL_V01 = INT_MIN,
+	USB_AUDIO_STREAM_REQ_SUCCESS_V01 = 0,
+	USB_AUDIO_STREAM_REQ_FAILURE_V01 = 1,
+	USB_AUDIO_STREAM_REQ_FAILURE_NOT_FOUND_V01 = 2,
+	USB_AUDIO_STREAM_REQ_FAILURE_INVALID_PARAM_V01 = 3,
+	USB_AUDIO_STREAM_REQ_FAILURE_MEMALLOC_V01 = 4,
+	USB_AUDIO_STREAM_STATUS_ENUM_MAX_VAL_V01 = INT_MAX,
+};
+
+enum usb_audio_device_indication_enum_v01 {
+	USB_AUDIO_DEVICE_INDICATION_ENUM_MIN_VAL_V01 = INT_MIN,
+	USB_AUDIO_DEV_CONNECT_V01 = 0,
+	USB_AUDIO_DEV_DISCONNECT_V01 = 1,
+	USB_AUDIO_DEV_SUSPEND_V01 = 2,
+	USB_AUDIO_DEV_RESUME_V01 = 3,
+	USB_AUDIO_DEVICE_INDICATION_ENUM_MAX_VAL_V01 = INT_MAX,
+};
+
+enum usb_audio_device_speed_enum_v01 {
+	USB_AUDIO_DEVICE_SPEED_ENUM_MIN_VAL_V01 = INT_MIN,
+	USB_AUDIO_DEVICE_SPEED_INVALID_V01 = 0,
+	USB_AUDIO_DEVICE_SPEED_LOW_V01 = 1,
+	USB_AUDIO_DEVICE_SPEED_FULL_V01 = 2,
+	USB_AUDIO_DEVICE_SPEED_HIGH_V01 = 3,
+	USB_AUDIO_DEVICE_SPEED_SUPER_V01 = 4,
+	USB_AUDIO_DEVICE_SPEED_SUPER_PLUS_V01 = 5,
+	USB_AUDIO_DEVICE_SPEED_ENUM_MAX_VAL_V01 = INT_MAX,
+};
+
+struct qmi_uaudio_stream_req_msg_v01 {
+	u8 enable;
+	u32 usb_token;
+	u8 audio_format_valid;
+	u32 audio_format;
+	u8 number_of_ch_valid;
+	u32 number_of_ch;
+	u8 bit_rate_valid;
+	u32 bit_rate;
+	u8 xfer_buff_size_valid;
+	u32 xfer_buff_size;
+	u8 service_interval_valid;
+	u32 service_interval;
+};
+#define QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN 46
+extern struct qmi_elem_info qmi_uaudio_stream_req_msg_v01_ei[];
+
+struct qmi_uaudio_stream_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	u8 status_valid;
+	enum usb_audio_stream_status_enum_v01 status;
+	u8 internal_status_valid;
+	u32 internal_status;
+	u8 slot_id_valid;
+	u32 slot_id;
+	u8 usb_token_valid;
+	u32 usb_token;
+	u8 std_as_opr_intf_desc_valid;
+	struct usb_interface_descriptor_v01 std_as_opr_intf_desc;
+	u8 std_as_data_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_data_ep_desc;
+	u8 std_as_sync_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_sync_ep_desc;
+	u8 usb_audio_spec_revision_valid;
+	u16 usb_audio_spec_revision;
+	u8 data_path_delay_valid;
+	u8 data_path_delay;
+	u8 usb_audio_subslot_size_valid;
+	u8 usb_audio_subslot_size;
+	u8 xhci_mem_info_valid;
+	struct apps_mem_info_v01 xhci_mem_info;
+	u8 interrupter_num_valid;
+	u8 interrupter_num;
+	u8 speed_info_valid;
+	enum usb_audio_device_speed_enum_v01 speed_info;
+	u8 controller_num_valid;
+	u8 controller_num;
+};
+#define QMI_UAUDIO_STREAM_RESP_MSG_V01_MAX_MSG_LEN 202
+extern struct qmi_elem_info qmi_uaudio_stream_resp_msg_v01_ei[];
+
+struct qmi_uaudio_stream_ind_msg_v01 {
+	enum usb_audio_device_indication_enum_v01 dev_event;
+	u32 slot_id;
+	u8 usb_token_valid;
+	u32 usb_token;
+	u8 std_as_opr_intf_desc_valid;
+	struct usb_interface_descriptor_v01 std_as_opr_intf_desc;
+	u8 std_as_data_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_data_ep_desc;
+	u8 std_as_sync_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_sync_ep_desc;
+	u8 usb_audio_spec_revision_valid;
+	u16 usb_audio_spec_revision;
+	u8 data_path_delay_valid;
+	u8 data_path_delay;
+	u8 usb_audio_subslot_size_valid;
+	u8 usb_audio_subslot_size;
+	u8 xhci_mem_info_valid;
+	struct apps_mem_info_v01 xhci_mem_info;
+	u8 interrupter_num_valid;
+	u8 interrupter_num;
+	u8 controller_num_valid;
+	u8 controller_num;
+};
+#define QMI_UAUDIO_STREAM_IND_MSG_V01_MAX_MSG_LEN 181
+extern struct qmi_elem_info qmi_uaudio_stream_ind_msg_v01_ei[];
+
+#endif
