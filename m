Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E96751CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjATJ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjATJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:57:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6864CAA5EF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:56:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80C3014BF;
        Fri, 20 Jan 2023 01:57:26 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16D093F71A;
        Fri, 20 Jan 2023 01:56:42 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:56:32 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Subject: Re: [PATCH v8 00/17] Introduce a unified API for SCMI Server testing
Message-ID: <Y8plUOoQu7G9PQXZ@e120937-lin>
References: <20230118121426.492864-1-cristian.marussi@arm.com>
 <CAKfTPtBUQS9D3nJLD5RPbOAs76ZdGhaX50_ns_Qm3X+UbZb-1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBUQS9D3nJLD5RPbOAs76ZdGhaX50_ns_Qm3X+UbZb-1w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:11:24AM +0100, Vincent Guittot wrote:
> On Wed, 18 Jan 2023 at 13:15, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > Hi all,
> >
> > This series aims to introduce a new SCMI unified userspace interface meant
> > to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> > from the perspective of the OSPM agent (non-secure world only ...)
> >
> > It is proposed as a testing/development facility, it is NOT meant to be a
> > feature to use in production, but only enabled in Kconfig for test
> > deployments.
> >
> > Currently an SCMI Compliance Suite like the one at [1] can only work by
> > injecting SCMI messages at the SCMI transport layer using the mailbox test
> > driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> > the related replies from the SCMI backend Server.
> >
> > This approach has a few drawbacks:
> >
> > - the SCMI Server under test MUST be reachable through a mailbox based
> >   SCMI transport: any other SCMI Server placement is not possible (like in
> >   a VM reachable via SCMI Virtio). In order to cover other placements in
> >   the current scenario we should write some sort of test driver for each
> >   and every existent SCMI transport and for any future additional transport
> >   ...this clearly does not scale.
> >
> > - even in the mailbox case the userspace Compliance suite cannot simply
> >   send and receive bare SCMI messages BUT it has to properly lay them out
> >   into the shared memory exposed by the mailbox test driver as expected by
> >   the transport definitions. In other words such a userspace test
> >   application has to, not only use a proper transport driver for the system
> >   at hand, but it also has to have a comprehensive knowledge of the
> >   internals of the underlying transport in order to operate.
> >
> > - last but not least, the system under test has to be specifically
> >   configured and built, in terms of Kconfig and DT, to perform such kind of
> >   testing, it cannot be used for anything else, which is unfortunate for
> >   CI/CD deployments.
> >
> > This series introduces a new SCMI Raw mode support feature that, when
> > configured and enabled exposes a new interface in debugfs through which:
> >
> > - a userspace application can inject bare SCMI binary messages into the
> >   SCMI core stack; such messages will be routed by the SCMI regular kernel
> >   stack to the backend Server using the currently configured transport
> >   transparently: in other words you can test the SCMI server, no matter
> >   where it is placed, as long as it is reachable from the currently
> >   configured SCMI stack.
> >   Same goes the other way around on the reading path: any SCMI server reply
> >   can be read as a bare SCMI binary message from the same debugfs path.
> >
> > - as a direct consequence of this way of injecting bare messages in the
> >   middle of the SCMI stack (instead of beneath it at the transport layer)
> >   the user application has to handle only bare SCMI messages without having
> >   to worry about the specific underlying transport internals that will be
> >   taken care of by the SCMI core stack itself using its own machinery,
> >   without duplicating such logic.
> >
> > - a system under test, once configured with SCMI Raw support enabled in
> >   Kconfig, can be booted without any particular DT change.
> >
> > Latest V6 additions:
> >
> >  - improved scmi traces for msg dumps to include used channels
> >  - added a new common SCMI debugfs root fs
> >  - reworked SCMI Raw debugfs layout
> >  - added support of a new additional per-channel API that allows a user to
> >    select a specific egress channel for the message injection (when more
> >    than one channel is available)
> >
> > A quick and trivial example from the shell...reading from a sensor by
> > injecting a properly crafted packet in raw mode (letting the stack select
> > the channel):
> >
> >         # INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=1 (binary little endian)
> >         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi/0/raw/message
> >
> >         # READING BACK THE REPLY...
> >         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi/0/raw/message | od --endian=little -t x4
> >         0000000 00005406 00000000 00000335 00000000
> >         0000020
> >
> > while doing that, since Raw mode makes (partial) use of the regular SCMI
> > stack, you can observe the messages going through the SCMI stack with the
> > usual traces:
> >
> >               bash-329     [000] ..... 14183.446808: scmi_msg_dump: id=0 ch=10 pt=15 t=cmnd msg_id=06 seq=0000 s=0 pyld=0100000000000000
> >    irq/35-mhu_db_l-81      [000] ..... 14183.447809: scmi_msg_dump: id=0 ch=10 pt=15 t=resp msg_id=06 seq=0000 s=0 pyld=3503000000000000
> >
> > ..trying to read in async when the backend server does NOT supports asyncs:
> >
> >         # AN ASYNC SENSOR READING REQUEST...
> >         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x01\\x00\\x00\\x00 > /sys/kernel/debug/scmi/0/raw/message_async
> >
> >               bash-329     [000] ..... 16415.938739: scmi_msg_dump: id=0 ch=10 pt=15 t=cmnd msg_id=06 seq=0000 s=0 pyld=0100000001000000
> >    irq/35-mhu_db_l-81      [000] ..... 16415.944129: scmi_msg_dump: id=0 ch=10 pt=15 t=resp msg_id=06 seq=0000 s=-1 pyld=
> >
> >         # RETURNS A STATUS -1 FROM THE SERVER NOT SUPPORTING IT
> >         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi/0/raw/message | od --endian=little -t x4
> >         0000000 00005406 ffffffff
> >         0000010
> >
> > Note that the above example was on a JUNO, BUT exactly the same steps can
> > be used to reach an SCMI Server living on a VM reachable via virtio as
> > long as the system under test if properly configured to work with a
> > virtio transport.
> >
> > In a nutshell the exposed API is as follows:
> >
> > /sys/kernel/debug/scmi/
> > `-- 0
> >     |-- atomic_threshold_us
> >     |-- instance_name
> >     |-- raw
> >     |   |-- channels
> >     |   |   |-- 0x10
> >     |   |   |   |-- message
> >     |   |   |   `-- message_async
> >     |   |   `-- 0x13
> >     |   |       |-- message
> >     |   |       `-- message_async
> >     |   |-- errors
> >     |   |-- message
> >     |   |-- message_async
> >     |   |-- notification
> >     |   `-- reset
> >     `-- transport
> >         |-- is_atomic
> >         |-- max_msg_size
> >         |-- max_rx_timeout_ms
> >         |-- rx_max_msg
> >         |-- tx_max_msg
> >         `-- type
> >
> > ... where at the top level:
> >
> >  - <N>: a progressive sequence number identifying this SCMI instance, in
> >    case there are multiple SCMI instance defined
> >
> >  - instance_name: can be used (by CI) to identify the SCMI instance <N>
> >    that you are using through this Raw accessors: it corresponds to the SCMI
> >    DT top node full name of the underlying SCMI instance
> >
> >
> > ... rooted under /transport:
> >
> >  - a bunch of configuration info useful to setup the user application
> >    expectations in terms of timeouts and message characteristics.
> >
> >
> > ... rooted at /raw (the real SCMI Raw interface :D):
> >
> >  - message*: used to send sync/async commands and read back immediate and
> >    delayed responses (if any)
> >  - errors: used to report timeout and unexpected replies
> >  - reset: used to reset the SCMI Raw stack, flushing all queues from
> >    received messages still pending to be read out (useful to be sure to
> >    cleanup between test suite runs...)
> >  - notification: used to read any notification being spit by the system
> >    (if previously enabled by the user app)
> >
> >
> > ... rooted at /raw/channels/<M>/:
> 

Hi Vincent,

thanks for trying this out.

> I haven't seen a description of the <M>. I figured out that this is
> the protocol id to which the channel was associated in DT while
> testing it but it could be good to describe this somewhere.

Ah, damn yes, I had made a note to myself to add an explicit description
of how the channel number IDs are chosen, then I forgot :P

I'll add a follow-on patch once is queued.

> Apart from this minor thing, I have tested it with an scmi server
> embedded in OPTEE and run the scmi compliance tests. Everything works
> fine using the default mode or using one specific channel.
> 
> FWIW
> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> 

Thanks,
Cristian

