Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FCC646E02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLHLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiLHLDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:03:30 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63ED8932F;
        Thu,  8 Dec 2022 03:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670497303; x=1702033303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCnbh+fwg8DrIT+FYlYEQD8y0Pfiz4OuOe484jfsh6I=;
  b=WF7M/M0gZYeL85DrZtTqCfCS6zkX/+m1a+msuXiVf8QOClDHFkDREDPJ
   Rg1QZZy89VAuhlOntB7KooyI8ORtmKhEuz9G63FGEaKBxHFkFISUy18wW
   QqdwUPt3yl/yePjty68Ku9HuTgdscq94KZtFSmLt13ehMOj4I//jA9dUC
   FYarKEGn8QAr2+SPWRa3C+H1Dpk2i6fUcb+GEUQJnLWe5MsBzFN3D82xN
   xO7bFVIMqt+CjWbHZTCQGnAYzk/fLO/JTkVczAn5aJFxXYyoNOx7dltQB
   WREEfVF5a8He+ETJvrQkziWRXYrSeZ66k0twQmGg99KFA/HWxaBU3GvX7
   g==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665417600"; 
   d="scan'208";a="223333440"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2022 19:01:43 +0800
IronPort-SDR: iL4Xm1jd1bTg2a5A72vHqi8XeBtI03RDF+a46ZQnPaY+pk4a3XhQCJtgiZA2OLTks5kafZXKKU
 7vGglxgSzpWdr7aHaOREUygpX976NJwpPG5CnI7/1Hsa79dcwH3svQZ0D/JjxuJCoq0f3grRjk
 E5ZlQiXQgcs0IXQenoM8SEgr4RgUMRWSqI4Tz9JqxwnRi5VX/M8pAXfWruF9Y20CZl41rVL+sc
 vZCzFt7ICGEL6ZvT7SoOz3m7BLzcXK1iByoFtblD4XcstAnMZB83ZyIOfg7+571dqwYC+fZbX6
 tEU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 02:14:28 -0800
IronPort-SDR: lH0I2LL8Td+V8zpKZDvQN2JXyuFfwFJ/WJwJHI4g3oCU4OlnnIcGij+ff7/scdguZZUCNa/fV3
 oUsBUre7SroxLel2sEwxi1V83Jg+lIsxL4spr3yVrSdv0H1Zav9wKxN4Sj7goW2Uia4TE8d8vC
 sqcT0kHSamh1GII5KG6vz1/0ZHywU5/cpRqbSiVPJ4qpb1lhSq6plpfnDdWuweLeloSNKC4mQZ
 YqXRhfXkPvWAetm/yNR1oTJkSOopt0hL53YsbYGChTzrBaJGaNYg2tCMKqtr9r5o8oI61YS8n/
 gkA=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Dec 2022 03:01:43 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 25/25] Documentation: sysfs-block-device: document command duration limits
Date:   Thu,  8 Dec 2022 11:59:41 +0100
Message-Id: <20221208105947.2399894-26-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208105947.2399894-1-niklas.cassel@wdc.com>
References: <20221208105947.2399894-1-niklas.cassel@wdc.com>
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
---
 Documentation/ABI/testing/sysfs-block-device | 143 +++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
index 7ac7b19b2f72..44841f91c69b 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -95,3 +95,146 @@ Description:
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
+		"/sys/block/*/device/duration_limits" does not exist).
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
+			     earliest possible time consistent with the
+			     specified command duration guideline.
+		      - 0x1: If the specified command duration guideline has
+			     not been achieved and the command duration
+			     guideline policy field is not the seventh command
+			     duration limits descriptor, then the device
+			     continues processing that command using the
+			     command duration limits descriptor that has
+			     the next higher number.
+		      - 0x2: The device will continue processing the command
+			     as with no command duration limits descriptor
+			     being used.
+		      - 0xD: The device will complete the command and an IO
+			     failure will be reported to the user with the ETIME
+			     error code.
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
+			     earliest possible time (i.e, do nothing based on
+			     the max limit not being met).
+		      - 0xD: The device will complete the command and an IO
+			     failure will be reported to the user with the ETIME
+			     error code.
+		      - 0xE: Same as 0xD.
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
+			     earliest possible time (i.e, do nothing based on
+			     the time limit not being met).
+		      - 0xD: The device will complete the command and an IO
+			     failure will be reported to the user with the ETIME
+			     error code.
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
2.38.1

