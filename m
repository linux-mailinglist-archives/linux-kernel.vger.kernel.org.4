Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDE750BED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjGLPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGLPKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C9F1FE1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A3561803
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE3C433C9;
        Wed, 12 Jul 2023 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689174558;
        bh=e3MaI1/jz0lN6S/DnrtBmXU3uvqKZWpqSOP/vDadgxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYamKjhUuIxcF4zvummTVldw0pp8SJoCDz2y1Xw7KBBt2WY0SZ/1wehxIdLnk/3pU
         OQTPGpyeei3RJtWaAZI6Z1qX8cdQ27BOrruAogPUHm7YpQ0VX2DI11eJJtSJH4hAMZ
         RkvgznfsG7zmaBD6pEkuF5Eti4xooZbW3bnam2HM=
Date:   Wed, 12 Jul 2023 17:09:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH 1/4] cdx: add support for bus enable and disable
Message-ID: <2023071223-unstopped-marsupial-9c89@gregkh>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-2-abhijit.gangurde@amd.com>
 <2023071109-saturate-purist-d854@gregkh>
 <DM4PR12MB7765F182AAF927F780DEE8848F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB7765F182AAF927F780DEE8848F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 01:21:13PM +0000, Gangurde, Abhijit wrote:
> [AMD Official Use Only - General]
> 
> > > CDX bus needs to be disabled before updating/writing devices
> > > in the FPGA. Once the devices are written, the bus shall be
> > > enabled. This change provides sysfs entry to enable/disable the
> > > CDX bus.
> > >
> > > Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> > > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> > vuuren@amd.com>
> > > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cdx | 11 +++++
> > >  drivers/cdx/cdx.c                       | 26 ++++++++++++
> > >  drivers/cdx/controller/cdx_controller.c | 27 +++++++++++++
> > >  drivers/cdx/controller/mc_cdx_pcol.h    | 54
> > +++++++++++++++++++++++++
> > >  drivers/cdx/controller/mcdi_functions.c | 24 +++++++++++
> > >  drivers/cdx/controller/mcdi_functions.h | 16 ++++++++
> > >  include/linux/cdx/cdx_bus.h             |  6 +++
> > >  7 files changed, 164 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> > b/Documentation/ABI/testing/sysfs-bus-cdx
> > > index 7af477f49998..0afa85b3c63b 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > > @@ -11,6 +11,17 @@ Description:
> > >
> > >               # echo 1 > /sys/bus/cdx/rescan
> > >
> > > +What:              /sys/bus/cdx/enable
> > > +Date:              July 2023
> > > +Contact:   nipun.gupta@amd.com
> > > +Description:
> > > +           Writing y/1/on to this file enables the CDX bus and
> > > +           writing n/0/off disables the bus.
> > > +
> > > +           For example to disable CDX bus::
> > > +
> > > +             # echo 0 > /sys/bus/cdx/enable
> >
> > What could go wrong!  :)
> >
> > You don't say why disabling / enabling the bus is needed, this feels
> > like a very huge stick, why is this for all busses, and not just an
> > individual CDX bus?
> >
> 
> As said in the description of the patch, disabling/enabling is needed when FPGA is being reprogrammed.

Ok, why would this not also be in the description for when you need to
look up what this file does?  You will not be able to track it back to
the commit log very easily.

thanks,

greg k-h
