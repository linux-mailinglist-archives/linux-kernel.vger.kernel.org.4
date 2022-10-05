Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2305F4FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJEGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJEGXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:23:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5368E74B94;
        Tue,  4 Oct 2022 23:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93765B81C48;
        Wed,  5 Oct 2022 06:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2592C433D6;
        Wed,  5 Oct 2022 06:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664950981;
        bh=VAMnvAJnxm6F8Ulg+VAsWUC9n6NdVJkfOZIQb8NsMls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxbFswYIkHI12aX0RqMUk6N7FZJy+2SlU9+anc7VpwXqL/3THUUJ6kU0qTx2tHIzO
         VWsjK/qg9syow8a3M0y1/ZleQ1RxkguAiN1W+ZsSM4gBMa9RDYPI0Kno4/sfr3VReD
         86r0BzUimvI/00N0OkNsHPWrFZUzrHQKdDJxtFkw=
Date:   Wed, 5 Oct 2022 08:23:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/14] virt: gunyah: Add sysfs nodes
Message-ID: <Yz0i7VNc4oK58yh9@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-7-quic_eberman@quicinc.com>
 <Yzbcd0r768pRgRMr@kroah.com>
 <2a8c1752-818d-bf19-5a3a-095b969c5c5a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8c1752-818d-bf19-5a3a-095b969c5c5a@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 04:50:51PM -0700, Elliot Berman wrote:
> 
> 
> On 9/30/2022 5:09 AM, Greg Kroah-Hartman wrote:
> > On Wed, Sep 28, 2022 at 12:56:25PM -0700, Elliot Berman wrote:
> > > Add /sys/hypervisor support when detecting that Linux is running in a
> > > Gunyah environment. Export the version of Gunyah which is reported via
> > > the hyp_identify hypercall.
> > > 
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > > ---
> > >   .../ABI/testing/sysfs-hypervisor-gunyah       | 15 ++++
> > >   MAINTAINERS                                   |  1 +
> > >   drivers/virt/Makefile                         |  1 +
> > >   drivers/virt/gunyah/Makefile                  |  2 +
> > >   drivers/virt/gunyah/sysfs.c                   | 71 +++++++++++++++++++
> > >   5 files changed, 90 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-gunyah
> > >   create mode 100644 drivers/virt/gunyah/Makefile
> > >   create mode 100644 drivers/virt/gunyah/sysfs.c
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
> > > new file mode 100644
> > > index 000000000000..7d74e74e9edd
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
> > > @@ -0,0 +1,15 @@
> > > +What:		/sys/hypervisor/gunyah/api
> > > +Date:		October 2022
> > > +KernelVersion:	6.1
> > > +Contact:	linux-arm-msm@vger.kernel.org
> > > +Description:	If running under Gunyah:
> > > +		The Gunyah API version.
> > 
> > What does this version mean?  What format is it in?
> > 
> 
> The version is incremented on backwards-incompatible API changes. It's an
> integer: I've updated the description to mention it's an integer. FYI -- we
> are still currently at "1" and not aiming to increment this number. I'd like
> to get it reported in sysfs in case the version is incremented later.

If you change it in the future to be backwards incompatible, then you
have to change your kernel code anyway and userspace still has to keep
working the same so it would use a totally different interface.

So why is this even needed at all?

> > > +
> > > +What:		/sys/hypervisor/gunyah/variant
> > > +Date:		October 2022
> > > +KernelVersion:	6.1
> > > +Contact:	linux-arm-msm@vger.kernel.org
> > > +Description:	If running under Gunyah:
> > > +		Reports the build variant of Gunyah:
> > > +		The open source build of Gunyah will report "81".
> > > +		The Qualcomm build of Gunyah will report "72".
> > 
> > So there are only 2 versions variants?  What happens when you get a
> > third?  And why the odd numbers?
> > 
> 
> The kernel isn't parsing the reported build variant and is passing the
> reported value up to the sysfs node. If a new third variant comes along, its
> build variant number would be reported. Would it be preferred to instead
> link to Gunyah's definitions for the build variant?

Just document what these random numbers mean please and what userspace
is to do with them.  If nothing, and this is just information, who would
use that information?  And if no one, why report it at all? 

thanks,

greg k-h
