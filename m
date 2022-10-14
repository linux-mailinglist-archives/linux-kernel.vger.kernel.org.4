Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A6A5FE9B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJNHiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJNHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:38:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A63B47F;
        Fri, 14 Oct 2022 00:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0C47B8225F;
        Fri, 14 Oct 2022 07:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1061C433D6;
        Fri, 14 Oct 2022 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665733086;
        bh=ymw2K5hvr5rw/WJaEA/gW9Nwyp8uHcWoIXyvNhiOULk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6OL9hTJ4bQnWYaSsPFP5j2wrhaKg+DzfPA0l1t/fXr5NsvY4KcbIFi1OE2i/ofF/
         a+GEFpqY/TLadop59FT1fvGIm/cfsLDUA5de//tPZWpJLT/NrxOi9xXNKk1w4H92W1
         Ke7k0dPMZ2tlmFHQhwEoR2F5n0M9dTtOGO24w0Lg=
Date:   Fri, 14 Oct 2022 09:38:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM
 Console Services
Message-ID: <Y0kSB9ZFoK1WJVLi@kroah.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-14-quic_eberman@quicinc.com>
 <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
 <85ca7eb4-3e0c-4ffb-8bac-a435594ca0f7@app.fastmail.com>
 <b7cca9c7-5170-bf40-c030-d676944b03c6@quicinc.com>
 <Y0Zk2hN4uEbxCp56@kroah.com>
 <0640f0a5-19c1-55d2-229a-37751a18118f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0640f0a5-19c1-55d2-229a-37751a18118f@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 01:54:36PM -0700, Elliot Berman wrote:
> 
> 
> On 10/11/2022 11:55 PM, Greg Kroah-Hartman wrote:
> > On Tue, Oct 11, 2022 at 03:04:47PM -0700, Elliot Berman wrote:
> > > 
> > > 
> > > On 10/11/2022 4:09 AM, Arnd Bergmann wrote:
> > > > On Tue, Oct 11, 2022, at 8:02 AM, Jiri Slaby wrote:
> > > > > On 11. 10. 22, 2:08, Elliot Berman wrote:
> > > > > > +
> > > > > > +	/* below are for printk console.
> > > > > > +	 * gh_rm_console_* calls will sleep and console_write can be called from
> > > > > > +	 * atomic ctx. Two xmit buffers are used. The active buffer is tracked with
> > > > > > +	 * co_xmit_idx. Writes go into the co_xmit_buf[co_xmit_idx] buffer.
> > > > > > +	 * A work is scheduled to flush the bytes. The work will swap the active buffer
> > > > > > +	 * and write out the other buffer.
> > > > > > +	 */
> > > > > 
> > > > > Ugh, why? This is too ugly and unnecessary. What about passing the kfifo
> > > > > to gh_rm_console_write() instead? You do memcpy() there anyway.
> > > > 
> > > > Another problem here is that you really want the console output to be
> > > > printed from atomic context, otherwise one would never see e.g. the
> > > > output of a panic() call. Having a deferred write is probably fine for
> > > > normal tty operations, but you probably want a different device for the
> > > > console here, e.g. the hvc_dcc driver.
> > > > 
> > > 
> > > Yes, that is our perspective on the RM console driver as well. I'll make
> > > this more explicit in the Kconfig/commit text. We expect most VMs
> > > (especially Linux) to use some other console mechanism provided by their
> > > VMM. I'm submitting here because we are presently using RM console on some
> > > of our VMs where we have other ways to collects logs on panic. It also makes
> > > it easier to implement a simple virtual machine manager that does not want
> > > to virtualize a serial device or have a virtio stack.
> > 
> > The whole goal of virtio was so that we would not have all of these
> > random custom drivers for new hypervisors all over the place, requiring
> > custom userspace interaction with them.
> > 
> > Please use virtio, that's what it is there for, don't create a new
> > console device if you do not have to.
> 
> We have a lightweight VM product use case today that doesn't want to support
> an entire virtio stack just for a console. This VM already has a Gunyah
> stack present, and to facilitate their console needs, we want to give them
> the Gunyah console.
> 
> There are a few other hypervisors that also provide a console facility in
> Linux: Xen, ePAPR hypervisor and z/VM.

Those all pre-dated virtio.  Please do not reinvent the wheel, again,
this is explicitly what virtio was designed for, so that we would not
have per-device/hypervisor drivers constantly being forced to be added.

Learn from the past mistakes and just use the interfaces and apis we
already have.  You don't have to have a "heavy" VM to support just a
virtio console, and in fact, all the code is already written for you!

thanks,

greg k-h
