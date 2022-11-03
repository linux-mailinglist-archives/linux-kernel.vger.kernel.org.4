Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD296179BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKCJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiKCJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:21:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E663DF0C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:21:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B979D23A;
        Thu,  3 Nov 2022 02:21:25 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FD193F5A1;
        Thu,  3 Nov 2022 02:21:17 -0700 (PDT)
Date:   Thu, 3 Nov 2022 09:21:10 +0000
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
Message-ID: <Y2OIBkdOXb7NIF7k@e120937-lin>
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
 <CAKfTPtBJy4SdbYUNHFn2ZXEO_pnaMPYibfjXWNBnXy49P2h78Q@mail.gmail.com>
 <Y1vvPBw4xB7m23wY@e120937-lin>
 <CAKfTPtAfuqtCee7f4bREsLqb5KJcLWw1Y=-0Y+2t+3XfX_YctQ@mail.gmail.com>
 <Y1wKHoxcWTz6VXyh@e120937-lin>
 <CAKfTPtAcEiqBDr5BXBS8Q9HzBWg544YR0eZkkaF3u_9EowZJcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAcEiqBDr5BXBS8Q9HzBWg544YR0eZkkaF3u_9EowZJcQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:54:50AM +0100, Vincent Guittot wrote:
> On Fri, 28 Oct 2022 at 18:58, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > On Fri, Oct 28, 2022 at 06:18:52PM +0200, Vincent Guittot wrote:
> > > On Fri, 28 Oct 2022 at 17:04, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > >
> > > > On Fri, Oct 28, 2022 at 04:40:02PM +0200, Vincent Guittot wrote:
> > > > > On Wed, 19 Oct 2022 at 22:46, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > >
> > > > Hi Vincent,
> > > >
> > > > > > This series aims to introduce a new SCMI unified userspace interface meant
> > > > > > to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> > > > > > from the perspective of the OSPM agent (non-secure world only ...)
> > > > > >
> > >
> > > [ snip]
> > >
> > > > > Hi Cristian,
> > > > >
> > > > > I have tested your series with an optee message transport layer and
> > > > > been able to send raw messages to the scmi server PTA
> > > > >
> > > > > FWIW
> > > > >
> > > > > Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > >
> > > >
> > > > Thanks a lot for your test and feedback !
> > > >
> > > > ... but I was going to reply to this saying that I spotted another issue
> > > > with the current SCMI Raw implementation (NOT related to optee/smc) so
> > > > that I'll post a V5 next week :P
> > > >
> > > > Anyway, the issue is much related to the debugfs root used by SCMI Raw,
> > > > i.e.:
> > > >
> > > >         /sys/kernel/debug/scmi_raw/
> > > >
> > > > ..this works fine unless you run it on a system sporting multiple DT-defined
> > > > server instances ...that is not officially supported but....ehm...a little
> > > > bird told these system with multiple servers do exists :D
> > >
> > > ;-)
> > >
> > > >
> > > > In such a case the SCMI core stack is probed multiuple times and so it
> > > > will try to register multiple debugfs Raw roots: there is no chanche to
> > > > root the SCMI Raw entries at the same point clearly ... and then anyway
> > > > there is the issue of recognizing which server is rooted where ... with
> > > > the additional pain that a server CANNOT be recognized by querying...cause
> > > > there is only one by teh spec with agentID ZERO ... in theory :D...
> > > >
> > > > So my tentaive solution for V5 would be:
> > > >
> > > > - change the Raw root debugfs as:
> > > >
> > > >         /sys/kernel/debug/scmi_raw/0/... (first server defined)
> > > >
> > > >         /sys/kernel/debug/scmi_raw/1/... (possible additional server(s)..)
> > > >
> > > > - expose the DT scmi-server root-node name of the server somewhere under
> > > >   that debugfs root like:
> > > >
> > > >         ..../scmi_raw/0/transport_name -> 'scmi-mbx'
> > > >
> > > >         ..../scmi_raw/1/transport_name -> 'scmi-virtio'
> > >
> > > I was about to say that you would display the server name but that
> > > means that you have send a request to the server which probably
> > > defeats the purpose of the raw mode
> > >
> > > >
> > > >   so that if you know HOW you have configured your own system in the DT
> > > >   (maybe multiple servers with different kind of transports ?), you can
> > > >   easily select programmatically which one is which, and so decide
> > > >   which Raw debugfs fs to use...
> > > >
> > > > ... I plan to leave the SCMI ACS suite use by default the first system
> > > > rooted at /sys/kernel/debug/scmi_raw/0/...maybe adding a commandline
> > > > option to choose an alternative path for SCMI Raw.
> > > >
> > > > Does all of this sound reasonable ?
> > >
> > > Yes, adding an index looks good to me.
> >
> > Ok, I'll rework accordingly.
> >
> > >
> > > As we are there, should we consider adding a per channel entry in the
> > > tree when there are several channels shared with the same server ?
> > >
> >
> > So, I was thinking about this and, even though, it seems not strictly
> > needed for Compliance testing (as discussed offline) I do think that
> > could be a sensible option to have as an additional mean to stress the
> > server transport implementation (as you wish).
> 
> Thanks
> 
> >
> > Having said that, this week, I was reasoning about an alternative
> > interface to do this, i.e. to avoid to add even more debugfs entries
> > for this chosen-channel config or possibly in the future to ask for
> > transport polling mode (if supported by the underlying transport)
> >
> > My idea (not thought fully through as of now eh..) would be as follows:
> >
> > since the current Raw implementation enforces a minimum size of 4 bytes
> > for the injected message (more on this later down below in NOTE), I was
> > thinking about using less-than-4-bytes-sized messages to sort of
> > pre-configure the Raw stack.
> >
> > IOW, instead of having a number of new additional entries like
> >
> >         ../message_ch10
> >         ../message_ch13
> >         ../message_poll
> >
> > we could design a sort of API (in the API :D) that defines how
> > 3-bytes message payload are to be interpreted, so that in normal usage
> > everything will go on as it is now, while if a 3-bytes message is
> > injected by a specially crafted testcase, it would be used to configure
> > the behaviour stack for the subsequent set of Raw transactions
> > (i.e. for the currently opened fd...) like:
> >
> > - open message fd
> >
> > - send a configure message:
> >
> >         | proto_chan_#  |     flags (polling..)  |
> >         ------------------------------------------
> >         0               7                       21
> >
> > - send/receive your test messages
> >
> > - repeat or close (then the config will vanish...)
> >
> > This would mean adding some sort entry under scmi_raw to expose the
> > configured available channels on the system though.
> >
> > [maybe the flags above could also include an async flag and avoid
> >  also to add the message_async entries...]
> >
> > I discarded the idea to run the above config process via IOCTLs since
> > it seemed to me even more frowned upon to use IOCTLs on a debugfs entry
> > :P...but I maybe wrong ah...
> >
> > All of this is still to be explored anyway, any thoughts ? or evident
> > drawbacks ? (beside having to clearly define an API for these message
> > config machinery)
> 
> TBH, I'm not a fan of adding a protocol on top of the SCMI one. This
> interface aims to test the SCMI servers and their channels so we
> should focus on this and make it simple to use. IMHO, adding some
> special bytes before the real scmi message is prone to create
> complexity and error in the use of this debug interface.
> 

Indeed, even if only for transport-related tests, the risk is to make
more complicate to use the interface.

Agreed, just wanted to have some feedback. I'll revert to some based on
debugfs trying to minimize entries and improper usage...maybe something
like grouping on per-channel subdirs when different channels are
available.

E.g. on a system with a dedicated PERF channel I could have


	../scmi_raw/0/message             <<< usual auto channel selection
		     /message_async 
		     ...

		     /chan_0x10/message   <<< use default channel (base proto)
		     	       /message_async
			       ....

		     /chan_0x13/message  <<< use PERF channel
		     	       /message_async
			       ....

The alternative would be to have a common single entry to configure the usage
of the a single batch of message/message_async entries BUT that seems to
me more prone to error, e.g. if you dont clear the special config at the
end of your special testcase you could endup using custom channels conf also
with any following regular test which expects to benefit from the
automatic channel selection (which I still think should be default way of
running these tests..)

Thoughts ?

Thanks for the feedback.
Cristian
