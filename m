Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0D5F7B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJGQHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJGQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:07:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31C4810C4FD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:07:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A9A106F;
        Fri,  7 Oct 2022 09:07:19 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8300A3F67D;
        Fri,  7 Oct 2022 09:07:11 -0700 (PDT)
Date:   Fri, 7 Oct 2022 17:07:09 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com
Subject: Re: [PATCH v3 0/9] Introduce a unified API for SCMI Server testing
Message-ID: <Y0BOrU9jzM+5Lb3G@e120937-lin>
References: <20220903183042.3913053-1-cristian.marussi@arm.com>
 <CAKfTPtAt4803k1WpQru+8Sg5PFkSXaSF6b6wNeyu6yCiypVUEw@mail.gmail.com>
 <Y0BHynXmexuqKEqJ@e120937-lin>
 <CAKfTPtBZp0o3PZJXW6+DF8nqc9coB9Q--r7Op_83LExhjMmQQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBZp0o3PZJXW6+DF8nqc9coB9Q--r7Op_83LExhjMmQQA@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:58:59PM +0200, Vincent Guittot wrote:
> On Fri, 7 Oct 2022 at 17:37, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > On Fri, Oct 07, 2022 at 04:23:33PM +0200, Vincent Guittot wrote:
> > > Hi Cristian,
> > >
> >
> > Hi Vincent
> >
> > thanks for give it a try !
> >
> > > On Sat, 3 Sept 2022 at 20:31, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > This series aims to introduce a new SCMI unified userspace interface meant
> > > > to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> > > > from the perspective of the OSPM agent (non-secure world only ...)
> > > >
> > > > It is proposed as a testing/development facility, it is NOT meant to be a
> > > > feature to use in production, but only enabled in Kconfig for test
> > > > deployments.
> > > >
> > > > Currently an SCMI Compliance Suite like the one at [1] can only work by
> > > > injecting SCMI messages at the SCMI transport layer using the mailbox test
> > > > driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> > > > the related replies from the SCMI backend Server.
> > > >
> > >
> > > ...
> > >
> > > >
> > > > In V2 the runtime enable/disable switching capability has been removed
> > > > (for now) since still not deemed to be stable/reliable enough: as a
> > > > consequence when SCMI Raw support is compiled in, the regular SCMI stack
> > > > drivers are now inhibited permanently for that Kernel.
> > > >
> > > > A quick and trivial example from the shell...reading from a sensor
> > > > injecting a properly crafted packet in raw mode:
> > > >
> > > >         # INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=1 (binary little endian)
> > > >         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message
> > >
> > > I have tried your patchset with an SCMI server using an optee-os
> > > transport channel but I have a timed out error when trying your
> > > example above to read sensor1
> > >
> > > #  echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00
> > > > /sys/kernel/debug/scmi_raw/message
> > > # [   93.306690] arm-scmi firmware:scmi0: timed out in RAW response -
> > > HDR:00005406
> > >
> > > and there no response available when trying to read it with
> > > # cat /sys/kernel/debug/scmi_raw/message
> > >
> >
> > is there anything cat'ting /sys/kernel/debug/scmi_raw/errors ?
> 
> It was empty
> 
> >
> > >
> > > The sensor 1 can be successfully read in normal mode:
> > > # cat /sys/class/hwmon/hwmon0/temp1_input
> > > 25000
> > > #
> > >
> > > In both case, the SCMI server received the requests and replied successfully
> > >
> > > Could it be that you process the answer differently in case of raw mode ?
> > >
> >
> > Well, absolutely, when in raw mode the reply is picked up directly into
> > the RX path and copied in a message queue to be read from asyncrhnously
> > later via debugfs.
> >
> > ... mmm I think I found the problem...the reply is picked up on the RX *IRQ*
> > path as of now...but in optee/SMC there is no interrupt (sometime there is in
> > SMC) and the reply is instead read back straight away (transport is marked as
> > sync_cmds_completed_on_ret=true in fact).... so this is the issue probably ...
> > I have NOT tested on anything but mailbox and virtio till now...and I
> > missed this possibility that this NO-irq reply was a thing even when NOT
> > in polling mode (which I do not support)...my bad :<
> >
> > Ok, next week I'll rework the series to fix this big_BUG and some other minor
> > things...in the meantime if you want to try this snippet down below...
> >
> > ... this won't definitely be the final patch but it could let you experiment
> > more (only build tested though )
> 
> Thanks.
> The patch below fixes my problem with optee transport layer
> 

Good, thanks for the patience.

Thanks,
Cristian

> >
> > Thanks for testing !
> > Cristian
> >
> > --->8-------
> >
> > diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
> > index 13eeebe4b7a8..b9fcb66a1b6a 100644
> > --- a/drivers/firmware/arm_scmi/raw_mode.c
> > +++ b/drivers/firmware/arm_scmi/raw_mode.c
> > @@ -197,6 +197,8 @@ struct scmi_dbg_raw_data {
> >         size_t rx_size;
> >  };
> >
> > +void scmi_raw_message_report(void *r, struct scmi_xfer *xfer, unsigned int idx);
> > +
> >  static inline
> >  struct scmi_raw_buffer *scmi_raw_buffer_get(struct scmi_raw_mode_info *raw,
> >                                             unsigned int idx)
> > @@ -389,22 +391,34 @@ static void scmi_xfer_raw_worker(struct work_struct *work)
> >
> >                 xfer = rw->xfer;
> >
> > -               /*
> > -                * Waiters are queued by wait-deadline at the end, so some of
> > -                * them could have been already expired when processed, BUT we
> > -                * have to check the completion status anyway just in case a
> > -                * virtually expired (aged) transaction was indeed completed
> > -                * fine and we'll have to wait for the asynchronous part (if
> > -                * any).
> > -                */
> > -               aging = jiffies - rw->start_jiffies;
> > -               tmo = max_tmo > aging ? max_tmo - aging : 0;
> > -
> > -               if ((tmo && !wait_for_completion_timeout(&xfer->done, tmo)) ||
> > -                   (!tmo && !try_wait_for_completion(&xfer->done))) {
> > -                       dev_err(dev, "timed out in RAW response - HDR:%08X\n",
> > -                               pack_scmi_header(&xfer->hdr));
> > -                       ret = -ETIMEDOUT;
> > +               if (!raw->desc->sync_cmds_completed_on_ret) {
> > +                       /*
> > +                        * Waiters are queued by wait-deadline at the end, so some of
> > +                        * them could have been already expired when processed, BUT we
> > +                        * have to check the completion status anyway just in case a
> > +                        * virtually expired (aged) transaction was indeed completed
> > +                        * fine and we'll have to wait for the asynchronous part (if
> > +                        * any).
> > +                        */
> > +                       aging = jiffies - rw->start_jiffies;
> > +                       tmo = max_tmo > aging ? max_tmo - aging : 0;
> > +
> > +                       if ((tmo &&
> > +                            !wait_for_completion_timeout(&xfer->done, tmo)) ||
> > +                            (!tmo && !try_wait_for_completion(&xfer->done))) {
> > +                               dev_err(dev,
> > +                                       "timed out in RAW response - HDR:%08X\n",
> > +                                       pack_scmi_header(&xfer->hdr));
> > +                               ret = -ETIMEDOUT;
> > +                       }
> > +               } else {
> > +                       raw->desc->ops->fetch_response(rw->cinfo, xfer);
> > +                       /* Trace polled replies. */
> > +                       trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id,
> > +                                           "RESP",
> > +                                           xfer->hdr.seq, xfer->hdr.status,
> > +                                           xfer->rx.buf, xfer->rx.len);
> > +                       scmi_raw_message_report(raw, xfer, SCMI_RAW_REPLY_QUEUE);
> >                 }
> >
> >                 /* Avoid unneeded async waits */
> >
> >
> > ---8<-------
> >
