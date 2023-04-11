Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C306DDC08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDKNZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDKNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:25:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F56A55A4;
        Tue, 11 Apr 2023 06:25:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 265DAFEC;
        Tue, 11 Apr 2023 06:26:02 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F203F6C4;
        Tue, 11 Apr 2023 06:25:16 -0700 (PDT)
Date:   Tue, 11 Apr 2023 14:25:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v1 0/2] Introducing generic SCMI pinctrl driver
 implementation
Message-ID: <20230411132514.hdyyxug77t5gyzkj@bogus>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <CACRpkdaY1KjkJ_it0okrixrbCbe5Yy8PZiFAYacr_C03adP_hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaY1KjkJ_it0okrixrbCbe5Yy8PZiFAYacr_C03adP_hQ@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:27:53PM +0200, Linus Walleij wrote:
> Hi Oleksii,
> 
> thanks for your patches!
> 
> On Fri, Apr 7, 2023 at 12:18 PM Oleksii Moisieiev
> <Oleksii_Moisieiev@epam.com> wrote:
> 
> > This RFC patch series is intended to introduce the potential generic driver for
> > pin controls over SCMI protocol, provided in the latest beta version of DEN0056 [0].
> >
> > On ARM-based systems, a separate Cortex-M based System Control Processor (SCP)
> > provides control on pins, as well as with power, clocks, reset controllers. In this case,
> > kernel should use one of the possible transports, described in [0] to access SCP and
> > control clocks/power-domains etc. This driver is using SMC transport to communicate with SCP via
> > SCMI protocol and access to the Pin Control Subsystem.
> >
> > The provided driver consists of 2 parts:
> >  - firmware/arm_scmi/pinctrl.c - the SCMI pinctrl protocol inmplementation
> >    responsible for the communication with SCP firmware.
> >
> >  - drivers/pinctrl/pinctrl-scmi.c - pinctrl driver, which is using pinctrl
> >   protocol implementation to access all necessary data.
> 
> TBH this looks so good that I am happy to merge it once you send a non-RFC
> version.
> 
> My main concern would have been the protocol itself, but that was very
> carefully tailored to match what the pin control subsystem needs and
> I am quite happy with it the way it came out: using strings for groups and
> functions.
> 
> The scmi code in patch 1 adds an extra layer of abstraction and a vtable
> that would not have been necessary if all of the code was confined in
> one file in drivers/pinctrl but it is not up to me how the SCMI people
> want to abstract their stuff and there seems to be precedents to do things
> this way.
>

I haven't looked at the code to comment on the details, but in general the
SCMI abstraction was created and used in other kernel subsystems for couple
of reasons:

1. Leave all the protocol specific details like the version and other in
   the abstraction so that the driver remains simple and doesn't have to deal
   with those details.

2. Similar to the version and other details(generic or vendor specific), since
   there is a firmware involved, there might be need for quirks and again
   dealing with those in these SCMI layer is better as we will not have any
   specific compatible say just for pinctrl or dvfs ..etc.

3. Other reason was to allow testing of features that are in the spec and
   firmware but not used by any framework. But I think the way we introduced
   raw scmi interface nullifies it as it allows to bypass any framework and do
   raw SCMI transfers now. But originally the abstraction considered that
   possibility as well.

> I heard that someone wanted to also implement GPIO over SCMI, but
> it is not part of this driver so I guess that will be a future addition.
> It's a good starting point to add GPIO later.
>

Yes, Xilinx people want GPIO for moving away from their custom but similar to
SCMI like interface. There are yet to start exploring details.

--
Regards,
Sudeep
