Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B21674F30
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjATILo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjATILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:11:41 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AAD891CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:11:36 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f3so3541591pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbD9/yqdYF7lSP8WNZZT9woVhbFZKY69niohOqJ0dU4=;
        b=nBjjCVYbyHUdjpyuZnlxuScQSwriVcOIjE9kkz9Rhr6xRiRVdxfP7AKKc915z9QDSF
         jAU/qCl6fXi2lWoy4/+gQkoJP0cDZakq1VRvZAxCpcUCnK83jkY4vKukl+0wzho+Kch5
         dVzdBUWKCxb79tVZoeiKiUglHvAPuoNYel31aCQRxBjNi9woit3kN8ncPCZmcGR3nn9H
         JS3xZPZc0+/qo+wZvR2tTUZDnsYowLIufnOR3n1UvXvMkn3vRYfpBSHiAh8pvy5CEY1/
         aDdshi07XFE2apvpiX+RLya24d7mljVED+9GgmjE+7SwXulrFHwERHdhT5gplSwxyv3q
         VPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbD9/yqdYF7lSP8WNZZT9woVhbFZKY69niohOqJ0dU4=;
        b=jePO3UuQdBMwVWD9WJbYq9nSk8tGqLXL67BRyDQDpyTHLMkC4ztJV66P9Gy3rarUgm
         zPlqqWxA+HYR34L0lvDky+ugMRF6TzV8OWIDuOcial322e77n+Lx9n8ZSCfzkp5MR/l2
         RlfmbSTzLfJATrb58NCsIZLrVB4OxLVtsl2OIyfR+eYoYyRju6YzFTKtGZNYdK9jFgz0
         WAaDOGJ3Nlq47VckX+BvraE7uoXLW4ECyL9r7BikhqK2b/SZ2X/zcwciEvt/rVXkvNFh
         GuqcI1cD9SiTIZXVCp5iKEWfvlHkReB/CeMypCC+h2VeMkTb7lLcJm2lxZQCVGoaEU+r
         BcTA==
X-Gm-Message-State: AFqh2krmmYUjc7G6jzTQbn2lbblw/oKhdl3k/e1qliEgAAT06VKbxbAI
        HyfNIf1fDa7vVJYbEUeHFHBxJMXhACTV6AbQCL2uBg==
X-Google-Smtp-Source: AMrXdXtVBtURAnLcISa0fbVzSblC+ver6Xfq5dzxXPPxqot4I8OmMBhtDPZE39/Kk5MtXrk3l5NufYDzjrNOTTa0I5Y=
X-Received: by 2002:aa7:85d3:0:b0:583:2cb5:aa0d with SMTP id
 z19-20020aa785d3000000b005832cb5aa0dmr1429416pfn.86.1674202295928; Fri, 20
 Jan 2023 00:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20230118121426.492864-1-cristian.marussi@arm.com>
In-Reply-To: <20230118121426.492864-1-cristian.marussi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Jan 2023 09:11:24 +0100
Message-ID: <CAKfTPtBUQS9D3nJLD5RPbOAs76ZdGhaX50_ns_Qm3X+UbZb-1w@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] Introduce a unified API for SCMI Server testing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 at 13:15, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> Hi all,
>
> This series aims to introduce a new SCMI unified userspace interface meant
> to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> from the perspective of the OSPM agent (non-secure world only ...)
>
> It is proposed as a testing/development facility, it is NOT meant to be a
> feature to use in production, but only enabled in Kconfig for test
> deployments.
>
> Currently an SCMI Compliance Suite like the one at [1] can only work by
> injecting SCMI messages at the SCMI transport layer using the mailbox test
> driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> the related replies from the SCMI backend Server.
>
> This approach has a few drawbacks:
>
> - the SCMI Server under test MUST be reachable through a mailbox based
>   SCMI transport: any other SCMI Server placement is not possible (like in
>   a VM reachable via SCMI Virtio). In order to cover other placements in
>   the current scenario we should write some sort of test driver for each
>   and every existent SCMI transport and for any future additional transport
>   ...this clearly does not scale.
>
> - even in the mailbox case the userspace Compliance suite cannot simply
>   send and receive bare SCMI messages BUT it has to properly lay them out
>   into the shared memory exposed by the mailbox test driver as expected by
>   the transport definitions. In other words such a userspace test
>   application has to, not only use a proper transport driver for the system
>   at hand, but it also has to have a comprehensive knowledge of the
>   internals of the underlying transport in order to operate.
>
> - last but not least, the system under test has to be specifically
>   configured and built, in terms of Kconfig and DT, to perform such kind of
>   testing, it cannot be used for anything else, which is unfortunate for
>   CI/CD deployments.
>
> This series introduces a new SCMI Raw mode support feature that, when
> configured and enabled exposes a new interface in debugfs through which:
>
> - a userspace application can inject bare SCMI binary messages into the
>   SCMI core stack; such messages will be routed by the SCMI regular kernel
>   stack to the backend Server using the currently configured transport
>   transparently: in other words you can test the SCMI server, no matter
>   where it is placed, as long as it is reachable from the currently
>   configured SCMI stack.
>   Same goes the other way around on the reading path: any SCMI server reply
>   can be read as a bare SCMI binary message from the same debugfs path.
>
> - as a direct consequence of this way of injecting bare messages in the
>   middle of the SCMI stack (instead of beneath it at the transport layer)
>   the user application has to handle only bare SCMI messages without having
>   to worry about the specific underlying transport internals that will be
>   taken care of by the SCMI core stack itself using its own machinery,
>   without duplicating such logic.
>
> - a system under test, once configured with SCMI Raw support enabled in
>   Kconfig, can be booted without any particular DT change.
>
> Latest V6 additions:
>
>  - improved scmi traces for msg dumps to include used channels
>  - added a new common SCMI debugfs root fs
>  - reworked SCMI Raw debugfs layout
>  - added support of a new additional per-channel API that allows a user to
>    select a specific egress channel for the message injection (when more
>    than one channel is available)
>
> A quick and trivial example from the shell...reading from a sensor by
> injecting a properly crafted packet in raw mode (letting the stack select
> the channel):
>
>         # INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=1 (binary little endian)
>         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi/0/raw/message
>
>         # READING BACK THE REPLY...
>         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi/0/raw/message | od --endian=little -t x4
>         0000000 00005406 00000000 00000335 00000000
>         0000020
>
> while doing that, since Raw mode makes (partial) use of the regular SCMI
> stack, you can observe the messages going through the SCMI stack with the
> usual traces:
>
>               bash-329     [000] ..... 14183.446808: scmi_msg_dump: id=0 ch=10 pt=15 t=cmnd msg_id=06 seq=0000 s=0 pyld=0100000000000000
>    irq/35-mhu_db_l-81      [000] ..... 14183.447809: scmi_msg_dump: id=0 ch=10 pt=15 t=resp msg_id=06 seq=0000 s=0 pyld=3503000000000000
>
> ..trying to read in async when the backend server does NOT supports asyncs:
>
>         # AN ASYNC SENSOR READING REQUEST...
>         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x01\\x00\\x00\\x00 > /sys/kernel/debug/scmi/0/raw/message_async
>
>               bash-329     [000] ..... 16415.938739: scmi_msg_dump: id=0 ch=10 pt=15 t=cmnd msg_id=06 seq=0000 s=0 pyld=0100000001000000
>    irq/35-mhu_db_l-81      [000] ..... 16415.944129: scmi_msg_dump: id=0 ch=10 pt=15 t=resp msg_id=06 seq=0000 s=-1 pyld=
>
>         # RETURNS A STATUS -1 FROM THE SERVER NOT SUPPORTING IT
>         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi/0/raw/message | od --endian=little -t x4
>         0000000 00005406 ffffffff
>         0000010
>
> Note that the above example was on a JUNO, BUT exactly the same steps can
> be used to reach an SCMI Server living on a VM reachable via virtio as
> long as the system under test if properly configured to work with a
> virtio transport.
>
> In a nutshell the exposed API is as follows:
>
> /sys/kernel/debug/scmi/
> `-- 0
>     |-- atomic_threshold_us
>     |-- instance_name
>     |-- raw
>     |   |-- channels
>     |   |   |-- 0x10
>     |   |   |   |-- message
>     |   |   |   `-- message_async
>     |   |   `-- 0x13
>     |   |       |-- message
>     |   |       `-- message_async
>     |   |-- errors
>     |   |-- message
>     |   |-- message_async
>     |   |-- notification
>     |   `-- reset
>     `-- transport
>         |-- is_atomic
>         |-- max_msg_size
>         |-- max_rx_timeout_ms
>         |-- rx_max_msg
>         |-- tx_max_msg
>         `-- type
>
> ... where at the top level:
>
>  - <N>: a progressive sequence number identifying this SCMI instance, in
>    case there are multiple SCMI instance defined
>
>  - instance_name: can be used (by CI) to identify the SCMI instance <N>
>    that you are using through this Raw accessors: it corresponds to the SCMI
>    DT top node full name of the underlying SCMI instance
>
>
> ... rooted under /transport:
>
>  - a bunch of configuration info useful to setup the user application
>    expectations in terms of timeouts and message characteristics.
>
>
> ... rooted at /raw (the real SCMI Raw interface :D):
>
>  - message*: used to send sync/async commands and read back immediate and
>    delayed responses (if any)
>  - errors: used to report timeout and unexpected replies
>  - reset: used to reset the SCMI Raw stack, flushing all queues from
>    received messages still pending to be read out (useful to be sure to
>    cleanup between test suite runs...)
>  - notification: used to read any notification being spit by the system
>    (if previously enabled by the user app)
>
>
> ... rooted at /raw/channels/<M>/:

I haven't seen a description of the <M>. I figured out that this is
the protocol id to which the channel was associated in DT while
testing it but it could be good to describe this somewhere.
Apart from this minor thing, I have tested it with an scmi server
embedded in OPTEE and run the scmi compliance tests. Everything works
fine using the default mode or using one specific channel.

FWIW
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks

>
>  - message*: used to send sync/async commands and read back immediate and
>    delayed responses (if any), using a SPECIFIC transport channel <M>
>    (instead of letting the system choose for you based on transport config
>     and the rotocol embedded in the injected message)
>    NOTE THAT these entries are optional, created only if there is more than
>    transport channel defined on the system.
>
> Each write corresponds to one command request and the replies or delayed
> response are read back one message at time (receiving an EOF at each
> message boundary).
>
> The user application running the test is in charge of handling timeouts
> and properly choosing SCMI sequence numbers for the outgoing requests: note
> that the same fixed number can be re-used (...though discouraged...) as
> long as the suite does NOT expect to send multiple in-flight commands
> concurrently.
>
> Since the SCMI core regular stack is partially used to deliver and collect
> the messages, late replies after timeouts and any other sort of unexpected
> message sent by the SCMI server platform back can be identified by the SCMI
> core as usual and it will be reported under /errors for later analysis.
> (a userspace test-app will have anyway properly detected the timeout on
>  /message* ...)
>
> All of the above has been roughly tested against a standard JUNO SCP SCMI
> Server (mailbox trans) and an emulated SCMI Server living in a VM (virtio
> trans) using a custom experimental version of the scmi-tests Compliance
> suite patched to support Raw mode and posted at [2]. (still in development
> ...merge requests are in progress...for now it is just a mean for me to
> test the testing API ... O_o)
>
> This V8 series is based on v6.2-rc1 PLUS another series which reworked a
> bit the SCMI core stack init/probe [3]; to ease testing a V8 properly
> based can be picked up from [4].
>
> Having said that (in such a concise and brief way :P) ...
>
> ...any feedback/comments are welcome !
>
> Thanks,
> Cristian
>
> ---
> v7 --> v8
> - fixed a few bad handling on error path
> - ignoring debugfs_ retvals as supposed to
> - using XArray for per-channel queus instead of IDRs
> - refactored debugfs setup calls
>
> v6 --> v7
> - fixed one sparse error
> - removed redundant info.num_chans/channels fields: enumerate them dyamically
>   once needed.
>
> v5 --> v6
> - exported symbol debugfs_create_str
> - rebased on top of v6.2-rc1 plus series at [3]
> - redesigned SCMI debugfs layout with a bunch of common entries
>   enabled by implicit CONFIG_ARM_SCMI_NEED_DEBUGFS
> - refactored SCMI Raw internal queues handling
> - added SCMI Raw per-channel injection support
> - added channels info on SCMI msg_dump traces
> - fix debugfs multiple writers cases
> - added DEBUG_FS dependency to Raw mode
> - select CONFIG_ARM_SCMI_NEED_DEBUGFS when Raw mode is compiled
>
> v4 --> v5
> - rebased on sudeep/for-next/scmi
> - added multiple SCMI instances support
> - added optional Raw full-cohexistence mode
> - use custom tags to distinguish Raw msg_dump traces
> - add circular handling of raw buffers queues for errors and notifications
>
> V3 --> v4
> - rebased on v6.1-rc1
> - addedd missing support for 'polled' transports and transport lacking a
>   completion_irq (like smc/optee)
> - removed a few inlines
> - refactored SCMI Raw RX patch to make use more extensively of the regular
>   non-Raw RX path
> - fix handling of O_NONBLOCK raw_mode read requests
>
> v2 --> v3
> - fixed some sparse warning on LE and __poll_t
> - reworked and simplified deferred worker in charge of xfer delayed waiting
> - allow for injection of DT-unknown protocols messages when in Raw mode
>   (needed for any kind of fuzzing...)
>
> v1 --> v2
> - added comments and debugfs docs
> - added dedicated transport devices for channels initialization
> - better channels handling in Raw mode
> - removed runtime enable, moved to static compile time exclusion
>   of SCMI regular stack
>
> [1]: https://gitlab.arm.com/tests/scmi-tests
> [2]: https://gitlab.arm.com/tests/scmi-tests/-/commits/raw_mode_support_devel/
> [3]: https://lore.kernel.org/all/20221222185049.737625-1-cristian.marussi@arm.com/
> [4]: https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_raw_mode_V8/
>
>
> Cristian Marussi (17):
>   firmware: arm_scmi: Refactor xfer in-flight registration routines
>   firmware: arm_scmi: Refactor polling helpers
>   firmware: arm_scmi: Refactor scmi_wait_for_message_response
>   firmware: arm_scmi: Add flags field to xfer
>   firmware: arm_scmi: Add xfer Raw helpers
>   firmware: arm_scmi: Move errors defs and code to common.h
>   firmware: arm_scmi: Add internal platform/channel IDs
>   include: trace: Add platform and channel instance references
>   debugfs: Export debugfs_create_str symbol
>   firmware: arm_scmi: Populate a common SCMI debugsfs root
>   firmware: arm_scmi: Add debugfs ABI documentation for common entries
>   firmware: arm_scmi: Add core Raw transmission support
>   firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
>   firmware: arm_scmi: Reject SCMI drivers while in Raw mode
>   firmware: arm_scmi: Call Raw mode hooks from the core stack
>   firmware: arm_scmi: Add Raw mode coexistence support
>   firmware: arm_scmi: Add per-channel Raw injection support
>
>  Documentation/ABI/testing/debugfs-scmi     |   70 +
>  Documentation/ABI/testing/debugfs-scmi-raw |  109 ++
>  drivers/firmware/arm_scmi/Kconfig          |   32 +
>  drivers/firmware/arm_scmi/Makefile         |    1 +
>  drivers/firmware/arm_scmi/bus.c            |    7 +
>  drivers/firmware/arm_scmi/common.h         |   75 +
>  drivers/firmware/arm_scmi/driver.c         |  638 +++++++--
>  drivers/firmware/arm_scmi/protocols.h      |    7 +
>  drivers/firmware/arm_scmi/raw_mode.c       | 1443 ++++++++++++++++++++
>  drivers/firmware/arm_scmi/raw_mode.h       |   31 +
>  fs/debugfs/file.c                          |    1 +
>  include/trace/events/scmi.h                |   18 +-
>  12 files changed, 2292 insertions(+), 140 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-scmi
>  create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw
>  create mode 100644 drivers/firmware/arm_scmi/raw_mode.c
>  create mode 100644 drivers/firmware/arm_scmi/raw_mode.h
>
> --
> 2.34.1
>
