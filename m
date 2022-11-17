Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8E962D211
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiKQEC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiKQEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:01:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614149B5D;
        Wed, 16 Nov 2022 20:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668657659; x=1700193659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUNG8NIAa9pCK7zUL68UQaJAiq+0V2MYRuzo+MnCPyY=;
  b=LYct/lRo7EvxahFnHnklzKa1D39bQEDy7xdb7KnUO5SQ/6vSv6c36oez
   PuM2cUN6H9OKePC2c05XyxTMYO6woeZltwO5OR81rgeyE9sqw65+2MX2M
   9RtC/80Lyx/uoXgugRimRvFzHMWhL4E06jhVusf4sE4sf//xdE57PjLl8
   q+3dvtlns9uw60MW8MEen5or9sciMj5WQE8o61nK0MpSU0QTNBzruraA/
   BTv6Cly4XJdE6lrhGQgqKiA1a5U5e8oUPdyDPJmWSX/Rz+Vbbn+8m7ilD
   JZEc/Mq4GCpw8Shb7aOHDq2WIv0z1ZnLVSKHzTC1JdgMwp51TKdAX1s0b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292455972"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292455972"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590462701"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590462701"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:58 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v3 10/16] platform/x86/intel/ifs: Add metadata support
Date:   Wed, 16 Nov 2022 19:59:29 -0800
Message-Id: <20221117035935.4136738-11-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117035935.4136738-1-jithu.joseph@intel.com>
References: <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221117035935.4136738-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

One of the existing reserved fields in microcode header has been
allocated to indicate the size for metadata structures.

The location of metadata section within microcode header is as shown
below:

    Microcode Format
   +----------------------+  Base
   |Header Version        |
   +----------------------+
   |Update revision       |
   +----------------------+
   |Date DDMMYYYY         |
   +----------------------+
   |Sig                   |
   +----------------------+
   |Checksum              |
   +----------------------+
   |Loader Version        |
   +----------------------+
   |Processor Flags       |
   +----------------------+
   |Data Size             |
   +----------------------+
   |Total Size            |
   +----------------------+
   |Meta Size             |
   +----------------------+
   |Reserved              |
   +----------------------+
   |Reserved              |
   +----------------------+  Base+48
   |                      |
   |                      |
   |                      |
   |                      |
   |    Microcode         |
   |                      |
   |     Data             |
   |                      |
   |                      |
   +----------------------+  Base+48+data_size-
   |                      |     meta_size
   |   Meta Data          |
   |   structure(s)       |
   |                      |
   +----------------------+  Base+48+data_size
   |   Extended Signature |
   |        Table         |
   |                      |
   |                      |
   |                      |
   |                      |
   |                      |
   +----------------------+  Base+total_size

Add an accessor function which will return a pointer to the
start of a specific meta_type being queried.

Upcoming changes will introduce the layout of IFS metadata
structure and will make use of metadata section.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index c914e4d359db..713f18ce00a1 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -43,6 +43,38 @@ static const char * const scan_authentication_status[] = {
 	[2] = "Chunk authentication error. The hash of chunk did not match expected value"
 };
 
+#define MC_HEADER_META_TYPE_END		(0)
+
+struct metadata_header {
+	unsigned int		type;
+	unsigned int		blk_size;
+};
+
+static struct metadata_header *find_meta_data(void *ucode, unsigned int meta_type)
+{
+	struct metadata_header *meta_header;
+	unsigned long data_size, total_meta;
+	unsigned long meta_size = 0;
+
+	data_size = get_datasize(ucode);
+	total_meta = ((struct microcode_intel *)ucode)->hdr.metasize;
+	if (!total_meta)
+		return NULL;
+
+	meta_header = (ucode + MC_HEADER_SIZE + data_size) - total_meta;
+
+	while (meta_header->type != MC_HEADER_META_TYPE_END &&
+	       meta_header->blk_size &&
+	       meta_size < total_meta) {
+		meta_size += meta_header->blk_size;
+		if (meta_header->type == meta_type)
+			return meta_header;
+
+		meta_header = (void *)meta_header + meta_header->blk_size;
+	}
+	return NULL;
+}
+
 /*
  * To copy scan hashes and authenticate test chunks, the initiating cpu must point
  * to the EDX:EAX to the test image in linear address.
-- 
2.25.1

