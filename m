Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99436188FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKCTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKCTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86C862099C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:52:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B8BF1FB;
        Thu,  3 Nov 2022 12:52:56 -0700 (PDT)
Received: from e120937-lin.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BABE43F534;
        Thu,  3 Nov 2022 12:52:47 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v5 0/14] Introduce a unified API for SCMI Server testing
Date:   Thu,  3 Nov 2022 19:52:11 +0000
Message-Id: <20221103195225.1028864-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series aims to introduce a new SCMI unified userspace interface meant
to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
from the perspective of the OSPM agent (non-secure world only ...)

It is proposed as a testing/development facility, it is NOT meant to be a
feature to use in production, but only enabled in Kconfig for test
deployments.

Currently an SCMI Compliance Suite like the one at [1] can only work by
injecting SCMI messages at the SCMI transport layer using the mailbox test
driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
the related replies from the SCMI backend Server.

This approach has a few drawbacks:

- the SCMI Server under test MUST be reachable through a mailbox based
  SCMI transport: any other SCMI Server placement is not possible (like in
  a VM reachable via SCMI Virtio). In order to cover other placements in
  the current scenario we should write some sort of test driver for each
  and every existent SCMI transport and for any future additional transport
  ...this clearly does not scale.

- even in the mailbox case the userspace Compliance suite cannot simply
  send and receive bare SCMI messages BUT it has to properly lay them out
  into the shared memory exposed by the mailbox test driver as expected by
  the transport definitions. In other words such a userspace test
  application has to, not only use a proper transport driver for the system
  at hand, but it also has to have a comprehensive knowledge of the
  internals of the underlying transport in order to operate.

- last but not least, the system under test has to be specifically
  configured and built, in terms of Kconfig and DT, to perform such kind of
  testing, it cannot be used for anything else, which is unfortunate for
  CI/CD deployments.

This series introduces a new SCMI Raw mode support feature that, when
configured and enabled exposes a new interface in debugfs through which:

- a userspace application can inject bare SCMI binary messages into the
  SCMI core stack; such messages will be routed by the SCMI regular kernel
  stack to the backend Server using the currently configured transport
  transparently: in other words you can test the SCMI server, no matter
  where it is placed, as long as it is reachable from the currently
  configured SCMI stack.
  Same goes the other way around on the reading path: any SCMI server reply
  can be read as a bare SCMI binary message from the same debugfs path.

- as a direct consequence of this way of injecting bare messages in the
  middle of the SCMI stack (instead of beneath it at the transport layer)
  the user application has to handle only bare SCMI messages without having
  to worry about the specific underlying transport internals that will be
  taken care of by the SCMI core stack itself using its own machinery,
  without duplicating such logic.

- a system under test, once configured with SCMI Raw support enabled in
  Kconfig, can be booted without any particular DT change.

In V2 the runtime enable/disable switching capability has been removed
(for now) since still not deemed to be stable/reliable enough: as a
consequence when SCMI Raw support is compiled in, the regular SCMI stack
drivers are now inhibited permanently for that Kernel.

In V4 it has been added the support for transports lacking a completion_irq
or configured forcibly in polled mode.

In V5 it has been added:

 - support for possibly multiple SCMI instances is introduced and as a
   consequence the API is now rooted at /sys/kernel/debug/scmi_raw/0/
   (with any additional SCMI insance Raw accessors rooted at scmi_raw/1/..
    scmi_raw/2/... etc)

 - a new COEXISTENCE mode is added that can be enabled with
   CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX=y

A quick and trivial example from the shell...reading from a sensor
injecting a properly crafted packet in raw mode:

	# INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=1 (binary little endian)
	root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/0/message

	# READING BACK THE REPLY...
	root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/0/message | od --endian=little -t x4
	0000000 00005406 00000000 00000335 00000000
	0000020

while doing that, since Raw mode makes (partial) use of the regular SCMI
stack, you can observe the messages going through the SCMI stack with the
usual traces:

              bash-329     [000] ..... 14183.446808: scmi_msg_dump: pt=15 t=cmnd msg_id=06 seq=0000 s=0 pyld=0100000000000000
   irq/35-mhu_db_l-81      [000] ..... 14183.447809: scmi_msg_dump: pt=15 t=resp msg_id=06 seq=0000 s=0 pyld=3503000000000000


..trying to read in async when the backend server does NOT supports asyncs:

	# AN ASYNC SENSOR READING REQUEST...
	root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x01\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/0/message_async

              bash-329     [000] ..... 16415.938739: scmi_msg_dump: pt=15 t=cmnd msg_id=06 seq=0000 s=0 pyld=0100000001000000
   irq/35-mhu_db_l-81      [000] ..... 16415.944129: scmi_msg_dump: pt=15 t=resp msg_id=06 seq=0000 s=-1 pyld=

	# RETURNS A STATUS -1 FROM THE SERVER NOT SUPPORTING IT
	root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/0/message | od --endian=little -t x4
	0000000 00005406 ffffffff
	0000010

Note that this was on a JUNO, BUT exactly the same steps can be used to
reach an SCMI Server living on a VM reachable via virtio as long as the
system under test if properly configured to work with a virtio transport.

In a nutshell the exposed API is as follows:

/sys/kernel/debug/scmi_raw/0/
├── errors
├── instance_name
├── message
├── message_async
├── notification
├── reset
├── transport_max_msg_size
├── transport_rx_timeout_ms
└── transport_tx_max_msg

where:

 - message*: used to send sync/async commands and read back immediate and
   delayed responses (if any)
 - errors: used to report timeout and unexpected replies
 - reset: used to reset the SCMI Raw stack, flushing all queues from
   received messages still pending to be read out (useful to be sure to
   cleanup between test suite runs...)
 - notification: used to read any notification being spit by the system
   (if previously enabled by the user app)
 - transport*: a bunch of configuration useful to setup the user
   application expectations in terms of timeouts and message
   characteristics.
 - instance_name: can be used to identify the SCMI instance that you are
   using through this Raw accessors: it corresponds to the SCMI DT top node
   full name of the underlying SCMI instance

Each write corresponds to one command request and the replies or delayed
response are read back one message at time (receiving an EOF at each
message boundary).

The user application running the test is in charge of handling timeouts
and properly choosing SCMI sequence numbers for the outgoing requests: note
that the same fixed number can be re-used (...though discouraged...) as
long as the suite does NOT expect to send multiple in-flight commands
concurrently.

Since the SCMI core regular stack is partially used to deliver and collect
the messages, late replies after timeouts and any other sort of unexpected
message sent by the SCMI server platform back can be identified by the SCMI
core as usual and it will be reported under /errors for later analysis.
(a userspace test-app will have anyway properly detected the timeout on
 /message* ...)

All of the above has been roughly tested against a standard JUNO SCP SCMI
Server (mailbox trans) and an emulated SCMI Server living in a VM (virtio
trans) using a custom experimental version of the scmi-tests Compliance
suite patched to support Raw mode and posted at [2]. (still in development
...merge requests are in progress...for now it is just a mean for me to
test the testing API ... O_o)

The V5 series is based on sudeep/for-next/scmi [3] on top of commit:

commit 729371745c53 ("hwmon: (scmi) Register explicitly with Thermal Framework")

Having said that (in such a concise and brief way :P) ...
	
...any feedback/comments are welcome !

Thanks,
Cristian

---
v4 --> v5
- rebased on sudeep/for-next/scmi
- added multiple SCMI instances support
- added optional Raw full-cohexistence mode
- use custom tags to distinguish Raw msg_dump traces
- add circular handling of raw buffers queues for errors and notifications

V3 --> v4
- rebased on v6.1-rc1
- addedd missing support for 'polled' transports and transport lacking a
  completion_irq (like smc/optee)
- removed a few inlines
- refactored SCMI Raw RX patch to make use more extensively of the regular
  non-Raw RX path
- fix handling of O_NONBLOCK raw_mode read requests

v2 --> v3
- fixed some sparse warning on LE and __poll_t
- reworked and simplified deferred worker in charge of xfer delayed waiting
- allow for injection of DT-unknown protocols messages when in Raw mode
  (needed for any kind of fuzzing...)

v1 --> v2
- added comments and debugfs docs
- added dedicated transport devices for channels initialization
- better channels handling in Raw mode
- removed runtime enable, moved to static compile time exclusion
  of SCMI regular stack

[1]: https://gitlab.arm.com/tests/scmi-tests
[2]: https://gitlab.arm.com/tests/scmi-tests/-/commits/raw_mode_support_devel/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi

Cristian Marussi (14):
  firmware: arm_scmi: Refactor xfer in-flight registration routines
  firmware: arm_scmi: Simplify chan_available transport operation
  firmware: arm_scmi: Use dedicated devices to initialize channels
  firmware: arm_scmi: Refactor polling helpers
  firmware: arm_scmi: Refactor scmi_wait_for_message_response
  firmware: arm_scmi: Add is_raw flag to xfer
  firmware: arm_scmi: Add xfer Raw helpers
  firmware: arm_scmi: Move errors defs and code to common.h
  firmware: arm_scmi: Add core Raw transmission support
  firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
  firmware: arm_scmi: Reject SCMI drivers while in Raw mode
  firmware: arm_scmi: Create Raw debugfs root dentry
  firmware: arm_scmi: Call Raw mode hooks from the core stack
  firmware: arm_scmi: Add Raw mode coexistence support

 Documentation/ABI/testing/debugfs-scmi-raw |   98 ++
 drivers/firmware/arm_scmi/Kconfig          |   23 +
 drivers/firmware/arm_scmi/Makefile         |    1 +
 drivers/firmware/arm_scmi/common.h         |   72 +-
 drivers/firmware/arm_scmi/driver.c         |  557 +++++---
 drivers/firmware/arm_scmi/mailbox.c        |    4 +-
 drivers/firmware/arm_scmi/optee.c          |    4 +-
 drivers/firmware/arm_scmi/protocols.h      |    2 +
 drivers/firmware/arm_scmi/raw_mode.c       | 1340 ++++++++++++++++++++
 drivers/firmware/arm_scmi/raw_mode.h       |   30 +
 drivers/firmware/arm_scmi/smc.c            |    4 +-
 drivers/firmware/arm_scmi/virtio.c         |    2 +-
 12 files changed, 1980 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw
 create mode 100644 drivers/firmware/arm_scmi/raw_mode.c
 create mode 100644 drivers/firmware/arm_scmi/raw_mode.h

-- 
2.34.1

