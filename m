Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C006761156B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJ1PEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJ1PEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:04:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F80F208825
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:04:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4736E1FB;
        Fri, 28 Oct 2022 08:04:07 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242A33F534;
        Fri, 28 Oct 2022 08:03:59 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:03:52 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
Message-ID: <Y1vvPBw4xB7m23wY@e120937-lin>
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
 <CAKfTPtBJy4SdbYUNHFn2ZXEO_pnaMPYibfjXWNBnXy49P2h78Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtBJy4SdbYUNHFn2ZXEO_pnaMPYibfjXWNBnXy49P2h78Q@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:40:02PM +0200, Vincent Guittot wrote:
> On Wed, 19 Oct 2022 at 22:46, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > Hi all,
> >

Hi Vincent,

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
> > In V2 the runtime enable/disable switching capability has been removed
> > (for now) since still not deemed to be stable/reliable enough: as a
> > consequence when SCMI Raw support is compiled in, the regular SCMI stack
> > drivers are now inhibited permanently for that Kernel.
> >
> > In V4 it has been added the support for transports lacking a completion_irq
> > or configured forcibly in polled mode.
> >
> > A quick and trivial example from the shell...reading from a sensor
> > injecting a properly crafted packet in raw mode:
> >
> >         # INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=1 (binary little endian)
> >         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message
> >
> >         # READING BACK THE REPLY...
> >         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/message | od --endian=little -t x4
> >         0000000 00005406 00000000 00000335 00000000
> >         0000020
> >
> > while doing that, since Raw mode makes (partial) use of the regular SCMI
> > stack, you can observe the messages going through the SCMI stack with the
> > usual traces:
> >
> >               bash-329     [000] ..... 14183.446808: scmi_msg_dump: pt=15 t=CMND msg_id=06 seq=0000 s=0 pyld=0100000000000000
> >    irq/35-mhu_db_l-81      [000] ..... 14183.447809: scmi_msg_dump: pt=15 t=RESP msg_id=06 seq=0000 s=0 pyld=3503000000000000
> >
> >
> > ..trying to read in async when the backend server does NOT supports asyncs:
> >
> >         # AN ASYNC SENSOR READING REQUEST...
> >         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x01\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message_async
> >
> >               bash-329     [000] ..... 16415.938739: scmi_msg_dump: pt=15 t=CMND msg_id=06 seq=0000 s=0 pyld=0100000001000000
> >    irq/35-mhu_db_l-81      [000] ..... 16415.944129: scmi_msg_dump: pt=15 t=RESP msg_id=06 seq=0000 s=-1 pyld=
> >
> >         # RETURNS A STATUS -1 FROM THE SERVER NOT SUPPORTING IT
> >         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/message | od --endian=little -t x4
> >         0000000 00005406 ffffffff
> >         0000010
> >
> > Note that this was on a JUNO, BUT exactly the same steps can be used to
> > reach an SCMI Server living on a VM reachable via virtio as long as the
> > system under test if properly configured to work with a virtio transport.
> >
> > In a nutshell the exposed API is as follows:
> >
> > /sys/kernel/debug/scmi_raw/
> > ├── errors
> > ├── message
> > ├── message_async
> > ├── notification
> > ├── reset
> > ├── transport_max_msg_size
> > ├── transport_rx_timeout_ms
> > └── transport_tx_max_msg
> >
> > where:
> >
> >  - message*: used to send sync/async commands and read back immediate and
> >    delayed responses (if any)
> >  - errors: used to report timeout and unexpected replies
> >  - reset: used to reset the SCMI Raw stack, flushing all queues from
> >    received messages still pending to be read out (useful to be sure to
> >    cleanup between test suite runs...)
> >  - notification: used to read any notification being spit by the system
> >    (if previously enabled by the user app)
> >  - transport*: a bunch of configuration useful to setup the user
> >    application expectations in terms of timeouts and message
> >    characteristics.
> >
> > Each write corresponds to one command request and the replies or delayed
> > response are read back one message at time (receiving an EOF at each
> > message boundary).
> >
> > The user application running the test is in charge of handling timeouts
> > and properly choosing SCMI sequence numbers for the outgoing requests: note
> > that the same fixed number can be re-used (...though discouraged...) as
> > long as the suite does NOT expect to send multiple in-flight commands
> > concurrently.
> >
> > Since the SCMI core regular stack is partially used to deliver and collect
> > the messages, late replies after timeouts and any other sort of unexpected
> > message sent by the SCMI server platform back can be identified by the SCMI
> > core as usual and it will be reported under /errors for later analysis.
> > (a userspace test-app will have anyway properly detected the timeout on
> >  /message* ...)
> >
> > All of the above has been roughly tested against a standard JUNO SCP SCMI
> > Server (mailbox trans) and an emulated SCMI Server living in a VM (virtio
> > trans) using a custom experimental version of the scmi-tests Compliance
> > suite patched to support Raw mode and posted at [2]. (still in development
> > ...merge requests are in progress...for now it is just a mean for me to
> > test the testing API ... O_o)
> >
> > The series is based on v6.1-rc1.
> >
> > Having said that (in such a concise and brief way :P) ...
> >
> > ...any feedback/comments are welcome !
> 
> Hi Cristian,
> 
> I have tested your series with an optee message transport layer and
> been able to send raw messages to the scmi server PTA
> 
> FWIW
> 
> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> 

Thanks a lot for your test and feedback !

... but I was going to reply to this saying that I spotted another issue
with the current SCMI Raw implementation (NOT related to optee/smc) so
that I'll post a V5 next week :P

Anyway, the issue is much related to the debugfs root used by SCMI Raw,
i.e.:

	/sys/kernel/debug/scmi_raw/

..this works fine unless you run it on a system sporting multiple DT-defined
server instances ...that is not officially supported but....ehm...a little
bird told these system with multiple servers do exists :D

In such a case the SCMI core stack is probed multiuple times and so it
will try to register multiple debugfs Raw roots: there is no chanche to
root the SCMI Raw entries at the same point clearly ... and then anyway
there is the issue of recognizing which server is rooted where ... with
the additional pain that a server CANNOT be recognized by querying...cause
there is only one by teh spec with agentID ZERO ... in theory :D...

So my tentaive solution for V5 would be:

- change the Raw root debugfs as:

	/sys/kernel/debug/scmi_raw/0/... (first server defined)

	/sys/kernel/debug/scmi_raw/1/... (possible additional server(s)..)

- expose the DT scmi-server root-node name of the server somewhere under
  that debugfs root like:

	..../scmi_raw/0/transport_name -> 'scmi-mbx'

	..../scmi_raw/1/transport_name -> 'scmi-virtio'

  so that if you know HOW you have configured your own system in the DT
  (maybe multiple servers with different kind of transports ?), you can
  easily select programmatically which one is which, and so decide
  which Raw debugfs fs to use...

... I plan to leave the SCMI ACS suite use by default the first system
rooted at /sys/kernel/debug/scmi_raw/0/...maybe adding a commandline
option to choose an alternative path for SCMI Raw.

Does all of this sound reasonable ?

Thanks,
Cristian

