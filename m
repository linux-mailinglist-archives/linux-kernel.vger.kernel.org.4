Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8065D7D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjADQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjADQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:03:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B0B86;
        Wed,  4 Jan 2023 08:03:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6C5AB815C9;
        Wed,  4 Jan 2023 16:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B69C433D2;
        Wed,  4 Jan 2023 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672848214;
        bh=qwVm6Ey+pId0r7wPricoXhTqRlRKCe/YHgGXKdhvpjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqWdfQbvRSOxXRhuVMlJTNvvt0WYb25FBVMeIk2cde4zbaEhsbT5WoTdZLqY7HRTY
         k7mG9BQu5gHKhhtyGIY/deZmcT8B8HewKtl3U2CN12xLPOsnOp6Mqnq15MsnXEA+7g
         Xy0tXkDSsIEgbrYk30d1CjEk3Y4DmmF2qXttRHlIuSsRoPd9IuWHAo6VcnxmnMSGNH
         lbOhCPsba4FISM0vdZvkWV6pg8sGmXpon1gOrFfzV3MIHFNmpfPLLUeWcvOFFUiGp9
         f/4tpm1REe52ZWvwbraRL1d0Ccwu/A8V4Aqf/YrT4j9Zy3a6YQm1QycNX30AgFvnNJ
         faLWT0jz4fXuA==
Date:   Wed, 4 Jan 2023 10:03:31 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V4 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Message-ID: <20230104160331.w2sicwlqiygr42hl@builder.lan>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-4-git-send-email-quic_sarannya@quicinc.com>
 <12f53ff1-a358-7129-c9ed-9b9fd7dad7e7@foss.st.com>
 <20221227155641.xlkel7uhk7jr4qru@builder.lan>
 <45444451-26e3-c203-bdeb-59170b6cc5ba@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45444451-26e3-c203-bdeb-59170b6cc5ba@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 03:50:10PM +0100, Arnaud POULIQUEN wrote:
> On 12/27/22 16:56, Bjorn Andersson wrote:
> > On Wed, Dec 21, 2022 at 05:28:16PM +0100, Arnaud POULIQUEN wrote:
> >>
> >>
> >> On 12/7/22 14:04, Sarannya S wrote:
[..]
> >>>  	struct rpmsg_eptdev *eptdev = fp->private_data;
> >>>  
> >>> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> >>> -		return -EINVAL;
> >>> -
> >>> -	/* Don't allow to destroy a default endpoint. */
> >>> -	if (eptdev->default_ept)
> >>> -		return -EINVAL;
> >>> +	bool set;
> >>> +	u32 val;
> >>> +	int ret;
> >>> +	
> >>> +	switch (cmd) {
> >>> +	case TIOCMGET:
> >>> +		eptdev->signals_pending = false;
> >>> +		ret = put_user(eptdev->remote_signals, (int __user *)arg);
> >>> +		break;
> >>> +	case TIOCMSET:
> >>> +		ret = get_user(val, (int __user *)arg);
> >>> +		if (ret)
> >>> +			break;
> >>> +		set = (val & (TIOCM_DTR | TIOCM_RTS)) ? true : false;
> >>> +		ret = rpmsg_set_flow_control(eptdev->ept, set, 0);
> >>> +		break;
> >>
> >> I still wonder if it makes sense to implement serial IOCTRL in rpmsg_char.
> > 
> > I've thinking about this since v1 as well...
> > 
> >> I think it is quite dangerous to have such kind of mixed interface.
> >> User application would want to use the serial interface should use the tty
> >> interface.
> >>
> > 
> > Can you please elaborate on this statement, because I have a hard time
> > to state why the user space application must use the tty interface
> > instead of rpmsg_char.
> > 
> > And in particular, I don't think this is a question for the "user
> > application", but rather for the system configuration.
> > 
> > In order to move an application that works with rpmsg_char to the tty
> > driver ("because it's the right thing to do..."?) means that the system
> > needs to be reconfigured, such that the given rpmsg channel is exposed
> > through the tty driver instead.
> > 
> > This in turn either implies that the firmware needs to be changed to
> > expose these channels with the name "rpmsg-tty" - and the application
> > taught how to figure out which ttyRPMSGn to open - or the rpmsg_ctrl
> > interface needs to be extended to allow the Linux side to request a
> > particular channel to be exposed as rpmsg_char vs rpmsg-tty...
> > 
> 
> You are right, it can be not straightforward to migrate to rpmsg_tty. That's why
> it also makes sense to implement flow control in the rpmsg char.
> 
> What I try to highlight is the use of the RS232 signaling(e.g TIOCM_DTR) and
> TIOCMGET/TIOCMSE  terminal IOCTL in this patch.
> Please tell me if I wrong, but seems to me that such interface is dedicated to
> the serial/TTY frameworks [1].
> So does it make sense to reuse this interface for the rpmsg char?
> 

We're in understanding of the usefulness and the question about the
validity of reusing the tty's TIOCM{GET,SET} ioctl here. I don't know
the answer to the latter, and haven't pushed on this point.

> [1]https://elixir.bootlin.com/linux/latest/source/include/uapi/asm-generic/ioctls.h#L8
> 
> Instead we could have generic RPMSG IOCTLs that can be implemented on different
> rpmsg clients whatever the rpmsg channel (so not only the rpmsg char). This is
> the proposal below.
> 

Using a new pair of rpmsg_char ioctls for "set/get flow enable/disable"
would, IMHO, be easier to understand and it would avoid assumptions
inherited about all the other bits in the TIOCMSET ioctl.

Regards,
Bjorn

> Regards,
> Arnaud
> 
> >> For the rpmsg char, I would be in favor of creating a specific RPMSG IOCTRLs
> >> to avoid confusion.
> >>
> >> For instance:
> >>
> >>  - RPMSG_GET_SIGN_IOCTRL
> >>  - RPMSG_SET_SIGN_IOCTRL
> >>
> > 
> > Again, we're talking "flow control" at this level. So either we follow
> > the standard IOCTL and make it easy for existing applications to use
> > rpmsg_char, or we provide a _good_ explanation why they must use the
> > tty interface instead (and if so solve above mentioned problems).
> > 
> > Regards,
> > Bjorn
> > 
> >> With associated parameter corresponding to the bitmap proposed in my comment of
> >> your patch 1/4.
> >>
> >> Of course, this is only a suggestion, I let Bjorn and Mathieu comment.
> >>
> >> Regards,
> >> Arnaud
> >>
> >>
> >>> +	case RPMSG_DESTROY_EPT_IOCTL:
> >>> +		/* Don't allow to destroy a default endpoint. */
> >>> +		if (eptdev->default_ept) {
> >>> +			ret = -EINVAL;
> >>> +			break;
> >>> +		}
> >>> +		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> >>> +		break;
> >>> +	default:
> >>> +		ret = -EINVAL;
> >>> +	}
> >>>  
> >>> -	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> >>> +	return ret;
> >>>  }
> >>>  
> >>>  static const struct file_operations rpmsg_eptdev_fops = {
