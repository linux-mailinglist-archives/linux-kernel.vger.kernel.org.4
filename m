Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F50702422
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbjEOGId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbjEOGIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF02D7D
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684130600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/HTD3f0P0/3Vfg2IW/92bJMtlhcGD951h+Pgg59OXQ=;
        b=IdwlBG1acQm5kWI8L8sOOvto8y85toc0IDV/l5SzAbeYnQG/JdtxLcDhBJgTcfDu2bi6ZC
        rjwSfxZtPVEOee3xLoQsSRsFfrNExJ5xVOpITHXZ0KQXXJoAaJpTSpF8x3Frv4dRQ/4PRF
        naX2ZuQFCooKZwM+7Ir5ft0wz2oN16Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-U_SSZYFTOVq2JwICkBmuDg-1; Mon, 15 May 2023 02:03:17 -0400
X-MC-Unique: U_SSZYFTOVq2JwICkBmuDg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1F72101A552;
        Mon, 15 May 2023 06:03:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E56140B947;
        Mon, 15 May 2023 06:03:11 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
Date:   Mon, 15 May 2023 14:02:59 +0800
Message-Id: <20230515060259.830662-3-bhe@redhat.com>
In-Reply-To: <20230515060259.830662-1-bhe@redhat.com>
References: <20230515060259.830662-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People complained the crashkernel reservation code flow is hard to
follow, so add this document to explain the background, concepts and
implementation of crashkernel reservation on arm64. Hope this can help
people to understand it more easily.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/arm64/kdump.rst | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/arm64/kdump.rst

diff --git a/Documentation/arm64/kdump.rst b/Documentation/arm64/kdump.rst
new file mode 100644
index 000000000000..78b22017c490
--- /dev/null
+++ b/Documentation/arm64/kdump.rst
@@ -0,0 +1,103 @@
+=======================================
+crashkernel memory reservation on arm64
+=======================================
+
+Author: Baoquan He <bhe@redhat.com>
+
+Kdump mechanism is utilized to capture corrupted kernel's vmcore so
+that people can analyze it to get the root cause of corruption. In
+order to do that, a preliminarily reserved memory is needed to load
+in kdump kernel, and switch to kdump kernel to boot up and run if
+corruption happened.
+
+That reserved memory for kdump is adapted to be able to minimally
+accommodate kdump kernel to boot and run, and user space programs
+running to do the vmcore collecting.
+
+Kernel parameter
+================
+Through kernel parameter like below, memory can be reserved
+accordingly during early stage of 1st kernel's bootup so that
+continuous large chunk of memomy can be found and reserved. Meanwhile,
+the need of low memory need be considered if crashkernel is reserved
+in high memory area.
+
+- crashkernel=size@offset
+- crashkernel=size
+- crashkernel=size,high crashkernel=size,low
+
+Low memory and high memory
+===============
+What is low memory and high memory? In kdump reservation, low memory
+means the memory area under a specific limitation, and it's usually
+decided by the lowest addressing bits of PCI devices which kdump kernel
+need rely on to boot up and collect vmcore successfully. Those devices
+not related to vmcore dumping can be ignored, e.g on x86, those i2c may
+only be able to access 24bits addressing area, but kdump kernel still
+take 4G as the limitation because all known devices that kdump kernel
+cares about have 32bits addressing ability. On arm64, the low memory
+upper boundary is not fixed, it's 1G on RPi4 platform, while 4G on normal
+arm64 system. On the special system with CONFIG_ZONE_DMA|DMA32 disabled,
+the whole system RAM is low memory. Except of low memory, all the rest
+of system RAM is high memory which kernel and user space programs can
+require to allocate and use.
+
+Implementation
+==============
+1)crashkernel=size@offset
+-------------------------
+crashkernel memory must be reserved at the user specified region, otherwise
+fail if already occupied.
+
+
+2) crashkernel=size
+-------------------
+crashkernel memory region will be reserved in any available position
+according to searching order.
+
+Firstly, it searches the low memory area for an available region with specified
+size.
+
+Secondly, if searching low memory failed, fallback to search the high memory
+area with the specified size. Meanwhile, if the reservation in high memory
+succeeds, a default reservation in low memory will be done, the current default
+value is 128M which is satisfying the low memory needs, e.g pci device driver
+initialization.
+
+If both the above searching failed, the reservation will fail finally.
+
+Note: crashkernel=size is recommended option among crashkernel kernel
+parameters. With it, user doesn't need to know much about system memory
+information, just need to specify whatever memory kdump kernel needs to
+make vmcore dumping succeed.
+
+3) crashkernel=size,high crashkernel=size,low
+--------------------------------------------
+crashkernel=size,high is an important supplement to crashkernel=size. It
+allows user to precisely specify how much memory need be allocated from
+high memory, and how much memory is needed from low memory. On system
+with large memory, low memory is small and precious since some kernel
+feature and many devices can only request memory from the area, while
+requiring a large chunk of continuous memory from high memory area doesn't
+matter much and can satisfy most of kernel and almost all user space
+programs' requirement. In such case, only a small part of necessary memory
+from low memory area can satisfy needs. With it, the 1st kernel's normal
+running won't be impacted because of limited low memory resource.
+
+To reserve memory for crashkernel=size,high, firstly, searching is tried in
+high memory region. If reservation succeeds, low memory reservaton will be
+done subsequently.
+
+Secondly, if reservation in high memory failed, fallback to search the
+low memory with the specified size in crsahkernel=,high. If succeeds,
+everything is fine since no low memory is needed.
+
+Notes:
+- If crashkernel=,low is not specified, the default low memory reservation
+  will be done automically.
+
+- if crashkernel=0,low is specified, means that low memory reservation is
+  ommited intentionally.
+
+3)
+
-- 
2.34.1

