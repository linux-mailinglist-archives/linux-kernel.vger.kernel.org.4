Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFF6302E4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 00:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiKRXVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 18:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKRXU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 18:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2F7C6AF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668812961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fqxYlPjStId8INOMKlUIJ9udLA0AzXzEw7XWCP07sCA=;
        b=ShB2nT5hZ9TmyBLg70rRqZJNTRlu0vl02lTtMRH2+0j8qi4E3gyKzf6dpHkdC3gvyI5V5J
        EYsZxmrROWx7cyioIf9p91Bhw5StM/A4w0aP1Gop2wdnAeshK4epd+mlxPGwCwlQUakZRk
        g0W3Be7bdZlFfWHVP8G1JWDbxitc8rk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-zZhdaS2ZMiOzxxwsoT0uFg-1; Fri, 18 Nov 2022 18:09:20 -0500
X-MC-Unique: zZhdaS2ZMiOzxxwsoT0uFg-1
Received: by mail-io1-f72.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso3358089iot.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqxYlPjStId8INOMKlUIJ9udLA0AzXzEw7XWCP07sCA=;
        b=mbO232NvvydxzENQtxJBrcC5AUSQ3iTV25+93xIDzwpSSNaKm9F3/1EqSU0JCm9swf
         AE5sKdt184dRRMaGMJCuXugiPVobpB2qQiS0XXJiYz6R0U9UrdgJkPhbRcgqdd192SV0
         rwt3qblI326brhRuoEbsiQm2svV5Xgt5ocoItVT4zdTL24eA0ovVUDAQQcvedEAt5/H7
         y+ziNIhjUfiRhYBYvl7wPU2qSuBQuqWbdg8k1wHm+LIFfeyPEB16M6JWVGV64BFOAS2V
         IQKEint//0ZQmwkJh29pehV31Yo234SmTenKUNmFfFpLZPkJL+StSe18N4EzNVEPGpf5
         mLxw==
X-Gm-Message-State: ANoB5pnjSp/+zPy9ldbm29ZH+3v/X6aaN7vEYbhxuW9vJV08ddTg/Gem
        Wc6LHDV7OX1n2XipRm66IVhvP+KMcCQw9ERgQzqQkkgIy7o6E7cpewcBNr97f9i1joAXfdgG7gu
        F9GGcaMAMX0PjDJp0+Szgz+PN
X-Received: by 2002:a05:6638:e8e:b0:365:ca83:bafb with SMTP id p14-20020a0566380e8e00b00365ca83bafbmr4266499jas.272.1668812959485;
        Fri, 18 Nov 2022 15:09:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7f3wAGkAooZ4pgGTzbQ8zzFPutM7VEf7MWtlfseJLOvhAGCmYD1Viv5Pey1FXFSlTBLf+UZw==
X-Received: by 2002:a05:6638:e8e:b0:365:ca83:bafb with SMTP id p14-20020a0566380e8e00b00365ca83bafbmr4266495jas.272.1668812959204;
        Fri, 18 Nov 2022 15:09:19 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g17-20020a056e02131100b0030249f369f7sm1631332ilr.82.2022.11.18.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:09:18 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:09:16 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, christian.koenig@amd.com
Subject: [RFC] Resizable BARs vs bridges with BARs
Message-ID: <20221118160916.7e165306.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get resizable BARs working in a configuration where my
root bus resources provide plenty of aperture for the BAR:

pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window] <<<
pci_bus 0000:5d: root bus resource [bus 5d-7f]

But resizing fails with -ENOSPC.  The topology looks like this:

 +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
                                             \-04.0-[61]----00.0  Intel Corporation Device 4f92

The BIOS is not fluent in resizable BARs and only programs the root
port with a small aperture:

5d:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A (rev 07) (prog-if 00 [Normal decode])
        Bus: primary=5d, secondary=5e, subordinate=61, sec-latency=0
        I/O behind bridge: 0000f000-00000fff [disabled]
        Memory behind bridge: b9000000-ba0fffff [size=17M]
        Prefetchable memory behind bridge: 000000bfe0000000-000000bff07fffff [size=264M]
        Kernel driver in use: pcieport

The trouble comes on the upstream PCIe switch port:

5e:00.0 PCI bridge: Intel Corporation Device 4fa1 (rev 01) (prog-if 00 [Normal decode])
   >>>  Region 0: Memory at b010000000 (64-bit, prefetchable)
        Bus: primary=5e, secondary=5f, subordinate=61, sec-latency=0
        I/O behind bridge: 0000f000-00000fff [disabled]
        Memory behind bridge: b9000000-ba0fffff [size=17M]
        Prefetchable memory behind bridge: 000000bfe0000000-000000bfefffffff [size=256M]
        Kernel driver in use: pcieport

Note region 0 of this bridge, which is 64-bit, prefetchable and
therefore conflicts with the same type for the resizable BAR on the GPU:

60:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A380] (rev 05) (prog-if 00 [VGA controller])
        Region 0: Memory at b9000000 (64-bit, non-prefetchable) [disabled] [size=16M]
        Region 2: Memory at bfe0000000 (64-bit, prefetchable) [disabled] [size=256M]
        Expansion ROM at <ignored> [disabled]
        Capabilities: [420 v1] Physical Resizable BAR
                BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB

It's a shame that the hardware designers didn't mark the upstream port
BAR as non-prefetchable to avoid it living in the same resource
aperture as the resizable BAR on the downstream device.  In any case,
it's my understanding that our bridge drivers don't generally make use
of bridge BARs.  I think we can test whether a driver has done a
pci_request_region() or equivalent by looking for the IORESOURCE_BUSY
flag, but I also suspect this is potentially racy.

The patch below works for me, allowing the new resourceN_resize sysfs
attribute to resize the root port window within the provided bus
window.  Is this the right answer?  How can we make it feel less
sketchy?  Thanks,

Alex

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b4096598dbcb..8c332a08174d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2137,13 +2137,19 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 	next = bridge;
 	do {
 		bridge = next;
-		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
+		for (i = PCI_STD_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
 		     i++) {
 			struct resource *res = &bridge->resource[i];
 
 			if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
 				continue;
 
+			if (i < PCI_STD_NUM_BARS) {
+				if (!(res->flags & IORESOURCE_BUSY))
+					pci_release_resource(bridge, i);
+				continue;
+			}
+
 			/* Ignore BARs which are still in use */
 			if (res->child)
 				continue;

