Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAC86202BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiKGWzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiKGWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09B62935D;
        Mon,  7 Nov 2022 14:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861687; x=1699397687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mk+Vz7rzmu4MdLLvCybyRG1sgfbqtsuXJMMpfrS3JGA=;
  b=k9Qw2A+r8FatH5CZrGoYG91w+ZON67gClZegulWPYfIPb93vRDiBaWom
   treX+UEOe3bnPfsWwkW9tDUnhp4YLwyyVf6+45ODKrR9YUP30CtNle5xP
   J647rztBHX3P88YjKfQDDN6Ix9A7XF+nptwhRRGNDPBF9VnZ45FvUEC4v
   jPbfCvKNbhD+sULUNntUdl/YhjM5j8j2lFMJNlA5PZOUOrXyT48ZKpqFL
   BEZ93JkbkOVC3CtGIk9V0ev1KhbK+FMzf5WZWGZRdWN+Vg3rdUDHfwTY0
   xpGNXOQTlCf5nP2x8ztaPx1ZlSg+jC33lOUB+Hn+tL/OAoITVmdg7zZ51
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911834"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012982"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012982"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:47 -0800
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
Subject: [PATCH v2 08/14] platform/x86/intel/ifs: Add metadata support
Date:   Mon,  7 Nov 2022 14:53:17 -0800
Message-Id: <20221107225323.2733518-9-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

One of the existing reserved fields in microcode header has been
allocated to indicate the size for metadata structures.

The metadata section within microcode header is as shown below:

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

In subsequent patches, IFS test image file (which reuse microcode header
format) will make use of metadata section.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 89ce265887ea..60ba5a057f91 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -44,6 +44,38 @@ static const char * const scan_authentication_status[] = {
 	[2] = "Chunk authentication error. The hash of chunk did not match expected value"
 };
 
+#define META_TYPE_END		(0)
+
+struct metadata_header {
+	unsigned int		type;
+	unsigned int		blk_size;
+};
+
+static struct metadata_header *ifs_find_meta_data(void *ucode, unsigned int meta_type)
+{
+	struct metadata_header *meta_header;
+	unsigned long data_size, total_meta;
+	unsigned long meta_size = 0;
+
+	data_size = get_datasize(ucode);
+	total_meta = ((struct microcode_intel *)ucode)->hdr.metasize;
+
+	if (!total_meta)
+		return NULL;
+
+	meta_header = (ucode + MC_HEADER_SIZE + data_size) - total_meta;
+
+	while ((meta_header->type != META_TYPE_END) && meta_header->blk_size &&
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

