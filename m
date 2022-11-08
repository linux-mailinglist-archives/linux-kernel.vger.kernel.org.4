Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48646218D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiKHPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiKHPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:52:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA295C778
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:52:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49F2A61656
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A943C433C1;
        Tue,  8 Nov 2022 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667922767;
        bh=MANpUbtMojnpkqgCOCSA6YWcTOTSpUDbvfCA/nA05fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHxocduAjkb1uhHabDemNU7C622AC4aaNg/hccdDE3nLcHizpoKEeDQdPMKbtu4vf
         JzMp4PjZbkgTSAsPq2fVrJyJTfiV6Vz9XebghUNU5aBEPLPIrLKmeIZneNyrSAare9
         3x5PFfncNy76GcAdZMvyWl2HTRnTa2VcmjFXdsX0=
Date:   Tue, 8 Nov 2022 16:52:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y2p7TOeg8vzK0rvB@kroah.com>
References: <Y2px+zOGjkpGh6qC@qemulion>
 <Y2p29zc/TeX8OFWU@kroah.com>
 <Y2p5hqdFo5UZoHUY@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2p5hqdFo5UZoHUY@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:15:10PM +0530, Deepak R Varma wrote:
> On Tue, Nov 08, 2022 at 04:34:15PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 08, 2022 at 08:42:59PM +0530, Deepak R Varma wrote:
> > > Hello,
> > >
> > > First, my apologies for the long email.
> > > I am requesting guidance on how to approach resolving the zero element flexible
> > > VLO struct implementation in this driver in file drivers/staging/waln-ng/hfa384x.f
> > >
> > > The struct hfa384x_pdrec contains nested structs with zero element arrays.  These
> > > zero element structs are part of a union 'data' inside the struct container. This
> > > union 'data' is the last element of this container. Please see the code snip below:
> > >
> > > <snip>
> > >
> > > 	1068 struct hfa384x_pdrec {
> > > 	   1         __le16 len;             /* in words */
> > > 	   2         __le16 code;
> > > 	   3         union pdr {
> > > 	   4                 struct hfa384x_pdr_pcb_partnum pcb_partnum;
> > > 	  11                 struct hfa384x_pdr_nicid nicid;
> > > 	  12                 struct hfa384x_pdr_refdac_measurements refdac_measurements;
> > > 	  13                 struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
> > > 	  14                 struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
> > > 	  15                 struct hfa384x_pdr_mac_address mac_address;
> > > 	  39         } data;
> > > 	  40 } __packed;
> > >
> > > </snip>
> > >
> > > The three structures in question are declared as follows in the same file:
> > >
> > > <snip>
> > > 	962  struct hfa384x_pdr_refdac_measurements {
> > > 	   1         u16 value[0];
> > > 	   2 } __packed;
> > > 	   3
> > > 	   4 struct hfa384x_pdr_vgdac_measurements {
> > > 	   5         u16 value[0];
> > > 	   6 } __packed;
> > > 	   7
> > > 	   8 struct hfa384x_pdr_level_comp_measurements {
> > > 	   9         u16 value[0];
> > > 	  10 } __packed;
> > > </snip>
> > >
> > > As per the C99 specifications, the flexible array struct should have at least
> > > one member other than the true flexible array member. So converting these from
> > > [0] to [] is not feasible in the current form.
> > >
> > > I did not find these struct variables being used for memory allocation in the
> > > code directly. My find may be short since the implementation appears to get very
> > > complex as I tried to get deeper.
> > >
> > > Can you please suggest how should I approach correcting the zero element flex
> > > array implementation here? Can these structs be removed if they are unused?
> >
> > Are you sure they are unused?
> >
> > They look like structures that are read from the memory of a device,
> > right?  Try removing the structures from the union and see what happens
> > :)
> 
> I did remove the structs from the union and it built fine. Is there anything else I
> can check/test to verify the impact?
> 
> <snip>
> 	drv@qemulion:~/git/kernels/staging$ git diff
> 	diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
> 	index 0611e37df6ac..8fe10aa93dfb 100644
> 	--- a/drivers/staging/wlan-ng/hfa384x.h
> 	+++ b/drivers/staging/wlan-ng/hfa384x.h
> 	@@ -1077,9 +1077,6 @@ struct hfa384x_pdrec {
> 			struct hfa384x_pdr_mfisuprange mfisuprange;
> 			struct hfa384x_pdr_cfisuprange cfisuprange;
> 			struct hfa384x_pdr_nicid nicid;
> 	-               struct hfa384x_pdr_refdac_measurements refdac_measurements;
> 	-               struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
> 	-               struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
> 			struct hfa384x_pdr_mac_address mac_address;
> 			struct hfa384x_pdr_mkk_callname mkk_callname;
> 			struct hfa384x_pdr_regdomain regdomain;
> 	drv@qemulion:~/git/kernels/staging$ make M=drivers/staging/wlan-ng/
> 	  CC [M]  drivers/staging/wlan-ng/prism2usb.o
> 	  CC [M]  drivers/staging/wlan-ng/p80211netdev.o
> 	  LD [M]  drivers/staging/wlan-ng/prism2_usb.o
> 	  MODPOST drivers/staging/wlan-ng/Module.symvers
> 	  LD [M]  drivers/staging/wlan-ng/prism2_usb.ko
> 	  BTF [M] drivers/staging/wlan-ng/prism2_usb.ko
> 	drv@qemulion:~/git/kernels/staging$
> </snip>
> 

Test the device to make sure it still works?
