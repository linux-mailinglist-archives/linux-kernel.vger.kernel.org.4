Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F05F7B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJGP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJGP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:59:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14193A87BB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:59:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b1so2940422lfs.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h45Ft2yG3ivsonKmhY4RDL65uqkYB8IsHn9neIB2u1A=;
        b=I5MSgNcwS+ZXTEmh1q7gLVc6vZiRmCXEfvDL0KCPjJy8c/DRh/YfPeWCvGoNQHiacL
         1132+pmPtihOe/5T/q5DCIebk1uy7cZdmjT1CbzPiAd4hGlEstS9uCzgxa+J/JJq1pE/
         94EyghAmMfdMzr6qBWZ7uLct4hrgl0jZ4L+2Uobs+PB12U85m8OcXczAi4m75hdfYPlO
         rw5gTBNc0s/uowWHwfW54BLN3J8V2DVqCgp0Dq/343WFotlDHnyaxhin2vC63U41poa3
         wBauToG1sq+RrHlPgRsqo3YrC6RhMLYq0ovlkqavHhOjmY3nOxqRwQpt7j9Qe8tiS86e
         /hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h45Ft2yG3ivsonKmhY4RDL65uqkYB8IsHn9neIB2u1A=;
        b=0sJzwP1eLgf4l6fzkbsd9u/AV84LiZg40+U/uXopngoj5LsbI3WCQQs2ZoxwA2JSVs
         a23QVPlW+nyjTu3YBySxNVlqfIMIabQhtvsJIp0f4xFiiWbUZ0WJFKIV6mskKSad+zSA
         5ehcyhHSZfnkn7e1RETW5jxx6KqGwprQjAljXaLDX3a7c151UHWfKyWvTguWYG11IChz
         9gQvGcXNFLpZcQ7RTPDtV1y1APOZEoGWRgSa54o7ZmOLEnVe3BWOKLZy78y9g7FSy/OM
         5OCANOlWxnu+mNMq0gTP6sWufUN39fCPolePz0p3xwkMxpeRRC+02qTtwJBs05w7VTdu
         efSg==
X-Gm-Message-State: ACrzQf3IeBuOrBget28tnwBVYy6Gm1fl3hCnxmvAn+EDGpyL5pc/DIRj
        yuNvrclDxBhRdsBH3lwF//lPLWEJDuZCNmiqixpmGD3RT6M1Sg==
X-Google-Smtp-Source: AMsMyM7xIuXTMUFgx9TrVGruxkgCRFo83+/AB/IsJTzaCQ0FyQ5FQu8YJKTckQdaIvTUv+fZ33uFbs0s0L9RhOWjXik=
X-Received: by 2002:a19:ad03:0:b0:4a0:56ab:7148 with SMTP id
 t3-20020a19ad03000000b004a056ab7148mr2274341lfc.430.1665158350318; Fri, 07
 Oct 2022 08:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220903183042.3913053-1-cristian.marussi@arm.com>
 <CAKfTPtAt4803k1WpQru+8Sg5PFkSXaSF6b6wNeyu6yCiypVUEw@mail.gmail.com> <Y0BHynXmexuqKEqJ@e120937-lin>
In-Reply-To: <Y0BHynXmexuqKEqJ@e120937-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 7 Oct 2022 17:58:59 +0200
Message-ID: <CAKfTPtBZp0o3PZJXW6+DF8nqc9coB9Q--r7Op_83LExhjMmQQA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Introduce a unified API for SCMI Server testing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 at 17:37, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Fri, Oct 07, 2022 at 04:23:33PM +0200, Vincent Guittot wrote:
> > Hi Cristian,
> >
>
> Hi Vincent
>
> thanks for give it a try !
>
> > On Sat, 3 Sept 2022 at 20:31, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > Hi all,
> > >
> > > This series aims to introduce a new SCMI unified userspace interface meant
> > > to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> > > from the perspective of the OSPM agent (non-secure world only ...)
> > >
> > > It is proposed as a testing/development facility, it is NOT meant to be a
> > > feature to use in production, but only enabled in Kconfig for test
> > > deployments.
> > >
> > > Currently an SCMI Compliance Suite like the one at [1] can only work by
> > > injecting SCMI messages at the SCMI transport layer using the mailbox test
> > > driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> > > the related replies from the SCMI backend Server.
> > >
> >
> > ...
> >
> > >
> > > In V2 the runtime enable/disable switching capability has been removed
> > > (for now) since still not deemed to be stable/reliable enough: as a
> > > consequence when SCMI Raw support is compiled in, the regular SCMI stack
> > > drivers are now inhibited permanently for that Kernel.
> > >
> > > A quick and trivial example from the shell...reading from a sensor
> > > injecting a properly crafted packet in raw mode:
> > >
> > >         # INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=1 (binary little endian)
> > >         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message
> >
> > I have tried your patchset with an SCMI server using an optee-os
> > transport channel but I have a timed out error when trying your
> > example above to read sensor1
> >
> > #  echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00
> > > /sys/kernel/debug/scmi_raw/message
> > # [   93.306690] arm-scmi firmware:scmi0: timed out in RAW response -
> > HDR:00005406
> >
> > and there no response available when trying to read it with
> > # cat /sys/kernel/debug/scmi_raw/message
> >
>
> is there anything cat'ting /sys/kernel/debug/scmi_raw/errors ?

It was empty

>
> >
> > The sensor 1 can be successfully read in normal mode:
> > # cat /sys/class/hwmon/hwmon0/temp1_input
> > 25000
> > #
> >
> > In both case, the SCMI server received the requests and replied successfully
> >
> > Could it be that you process the answer differently in case of raw mode ?
> >
>
> Well, absolutely, when in raw mode the reply is picked up directly into
> the RX path and copied in a message queue to be read from asyncrhnously
> later via debugfs.
>
> ... mmm I think I found the problem...the reply is picked up on the RX *IRQ*
> path as of now...but in optee/SMC there is no interrupt (sometime there is in
> SMC) and the reply is instead read back straight away (transport is marked as
> sync_cmds_completed_on_ret=true in fact).... so this is the issue probably ...
> I have NOT tested on anything but mailbox and virtio till now...and I
> missed this possibility that this NO-irq reply was a thing even when NOT
> in polling mode (which I do not support)...my bad :<
>
> Ok, next week I'll rework the series to fix this big_BUG and some other minor
> things...in the meantime if you want to try this snippet down below...
>
> ... this won't definitely be the final patch but it could let you experiment
> more (only build tested though )

Thanks.
The patch below fixes my problem with optee transport layer

>
> Thanks for testing !
> Cristian
>
> --->8-------
>
> diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
> index 13eeebe4b7a8..b9fcb66a1b6a 100644
> --- a/drivers/firmware/arm_scmi/raw_mode.c
> +++ b/drivers/firmware/arm_scmi/raw_mode.c
> @@ -197,6 +197,8 @@ struct scmi_dbg_raw_data {
>         size_t rx_size;
>  };
>
> +void scmi_raw_message_report(void *r, struct scmi_xfer *xfer, unsigned int idx);
> +
>  static inline
>  struct scmi_raw_buffer *scmi_raw_buffer_get(struct scmi_raw_mode_info *raw,
>                                             unsigned int idx)
> @@ -389,22 +391,34 @@ static void scmi_xfer_raw_worker(struct work_struct *work)
>
>                 xfer = rw->xfer;
>
> -               /*
> -                * Waiters are queued by wait-deadline at the end, so some of
> -                * them could have been already expired when processed, BUT we
> -                * have to check the completion status anyway just in case a
> -                * virtually expired (aged) transaction was indeed completed
> -                * fine and we'll have to wait for the asynchronous part (if
> -                * any).
> -                */
> -               aging = jiffies - rw->start_jiffies;
> -               tmo = max_tmo > aging ? max_tmo - aging : 0;
> -
> -               if ((tmo && !wait_for_completion_timeout(&xfer->done, tmo)) ||
> -                   (!tmo && !try_wait_for_completion(&xfer->done))) {
> -                       dev_err(dev, "timed out in RAW response - HDR:%08X\n",
> -                               pack_scmi_header(&xfer->hdr));
> -                       ret = -ETIMEDOUT;
> +               if (!raw->desc->sync_cmds_completed_on_ret) {
> +                       /*
> +                        * Waiters are queued by wait-deadline at the end, so some of
> +                        * them could have been already expired when processed, BUT we
> +                        * have to check the completion status anyway just in case a
> +                        * virtually expired (aged) transaction was indeed completed
> +                        * fine and we'll have to wait for the asynchronous part (if
> +                        * any).
> +                        */
> +                       aging = jiffies - rw->start_jiffies;
> +                       tmo = max_tmo > aging ? max_tmo - aging : 0;
> +
> +                       if ((tmo &&
> +                            !wait_for_completion_timeout(&xfer->done, tmo)) ||
> +                            (!tmo && !try_wait_for_completion(&xfer->done))) {
> +                               dev_err(dev,
> +                                       "timed out in RAW response - HDR:%08X\n",
> +                                       pack_scmi_header(&xfer->hdr));
> +                               ret = -ETIMEDOUT;
> +                       }
> +               } else {
> +                       raw->desc->ops->fetch_response(rw->cinfo, xfer);
> +                       /* Trace polled replies. */
> +                       trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id,
> +                                           "RESP",
> +                                           xfer->hdr.seq, xfer->hdr.status,
> +                                           xfer->rx.buf, xfer->rx.len);
> +                       scmi_raw_message_report(raw, xfer, SCMI_RAW_REPLY_QUEUE);
>                 }
>
>                 /* Avoid unneeded async waits */
>
>
> ---8<-------
>
