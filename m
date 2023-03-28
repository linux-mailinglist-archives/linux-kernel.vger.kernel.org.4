Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C56CBCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjC1LBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1LBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:01:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0D76AC;
        Tue, 28 Mar 2023 04:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57BC6B81BDF;
        Tue, 28 Mar 2023 11:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9180FC4339B;
        Tue, 28 Mar 2023 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680001271;
        bh=rVwYw8oNfAjcRZtetRMIy5t1JK4xKEoXm7nC/lTdtM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHGK9uzPkKjjmZPlNcc6V/hMrHAmP5ibSu5trUNzpmG6KtHR6ZU2PS/sQXCGT1RzZ
         utxzEiic4pIOA/h0NLun1avPsHwicEQWo5IIYk/gyn0nTLLXslUNkDPrkpcYr3Q3je
         pi4kYq8cF4obKVbOkxSFL8rHs/G0VlCx1g2yoFtU=
Date:   Tue, 28 Mar 2023 13:01:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        dan.j.williams@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/5] perf: Allow a PMU to have a parent.
Message-ID: <ZCLI9A40PJsyqAmq@kroah.com>
References: <20230324171313.18448-1-Jonathan.Cameron@huawei.com>
 <20230324171313.18448-3-Jonathan.Cameron@huawei.com>
 <f8123e7c-36a6-a302-1101-e778622dc997@linux.intel.com>
 <20230328115444.000036ea@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328115444.000036ea@Huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:54:44AM +0100, Jonathan Cameron wrote:
> On Mon, 27 Mar 2023 13:04:08 -0400
> "Liang, Kan" <kan.liang@linux.intel.com> wrote:
> 
> > On 2023-03-24 1:13 p.m., Jonathan Cameron wrote:
> > > Some PMUs have well defined parents such as PCI devices.
> > > As the device_initialize() and device_add() are all within
> > > pmu_dev_alloc() which is called from perf_pmu_register()
> > > there is no opportunity to set the parent from within a driver.
> > > 
> > > Add a struct device *parent field to struct pmu and use that
> > > to set the parent.  
> > 
> > Why we want a PMU parent? Maybe I missed it. I don't see that the parent
> > is used anywhere.
> 
> This allows you to identify the association between PMU and the hardware related
> device that is providing it by looking at the directory structure in sysfs rather
> than putting them directly under /sys/devices.
> 
> ls -l /sys/bus/event_sources/devices/
> 
> ... armv8_pmuv3_0 -> ../../../devices/arm8_pmuv3_0
> ... breakpoint -> ../../../devices/breakpoint
> ... cpmu0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/cpmu0/cpmu0
> etc
> 
> (the first cpmu0 is the parent registered as a child of the PCI EP and used for
>  driver binding).  So it's of use to userspace rather than in the kernel driver
> itself.
> 
> Note that almost nothing is normally in the top level /sys/devices other than
> event_sources - because nearly all other struct device instances created by
> subsystems have parents assigned.
> 
> On my system
> 
> ls /sys/devices
> 
> armv8_pmuv3_0	LNXSYSTEM:00	pci0000:0c	pnp0		system		uprobe
> breakpoint	pci0000:00	platform	software	tracepoint	virtual
> 
> +CC Greg KH for input on whether / why this make sense.

That doesn't make sense, nothing should be in /sys/devices/ EXCEPT the
root device of busses.  Everything else is wrong and should have their
code fixed up (i.e. "breakpoint", "software", etc.)

thanks,

greg k-h
