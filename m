Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C86218AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiKHPpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiKHPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:45:28 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CA95B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667922314; bh=jWdG7NDvmswNMYUqtnVqXlVLak5hAsqv8pkk5+uIsZA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=bdGsWyVPArngIIGeKNfiWh1hyEZnnmBm43rgPeSHSCeFvGYJZsq9lBuu3ZG4JAaWa
         1C4WT/3lnY/JygrwyW4yb2KbIg+bW3RJ4v2G39Hcbx37OmWg8TjOecEJ73tyI3dFGt
         NbPLZnAH1Wo5I2w/Zmd4KoXAgqLECAUSW1exv/Xw=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  8 Nov 2022 16:45:14 +0100 (CET)
X-EA-Auth: N7/HD7u/DVVCZW32hYbTDZ1ptl0U6Q/FRr/YWrPrQbB85O+ADEcQ9h2YhAqrgH9efzIBgHm5Q1DJ5Wbm3cheokH7tvZTrJbT
Date:   Tue, 8 Nov 2022 21:15:10 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y2p5hqdFo5UZoHUY@qemulion>
References: <Y2px+zOGjkpGh6qC@qemulion>
 <Y2p29zc/TeX8OFWU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2p29zc/TeX8OFWU@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:34:15PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 08, 2022 at 08:42:59PM +0530, Deepak R Varma wrote:
> > Hello,
> >
> > First, my apologies for the long email.
> > I am requesting guidance on how to approach resolving the zero element flexible
> > VLO struct implementation in this driver in file drivers/staging/waln-ng/hfa384x.f
> >
> > The struct hfa384x_pdrec contains nested structs with zero element arrays.  These
> > zero element structs are part of a union 'data' inside the struct container. This
> > union 'data' is the last element of this container. Please see the code snip below:
> >
> > <snip>
> >
> > 	1068 struct hfa384x_pdrec {
> > 	   1         __le16 len;             /* in words */
> > 	   2         __le16 code;
> > 	   3         union pdr {
> > 	   4                 struct hfa384x_pdr_pcb_partnum pcb_partnum;
> > 	  11                 struct hfa384x_pdr_nicid nicid;
> > 	  12                 struct hfa384x_pdr_refdac_measurements refdac_measurements;
> > 	  13                 struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
> > 	  14                 struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
> > 	  15                 struct hfa384x_pdr_mac_address mac_address;
> > 	  39         } data;
> > 	  40 } __packed;
> >
> > </snip>
> >
> > The three structures in question are declared as follows in the same file:
> >
> > <snip>
> > 	962  struct hfa384x_pdr_refdac_measurements {
> > 	   1         u16 value[0];
> > 	   2 } __packed;
> > 	   3
> > 	   4 struct hfa384x_pdr_vgdac_measurements {
> > 	   5         u16 value[0];
> > 	   6 } __packed;
> > 	   7
> > 	   8 struct hfa384x_pdr_level_comp_measurements {
> > 	   9         u16 value[0];
> > 	  10 } __packed;
> > </snip>
> >
> > As per the C99 specifications, the flexible array struct should have at least
> > one member other than the true flexible array member. So converting these from
> > [0] to [] is not feasible in the current form.
> >
> > I did not find these struct variables being used for memory allocation in the
> > code directly. My find may be short since the implementation appears to get very
> > complex as I tried to get deeper.
> >
> > Can you please suggest how should I approach correcting the zero element flex
> > array implementation here? Can these structs be removed if they are unused?
>
> Are you sure they are unused?
>
> They look like structures that are read from the memory of a device,
> right?  Try removing the structures from the union and see what happens
> :)

I did remove the structs from the union and it built fine. Is there anything else I
can check/test to verify the impact?

<snip>
	drv@qemulion:~/git/kernels/staging$ git diff
	diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
	index 0611e37df6ac..8fe10aa93dfb 100644
	--- a/drivers/staging/wlan-ng/hfa384x.h
	+++ b/drivers/staging/wlan-ng/hfa384x.h
	@@ -1077,9 +1077,6 @@ struct hfa384x_pdrec {
			struct hfa384x_pdr_mfisuprange mfisuprange;
			struct hfa384x_pdr_cfisuprange cfisuprange;
			struct hfa384x_pdr_nicid nicid;
	-               struct hfa384x_pdr_refdac_measurements refdac_measurements;
	-               struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
	-               struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
			struct hfa384x_pdr_mac_address mac_address;
			struct hfa384x_pdr_mkk_callname mkk_callname;
			struct hfa384x_pdr_regdomain regdomain;
	drv@qemulion:~/git/kernels/staging$ make M=drivers/staging/wlan-ng/
	  CC [M]  drivers/staging/wlan-ng/prism2usb.o
	  CC [M]  drivers/staging/wlan-ng/p80211netdev.o
	  LD [M]  drivers/staging/wlan-ng/prism2_usb.o
	  MODPOST drivers/staging/wlan-ng/Module.symvers
	  LD [M]  drivers/staging/wlan-ng/prism2_usb.ko
	  BTF [M] drivers/staging/wlan-ng/prism2_usb.ko
	drv@qemulion:~/git/kernels/staging$
</snip>

>
> thanks,
>
> greg k-h


