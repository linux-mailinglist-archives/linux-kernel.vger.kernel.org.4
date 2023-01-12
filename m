Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D26674B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjALOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjALOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:10:28 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5B58D2F;
        Thu, 12 Jan 2023 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673532326; x=1705068326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iJuqTlHbB+r3PzdoLMxijeGItAuqi1spp9PVHEVw1+Q=;
  b=BB+ZEaRH048ynRkNCF6qZEDWEHQVFxHpjVczowpFFkVSrzGzAUGjchmi
   VdYNx8Key3AyHS+JdOBGj0jnH1oqwuhNap2GNcCjvYTvYuhNuNJPuq5i0
   YMYGyrXA/GVKtEUUI+w8JI7no5CT04FbfDK7aZvAzyWbnvujb3QTAgnlS
   qopJdWv3EwZss+bFSDQg9YEF8A+UMdTvCfqiaJhHBe0CBaTBVFtR8NFwu
   peI8GSBOlAkicyVQNthI6hW8IpiEu9Mo3sjjVH2Wj4TrbbBcDT23vuPAn
   gQ/mef8cYJCZuaS+Rxc2ypAZVuuCRFQ8ub87KMq4IEq99Zlj2HUOJx22R
   A==;
X-IronPort-AV: E=Sophos;i="5.97,211,1669046400"; 
   d="scan'208";a="332632758"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 22:05:11 +0800
IronPort-SDR: 22K2g1Z8G7SXmFvm94GpnZ7kqixbQVzvSEyFyHhykCFwL0cdcUUpJ9BesneZAzy8au7IpZJHJd
 A4maT8dAUvq20aYBQyLug5R1OeRZF3Vcgzq3pwRVvfjZa1+D09xTI4B9HghdC9gS6bVOzpFuMa
 athrdrRBEEADbTcprihRV1ivrYjbUHwe1owQiNQyxgjH6lF+RM/LUPapnKzXYSfoKJrAkgI6YD
 tVdgAdPAlRngnav3ygh2YuacPuRiMv2xeXkffCtPWClrJNl0tXWx6ecrzCd+SkeXQfdLXAhwBp
 AkI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jan 2023 05:17:15 -0800
IronPort-SDR: mJE5jswxrS6xxVKtsQhZZpLT6y1e0Rb01aQCv8cd82+fdSPygaN36UdtAPmGHiVsiXI7cQphlY
 bkUYjmvKmoVoNPdT9itS62M+rlmp69nkf+xhYqc59a8A/76yRaVBMNQeSJeE+8uQ/OLA+z28g0
 Yvn80elQQrR1aPyAwNCRJkSUhdhq/EpsN4b3v6C/nkQKnMcJAKxpqoQ2MPLrp5/9tKGpDf4dRi
 cOEb1Yxiy8fGRTGV+G+pAXEtNFU46a/q9U12kfTmFvY+9tdI8pyk+v+tWchCkgtoF9fp48t9ey
 txs=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.12])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2023 06:05:10 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 18/18] Documentation: sysfs-block-device: document command duration limits
Date:   Thu, 12 Jan 2023 15:04:07 +0100
Message-Id: <20230112140412.667308-19-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112140412.667308-1-niklas.cassel@wdc.com>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
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

Document ABI/testing/sysfs-block-device the sysfs attributes present
under /sys/block/*/device/duration_limits for ATA and SCSI devices
supporting the command duration limits feature.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 Documentation/ABI/testing/sysfs-block-device | 150 +++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
index 7ac7b19b2f72..3a32c86942f5 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -95,3 +95,153 @@ Description:
 		This file does not exist if the HBA driver does not implement
 		support for the SATA NCQ priority feature, regardless of the
 		device support for this feature.
+
+
+What:		/sys/block/*/device/duration_limits/enable
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RW) For ATA and SCSI devices supporting the command duration
+		limits feature, write to the file to turn on or off the
+		feature. By default this feature is turned off. If the device
+		does not support the command duration limits feature, this
+		attribute does not exist (the directory
+		"/sys/block/\*/device/duration_limits" does not exist).
+		Writing "1" to this file enables the use of command duration
+		limits for read and write commands in the kernel and turns on
+		the feature on the device. Writing "0" disables the feature.
+
+
+What:		/sys/block/*/device/duration_limits/read/[1-7]/*
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the set of 7 command duration limits
+		descriptors for read commands currently set on the device. For
+		each of the 7 descritors, the following read-only attributes
+		are present:
+
+		  - duration_guideline: specifies the preferred length of time
+		    in microseconds for the completion of a command.
+
+		  - duration_guideline_policy: specifies the policy action
+		    taken if the duration_guideline attribute specifies a
+		    non-zero command duration guideline that the device is
+		    unable to achieve for a command.
+
+		    Possible values are:
+
+		      - 0x0: The device will complete the command at the
+			earliest possible time consistent with the specified
+			command duration guideline.
+
+		      - 0x1: If the specified command duration guideline has not
+			been achieved and the command duration guideline policy
+			field is not in the seventh command duration limits
+			descriptor, then the device continues processing that
+			command using the command duration limits descriptor
+			that has the next higher number.
+
+		      - 0x2: The device will continue processing the command as
+			with no command duration limits descriptor being used.
+
+		      - 0xD: The device will complete the command and an IO
+			failure will be reported to the user with the ETIME
+			error code.
+
+		      - 0xF: Same as 0xD.
+
+		  - max_active_time: specifies an upper limit in microseconds
+		    on the time that elapses from the time at which the device
+		    initiates actions to access, transfer, or act upon the
+		    specified data until the time the device returns status for
+		    the command.
+
+		  - max_active_time_policy: specifies the policy action taken
+		    if the time used to process a command exceeds a non-zero
+		    time specified by the max_active_time attribute.
+
+		    Possible values are:
+
+		      - 0x0: The device will complete the command at the
+			earliest possible time (i.e, do nothing based on the max
+			time limit not being met).
+
+		      - 0xD: The device will complete the command and an IO
+			failure will be reported to the user with the ETIME
+			error code.
+
+		      - 0xE: Same as 0xD.
+
+		      - 0xF: Same as 0xD.
+
+		  - max_inactive_time: specifies an upper limit in microseconds
+		    on the time that elapses from the time at which the device
+		    receives the command until the time at which the device
+		    initiates actions to access, transfer, or act upon the
+		    specified data.
+
+		  - max_inactive_time_policy: specifies the policy action taken
+		    if a non-zero max_inactive_time limit is not met.
+
+		    Possible values are:
+
+		      - 0x0: The device will complete the command at the
+			earliest possible time (i.e, do nothing based on the max
+			time limit not being met).
+
+		      - 0xD: The device will complete the command and an IO
+			failure will be reported to the user with the ETIME
+			error code.
+
+		      - 0xF: Same as 0xD.
+
+
+What:		/sys/block/*/device/duration_limits/read/page
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the name of the device VPD page
+		specifying the set of 7 command duration limits descriptors for
+		read commands. Possible values are "T2A" and "T2B".
+
+
+What:		/sys/block/*/device/duration_limits/write/[1-7]/*
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the set of 7 command duration limits
+		descriptors for write commands currently set on the device. For
+		each of the 7 descritors, the same set of read-only attributes
+		as for read commands is present.
+
+
+What:		/sys/block/*/device/duration_limits/write/page
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the name of the device VPD page
+		specifying the set of 7 command duration limits descriptors for
+		write commands. Possible values are "T2A" and "T2B".
+
+
+What:		/sys/block/*/device/duration_limits/perf_vs_duration_guideline
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this specifies the maximum percentage increase
+		in average command completion times (reduction in IOPS) that
+		is allowed for the device to perform actions based on the
+		contents of the duration guideline field in every command
+		duration limit descriptor for both read and write commands.
-- 
2.39.0

