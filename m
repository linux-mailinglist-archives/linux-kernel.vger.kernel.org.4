Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B356EA78E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjDUJtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjDUJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:48:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85D46C14B;
        Fri, 21 Apr 2023 02:47:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 105401480;
        Fri, 21 Apr 2023 02:48:37 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85133F5A1;
        Fri, 21 Apr 2023 02:47:51 -0700 (PDT)
Date:   Fri, 21 Apr 2023 10:47:49 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Message-ID: <ZEJbxTzv6tlBkExS@e120937-lin>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <6dc456ff-7fc6-3b73-3727-dd048e9a9629@oss.nxp.com>
 <f73f39e2-81dd-4204-a3be-c5e7f5e54c1b@epam.com>
 <CACRpkdY1eSdWX6+azn43MO77urVf_t25wgZtuyTwKHw4v+QYNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY1eSdWX6+azn43MO77urVf_t25wgZtuyTwKHw4v+QYNg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:28:38AM +0200, Linus Walleij wrote:
> On Fri, Apr 21, 2023 at 10:40 AM Oleksii Moisieiev
> <Oleksii_Moisieiev@epam.com> wrote:
> > On 17.04.23 05:55, Peng Fan wrote:
> > > On 4/13/2023 6:04 AM, Cristian Marussi wrote:
> 
> > > Is it possible to extend the spec to support multilple uint32_t for PIN
> > > CONFIG SET?
> > >
> > > With only one uint32_t could not satisfy i.MX requirement.
> > >
> > > Thanks,
> > > Peng.
> > >
> > IIUC you are expecting to have an ability to set some kind of array of
> > uint32_t config values to some specific ConfigType?
> >
> > I'm not sure if it's supported by pintctrl subsystem right now. I was
> > unable to find an example in the existing device-tree pinctrl bindings.
> > This makes me think that this kind of binding is OEM specific.
> >
> > Maybe it can be implemented by adding new IDs to OEM specific range
> > (192-255) which is reserved for OEM specific units (See Table 23 of
> > DEN0056E).
> 

Hi Linus,

> From a pinctrl point of view I do not understand this requirement.
> 
> The pinctrl subsystem in the Linux kernel certainly does not support
> an array of u32 for the pin config, we only support passing a single
> u32 value along with the enumerator (config type), or well it is
> actually 24 bits in Linux, the uppermost 8 bits is for the config type:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pinctrl/pinconf-generic.h
> 
> /*
>  * Helpful configuration macro to be used in tables etc.
>  */
> #define PIN_CONF_PACKED(p, a) ((a << 8) | ((unsigned long) p & 0xffUL))
> 
> p = parameter (PIN_CONFIG_DRIVE_STRENGTH etc)
> a = argument (value such as in mA)
> 

My (possibly wrong) reasoning on the other reply, is based on the
(possibly equally wrong :D) understanding that what Peng wants is just
the possibility at the spec and the SCMI protocol layer (exposed in
protocol operations) to issue PINCTRL_SET requests containing optionally
an array of multiple ConfigType/Value pairs (which is anyway not supported
by PinCtrl as I understand) instead of a single pair.

... but I can divine (:D)....that soon a new SCMI spec review/comment/amend
cycle will be coming for people reading this...

Thanks,
Cristian
