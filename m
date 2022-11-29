Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4519C63BFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiK2MPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiK2MPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:15:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3069C5CD06
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:15:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802E4D6E;
        Tue, 29 Nov 2022 04:15:43 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A14C23F73D;
        Tue, 29 Nov 2022 04:15:35 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:15:33 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Ludvig =?iso-8859-1?Q?P=E4rsson?= <Ludvig.Parsson@axis.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "etienne.carriere@linaro.org" <etienne.carriere@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Message-ID: <Y4X35fXiPHQ5b0cG@e120937-lin>
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus>
 <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
 <20221114102650.qwkaxtnstujaiu6u@bogus>
 <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
 <b0bc03f9f2a5afbe3a77b81648a765348073cc36.camel@axis.com>
 <Y30LXW5Elcur5mlI@e120937-lin>
 <0b24b15bfee6d97d23caf0225d264c14e0ed48f1.camel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b24b15bfee6d97d23caf0225d264c14e0ed48f1.camel@axis.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:49:10AM +0000, Ludvig Pärsson wrote:
> On Tue, 2022-11-22 at 17:48 +0000, Cristian Marussi wrote:
> > On Mon, Nov 14, 2022 at 01:47:25PM +0000, Ludvig Pärsson wrote:
> > > On Mon, 2022-11-14 at 12:29 +0100, Etienne Carriere wrote:
> > > > Hello all,
> > > > 
> > 
> > Hi Ludvig,
> > 
> > following up on the issues raised by this thread and a few proposals
> > that
> > were flying around (online and offline), in the past days I took the
> > chance
> > to have a go at a substantial rework of the init/probe sequences in
> > the SCMI
> > core to address the issue you faced with SCMI TEE transport while
> > trying to
> > untangle a bit the SCMI core startup sequences (... while also
> > possibly not
> > breaking it all :P...)
> > 
> > In a nutshell, building on an idea from an offline chat with Etienne
> > ad
> > Sudeep, now the SCMI bus initialization is split on its own and
> > initialized at
> > subsys_initcall level, while the SCMI core stack, including the the
> > SCMI TEE
> > transport layer, is moved at module_init layer together with the SCMI
> > driver users.
> > 
> > This *should* theoretically solve your issue ... (and it seems like
> > all the
> > rest it's still working :P) ... so I was wondering if you can give a
> > go
> > at the following pachset on your setup:
> > 
> > https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_rework_stack_init_draft/
> > 
> > ... note that this is just a draft at the moment, which has undergone
> > a
> > reasonable amount of testing on mailbox/virtio transports only in
> > both a
> > SCMI builtin and/or modules scenario, but is no where ready for
> > review.
> > 
> > The top three patches are really what you need BUT these are probably
> > tightly bound to that bunch of early fixes you can see in the
> > branch...so in other words better if you pick the whole branch for
> > testing :D
> > 
> > Once you've confirmed me that this solves your issues I'll start the
> > final cleanup for posting in the next cycle.
> > 
> > Thanks,
> > Cristian
> 
> Hi Cristian,

Hi,

> 
> I tried my best to get the patchset to work somehow on my version of
> the kernel, and it seems to be working great. I played around with some
> things, for example changing order of some drivers that were on the
> same init levels, and it still worked. Only tested with voltage domain
> protocol and optee transport.
> 
> Thanks for your great work!
> 

Great, thanks for testing it.
I'll post shortly a cleaned up series aiming at the next release cycle.

Thanks,
Cristian
