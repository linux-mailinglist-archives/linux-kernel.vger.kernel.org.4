Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1F60518B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiJSUrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiJSUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:47:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB9221BE905
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:47:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4A71A25;
        Wed, 19 Oct 2022 13:47:07 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22693F792;
        Wed, 19 Oct 2022 13:46:59 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 09/11] firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
Date:   Wed, 19 Oct 2022 21:46:24 +0100
Message-Id: <20221019204626.3813043-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019204626.3813043-1-cristian.marussi@arm.com>
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of the debugfs SCMI Raw ABI.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi-raw | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw

diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/ABI/testing/debugfs-scmi-raw
new file mode 100644
index 000000000000..183ec678cb3e
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-scmi-raw
@@ -0,0 +1,88 @@
+What:		/sys/kernel/debug/scmi_raw/transport_max_msg_size
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	Max message size of allowed SCMI messages for the currently
+		configured SCMI transport.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi_raw/transport_tx_max_msg
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	Max number of concurrently allowed in-flight SCMI messages for
+		the currently configured SCMI transport.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi_raw/transport_rx_timeout_ms
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	Timeout in milliseconds allowed for SCMI synchronous replies
+		for the currently configured SCMI transport.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi_raw/message
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw synchronous message injection/snooping facility; write
+		a complete SCMI synchronous command message (header included)
+		in little-endian binary format to have it sent to the configured
+		backend SCMI server.
+		Any subsequently received response can be read from this same
+		entry if it arrived within the configured timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi_raw/message_async
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw asynchronous message injection/snooping facility; write
+		a complete SCMI asynchronous command message (header included)
+		in little-endian binary format to have it sent to the configured
+		backend SCMI server.
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
+What:		/sys/kernel/debug/scmi_raw/errors
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw message errors facility; any kind of timed-out or
+		generally unexpectedly received SCMI message can be read from
+		this entry.
+		Each read gives back one message at time (receiving an EOF at
+		each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi_raw/notification
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw notification snooping facility; any notification
+		emitted by the backend SCMI server can be read from this entry.
+		Each read gives back one message at time (receiving an EOF at
+		each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi_raw/reset
+Date:		December 2022
+KernelVersion:	6.1
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw stack reset facility; writing a value to this entry
+		causes the internal queues of any kind of received message,
+		still pending to be read out, to be flushed.
+		Can be used to reset and clean the SCMI Raw stack between to
+		different test-run.
+Users:		Debugging, any userspace test suite
-- 
2.34.1

