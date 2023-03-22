Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F296C4DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCVO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCVO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:29:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8AA5F527
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:29:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so19320260pjt.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679495372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXV3Wl1KTvMBuLUh8beW+k4dT9B/YtXLSZI9tNVnWns=;
        b=ea1HbWMIUbjWB0jjwjfgHyGjpjLN7Z/HpBQ7Z2lg1UFFZXXtYxc9GdcH02PR5AIldY
         K6AIhWuVlZjMIsRgB2Gmuh3yu9Rz+Ns4pW1hqbhLN8t9Y5vFHP1yP+5K6bk+yPi3jWHi
         ucbzp6YRr8DHdj72j/9D0fFo00H5HUlfF4Yw14ebpLbzVGNqjOfD4KQ8cTHfGGmO/hgU
         HyujEgkQogGKuGPUOGOSpeKgvjZ2IDXB8c/6PHNQ6A4UWaFpISjcr8sGBi1grWSm8WHq
         +ivADraBncJlyf23uwaG2kfcagTIztSF00PxSye/X6mbJSFrKV0tPOzpkgfEdqP+YFvQ
         lQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXV3Wl1KTvMBuLUh8beW+k4dT9B/YtXLSZI9tNVnWns=;
        b=B53cVVJK3kZVgqJh8sXU2yecPWajfwJy/31qGcJnk7qkZ318eWg6hN4rSR4+7tmMY7
         rxus8I/ym5Ea2c/N1lF01cYjo0YpHfGOjXXnP3HIlztv+auNzqdXj2N3cGttIE1+4t5g
         xoTjd8NszuMeyUg9lTmP/plMGDlArl/lbL8d3HdKzI7TAOZvmstc0td0rl4/yycznUj+
         Igz1nOAc877sVwEE+XaWFyTHLyL1M/9xbDaqUG0NGAysjjuoo4G/0DYu+an7s0yOE/Xy
         YkWlgS11xaMmO056Hk1OwTovtl/s+l6X+L5ewhROaVPl/hevxyY1yw+W/0WKyhkfOLkf
         3VXQ==
X-Gm-Message-State: AO0yUKUwMuCRV1Ui1QODb+BoVyA5ThdN5jWxLMRaBwyvIOlFlBE4I1HK
        KTnZMtU5Q7CvDDLGDCNpMzQ=
X-Google-Smtp-Source: AK7set/ZwZfIc0+pu5aOJed20L3enF0+op/5NvxPq3BGiC3k3hK3zssko6YHsOCVGsNEEWVti2Uquw==
X-Received: by 2002:a05:6a20:3541:b0:d8:d720:7fa with SMTP id f1-20020a056a20354100b000d8d72007famr5419234pze.0.1679495372219;
        Wed, 22 Mar 2023 07:29:32 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([103.115.201.92])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b0062603aec060sm10103062pfa.184.2023.03.22.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:29:31 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: vme_user: Fixing coding style issues reported by checkpatch
Date:   Wed, 22 Mar 2023 19:59:23 +0530
Message-Id: <20230322142923.723-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing alignment should match open parenthesis issue on multiple lines,
reported by checkpatch script.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 102 +++++++++++++-------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 2f5eafd50934..716de1d7fe21 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -55,14 +55,14 @@ static struct pci_driver tsi148_driver = {
 };

 static void reg_join(unsigned int high, unsigned int low,
-	unsigned long long *variable)
+		     unsigned long long *variable)
 {
 	*variable = (unsigned long long)high << 32;
 	*variable |= (unsigned long long)low;
 }

 static void reg_split(unsigned long long variable, unsigned int *high,
-	unsigned int *low)
+		      unsigned int *low)
 {
 	*low = (unsigned int)variable & 0xFFFFFFFF;
 	*high = (unsigned int)(variable >> 32);
@@ -72,7 +72,7 @@ static void reg_split(unsigned long long variable, unsigned int *high,
  * Wakes up DMA queue.
  */
 static u32 tsi148_DMA_irqhandler(struct tsi148_driver *bridge,
-	int channel_mask)
+				 int channel_mask)
 {
 	u32 serviced = 0;

@@ -207,7 +207,7 @@ static u32 tsi148_IACK_irqhandler(struct tsi148_driver *bridge)
  * Calling VME bus interrupt callback if provided.
  */
 static u32 tsi148_VIRQ_irqhandler(struct vme_bridge *tsi148_bridge,
-	u32 stat)
+				  u32 stat)
 {
 	int vec, i, serviced = 0;
 	struct tsi148_driver *bridge;
@@ -358,7 +358,7 @@ static int tsi148_irq_init(struct vme_bridge *tsi148_bridge)
 }

 static void tsi148_irq_exit(struct vme_bridge *tsi148_bridge,
-	struct pci_dev *pdev)
+			    struct pci_dev *pdev)
 {
 	struct tsi148_driver *bridge = tsi148_bridge->driver_priv;

@@ -392,7 +392,7 @@ static int tsi148_iack_received(struct tsi148_driver *bridge)
  * Configure VME interrupt
  */
 static void tsi148_irq_set(struct vme_bridge *tsi148_bridge, int level,
-	int state, int sync)
+			   int state, int sync)
 {
 	struct pci_dev *pdev;
 	u32 tmp;
@@ -430,7 +430,7 @@ static void tsi148_irq_set(struct vme_bridge *tsi148_bridge, int level,
  * interrupt to be acked.
  */
 static int tsi148_irq_generate(struct vme_bridge *tsi148_bridge, int level,
-	int statid)
+			       int statid)
 {
 	u32 tmp;
 	struct tsi148_driver *bridge;
@@ -453,7 +453,7 @@ static int tsi148_irq_generate(struct vme_bridge *tsi148_bridge, int level,

 	/* XXX Consider implementing a timeout? */
 	wait_event_interruptible(bridge->iack_queue,
-		tsi148_iack_received(bridge));
+				 tsi148_iack_received(bridge));

 	mutex_unlock(&bridge->vme_int);

@@ -464,7 +464,7 @@ static int tsi148_irq_generate(struct vme_bridge *tsi148_bridge, int level,
  * Initialize a slave window with the requested attributes.
  */
 static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
-	unsigned long long vme_base, unsigned long long size,
+			    unsigned long long vme_base, unsigned long long size,
 	dma_addr_t pci_base, u32 aspace, u32 cycle)
 {
 	unsigned int i, addr = 0, granularity = 0;
@@ -607,7 +607,7 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
  * Get slave window configuration.
  */
 static int tsi148_slave_get(struct vme_slave_resource *image, int *enabled,
-	unsigned long long *vme_base, unsigned long long *size,
+			    unsigned long long *vme_base, unsigned long long *size,
 	dma_addr_t *pci_base, u32 *aspace, u32 *cycle)
 {
 	unsigned int i, granularity = 0, ctl = 0;
@@ -706,7 +706,7 @@ static int tsi148_slave_get(struct vme_slave_resource *image, int *enabled,
  * Allocate and map PCI Resource
  */
 static int tsi148_alloc_resource(struct vme_master_resource *image,
-	unsigned long long size)
+				 unsigned long long size)
 {
 	unsigned long long existing_size;
 	int retval = 0;
@@ -752,7 +752,7 @@ static int tsi148_alloc_resource(struct vme_master_resource *image,
 	image->bus_resource.flags = IORESOURCE_MEM;

 	retval = pci_bus_alloc_resource(pdev->bus,
-		&image->bus_resource, size, 0x10000, PCIBIOS_MIN_MEM,
+					&image->bus_resource, size, 0x10000, PCIBIOS_MIN_MEM,
 		0, NULL, NULL);
 	if (retval) {
 		dev_err(tsi148_bridge->parent, "Failed to allocate mem resource for window %d size 0x%lx start 0x%lx\n",
@@ -796,7 +796,7 @@ static void tsi148_free_resource(struct vme_master_resource *image)
  * Set the attributes of an outbound window.
  */
 static int tsi148_master_set(struct vme_master_resource *image, int enabled,
-	unsigned long long vme_base, unsigned long long size, u32 aspace,
+			     unsigned long long vme_base, unsigned long long size, u32 aspace,
 	u32 cycle, u32 dwidth)
 {
 	int retval = 0;
@@ -1031,7 +1031,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
  * XXX Not parsing prefetch information.
  */
 static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
-	unsigned long long *vme_base, unsigned long long *size, u32 *aspace,
+			       unsigned long long *vme_base, unsigned long long *size, u32 *aspace,
 	u32 *cycle, u32 *dwidth)
 {
 	unsigned int i, ctl;
@@ -1140,7 +1140,7 @@ static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
 }

 static int tsi148_master_get(struct vme_master_resource *image, int *enabled,
-	unsigned long long *vme_base, unsigned long long *size, u32 *aspace,
+			     unsigned long long *vme_base, unsigned long long *size, u32 *aspace,
 	u32 *cycle, u32 *dwidth)
 {
 	int retval;
@@ -1148,7 +1148,7 @@ static int tsi148_master_get(struct vme_master_resource *image, int *enabled,
 	spin_lock(&image->lock);

 	retval = __tsi148_master_get(image, enabled, vme_base, size, aspace,
-		cycle, dwidth);
+				     cycle, dwidth);

 	spin_unlock(&image->lock);

@@ -1156,7 +1156,7 @@ static int tsi148_master_get(struct vme_master_resource *image, int *enabled,
 }

 static ssize_t tsi148_master_read(struct vme_master_resource *image, void *buf,
-	size_t count, loff_t offset)
+				  size_t count, loff_t offset)
 {
 	int retval, enabled;
 	unsigned long long vme_base, size;
@@ -1241,7 +1241,7 @@ static ssize_t tsi148_master_read(struct vme_master_resource *image, void *buf,
 }

 static ssize_t tsi148_master_write(struct vme_master_resource *image, void *buf,
-	size_t count, loff_t offset)
+				   size_t count, loff_t offset)
 {
 	int retval = 0, enabled;
 	unsigned long long vme_base, size;
@@ -1343,7 +1343,7 @@ static ssize_t tsi148_master_write(struct vme_master_resource *image, void *buf,
  * Requires a previously configured master window, returns final value.
  */
 static unsigned int tsi148_master_rmw(struct vme_master_resource *image,
-	unsigned int mask, unsigned int compare, unsigned int swap,
+				      unsigned int mask, unsigned int compare, unsigned int swap,
 	loff_t offset)
 {
 	unsigned long long pci_addr;
@@ -1399,7 +1399,7 @@ static unsigned int tsi148_master_rmw(struct vme_master_resource *image,
 }

 static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
-	u32 aspace, u32 cycle, u32 dwidth)
+					     u32 aspace, u32 cycle, u32 dwidth)
 {
 	u32 val;

@@ -1497,7 +1497,7 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
 }

 static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
-	u32 aspace, u32 cycle, u32 dwidth)
+					      u32 aspace, u32 cycle, u32 dwidth)
 {
 	u32 val;

@@ -1600,7 +1600,7 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
  * Note: DMA engine expects the DMA descriptor to be big endian.
  */
 static int tsi148_dma_list_add(struct vme_dma_list *list,
-	struct vme_dma_attr *src, struct vme_dma_attr *dest, size_t count)
+			       struct vme_dma_attr *src, struct vme_dma_attr *dest, size_t count)
 {
 	struct tsi148_dma_entry *entry, *prev;
 	u32 address_high, address_low, val;
@@ -1654,7 +1654,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		pci_attr = src->private;

 		reg_split((unsigned long long)pci_attr->address, &address_high,
-			&address_low);
+			  &address_low);
 		entry->descriptor.dsau = cpu_to_be32(address_high);
 		entry->descriptor.dsal = cpu_to_be32(address_low);
 		entry->descriptor.dsat = cpu_to_be32(TSI148_LCSR_DSAT_TYP_PCI);
@@ -1663,7 +1663,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		vme_attr = src->private;

 		reg_split((unsigned long long)vme_attr->address, &address_high,
-			&address_low);
+			  &address_low);
 		entry->descriptor.dsau = cpu_to_be32(address_high);
 		entry->descriptor.dsal = cpu_to_be32(address_low);
 		entry->descriptor.dsat = cpu_to_be32(TSI148_LCSR_DSAT_TYP_VME);
@@ -1690,7 +1690,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		pci_attr = dest->private;

 		reg_split((unsigned long long)pci_attr->address, &address_high,
-			&address_low);
+			  &address_low);
 		entry->descriptor.ddau = cpu_to_be32(address_high);
 		entry->descriptor.ddal = cpu_to_be32(address_low);
 		entry->descriptor.ddat = cpu_to_be32(TSI148_LCSR_DDAT_TYP_PCI);
@@ -1699,7 +1699,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		vme_attr = dest->private;

 		reg_split((unsigned long long)vme_attr->address, &address_high,
-			&address_low);
+			  &address_low);
 		entry->descriptor.ddau = cpu_to_be32(address_high);
 		entry->descriptor.ddal = cpu_to_be32(address_low);
 		entry->descriptor.ddat = cpu_to_be32(TSI148_LCSR_DDAT_TYP_VME);
@@ -1735,7 +1735,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 	/* Fill out previous descriptors "Next Address" */
 	if (entry->list.prev != &list->entries) {
 		reg_split((unsigned long long)entry->dma_handle, &address_high,
-			&address_low);
+			  &address_low);
 		prev = list_entry(entry->list.prev, struct tsi148_dma_entry,
 				  list);
 		prev->descriptor.dnlau = cpu_to_be32(address_high);
@@ -1813,7 +1813,7 @@ static int tsi148_dma_list_exec(struct vme_dma_list *list)

 	/* Get first bus address and write into registers */
 	entry = list_first_entry(&list->entries, struct tsi148_dma_entry,
-		list);
+				 list);

 	mutex_unlock(&ctrlr->mtx);

@@ -1832,7 +1832,7 @@ static int tsi148_dma_list_exec(struct vme_dma_list *list)
 		TSI148_LCSR_DMA[channel] + TSI148_LCSR_OFFSET_DCTL);

 	retval = wait_event_interruptible(bridge->dma_queue[channel],
-		tsi148_dma_busy(ctrlr->parent, channel));
+					  tsi148_dma_busy(ctrlr->parent, channel));

 	if (retval) {
 		iowrite32be(dctlreg | TSI148_LCSR_DCTL_ABT, bridge->base +
@@ -1883,7 +1883,7 @@ static int tsi148_dma_list_empty(struct vme_dma_list *list)
 		entry = list_entry(pos, struct tsi148_dma_entry, list);

 		dma_unmap_single(tsi148_bridge->parent, entry->dma_handle,
-			sizeof(struct tsi148_dma_descriptor), DMA_TO_DEVICE);
+				 sizeof(struct tsi148_dma_descriptor), DMA_TO_DEVICE);
 		kfree(entry);
 	}

@@ -1898,7 +1898,7 @@ static int tsi148_dma_list_empty(struct vme_dma_list *list)
  * callback is attached and disabled when the last callback is removed.
  */
 static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
-	u32 aspace, u32 cycle)
+			 u32 aspace, u32 cycle)
 {
 	u32 lm_base_high, lm_base_low, lm_ctl = 0;
 	int i;
@@ -1963,7 +1963,7 @@ static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
  * or disabled.
  */
 static int tsi148_lm_get(struct vme_lm_resource *lm,
-	unsigned long long *lm_base, u32 *aspace, u32 *cycle)
+			 unsigned long long *lm_base, u32 *aspace, u32 *cycle)
 {
 	u32 lm_base_high, lm_base_low, lm_ctl, enabled = 0;
 	struct tsi148_driver *bridge;
@@ -2013,7 +2013,7 @@ static int tsi148_lm_get(struct vme_lm_resource *lm,
  * Callback will be passed the monitor triggered.
  */
 static int tsi148_lm_attach(struct vme_lm_resource *lm, int monitor,
-	void (*callback)(void *), void *data)
+			    void (*callback)(void *), void *data)
 {
 	u32 lm_ctl, tmp;
 	struct vme_bridge *tsi148_bridge;
@@ -2086,7 +2086,7 @@ static int tsi148_lm_detach(struct vme_lm_resource *lm, int monitor)
 	iowrite32be(tmp, bridge->base + TSI148_LCSR_INTEO);

 	iowrite32be(TSI148_LCSR_INTC_LMC[monitor],
-		 bridge->base + TSI148_LCSR_INTC);
+		    bridge->base + TSI148_LCSR_INTC);

 	/* Detach callback */
 	bridge->lm_callback[monitor] = NULL;
@@ -2125,7 +2125,7 @@ static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
 }

 static void *tsi148_alloc_consistent(struct device *parent, size_t size,
-	dma_addr_t *dma)
+				     dma_addr_t *dma)
 {
 	struct pci_dev *pdev;

@@ -2136,7 +2136,7 @@ static void *tsi148_alloc_consistent(struct device *parent, size_t size,
 }

 static void tsi148_free_consistent(struct device *parent, size_t size,
-	void *vaddr, dma_addr_t dma)
+				   void *vaddr, dma_addr_t dma)
 {
 	struct pci_dev *pdev;

@@ -2159,7 +2159,7 @@ static void tsi148_free_consistent(struct device *parent, size_t size,
  * be mapped onto PCI memory.
  */
 static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
-	struct pci_dev *pdev)
+			     struct pci_dev *pdev)
 {
 	u32 cbar, crat, vstat;
 	u32 crcsr_bus_high, crcsr_bus_low;
@@ -2201,7 +2201,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	else {
 		dev_info(tsi148_bridge->parent, "Enabling CR/CSR space\n");
 		iowrite32be(crat | TSI148_LCSR_CRAT_EN,
-			bridge->base + TSI148_LCSR_CRAT);
+			    bridge->base + TSI148_LCSR_CRAT);
 	}

 	/* If we want flushed, error-checked writes, set up a window
@@ -2210,7 +2210,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	 */
 	if (err_chk) {
 		retval = tsi148_master_set(bridge->flush_image, 1,
-			(vstat * 0x80000), 0x80000, VME_CRCSR, VME_SCT,
+					   (vstat * 0x80000), 0x80000, VME_CRCSR, VME_SCT,
 			VME_D16);
 		if (retval)
 			dev_err(tsi148_bridge->parent, "Configuring flush image failed\n");
@@ -2220,7 +2220,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 }

 static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
-	struct pci_dev *pdev)
+			      struct pci_dev *pdev)
 {
 	u32 crat;
 	struct tsi148_driver *bridge;
@@ -2230,7 +2230,7 @@ static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
 	/* Turn off CR/CSR space */
 	crat = ioread32be(bridge->base + TSI148_LCSR_CRAT);
 	iowrite32be(crat & ~TSI148_LCSR_CRAT_EN,
-		bridge->base + TSI148_LCSR_CRAT);
+		    bridge->base + TSI148_LCSR_CRAT);

 	/* Free image */
 	iowrite32be(0, bridge->base + TSI148_LCSR_CROU);
@@ -2286,7 +2286,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)

 	/* map registers in BAR 0 */
 	tsi148_device->base = ioremap(pci_resource_start(pdev, 0),
-		4096);
+				      4096);
 	if (!tsi148_device->base) {
 		dev_err(&pdev->dev, "Unable to remap CRG region\n");
 		retval = -EIO;
@@ -2366,7 +2366,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		       sizeof(master_image->bus_resource));
 		master_image->kern_base  = NULL;
 		list_add_tail(&master_image->list,
-			&tsi148_bridge->master_resources);
+			      &tsi148_bridge->master_resources);
 	}

 	/* Add slave windows to list */
@@ -2387,7 +2387,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
 			VME_PROG | VME_DATA;
 		list_add_tail(&slave_image->list,
-			&tsi148_bridge->slave_resources);
+			      &tsi148_bridge->slave_resources);
 	}

 	/* Add dma engines to list */
@@ -2408,7 +2408,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		INIT_LIST_HEAD(&dma_ctrlr->pending);
 		INIT_LIST_HEAD(&dma_ctrlr->running);
 		list_add_tail(&dma_ctrlr->list,
-			&tsi148_bridge->dma_resources);
+			      &tsi148_bridge->dma_resources);
 	}

 	/* Add location monitor to list */
@@ -2446,16 +2446,16 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)

 	data = ioread32be(tsi148_device->base + TSI148_LCSR_VSTAT);
 	dev_info(&pdev->dev, "Board is%s the VME system controller\n",
-		(data & TSI148_LCSR_VSTAT_SCONS) ? "" : " not");
+		 (data & TSI148_LCSR_VSTAT_SCONS) ? "" : " not");
 	if (!geoid)
 		dev_info(&pdev->dev, "VME geographical address is %d\n",
-			data & TSI148_LCSR_VSTAT_GA_M);
+			 data & TSI148_LCSR_VSTAT_GA_M);
 	else
 		dev_info(&pdev->dev, "VME geographical address is set to %d\n",
-			geoid);
+			 geoid);

 	dev_info(&pdev->dev, "VME Write and flush and error check is %s\n",
-		err_chk ? "enabled" : "disabled");
+		 err_chk ? "enabled" : "disabled");

 	retval = tsi148_crcsr_init(tsi148_bridge, pdev);
 	if (retval) {
@@ -2507,7 +2507,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* resources are stored in link list */
 	list_for_each_safe(pos, n, &tsi148_bridge->master_resources) {
 		master_image = list_entry(pos, struct vme_master_resource,
-			list);
+					  list);
 		list_del(pos);
 		kfree(master_image);
 	}
@@ -2605,7 +2605,7 @@ static void tsi148_remove(struct pci_dev *pdev)
 	/* resources are stored in link list */
 	list_for_each_safe(pos, tmplist, &tsi148_bridge->master_resources) {
 		master_image = list_entry(pos, struct vme_master_resource,
-			list);
+					  list);
 		list_del(pos);
 		kfree(master_image);
 	}
--
2.30.2

