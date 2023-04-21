Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162636EA79D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjDUJzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDUJzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:55:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 653BF9779;
        Fri, 21 Apr 2023 02:55:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 054FF1480;
        Fri, 21 Apr 2023 02:55:54 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CA043F5A1;
        Fri, 21 Apr 2023 02:55:08 -0700 (PDT)
Date:   Fri, 21 Apr 2023 10:54:58 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     Peng Fan <peng.fan@oss.nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Message-ID: <ZEJdcp9Jb+ATn9ui@e120937-lin>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <6dc456ff-7fc6-3b73-3727-dd048e9a9629@oss.nxp.com>
 <f73f39e2-81dd-4204-a3be-c5e7f5e54c1b@epam.com>
 <ZEJXpCdf9pWgoXL6@e120937-lin>
 <3041c92c-385a-00cd-87cd-d8b906dcd84c@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3041c92c-385a-00cd-87cd-d8b906dcd84c@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 09:48:33AM +0000, Oleksii Moisieiev wrote:
> Hi Cristian,
> 

Hi,

> On 21.04.23 12:30, Cristian Marussi wrote:
> > On Fri, Apr 21, 2023 at 08:40:47AM +0000, Oleksii Moisieiev wrote:
> >> Hi Peng Fan,
> >>
> >> On 17.04.23 05:55, Peng Fan wrote:
> >>>
> >>> On 4/13/2023 6:04 AM, Cristian Marussi wrote:
> >>>> On Fri, Apr 07, 2023 at 10:18:27AM +0000, Oleksii Moisieiev wrote:
> >>>>> Implementation of the SCMI client driver, which implements
> >>>>> PINCTRL_PROTOCOL. This protocol has ID 19 and is described
> >>>>> in the latest DEN0056 document.
> >>>> Hi,
> >>>>
> >>>>> This protocol is part of the feature that was designed to
> >>>>> separate the pinctrl subsystem from the SCP firmware.
> >>>>> The idea is to separate communication of the pin control
> >>>>> subsystem with the hardware to SCP firmware
> >>>>> (or a similar system, such as ATF), which provides an interface
> >>>>> to give the OS ability to control the hardware through SCMI protocol.
> >>>>> This is a generic driver that implements SCMI protocol,
> >>>>> independent of the platform type.
> >>>>>
> >>>>> DEN0056 document:
> >>>>> https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/latest__;!!GF_29dbcQIUBPA!y2hR3PEGGxiPjVeXBcgGyV03DPDhzgUKR0uHvsTpiafKgBar8Egc6oOOs-IkFIquhSf-qBzltqEMyzRZHq8eC4g$
> >>>>> [developer[.]arm[.]com]
> >>>>>
> >>>> No need to specify all of this in the commit message, just a note that
> >>>> you are adding a new SCMIv3.2 Pincontrol protocol, highlighting anything
> >>>> that has been left out in this patch (if any) will be enough.
> >>> Is it possible to extend the spec to support multilple uint32_t for PIN
> >>> CONFIG SET?
> >>>
> >>> With only one uint32_t could not satisfy i.MX requirement.
> >>>
> >>> Thanks,
> >>> Peng.
> >>>
> >> IIUC you are expecting to have an ability to set some kind of array of
> >> uint32_t config values to some specific ConfigType?
> >>
> >> I'm not sure if it's supported by pintctrl subsystem right now. I was
> >> unable to find an example in the existing device-tree pinctrl bindings.
> >> This makes me think that this kind of binding is OEM specific.
> >>
> >> Maybe it can be implemented by adding new IDs to OEM specific range
> >> (192-255) which is reserved for OEM specific units (See Table 23 of
> >> DEN0056E).
> >>
> > If I understood correctly the aim of Peng multi-valued request, I think
> > that even if Linux does not support using this kind of multiple valued
> > requests (as of now), if it is useful or required by some of the possibly
> > supported hardware, it should be described and allowed by the specification
> > and supported by the core SCMI protocol support at least, while the pinctrl
> > SCMI driver can ignore this and keep using a one-sized array protocol_ops
> > call internally (since it cannot do any different anyway as of now)
> >
> > IOW I dont think we should model too strictly the SCMI spec against only
> > what the Linux pinctrl subsystem support today, since Linux it is just
> > really only one of the possible SCMI agents and Linux implementation itself
> > can possibly change: it is better to model the spec on the HW requirements
> > or the possible usage patterns across all the possibly participating agents.
> >
> > As an example, for similar reasons, when the SCMI Voltage protocol was added
> > to the spec, at the very last minute, a change was made to the spec to allow
> > for negative voltages, even though the Linux regulator subsystem was not
> > and still is not supporting at all negative voltages as of now; so basically
> > the SCMI voltage protocol API now exposes a per-domain flag (negative_volts_allowed),
> > that allows any kind of voltage domain to be enumerated and handled at the SCMI
> > spec and core layer but that also allows any SCMI driver user, like the SCMI
> > Regulator driver, to decide on his own if negative voltages domains can be
> > supported: indeed the scmi-regulator driver just skips the initialization of
> > any voltage domain that is found to be describing negative voltages.
> >
> > Here is a bit different, it is more of an optimization in the call path
> > than an HW difference, but I would follow the same approach: with the
> > SCMI spec and the core SCMI stack (the protocol) that supports a multi-uint32
> > call as a general case, if useful for some scenarios, and instead the SCMI
> > pinctrl driver that just ignores this possibility and keep using a single-value
> > array anyway....then, it will be up to the guys leveraging this multi-valued
> > call to come up with a way to use it on their systems, possibly maybe contributing
> > back to upstream any needed modification if general enough
> > (not sure about the details of how this multi-vals operation should be...we'll have
> > to discuss that about the spec all together I think.)
> >
> > In any case, I would definitely NOT relegate such possibility to vendor space,
> > since it is something generic and, especially being just (as it seems to me) an
> > optimization on the call path at the end, it will just lead to uneeded duplication
> > of functionalities in the vendor implementation of stuff that it is already
> > very slightly differently supported by the standard.
> >
> > ...just my opinion anyway, I'll happily let other guys in this thread discuss and
> > decide about this :P
> >
> > Thanks,
> > Cristian
> 
> That sounds reasonable for me, although I can't imagine the use case of 
> multi-valued config values (most likely this is the problem of my 
> imagination). So I'd appreciate if Peng Fan could provide us with some 
> examples.
> 
>  From my standpoint - ConfigTypes are meant to be simple value because 
> they are mostly related to the electronic properties. But I agree that 
> protocol should be platform-agnostic.
> 
> It will be great if Peng Fan could provide some examples, so we can 
> think about the best solution.
> 

All of the above blabbing of mine (:P) is based on the assumption that
Peng wants just to simply fit multiple type/value pairs requests, possibly
about the same pin, at once in one SCMI command payload, not that he wants to
push a type/val1/val2/val3.. like command....but I maybe wrong and I agree that
more use-case examples from Peng could be useful.

Thanks,
Cristian
