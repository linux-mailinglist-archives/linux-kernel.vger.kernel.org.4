Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D466A4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjAMVOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjAMVNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:13:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55BDD8BF03
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:12:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF28119F0;
        Fri, 13 Jan 2023 13:13:21 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC8423F587;
        Fri, 13 Jan 2023 13:12:37 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v7 13/17] firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
Date:   Fri, 13 Jan 2023 21:11:31 +0000
Message-Id: <20230113211135.2530064-14-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113211135.2530064-1-cristian.marussi@arm.com>
References: <20230113211135.2530064-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of the debugfs SCMI Raw ABI.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- split debugfs Raw ABI doc into its own docfile and changed
  the top rootfs structure
v4 --> v5
- updated ABI description for multiple SCMI instances support
---
 Documentation/ABI/testing/debugfs-scmi-raw | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw

diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/ABI/testing/debugfs-scmi-raw
new file mode 100644
index 000000000000..45817d465b1f
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-scmi-raw
@@ -0,0 +1,66 @@
+What:		/sys/kernel/debug/scmi/<n>/raw/message
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw synchronous message injection/snooping facility; write
+		a complete SCMI synchronous command message (header included)
+		in little-endian binary format to have it sent to the configured
+		backend SCMI server for instance <n>.
+		Any subsequently received response can be read from this same
+		entry if it arrived within the configured timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/message_async
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw asynchronous message injection/snooping facility; write
+		a complete SCMI asynchronous command message (header included)
+		in little-endian binary format to have it sent to the configured
+		backend SCMI server for instance <n>.
+		Any subsequently received response can be read from this same
+		entry if it arrived within the configured timeout.
+		Any additional delayed response received afterwards can be read
+		from this same entry too if it arrived within the configured
+		timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/errors
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw message errors facility; any kind of timed-out or
+		generally unexpectedly received SCMI message, for instance <n>,
+		can be read from this entry.
+		Each read gives back one message at time (receiving an EOF at
+		each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/notification
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw notification snooping facility; any notification
+		emitted by the backend SCMI server, for instance <n>, can be
+		read from this entry.
+		Each read gives back one message at time (receiving an EOF at
+		each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/reset
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw stack reset facility; writing a value to this entry
+		causes the internal queues of any kind of received message,
+		still pending to be read out for instance <n>, to be immediately
+		flushed.
+		Can be used to reset and clean the SCMI Raw stack between to
+		different test-run.
+Users:		Debugging, any userspace test suite
-- 
2.34.1

