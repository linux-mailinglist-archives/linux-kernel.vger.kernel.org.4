Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994EE69A629
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBQHhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQHhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:37:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B34FCBD;
        Thu, 16 Feb 2023 23:37:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BC62615C9;
        Fri, 17 Feb 2023 07:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F0C433D2;
        Fri, 17 Feb 2023 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676619433;
        bh=rF2nhK+06ELdbRmCQi57VJGIdRujdnHAVF4wTr7HW1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkin1QZwm35J/E67DcAxhmZfKhkXlh5yXtFx4tp2JtU+bWbgKo4o/iGPSN8KtfVxi
         n/Oj06uwpF57s0G6xj4AVm2xs+MZeCvJCoRDl8WiwKd710KREskPk//EPUnnYC9ehJ
         9sG2NedTQxSTBq+wzhJ5XpZyze6KQcJaeHt/mVIU=
Date:   Fri, 17 Feb 2023 08:37:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Message-ID: <Y+8upgx58a+vLeaT@kroah.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
 <Y+3QqdQVH5BTbnaP@kroah.com>
 <b04aef26-ee0d-af01-3aa1-a0c77d9cbaf3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b04aef26-ee0d-af01-3aa1-a0c77d9cbaf3@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 09:40:52AM -0800, Elliot Berman wrote:
> 
> 
> On 2/15/2023 10:43 PM, Greg Kroah-Hartman wrote:
> > On Tue, Feb 14, 2023 at 01:23:25PM -0800, Elliot Berman wrote:
> > > +struct gh_rm {
> > > +	struct device *dev;
> > 
> > What device does this point to?
> > 
> 
> The platform device.

What platform device?  And why a platform device?

> > > +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
> > > +	struct gh_msgq msgq;
> > > +	struct mbox_client msgq_client;
> > > +	struct gh_rm_connection *active_rx_connection;
> > > +	int last_tx_ret;
> > > +
> > > +	struct idr call_idr;
> > > +	struct mutex call_idr_lock;
> > > +
> > > +	struct kmem_cache *cache;
> > > +	struct mutex send_lock;
> > > +	struct blocking_notifier_head nh;
> > > +};
> > 
> > This obviously is the "device" that your system works on, so what are
> > the lifetime rules of it?  Why isn't is just a real 'struct device' in
> > the system instead of a random memory blob with a pointer to a device?
> > 
> > What controls the lifetime of this structure and where is the reference
> > counting logic for it?
> > 
> 
> The lifetime of the structure is bound by the platform device that above
> struct device *dev points to. get_gh_rm and put_gh_rm increments the device
> ref counter and ensures lifetime of the struct is also extended.

But this really is "your" device, not the platform device.  So make it a
real one please as that is how the kernel's driver model works.  Don't
hang "magic structures" off of a random struct device and have them
control the lifetime rules of the parent without actually being a device
themself.  This should make things simpler overall, not more complex,
and allow you to expose things to userspace properly (right now your
data is totally hidden.)

thanks,

greg k-h
