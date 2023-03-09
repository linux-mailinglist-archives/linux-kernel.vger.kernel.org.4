Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB086B2FF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCIVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCIVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:55:32 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49619F05C7;
        Thu,  9 Mar 2023 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678398931; x=1709934931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHO3iDOGQC1PtH6j/1w7cXF0Z0P1HSJgVq8t6FkMnTg=;
  b=ngE7lfhy7+gkIPJffzvyT7hlKsbMelmyJOVvyPSQtFeGjNy6Bl7iqDLb
   6sDIgDIaP+gQJ2Lj3flA05LIJN4km9u0ThhVfgeU4PO37n3LfxWiHYpw4
   N8+/YqgNVm57ZsXcjZ6k/wteMu+4SUel3SvRB9lioA65SCnmyZWp107TB
   Ea7tINy0PgVi+gD4qz53kyFnXUCHQ2iJmdT295HDmPSXe2fflPVxvEHTU
   kxOi2OWoEhFfwFOULnLQUw2wX7oU5cj4KiNMhYb5nyk7EB4CebrpYJnjj
   2tHZQ4dUvlQjoaSsPdp+Hsc9wVPQ3E05ydiJjSurySj8JYc3AEsqHBBCD
   A==;
X-IronPort-AV: E=Sophos;i="5.98,247,1673884800"; 
   d="scan'208";a="225270945"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2023 05:55:30 +0800
IronPort-SDR: hEcBmawp54fI/DZx1IKvBVK4dhuyq2vEgk+OKMSy+9jlAq/8ngpFWopNOL98JHVmllb5peWCaX
 2XO76RMCAR4oe3Bm++/7BVoCLSI9Wnte1b8LNlVLS0u80wmsW88uqYM/eo4w6lRS9N86AeaUXE
 8es2wuFhJNutqQtvwM049wC37A2eswSGUo4mT9qO995NbcCZOS/R6ehvLmmdxtRHWL/ePvUuhp
 IRnZxfhNuEAUeXZrRM3AmFPXbGHVeRwmnHtZjDhxRIZZ118pflMIvWqG74UG4gVm3yBjYpTX/6
 P+4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2023 13:06:24 -0800
IronPort-SDR: 3z8t7a+Lp/mB/akEZGLabMdpoRdhWDPKuv6uLbdbS3tGze1jPSrfAbjyOL2Sys0322UQiHyt20
 fmoDG+tpZXVd0N1EgOXkg9tgxHWHz3GvKd9u/U2yWQUCApKlYsWtHiFSJb07nxyyFZvgypvkLi
 10z7tmaQqx0y9XntPEwX7HIcyhnNe4y8wrAvX81n2HtVccve5Hv1tTtvIA/G7C3apaQqyyP0EO
 hyi3Z94/QaQI039Ch+mbp/fwKXaB/M0g7bhhSe0zfE4ZkznfIejTYq4kMcUpdSjoqm0rJfB8kq
 bBU=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.41])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2023 13:55:29 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v4 02/19] block: introduce ioprio hints
Date:   Thu,  9 Mar 2023 22:54:54 +0100
Message-Id: <20230309215516.3800571-3-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215516.3800571-1-niklas.cassel@wdc.com>
References: <20230309215516.3800571-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

IO priorities currently only use 6-bits of the 16-bits ioprio value: the
3-upper bits are used to define up to 8 priority classes (4 of which are
valid) and the 3 lower bits of the value are used to define a priority
level for the real-time and best-effort class.

The remaining 10-bits between the IO priority class and level are
unused, and in fact, cannot be used by the user as doing so would
either result in the value being completely ignored, or in an error
returned by ioprio_check_cap().

Use these 10-bits of an ioprio value to allow a user to specify IO
hints. An IO hint is defined as a 10-bits value, allowing up to 1023
different hints to be specified, with the value 0 being reserved as the
"no hint" case. An IO hint can apply to any IO that specifies a valid
priority class other than NONE, regardless of the IO priority level
specified.

To do so, the macros IOPRIO_PRIO_HINT() and IOPRIO_PRIO_VALUE_HINT() are
introduced in include/uapi/linux/ioprio.h to respectively allow a user
to get and set a hint in an ioprio value.

To support the ATA and SCSI command duration limits feature, 7 hints
are defined: IOPRIO_HINT_DEV_DURATION_LIMIT_1 to
IOPRIO_HINT_DEV_DURATION_LIMIT_7, allowing a user to specify which
command duration limit descriptor should be applied to the commands
serving an IO. Specifying these hints has for now no effect whatsoever
if the target block devices do not support the command duration limits
feature. However, in the future, block IO schedulers can be modified to
optimize IO issuing order based on these hints, even for devices that
do not support the command duration limits feature.

Given that the 7 duration limits hints defined have no effect on any
block layer component, the actual definition of the duration limits
implied by these hints remains at the device level.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/uapi/linux/ioprio.h | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 4444b4e4fdad..607c7617b9d2 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -58,4 +58,53 @@ enum {
 #define IOPRIO_NORM	4
 #define IOPRIO_BE_NORM	IOPRIO_NORM
 
+/*
+ * The 10-bits between the priority class and the priority level are used to
+ * optionally define IO hints for any combination of IO priority class and
+ * level. Depending on the kernel configuration, IO scheduler being used and
+ * the target IO device being used, hints can influence how IOs are processed
+ * without affecting the IO scheduling ordering defined by the IO priority
+ * class and level.
+ */
+#define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
+#define IOPRIO_HINT_NR_BITS		10
+#define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
+#define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
+#define IOPRIO_PRIO_HINT(ioprio)	\
+	(((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
+
+/*
+ * Alternate macro for IOPRIO_PRIO_VALUE() to define an IO priority with
+ * a class, level and hint.
+ */
+#define IOPRIO_PRIO_VALUE_HINT(class, level, hint)		 \
+	((((class) & IOPRIO_CLASS_MASK) << IOPRIO_CLASS_SHIFT) | \
+	 (((hint) & IOPRIO_HINT_MASK) << IOPRIO_HINT_SHIFT) |	 \
+	 ((level) & IOPRIO_LEVEL_MASK))
+
+/*
+ * IO hints.
+ */
+enum {
+	/* No hint */
+	IOPRIO_HINT_NONE = 0,
+
+	/*
+	 * Device command duration limits: indicate to the device a desired
+	 * duration limit for the commands that will be used to process an IO.
+	 * These will currently only be effective for SCSI and ATA devices that
+	 * support the command duration limits feature. If this feature is
+	 * enabled, then the commands issued to the device to process an IO with
+	 * one of these hints set will have the duration limit index (dld field)
+	 * set to the value of the hint.
+	 */
+	IOPRIO_HINT_DEV_DURATION_LIMIT_1 = 1,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_2 = 2,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_3 = 3,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_4 = 4,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_5 = 5,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_6 = 6,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
+};
+
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.39.2

