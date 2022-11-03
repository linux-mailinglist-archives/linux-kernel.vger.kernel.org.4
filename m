Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09DE6183D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKCQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKCQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:07:59 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB4E18B32;
        Thu,  3 Nov 2022 09:07:54 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FxVQo026919;
        Thu, 3 Nov 2022 16:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=yEYFuNfnfU7EZumdDn0VomNI6piViCEvsXu1bSlFvEk=;
 b=CGwFSf9TlSKpfs0KbXDLQV/GzCegQXVvqUXkTtJSIJLINHr3A86JXuBSB6mF57+7zkj6
 VwuiUsk6YY3fICzcpvBOfP69EPqf6Qr0W0jfr2VTyo64rBAEiE0RaY1T/lL7Uq4xlZNL
 TyAMMtLiHR+weOE4Y9+/S1TSVxaipOCHRAAd/Nk1QhQfI9QXyJIJNC25wF0/50o/D0bH
 t+FelsO+GnSjEnfrctrQhBPZaHWL0hcNX2K/LoZ5Rn/WR6eBITP8SFOlsgG7Q0X8zbCB
 lo6cWWNelxhqjsngLrd36xzyFdcgPPRXeSt77qKnoYM9Ul0u937jqiCpl+EOaA5naeRx 1w== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kmgs5r3es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:07:34 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 62BA8295AB;
        Thu,  3 Nov 2022 16:07:33 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D01DA804D22;
        Thu,  3 Nov 2022 16:07:32 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, richard.yu@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/7] usb: gadget: udc: gxp_udc: add gxp USB support
Date:   Thu,  3 Nov 2022 11:06:19 -0500
Message-Id: <20221103160625.15574-2-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103160625.15574-1-richard.yu@hpe.com>
References: <20221103160625.15574-1-richard.yu@hpe.com>
X-Proofpoint-GUID: -Ig6TUUZ93omwRfThA152xaOkyATGqTo
X-Proofpoint-ORIG-GUID: -Ig6TUUZ93omwRfThA152xaOkyATGqTo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=922 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030107
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

The GXP vEHCI controller presents an 8 port EHCI compatible PCI function
to host software. Each EHCI port is logically connected to a
corresponding set of virtual device registers.

Signed-off-by: Richard Yu <richard.yu@hpe.com>
---
 drivers/usb/gadget/udc/Kconfig   |    6 +
 drivers/usb/gadget/udc/Makefile  |    1 +
 drivers/usb/gadget/udc/gxp_udc.c | 1300 ++++++++++++++++++++++++++++++
 3 files changed, 1307 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/gxp_udc.c

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 5756acb07b8d..5eab5c140edf 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -463,6 +463,12 @@ config USB_TEGRA_XUDC
 	 dynamically linked module called "tegra_xudc" and force all
 	 gadget drivers to also be dynamically linked.
 
+config USB_GXP_UDC
+        bool "GXP UDC Driver"
+        depends on ARCH_HPE_GXP || COMPILE_TEST
+        help
+          Say "y" to add support for GXP UDC driver
+
 config USB_ASPEED_UDC
 	tristate "Aspeed UDC driver support"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 12f9e4c9eb0c..e1d6e0711b4d 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -43,3 +43,4 @@ obj-$(CONFIG_USB_ASPEED_VHUB)	+= aspeed-vhub/
 obj-$(CONFIG_USB_ASPEED_UDC)	+= aspeed_udc.o
 obj-$(CONFIG_USB_BDC_UDC)	+= bdc/
 obj-$(CONFIG_USB_MAX3420_UDC)	+= max3420_udc.o
+obj-$(CONFIG_USB_GXP_UDC)	+= gxp_udc.o
diff --git a/drivers/usb/gadget/udc/gxp_udc.c b/drivers/usb/gadget/udc/gxp_udc.c
new file mode 100644
index 000000000000..2e046f88af6c
--- /dev/null
+++ b/drivers/usb/gadget/udc/gxp_udc.c
@@ -0,0 +1,1300 @@
+// SPDX-License-Identifier: GPL-2.0=or-later
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
+#include <linux/prefetch.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#define EVGBASE			0x0800
+#define EVGISTAT		0x0000
+#define EVGIEN			0x0004
+#define EVDBG			0x0008
+#define EVFEMAP			0x0010
+#define EVFEMAP_VDEVNUM_MASK	0x07
+#define EVFEMAP_VDEVNUM(val)	val
+#define EVFEMAP_EPNUM_MASK	0x70
+#define EVFEMAP_EPNUM(val)	((val) << 4)
+
+#define EVDBASE			0x1000
+#define EVDISTAT		0x0000
+#define EVDISTAT_ALL_EP_INT	0x000000ff
+#define EVDISTAT_EP0_INT	0x00000001
+#define EVDISTAT_EP1_INT	0x00000002
+#define EVDISTAT_EP2_INT	0x00000004
+#define EVDISTAT_EP3_INT	0x00000008
+#define EVDISTAT_EP4_INT	0x00000010
+#define EVDISTAT_EP5_INT	0x00000020
+#define EVDISTAT_EP6_INT	0x00000040
+#define EVDISTAT_EP7_INT	0x00000080
+#define EVDISTAT_SETUP_DAT_RCV	0x00010000
+#define EVDISTAT_PORTEN_CHANGE	0x00100000
+#define EVDISTAT_PORTRST	0x80000000
+
+#define EVDIEN			0x0004
+
+#define EVDISTAT_MASK	(EVDISTAT_SETUP_DAT_RCV | EVDISTAT_PORTEN_CHANGE | \
+			 EVDISTAT_PORTRST | EVDISTAT_ALL_EP_INT)
+#define EVDIEN_MASK	(EVDISTAT_SETUP_DAT_RCV | EVDISTAT_PORTEN_CHANGE | \
+			 EVDISTAT_PORTRST | EVDISTAT_EP0_INT)
+
+#define EVDCS			0x0008
+#define EVDCS_CONNECT		0x00000001
+#define EVDCS_PORTENABLESTS	0x01000000
+
+#define EVDADDR			0x000c
+#define EVDSETUPL		0x0010
+#define EVDSETUPH		0x0014
+
+#define EVDEPCC				0x0000
+#define EVDEPCC_EPENABLE		0x00000001
+#define EVDEPCC_CFGINOUT		0x00000002
+#define EVDEPCC_DT_RESET		0x00000004
+#define EVDEPCC_DISARMCMD		0x00000020
+#define EVDEPCC_STALL			0x00000080
+#define EVDEPCC_TXN_PER_UFRAME_MASK	0x00030000
+#define EVDEPCC_TXN_PER_UFRAME(val)	((val) << 16)
+#define EVDEPCC_EP_TYPE_MASK		0x000C0000
+#define EVDEPCC_EP_TYPE(val)		((val) << 18)
+#define EVDEPCC_EP_SIZE_MASK		0x00700000
+#define EVDEPCC_EP_SIZE(val)		((val) << 20)
+
+#define EP_TYPE_CONTROL	0x00
+#define EP_TYPE_BULK	0x01
+#define EP_TYPE_INT	0x02
+#define EP_TYPE_ISOC	0x03
+
+#define EP_IN	0x01
+#define EP_OUT	0x00
+
+#define EVDEPSTS		0x0004
+#define EVDEPSTS_DONE		0x00000001
+#define EVDEPSTS_SHORT		0x00000002
+#define EVDEPSTS_STALLDET	0x00000004
+#define EVDEPSTS_BUFARMED	0x00010000
+
+#define EVDEPEVTEN		0x0008
+#define EVDEPEVTEN_DONE		0x00000001
+#define EVDEPEVTEN_SHORT	0x00000002
+#define EVDEPEVTEN_STALLDET	0x00000004
+#define EVDEPADDR		0x000c
+#define EVDEPLEN		0x0010
+#define EVDEPNTX		0x0014
+
+#define GXP_UDC_MAX_NUM_EP			8
+#define GXP_UDC_MAX_NUM_FLEX_EP			16
+#define GXP_UDC_MAX_NUM_VDEVICE			8
+#define GXP_UDC_MAX_NUM_FLEX_EP_PER_VDEV	7
+
+static bool udcg_init_done;
+
+static const char * const gxp_udc_name[] = {
+	"gxp-udc0", "gxp-udc1", "gxp-udc2", "gxp-udc3",
+	"gxp-udc4", "gxp-udc5", "gxp-udc6", "gxp-udc7"};
+
+static const char * const gxp_udc_ep_name[] = {
+	"ep0", "ep1", "ep2", "ep3", "ep4", "ep5", "ep6", "ep7"};
+
+struct gxp_udc_req {
+	struct usb_request req;
+	struct list_head queue;
+};
+
+struct gxp_udc_ep {
+	void __iomem *base;
+	struct gxp_udc_drvdata *drvdata;
+
+	struct usb_ep ep;
+	struct list_head queue;
+	unsigned char epnum;
+	unsigned char type;
+	bool stall;
+	bool wedged;
+	int is_in;
+};
+
+struct gxp_udc_drvdata {
+	void __iomem *base;
+	struct platform_device *pdev;
+	struct regmap *udcg_map;
+	struct gxp_udc_ep ep[GXP_UDC_MAX_NUM_EP];
+
+	int irq;
+	struct usb_gadget gadget;
+	struct usb_gadget_driver *driver;
+
+	u32 vdevnum;
+	u32 fepnum;
+	u32 devaddr;
+
+	__le16	ep0_data;
+	struct usb_request *ep0_req;
+	bool deffer_set_address;
+
+	/* This lock is used to protect the drvdata structure access */
+	spinlock_t	lock;
+};
+
+static void gxp_udc_out_0byte_status(struct gxp_udc_ep *ep);
+static void gxp_udc_in_0byte_status(struct gxp_udc_ep *ep);
+
+static unsigned char gxp_udc_femap_read(struct gxp_udc_drvdata *drvdata,
+					int fep)
+{
+	unsigned int value;
+	int i = fep & 0x03;
+
+	regmap_read(drvdata->udcg_map, EVFEMAP + (fep & ~0x03), &value);
+	value = (value >> (8 * i)) & 0xff;
+
+	return  (unsigned char)value;
+}
+
+static void gxp_udc_femap_write(struct gxp_udc_drvdata *drvdata, int fep,
+				unsigned char value)
+{
+	unsigned int reg;
+	unsigned int tmp = value;
+	int i = fep & 0x03;
+
+	regmap_read(drvdata->udcg_map, EVFEMAP + (fep & ~0x03), &reg);
+	tmp = tmp << (8 * i);
+	reg &= ~(0xff << (8 * i));
+	reg |= tmp;
+	regmap_write(drvdata->udcg_map, EVFEMAP + (fep & ~0x03), reg);
+}
+
+static int gxp_udc_start_dma(struct gxp_udc_ep *ep, struct gxp_udc_req *req)
+{
+	writel(req->req.dma, ep->base + EVDEPADDR);
+	writel(req->req.length, ep->base + EVDEPLEN);
+
+	return 0;
+}
+
+static int gxp_udc_done_dma(struct gxp_udc_ep *ep, struct gxp_udc_req *req)
+{
+	u32 len;
+
+	len = readl(ep->base + EVDEPLEN);
+	req->req.actual = req->req.length - len;
+
+	if (len && ep->is_in) {
+		/* remaining data to send, rearm again */
+		writel(len, ep->base + EVDEPLEN);
+		return 0;
+	}
+	return 1;
+}
+
+static u32 evdepcc_ep_type(int value)
+{
+	switch (value) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		/* control */
+		return EP_TYPE_CONTROL;
+
+	case USB_ENDPOINT_XFER_ISOC:
+		/* isochronous */
+		return EP_TYPE_ISOC;
+
+	case USB_ENDPOINT_XFER_BULK:
+		/* bulk */
+		return EP_TYPE_BULK;
+
+	case USB_ENDPOINT_XFER_INT:
+		/* interrupt */
+		return EP_TYPE_INT;
+
+	default:
+		return 0;
+	}
+}
+
+static u32 evdepcc_ep_size(int value)
+{
+	switch (value) {
+	case 8:
+		return 0x00;
+	case 16:
+		return 0x01;
+	case 32:
+		return 0x02;
+	case 64:
+		return 0x03;
+	case 128:
+		return 0x04;
+	case 256:
+		return 0x05;
+	case 512:
+		return 0x06;
+	case 1024:
+	default:
+		return 0x07;
+	}
+}
+
+static int gxp_udc_ep_init(struct gxp_udc_ep *ep, int type, int dir_in,
+			   int size)
+{
+	u32 val;
+	u32 tmp;
+
+	ep->is_in = dir_in;
+	ep->type = type;
+	ep->ep.maxpacket = size;
+
+	val = readl(ep->base + EVDEPCC);
+	if (dir_in) {
+		/* to host */
+		val |= EVDEPCC_CFGINOUT;
+	} else {
+		/* to device */
+		val &= ~EVDEPCC_CFGINOUT;
+	}
+
+	tmp = evdepcc_ep_type(type);
+	val &= ~EVDEPCC_EP_TYPE_MASK;
+	val |= EVDEPCC_EP_TYPE(tmp);
+
+	tmp = evdepcc_ep_size(size);
+	val &= ~EVDEPCC_EP_SIZE_MASK;
+	val |= EVDEPCC_EP_SIZE(tmp);
+
+	val &= ~EVDEPCC_TXN_PER_UFRAME_MASK;
+	if (type == USB_ENDPOINT_XFER_INT ||
+	    type == USB_ENDPOINT_XFER_ISOC) {
+		val |= EVDEPCC_TXN_PER_UFRAME(1);
+	}
+
+	val |= EVDEPCC_EPENABLE;
+	writel(val, ep->base + EVDEPCC);
+
+	val = readl(ep->base + EVDEPSTS);
+	val &= ~(EVDEPSTS_DONE | EVDEPSTS_SHORT | EVDEPSTS_STALLDET);
+	writel(val, ep->base + EVDEPSTS);
+
+	val = readl(ep->base + EVDEPEVTEN);
+	val |= EVDEPEVTEN_DONE;
+	val |= EVDEPEVTEN_SHORT;
+	val |= EVDEPEVTEN_STALLDET;
+	writel(val, ep->base + EVDEPEVTEN);
+
+	return 0;
+}
+
+static struct usb_request *gxp_udc_ep_alloc_request(struct usb_ep *_ep,
+						    gfp_t gfp_flags)
+{
+	struct gxp_udc_req *req;
+	struct gxp_udc_ep *ep;
+
+	req = kzalloc(sizeof(*req), gfp_flags);
+	if (!req)
+		return NULL;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+	pr_debug("%s: ep%d\n", __func__, ep->epnum);
+
+	INIT_LIST_HEAD(&req->queue);
+
+	return &req->req;
+}
+
+static void gxp_udc_ep_free_request(struct usb_ep *_ep,
+				    struct usb_request *_req)
+{
+	struct gxp_udc_req *req;
+	struct gxp_udc_ep *ep;
+
+	if (!_req)
+		return;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+	pr_debug("%s: ep%d\n", __func__, ep->epnum);
+
+	req = container_of(_req, struct gxp_udc_req, req);
+	WARN_ON(!list_empty(&req->queue));
+	kfree(req);
+}
+
+static int gxp_udc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+			    gfp_t gfp_flags)
+{
+	struct gxp_udc_req *req;
+	struct gxp_udc_ep *ep;
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	if (!_req || !_ep)
+		return -EINVAL;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+	req = container_of(_req, struct gxp_udc_req, req);
+
+	if (!ep->drvdata->driver ||
+	    ep->drvdata->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+
+	pr_debug("%s: vdev%d ep%d\n",
+		 __func__, ep->drvdata->vdevnum, ep->epnum);
+
+	spin_lock_irqsave(&ep->drvdata->lock, flags);
+
+	if (ep->epnum == 0) {
+		val = readl(ep->base + EVDEPCC);
+		ep->is_in = (val & EVDEPCC_CFGINOUT) ? 1 : 0;
+
+		if (!_req->length) {
+			/* ep0 control write transaction no data stage. */
+			_req->status = 0;
+
+			if (_req->complete) {
+				spin_unlock(&ep->drvdata->lock);
+				usb_gadget_giveback_request(_ep, _req);
+				spin_lock(&ep->drvdata->lock);
+			}
+
+			gxp_udc_in_0byte_status(ep);
+			return 0;
+		}
+	}
+
+	ret = usb_gadget_map_request(&ep->drvdata->gadget,
+				     &req->req, ep->is_in);
+	if (ret) {
+		dev_dbg(&ep->drvdata->pdev->dev,
+			"usb_gadget_map_request failed ep%d\n", ep->epnum);
+		spin_unlock_irqrestore(&ep->drvdata->lock, flags);
+		return ret;
+	}
+
+	req->req.actual = 0;
+	req->req.status = -EINPROGRESS;
+
+	if (list_empty(&ep->queue)) {
+		list_add_tail(&req->queue, &ep->queue);
+		gxp_udc_start_dma(ep, req);
+	} else {
+		list_add_tail(&req->queue, &ep->queue);
+	}
+
+	spin_unlock_irqrestore(&ep->drvdata->lock, flags);
+
+	return 0;
+}
+
+static int gxp_udc_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
+{
+	struct gxp_udc_req *req;
+	struct gxp_udc_ep *ep;
+	unsigned long flags;
+
+	if (!_ep || !_req)
+		return -EINVAL;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+	req = container_of(_req, struct gxp_udc_req, req);
+
+	pr_debug("%s: vdev%d ep%d\n",
+		 __func__, ep->drvdata->vdevnum, ep->epnum);
+
+	spin_lock_irqsave(&ep->drvdata->lock, flags);
+
+	/* ensure the req is still queued on this ep */
+	list_for_each_entry(req, &ep->queue, queue) {
+		if (&req->req == _req)
+			break;
+	}
+	if (&req->req != _req) {
+		pr_debug("%s: vdev%d ep%d _req is not queued in this ep\n",
+			 __func__, ep->drvdata->vdevnum, ep->epnum);
+		spin_unlock_irqrestore(&ep->drvdata->lock, flags);
+		return -EINVAL;
+	}
+
+	if (ep->drvdata->gadget.speed == USB_SPEED_UNKNOWN)
+		_req->status = -ESHUTDOWN;
+	else
+		_req->status = -ECONNRESET;
+
+	/* remove req from queue */
+	list_del_init(&req->queue);
+	usb_gadget_unmap_request(&ep->drvdata->gadget, &req->req, ep->is_in);
+	if (req->req.complete) {
+		spin_unlock(&ep->drvdata->lock);
+		usb_gadget_giveback_request(_ep, _req);
+		spin_lock(&ep->drvdata->lock);
+	}
+
+	spin_unlock_irqrestore(&ep->drvdata->lock, flags);
+
+	return 0;
+}
+
+static int gxp_udc_ep_enable(struct usb_ep *_ep,
+			     const struct usb_endpoint_descriptor *desc)
+{
+	struct gxp_udc_ep *ep;
+	struct gxp_udc_drvdata *drvdata;
+	u32 val;
+
+	if (!_ep)
+		return -EINVAL;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+	drvdata = ep->drvdata;
+
+	pr_debug("%s vdev%d ep%d\n", __func__, drvdata->vdevnum, ep->epnum);
+
+	if (!drvdata->driver || drvdata->gadget.speed == USB_SPEED_UNKNOWN) {
+		dev_err(&drvdata->pdev->dev,
+			"vdev%d ep enable failed no driver or speed unknown\n",
+			drvdata->vdevnum);
+		return -ESHUTDOWN;
+	}
+
+	if (usb_endpoint_num(desc) > GXP_UDC_MAX_NUM_EP) {
+		dev_err(&drvdata->pdev->dev,
+			"vdev%d ep enable failed ep%d is out of range(%d)\n",
+			drvdata->vdevnum, usb_endpoint_num(desc),
+			GXP_UDC_MAX_NUM_EP);
+		return -EINVAL;
+	}
+
+	ep->ep.desc = desc;
+
+	ep->stall = false;
+	ep->wedged = false;
+
+	/* setup ep according to the setting of desc */
+	gxp_udc_ep_init(ep, usb_endpoint_type(desc), usb_endpoint_dir_in(desc),
+			usb_endpoint_maxp(desc));
+
+	/* enable ep interrupt */
+	val = readl(drvdata->base + EVDIEN);
+	val |= 1 << ep->epnum;
+	writel(val, drvdata->base + EVDIEN);
+
+	return 0;
+}
+
+static int gxp_udc_ep_disable(struct usb_ep *_ep)
+{
+	struct gxp_udc_ep *ep;
+	struct gxp_udc_req *req;
+	unsigned long flags;
+	u32 val;
+
+	if (!_ep)
+		return -EINVAL;
+
+	if (!_ep->desc)
+		return -EINVAL;
+
+	_ep->desc = NULL;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+	ep->stall = false;
+	ep->wedged = false;
+
+	pr_debug("%s vdev%d ep%d\n",
+		 __func__, ep->drvdata->vdevnum, ep->epnum);
+	spin_lock_irqsave(&ep->drvdata->lock, flags);
+
+	/* clean queue */
+	while (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next, struct gxp_udc_req, queue);
+		gxp_udc_ep_dequeue(&ep->ep, &req->req);
+	}
+
+	/* disable ep */
+	val = readl(ep->base + EVDEPCC);
+	val &= ~EVDEPCC_EPENABLE;
+	writel(val, ep->base + EVDEPCC);
+
+	/* disable interrupt */
+	val = readl(ep->drvdata->base + EVDIEN);
+	val &= ~(1 << ep->epnum);
+	writel(val, ep->drvdata->base + EVDIEN);
+
+	spin_unlock_irqrestore(&ep->drvdata->lock, flags);
+
+	return 0;
+}
+
+static int gxp_udc_ep_set_halt_and_wedge(struct usb_ep *_ep,
+					 int value, int wedge)
+{
+	struct gxp_udc_ep *ep;
+	struct gxp_udc_req *req;
+	u32 val;
+
+	if (!_ep)
+		return -EINVAL;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+
+	pr_debug("vdev%d ep%d gxp_udc_ep_set_halt(%d)\n",
+		 ep->drvdata->vdevnum, ep->epnum, value);
+
+	val = readl(ep->base + EVDEPCC);
+
+	/* value = 1, halt on endpoint. 0, clear halt */
+	if (value) {
+		ep->stall = true;
+		if (wedge)
+			ep->wedged = true;
+
+		val |= EVDEPCC_STALL;
+		writel(val, ep->base + EVDEPCC);
+	} else {
+		ep->stall = false;
+		ep->wedged = false;
+
+		val &= ~EVDEPCC_STALL;
+		val |= EVDEPCC_DT_RESET;
+		writel(val, ep->base + EVDEPCC);
+
+		/*
+		 * resume dma if it is in endpoint and there is
+		 * request in queue when clear halt
+		 */
+		if (ep->is_in && !list_empty(&ep->queue) && !value) {
+			req = list_entry(ep->queue.next,
+					 struct gxp_udc_req, queue);
+			if (req)
+				gxp_udc_start_dma(ep, req);
+		}
+	}
+
+	return 0;
+}
+
+static int gxp_udc_ep_set_halt(struct usb_ep *_ep, int value)
+{
+	struct gxp_udc_ep *ep;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+
+	pr_debug("%s: vdev%d ep%d value:%d\n",
+		 __func__, ep->drvdata->vdevnum, ep->epnum, value);
+	return gxp_udc_ep_set_halt_and_wedge(_ep, value, 0);
+}
+
+static int gxp_udc_ep_set_wedge(struct usb_ep *_ep)
+{
+	struct gxp_udc_ep *ep;
+
+	ep = container_of(_ep, struct gxp_udc_ep, ep);
+
+	pr_debug("%s: vdev%d ep%d\n",
+		 __func__, ep->drvdata->vdevnum, ep->epnum);
+	return gxp_udc_ep_set_halt_and_wedge(_ep, 1, 1);
+}
+
+static const struct usb_ep_ops gxp_udc_ep_ops = {
+	.enable = gxp_udc_ep_enable,
+	.disable = gxp_udc_ep_disable,
+
+	.alloc_request = gxp_udc_ep_alloc_request,
+	.free_request = gxp_udc_ep_free_request,
+
+	.queue = gxp_udc_ep_queue,
+	.dequeue = gxp_udc_ep_dequeue,
+
+	.set_halt = gxp_udc_ep_set_halt,
+	.set_wedge	= gxp_udc_ep_set_wedge,
+};
+
+static int gxp_udc_connect(struct gxp_udc_drvdata *drvdata)
+{
+	unsigned int val;
+	unsigned char femap;
+	int i;
+	int j;
+
+	/* clear event before enable int */
+	val = readl(drvdata->base + EVDISTAT);
+	val |= EVDISTAT_MASK;
+	val |= (EVDISTAT_SETUP_DAT_RCV | EVDISTAT_PORTEN_CHANGE | EVDISTAT_PORTRST);
+	writel(val, drvdata->base + EVDISTAT);
+
+	/* ep0 init */
+	gxp_udc_ep_init(&drvdata->ep[0], USB_ENDPOINT_XFER_CONTROL, EP_IN, 64);
+
+	/* enable interrupt */
+	val = readl(drvdata->base + EVDIEN);
+	val |= EVDIEN_MASK;
+	writel(val, drvdata->base + EVDIEN);
+
+	/* enable vdevice interrupt */
+	regmap_update_bits(drvdata->udcg_map, EVGIEN, BIT(drvdata->vdevnum),
+			   BIT(drvdata->vdevnum));
+
+	/* initial flex ep */
+	for (j = 1; j < drvdata->fepnum + 1; j++) {
+		for (i = 0; i < GXP_UDC_MAX_NUM_FLEX_EP; i++) {
+			femap = gxp_udc_femap_read(drvdata, i);
+			/* if the flex ep is free (ep==0) */
+			if (!(femap & EVFEMAP_EPNUM_MASK)) {
+				femap &= ~EVFEMAP_EPNUM_MASK;
+				femap |= EVFEMAP_EPNUM(j);
+				femap &= ~EVFEMAP_VDEVNUM_MASK;
+				femap |= EVFEMAP_VDEVNUM(drvdata->vdevnum);
+				gxp_udc_femap_write(drvdata, i, femap);
+				break;
+			}
+		}
+		if (i == GXP_UDC_MAX_NUM_FLEX_EP) {
+			dev_err(&drvdata->pdev->dev,
+				"vdev%d cannot find a free flex ep\n",
+				drvdata->vdevnum);
+			return -ENODEV;
+		}
+	}
+
+	/* set connect bit, EVDCS */
+	val = readl(drvdata->base + EVDCS);
+
+	val |= EVDCS_CONNECT;
+	writel(val, drvdata->base + EVDCS);
+
+	return 0;
+}
+
+static int gxp_udc_disconnect(struct gxp_udc_drvdata *drvdata)
+{
+	unsigned int val;
+	unsigned char femap;
+	int i;
+
+	/* disable interrupt */
+	val = readl(drvdata->base + EVDIEN);
+	val &= ~EVDIEN_MASK;
+	writel(val, drvdata->base + EVDIEN);
+
+	/* disable vdevice interrupt */
+	regmap_update_bits(drvdata->udcg_map, EVGIEN, BIT(drvdata->vdevnum), 0);
+
+	/* clear connect bit, EVDCS */
+	val = readl(drvdata->base + EVDCS);
+	val &= ~EVDCS_CONNECT;
+	writel(val, drvdata->base + EVDCS);
+
+	/* free flex ep */
+	for (i = 0; i < GXP_UDC_MAX_NUM_FLEX_EP; i++) {
+		femap = gxp_udc_femap_read(drvdata, i);
+		if (EVFEMAP_VDEVNUM(drvdata->vdevnum) ==
+				(femap & EVFEMAP_VDEVNUM_MASK)) {
+			gxp_udc_femap_write(drvdata, i, 0);
+		}
+	}
+
+	return 0;
+}
+
+static int gxp_udc_start(struct usb_gadget *gadget,
+			 struct usb_gadget_driver *driver)
+{
+	struct gxp_udc_drvdata *drvdata;
+
+	if (!gadget)
+		return -ENODEV;
+
+	drvdata = container_of(gadget, struct gxp_udc_drvdata, gadget);
+	spin_lock(&drvdata->lock);
+
+	if (drvdata->driver) {
+		dev_err(&drvdata->pdev->dev,
+			"vdev%d start failed driver!=NULL\n", drvdata->vdevnum);
+
+		spin_unlock(&drvdata->lock);
+		return -EBUSY;
+	}
+
+	drvdata->deffer_set_address = false;
+
+	/* hook up the driver */
+	driver->driver.bus = NULL;
+	drvdata->driver = driver;
+
+	gxp_udc_connect(drvdata);
+
+	spin_unlock(&drvdata->lock);
+	return 0;
+}
+
+static int gxp_udc_stop(struct usb_gadget *gadget)
+{
+	struct gxp_udc_drvdata *drvdata;
+
+	if (!gadget)
+		return -ENODEV;
+
+	drvdata = container_of(gadget, struct gxp_udc_drvdata, gadget);
+	spin_lock(&drvdata->lock);
+
+	gxp_udc_disconnect(drvdata);
+	drvdata->gadget.speed = USB_SPEED_UNKNOWN;
+	drvdata->driver = NULL;
+
+	spin_unlock(&drvdata->lock);
+	return 0;
+}
+
+static const struct usb_gadget_ops gxp_udc_gadget_ops = {
+	.udc_start	= gxp_udc_start,
+	.udc_stop	= gxp_udc_stop,
+};
+
+static void gxp_udc_out_0byte_status(struct gxp_udc_ep *ep)
+{
+	u32 evdepcc;
+
+	/* out */
+	evdepcc = readl(ep->base + EVDEPCC);
+	evdepcc &= ~EVDEPCC_CFGINOUT;
+	writel(evdepcc, ep->base + EVDEPCC);
+
+	/* 0 len */
+	writel(0, ep->base + EVDEPLEN);
+}
+
+static void gxp_udc_in_0byte_status(struct gxp_udc_ep *ep)
+{
+	u32 evdepcc;
+
+	/* in */
+	evdepcc = readl(ep->base + EVDEPCC);
+	evdepcc |= EVDEPCC_CFGINOUT;
+	writel(evdepcc, ep->base + EVDEPCC);
+
+	/* 0 len */
+	writel(0, ep->base + EVDEPLEN);
+}
+
+static int gxp_udc_ep_nuke(struct gxp_udc_ep *ep)
+{
+	u32 evdepcc;
+	struct gxp_udc_req *req;
+
+	if (!ep)
+		return -EINVAL;
+
+	/* disarm dma */
+	evdepcc = readl(ep->base + EVDEPCC);
+	evdepcc |= EVDEPCC_DISARMCMD;
+	writel(evdepcc, ep->base + EVDEPCC);
+
+	while (!list_empty(&ep->queue)) {
+		req = list_first_entry(&ep->queue, struct gxp_udc_req, queue);
+		gxp_udc_ep_dequeue(&ep->ep, &req->req);
+	}
+
+	return 0;
+}
+
+static int gxp_udc_set_feature(struct gxp_udc_drvdata *drvdata,
+			       struct usb_ctrlrequest *ctrl)
+{
+	struct gxp_udc_ep *ep;
+
+	if (ctrl->bRequestType == USB_RECIP_ENDPOINT) {
+		ep = &drvdata->ep[ctrl->wIndex & USB_ENDPOINT_NUMBER_MASK];
+		if (le16_to_cpu(ctrl->wValue) == USB_ENDPOINT_HALT) {
+			gxp_udc_ep_set_halt(&ep->ep, 1);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int gxp_udc_clear_feature(struct gxp_udc_drvdata *drvdata,
+				 struct usb_ctrlrequest *ctrl)
+{
+	struct gxp_udc_ep *ep;
+
+	if (ctrl->bRequestType == USB_RECIP_ENDPOINT) {
+		ep = &drvdata->ep[ctrl->wIndex & USB_ENDPOINT_NUMBER_MASK];
+		if (le16_to_cpu(ctrl->wValue) == USB_ENDPOINT_HALT) {
+			if (ep->wedged)
+				gxp_udc_ep_set_halt(&ep->ep, 0);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int gxp_udc_get_status(struct gxp_udc_drvdata *drvdata,
+			      struct usb_ctrlrequest *ctrl)
+{
+	int ret;
+	u32 evdepcc;
+
+	switch (ctrl->bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		/* fill the req to send */
+		drvdata->ep0_data = 1;
+		drvdata->ep0_req->length = 2;
+		drvdata->ep0_req->buf = &drvdata->ep0_data;
+		gxp_udc_ep_queue(&drvdata->ep[0].ep, drvdata->ep0_req,
+				 GFP_KERNEL);
+		ret = 1;
+		break;
+
+	case USB_RECIP_ENDPOINT:
+		evdepcc = readl(drvdata->ep[ctrl->wIndex &
+			USB_ENDPOINT_NUMBER_MASK].base + EVDEPCC);
+		/* fill the req to send */
+		if (evdepcc & EVDEPCC_STALL)
+			drvdata->ep0_data = 1;
+		else
+			drvdata->ep0_data = 0;
+		drvdata->ep0_req->length = 2;
+		drvdata->ep0_req->buf = &drvdata->ep0_data;
+		gxp_udc_ep_queue(&drvdata->ep[0].ep, drvdata->ep0_req,
+				 GFP_KERNEL);
+		ret = 1;
+		break;
+
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static void gxp_udc_handle_ep0_int(struct gxp_udc_ep *ep)
+{
+	struct gxp_udc_drvdata *drvdata = ep->drvdata;
+	struct gxp_udc_req *req;
+	u32 evdepsts;
+	u32 evdepcc;
+
+	evdepcc = readl(ep->base + EVDEPCC);
+	evdepsts  = readl(ep->base + EVDEPSTS);
+	writel(evdepsts, ep->base + EVDEPSTS); /* write 1 to clear status */
+
+	if (evdepsts & EVDEPSTS_STALLDET) {
+		pr_debug("ep%d get stalldet int\n", ep->epnum);
+		evdepcc &= ~EVDEPCC_STALL;
+		evdepcc |= EVDEPCC_DT_RESET;
+		writel(evdepcc, ep->base + EVDEPCC);
+	}
+
+	if (evdepsts & EVDEPSTS_DONE || evdepsts & EVDEPSTS_SHORT) {
+		if (drvdata->deffer_set_address) {
+			writel(drvdata->devaddr, drvdata->base + EVDADDR);
+			drvdata->deffer_set_address = false;
+		} else if (!list_empty(&ep->queue)) {
+			req = list_entry(ep->queue.next,
+					 struct gxp_udc_req, queue);
+			if (gxp_udc_done_dma(ep, req)) {
+				/* req is done */
+				list_del_init(&req->queue);
+				usb_gadget_unmap_request(&ep->drvdata->gadget,
+							 &req->req, ep->is_in);
+				if (req->req.complete) {
+					req->req.status = 0;
+					usb_gadget_giveback_request(&ep->ep,
+								    &req->req);
+				}
+
+				if (!list_empty(&ep->queue)) {
+					/* process next req in queue */
+					req = list_entry(ep->queue.next,
+							 struct gxp_udc_req,
+							 queue);
+					gxp_udc_start_dma(ep, req);
+					pr_debug("ep0 queue is not empty after done a req!!\n");
+				} else {
+					/* last req completed -> status stage */
+					if (evdepcc & EVDEPCC_CFGINOUT) {
+						/* data in -> out status */
+						gxp_udc_out_0byte_status(ep);
+					} else {
+						/* data out ->in status */
+						gxp_udc_in_0byte_status(ep);
+					}
+				}
+			}
+		}
+	}
+}
+
+static void gxp_udc_handle_ep_int(struct gxp_udc_ep *ep)
+{
+	struct gxp_udc_req *req;
+	u32 evdepsts;
+	u32 evdepcc;
+
+	evdepsts  = readl(ep->base + EVDEPSTS);
+	writel(evdepsts, ep->base + EVDEPSTS); /* write 1 to clear status */
+
+	if (evdepsts & EVDEPSTS_STALLDET) {
+		pr_debug("ep%d get stalldet int\n", ep->epnum);
+		evdepcc = readl(ep->base + EVDEPCC);
+		evdepcc &= ~EVDEPCC_STALL;
+		evdepcc |= EVDEPCC_DT_RESET;
+		writel(evdepcc, ep->base + EVDEPCC);
+	}
+
+	if (evdepsts & EVDEPSTS_DONE || evdepsts & EVDEPSTS_SHORT) {
+		if (evdepsts & EVDEPSTS_SHORT)
+			pr_debug("ep%d get short int\n", ep->epnum);
+		if (evdepsts & EVDEPSTS_DONE)
+			pr_debug("ep%d get done int\n", ep->epnum);
+
+		if (!list_empty(&ep->queue)) {
+			req = list_entry(ep->queue.next,
+					 struct gxp_udc_req, queue);
+			if (gxp_udc_done_dma(ep, req)) {
+				/* req is done */
+				list_del_init(&req->queue);
+				usb_gadget_unmap_request(&ep->drvdata->gadget,
+							 &req->req, ep->is_in);
+				if (req->req.complete) {
+					req->req.status = 0;
+					usb_gadget_giveback_request(&ep->ep,
+								    &req->req);
+				}
+
+				if (!list_empty(&ep->queue)) {
+					/* process next req in queue */
+					req = list_entry(ep->queue.next,
+							 struct gxp_udc_req,
+							 queue);
+					gxp_udc_start_dma(ep, req);
+				}
+			}
+		}
+	}
+}
+
+static void gxp_udc_handle_setup_data_rcv(struct gxp_udc_drvdata *drvdata)
+{
+	struct usb_ctrlrequest ctrl = {0};
+	u32 *ptr;
+	u32 val;
+	int handled = 0;
+	int ret;
+
+	ptr = (u32 *)&ctrl;
+
+	ptr[0] = readl(drvdata->base + EVDSETUPL);
+	ptr[1] = readl(drvdata->base + EVDSETUPH);
+
+	if ((ctrl.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD) {
+		switch (ctrl.bRequest) {
+		case USB_REQ_SET_ADDRESS:
+			pr_debug("vdev%d get setup data USB_REQ_SET_ADDRESS\n",
+				 drvdata->vdevnum);
+			/*
+			 * this request is unique in that the device does
+			 * not set its address until after the completion
+			 * of the status stage.(ref: usb nutshell)
+			 */
+			drvdata->devaddr = ctrl.wValue & 0x7f;
+			drvdata->deffer_set_address = true;
+			gxp_udc_in_0byte_status(&drvdata->ep[0]);
+			handled = 1;
+			break;
+
+		case USB_REQ_SET_FEATURE:
+			pr_debug("vdev%d get setup data USB_REQ_SET_FEATURE\n",
+				 drvdata->vdevnum);
+			handled = gxp_udc_set_feature(drvdata, &ctrl);
+			break;
+
+		case USB_REQ_CLEAR_FEATURE:
+			pr_debug("vdev%d get setup data USB_REQ_CLEAR_FEATURE\n",
+				 drvdata->vdevnum);
+			handled = gxp_udc_clear_feature(drvdata, &ctrl);
+			break;
+
+		case USB_REQ_GET_STATUS:
+			pr_debug("vdev%d get setup data USB_REQ_GET_STATUS\n",
+				 drvdata->vdevnum);
+			handled = gxp_udc_get_status(drvdata, &ctrl);
+			break;
+
+		default:
+			handled = 0;
+			break;
+		}
+	}
+
+	/*
+	 * pass the request to upper layer driver code(composite.c)
+	 * if it is not handled by the code above.
+	 */
+	if (drvdata->driver && !handled) {
+		ret = drvdata->driver->setup(&drvdata->gadget, &ctrl);
+		if (ret < 0) {
+			dev_err(&drvdata->pdev->dev,
+				"setup failed, return %d\n", ret);
+			/* set ep0 to stall */
+			val = readl(drvdata->ep[0].base + EVDEPCC);
+			val |= EVDEPCC_STALL;
+			writel(val, drvdata->ep[0].base + EVDEPCC);
+			return;
+		}
+	}
+}
+
+static irqreturn_t gxp_udc_irq(int irq, void *_drvdata)
+{
+	struct gxp_udc_drvdata *drvdata = _drvdata;
+
+	u32 evgistat;
+	u32 evdistat;
+	u32 evdcs;
+	u32 i;
+
+	regmap_read(drvdata->udcg_map, EVGISTAT, &evgistat);
+	if (evgistat & (1 << drvdata->vdevnum)) {
+		evdistat = readl(drvdata->base + EVDISTAT);
+		while (evdistat & EVDISTAT_MASK) {
+			pr_debug("vdev%d get int = 0x%08x\n",
+				 drvdata->vdevnum, evdistat);
+
+			if (evdistat & EVDISTAT_PORTEN_CHANGE) {
+				evdcs = readl(drvdata->base + EVDCS);
+				drvdata->gadget.speed =
+					(evdcs & EVDCS_PORTENABLESTS) ?
+					USB_SPEED_HIGH : USB_SPEED_UNKNOWN;
+
+				pr_debug("vdev%d get port enable change int speed = %d\n",
+					 drvdata->vdevnum,
+					 drvdata->gadget.speed);
+
+				/*  write 1 to clear */
+				writel(EVDISTAT_PORTEN_CHANGE,
+				       drvdata->base + EVDISTAT);
+			}
+
+			if (evdistat & EVDISTAT_PORTRST) {
+				pr_debug("vdev%d get port rst int\n",
+					 drvdata->vdevnum);
+				writel(0, drvdata->base + EVDADDR);
+
+				for (i = 0; i < drvdata->fepnum + 1; i++)
+					gxp_udc_ep_nuke(&drvdata->ep[i]);
+
+				usb_gadget_udc_reset(&drvdata->gadget,
+						     drvdata->driver);
+
+				/* write 1 to clear */
+				writel(EVDISTAT_PORTRST,
+				       drvdata->base + EVDISTAT);
+			}
+
+			if (evdistat & EVDISTAT_SETUP_DAT_RCV) {
+				pr_debug("vdev%d get setup data rcv int\n",
+					 drvdata->vdevnum);
+					gxp_udc_handle_setup_data_rcv(drvdata);
+					/* write 1 to clear */
+					writel(EVDISTAT_SETUP_DAT_RCV,
+					       drvdata->base + EVDISTAT);
+			}
+			if (evdistat & 0x01)
+				gxp_udc_handle_ep0_int(&drvdata->ep[0]);
+
+			for (i = 1; i < GXP_UDC_MAX_NUM_EP; i++)
+				if (evdistat & (1 << i))
+					gxp_udc_handle_ep_int(&drvdata->ep[i]);
+
+			evdistat = readl(drvdata->base + EVDISTAT);
+		}
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+static int gxp_udc_init(struct gxp_udc_drvdata *drvdata)
+{
+	int i;
+	struct gxp_udc_ep *ep;
+
+	/* Disable device interrupt */
+	writel(0, drvdata->base + EVDIEN);
+
+	drvdata->gadget.max_speed = USB_SPEED_HIGH;
+	drvdata->gadget.speed = USB_SPEED_UNKNOWN;
+	drvdata->gadget.ops = &gxp_udc_gadget_ops;
+	drvdata->gadget.name = gxp_udc_name[drvdata->vdevnum];
+	drvdata->gadget.is_otg = 0;
+	drvdata->gadget.is_a_peripheral = 0;
+
+	drvdata->gadget.ep0 = &drvdata->ep[0].ep;
+	drvdata->ep0_req = gxp_udc_ep_alloc_request(&drvdata->ep[0].ep,
+						    GFP_KERNEL);
+
+	INIT_LIST_HEAD(&drvdata->gadget.ep_list);
+
+	for (i = 0; i < drvdata->fepnum + 1; i++) {
+		ep = &drvdata->ep[i];
+
+		ep->drvdata = drvdata;
+
+		INIT_LIST_HEAD(&ep->queue);
+		INIT_LIST_HEAD(&ep->ep.ep_list);
+		if (i > 0)
+			list_add_tail(&ep->ep.ep_list,
+				      &drvdata->gadget.ep_list);
+
+		usb_ep_set_maxpacket_limit(&ep->ep, (i > 0) ? 512 : 64);
+		ep->epnum = i;
+		ep->ep.name = gxp_udc_ep_name[i];
+		ep->ep.ops = &gxp_udc_ep_ops;
+		ep->base = drvdata->base + 0x20 * (i + 1);
+		if (i == 0) {
+			ep->ep.caps.type_control = true;
+		} else {
+			ep->ep.caps.type_iso = true;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
+		}
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
+	}
+
+	return 0;
+}
+
+static void gxp_udcg_init(struct gxp_udc_drvdata *drvdata)
+{
+	int i;
+
+	if (!udcg_init_done) {
+		/* disable interrupt */
+		regmap_write(drvdata->udcg_map, EVGIEN, 0);
+
+		/* disable all flex ep map */
+		for (i = 0; i < GXP_UDC_MAX_NUM_FLEX_EP; i += 4)
+			regmap_write(drvdata->udcg_map, EVFEMAP + i, 0);
+
+		udcg_init_done = true;
+	}
+}
+
+static int gxp_udc_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct gxp_udc_drvdata *drvdata;
+	int ret;
+	u32 vdevnum;
+	u32 fepnum;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_udc_drvdata),
+			       GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, drvdata);
+	drvdata->pdev = pdev;
+
+	spin_lock_init(&drvdata->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to obtain IRQ number\n");
+		return ret;
+	}
+	drvdata->irq = ret;
+
+	if (of_property_read_u32(pdev->dev.of_node, "vdevnum", &vdevnum)) {
+		dev_err(&pdev->dev,
+			"property vdevnum is undefined\n");
+		return -EINVAL;
+	}
+
+	if (vdevnum > GXP_UDC_MAX_NUM_VDEVICE) {
+		dev_err(&pdev->dev,
+			"property vdevnum(%d) is invalid\n", vdevnum);
+		return -EINVAL;
+	}
+	drvdata->vdevnum = vdevnum;
+
+	if (of_property_read_u32(pdev->dev.of_node, "fepnum", &fepnum)) {
+		dev_err(&pdev->dev, "property fepnum is undefined\n");
+		return -EINVAL;
+	}
+
+	if (fepnum > GXP_UDC_MAX_NUM_FLEX_EP_PER_VDEV) {
+		dev_err(&pdev->dev, "property fepnum(%d) is invalid\n", fepnum);
+		return -EINVAL;
+	}
+	drvdata->fepnum = fepnum;
+
+	drvdata->udcg_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							    "hpe,syscon-phandle");
+	if (IS_ERR(drvdata->udcg_map)) {
+		dev_err(&pdev->dev, "failed to map udcg_handle\n");
+		return -ENODEV;
+	}
+	gxp_udcg_init(drvdata);
+
+	gxp_udc_init(drvdata);
+	ret = usb_add_gadget_udc(&pdev->dev, &drvdata->gadget);
+	if (ret) {
+		dev_err(&pdev->dev, "add gadget failed\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(&pdev->dev,
+			       drvdata->irq,
+			       gxp_udc_irq,
+			       IRQF_SHARED,
+			       gxp_udc_name[vdevnum],
+			       drvdata);
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "irq request failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id gxp_udc_of_match[] = {
+	{ .compatible = "hpe,gxp-udc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gxp_udc_of_match);
+
+static struct platform_driver gxp_udc_driver = {
+	.driver		= {
+		.name	= "gxp-udc",
+		.of_match_table = of_match_ptr(gxp_udc_of_match),
+	},
+	.probe		= gxp_udc_probe,
+};
+module_platform_driver(gxp_udc_driver);
+
+MODULE_AUTHOR("Richard Yu <richard.yu@hpe.com>");
+MODULE_DESCRIPTION("HPE GXP UDC Driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

