Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34C06CA6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjC0OEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC0OEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:04:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EA65E5;
        Mon, 27 Mar 2023 07:04:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01310C14;
        Mon, 27 Mar 2023 07:05:07 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CAA93F6C4;
        Mon, 27 Mar 2023 07:04:21 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 0/2] Add SCMI support for mailbox unidirectional channels
Date:   Mon, 27 Mar 2023 15:03:40 +0100
Message-Id: <20230327140342.222168-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series aims to extend SCMI mailbox transport layer to support mailbox
controllers that expose unidirectional channels.

SCMI communications between an agent like Linux and the platform fw server
happens through 2 main communication channels: an 'a2p' bidirectional
channel (called TX in SCMI parlance) used to send synchronous commands
and receive related replies and an optional 'p2a' unidirectional channel
(called RX) used to convey notfications or delayed responses to asynchronous
commands possibly emitted by the platform toward the agent.

The current SCMI mailbox transport support was modelled around mailboxes
that were bidirectional by nature, and, as such, fit well in the above SCMI
communication scheme, allowing us to currently describe the mailbox
transport channels as in the following examples:

 1.  system with a single TX 'a2p' defined over a mailbox bidirectional
     channel:

	mboxes = <&mb 0 0>;
	shmem = <&a2p_mem>;

 2. system with a TX 'a2p' defined over a bidirectional mailbox channel
    AND an optional RX 'p2a' defined over a unidirectional channel:

	mboxes = <&mb 0 0>, <&mb 0 1>,
	shmem = <&a2p_shmem>, <&p2a_shmem>;

This binding, as it is now, does NOT support the usage of mailbox
controllers exposing channels that are unidirectional by nature, like
it is the case with ARM MHUv2 mailboxes as an example, since 2 distinct
unidirectional mailbox channels would be needed to represent just the
SCMI TX bidirectional communication path.

Note that the mboxes property referred in the SCMI nodes to configure the
transport is compliant with (and parsed by) the mailbox common subsystem,
which is the entity that exposes and finally handles the mailbox controller:
as a consequence playing creatively (or dirty :P) with the syntax of the
mboxes property to fit our needs is not an option.

This series extends the SCMI mailbox-related bindings, which defines how
mboxes and shmem properties are interpreted, and the logic inside the
SCMI mailbox transport subsystem to support the usage of these type of
unidirectional mailbox channels, while aiming to maintain backward
compatibility with the original scheme based on bidirectional channels.

With these proposed DT extensions, in addition to the above definitions,
the following descriptions can be crafted for a system using a mailbox
controller exposing unidirectional channels:

 2. system with a single TX 'a2p' defined over a pair of unidirectional
    mailbox channels (similar to 1):

	mboxes = <&mb_tx 0 0>, <&mb_rx 0 0>;
	shmem = <&a2p_mem>;

 3. system with a TX 'a2p' defined over a pair of unidirectional channels
    AND an RX 'p2a' defined over a unidirectional channel (similar to 2):

	mboxes = <&mb_tx 0 0>, <&mb_rx 0 0>, <&mb_rx 0 1>;
	shmem = <&a2p_shmem>, <&p2a_shmem>;

The SCMI mailbox transport logic has been modified to select and make a
proper use of the needed channels depending on the combination of found
mboxes/shmem descriptors:

  a) 1 mbox / 1 shmem => SCMI TX over 1 mailbox bidirectional channel
  b) 2 mbox / 2 shmem => SCMI TX and RX over 2 mailbox bidirectional chans

  c) 2 mbox / 1 shmem => SCMI TX over 2 mailbox unidirectional chans
  d) 3 mbox / 2 shmem => SCMI TX and RX over 3 mailbox unidirectional chans

with any other combination considered invalid.

Note that, up until the changes in this series, the only valid configs
accepted by the SCMI mailbox transport are a) and b): this ensures backward
compatibility even in the case in which a DT sporting the new format (c,d)
is, wrongly, deployed with an old kernel still not supporting this new logic:
in such a case c) and d) configs will be simply rejected. (wrongly deployed
because installing a c) or d) styled-DT would be required only if the
underlying mailbox HW had effectively changed and used unidir chans)

I have tested this on a JUNO board (MHUv1 bidirectional) and TotalCompute
TC2 reference design (MHUv2 unidirectional). [1]

The series is based on v6.3-rc4.

Having said that, I am not completely sure if all of the above constraints
should (and/or could) be expressed in a more formal way also in the YAML
binding itself.

Any feedback or suggestion in these regards is highly appreciated.

Thanks,
Cristian

[1]: https://gitlab.arm.com/arm-reference-solutions/arm-reference-solutions-docs/-/blob/master/docs/totalcompute/tc2/tc2_sw_stack.rst

----


Cristian Marussi (2):
  dt-bindings: firmware: arm,scmi: Support mailboxes unidirectional
    channels
  firmware: arm_scmi: Add support for unidirectional mailbox channels

 .../bindings/firmware/arm,scmi.yaml           | 42 +++++++-
 drivers/firmware/arm_scmi/mailbox.c           | 95 ++++++++++++++++---
 2 files changed, 122 insertions(+), 15 deletions(-)

-- 
2.34.1

